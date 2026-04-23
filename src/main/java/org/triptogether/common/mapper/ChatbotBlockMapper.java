package org.triptogether.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.common.vo.ChatbotBlockVO;

import java.util.List;

@Mapper
public interface ChatbotBlockMapper {

    // 활성 차단 여부 (IP/USER)
    boolean isBlocked(@Param("blockType") String blockType,
                      @Param("blockValue") String blockValue);

    // 차단 등록 또는 갱신 (동일 (type,value) 조합 있으면 재활성화)
    void upsertBlock(ChatbotBlockVO block);

    // 차단 해제 (is_active=0)
    void deactivateBlock(@Param("blockId") Long blockId);

    // 단건 조회
    ChatbotBlockVO selectBlock(@Param("blockId") Long blockId);

    // 활성 차단만 / 전체 차단 조회 (관리자)
    List<ChatbotBlockVO> selectBlocks(@Param("onlyActive") boolean onlyActive);
}
