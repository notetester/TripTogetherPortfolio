package org.triptogether.common.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 챗봇 1차 분류 결과.
 * - intent: 메시지 의도 카테고리 (EXPLORE / COURSES / PACKAGES / COMMUNITY / GENERIC / INAPPROPRIATE)
 * - keywords: 핵심 검색어 (지역명·장소명·테마·시기 등)
 * - relatedTerms: 유의어·관련어 (예: "신혼여행" → ["로맨틱", "커플"])
 *
 * 분류 실패 시 fallback 으로 생성될 땐 intent=GENERIC, keywords=규칙기반 추출 결과.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatIntentVO {

    public static final String INTENT_EXPLORE       = "EXPLORE";
    public static final String INTENT_COURSES       = "COURSES";
    public static final String INTENT_PACKAGES      = "PACKAGES";
    public static final String INTENT_COMMUNITY     = "COMMUNITY";
    public static final String INTENT_GENERIC       = "GENERIC";
    public static final String INTENT_INAPPROPRIATE = "INAPPROPRIATE";

    private String intent;
    private List<String> keywords;
    private List<String> relatedTerms;

    public boolean isInappropriate() {
        return INTENT_INAPPROPRIATE.equals(intent);
    }
}
