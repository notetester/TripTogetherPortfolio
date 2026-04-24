package org.triptogether.myPage.service;

import org.triptogether.myPage.vo.ViewHistoryItemDto;

import java.util.List;

public interface ViewHistoryService {

    /** 유효한 컨텐츠 타입 상수 */
    String TYPE_COMMUNITY = "community";
    String TYPE_SPOT      = "spot";
    String TYPE_PLAN      = "plan";
    String TYPE_PACKAGE   = "package";

    /**
     * 조회 이력 기록 (로그인 유저용). 실패 시 silently 무시(상세 페이지 렌더는 영향 없음).
     * userIdx 가 null 이거나 type/id 가 비정상이면 no-op.
     */
    void record(Long userIdx, String contentType, Long contentId);

    /** 최근 조회 목록 */
    List<ViewHistoryItemDto> getRecent(Long userIdx, int limit);

    /** 전체 개수 */
    int countRecent(Long userIdx);

    /** 개별 삭제 (본인 기록만) */
    int deleteOne(Long userIdx, Long historyIdx);

    /** 전체 삭제 */
    int deleteAll(Long userIdx);
}
