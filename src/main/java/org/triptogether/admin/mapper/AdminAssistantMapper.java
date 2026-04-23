package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.AdminAssistantMessageVO;
import org.triptogether.admin.vo.AdminAssistantSessionVO;
import org.triptogether.admin.vo.AdminAssistantStatsVO;

import java.util.List;

/**
 * 관리자 AI 도우미(assistant) 관리 Mapper.
 * SJ가 구현한 CHAT_POST/CHAT_COMMENT 테이블을 읽기/삭제만 수행.
 * 쓰기(INSERT/UPDATE)는 assistant 모듈의 AssistantMapper가 담당하므로 여기선 다루지 않음.
 */
@Mapper
public interface AdminAssistantMapper {

    // ===== 대시보드 통계 =====
    AdminAssistantStatsVO selectStats();

    // ===== 세션 목록 =====
    List<AdminAssistantSessionVO> selectSessions(@Param("keyword") String keyword,
                                                 @Param("offset") int offset,
                                                 @Param("limit") int limit);

    int countSessions(@Param("keyword") String keyword);

    AdminAssistantSessionVO selectSession(@Param("chatPostIdx") Long chatPostIdx);

    // ===== 메시지 =====
    List<AdminAssistantMessageVO> selectMessagesByPost(@Param("chatPostIdx") Long chatPostIdx);

    List<AdminAssistantMessageVO> selectRecentMessages(@Param("offset") int offset,
                                                      @Param("limit") int limit);

    int countMessages();

    // ===== 관리자 삭제 (세션 삭제 시 FK CASCADE로 메시지도 삭제됨) =====
    int deleteSession(@Param("chatPostIdx") Long chatPostIdx);
}
