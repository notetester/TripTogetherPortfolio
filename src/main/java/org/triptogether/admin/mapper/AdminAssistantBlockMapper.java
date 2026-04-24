package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.AdminAssistantBlockVO;

import java.util.List;

/**
 * ADMIN_ASSISTANT_BLOCK 매퍼 - AI 도우미 전용 차단 관리.
 */
@Mapper
public interface AdminAssistantBlockMapper {

    /** 차단 목록 조회 (is_active 필터). activeOnly=true 면 활성 차단만 반환. */
    List<AdminAssistantBlockVO> selectBlocks(@Param("activeOnly") boolean activeOnly);

    /** 활성 차단 1건 조회 (블록 체크용). target 없으면 null. */
    AdminAssistantBlockVO selectActiveBlock(@Param("blockType") String blockType,
                                            @Param("blockValue") String blockValue);

    /** 신규 차단 등록. 동일 target 활성 차단이 있으면 INSERT 실패하므로 사전 upsert는 서비스 계층에서 처리. */
    int insertBlock(AdminAssistantBlockVO block);

    /** 차단 해제 (is_active=0). */
    int deactivateBlock(@Param("blockId") Long blockId);
}
