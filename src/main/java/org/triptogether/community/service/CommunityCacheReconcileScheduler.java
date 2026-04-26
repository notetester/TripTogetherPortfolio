package org.triptogether.community.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.community.mapper.CommunityMapper;

/**
 * 커뮤니티 캐시 카운터 운영 안전망.
 *
 * <p>like_count / comment_count / report_count 같은 캐시 컬럼은 트랜잭션
 * 안에서 +1/-1 로 갱신되지만 동시성·예외 케이스로 어긋날 가능성이 0은 아니다.
 * 매일 새벽 한 번 실제 행 수와 비교해 일괄 정정한다.</p>
 *
 * <ul>
 *   <li>실행: 매일 04:30 KST (Pixabay orphan 정리 04:00 직후, 한산 시간대)</li>
 *   <li>대상: ACTIVE/BLOCKED 게시글 + ACTIVE/BLOCKED 댓글</li>
 *   <li>출력: 실제 값이 바뀐 행 수만 INFO 로그</li>
 * </ul>
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class CommunityCacheReconcileScheduler {

    private final CommunityMapper communityMapper;

    // 정책: ADR-0006 (캐시 컬럼 + Reconcile 스케줄러 - Eventually Consistent 정합성 안전망)
    @Scheduled(cron = "0 30 4 ? * *", zone = "Asia/Seoul")
    @Transactional
    public void reconcile() {
        log.info("[CacheReconcile] 시작");
        try {
            int postChanged    = communityMapper.reconcilePostCounts();
            int commentChanged = communityMapper.reconcileCommentCounts();
            log.info("[CacheReconcile] 완료 — post 갱신 {}건, comment 갱신 {}건",
                    postChanged, commentChanged);
        } catch (Exception e) {
            log.error("[CacheReconcile] 실패: {}", e.getMessage(), e);
        }
    }
}
