package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.AdminAssistantUsageVO;

import java.time.LocalDateTime;

/**
 * ADMIN_ASSISTANT_DAILY_USAGE 매퍼 - 주기별 사용량.
 * 인터셉터가 한도 체크 시 사용.
 */
@Mapper
public interface AdminAssistantUsageMapper {

    /** 특정 유저/IP + 주기의 사용량 조회. 없으면 null. */
    AdminAssistantUsageVO selectUsage(@Param("userIdx") Long userIdx,
                                      @Param("ipAddress") String ipAddress,
                                      @Param("periodStart") LocalDateTime periodStart);

    /** 메시지 카운트 +1 (upsert). 레코드 없으면 INSERT, 있으면 UPDATE. */
    int upsertMessageIncrement(@Param("userIdx") Long userIdx,
                               @Param("ipAddress") String ipAddress,
                               @Param("periodStart") LocalDateTime periodStart);

    /** 세션 카운트 +1 (upsert). 신규 CHAT_POST 생성 감지 시 호출. */
    int upsertSessionIncrement(@Param("userIdx") Long userIdx,
                               @Param("ipAddress") String ipAddress,
                               @Param("periodStart") LocalDateTime periodStart);

    /** 메시지 카운트 -amount (세션 삭제 환급용). 레코드 없으면 no-op. 음수 방지 GREATEST(0,...). */
    int decreaseMessageCount(@Param("userIdx") Long userIdx,
                              @Param("ipAddress") String ipAddress,
                              @Param("periodStart") LocalDateTime periodStart,
                              @Param("amount") int amount);
}
