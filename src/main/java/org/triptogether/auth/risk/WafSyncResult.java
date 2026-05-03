package org.triptogether.auth.risk;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class WafSyncResult {
    private boolean handled;
    private boolean success;
    private String status;
    private String message;
}
