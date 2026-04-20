package org.triptogether.moderation.service;

import org.triptogether.moderation.vo.ContentModerationPolicyVO;

public interface ModerationPolicyService {

    /** 현재 정책 조회 (캐시 우선). null 반환하지 않음 — 비어있으면 기본값 반환 */
    ContentModerationPolicyVO getPolicy();

    /** 정책 갱신 후 캐시 무효화 */
    void updatePolicy(ContentModerationPolicyVO policy);

    /** 외부에서 강제 캐시 무효화가 필요할 때 */
    void invalidate();
}
