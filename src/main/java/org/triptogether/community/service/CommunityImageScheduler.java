package org.triptogether.community.service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.triptogether.cloudinary.CloudinaryService;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Slf4j
@Component
@RequiredArgsConstructor
public class CommunityImageScheduler {

    @Value("${pixabay.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;
    private final CloudinaryService cloudinaryService;

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
    public String getRandomImage(String region) {
        if ("etc".equals(region)) {
            List<String> all = new ArrayList<>(imageCache.values());
            if (all.isEmpty()) return null;
            return all.get(random.nextInt(all.size()));
        }
        return imageCache.get(region);
    }

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
}
