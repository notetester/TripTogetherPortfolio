package org.triptogether.auth.risk;

import org.triptogether.auth.vo.SecurityWafSyncQueueVO;

public interface WafSyncProvider {
    boolean supports(SecurityWafSyncQueueVO item);
    WafSyncResult sync(SecurityWafSyncQueueVO item);
}
