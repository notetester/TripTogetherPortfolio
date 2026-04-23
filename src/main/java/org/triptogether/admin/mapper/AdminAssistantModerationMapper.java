package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.AdminAssistantModerationVO;

import java.math.BigDecimal;
import java.util.List;

/**
 * ADMIN_ASSISTANT_MODERATION 매퍼.
 * 스케줄러가 user 메시지 Perspective 판정 결과 저장/조회.
 * 관리자 페이지 부적절 메시지 탭이 조회 사용.
 */
@Mapper
public interface AdminAssistantModerationMapper {

    /** 아직 검사 안 된 user 메시지의 chat_comment_idx 목록을 N개 까지 반환. */
    List<Long> selectPendingUserCommentIds(@Param("limit") int limit);

    /** 판정 결과 저장 (chat_comment_idx UNIQUE). */
    int insertModeration(@Param("chatCommentIdx") Long chatCommentIdx,
                         @Param("isInappropriate") Boolean isInappropriate,
                         @Param("toxicityScore") BigDecimal toxicityScore);

    /** 부적절 메시지 목록 (관리자 페이지용, 페이징). */
    List<AdminAssistantModerationVO> selectInappropriateMessages(@Param("offset") int offset,
                                                                 @Param("limit") int limit);

    /** 부적절 메시지 총 개수. */
    int countInappropriateMessages();
}
