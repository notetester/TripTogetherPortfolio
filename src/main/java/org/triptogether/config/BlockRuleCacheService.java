package org.triptogether.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.triptogether.common.vo.IpBlockRuleVO;
import org.triptogether.common.vo.UserBlockRuleVO;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

/**
 * 애플리케이션 레벨 차단 규칙 캐시.
 *
 * <p>요청마다 DB를 조회하지 않고, 관리자 동기화/규칙 변경 시점에 DB → 메모리 → 파일 캐시로 갱신한다.
 * 파일 캐시는 재기동 직후 DB 조회 전에도 마지막 규칙 스냅샷으로 빠르게 방어를 시작하기 위한 보조 수단이다.</p>
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class BlockRuleCacheService {

    private final IpBlockMapper ipBlockMapper;
    private final ObjectMapper objectMapper;

    @Value("${security.block.cache.file:./data/block-rule-cache.json}")
    private String cacheFilePath;

    private final AtomicReference<BlockRuleCacheSnapshot> current = new AtomicReference<>();

    public BlockRuleCacheSnapshot getSnapshot() {
        BlockRuleCacheSnapshot snapshot = current.get();
        if (snapshot == null) {
            return loadFromFileOrDatabase();
        }
        return snapshot;
    }

    public synchronized BlockRuleCacheSnapshot refreshFromDatabase() {
        List<IpBlockRuleVO> ipRules = safeList(ipBlockMapper.findActiveIpBlockRules());
        List<UserBlockRuleVO> userRules = safeList(ipBlockMapper.findActiveUserBlockRules());
        BlockRuleCacheSnapshot snapshot = BlockRuleCacheSnapshot.of("DB", ipRules, userRules);
        current.set(snapshot);
        writeToFile(snapshot);
        log.info("[BlockCache] DB 동기화 완료: ipRules={}, userRules={}, file={}", ipRules.size(), userRules.size(), cacheFilePath);
        return snapshot;
    }

    public synchronized BlockRuleCacheSnapshot loadFromFileOrDatabase() {
        BlockRuleCacheSnapshot fileSnapshot = readFromFile();
        if (fileSnapshot != null) {
            current.set(fileSnapshot);
            log.info("[BlockCache] 파일 캐시 로드: ipRules={}, userRules={}, file={}", fileSnapshot.getIpRules().size(), fileSnapshot.getUserRules().size(), cacheFilePath);
            return fileSnapshot;
        }
        return refreshFromDatabase();
    }

    public BlockRuleCacheSnapshot invalidateAndRefresh() {
        current.set(BlockRuleCacheSnapshot.empty("INVALIDATED"));
        return refreshFromDatabase();
    }

    private void writeToFile(BlockRuleCacheSnapshot snapshot) {
        try {
            objectMapper.findAndRegisterModules();
            Path path = Path.of(cacheFilePath).toAbsolutePath().normalize();
            Path parent = path.getParent();
            if (parent != null) {
                Files.createDirectories(parent);
            }
            objectMapper.writerWithDefaultPrettyPrinter().writeValue(path.toFile(), snapshot);
        } catch (Exception e) {
            log.warn("[BlockCache] 파일 캐시 저장 실패: {}", e.getMessage());
        }
    }

    private BlockRuleCacheSnapshot readFromFile() {
        try {
            objectMapper.findAndRegisterModules();
            Path path = Path.of(cacheFilePath).toAbsolutePath().normalize();
            if (!Files.isRegularFile(path)) return null;
            BlockRuleCacheSnapshot snapshot = objectMapper.readValue(path.toFile(), BlockRuleCacheSnapshot.class);
            if (snapshot != null && snapshot.getLoadedAt() == null) {
                snapshot.setLoadedAt(LocalDateTime.now());
            }
            if (snapshot != null && snapshot.getSource() == null) {
                snapshot.setSource("FILE");
            }
            return snapshot;
        } catch (IOException e) {
            log.warn("[BlockCache] 파일 캐시 로드 실패: {}", e.getMessage());
            return null;
        }
    }

    private <T> List<T> safeList(List<T> list) {
        return list == null ? Collections.emptyList() : new ArrayList<>(list);
    }

    @Data
    public static class BlockRuleCacheSnapshot {
        private String source;
        private LocalDateTime loadedAt;
        private List<IpBlockRuleVO> ipRules = new ArrayList<>();
        private List<UserBlockRuleVO> userRules = new ArrayList<>();

        public static BlockRuleCacheSnapshot empty(String source) {
            BlockRuleCacheSnapshot snapshot = new BlockRuleCacheSnapshot();
            snapshot.setSource(source);
            snapshot.setLoadedAt(LocalDateTime.now());
            return snapshot;
        }

        public static BlockRuleCacheSnapshot of(String source, List<IpBlockRuleVO> ipRules, List<UserBlockRuleVO> userRules) {
            BlockRuleCacheSnapshot snapshot = empty(source);
            snapshot.setIpRules(ipRules == null ? new ArrayList<>() : new ArrayList<>(ipRules));
            snapshot.setUserRules(userRules == null ? new ArrayList<>() : new ArrayList<>(userRules));
            return snapshot;
        }

        public boolean isEmpty() {
            return (ipRules == null || ipRules.isEmpty()) && (userRules == null || userRules.isEmpty());
        }
    }
}
