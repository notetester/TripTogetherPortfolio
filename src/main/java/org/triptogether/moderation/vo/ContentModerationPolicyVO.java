package org.triptogether.moderation.vo;

import lombok.Data;
import java.util.Date;

/**
 * CONTENT_MODERATION_POLICY 단일 행 매핑 VO
 */
@Data
public class ContentModerationPolicyVO {

    /** 항상 1 고정 */
    private int id;

    /** Perspective API 민감도 (STRICT / NORMAL / LOOSE) */
    private String toxicityLevel;

    private int postWindowMinutes;
    private int postMaxCount;

    private int commentWindowMinutes;
    private int commentMaxCount;

    private int inquiryWindowMinutes;
    private int inquiryMaxCount;

    /** 신고 누적 BLUR 임계값 (이 값 이상이면 일반 사용자에게 BLUR 처리) */
    private int reportThreshold;

    private Date updatedAt;
    private Long updatedByUserIdx;

    /** 민감도 레벨 → Perspective threshold 값 변환 */
    public double getToxicityThreshold() {
        if (toxicityLevel == null) return 0.8;
        switch (toxicityLevel) {
            case "STRICT": return 0.6;
            case "LOOSE":  return 0.9;
            case "NORMAL":
            default:       return 0.8;
        }
    }
}
