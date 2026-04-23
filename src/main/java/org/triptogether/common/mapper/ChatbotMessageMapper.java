package org.triptogether.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.common.vo.ChatMessageVO;

import java.util.List;

@Mapper
public interface ChatbotMessageMapper {

    // 메시지 저장 (useGeneratedKeys로 messageId 반환)
    void insertMessage(ChatMessageVO message);

    // 부적절 플래그 업데이트 (중복 INSERT 대신 UPDATE)
    void updateMessageInappropriate(@Param("messageId") Long messageId);

    // 대화의 최근 N개 (AI 컨텍스트용, 시간 오름차순 반환)
    List<ChatMessageVO> selectRecentMessages(@Param("conversationId") Long conversationId,
                                             @Param("limit") int limit);

    // 대화의 전체 메시지 (관리자 상세 조회용)
    List<ChatMessageVO> selectAllMessages(@Param("conversationId") Long conversationId);

    // ===== 관리자: 부적절 메시지 목록 =====

    List<ChatMessageVO> selectInappropriateMessages(@Param("offset") int offset,
                                                    @Param("limit") int limit);

    int countInappropriateMessages();

    // 특정 대화의 오늘자 user 메시지 수 (쿼터 차감용)
    int countTodayUserMessagesByConversation(@Param("conversationId") Long conversationId);
}
