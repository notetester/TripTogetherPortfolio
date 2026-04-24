package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminAssistantUsageVO;

import java.time.LocalDateTime;

/**
 * AI 도우미 주기별 사용량 서비스.
 * 인터셉터가 한도 체크 및 메시지/세션 증분에 사용.
 */
public interface AdminAssistantUsageService {

    /** 특정 유저(또는 IP)의 해당 주기 사용량. 없으면 null. */
    AdminAssistantUsageVO getUsage(Long userIdx, String ipAddress, LocalDateTime periodStart);

    /** 해당 주기 message_count +1 (upsert). */
    void incrementMessageCount(Long userIdx, String ipAddress, LocalDateTime periodStart);

    /** 해당 주기 session_count +1 (upsert). 신규 CHAT_POST 생성 감지 시. */
    void incrementSessionCount(Long userIdx, String ipAddress, LocalDateTime periodStart);

    /** 세션 삭제 시 환급: 해당 주기 message_count 차감. 레코드 없으면 no-op. */
    void decreaseMessageCount(Long userIdx, String ipAddress, LocalDateTime periodStart, int amount);
}
