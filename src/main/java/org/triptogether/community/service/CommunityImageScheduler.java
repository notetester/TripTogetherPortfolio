package org.triptogether.community.service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.triptogether.cloudinary.CloudinaryService;
import org.triptogether.community.mapper.CommunityMapper;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 커뮤니티 대표 이미지 스케줄러.
 *
 * <p>Pixabay API로 대륙별 풍경 이미지를 검색한 뒤 Cloudinary에 업로드하고,
 * 결과 URL을 인메모리 캐시({@code imageCache})에 보관한다.
 * 커뮤니티 게시글 목록의 대표 이미지가 없을 때 이 캐시에서 꺼내 사용한다.</p>
 *
 * <ul>
 *   <li>앱 시작 시 {@link #initCache()}가 백그라운드 스레드에서 1회 실행</li>
 *   <li>이후 24시간 주기로 {@link #refreshCache()}가 자동 갱신</li>
 *   <li>대륙 키: asia / europe / africa / north_america / south_america / oceania / etc</li>
 * </ul>
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class CommunityImageScheduler {

    @Value("${pixabay.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;
    private final CloudinaryService cloudinaryService;
    private final CommunityMapper communityMapper;

    /** Summernote inline 이미지 폴더 */
    private static final String INLINE_FOLDER = "community/inline";
    /** 신규 업로드 grace period — 저장 전 삭제 방지 */
    private static final int GRACE_PERIOD_HOURS = 24;
    /** Cloudinary URL에서 publicId 추출 (예: .../community/inline/abc123.jpg → community/inline/abc123) */
    private static final Pattern INLINE_PUBLIC_ID_PATTERN =
            Pattern.compile("/(community/inline/[^./?\\s\"']+)");

    /** region → Cloudinary URL */
    private final Map<String, String> imageCache = new ConcurrentHashMap<>();

    private static final Random random = new Random();

    private static final Map<String, String> REGION_KEYWORDS = new LinkedHashMap<>();
    static {
        REGION_KEYWORDS.put("asia",          "asia landscape");
        REGION_KEYWORDS.put("europe",        "europe landscape");
        REGION_KEYWORDS.put("africa",        "africa landscape");
        REGION_KEYWORDS.put("north_america", "north america landscape");
        REGION_KEYWORDS.put("south_america", "south america landscape");
        REGION_KEYWORDS.put("oceania",       "oceania landscape");
    }

    /** 앱 시작 시 백그라운드에서 1회 실행 */
    @PostConstruct
    public void initCache() {
        new Thread(() -> {
            log.info("Pixabay 초기 캐시 로드 시작");
            for (Map.Entry<String, String> entry : REGION_KEYWORDS.entrySet()) {
                refreshRegion(entry.getKey(), entry.getValue());
                try { Thread.sleep(2000); } catch (InterruptedException ignored) {}
            }
            log.info("Pixabay → Cloudinary 초기 캐시 로드 완료");
        }).start();
    }

    /** 24시간마다 캐시 갱신 (초기 실행은 @PostConstruct가 담당) */
    @Scheduled(initialDelay = 24 * 60 * 60 * 1000L, fixedRate = 24 * 60 * 60 * 1000L)
    public void refreshCache() {
        for (Map.Entry<String, String> entry : REGION_KEYWORDS.entrySet()) {
            refreshRegion(entry.getKey(), entry.getValue());
            try { Thread.sleep(2000); } catch (InterruptedException ignored) {}
        }
        log.info("Pixabay → Cloudinary 캐시 갱신 완료");
    }

    /**
     * 대륙별 이미지 1개 반환.
     * etc는 6개 대륙 중 랜덤으로 하나 사용.
     */
    public List<String> getAllImages() {
        return new ArrayList<>(imageCache.values());
    }

    public String getRandomImage(String region) {
        if ("etc".equals(region)) {
            List<String> all = new ArrayList<>(imageCache.values());
            if (all.isEmpty()) return null;
            return all.get(random.nextInt(all.size()));
        }
        return imageCache.get(region);
    }

    /**
     * 지정 대륙의 Pixabay 이미지 1장을 Cloudinary에 업로드하고 캐시를 갱신한다.
     *
     * <p>동일 region은 고정 publicId로 덮어쓰기(overwrite)되므로
     * Cloudinary에 이미지가 누적되지 않는다.</p>
     *
     * @param region  대륙 키 (예: "asia", "europe")
     * @param keyword Pixabay 검색 키워드 (예: "asia landscape")
     */
    private void refreshRegion(String region, String keyword) {
        try {
            String encodedKeyword = URLEncoder.encode(keyword, StandardCharsets.UTF_8);
            String apiUrl = "https://pixabay.com/api/?key=" + apiKey
                    + "&q=" + encodedKeyword
                    + "&image_type=photo&per_page=100&safesearch=true&orientation=horizontal";

            String response = restTemplate.getForObject(apiUrl, String.class);
            JsonObject root = JsonParser.parseString(response).getAsJsonObject();
            JsonArray hits = root.getAsJsonArray("hits");

            if (hits == null || hits.size() == 0) {
                log.warn("Pixabay 결과 없음: region={}", region);
                return;
            }

            // webformatURL 수집 후 랜덤 1개 선택
            List<String> webUrls = new ArrayList<>();
            for (JsonElement elem : hits) {
                JsonElement urlElem = elem.getAsJsonObject().get("webformatURL");
                if (urlElem != null && !urlElem.isJsonNull()) {
                    webUrls.add(urlElem.getAsString());
                }
            }
            if (webUrls.isEmpty()) return;

            String pickedUrl = webUrls.get(random.nextInt(webUrls.size()));

            // Pixabay 이미지 바이트 다운로드
            byte[] imageBytes = restTemplate.getForObject(pickedUrl, byte[].class);
            if (imageBytes == null || imageBytes.length == 0) {
                log.warn("Pixabay 이미지 다운로드 실패: region={}", region);
                return;
            }

            // Cloudinary 업로드 (고정 publicId로 덮어쓰기)
            String cloudinaryUrl = cloudinaryService.uploadImageFromBytes(imageBytes, "community_default", region);
            if (cloudinaryUrl == null) {
                log.warn("Cloudinary 업로드 실패: region={}", region);
                return;
            }

            imageCache.put(region, cloudinaryUrl);
            log.info("Pixabay→Cloudinary 갱신 완료: region={}, url={}", region, cloudinaryUrl);

        } catch (Exception e) {
            log.error("캐시 갱신 실패: region={}, error={}", region, e.getMessage());
        }
    }

    // =====================================================
    // Summernote inline 이미지 Orphan 정리
    // - 매주 월요일 04:00 KST (한산 시간대)
    // - Cloudinary community/inline 폴더 전수 조회
    // - ACTIVE 게시글 본문에서 사용 중인 publicId 수집 (jsoup)
    // - 둘을 비교해 orphan 후보 산출
    // - 업로드 후 24h 경과한 orphan만 삭제 (작성 중 취소 UX 보호)
    // =====================================================
    @Scheduled(cron = "0 0 4 ? * MON", zone = "Asia/Seoul")
    public void cleanupOrphanInlineImages() {
        log.info("[OrphanCleanup] 시작 folder={}, gracePeriodHours={}", INLINE_FOLDER, GRACE_PERIOD_HOURS);

        // 1) Cloudinary inline 폴더 전체 리소스
        List<Map<String, Object>> all = cloudinaryService.listResourcesInFolder(INLINE_FOLDER);
        if (all.isEmpty()) {
            log.info("[OrphanCleanup] Cloudinary 리소스 없음. 종료");
            return;
        }

        // 2) 사용 중 publicId 집합 (ACTIVE 게시글 본문 파싱)
        Set<String> usedPublicIds = collectUsedInlinePublicIds();
        log.info("[OrphanCleanup] Cloudinary 리소스 {}개, 사용 중 publicId {}개", all.size(), usedPublicIds.size());

        // 3) orphan 후보 중 grace period 지난 것만 삭제
        Instant graceCutoff = Instant.now().minus(GRACE_PERIOD_HOURS, ChronoUnit.HOURS);
        int totalOrphan = 0;
        int deleted = 0;
        int skippedGrace = 0;

        for (Map<String, Object> r : all) {
            String publicId = (String) r.get("publicId");
            if (publicId == null) continue;
            if (usedPublicIds.contains(publicId)) continue;

            totalOrphan++;

            // createdAt 파싱 (ISO8601: "2026-04-23T15:31:38Z")
            String createdAtStr = (String) r.get("createdAt");
            Instant createdAt = parseInstant(createdAtStr);
            if (createdAt == null || createdAt.isAfter(graceCutoff)) {
                skippedGrace++;
                continue;
            }

            boolean ok = cloudinaryService.deleteResource(publicId);
            if (ok) {
                deleted++;
                log.info("[OrphanCleanup] 삭제 publicId={}", publicId);
            }
        }

        log.info("[OrphanCleanup] 완료 스캔={}, 사용중={}, orphan={}, 삭제={}, grace 스킵={}",
                all.size(), usedPublicIds.size(), totalOrphan, deleted, skippedGrace);
    }

    /** ACTIVE 게시글의 본문 HTML에서 community/inline/* publicId 를 모두 수집한다. */
    private Set<String> collectUsedInlinePublicIds() {
        Set<String> used = new HashSet<>();
        List<String> contents = communityMapper.selectAllActiveContents();
        if (contents == null || contents.isEmpty()) return used;

        for (String html : contents) {
            if (html == null || html.isBlank()) continue;
            try {
                Elements imgs = Jsoup.parse(html).select("img[src]");
                for (Element img : imgs) {
                    String src = img.attr("src");
                    Matcher m = INLINE_PUBLIC_ID_PATTERN.matcher(src);
                    if (m.find()) used.add(m.group(1));
                }
            } catch (Exception e) {
                log.warn("[OrphanCleanup] 본문 파싱 실패: {}", e.getMessage());
            }
        }
        return used;
    }

    private Instant parseInstant(String iso) {
        if (iso == null || iso.isBlank()) return null;
        try {
            return Instant.parse(iso);
        } catch (Exception e) {
            return null;
        }
    }
}
