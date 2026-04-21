package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminIpBlockBatchOperationRuleVO {
    private Long ipBlockBatchOperationRuleIdx;
    private Long ipBlockBatchOperationIdx;
    private Long ipBlocklistIdx;
    private String operationEffect;
    private boolean beforeIsActive;
    private boolean afterIsActive;
    private String beforeControlMode;
    private String afterControlMode;
    private String memo;
}
