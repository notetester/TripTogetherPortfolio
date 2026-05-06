package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.admin.vo.AdminActionAuditVO;

@Service
@RequiredArgsConstructor
public class AdminActionAuditService {

    private final AdminMapper adminMapper;

    public void record(String actionType,
                       String actionDomain,
                       Long actorUserIdx,
                       String targetType,
                       String targetId,
                       String reasonCode,
                       String reasonArgs,
                       String detailSummary) {
        AdminActionAuditVO audit = new AdminActionAuditVO();
        audit.setActionType(actionType);
        audit.setActionDomain(actionDomain);
        audit.setActorUserIdx(actorUserIdx);
        audit.setTargetType(targetType);
        audit.setTargetId(targetId);
        audit.setReasonCode(reasonCode);
        audit.setReasonArgs(reasonArgs);
        audit.setDetailSummary(detailSummary);
        adminMapper.insertAdminActionAudit(audit);
    }
}
