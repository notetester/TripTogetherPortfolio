package org.triptogether.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.common.vo.ConversationVO;

import java.util.List;

@Mapper
public interface ChatbotConversationMapper {

    // ===== 유저 측 =====

    // 신규 대화 생성 (useGeneratedKeys로 conversationId 반환)
    void insertConversation(ConversationVO conversation);

    // 단건 조회
    ConversationVO selectConversation(@Param("conversationId") Long conversationId);

    // 로그인 유저의 활성 대화 목록 (최신순)
    List<ConversationVO> selectConversationsByUser(@Param("userIdx") Long userIdx);

    // 비로그인 유저의 활성 대화 목록
    List<ConversationVO> selectConversationsByAnonSession(@Param("anonSessionId") String anonSessionId);

    // 제목 수정
    void updateTitle(@Param("conversationId") Long conversationId,
                     @Param("title") String title);

    // 활동 시각 갱신
    void updateLastActive(@Param("conversationId") Long conversationId);

    // 소프트 삭제 (유저가 숨김)
    void softDelete(@Param("conversationId") Long conversationId);

    // 유저/세션의 활성 대화 수 (한도 체크)
    int countActiveConversations(@Param("userIdx") Long userIdx,
                                 @Param("anonSessionId") String anonSessionId);

    // ===== 관리자 측 =====

    // 전체 대화 검색 (키워드: userId/IP/title)
    List<ConversationVO> selectAllConversations(@Param("keyword") String keyword,
                                                @Param("offset") int offset,
                                                @Param("limit") int limit);

    int countAllConversations(@Param("keyword") String keyword);

    // 오늘 생성된 대화 수 (관리자 대시보드용)
    int countTodayConversations();
}
