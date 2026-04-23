package org.triptogether.myPage.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.myPage.mapper.ViewHistoryMapper;
import org.triptogether.myPage.vo.ViewHistoryItemDto;

import java.util.Collections;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
@RequiredArgsConstructor
public class ViewHistoryServiceImpl implements ViewHistoryService {

    /** 유저당 최대 보존 개수 */
    private static final int KEEP_PER_USER = 50;

    private static final Set<String> VALID_TYPES =
            Set.of(TYPE_COMMUNITY, TYPE_SPOT, TYPE_PLAN, TYPE_PACKAGE);

    private final ViewHistoryMapper viewHistoryMapper;

    @Override
    @Transactional
    public void record(Long userIdx, String contentType, Long contentId) {
        if (userIdx == null || contentId == null || contentType == null) return;
        if (!VALID_TYPES.contains(contentType)) return;
        try {
            viewHistoryMapper.upsertView(userIdx, contentType, contentId);
            viewHistoryMapper.pruneOld(userIdx, KEEP_PER_USER);
        } catch (Exception e) {
            // 조회 이력 기록 실패가 상세 페이지 렌더를 막지 않도록 흡수
            log.warn("view history record failed user={}, type={}, id={}: {}",
                    userIdx, contentType, contentId, e.getMessage());
        }
    }

    @Override
    public List<ViewHistoryItemDto> getRecent(Long userIdx, int limit) {
        if (userIdx == null || limit <= 0) return Collections.emptyList();
        return viewHistoryMapper.selectRecent(userIdx, limit);
    }

    @Override
    public int countRecent(Long userIdx) {
        if (userIdx == null) return 0;
        return viewHistoryMapper.countRecent(userIdx);
    }

    @Override
    public int deleteOne(Long userIdx, Long historyIdx) {
        if (userIdx == null || historyIdx == null) return 0;
        return viewHistoryMapper.deleteOne(userIdx, historyIdx);
    }

    @Override
    public int deleteAll(Long userIdx) {
        if (userIdx == null) return 0;
        return viewHistoryMapper.deleteAll(userIdx);
    }
}
