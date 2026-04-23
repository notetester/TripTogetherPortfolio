package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminAssistantBlockVO;

import java.util.List;

/**
 * AI 도우미 전용 차단 관리 서비스.
 * 인터셉터의 차단 체크 + 관리자 페이지 CRUD.
 */
public interface AdminAssistantBlockService {

    /** 차단 목록. activeOnly=true 면 활성 차단만. */
    List<AdminAssistantBlockVO> getBlocks(boolean activeOnly);

    /** 현재 차단 상태 여부 (인터셉터에서 호출). userIdx 또는 ip 중 하나라도 활성 차단이면 true. */
    boolean isBlocked(Long userIdx, String ipAddress);

    /**
     * 차단 등록/갱신. 동일 target 의 기존 활성 차단이 있으면 비활성화 후 새 레코드 INSERT.
     * → 이력 보존 + is_active UNIQUE 제약 충돌 회피.
     */
    void upsertBlock(AdminAssistantBlockVO block);

    /** 차단 해제 (is_active=0). */
    void deactivateBlock(Long blockId);
}
