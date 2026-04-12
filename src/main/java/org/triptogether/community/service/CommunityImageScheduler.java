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
import org.triptogether.community.mapper.CommunityImageCacheMapper;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@Slf4j
@Component
@RequiredArgsConstructor
public class CommunityImageScheduler {

    @Value("${pixabay.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;
    private final CommunityImageCacheMapper communityImageCacheMapper;

    private static final Map<String, String> REGION_KEYWORDS = new LinkedHashMap<>();
    static {
        REGION_KEYWORDS.put("asia",          "asia landscape");
        REGION_KEYWORDS.put("europe",        "europe landscape");
        REGION_KEYWORDS.put("africa",        "africa landscape");
        REGION_KEYWORDS.put("north_america", "north america landscape");
        REGION_KEYWORDS.put("south_america", "south america landscape");
        REGION_KEYWORDS.put("oceania",       "oceania landscape");
    }

    /** 앱 시작 시 1회 즉시 실행 */
    @PostConstruct
    public void initCache() {
        log.info("Pixabay 초기 캐시 로드 시작");
        refreshCache();
    }

    /** 4시간마다 캐시 갱신 */
    @Scheduled(fixedRate = 4 * 60 * 60 * 1000L)
    public void refreshCache() {
        for (Map.Entry<String, String> entry : REGION_KEYWORDS.entrySet()) {
            refreshRegion(entry.getKey(), entry.getValue());
        }
        log.info("Pixabay 캐시 갱신 완료");
    }

    private void refreshRegion(String region, String keyword) {
        try {
            String encodedKeyword = URLEncoder.encode(keyword, StandardCharsets.UTF_8);
            String url = "https://pixabay.com/api/?key=" + apiKey
                    + "&q=" + encodedKeyword
                    + "&image_type=photo&per_page=100&safesearch=true&orientation=horizontal";

            String response = restTemplate.getForObject(url, String.class);
            JsonObject root = JsonParser.parseString(response).getAsJsonObject();
            JsonArray hits = root.getAsJsonArray("hits");

            if (hits == null || hits.size() == 0) {
                log.warn("Pixabay 결과 없음: region={}", region);
                return;
            }

            // webformatURL 수집 후 셔플 → 10장 선택
            List<String> urls = new ArrayList<>();
            for (JsonElement elem : hits) {
                JsonElement urlElem = elem.getAsJsonObject().get("webformatURL");
                if (urlElem != null && !urlElem.isJsonNull()) {
                    urls.add(urlElem.getAsString());
                }
            }
            Collections.shuffle(urls);
            List<String> selected = urls.subList(0, Math.min(10, urls.size()));

            // 기존 캐시 삭제 후 새 이미지 삽입
            communityImageCacheMapper.deleteCacheByRegion(region);
            for (String imageUrl : selected) {
                communityImageCacheMapper.insertCache(region, imageUrl);
            }
            log.info("Pixabay 캐시 갱신: region={}, count={}", region, selected.size());

        } catch (Exception e) {
            log.error("Pixabay 캐시 갱신 실패: region={}, error={}", region, e.getMessage());
        }
    }
}
