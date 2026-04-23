package org.triptogether.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.common.vo.ChatbotDailyUsageVO;
import org.triptogether.common.vo.ChatbotQuotaVO;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface ChatbotQuotaMapper {

    // ===== 등급별 한도 =====

    // 특정 등급 한도 조회
    ChatbotQuotaVO selectQuotaByGrade(@Param("grade") String grade);

    // 전체 등급 한도 목록 (관리자 편집 화면)
    List<ChatbotQuotaVO> selectAllQuotas();

    // 등급 한도 업데이트
    void updateQuota(ChatbotQuotaVO quota);

    // ===== 일일 사용량 =====

    // 사용량 조회 (유저 또는 IP 기준, 주기 시작 시각 특정)
    ChatbotDailyUsageVO selectDailyUsage(@Param("userIdx") Long userIdx,
                                         @Param("ipAddress") String ipAddress,
                                         @Param("periodStart") LocalDateTime periodStart);

    // 사용량 +1 (없으면 INSERT, 있으면 UPDATE)
    void upsertDailyUsageIncrement(@Param("userIdx") Long userIdx,
                                   @Param("ipAddress") String ipAddress,
                                   @Param("periodStart") LocalDateTime periodStart);

    // 사용량 -N (GREATEST(0, ...) 로 음수 방지, 행 없으면 no-op)
    void decreaseDailyUsage(@Param("userIdx") Long userIdx,
                            @Param("ipAddress") String ipAddress,
                            @Param("periodStart") LocalDateTime periodStart,
                            @Param("amount") int amount);
}
