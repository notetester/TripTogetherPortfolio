package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminAssistantQuotaVO;
import org.triptogether.auth.vo.UsersVO;

import java.time.LocalDateTime;
import java.util.List;

/**
 * AI 도우미 등급별 한도 서비스.
 * 인터셉터의 한도 체크 + 관리자 페이지 CRUD.
 */
public interface AdminAssistantQuotaService {

    /** 로그인 유저의 등급 문자열 (비로그인·null은 GUEST, member_grade 공백은 BRONZE 기본). */
    String resolveGrade(UsersVO user);

    /** ADMIN/SUPERADMIN 은 한도 체크 면제. */
    boolean isQuotaExempt(UsersVO user);

    /** 등급으로 한도 조회. 해당 등급 없으면 GUEST 한도 반환. */
    AdminAssistantQuotaVO getQuotaByGrade(String grade);

    /** 전체 등급 한도. */
    List<AdminAssistantQuotaVO> getAllQuotas();

    /** 한도 수정. */
    void updateQuota(AdminAssistantQuotaVO quota);

    /**
     * 현재 주기의 시작 시각 계산.
     * 앵커(2000-01-01 HH:MM) 기준 periodDays*24h 간격으로 floor.
     * 챗봇 ChatbotQuotaService.calculateCurrentPeriodStart 와 동일 로직.
     */
    LocalDateTime calculateCurrentPeriodStart(AdminAssistantQuotaVO quota);
}
