package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminIpBlockBatchOperationVO {
    private Long ipBlockBatchOperationIdx;
    private Long ipBlockBatchIdx;
    private String batchCode;
    private String batchName;
    private String operationType;
    private String operationOption;
    private int requestedRuleCount;
    private int affectedRuleCount;
    private String description;
    private Long requestedByUserIdx;
    private String requestedByNickname;
    private LocalDateTime requestedAt;

    public String getOperationTypeLabel() {
        if ("BATCH_ACTIVATE".equalsIgnoreCase(operationType)) return "배치 활성화";
        if ("BATCH_DEACTIVATE".equalsIgnoreCase(operationType)) return "배치 비활성화";
        if ("RESTORE_BATCH_CONTROL".equalsIgnoreCase(operationType)) return "배치 제어 복구";
        return operationType;
    }

    public String getOperationOptionLabel() {
        if ("CASCADE_ACTIVE_RULES".equalsIgnoreCase(operationOption)) return "규칙도 함께 OFF";
        if ("RESTORE_BATCH_CONTROL".equalsIgnoreCase(operationOption)) return "이전 배치 상태 복구";
        if ("FORCE_ENABLE_ALL".equalsIgnoreCase(operationOption)) return "전부 ON";
        if ("KEEP_MANUAL_OVERRIDE".equalsIgnoreCase(operationOption)) return "수동 예외 유지";
        return "배치만";
    }

    public Date getRequestedAtDate() {
        return requestedAt == null ? null : Date.from(requestedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
