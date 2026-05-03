package org.triptogether.auth.risk;

import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;

public interface WafSyncAdapter {
    boolean supports(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item);
    WafSyncResult sync(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item);
}
