<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="blocks"/>
<spring:message code="admin.blocks.pageTitle" var="adminBlocksPageTitle"/>
<spring:message code="admin.blocks.individualRule" var="adminBlocksIndividualRuleLabel"/>
<spring:message code="admin.members.none" var="adminBlocksNoneLabel"/>
<spring:message code="admin.common.settings" var="adminBlocksSettingsLabel"/>
<spring:message code="admin.common.history" var="adminBlocksHistoryLabel"/>
<spring:message code="admin.blocks.ruleOff" var="adminBlocksRuleOffLabel"/>
<spring:message code="admin.blocks.ruleOn" var="adminBlocksRuleOnLabel"/>
<spring:message code="admin.blocks.returnToBatch" var="adminBlocksReturnToBatchLabel"/>
<c:set var="pageTitle" value="${adminBlocksPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div class="adm-kpi-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));">
                <div class="adm-kpi-card">
                    <div class="adm-kpi-label"><spring:message code="admin.blocks.kpi.activeUserBlocks"/></div>
                    <div class="adm-kpi-value">${activeUserBlockCount}</div>
                </div>
                <div class="adm-kpi-card">
                    <div class="adm-kpi-label"><spring:message code="admin.blocks.kpi.activePolicies"/></div>
                    <div class="adm-kpi-value">${activeIpBlockCount}</div>
                </div>
                <div class="adm-kpi-card">
                    <div class="adm-kpi-label"><spring:message code="admin.blocks.kpi.history"/></div>
                    <div class="adm-kpi-value">${blockHistoryCount}</div>
                </div>
                <div class="adm-kpi-card">
                    <div class="adm-kpi-label"><spring:message code="admin.blocks.kpi.activeBatches"/></div>
                    <div class="adm-kpi-value">${activeBatchCount}</div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/blocks">
                <input type="hidden" name="tab" id="blockActiveTabInput" value="${fn:escapeXml(param.tab)}">
                <div class="adm-filter-bar">
                    <div style="flex:1;min-width:260px;">
                        <div class="adm-filter-label"><spring:message code="admin.blocks.globalSearch"/></div>
                        <div class="adm-search-box">
                            <span class="adm-search-ico">🔍</span>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.blocks.searchPlaceholder'/>">
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.blocks.ruleState"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="ACTIVE" ${search.status=='ACTIVE'?'selected':''}><spring:message code="admin.blocks.ruleOn"/></option>
                            <option value="INACTIVE" ${search.status=='INACTIVE'?'selected':''}><spring:message code="admin.blocks.ruleOff"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.blocks.scope"/></div>
                        <select class="adm-select" name="scope">
                            <option value="ALL" ${search.scope=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="USER_ACTION" ${search.scope=='USER_ACTION'?'selected':''}><spring:message code="admin.blocks.scope.userAction"/></option>
                            <option value="GLOBAL" ${search.scope=='GLOBAL'?'selected':''}><spring:message code="admin.blocks.scope.global"/></option>
                            <option value="AUTO_DETECTION" ${search.scope=='AUTO_DETECTION'?'selected':''}><spring:message code="admin.blocks.scope.autoDetection"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.context.ruleAction"/></div>
                        <select class="adm-select" name="ruleAction">
                            <option value="ALL" ${search.ruleAction=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="BLOCK" ${search.ruleAction=='BLOCK'?'selected':''}><spring:message code="admin.context.ruleAction.block"/></option>
                            <option value="ALLOW" ${search.ruleAction=='ALLOW'?'selected':''}><spring:message code="admin.context.ruleAction.allow"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.blocks.controlMode"/></div>
                        <select class="adm-select" name="controlMode">
                            <option value="ALL" ${search.controlMode=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="MANUAL" ${search.controlMode=='MANUAL'?'selected':''}><spring:message code="admin.blocks.control.manual"/></option>
                            <option value="BATCH" ${search.controlMode=='BATCH'?'selected':''}><spring:message code="admin.blocks.control.batch"/></option>
                            <option value="MANUAL_OVERRIDE" ${search.controlMode=='MANUAL_OVERRIDE'?'selected':''}><spring:message code="admin.blocks.control.override"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.blocks.matchType"/></div>
                        <select class="adm-select" name="matchType">
                            <option value="ALL" ${search.matchType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="SINGLE_IP" ${search.matchType=='SINGLE_IP'?'selected':''}><spring:message code="admin.blocks.match.singleIp"/></option>
                            <option value="CIDR" ${search.matchType=='CIDR'?'selected':''}><spring:message code="admin.blocks.match.cidr"/></option>
                            <option value="RANGE" ${search.matchType=='RANGE'?'selected':''}><spring:message code="admin.blocks.match.range"/></option>
                            <option value="COUNTRY" ${search.matchType=='COUNTRY'?'selected':''}><spring:message code="admin.blocks.match.country"/></option>
                            <option value="ASN" ${search.matchType=='ASN'?'selected':''}><spring:message code="admin.blocks.match.asn"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.context.category"/></div>
                        <select class="adm-select" name="category">
                            <option value="ALL" ${search.category=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="MANUAL" ${search.category=='MANUAL'?'selected':''}><spring:message code="admin.blocks.category.manual"/></option>
                            <option value="SPAM" ${search.category=='SPAM'?'selected':''}><spring:message code="admin.blocks.category.spam"/></option>
                            <option value="ABUSE" ${search.category=='ABUSE'?'selected':''}><spring:message code="admin.blocks.category.abuse"/></option>
                            <option value="BRUTE_FORCE" ${search.category=='BRUTE_FORCE'?'selected':''}><spring:message code="admin.blocks.category.bruteForce"/></option>
                            <option value="GEO" ${search.category=='GEO'?'selected':''}><spring:message code="admin.blocks.category.geo"/></option>
                            <option value="VPN" ${search.category=='VPN'?'selected':''}><spring:message code="admin.blocks.category.vpn"/></option>
                            <option value="SECURITY" ${search.category=='SECURITY'?'selected':''}><spring:message code="admin.blocks.category.security"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.blocks.effectiveState"/></div>
                        <select class="adm-select" name="effectiveStatus">
                            <option value="ALL" ${search.effectiveStatus=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="EFFECTIVE" ${search.effectiveStatus=='EFFECTIVE'?'selected':''}><spring:message code="admin.blocks.effective.effective"/></option>
                            <option value="RULE_INACTIVE" ${search.effectiveStatus=='RULE_INACTIVE'?'selected':''}><spring:message code="admin.blocks.effective.ruleInactive"/></option>
                            <option value="BATCH_INACTIVE" ${search.effectiveStatus=='BATCH_INACTIVE'?'selected':''}><spring:message code="admin.blocks.effective.batchInactive"/></option>
                            <option value="EXPIRED" ${search.effectiveStatus=='EXPIRED'?'selected':''}><spring:message code="admin.blocks.effective.expired"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.context.batch"/></div>
                        <select class="adm-select" name="batchId">
                            <option value=""><spring:message code="admin.common.all"/></option>
                            <c:forEach var="bt" items="${batches}">
                                <option value="${bt.ipBlockBatchIdx}" ${search.batchId == bt.ipBlockBatchIdx ? 'selected' : ''}>${bt.batchName} (${bt.batchCode})</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:8px;">
                        <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.apply"/></button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/blocks"><spring:message code="admin.common.reset"/></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-tab-row adm-block-tab-row" id="blockTabBar" style="margin-bottom:20px;">
        <button type="button" class="adm-tab js-block-tab" data-tab="dashboard"><spring:message code="admin.layout.menu.dashboard"/></button>
        <button type="button" class="adm-tab js-block-tab" data-tab="all"><spring:message code="admin.common.all"/></button>
        <button type="button" class="adm-tab js-block-tab" data-tab="user-blocks"><spring:message code="admin.blocks.section.userBlocks"/></button>
        <button type="button" class="adm-tab js-block-tab" data-tab="ip-rules"><spring:message code="admin.blocks.section.ipRules"/></button>
        <button type="button" class="adm-tab js-block-tab" data-tab="batches"><spring:message code="admin.blocks.section.batches"/></button>
        <button type="button" class="adm-tab js-block-tab" data-tab="histories"><spring:message code="admin.blocks.section.histories"/></button>
    </div>

    <div class="adm-card js-dashboard-panel" style="margin-bottom:20px;display:none;">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.blocks.dashboard.title"/></div>
            <div class="adm-card-sub"><spring:message code="admin.blocks.dashboard.sub"/></div>
        </div>
        <div class="adm-card-body">
            <div class="adm-kpi-grid" style="display:grid;grid-template-columns:1fr;row-gap:28px;">
                <div class="adm-card" style="margin:0;">
                    <div class="adm-card-head">
                        <div class="adm-card-title" style="font-size:15px;"><spring:message code="admin.blocks.dashboard.recentUserBlocks"/></div>
                        <div class="adm-card-sub"><spring:message code="admin.blocks.dashboard.topFive"/></div>
                    </div>
                    <div class="adm-card-body" style="padding:0;">
                        <div class="adm-table-wrap">
                            <table class="adm-table">
                                <thead><tr><th><spring:message code="admin.common.member"/></th><th><spring:message code="admin.common.target"/></th><th><spring:message code="admin.common.status"/></th><th><spring:message code="admin.common.action"/></th></tr></thead>
                                <tbody>
                                <c:forEach var="b" items="${userBlocks}" begin="0" end="4">
                                    <tr>
                                        <td>${empty b.nickname ? '-' : b.nickname}</td>
                                        <td>${empty b.blockedIp ? b.blockTargetKey : b.blockedIp}</td>
                                        <td>${b.snapshotStatus}</td>
                                        <td>
                                            <button type="button"
                                                    class="adm-row-btn detail js-open-user-block-editor"
                                                    data-block-idx="${b.blockIdx}"
                                                    data-template-id="detail-user-${b.blockIdx}"
                                                    data-user-idx="${empty b.userIdx ? '' : b.userIdx}"
                                                    data-display-name="${fn:escapeXml(empty b.nickname ? b.userId : b.nickname)}"
                                                    data-user-id="${fn:escapeXml(empty b.userId ? '' : b.userId)}"
                                                    data-user-email="${fn:escapeXml(empty b.userEmail ? '' : b.userEmail)}"
                                                    data-block-type="${b.blockType}"
                                                    data-blocked-ip="${fn:escapeXml(empty b.blockedIp ? '' : b.blockedIp)}"
                                                    data-target-key="${fn:escapeXml(b.blockTargetKey)}"
                                                    data-active="${b.active ? 'true' : 'false'}"
                                                    data-snapshot-status="${fn:escapeXml(b.snapshotStatus)}"
                                                    data-reason="${fn:escapeXml(empty b.reason ? '' : b.reason)}"
                                                    data-expires-at="${b.expiresAtInputValue}"
                                                    data-blocked-at="-"
                                                    data-last-history-at="-"
                                                    data-sync-at="-"><spring:message code="admin.common.settings"/></button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty userBlocks}">
                                    <tr><td colspan="4" style="text-align:center;color:#64748b;"><spring:message code="admin.common.noData"/></td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="adm-card" style="margin:0;">
                    <div class="adm-card-head">
                        <div class="adm-card-title" style="font-size:15px;"><spring:message code="admin.blocks.dashboard.recentIpRules"/></div>
                        <div class="adm-card-sub"><spring:message code="admin.blocks.dashboard.ipRulesSub"/></div>
                    </div>
                    <div class="adm-card-body" style="padding:0;">
                        <div class="adm-table-wrap">
                            <table class="adm-table">
                                <thead><tr><th><spring:message code="admin.common.target"/></th><th><spring:message code="admin.common.actionLabel"/></th><th><spring:message code="admin.blocks.effectiveState"/></th><th><spring:message code="admin.common.action"/></th></tr></thead>
                                <tbody>
                                <c:forEach var="r" items="${ipBlocks}" begin="0" end="4">
                                    <tr>
                                        <td>${empty r.targetDisplayValue ? r.blockTargetKey : r.targetDisplayValue}</td>
                                        <td>${r.ruleActionLabel} / ${r.controlModeLabel}</td>
                                        <td>${r.finalStateLabel}</td>
                                        <td>
                                            <button type="button"
                                                    class="adm-row-btn detail js-open-ip-rule-editor"
                                                    data-id="${r.ipBlocklistIdx}"
                                                    data-template-id="detail-ip-${r.ipBlocklistIdx}"
                                                    data-target-display="${fn:escapeXml(empty r.targetDisplayValue ? r.blockTargetKey : r.targetDisplayValue)}"
                                                    data-target-key="${fn:escapeXml(r.blockTargetKey)}"
                                                    data-rule-action="${r.ruleAction}"
                                                    data-control-mode="${r.controlMode}"
                                                    data-block-category="${r.blockCategory}"
                                                    data-priority="${r.priority}"
                                                    data-reason="${fn:escapeXml(empty r.reason ? '' : r.reason)}"
                                                    data-detail-message="${fn:escapeXml(empty r.detailMessage ? '' : r.detailMessage)}"
                                                    data-expires-at="${r.expiresAtInputValue}"
                                                    data-effective-status-label="${fn:escapeXml(r.effectiveStatusLabel)}"
                                                    data-final-state-label="${fn:escapeXml(r.finalStateLabel)}"
                                                    data-rule-state-label="${fn:escapeXml(r.ruleStateLabel)}"
                                                    data-batch-status-label="${fn:escapeXml(r.batchStatusLabel)}"
                                                    data-batch-name="${fn:escapeXml(empty r.batchName ? adminBlocksIndividualRuleLabel : r.batchName)}"
                                                    data-batch-code="${fn:escapeXml(empty r.batchCode ? '' : r.batchCode)}"
                                                    data-batch-id="${empty r.ipBlockBatchIdx ? '' : r.ipBlockBatchIdx}"
                                                    data-blocked-at="-"
                                                    data-expires-display="-"
                                                    data-active="${r.active ? 'true' : 'false'}"><spring:message code="admin.common.settings"/></button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty ipBlocks}">
                                    <tr><td colspan="4" style="text-align:center;color:#64748b;"><spring:message code="admin.common.noData"/></td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="adm-card" style="margin:0;">
                    <div class="adm-card-head">
                        <div class="adm-card-title" style="font-size:15px;"><spring:message code="admin.blocks.dashboard.recentBatchOps"/></div>
                        <div class="adm-card-sub"><spring:message code="admin.blocks.dashboard.batchOpsSub"/></div>
                    </div>
                    <div class="adm-card-body" style="padding:0;">
                        <div class="adm-table-wrap">
                            <table class="adm-table">
                                <thead><tr><th><spring:message code="admin.context.batch"/></th><th><spring:message code="admin.common.actionLabel"/></th><th><spring:message code="admin.blocks.impact"/></th><th><spring:message code="admin.common.action"/></th></tr></thead>
                                <tbody>
                                <c:forEach var="op" items="${batchOperations}" begin="0" end="4">
                                    <tr>
                                        <td>${empty op.batchName ? '-' : op.batchName}</td>
                                        <td>${op.operationTypeLabel}</td>
                                        <td>${op.affectedRuleCount} / ${op.requestedRuleCount}</td>
                                        <td>
                                            <c:if test="${op.ipBlockBatchIdx != null}">
                                                <button type="button"
                                                        class="adm-row-btn detail js-open-batch-editor"
                                                        data-batch-id="${op.ipBlockBatchIdx}"
                                                        data-batch-code="${fn:escapeXml(empty op.batchCode ? '' : op.batchCode)}"
                                                        data-batch-name="${fn:escapeXml(empty op.batchName ? '' : op.batchName)}"><spring:message code="admin.common.settings"/></button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty batchOperations}">
                                    <tr><td colspan="4" style="text-align:center;color:#64748b;"><spring:message code="admin.common.noData"/></td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="adm-card" style="margin:0;">
                    <div class="adm-card-head">
                        <div class="adm-card-title" style="font-size:15px;"><spring:message code="admin.blocks.dashboard.recentHistory"/></div>
                        <div class="adm-card-sub"><spring:message code="admin.blocks.dashboard.historySub"/></div>
                    </div>
                    <div class="adm-card-body" style="padding:0;">
                        <div class="adm-table-wrap">
                            <table class="adm-table">
                                <thead><tr><th><spring:message code="admin.common.target"/></th><th><spring:message code="admin.blocks.changeKind"/></th><th><spring:message code="admin.blocks.result"/></th><th><spring:message code="admin.common.action"/></th></tr></thead>
                                <tbody>
                                <c:forEach var="h" items="${histories}" begin="0" end="4">
                                    <c:set var="historyCurrentType" value="IP_RULE"/>
                                    <c:if test="${h.blockScope == 'USER_ACTION'}">
                                        <c:set var="historyCurrentType" value="USER_BLOCK"/>
                                    </c:if>
                                    <c:if test="${not empty h.batchOperationIdx and not empty h.ipBlockBatchIdx}">
                                        <c:set var="historyCurrentType" value="BATCH"/>
                                    </c:if>
                                    <tr>
                                        <td>${h.blockTargetKey}</td>
                                        <td>${h.historyKind}</td>
                                        <td>${empty h.effectiveResult ? '-' : h.effectiveResult}</td>
                                        <td>
                                            <button type="button"
                                                    class="adm-row-btn detail js-open-history-current"
                                                    data-history-id="${h.blockIdx}"
                                                    data-current-type="${historyCurrentType}"
                                                    data-target-key="${fn:escapeXml(h.blockTargetKey)}"
                                                    data-rule-action="${fn:escapeXml(empty h.ruleAction ? '' : h.ruleAction)}"
                                                    data-batch-id="${empty h.ipBlockBatchIdx ? '' : h.ipBlockBatchIdx}"
                                                    data-template-id="detail-history-${h.blockIdx}"><spring:message code="admin.blocks.currentSetting"/></button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty histories}">
                                    <tr><td colspan="4" style="text-align:center;color:#64748b;"><spring:message code="admin.common.noData"/></td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card js-section-card" data-section="user-blocks" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.blocks.userBlocks.title"/></div>
            <div class="adm-card-sub"><spring:message code="admin.blocks.userBlocks.sub"/></div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="user-blocks">
                        <option value="all"><spring:message code="admin.blocks.filter.allFields"/></option>
                        <option value="nickname"><spring:message code="admin.blocks.filter.memberNickname"/></option>
                        <option value="userId"><spring:message code="admin.blocks.filter.memberUserId"/></option>
                        <option value="target"><spring:message code="admin.blocks.filter.blockTarget"/></option>
                        <option value="reason"><spring:message code="admin.common.reason"/></option>
                        <option value="blockType"><spring:message code="admin.blocks.filter.blockType"/></option>
                        <option value="blockedAt"><spring:message code="admin.blocks.filter.blockedDate"/></option>
                        <option value="expiresAt"><spring:message code="admin.blocks.filter.expireDate"/></option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="user-blocks" placeholder="<spring:message code='admin.blocks.userBlocks.searchPlaceholder'/>">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="user-blocks"><spring:message code="admin.common.reset"/></button>
                </div>
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-page-size" data-section="user-blocks">
                        <option value="10"><spring:message code="admin.common.pageSize" arguments="10"/></option>
                        <option value="20" selected><spring:message code="admin.common.pageSize" arguments="20"/></option>
                        <option value="50"><spring:message code="admin.common.pageSize" arguments="50"/></option>
                    </select>
                </div>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr><th><spring:message code="admin.common.member"/></th><th><spring:message code="admin.blocks.filter.blockType"/></th><th><spring:message code="admin.common.target"/></th><th><spring:message code="admin.common.status"/></th><th><spring:message code="admin.common.reason"/></th><th><spring:message code="admin.blocks.blockAndExpire"/></th><th><spring:message code="admin.common.action"/></th></tr>
                    </thead>
                    <tbody>
                    <c:forEach var="b" items="${userBlocks}">
                        <fmt:formatDate var="userBlockBlockedAtText" value="${b.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        <c:set var="userBlockLastHistoryText" value="-"/>
                        <c:if test="${b.lastHistoryAtDate != null}">
                            <fmt:formatDate var="userBlockLastHistoryText" value="${b.lastHistoryAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        </c:if>
                        <c:set var="userBlockSyncText" value="-"/>
                        <c:if test="${b.syncedAtDate != null}">
                            <fmt:formatDate var="userBlockSyncText" value="${b.syncedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        </c:if>
                        <tr class="js-local-row"
                            data-section="user-blocks"
                            data-search="${fn:toLowerCase(empty b.nickname ? '' : b.nickname)} ${fn:toLowerCase(empty b.userId ? '' : b.userId)} ${fn:toLowerCase(empty b.userEmail ? '' : b.userEmail)} ${fn:toLowerCase(empty b.blockedIp ? '' : b.blockedIp)} ${fn:toLowerCase(empty b.reason ? '' : b.reason)} ${fn:toLowerCase(empty b.blockTargetKey ? '' : b.blockTargetKey)} ${fn:toLowerCase(empty b.blockType ? '' : b.blockType)} ${fn:toLowerCase(empty b.snapshotStatus ? '' : b.snapshotStatus)}"
                            data-nickname="${fn:toLowerCase(empty b.nickname ? '' : b.nickname)}"
                            data-user-id="${fn:toLowerCase(empty b.userId ? '' : b.userId)}"
                            data-target="${fn:toLowerCase(empty b.blockedIp ? '' : b.blockedIp)} ${fn:toLowerCase(empty b.blockTargetKey ? '' : b.blockTargetKey)}"
                            data-reason="${fn:toLowerCase(empty b.reason ? '' : b.reason)}"
                            data-block-type="${fn:toLowerCase(empty b.blockType ? '' : b.blockType)}"
                            data-blocked-at="${fn:toLowerCase(userBlockBlockedAtText)}"
                            data-expires-at="${fn:toLowerCase(empty b.expiresAtInputValue ? '' : b.expiresAtInputValue)}">
                            <td>
                                <c:choose>
                                    <c:when test="${b.userIdx != null}">
                                        <button type="button"
                                                class="adm-inline-link js-open-member-detail"
                                                data-user-idx="${b.userIdx}"
                                                style="font-weight:700;color:#93c5fd;">
                                            ${empty b.nickname ? '-' : b.nickname}
                                        </button>
                                        <div style="font-size:12px;color:#94a3b8;">
                                            <button type="button"
                                                    class="adm-inline-link js-open-member-detail"
                                                    data-user-idx="${b.userIdx}"
                                                    style="color:#94a3b8;font-size:12px;">
                                                ${empty b.userId ? '-' : b.userId}
                                            </button>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="font-weight:700;color:#e2e8f0;">${empty b.nickname ? '-' : b.nickname}</div>
                                        <div style="font-size:12px;color:#94a3b8;">${empty b.userId ? '-' : b.userId}</div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${b.blockType}</td>
                            <td>
                                <button type="button"
                                        class="adm-link-btn js-open-user-block-editor"
                                        data-block-idx="${b.blockIdx}"
                                        data-template-id="detail-user-${b.blockIdx}"
                                        data-user-idx="${empty b.userIdx ? '' : b.userIdx}"
                                        data-display-name="${fn:escapeXml(empty b.nickname ? b.userId : b.nickname)}"
                                        data-user-id="${fn:escapeXml(empty b.userId ? '' : b.userId)}"
                                        data-user-email="${fn:escapeXml(empty b.userEmail ? '' : b.userEmail)}"
                                        data-block-type="${b.blockType}"
                                        data-blocked-ip="${fn:escapeXml(empty b.blockedIp ? '' : b.blockedIp)}"
                                        data-target-key="${fn:escapeXml(b.blockTargetKey)}"
                                        data-active="${b.active ? 'true' : 'false'}"
                                        data-snapshot-status="${fn:escapeXml(b.snapshotStatus)}"
                                        data-reason="${fn:escapeXml(empty b.reason ? '' : b.reason)}"
                                        data-expires-at="${b.expiresAtInputValue}"
                                        data-blocked-at="${userBlockBlockedAtText}"
                                        data-last-history-at="${userBlockLastHistoryText}"
                                        data-sync-at="${userBlockSyncText}">
                                    <span>${empty b.blockedIp ? '-' : b.blockedIp}</span>
                                    <span style="display:block;font-size:11px;color:#64748b;">${b.blockTargetKey}</span>
                                </button>
                            </td>
                            <td><span class="status-badge ${b.active ? 'ACTIVE' : 'DORMANT'}">${b.snapshotStatus}</span></td>
                            <td style="max-width:260px;white-space:normal;">${empty b.reason ? '-' : b.reason}</td>
                            <td style="font-size:12px;">
                                <div><fmt:formatDate value="${b.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div>
                                <div style="color:#94a3b8;"><spring:message code="admin.context.expiresAt"/>:
                                    <c:choose>
                                        <c:when test="${b.expiresAtDate != null}"><fmt:formatDate value="${b.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when>
                                        <c:otherwise><spring:message code="admin.members.none"/></c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                            <td>
                                <button type="button"
                                        class="adm-row-btn detail js-open-user-block-editor"
                                        data-block-idx="${b.blockIdx}"
                                        data-template-id="detail-user-${b.blockIdx}"
                                        data-user-idx="${empty b.userIdx ? '' : b.userIdx}"
                                        data-display-name="${fn:escapeXml(empty b.nickname ? b.userId : b.nickname)}"
                                        data-user-id="${fn:escapeXml(empty b.userId ? '' : b.userId)}"
                                        data-user-email="${fn:escapeXml(empty b.userEmail ? '' : b.userEmail)}"
                                        data-block-type="${b.blockType}"
                                        data-blocked-ip="${fn:escapeXml(empty b.blockedIp ? '' : b.blockedIp)}"
                                        data-target-key="${fn:escapeXml(b.blockTargetKey)}"
                                        data-active="${b.active ? 'true' : 'false'}"
                                        data-snapshot-status="${fn:escapeXml(b.snapshotStatus)}"
                                        data-reason="${fn:escapeXml(empty b.reason ? '' : b.reason)}"
                                        data-expires-at="${b.expiresAtInputValue}"
                                        data-blocked-at="${userBlockBlockedAtText}"
                                        data-last-history-at="${userBlockLastHistoryText}"
                                        data-sync-at="${userBlockSyncText}"><spring:message code="admin.common.settings"/></button>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-user-${b.blockIdx}"><spring:message code="admin.common.history"/></button>
                                <c:if test="${hasUserBlockAdmin and b.active}">
                                    <button type="button" class="adm-row-btn danger js-release-user-block" data-target-key="${fn:escapeXml(b.blockTargetKey)}"><spring:message code="admin.common.release"/></button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userBlocks}">
                        <tr><td colspan="7" style="text-align:center;padding:32px;color:#64748b;"><spring:message code="admin.common.noData"/></td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="user-blocks">
                <div class="adm-local-page-info js-local-page-info" data-section="user-blocks">0</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="user-blocks"><spring:message code="admin.common.prev"/></button>
                    <span class="js-local-page-state" data-section="user-blocks">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="user-blocks"><spring:message code="admin.common.next"/></button>
                </div>
            </div>
        </div>
    </div>

    <c:forEach var="b" items="${userBlocks}">
        <template id="detail-user-${b.blockIdx}">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.common.member"/></div><div class="detail-value">${empty b.nickname ? '-' : b.nickname} / ${empty b.userId ? '-' : b.userId}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.email"/></div><div class="detail-value">${empty b.userEmail ? '-' : b.userEmail}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.filter.blockType"/></div><div class="detail-value">${b.blockType}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.targetKey"/></div><div class="detail-value">${b.blockTargetKey}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.blockedIp"/></div><div class="detail-value">${empty b.blockedIp ? '-' : b.blockedIp}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.common.status"/></div><div class="detail-value">${b.active ? 'ACTIVE' : 'INACTIVE'} / ${b.snapshotStatus}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.operator"/></div><div class="detail-value">${empty b.blockedByNickname ? '-' : b.blockedByNickname}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.releasedBy"/></div><div class="detail-value">${empty b.releasedByNickname ? '-' : b.releasedByNickname}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.blockedAt"/></div><div class="detail-value"><fmt:formatDate value="${b.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.expiresAt"/></div><div class="detail-value"><c:choose><c:when test="${b.expiresAtDate != null}"><fmt:formatDate value="${b.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise><spring:message code="admin.members.none"/></c:otherwise></c:choose></div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.releasedAt"/></div><div class="detail-value"><c:choose><c:when test="${b.releasedAtDate != null}"><fmt:formatDate value="${b.releasedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.syncedAt"/></div><div class="detail-value"><c:choose><c:when test="${b.syncedAtDate != null}"><fmt:formatDate value="${b.syncedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
            </div>
            <div class="detail-item" style="margin-top:14px;"><div class="detail-label"><spring:message code="admin.blocks.detailReason"/></div><div class="detail-value">${empty b.reason ? '-' : fn:escapeXml(b.reason)}</div></div>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th><spring:message code="admin.common.item"/></th><th><spring:message code="admin.common.value"/></th></tr></thead>
                <tbody>
                <tr><td><spring:message code="admin.context.requestId"/></td><td>${empty b.blockRequestId ? '-' : b.blockRequestId}</td></tr>
                <tr><td><spring:message code="admin.blocks.scope"/></td><td>${empty b.blockScope ? '-' : b.blockScope}</td></tr>
                <tr><td><spring:message code="admin.blocks.ipMatch"/></td><td>${empty b.ipMatchType ? '-' : b.ipMatchType}</td></tr>
                <tr><td><spring:message code="admin.blocks.lastHistory"/></td><td><c:choose><c:when test="${b.lastHistoryAtDate != null}"><fmt:formatDate value="${b.lastHistoryAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></td></tr>
                </tbody>
            </table>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th><spring:message code="admin.common.history"/></th><th><spring:message code="admin.common.status"/></th><th><spring:message code="admin.common.time"/></th><th><spring:message code="admin.common.reason"/></th></tr></thead>
                <tbody>
                <c:forEach var="rel" items="${histories}">
                    <c:if test="${rel.blockTargetKey == b.blockTargetKey}">
                        <tr>
                            <td>${rel.historyKind}</td>
                            <td>${rel.active ? 'ACTIVE' : 'INACTIVE'}</td>
                            <td><fmt:formatDate value="${rel.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></td>
                            <td>${empty rel.controlReason ? (empty rel.reason ? '-' : fn:escapeXml(rel.reason)) : fn:escapeXml(rel.controlReason)}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </template>
    </c:forEach>

    <div class="adm-card js-section-card" data-section="ip-rules" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div>
                <div class="adm-card-title"><spring:message code="admin.blocks.ipRules.title"/></div>
                <div class="adm-card-sub"><spring:message code="admin.blocks.ipRules.sub"/></div>
            </div>
            <div style="display:flex;gap:8px;">
                <c:if test="${hasBlockPolicyAdmin}">
                    <button class="adm-btn adm-btn-ghost" type="button" onclick="openBatchModal()"><spring:message code="admin.blocks.createBatch"/></button>
                </c:if>
                <c:if test="${hasIpBlockAdmin or hasBlockPolicyAdmin}">
                    <button class="adm-btn adm-btn-primary" type="button" onclick="openIpRuleModal()"><spring:message code="admin.blocks.addRule"/></button>
                </c:if>
            </div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="ip-rules">
                        <option value="all"><spring:message code="admin.blocks.filter.allFields"/></option>
                        <option value="target"><spring:message code="admin.blocks.filter.ipOrTarget"/></option>
                        <option value="batch"><spring:message code="admin.context.batch"/></option>
                        <option value="reason"><spring:message code="admin.blocks.filter.reasonMemo"/></option>
                        <option value="priority"><spring:message code="admin.context.priority"/></option>
                        <option value="policy"><spring:message code="admin.blocks.filter.policyControlCategory"/></option>
                        <option value="blockedAt"><spring:message code="admin.blocks.filter.blockedDate"/></option>
                        <option value="expiresAt"><spring:message code="admin.blocks.filter.expireDate"/></option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="ip-rules" placeholder="<spring:message code='admin.blocks.ipRules.searchPlaceholder'/>">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="ip-rules"><spring:message code="admin.common.reset"/></button>
                </div>
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-page-size" data-section="ip-rules">
                        <option value="10"><spring:message code="admin.common.pageSize" arguments="10"/></option>
                        <option value="20" selected><spring:message code="admin.common.pageSize" arguments="20"/></option>
                        <option value="50"><spring:message code="admin.common.pageSize" arguments="50"/></option>
                    </select>
                </div>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr><th><spring:message code="admin.common.target"/></th><th><spring:message code="admin.blocks.actionControl"/></th><th><spring:message code="admin.context.batch"/></th><th><spring:message code="admin.common.status"/></th><th><spring:message code="admin.context.priority"/></th><th><spring:message code="admin.common.reason"/></th><th><spring:message code="admin.common.action"/></th></tr>
                    </thead>
                    <tbody>
                    <c:forEach var="r" items="${ipBlocks}">
                        <fmt:formatDate var="ipRuleBlockedAtText" value="${r.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        <c:set var="ipRuleExpiresText" value=""/>
                        <c:if test="${r.expiresAtDate != null}">
                            <fmt:formatDate var="ipRuleExpiresText" value="${r.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        </c:if>
                        <tr class="js-local-row"
                            data-section="ip-rules"
                            data-search="${fn:toLowerCase(empty r.targetDisplayValue ? r.blockTargetKey : r.targetDisplayValue)} ${fn:toLowerCase(r.blockTargetKey)} ${fn:toLowerCase(empty r.batchName ? '' : r.batchName)} ${fn:toLowerCase(empty r.batchCode ? '' : r.batchCode)} ${fn:toLowerCase(empty r.reason ? '' : r.reason)} ${fn:toLowerCase(empty r.detailMessage ? '' : r.detailMessage)} ${fn:toLowerCase(empty r.blockCategory ? '' : r.blockCategory)} ${fn:toLowerCase(empty r.controlMode ? '' : r.controlMode)} ${fn:toLowerCase(empty r.ruleAction ? '' : r.ruleAction)} ${r.priority}"
                            data-target="${fn:toLowerCase(empty r.targetDisplayValue ? r.blockTargetKey : r.targetDisplayValue)} ${fn:toLowerCase(r.blockTargetKey)}"
                            data-batch="${fn:toLowerCase(empty r.batchName ? '' : r.batchName)} ${fn:toLowerCase(empty r.batchCode ? '' : r.batchCode)}"
                            data-reason="${fn:toLowerCase(empty r.reason ? '' : r.reason)} ${fn:toLowerCase(empty r.detailMessage ? '' : r.detailMessage)}"
                            data-priority="${r.priority}"
                            data-policy="${fn:toLowerCase(empty r.blockCategory ? '' : r.blockCategory)} ${fn:toLowerCase(empty r.controlMode ? '' : r.controlMode)} ${fn:toLowerCase(empty r.ruleAction ? '' : r.ruleAction)} ${fn:toLowerCase(empty r.effectiveStatus ? '' : r.effectiveStatus)}"
                            data-blocked-at="${fn:toLowerCase(ipRuleBlockedAtText)}"
                            data-expires-at="${fn:toLowerCase(empty ipRuleExpiresText ? '' : ipRuleExpiresText)}">
                            <td>
                                <button type="button"
                                        class="adm-link-btn js-open-ip-rule-editor"
                                        data-id="${r.ipBlocklistIdx}"
                                        data-template-id="detail-ip-${r.ipBlocklistIdx}"
                                        data-target-display="${fn:escapeXml(empty r.targetDisplayValue ? r.blockTargetKey : r.targetDisplayValue)}"
                                        data-target-key="${fn:escapeXml(r.blockTargetKey)}"
                                        data-rule-action="${r.ruleAction}"
                                        data-control-mode="${r.controlMode}"
                                        data-block-category="${r.blockCategory}"
                                        data-priority="${r.priority}"
                                        data-reason="${fn:escapeXml(empty r.reason ? '' : r.reason)}"
                                        data-detail-message="${fn:escapeXml(empty r.detailMessage ? '' : r.detailMessage)}"
                                        data-expires-at="${r.expiresAtInputValue}"
                                        data-effective-status-label="${fn:escapeXml(r.effectiveStatusLabel)}"
                                        data-final-state-label="${fn:escapeXml(r.finalStateLabel)}"
                                        data-rule-state-label="${fn:escapeXml(r.ruleStateLabel)}"
                                        data-batch-status-label="${fn:escapeXml(r.batchStatusLabel)}"
                                        data-batch-name="${fn:escapeXml(empty r.batchName ? adminBlocksIndividualRuleLabel : r.batchName)}"
                                        data-batch-code="${fn:escapeXml(empty r.batchCode ? '' : r.batchCode)}"
                                        data-batch-id="${empty r.ipBlockBatchIdx ? '' : r.ipBlockBatchIdx}"
                                        data-blocked-at="${ipRuleBlockedAtText}"
                                        data-expires-display="${fn:escapeXml(empty ipRuleExpiresText ? adminBlocksNoneLabel : ipRuleExpiresText)}"
                                        data-active="${r.active ? 'true' : 'false'}">
                                    <span style="font-weight:700;color:#e2e8f0;">${empty r.targetDisplayValue ? r.blockTargetKey : r.targetDisplayValue}</span>
                                    <span style="display:block;font-size:12px;color:#94a3b8;">${r.blockTargetKey}</span>
                                    <span style="display:block;font-size:11px;color:#64748b;">${r.matchType}</span>
                                </button>
                            </td>
                            <td>
                                <div><span class="status-badge ${r.ruleAction == 'ALLOW' ? 'ACTIVE' : 'DORMANT'}">${r.ruleActionLabel}</span></div>
                                <div style="font-size:12px;color:#94a3b8;">${r.controlModeLabel}</div>
                                <div style="font-size:11px;color:#64748b;">${r.blockCategory}</div>
                            </td>
                            <td>
                                <div>${empty r.batchName ? adminBlocksIndividualRuleLabel : r.batchName}</div>
                                <div style="font-size:12px;color:#94a3b8;">${empty r.batchCode ? r.batchStatusLabel : fn:escapeXml(r.batchCode)}</div>
                                <div style="font-size:11px;color:#64748b;">${r.batchStatusLabel}</div>
                            </td>
                            <td>
                                <div><span class="status-badge ${r.effectiveStatusBadgeClass}">${r.finalStateLabel}</span></div>
                                <div style="font-size:12px;color:#94a3b8;">${r.effectiveStatusLabel}</div>
                                <div style="font-size:11px;color:#64748b;">${r.ruleStateLabel} / ${r.batchStatusLabel}</div>
                            </td>
                            <td>
                                <div>${r.priority}</div>
                                <div style="font-size:11px;color:#64748b;">${empty r.ruleOriginType ? '-' : r.ruleOriginType}</div>
                            </td>
                            <td style="max-width:280px;white-space:normal;">
                                <div>${empty r.reason ? '-' : r.reason}</div>
                                <div style="font-size:11px;color:#64748b;">${empty r.effectiveStatusReason ? '-' : r.effectiveStatusReason}</div>
                            </td>
                            <td>
                                <button type="button"
                                        class="adm-row-btn detail js-open-ip-rule-editor"
                                        data-id="${r.ipBlocklistIdx}"
                                        data-template-id="detail-ip-${r.ipBlocklistIdx}"
                                        data-target-display="${fn:escapeXml(empty r.targetDisplayValue ? r.blockTargetKey : r.targetDisplayValue)}"
                                        data-target-key="${fn:escapeXml(r.blockTargetKey)}"
                                        data-rule-action="${r.ruleAction}"
                                        data-control-mode="${r.controlMode}"
                                        data-block-category="${r.blockCategory}"
                                        data-priority="${r.priority}"
                                        data-reason="${fn:escapeXml(empty r.reason ? '' : r.reason)}"
                                        data-detail-message="${fn:escapeXml(empty r.detailMessage ? '' : r.detailMessage)}"
                                        data-expires-at="${r.expiresAtInputValue}"
                                        data-effective-status-label="${fn:escapeXml(r.effectiveStatusLabel)}"
                                        data-final-state-label="${fn:escapeXml(r.finalStateLabel)}"
                                        data-rule-state-label="${fn:escapeXml(r.ruleStateLabel)}"
                                        data-batch-status-label="${fn:escapeXml(r.batchStatusLabel)}"
                                        data-batch-name="${fn:escapeXml(empty r.batchName ? adminBlocksIndividualRuleLabel : r.batchName)}"
                                        data-batch-code="${fn:escapeXml(empty r.batchCode ? '' : r.batchCode)}"
                                        data-batch-id="${empty r.ipBlockBatchIdx ? '' : r.ipBlockBatchIdx}"
                                        data-blocked-at="${ipRuleBlockedAtText}"
                                        data-expires-display="${fn:escapeXml(empty ipRuleExpiresText ? adminBlocksNoneLabel : ipRuleExpiresText)}"
                                        data-active="${r.active ? 'true' : 'false'}">${adminBlocksSettingsLabel}</button>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-ip-${r.ipBlocklistIdx}">${adminBlocksHistoryLabel}</button>
                                <c:if test="${hasIpBlockAdmin or hasBlockPolicyAdmin}">
                                    <button type="button" class="adm-row-btn ${r.active ? 'danger' : 'detail'} js-toggle-ip-rule" data-id="${r.ipBlocklistIdx}" data-active="${r.active ? 'false' : 'true'}">${r.active ? adminBlocksRuleOffLabel : adminBlocksRuleOnLabel}</button>
                                    <c:if test="${r.ipBlockBatchIdx != null and r.controlMode == 'MANUAL_OVERRIDE'}">
                                        <button type="button" class="adm-row-btn detail js-return-to-batch" data-id="${r.ipBlocklistIdx}">${adminBlocksReturnToBatchLabel}</button>
                                    </c:if>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty ipBlocks}">
                        <tr><td colspan="7" style="text-align:center;padding:32px;color:#64748b;"><spring:message code="admin.common.noData"/></td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="ip-rules">
                <div class="adm-local-page-info js-local-page-info" data-section="ip-rules">0</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="ip-rules"><spring:message code="admin.common.prev"/></button>
                    <span class="js-local-page-state" data-section="ip-rules">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="ip-rules"><spring:message code="admin.common.next"/></button>
                </div>
            </div>
        </div>
    </div>

    <c:forEach var="r" items="${ipBlocks}">
        <template id="detail-ip-${r.ipBlocklistIdx}">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.targetKey"/></div><div class="detail-value">${r.blockTargetKey}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.displayValue"/></div><div class="detail-value">${empty r.targetDisplayValue ? '-' : r.targetDisplayValue}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.ruleAction"/></div><div class="detail-value">${r.ruleActionLabel}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.controlMode"/></div><div class="detail-value">${r.controlModeLabel}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.ruleState"/></div><div class="detail-value">${r.ruleStateLabel}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.effectiveState"/></div><div class="detail-value">${r.finalStateLabel} / ${r.effectiveStatusLabel}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.effectiveStatusReason"/></div><div class="detail-value">${empty r.effectiveStatusReason ? '-' : fn:escapeXml(r.effectiveStatusReason)}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.syncedAt"/></div><div class="detail-value"><c:choose><c:when test="${r.effectiveSyncedAtDate != null}"><fmt:formatDate value="${r.effectiveSyncedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose> / ${empty r.effectiveSyncedBySource ? '-' : r.effectiveSyncedBySource}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.matchType"/></div><div class="detail-value">${r.matchType}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.cidrRange"/></div><div class="detail-value">${empty r.cidrNotation ? '-' : r.cidrNotation} <c:if test="${not empty r.rangeStartIp}">${r.rangeStartIp} ~ ${r.rangeEndIp}</c:if></div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.countryAsn"/></div><div class="detail-value">${empty r.countryCode ? '-' : r.countryCode} / ${empty r.asn ? '-' : r.asn}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.batch"/></div><div class="detail-value">${empty r.batchName ? adminBlocksIndividualRuleLabel : r.batchName} <c:if test="${not empty r.batchCode}">(${r.batchCode})</c:if> / ${r.batchStatusLabel}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.priority"/></div><div class="detail-value">${r.priority}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.blockedAt"/></div><div class="detail-value"><fmt:formatDate value="${r.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.expiresAt"/></div><div class="detail-value"><c:choose><c:when test="${r.expiresAtDate != null}"><fmt:formatDate value="${r.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>${adminBlocksNoneLabel}</c:otherwise></c:choose></div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.manualOverride"/></div><div class="detail-value">${empty r.manualOverrideReason ? '-' : fn:escapeXml(r.manualOverrideReason)} <c:if test="${r.manualOverrideAtDate != null}">/ <fmt:formatDate value="${r.manualOverrideAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:if></div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.lastControl"/></div><div class="detail-value">${empty r.lastControlAction ? '-' : r.lastControlAction} <c:if test="${r.lastControlAtDate != null}">/ <fmt:formatDate value="${r.lastControlAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:if></div></div>
            </div>
            <div class="detail-item" style="margin-top:14px;"><div class="detail-label"><spring:message code="admin.blocks.policyReason"/></div><div class="detail-value">${empty r.reason ? '-' : fn:escapeXml(r.reason)}</div></div>
            <div class="detail-item" style="margin-top:14px;"><div class="detail-label"><spring:message code="admin.context.detailMemo"/></div><div class="detail-value">${empty r.detailMessage ? '-' : fn:escapeXml(r.detailMessage)}</div></div>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th><spring:message code="admin.common.item"/></th><th><spring:message code="admin.common.value"/></th></tr></thead>
                <tbody>
                <tr><td><spring:message code="admin.context.requestId"/></td><td>${empty r.blockRequestId ? '-' : r.blockRequestId}</td></tr>
                <tr><td><spring:message code="admin.blocks.autoBlock"/></td><td>${r.autoBlock ? 'Y' : 'N'} / ${empty r.autoBlockSource ? '-' : r.autoBlockSource}</td></tr>
                <tr><td><spring:message code="admin.blocks.riskScore"/></td><td>${empty r.riskScore ? '-' : r.riskScore}</td></tr>
                <tr><td><spring:message code="admin.blocks.userBinding"/></td><td>${empty r.userIdx ? '-' : r.userIdx} / ${empty r.blockType ? '-' : r.blockType}</td></tr>
                </tbody>
            </table>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th><spring:message code="admin.common.relatedHistory"/></th><th><spring:message code="admin.blocks.beforeAfterState"/></th><th><spring:message code="admin.common.time"/></th><th><spring:message code="admin.blocks.description"/></th></tr></thead>
                <tbody>
                <c:forEach var="rel" items="${histories}">
                    <c:if test="${rel.blockTargetKey == r.blockTargetKey}">
                        <tr>
                            <td>${rel.historyKind}</td>
                            <td>${empty rel.beforeEffectiveStatus ? '-' : rel.beforeEffectiveStatus} → ${empty rel.afterEffectiveStatus ? '-' : rel.afterEffectiveStatus}</td>
                            <td><fmt:formatDate value="${rel.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></td>
                            <td>${empty rel.controlReason ? (empty rel.reason ? '-' : fn:escapeXml(rel.reason)) : fn:escapeXml(rel.controlReason)}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </template>
    </c:forEach>

    <div class="adm-card js-section-card" data-section="batches" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.blocks.section.batches"/></div>
            <div class="adm-card-sub"><spring:message code="admin.blocks.batches.sub"/></div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="batches">
                        <option value="all"><spring:message code="admin.blocks.filter.allFields"/></option>
                        <option value="batch"><spring:message code="admin.blocks.filter.batchNameCode"/></option>
                        <option value="source"><spring:message code="admin.blocks.filter.source"/></option>
                        <option value="description"><spring:message code="admin.blocks.description"/></option>
                        <option value="policy"><spring:message code="admin.blocks.filter.basePolicy"/></option>
                        <option value="status"><spring:message code="admin.common.status"/></option>
                        <option value="updatedAt"><spring:message code="admin.blocks.filter.recentUpdated"/></option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="batches" placeholder="<spring:message code='admin.blocks.batches.searchPlaceholder'/>">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="batches"><spring:message code="admin.common.reset"/></button>
                </div>
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-page-size" data-section="batches">
                        <option value="10"><spring:message code="admin.common.pageSize" arguments="10"/></option>
                        <option value="20" selected><spring:message code="admin.common.pageSize" arguments="20"/></option>
                        <option value="50"><spring:message code="admin.common.pageSize" arguments="50"/></option>
                    </select>
                </div>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead><tr><th><spring:message code="admin.blocks.batch"/></th><th><spring:message code="admin.blocks.basePolicy"/></th><th><spring:message code="admin.blocks.currentState"/></th><th><spring:message code="admin.blocks.ruleStats"/></th><th><spring:message code="admin.blocks.description"/></th><th><spring:message code="admin.common.action"/></th></tr></thead>
                    <tbody>
                    <c:forEach var="b" items="${batches}">
                        <fmt:formatDate var="batchCreatedAtText" value="${b.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        <fmt:formatDate var="batchUpdatedAtText" value="${b.updatedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        <tr class="js-local-row"
                            data-section="batches"
                            data-search="${fn:toLowerCase(b.batchName)} ${fn:toLowerCase(b.batchCode)} ${fn:toLowerCase(empty b.sourceType ? '' : b.sourceType)} ${fn:toLowerCase(empty b.sourceName ? '' : b.sourceName)} ${fn:toLowerCase(empty b.description ? '' : b.description)} ${fn:toLowerCase(empty b.batchRuleAction ? '' : b.batchRuleAction)} ${fn:toLowerCase(empty b.defaultDisableStrategy ? '' : b.defaultDisableStrategy)} ${fn:toLowerCase(empty b.defaultEnableStrategy ? '' : b.defaultEnableStrategy)} ${fn:toLowerCase(b.activeLabel)} ${fn:toLowerCase(batchUpdatedAtText)}"
                            data-batch="${fn:toLowerCase(b.batchName)} ${fn:toLowerCase(b.batchCode)}"
                            data-source="${fn:toLowerCase(empty b.sourceType ? '' : b.sourceType)} ${fn:toLowerCase(empty b.sourceName ? '' : b.sourceName)}"
                            data-description="${fn:toLowerCase(empty b.description ? '' : b.description)}"
                            data-policy="${fn:toLowerCase(empty b.batchRuleAction ? '' : b.batchRuleAction)} ${b.defaultRulePriority} ${fn:toLowerCase(empty b.defaultDisableStrategy ? '' : b.defaultDisableStrategy)} ${fn:toLowerCase(empty b.defaultEnableStrategy ? '' : b.defaultEnableStrategy)}"
                            data-status="${fn:toLowerCase(b.activeLabel)}"
                            data-updated-at="${fn:toLowerCase(batchUpdatedAtText)}">
                            <td>
                                <button type="button"
                                        class="adm-link-btn js-open-batch-editor"
                                        data-batch-id="${b.ipBlockBatchIdx}"
                                        data-batch-code="${fn:escapeXml(b.batchCode)}"
                                        data-batch-name="${fn:escapeXml(b.batchName)}"
                                        data-source-type="${fn:escapeXml(b.sourceType)}"
                                        data-source-name="${fn:escapeXml(empty b.sourceName ? '' : b.sourceName)}"
                                        data-batch-rule-action="${fn:escapeXml(b.batchRuleAction)}"
                                        data-default-priority="${b.defaultRulePriority}"
                                        data-default-disable-strategy="${fn:escapeXml(b.defaultDisableStrategy)}"
                                        data-default-enable-strategy="${fn:escapeXml(b.defaultEnableStrategy)}"
                                        data-description="${fn:escapeXml(empty b.description ? '' : b.description)}"
                                        data-status-label="${fn:escapeXml(b.activeLabel)}"
                                        data-created-at="${batchCreatedAtText}"
                                        data-updated-at="${batchUpdatedAtText}"
                                        data-total-rules="${b.totalRuleCount}"
                                        data-active-rules="${b.activeRuleCount}"
                                        data-effective-rules="${b.effectiveRuleCount}"
                                        data-expired-rules="${b.expiredRuleCount}">
                                    <span style="font-weight:700;color:#e2e8f0;">${b.batchName}</span>
                                    <span style="display:block;font-size:12px;color:#94a3b8;">${b.batchCode}</span>
                                    <span style="display:block;font-size:11px;color:#64748b;">${b.sourceType} / ${empty b.sourceName ? '-' : b.sourceName}</span>
                                </button>
                            </td>
                            <td>
                                <div>${b.batchRuleActionLabel}</div>
                                <div style="font-size:12px;color:#94a3b8;"><spring:message code="admin.blocks.defaultPriority"/> ${b.defaultRulePriority}</div>
                                <div style="font-size:11px;color:#64748b;">OFF: ${b.defaultDisableStrategyLabel}</div>
                                <div style="font-size:11px;color:#64748b;">ON: ${b.defaultEnableStrategyLabel}</div>
                            </td>
                            <td>
                                <div><span class="status-badge ${b.active ? 'ACTIVE' : 'DORMANT'}">${b.activeLabel}</span></div>
                                <div style="font-size:12px;color:#94a3b8;"><spring:message code="admin.context.ruleAction.block"/> ${b.blockRuleCount} / <spring:message code="admin.context.ruleAction.allow"/> ${b.allowRuleCount}</div>
                            </td>
                            <td>
                                <div><spring:message code="admin.common.totalCountFormat" arguments="${b.totalRuleCount}"/> / <spring:message code="admin.blocks.ruleOn"/> ${b.activeRuleCount}</div>
                                <div style="font-size:11px;color:#64748b;"><spring:message code="admin.blocks.control.batch"/> ${b.batchManagedRuleCount} / <spring:message code="admin.blocks.control.override"/> ${b.manualOverrideRuleCount}</div>
                                <div style="font-size:11px;color:#64748b;"><spring:message code="admin.blocks.effectiveState"/> ${b.effectiveRuleCount} / <spring:message code="admin.blocks.effective.expired"/> ${b.expiredRuleCount}</div>
                            </td>
                            <td style="max-width:260px;white-space:normal;">${empty b.description ? '-' : b.description}</td>
                            <td>
                                <button type="button"
                                        class="adm-row-btn detail js-open-batch-editor"
                                        data-batch-id="${b.ipBlockBatchIdx}"
                                        data-batch-code="${fn:escapeXml(b.batchCode)}"
                                        data-batch-name="${fn:escapeXml(b.batchName)}"
                                        data-source-type="${fn:escapeXml(b.sourceType)}"
                                        data-source-name="${fn:escapeXml(empty b.sourceName ? '' : b.sourceName)}"
                                        data-batch-rule-action="${fn:escapeXml(b.batchRuleAction)}"
                                        data-default-priority="${b.defaultRulePriority}"
                                        data-default-disable-strategy="${fn:escapeXml(b.defaultDisableStrategy)}"
                                        data-default-enable-strategy="${fn:escapeXml(b.defaultEnableStrategy)}"
                                        data-description="${fn:escapeXml(empty b.description ? '' : b.description)}"
                                        data-status-label="${fn:escapeXml(b.activeLabel)}"
                                        data-created-at="${batchCreatedAtText}"
                                        data-updated-at="${batchUpdatedAtText}"
                                        data-total-rules="${b.totalRuleCount}"
                                        data-active-rules="${b.activeRuleCount}"
                                        data-effective-rules="${b.effectiveRuleCount}"
                                        data-expired-rules="${b.expiredRuleCount}"><spring:message code="admin.common.settings"/></button>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-batch-${b.ipBlockBatchIdx}"><spring:message code="admin.common.detail"/></button>
                                <c:if test="${hasBlockPolicyAdmin}">
                                    <button type="button"
                                            class="adm-row-btn ${b.active ? 'danger' : 'detail'} js-open-batch-toggle"
                                            data-id="${b.ipBlockBatchIdx}"
                                            data-active="${b.active ? 'false' : 'true'}"
                                            data-batch-name="${fn:escapeXml(b.batchName)}"
                                            data-active-rules="${b.activeRuleCount}"
                                            data-effective-rules="${b.effectiveRuleCount}"
                                            data-default-disable-strategy="${b.defaultDisableStrategy}"
                                            data-default-enable-strategy="${b.defaultEnableStrategy}">
                                        <c:choose>
                                            <c:when test="${b.active}"><spring:message code="admin.blocks.batchDeactivate"/></c:when>
                                            <c:otherwise><spring:message code="admin.blocks.batchReactivate"/></c:otherwise>
                                        </c:choose>
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty batches}">
                        <tr><td colspan="6" style="text-align:center;padding:32px;color:#64748b;"><spring:message code="admin.common.noData"/></td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="batches">
                <div class="adm-local-page-info js-local-page-info" data-section="batches">0</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="batches"><spring:message code="admin.common.prev"/></button>
                    <span class="js-local-page-state" data-section="batches">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="batches"><spring:message code="admin.common.next"/></button>
                </div>
            </div>
        </div>
    </div>

    <c:forEach var="b" items="${batches}">
        <template id="detail-batch-${b.ipBlockBatchIdx}">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.batchName"/></div><div class="detail-value">${b.batchName}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.batchCode"/></div><div class="detail-value">${b.batchCode}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.common.status"/></div><div class="detail-value">${b.activeLabel}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.source"/></div><div class="detail-value">${b.sourceType} / ${empty b.sourceName ? '-' : b.sourceName}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.baseAction"/></div><div class="detail-value">${b.batchRuleActionLabel} / <spring:message code="admin.blocks.defaultPriority"/> ${b.defaultRulePriority}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.baseStrategy"/></div><div class="detail-value">OFF: ${b.defaultDisableStrategyLabel} / ON: ${b.defaultEnableStrategyLabel}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.ruleCount"/></div><div class="detail-value"><spring:message code="admin.common.totalCountFormat" arguments="${b.totalRuleCount}"/> / <spring:message code="admin.blocks.ruleOn"/> ${b.activeRuleCount}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.controlComposition"/></div><div class="detail-value"><spring:message code="admin.blocks.control.batch"/> ${b.batchManagedRuleCount}, <spring:message code="admin.blocks.control.override"/> ${b.manualOverrideRuleCount}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.effectiveState"/></div><div class="detail-value">${b.effectiveRuleCount}<spring:message code="admin.common.countSuffix"/> <spring:message code="admin.blocks.effective.effective"/> / ${b.expiredRuleCount}<spring:message code="admin.common.countSuffix"/> <spring:message code="admin.blocks.effective.expired"/></div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.actionComposition"/></div><div class="detail-value"><spring:message code="admin.context.ruleAction.block"/> ${b.blockRuleCount} / <spring:message code="admin.context.ruleAction.allow"/> ${b.allowRuleCount}</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.createdAt"/></div><div class="detail-value">${empty b.createdByNickname ? '-' : b.createdByNickname} / <fmt:formatDate value="${b.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.updatedAt"/></div><div class="detail-value">${empty b.updatedByNickname ? '-' : b.updatedByNickname} / <fmt:formatDate value="${b.updatedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
            </div>
            <div class="detail-item" style="margin-top:14px;"><div class="detail-label"><spring:message code="admin.blocks.detailDescription"/></div><div class="detail-value">${empty b.description ? '-' : fn:escapeXml(b.description)}</div></div>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th><spring:message code="admin.blocks.recentBatchOperation"/></th><th><spring:message code="admin.blocks.option"/></th><th><spring:message code="admin.blocks.impact"/></th><th><spring:message code="admin.common.time"/></th></tr></thead>
                <tbody>
                <c:forEach var="op" items="${batchOperations}">
                    <c:if test="${op.ipBlockBatchIdx == b.ipBlockBatchIdx}">
                        <tr>
                            <td>${op.operationTypeLabel}</td>
                            <td>${op.operationOptionLabel}</td>
                            <td>${op.affectedRuleCount} / ${op.requestedRuleCount}</td>
                            <td><fmt:formatDate value="${op.requestedAtDate}" pattern="yyyy.MM.dd HH:mm"/></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th><spring:message code="admin.blocks.connectedRule"/></th><th><spring:message code="admin.common.actionLabel"/></th><th><spring:message code="admin.blocks.controlMode"/></th><th><spring:message code="admin.common.status"/></th></tr></thead>
                <tbody>
                <c:forEach var="rule" items="${ipBlocks}">
                    <c:if test="${rule.ipBlockBatchIdx == b.ipBlockBatchIdx}">
                        <tr>
                            <td>${rule.blockTargetKey}</td>
                            <td>${rule.ruleActionLabel}</td>
                            <td>${rule.controlModeLabel}</td>
                            <td>${rule.finalStateLabel} / ${rule.effectiveStatusLabel}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </template>
    </c:forEach>

    <div class="adm-card js-section-card" data-section="histories">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.blocks.section.histories"/></div>
            <div class="adm-card-sub"><spring:message code="admin.blocks.histories.sub"/></div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="histories">
                        <option value="all"><spring:message code="admin.blocks.filter.allFields"/></option>
                        <option value="target"><spring:message code="admin.common.target"/></option>
                        <option value="member"><spring:message code="admin.common.member"/></option>
                        <option value="change"><spring:message code="admin.blocks.changeKind"/></option>
                        <option value="reason"><spring:message code="admin.blocks.filter.reasonDescription"/></option>
                        <option value="batch"><spring:message code="admin.context.batch"/></option>
                        <option value="blockedAt"><spring:message code="admin.blocks.filter.blockedDate"/></option>
                        <option value="expiresAt"><spring:message code="admin.blocks.filter.expireDate"/></option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="histories" placeholder="<spring:message code='admin.blocks.histories.searchPlaceholder'/>">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="histories"><spring:message code="admin.common.reset"/></button>
                </div>
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-page-size" data-section="histories">
                        <option value="10"><spring:message code="admin.common.pageSize" arguments="10"/></option>
                        <option value="20" selected><spring:message code="admin.common.pageSize" arguments="20"/></option>
                        <option value="50"><spring:message code="admin.common.pageSize" arguments="50"/></option>
                    </select>
                </div>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead><tr><th><spring:message code="admin.common.time"/></th><th><spring:message code="admin.common.target"/></th><th><spring:message code="admin.common.actionLabel"/></th><th><spring:message code="admin.blocks.changeKind"/></th><th><spring:message code="admin.blocks.result"/></th><th><spring:message code="admin.common.reason"/></th><th><spring:message code="admin.common.action"/></th></tr></thead>
                    <tbody>
                    <c:forEach var="h" items="${histories}">
                        <c:set var="historyCurrentType" value="IP_RULE"/>
                        <c:if test="${h.blockScope == 'USER_ACTION'}">
                            <c:set var="historyCurrentType" value="USER_BLOCK"/>
                        </c:if>
                        <c:if test="${not empty h.batchOperationIdx and not empty h.ipBlockBatchIdx}">
                            <c:set var="historyCurrentType" value="BATCH"/>
                        </c:if>
                        <fmt:formatDate var="historyBlockedAtText" value="${h.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        <c:set var="historyExpiresText" value=""/>
                        <c:if test="${h.expiresAtDate != null}">
                            <fmt:formatDate var="historyExpiresText" value="${h.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        </c:if>
                        <tr class="js-local-row"
                            data-section="histories"
                            data-search="${fn:toLowerCase(h.blockTargetKey)} ${fn:toLowerCase(empty h.nickname ? '' : h.nickname)} ${fn:toLowerCase(empty h.userId ? '' : h.userId)} ${fn:toLowerCase(empty h.historyKind ? '' : h.historyKind)} ${fn:toLowerCase(empty h.controlReason ? '' : h.controlReason)} ${fn:toLowerCase(empty h.reason ? '' : h.reason)} ${fn:toLowerCase(empty h.batchName ? '' : h.batchName)} ${fn:toLowerCase(empty h.batchCode ? '' : h.batchCode)} ${fn:toLowerCase(historyBlockedAtText)} ${fn:toLowerCase(empty historyExpiresText ? '' : historyExpiresText)}"
                            data-target="${fn:toLowerCase(h.blockTargetKey)} ${fn:toLowerCase(empty h.blockedIp ? '' : h.blockedIp)}"
                            data-member="${fn:toLowerCase(empty h.nickname ? '' : h.nickname)} ${fn:toLowerCase(empty h.userId ? '' : h.userId)}"
                            data-change="${fn:toLowerCase(empty h.historyKind ? '' : h.historyKind)} ${fn:toLowerCase(empty h.controlMode ? '' : h.controlMode)} ${fn:toLowerCase(empty h.operationSource ? '' : h.operationSource)}"
                            data-reason="${fn:toLowerCase(empty h.controlReason ? '' : h.controlReason)} ${fn:toLowerCase(empty h.reason ? '' : h.reason)}"
                            data-batch="${fn:toLowerCase(empty h.batchName ? '' : h.batchName)} ${fn:toLowerCase(empty h.batchCode ? '' : h.batchCode)}"
                            data-blocked-at="${fn:toLowerCase(historyBlockedAtText)}"
                            data-expires-at="${fn:toLowerCase(empty historyExpiresText ? '' : historyExpiresText)}">
                            <td><fmt:formatDate value="${h.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></td>
                            <td>
                                <div style="font-weight:700;color:#e2e8f0;">${h.blockTargetKey}</div>
                                <div style="font-size:12px;color:#94a3b8;">${empty h.nickname ? '-' : h.nickname}</div>
                            </td>
                            <td>
                                <div>${empty h.ruleAction ? '-' : h.ruleAction}</div>
                                <div style="font-size:12px;color:#94a3b8;">${empty h.blockType ? '-' : h.blockType}</div>
                            </td>
                            <td>
                                <div>${h.historyKind}</div>
                                <div style="font-size:12px;color:#94a3b8;">${empty h.controlMode ? '-' : h.controlMode} / ${empty h.operationSource ? '-' : h.operationSource}</div>
                            </td>
                            <td>
                                <div>${empty h.effectiveResult ? '-' : h.effectiveResult}</div>
                                <div style="font-size:11px;color:#64748b;">${empty h.beforeEffectiveStatus ? '-' : h.beforeEffectiveStatus} → ${empty h.afterEffectiveStatus ? '-' : h.afterEffectiveStatus}</div>
                            </td>
                            <td style="max-width:320px;white-space:normal;">${empty h.controlReason ? (empty h.reason ? '-' : h.reason) : h.controlReason}</td>
                            <td>
                                <button type="button"
                                        class="adm-row-btn detail js-open-history-current"
                                        data-history-id="${h.blockIdx}"
                                        data-current-type="${historyCurrentType}"
                                        data-target-key="${fn:escapeXml(h.blockTargetKey)}"
                                        data-rule-action="${fn:escapeXml(empty h.ruleAction ? '' : h.ruleAction)}"
                                        data-batch-id="${empty h.ipBlockBatchIdx ? '' : h.ipBlockBatchIdx}"
                                        data-template-id="detail-history-${h.blockIdx}"><spring:message code="admin.blocks.currentSetting"/></button>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-history-${h.blockIdx}"><spring:message code="admin.common.detail"/></button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}">
                        <tr><td colspan="7" style="text-align:center;padding:32px;color:#64748b;"><spring:message code="admin.common.noData"/></td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="histories">
                <div class="adm-local-page-info js-local-page-info" data-section="histories">0</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="histories"><spring:message code="admin.common.prev"/></button>
                    <span class="js-local-page-state" data-section="histories">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="histories"><spring:message code="admin.common.next"/></button>
                </div>
            </div>
        </div>
    </div>
</div>

<c:forEach var="h" items="${histories}">
    <template id="detail-history-${h.blockIdx}">
        <div class="detail-grid">
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.targetKey"/></div><div class="detail-value">${h.blockTargetKey}</div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.historyKind"/></div><div class="detail-value">${h.historyKind}</div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.ruleAction"/></div><div class="detail-value">${empty h.ruleAction ? '-' : h.ruleAction}</div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.controlMode"/></div><div class="detail-value">${empty h.controlMode ? '-' : h.controlMode}</div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.common.member"/></div><div class="detail-value">${empty h.nickname ? '-' : h.nickname} / ${empty h.userId ? '-' : h.userId}</div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.filter.blockType"/></div><div class="detail-value">${h.blockType}</div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.blockedIp"/></div><div class="detail-value">${empty h.blockedIp ? '-' : h.blockedIp}</div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.sourceMatch"/></div><div class="detail-value">${h.blockScope} / ${empty h.ipMatchType ? '-' : h.ipMatchType}</div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.batch"/></div><div class="detail-value">${empty h.batchName ? '-' : h.batchName} <c:if test="${not empty h.batchCode}">(${h.batchCode})</c:if></div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.batchOperation"/></div><div class="detail-value">${empty h.batchOperationIdx ? '-' : h.batchOperationIdx}</div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.blockedAt"/></div><div class="detail-value"><fmt:formatDate value="${h.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.expiresAt"/></div><div class="detail-value"><c:choose><c:when test="${h.expiresAtDate != null}"><fmt:formatDate value="${h.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>${adminBlocksNoneLabel}</c:otherwise></c:choose></div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.releasedAt"/></div><div class="detail-value"><c:choose><c:when test="${h.releasedAtDate != null}"><fmt:formatDate value="${h.releasedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
            <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.syncedAt"/></div><div class="detail-value"><c:choose><c:when test="${h.listSyncedAtDate != null}"><fmt:formatDate value="${h.listSyncedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
        </div>
        <div class="detail-item" style="margin-top:14px;"><div class="detail-label"><spring:message code="admin.blocks.changeDescription"/></div><div class="detail-value">${empty h.controlReason ? '-' : fn:escapeXml(h.controlReason)}</div></div>
        <table class="history-table" style="margin-top:14px;">
            <thead><tr><th><spring:message code="admin.blocks.snapshot"/></th><th><spring:message code="admin.context.before"/></th><th><spring:message code="admin.context.after"/></th></tr></thead>
            <tbody>
            <tr><td><spring:message code="admin.blocks.ruleState"/></td><td>${empty h.beforeRuleIsActive ? '-' : (h.beforeRuleIsActive ? 'ON' : 'OFF')}</td><td>${empty h.afterRuleIsActive ? '-' : (h.afterRuleIsActive ? 'ON' : 'OFF')}</td></tr>
            <tr><td><spring:message code="admin.blocks.batchState"/></td><td>${empty h.beforeBatchIsActive ? '-' : (h.beforeBatchIsActive ? 'ON' : 'OFF')}</td><td>${empty h.afterBatchIsActive ? '-' : (h.afterBatchIsActive ? 'ON' : 'OFF')}</td></tr>
            <tr><td><spring:message code="admin.blocks.effectiveState"/></td><td>${empty h.beforeEffectiveStatus ? '-' : h.beforeEffectiveStatus}</td><td>${empty h.afterEffectiveStatus ? '-' : h.afterEffectiveStatus}</td></tr>
            <tr><td><spring:message code="admin.blocks.resultCode"/></td><td colspan="2">${empty h.effectiveResult ? '-' : h.effectiveResult}</td></tr>
            </tbody>
        </table>
    </template>
</c:forEach>

<div class="adm-modal-overlay" id="blockDetailModal">
    <div class="adm-modal" style="max-width:860px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockDetailTitle"><spring:message code="admin.blocks.detailTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('blockDetailModal')">✕</button>
        </div>
        <div class="adm-modal-body" id="blockDetailBody"></div>
    </div>
</div>

<div class="adm-modal-overlay" id="memberDetailModal">
    <div class="adm-modal" style="max-width:860px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="memberDetailTitle"><spring:message code="admin.context.memberTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('memberDetailModal')">✕</button>
        </div>
        <div class="adm-modal-body" id="memberDetailBody">
            <div style="text-align:center;padding:40px;color:#64748b;"><spring:message code="admin.common.loading"/></div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('memberDetailModal')"><spring:message code="admin.common.close"/></button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="userBlockEditModal">
    <div class="adm-modal" style="max-width:720px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="userBlockEditTitle"><spring:message code="admin.blocks.userBlocks.editTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('userBlockEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="userBlockEditId">
            <input type="hidden" id="userBlockEditTemplateId">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.common.member"/></div><div class="detail-value" id="userBlockEditMember">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.targetKey"/></div><div class="detail-value" id="userBlockEditTarget">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.filter.blockType"/></div><div class="detail-value" id="userBlockEditType">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.common.status"/></div><div class="detail-value" id="userBlockEditStatus">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.blockedAt"/></div><div class="detail-value" id="userBlockEditBlockedAt">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.syncedAt"/></div><div class="detail-value" id="userBlockEditSyncAt">-</div></div>
            </div>
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;margin-top:18px;">
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.common.status"/></label>
                    <select id="userBlockEditActive" class="adm-select">
                        <option value="true"><spring:message code="admin.blocks.keepBlocked"/></option>
                        <option value="false"><spring:message code="admin.blocks.releaseBlock"/></option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.context.expiresAt"/></label>
                    <input id="userBlockEditExpiresAt" class="adm-input" type="datetime-local">
                    <div class="adm-quick-row">
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="userBlockEditExpiresAt" data-days="1"><spring:message code="admin.common.plusDays" arguments="1"/></button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="userBlockEditExpiresAt" data-days="7"><spring:message code="admin.common.plusDays" arguments="7"/></button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="userBlockEditExpiresAt" data-days="30"><spring:message code="admin.common.plusDays" arguments="30"/></button>
                        <button type="button" class="adm-chip-btn js-expiry-clear" data-target="userBlockEditExpiresAt"><spring:message code="admin.common.indefinite"/></button>
                    </div>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label"><spring:message code="admin.common.reason"/></label>
                    <textarea id="userBlockEditReason" class="adm-input" style="min-height:120px;"></textarea>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('userBlockEditModal')"><spring:message code="admin.common.close"/></button>
            <button class="adm-btn adm-btn-ghost" type="button" id="userBlockEditHistoryBtn"><spring:message code="admin.common.relatedHistory"/></button>
            <button class="adm-btn adm-btn-primary" type="button" onclick="submitUserBlockEdit()"><spring:message code="admin.common.save"/></button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="ipRuleEditModal">
    <div class="adm-modal" style="max-width:760px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="ipRuleEditTitle"><spring:message code="admin.blocks.ipRules.editTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('ipRuleEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="ipRuleEditId">
            <input type="hidden" id="ipRuleEditTemplateId">
            <input type="hidden" id="ipRuleEditHasBatch">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.common.target"/></div><div class="detail-value" id="ipRuleEditTarget">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.batch"/></div><div class="detail-value" id="ipRuleEditBatch">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.ruleState"/></div><div class="detail-value" id="ipRuleEditRuleState">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.effectiveState"/></div><div class="detail-value" id="ipRuleEditFinalState">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.createdAt"/></div><div class="detail-value" id="ipRuleEditBlockedAt">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.expiresAt"/></div><div class="detail-value" id="ipRuleEditExpiresDisplay">-</div></div>
            </div>
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;margin-top:18px;">
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.context.ruleAction"/></label>
                    <select id="ipRuleEditAction" class="adm-select">
                        <option value="BLOCK"><spring:message code="admin.context.ruleAction.block"/></option>
                        <option value="ALLOW"><spring:message code="admin.context.ruleAction.allow"/></option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.blocks.controlMode"/></label>
                    <select id="ipRuleEditControlMode" class="adm-select"></select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.context.category"/></label>
                    <select id="ipRuleEditCategory" class="adm-select">
                        <option value="MANUAL"><spring:message code="admin.blocks.category.manual"/></option>
                        <option value="SPAM"><spring:message code="admin.blocks.category.spam"/></option>
                        <option value="ABUSE"><spring:message code="admin.blocks.category.abuse"/></option>
                        <option value="BRUTE_FORCE"><spring:message code="admin.blocks.category.bruteForce"/></option>
                        <option value="GEO"><spring:message code="admin.blocks.category.geo"/></option>
                        <option value="VPN"><spring:message code="admin.blocks.category.vpn"/></option>
                        <option value="SECURITY"><spring:message code="admin.blocks.category.security"/></option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.context.priority"/></label>
                    <input id="ipRuleEditPriority" class="adm-input" type="number" min="1">
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label"><spring:message code="admin.context.expiresAt"/></label>
                    <input id="ipRuleEditExpiresAt" class="adm-input" type="datetime-local">
                    <div class="adm-quick-row">
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipRuleEditExpiresAt" data-days="1"><spring:message code="admin.common.plusDays" arguments="1"/></button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipRuleEditExpiresAt" data-days="7"><spring:message code="admin.common.plusDays" arguments="7"/></button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipRuleEditExpiresAt" data-days="30"><spring:message code="admin.common.plusDays" arguments="30"/></button>
                        <button type="button" class="adm-chip-btn js-expiry-clear" data-target="ipRuleEditExpiresAt"><spring:message code="admin.common.indefinite"/></button>
                    </div>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label"><spring:message code="admin.blocks.policyReason"/></label>
                    <textarea id="ipRuleEditReason" class="adm-input" style="min-height:100px;"></textarea>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label"><spring:message code="admin.blocks.description"/></label>
                    <textarea id="ipRuleEditDetailMessage" class="adm-input" style="min-height:100px;"></textarea>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('ipRuleEditModal')"><spring:message code="admin.common.close"/></button>
            <button class="adm-btn adm-btn-ghost" type="button" id="ipRuleEditHistoryBtn"><spring:message code="admin.common.relatedHistory"/></button>
            <button class="adm-btn adm-btn-primary" type="button" onclick="submitIpRuleEdit()"><spring:message code="admin.common.save"/></button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="ipRuleModal">
    <div class="adm-modal" style="max-width:720px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title"><spring:message code="admin.blocks.ipRules.createTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('ipRuleModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.context.ruleAction"/></label>
                    <select id="ipRuleAction" class="adm-select">
                        <option value="BLOCK"><spring:message code="admin.context.ruleAction.block"/></option>
                        <option value="ALLOW"><spring:message code="admin.context.ruleAction.allow"/></option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.blocks.controlMode"/></label>
                    <select id="ipControlMode" class="adm-select">
                        <option value="MANUAL"><spring:message code="admin.blocks.control.manual"/></option>
                        <option value="BATCH"><spring:message code="admin.blocks.control.batch"/></option>
                        <option value="MANUAL_OVERRIDE"><spring:message code="admin.blocks.control.override"/></option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.blocks.matchType"/></label>
                    <select id="ipMatchType" class="adm-select" onchange="handleIpRuleTypeChange()">
                        <option value="SINGLE_IP"><spring:message code="admin.blocks.match.singleIp"/></option>
                        <option value="CIDR"><spring:message code="admin.blocks.match.cidr"/></option>
                        <option value="RANGE"><spring:message code="admin.blocks.match.range"/></option>
                        <option value="COUNTRY"><spring:message code="admin.blocks.match.country"/></option>
                        <option value="ASN"><spring:message code="admin.blocks.match.asn"/></option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.context.category"/></label>
                    <select id="ipBlockCategory" class="adm-select">
                        <option value="MANUAL"><spring:message code="admin.blocks.category.manual"/></option>
                        <option value="SPAM"><spring:message code="admin.blocks.category.spam"/></option>
                        <option value="ABUSE"><spring:message code="admin.blocks.category.abuse"/></option>
                        <option value="BRUTE_FORCE"><spring:message code="admin.blocks.category.bruteForce"/></option>
                        <option value="GEO"><spring:message code="admin.blocks.category.geo"/></option>
                        <option value="VPN"><spring:message code="admin.blocks.category.vpn"/></option>
                        <option value="SECURITY"><spring:message code="admin.blocks.category.security"/></option>
                    </select>
                </div>
                <div class="sa-form-group" id="fieldSingleIp">
                    <label class="sa-form-label"><spring:message code="admin.common.ip"/></label>
                    <input id="ipAddressInput" class="adm-input" type="text" placeholder="203.0.113.10">
                </div>
                <div class="sa-form-group" id="fieldCidr" style="display:none;">
                    <label class="sa-form-label"><spring:message code="admin.blocks.match.cidr"/></label>
                    <input id="cidrNotationInput" class="adm-input" type="text" placeholder="203.0.113.0/24">
                </div>
                <div class="sa-form-group" id="fieldRangeStart" style="display:none;">
                    <label class="sa-form-label"><spring:message code="admin.blocks.rangeStartIp"/></label>
                    <input id="rangeStartInput" class="adm-input" type="text" placeholder="203.0.113.1">
                </div>
                <div class="sa-form-group" id="fieldRangeEnd" style="display:none;">
                    <label class="sa-form-label"><spring:message code="admin.blocks.rangeEndIp"/></label>
                    <input id="rangeEndInput" class="adm-input" type="text" placeholder="203.0.113.255">
                </div>
                <div class="sa-form-group" id="fieldCountry" style="display:none;">
                    <label class="sa-form-label"><spring:message code="admin.blocks.countryCode"/></label>
                    <input id="countryCodeInput" class="adm-input" type="text" placeholder="CN">
                </div>
                <div class="sa-form-group" id="fieldAsn" style="display:none;">
                    <label class="sa-form-label"><spring:message code="admin.blocks.match.asn"/></label>
                    <input id="asnInput" class="adm-input" type="text" placeholder="AS12345">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.context.batch"/></label>
                    <select id="ipBatchIdx" class="adm-select" onchange="handleIpBatchChange()">
                        <option value="">${adminBlocksNoneLabel}</option>
                        <c:forEach var="b" items="${batches}">
                            <option value="${b.ipBlockBatchIdx}">${b.batchName} (${b.batchCode})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="admin.context.priority"/></label>
                    <input id="ipPriority" class="adm-input" type="number" min="1" value="1">
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label"><spring:message code="admin.context.expiresAt"/></label>
                    <input id="ipExpiresAt" class="adm-input" type="datetime-local">
                    <div class="adm-quick-row">
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipExpiresAt" data-days="1"><spring:message code="admin.common.plusDays" arguments="1"/></button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipExpiresAt" data-days="7"><spring:message code="admin.common.plusDays" arguments="7"/></button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipExpiresAt" data-days="30"><spring:message code="admin.common.plusDays" arguments="30"/></button>
                        <button type="button" class="adm-chip-btn js-expiry-clear" data-target="ipExpiresAt"><spring:message code="admin.common.indefinite"/></button>
                    </div>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label"><spring:message code="admin.blocks.policyReason"/></label>
                    <textarea id="ipReason" class="adm-input" style="min-height:90px;"></textarea>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label"><spring:message code="admin.blocks.description"/></label>
                    <textarea id="ipDetailMessage" class="adm-input" style="min-height:90px;"></textarea>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('ipRuleModal')"><spring:message code="admin.common.cancel"/></button>
            <button class="adm-btn adm-btn-primary" onclick="submitIpRule()"><spring:message code="admin.common.save"/></button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="batchModal">
    <div class="adm-modal" style="max-width:620px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title"><spring:message code="admin.blocks.batches.createTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('batchModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;">
                <div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.batchCode"/></label><input id="batchCode" class="adm-input" type="text" placeholder="VPN_FEED_202604"></div>
                <div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.batchName"/></label><input id="batchName" class="adm-input" type="text" placeholder="VPN Public Ranges 2026.04"></div>
<div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.source"/></label><select id="batchSourceType" class="adm-select"><option value="MANUAL"><spring:message code="admin.blocks.sourceType.manual"/></option><option value="VPN_FEED"><spring:message code="admin.blocks.sourceType.vpnFeed"/></option><option value="SPAM_FEED"><spring:message code="admin.blocks.sourceType.spamFeed"/></option><option value="GEO_POLICY"><spring:message code="admin.blocks.sourceType.geoPolicy"/></option><option value="AUTO_DETECTION"><spring:message code="admin.blocks.sourceType.autoDetection"/></option></select></div>
                <div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.source"/> <spring:message code="admin.common.value"/></label><input id="batchSourceName" class="adm-input" type="text" placeholder="Manual registration"></div>
                <div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.baseAction"/></label><select id="batchRuleAction" class="adm-select"><option value="BLOCK"><spring:message code="admin.context.ruleAction.block"/></option><option value="ALLOW"><spring:message code="admin.context.ruleAction.allow"/></option></select></div>
                <div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.defaultPriority"/></label><input id="batchDefaultPriority" class="adm-input" type="number" min="1" value="1"></div>
                <div class="sa-form-group"><label class="sa-form-label">OFF <spring:message code="admin.blocks.baseStrategy"/></label><select id="batchDisableStrategy" class="adm-select"><option value="BATCH_ONLY">BATCH_ONLY</option><option value="CASCADE_ACTIVE_RULES">CASCADE_ACTIVE_RULES</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">ON <spring:message code="admin.blocks.baseStrategy"/></label><select id="batchEnableStrategy" class="adm-select"><option value="BATCH_ONLY">BATCH_ONLY</option><option value="RESTORE_BATCH_CONTROL">RESTORE_BATCH_CONTROL</option><option value="FORCE_ENABLE_ALL">FORCE_ENABLE_ALL</option></select></div>
                <div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label"><spring:message code="admin.blocks.description"/></label><textarea id="batchDescription" class="adm-input" style="min-height:90px;"></textarea></div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('batchModal')"><spring:message code="admin.common.cancel"/></button>
            <button class="adm-btn adm-btn-primary" onclick="submitBatch()"><spring:message code="admin.common.create"/></button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="batchEditModal">
    <div class="adm-modal" style="max-width:720px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="batchEditTitle"><spring:message code="admin.blocks.batches.editTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('batchEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="batchEditId">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.currentState"/></div><div class="detail-value" id="batchEditStatus">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.updatedAt"/></div><div class="detail-value" id="batchEditUpdatedAt">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.context.createdAt"/></div><div class="detail-value" id="batchEditCreatedAt">-</div></div>
                <div class="detail-item"><div class="detail-label"><spring:message code="admin.blocks.ruleStats"/></div><div class="detail-value" id="batchEditStats">-</div></div>
            </div>
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;margin-top:18px;">
                <div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.batchCode"/></label><input id="batchEditCode" class="adm-input" type="text"></div>
                <div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.batchName"/></label><input id="batchEditName" class="adm-input" type="text"></div>
<div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.source"/></label><select id="batchEditSourceType" class="adm-select"><option value="MANUAL"><spring:message code="admin.blocks.sourceType.manual"/></option><option value="VPN_FEED"><spring:message code="admin.blocks.sourceType.vpnFeed"/></option><option value="SPAM_FEED"><spring:message code="admin.blocks.sourceType.spamFeed"/></option><option value="GEO_POLICY"><spring:message code="admin.blocks.sourceType.geoPolicy"/></option><option value="AUTO_DETECTION"><spring:message code="admin.blocks.sourceType.autoDetection"/></option></select></div>
                <div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.source"/> <spring:message code="admin.common.value"/></label><input id="batchEditSourceName" class="adm-input" type="text"></div>
                <div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.baseAction"/></label><select id="batchEditRuleAction" class="adm-select"><option value="BLOCK"><spring:message code="admin.context.ruleAction.block"/></option><option value="ALLOW"><spring:message code="admin.context.ruleAction.allow"/></option></select></div>
                <div class="sa-form-group"><label class="sa-form-label"><spring:message code="admin.blocks.defaultPriority"/></label><input id="batchEditPriority" class="adm-input" type="number" min="1"></div>
                <div class="sa-form-group"><label class="sa-form-label">OFF <spring:message code="admin.blocks.baseStrategy"/></label><select id="batchEditDisableStrategy" class="adm-select"><option value="BATCH_ONLY">BATCH_ONLY</option><option value="CASCADE_ACTIVE_RULES">CASCADE_ACTIVE_RULES</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">ON <spring:message code="admin.blocks.baseStrategy"/></label><select id="batchEditEnableStrategy" class="adm-select"><option value="BATCH_ONLY">BATCH_ONLY</option><option value="RESTORE_BATCH_CONTROL">RESTORE_BATCH_CONTROL</option><option value="FORCE_ENABLE_ALL">FORCE_ENABLE_ALL</option></select></div>
                <div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label"><spring:message code="admin.blocks.description"/></label><textarea id="batchEditDescription" class="adm-input" style="min-height:100px;"></textarea></div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('batchEditModal')"><spring:message code="admin.common.close"/></button>
            <button class="adm-btn adm-btn-primary" type="button" onclick="submitBatchEdit()"><spring:message code="admin.common.save"/></button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="batchToggleModal">
    <div class="adm-modal" style="max-width:620px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="batchToggleTitle"><spring:message code="admin.blocks.batches.toggleTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('batchToggleModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="batchToggleId">
            <input type="hidden" id="batchToggleActive">
            <div class="detail-item" style="margin-bottom:14px;">
                <div class="detail-label"><spring:message code="admin.blocks.impact"/></div>
                <div class="detail-value" id="batchToggleSummary">-</div>
            </div>
            <div class="sa-form-group">
                <label class="sa-form-label"><spring:message code="admin.blocks.option"/></label>
                <select id="batchToggleOption" class="adm-select"></select>
            </div>
            <div class="sa-form-group" style="margin-top:14px;">
                <label class="sa-form-label"><spring:message code="admin.blocks.description"/></label>
                <textarea id="batchToggleDescription" class="adm-input" style="min-height:90px;"></textarea>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('batchToggleModal')"><spring:message code="admin.common.cancel"/></button>
            <button class="adm-btn adm-btn-primary" onclick="submitBatchToggle()"><spring:message code="admin.common.apply"/></button>
        </div>
    </div>
</div>

<style>
    .adm-inline-link {
        border: 0;
        background: transparent;
        padding: 0;
        cursor: pointer;
        font: inherit;
        text-align: left;
    }

    .adm-inline-link:hover {
        text-decoration: underline;
    }

    .adm-link-btn {
        width: 100%;
        border: 0;
        background: transparent;
        padding: 0;
        text-align: left;
        color: inherit;
        cursor: pointer;
    }

    .adm-link-btn:hover span:first-child {
        color: #93c5fd !important;
    }

    .adm-block-tab-row {
        flex-wrap: wrap;
        gap: 8px;
    }

    .adm-local-toolbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        padding: 16px;
        border-bottom: 1px solid rgba(148, 163, 184, 0.14);
        background: rgba(15, 23, 42, 0.42);
    }

    .adm-local-toolbar-group {
        display: flex;
        align-items: center;
        gap: 8px;
        flex-wrap: wrap;
    }

    .adm-local-toolbar .adm-input {
        min-width: 240px;
    }

    .adm-local-pagination {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        padding: 14px 16px 16px;
        border-top: 1px solid rgba(148, 163, 184, 0.14);
        background: rgba(15, 23, 42, 0.42);
        font-size: 13px;
        color: #cbd5e1;
    }

    .adm-local-page-actions {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .adm-local-empty td {
        text-align: center;
        padding: 28px;
        color: #64748b;
    }

    .adm-quick-row {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
        margin-top: 10px;
    }

    .adm-chip-btn {
        border: 1px solid rgba(148, 163, 184, 0.28);
        background: #182030;
        color: #cbd5e1;
        border-radius: 6px;
        padding: 6px 10px;
        font-size: 12px;
        cursor: pointer;
    }

    .adm-chip-btn:hover {
        border-color: rgba(96, 165, 250, 0.5);
        color: #eff6ff;
    }
</style>

<script>
const CTX = '${pageContext.request.contextPath}';
const ADMIN_BLOCK_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const ADMIN_BLOCK_MSG = {
    noData: '<spring:message code="admin.common.noData" javaScriptEscape="true"/>',
    noMatchingData: '<spring:message code="admin.common.noMatchingData" javaScriptEscape="true"/>',
    totalCountFormat: '<spring:message code="admin.common.totalCountFormat" javaScriptEscape="true"/>',
    currentCountFormat: '<spring:message code="admin.common.currentCountFormat" javaScriptEscape="true"/>',
    loading: '<spring:message code="admin.common.loading" javaScriptEscape="true"/>',
    close: '<spring:message code="admin.common.close" javaScriptEscape="true"/>',
    fetchError: '<spring:message code="admin.context.fetchError" javaScriptEscape="true"/>',
    settings: '<spring:message code="admin.common.settings" javaScriptEscape="true"/>',
    detail: '<spring:message code="admin.common.detail" javaScriptEscape="true"/>',
    history: '<spring:message code="admin.common.history" javaScriptEscape="true"/>',
    memberTitle: '<spring:message code="admin.context.memberTitle" javaScriptEscape="true"/>',
    tabInfo: '<spring:message code="admin.context.tab.info" javaScriptEscape="true"/>',
    tabLogins: '<spring:message code="admin.context.tab.logins" javaScriptEscape="true"/>',
    saved: '<spring:message code="admin.common.saved" javaScriptEscape="true"/>',
    saveFailed: '<spring:message code="admin.common.saveFailed" javaScriptEscape="true"/>',
    created: '<spring:message code="admin.common.created" javaScriptEscape="true"/>',
    createFailed: '<spring:message code="admin.common.createFailed" javaScriptEscape="true"/>',
    updated: '<spring:message code="admin.common.updated" javaScriptEscape="true"/>',
    updateFailed: '<spring:message code="admin.common.updateFailed" javaScriptEscape="true"/>',
    released: '<spring:message code="admin.common.released" javaScriptEscape="true"/>',
    releaseFailed: '<spring:message code="admin.common.releaseFailed" javaScriptEscape="true"/>',
    batchSettingsNotFound: '<spring:message code="admin.blocks.batchSettingsNotFound" javaScriptEscape="true"/>',
    blockDetailTitle: '<spring:message code="admin.blocks.detailTitle" javaScriptEscape="true"/>',
    userBlockHistory: '<spring:message code="admin.blocks.userBlockHistory" javaScriptEscape="true"/>',
    ipRuleHistory: '<spring:message code="admin.blocks.ipRuleHistory" javaScriptEscape="true"/>',
    confirmRuleOn: '<spring:message code="admin.blocks.confirmRuleOn" javaScriptEscape="true"/>',
    confirmRuleOff: '<spring:message code="admin.blocks.confirmRuleOff" javaScriptEscape="true"/>',
    confirmReturnToBatch: '<spring:message code="admin.blocks.confirmReturnToBatch" javaScriptEscape="true"/>',
    confirmReleaseUserBlock: '<spring:message code="admin.blocks.confirmReleaseUserBlock" javaScriptEscape="true"/>',
    historyCurrentMissing: '<spring:message code="admin.blocks.historyCurrentMissing" javaScriptEscape="true"/>',
    batchToggleEnableSummary: '<spring:message code="admin.blocks.batchToggleEnableSummary" javaScriptEscape="true"/>',
    batchToggleDisableSummary: '<spring:message code="admin.blocks.batchToggleDisableSummary" javaScriptEscape="true"/>',
    keepBlocked: '<spring:message code="admin.blocks.keepBlocked" javaScriptEscape="true"/>',
    releaseBlock: '<spring:message code="admin.blocks.releaseBlock" javaScriptEscape="true"/>',
    effectiveOn: '<spring:message code="admin.blocks.effective.effective" javaScriptEscape="true"/>',
    ruleOff: '<spring:message code="admin.blocks.effective.ruleInactive" javaScriptEscape="true"/>',
    batchOff: '<spring:message code="admin.blocks.effective.batchInactive" javaScriptEscape="true"/>',
    expired: '<spring:message code="admin.blocks.effective.expired" javaScriptEscape="true"/>',
    individualRule: '<spring:message code="admin.blocks.individualRule" javaScriptEscape="true"/>',
    ruleOn: '<spring:message code="admin.blocks.ruleOn" javaScriptEscape="true"/>',
    pagePrefix: '<spring:message code="admin.common.pagePrefix" javaScriptEscape="true"/>'
};
const BLOCK_SECTION_CONFIG = {
    'user-blocks': {
        fields: {
            all: ['search'],
            nickname: ['nickname'],
            userId: ['userId'],
            target: ['target'],
            reason: ['reason'],
            blockType: ['blockType'],
            blockedAt: ['blockedAt'],
            expiresAt: ['expiresAt']
        }
    },
    'ip-rules': {
        fields: {
            all: ['search'],
            target: ['target'],
            batch: ['batch'],
            reason: ['reason'],
            priority: ['priority'],
            policy: ['policy'],
            blockedAt: ['blockedAt'],
            expiresAt: ['expiresAt']
        }
    },
    'batches': {
        fields: {
            all: ['search'],
            batch: ['batch'],
            source: ['source'],
            description: ['description'],
            policy: ['policy'],
            status: ['status'],
            updatedAt: ['updatedAt']
        }
    },
    'histories': {
        fields: {
            all: ['search'],
            target: ['target'],
            member: ['member'],
            change: ['change'],
            reason: ['reason'],
            batch: ['batch'],
            blockedAt: ['blockedAt'],
            expiresAt: ['expiresAt']
        }
    }
};
const blockSectionState = {};
let activeBlockTab = 'dashboard';

function escapeHtml(value) {
    if (value == null) return '';
    return String(value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

function formatNullable(value) {
    return value ? escapeHtml(value) : '<span style="color:#475569">—</span>';
}

function normalizeSearchValue(value) {
    return String(value || '').trim().toLowerCase();
}

function getLocalRows(section) {
    return Array.from(document.querySelectorAll('.js-local-row[data-section="' + section + '"]'));
}

function getLocalState(section) {
    if (!blockSectionState[section]) {
        blockSectionState[section] = {page: 1, pageSize: 20};
    }
    return blockSectionState[section];
}

function updateTabQuery(tab) {
    const hiddenInput = document.getElementById('blockActiveTabInput');
    if (hiddenInput) {
        hiddenInput.value = tab;
    }
    const url = new URL(window.location.href);
    url.searchParams.set('tab', tab);
    window.history.replaceState({}, '', url.toString());
}

function activateBlockTab(tab) {
    const validTabs = ['dashboard', 'all', 'user-blocks', 'ip-rules', 'batches', 'histories'];
    activeBlockTab = validTabs.includes(tab) ? tab : 'dashboard';
    updateTabQuery(activeBlockTab);

    document.querySelectorAll('.js-block-tab').forEach(function (button) {
        button.classList.toggle('active', button.dataset.tab === activeBlockTab);
    });

    const dashboardPanel = document.querySelector('.js-dashboard-panel');
    if (dashboardPanel) {
        dashboardPanel.style.display = activeBlockTab === 'dashboard' ? '' : 'none';
    }

    document.querySelectorAll('.js-section-card').forEach(function (card) {
        const section = card.dataset.section;
        const visible = activeBlockTab === 'all' || (activeBlockTab !== 'dashboard' && activeBlockTab === section);
        card.style.display = visible ? '' : 'none';
    });
}

function ensureLocalEmptyRow(section, visibleCount) {
    const rows = getLocalRows(section);
    const sampleRow = rows[0];
    if (!sampleRow) return;

    const tbody = sampleRow.parentElement;
    const colspan = sampleRow.children.length || tbody.parentElement.querySelectorAll('thead th').length || 1;
    let emptyRow = tbody.querySelector('.adm-local-empty[data-section="' + section + '"]');

    if (visibleCount > 0) {
        if (emptyRow) emptyRow.remove();
        return;
    }

    if (!emptyRow) {
        emptyRow = document.createElement('tr');
        emptyRow.className = 'adm-local-empty';
        emptyRow.dataset.section = section;
        emptyRow.innerHTML = '<td colspan="' + colspan + '">' + escapeHtml(ADMIN_BLOCK_MSG.noMatchingData) + '</td>';
        tbody.appendChild(emptyRow);
    }
}

function filterLocalRows(section) {
    const config = BLOCK_SECTION_CONFIG[section];
    if (!config) return [];

    const keywordInput = document.querySelector('.js-local-keyword[data-section="' + section + '"]');
    const fieldSelect = document.querySelector('.js-local-field[data-section="' + section + '"]');
    const keyword = normalizeSearchValue(keywordInput ? keywordInput.value : '');
    const field = fieldSelect ? fieldSelect.value : 'all';
    const keys = config.fields[field] || config.fields.all;

    return getLocalRows(section).filter(function (row) {
        if (!keyword) return true;
        return keys.some(function (key) {
            return normalizeSearchValue(row.dataset[key] || '').includes(keyword);
        });
    });
}

function renderLocalSection(section) {
    const state = getLocalState(section);
    const filteredRows = filterLocalRows(section);
    const total = filteredRows.length;
    const pageSize = Math.max(1, Number(state.pageSize || 20));
    const totalPages = Math.max(1, Math.ceil(total / pageSize));

    if (state.page > totalPages) {
        state.page = totalPages;
    }
    if (state.page < 1) {
        state.page = 1;
    }

    const start = (state.page - 1) * pageSize;
    const end = start + pageSize;

    getLocalRows(section).forEach(function (row) {
        row.style.display = 'none';
    });
    filteredRows.slice(start, end).forEach(function (row) {
        row.style.display = '';
    });

    ensureLocalEmptyRow(section, filteredRows.slice(start, end).length);

    const info = document.querySelector('.js-local-page-info[data-section="' + section + '"]');
    const pageState = document.querySelector('.js-local-page-state[data-section="' + section + '"]');
    const prevBtn = document.querySelector('.js-local-prev[data-section="' + section + '"]');
    const nextBtn = document.querySelector('.js-local-next[data-section="' + section + '"]');

    if (info) {
        const shown = total === 0 ? 0 : Math.min(total, end) - start;
        info.textContent = ADMIN_BLOCK_MSG.totalCountFormat.replace('{0}', total) + ' / ' + ADMIN_BLOCK_MSG.currentCountFormat.replace('{0}', shown);
    }
    if (pageState) {
        pageState.textContent = state.page + ' / ' + totalPages;
    }
    if (prevBtn) prevBtn.disabled = state.page <= 1;
    if (nextBtn) nextBtn.disabled = state.page >= totalPages;
}

function initializeLocalSections() {
    Object.keys(BLOCK_SECTION_CONFIG).forEach(function (section) {
        const pageSizeSelect = document.querySelector('.js-local-page-size[data-section="' + section + '"]');
        const fieldSelect = document.querySelector('.js-local-field[data-section="' + section + '"]');
        const keywordInput = document.querySelector('.js-local-keyword[data-section="' + section + '"]');
        const resetButton = document.querySelector('.js-local-reset[data-section="' + section + '"]');

        const state = getLocalState(section);
        if (pageSizeSelect) {
            state.pageSize = Number(pageSizeSelect.value || 20);
            pageSizeSelect.addEventListener('change', function () {
                state.pageSize = Number(pageSizeSelect.value || 20);
                state.page = 1;
                renderLocalSection(section);
            });
        }
        if (fieldSelect) {
            fieldSelect.addEventListener('change', function () {
                state.page = 1;
                renderLocalSection(section);
            });
        }
        if (keywordInput) {
            keywordInput.addEventListener('input', function () {
                state.page = 1;
                renderLocalSection(section);
            });
        }
        if (resetButton) {
            resetButton.addEventListener('click', function () {
                if (fieldSelect) fieldSelect.value = 'all';
                if (keywordInput) keywordInput.value = '';
                state.page = 1;
                renderLocalSection(section);
            });
        }
        renderLocalSection(section);
    });
}

function findFirstButton(selector, predicate) {
    const buttons = Array.from(document.querySelectorAll(selector));
    return buttons.find(predicate) || null;
}

function formatDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString(ADMIN_BLOCK_LOCALE || undefined, {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatHistoryDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString(ADMIN_BLOCK_LOCALE || undefined, {
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatBooleanBadge(value) {
    return value
        ? '<span style="color:#4ade80">✓ <spring:message code="admin.common.yes" javaScriptEscape="true"/></span>'
        : '<span style="color:#475569">✗ <spring:message code="admin.common.no" javaScriptEscape="true"/></span>';
}

function buildStatusBadge(status) {
    const safe = escapeHtml(status || '');
    return '<span class="status-badge ' + safe + '">' + (safe || '—') + '</span>';
}

function buildRoleBadge(role) {
    const safe = escapeHtml(role || '');
    return '<span class="role-badge ' + safe + '">' + (safe || '—') + '</span>';
}

function buildSocialHtml(linkedProviders) {
    if (!linkedProviders) {
        return '<span class="adm-social-empty"><spring:message code="admin.members.noLinkedProvider" javaScriptEscape="true"/></span>';
    }

    const providerMap = {
        KAKAO: {
            label: '<spring:message code="admin.social.kakao" javaScriptEscape="true"/>',
            className: 'kakao',
            icon: '<span class="adm-social-icon kakao-mark">k</span>'
        },
        NAVER: {
            label: '<spring:message code="admin.social.naver" javaScriptEscape="true"/>',
            className: 'naver',
            icon: '<span class="adm-social-icon naver-mark">N</span>'
        },
        GOOGLE: {
            label: '<spring:message code="admin.social.google" javaScriptEscape="true"/>',
            className: 'google',
            icon: '<span class="adm-social-icon google-mark"><svg viewBox="0 0 48 48" aria-hidden="true" focusable="false"><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/><path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/></svg></span>'
        }
    };

    const items = linkedProviders
        .split(',')
        .map(provider => provider.trim())
        .filter(provider => provider.length > 0)
        .map(function(provider) {
            const info = providerMap[provider];
            if (!info) {
                return '<span class="adm-social-pill"><span class="adm-social-label">' + escapeHtml(provider) + '</span></span>';
            }
            return '<span class="adm-social-pill ' + info.className + '">' + info.icon + '<span class="adm-social-label">' + escapeHtml(info.label) + '</span></span>';
        });

    if (!items.length) {
        return '<span class="adm-social-empty"><spring:message code="admin.members.noLinkedProvider" javaScriptEscape="true"/></span>';
    }

    return '<div class="adm-social-list">' + items.join('') + '</div>';
}

function buildMemberInfoTab(member) {
    const statusBadge = buildStatusBadge(member.accountStatus);
    const roleBadge = buildRoleBadge(member.userRole);
    const socialHtml = buildSocialHtml(member.linkedProviders);
    const lastLoginText = formatDateTime(member.lastLoginAt);

    return ''
        + '<div class="detail-grid">'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.context.memberNo" javaScriptEscape="true"/></div><div class="detail-value">#' + escapeHtml(member.userIdx) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.context.userId" javaScriptEscape="true"/></div><div class="detail-value">' + formatNullable(member.userId) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.context.nickname" javaScriptEscape="true"/></div><div class="detail-value">' + formatNullable(member.nickname) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.context.email" javaScriptEscape="true"/></div><div class="detail-value" style="font-size:12px;">' + formatNullable(member.userEmail) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.members.accountStatus" javaScriptEscape="true"/></div><div class="detail-value">' + statusBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.common.role" javaScriptEscape="true"/></div><div class="detail-value">' + roleBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.context.nationality" javaScriptEscape="true"/></div><div class="detail-value">' + formatNullable(member.nationality) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.context.preferredLanguage" javaScriptEscape="true"/></div><div class="detail-value">' + formatNullable(member.preferredLang) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.members.emailVerified" javaScriptEscape="true"/></div><div class="detail-value">' + formatBooleanBadge(member.emailVerified) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.members.emailLoginEnabled" javaScriptEscape="true"/></div><div class="detail-value">' + formatBooleanBadge(member.emailLoginEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.members.passwordLoginEnabled" javaScriptEscape="true"/></div><div class="detail-value">' + formatBooleanBadge(member.passwordEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label"><spring:message code="admin.context.createdAt" javaScriptEscape="true"/></div><div class="detail-value" style="font-size:12px;">' + formatDateTime(member.createdAt) + '</div></div>'
        + '</div>'
        + '<div class="detail-item" style="margin-top:12px;">'
        + '<div class="detail-label"><spring:message code="admin.members.socialLinked" javaScriptEscape="true"/></div>'
        + '<div class="detail-value" style="margin-top:4px;">' + socialHtml + '</div>'
        + '</div>'
        + '<div style="margin-top:12px;display:flex;gap:8px;flex-wrap:wrap;">'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;"><spring:message code="admin.members.loginSuccess" javaScriptEscape="true"/></div>'
        + '<div style="font-size:20px;font-weight:700;color:#4ade80;margin-top:4px;">' + escapeHtml(member.loginSuccessCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;"><spring:message code="admin.members.loginFailure" javaScriptEscape="true"/></div>'
        + '<div style="font-size:20px;font-weight:700;color:#f87171;margin-top:4px;">' + escapeHtml(member.loginFailCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:120px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;"><spring:message code="admin.context.lastLogin" javaScriptEscape="true"/></div>'
        + '<div style="font-size:12px;font-weight:600;color:#94a3b8;margin-top:4px;">' + escapeHtml(lastLoginText) + '</div>'
        + '</div>'
        + '</div>';
}

function buildMemberHistTab(history) {
    if (!history.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;"><spring:message code="admin.context.empty.logins" javaScriptEscape="true"/></div>';
    }

    const methodMap = {
        ID: '<spring:message code="admin.context.userId" javaScriptEscape="true"/>',
        EMAIL: '<spring:message code="admin.context.email" javaScriptEscape="true"/>',
        KAKAO: '<spring:message code="admin.social.kakao" javaScriptEscape="true"/>',
        NAVER: '<spring:message code="admin.social.naver" javaScriptEscape="true"/>',
        GOOGLE: '<spring:message code="admin.social.google" javaScriptEscape="true"/>'
    };

    let rows = '';
    history.forEach(function(item) {
        const ok = !!item.success;
        rows += ''
            + '<tr>'
            + '<td>' + escapeHtml(formatHistoryDateTime(item.loginAt)) + '</td>'
            + '<td>' + escapeHtml(methodMap[item.loginMethod] || item.loginMethod || '—') + '</td>'
            + '<td class="' + (ok ? 'h-success' : 'h-fail') + '">' + (ok ? '✅ <spring:message code="admin.logs.success" javaScriptEscape="true"/>' : '❌ <spring:message code="admin.logs.failure" javaScriptEscape="true"/>') + '</td>'
            + '<td>' + escapeHtml(item.failReason || '—') + '</td>'
            + '<td style="font-size:11px;color:#475569;">' + escapeHtml(item.ipAddress || '—') + '</td>'
            + '</tr>';
    });

    return ''
        + '<div style="overflow-x:auto;max-height:340px;overflow-y:auto;">'
        + '<table class="history-table">'
        + '<thead><tr><th><spring:message code="admin.common.time" javaScriptEscape="true"/></th><th><spring:message code="admin.logs.provider" javaScriptEscape="true"/></th><th><spring:message code="admin.blocks.result" javaScriptEscape="true"/></th><th><spring:message code="admin.logs.failReason" javaScriptEscape="true"/></th><th><spring:message code="admin.common.ip" javaScriptEscape="true"/></th></tr></thead>'
        + '<tbody>' + rows + '</tbody>'
        + '</table>'
        + '</div>';
}

function switchMemberTab(tab, btn) {
    document.querySelectorAll('#memberDetailModal .adm-tab').forEach(function(tabButton) {
        tabButton.classList.remove('active');
    });
    btn.classList.add('active');
    document.getElementById('member-detail-tab-info').style.display = tab === 'info' ? '' : 'none';
    document.getElementById('member-detail-tab-hist').style.display = tab === 'hist' ? '' : 'none';
}

async function openMemberDetailModal(userIdx) {
    if (!userIdx) return;

    document.getElementById('memberDetailModal').classList.add('open');
    document.getElementById('memberDetailBody').innerHTML =
        '<div style="text-align:center;padding:40px;color:#475569;">' + escapeHtml(ADMIN_BLOCK_MSG.loading) + ' ⏳</div>';

    const res = await fetch(CTX + '/admin/members/' + userIdx, {
        headers: {'X-Requested-With': 'XMLHttpRequest'}
    });
    const data = await res.json();

    if (!data.success) {
        document.getElementById('memberDetailBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(data.message || ADMIN_BLOCK_MSG.fetchError) + '</div>';
        return;
    }

    const member = data.member || {};
    const history = Array.isArray(data.history) ? data.history : [];
    document.getElementById('memberDetailTitle').textContent = ADMIN_BLOCK_MSG.memberTitle;
    document.getElementById('memberDetailBody').innerHTML = ''
        + '<div class="adm-tabs">'
        + '<button class="adm-tab active" onclick="switchMemberTab(\'info\', this)">' + escapeHtml(ADMIN_BLOCK_MSG.tabInfo) + '</button>'
        + '<button class="adm-tab" onclick="switchMemberTab(\'hist\', this)">' + escapeHtml(ADMIN_BLOCK_MSG.tabLogins) + ' (' + history.length + ')</button>'
        + '</div>'
        + '<div id="member-detail-tab-info">' + buildMemberInfoTab(member) + '</div>'
        + '<div id="member-detail-tab-hist" style="display:none;">' + buildMemberHistTab(history) + '</div>';
}

function openIpRuleModal() {
    document.getElementById('ipRuleModal').classList.add('open');
    handleIpRuleTypeChange();
    handleIpBatchChange();
}

function openBatchModal() {
    document.getElementById('batchModal').classList.add('open');
}

function openBatchEditor(button) {
    const resolvedButton = button.dataset.sourceType
        ? button
        : findFirstButton('.js-open-batch-editor', function (candidate) {
            return candidate.dataset.batchId === button.dataset.batchId && candidate.dataset.sourceType;
        });

    if (!resolvedButton) {
        adm_toast(ADMIN_BLOCK_MSG.batchSettingsNotFound, 'error');
        return;
    }

    document.getElementById('batchEditId').value = resolvedButton.dataset.batchId || '';
    document.getElementById('batchEditTitle').textContent = resolvedButton.dataset.batchName || '<spring:message code="admin.blocks.batches.editTitle" javaScriptEscape="true"/>';
    document.getElementById('batchEditStatus').textContent = resolvedButton.dataset.statusLabel || '-';
    document.getElementById('batchEditUpdatedAt').textContent = resolvedButton.dataset.updatedAt || '-';
    document.getElementById('batchEditCreatedAt').textContent = resolvedButton.dataset.createdAt || '-';
    document.getElementById('batchEditStats').textContent = ADMIN_BLOCK_MSG.totalCountFormat.replace('{0}', resolvedButton.dataset.totalRules || '0')
        + ' / ' + ADMIN_BLOCK_MSG.ruleOn + ' ' + (resolvedButton.dataset.activeRules || '0')
        + ' / ' + ADMIN_BLOCK_MSG.effectiveOn + ' ' + (resolvedButton.dataset.effectiveRules || '0')
        + ' / ' + ADMIN_BLOCK_MSG.expired + ' ' + (resolvedButton.dataset.expiredRules || '0');
    document.getElementById('batchEditCode').value = resolvedButton.dataset.batchCode || '';
    document.getElementById('batchEditName').value = resolvedButton.dataset.batchName || '';
    document.getElementById('batchEditSourceType').value = resolvedButton.dataset.sourceType || 'MANUAL';
    document.getElementById('batchEditSourceName').value = resolvedButton.dataset.sourceName || '';
    document.getElementById('batchEditRuleAction').value = resolvedButton.dataset.batchRuleAction || 'BLOCK';
    document.getElementById('batchEditPriority').value = resolvedButton.dataset.defaultPriority || '1';
    document.getElementById('batchEditDisableStrategy').value = resolvedButton.dataset.defaultDisableStrategy || 'BATCH_ONLY';
    document.getElementById('batchEditEnableStrategy').value = resolvedButton.dataset.defaultEnableStrategy || 'BATCH_ONLY';
    document.getElementById('batchEditDescription').value = resolvedButton.dataset.description || '';
    document.getElementById('batchEditModal').classList.add('open');
}

function closeModal(id) {
    document.getElementById(id).classList.remove('open');
}

function handleIpRuleTypeChange() {
    const type = document.getElementById('ipMatchType').value;
    document.getElementById('fieldSingleIp').style.display = type === 'SINGLE_IP' ? '' : 'none';
    document.getElementById('fieldCidr').style.display = type === 'CIDR' ? '' : 'none';
    document.getElementById('fieldRangeStart').style.display = type === 'RANGE' ? '' : 'none';
    document.getElementById('fieldRangeEnd').style.display = type === 'RANGE' ? '' : 'none';
    document.getElementById('fieldCountry').style.display = type === 'COUNTRY' ? '' : 'none';
    document.getElementById('fieldAsn').style.display = type === 'ASN' ? '' : 'none';
}

function handleIpBatchChange() {
    const batchId = document.getElementById('ipBatchIdx').value;
    const controlMode = document.getElementById('ipControlMode');
    if (!batchId) {
        controlMode.value = 'MANUAL';
    } else if (controlMode.value === 'MANUAL') {
        controlMode.value = 'BATCH';
    }
}

function openBlockDetail(templateId, title) {
    const template = document.getElementById(templateId);
    if (!template) return;
    document.getElementById('blockDetailTitle').textContent = title || ADMIN_BLOCK_MSG.blockDetailTitle;
    document.getElementById('blockDetailBody').innerHTML = template.innerHTML;
    document.getElementById('blockDetailModal').classList.add('open');
}

function applyExpiryPreset(targetId, days) {
    const input = document.getElementById(targetId);
    if (!input) return;
    const base = new Date();
    base.setMinutes(base.getMinutes() - base.getTimezoneOffset());
    const result = new Date(base.getTime() + (Number(days) * 24 * 60 * 60 * 1000));
    input.value = result.toISOString().slice(0, 16);
}

function clearExpiryPreset(targetId) {
    const input = document.getElementById(targetId);
    if (input) {
        input.value = '';
    }
}

function fillIpRuleEditControlModes(hasBatch, currentMode) {
    const select = document.getElementById('ipRuleEditControlMode');
    if (!select) return;

    if (hasBatch) {
        select.innerHTML = ''
            + '<option value="BATCH"><spring:message code="admin.blocks.control.batch" javaScriptEscape="true"/></option>'
            + '<option value="MANUAL_OVERRIDE"><spring:message code="admin.blocks.control.override" javaScriptEscape="true"/></option>';
        select.value = currentMode === 'MANUAL_OVERRIDE' ? 'MANUAL_OVERRIDE' : 'BATCH';
    } else {
        select.innerHTML = '<option value="MANUAL"><spring:message code="admin.blocks.control.manual" javaScriptEscape="true"/></option>';
        select.value = 'MANUAL';
    }
}

function openUserBlockEditor(button) {
    const userIdx = button.dataset.userIdx || '';
    const displayName = button.dataset.displayName || '-';
    const userId = button.dataset.userId || '';
    const userEmail = button.dataset.userEmail || '';

    document.getElementById('userBlockEditId').value = button.dataset.blockIdx;
    document.getElementById('userBlockEditTemplateId').value = button.dataset.templateId || '';
    document.getElementById('userBlockEditTitle').textContent = '<spring:message code="admin.blocks.userBlocks.editTitle" javaScriptEscape="true"/>';

    let memberHtml = escapeHtml(displayName);
    if (userIdx) {
        memberHtml = '<button type="button" class="adm-inline-link js-open-member-detail" data-user-idx="' + escapeHtml(userIdx) + '" style="color:#93c5fd;">' + escapeHtml(displayName) + '</button>';
    }
    if (userId) {
        memberHtml += '<div style="font-size:12px;color:#94a3b8;margin-top:4px;">' + escapeHtml(userId) + '</div>';
    }
    if (userEmail) {
        memberHtml += '<div style="font-size:12px;color:#64748b;margin-top:4px;">' + escapeHtml(userEmail) + '</div>';
    }

    document.getElementById('userBlockEditMember').innerHTML = memberHtml;
    document.getElementById('userBlockEditTarget').textContent = button.dataset.targetKey || '-';
    document.getElementById('userBlockEditType').textContent = button.dataset.blockType || '-';
    document.getElementById('userBlockEditStatus').textContent = (button.dataset.active === 'true' ? ADMIN_BLOCK_MSG.keepBlocked : ADMIN_BLOCK_MSG.releaseBlock) + ' / ' + (button.dataset.snapshotStatus || '-');
    document.getElementById('userBlockEditBlockedAt').textContent = button.dataset.blockedAt || '-';
    document.getElementById('userBlockEditSyncAt').textContent = button.dataset.syncAt || '-';
    document.getElementById('userBlockEditActive').value = button.dataset.active === 'true' ? 'true' : 'false';
    document.getElementById('userBlockEditExpiresAt').value = button.dataset.expiresAt || '';
    document.getElementById('userBlockEditReason').value = button.dataset.reason || '';
    document.getElementById('userBlockEditHistoryBtn').onclick = function () {
        closeModal('userBlockEditModal');
        openBlockDetail(button.dataset.templateId, ADMIN_BLOCK_MSG.userBlockHistory);
    };
    document.getElementById('userBlockEditModal').classList.add('open');
}

function openIpRuleEditor(button) {
    const batchId = button.dataset.batchId || '';
    const hasBatch = batchId !== '';
    const batchLabel = hasBatch
        ? (button.dataset.batchName || '-') + (button.dataset.batchCode ? ' (' + button.dataset.batchCode + ')' : '')
        : ADMIN_BLOCK_MSG.individualRule;

    document.getElementById('ipRuleEditId').value = button.dataset.id;
    document.getElementById('ipRuleEditTemplateId').value = button.dataset.templateId || '';
    document.getElementById('ipRuleEditHasBatch').value = hasBatch ? 'true' : 'false';
    document.getElementById('ipRuleEditTitle').textContent = '<spring:message code="admin.blocks.ipRules.editTitle" javaScriptEscape="true"/>';
    document.getElementById('ipRuleEditTarget').textContent = (button.dataset.targetDisplay || '-') + ' / ' + (button.dataset.targetKey || '-');
    document.getElementById('ipRuleEditBatch').textContent = batchLabel + ' / ' + (button.dataset.batchStatusLabel || ADMIN_BLOCK_MSG.individualRule);
    document.getElementById('ipRuleEditRuleState').textContent = button.dataset.ruleStateLabel || '-';
    document.getElementById('ipRuleEditFinalState').textContent = (button.dataset.finalStateLabel || '-') + ' / ' + (button.dataset.effectiveStatusLabel || '-');
    document.getElementById('ipRuleEditBlockedAt').textContent = button.dataset.blockedAt || '-';
    document.getElementById('ipRuleEditExpiresDisplay').textContent = button.dataset.expiresDisplay || '${fn:escapeXml(adminBlocksNoneLabel)}';
    document.getElementById('ipRuleEditAction').value = button.dataset.ruleAction || 'BLOCK';
    document.getElementById('ipRuleEditCategory').value = button.dataset.blockCategory || 'MANUAL';
    document.getElementById('ipRuleEditPriority').value = button.dataset.priority || '1';
    document.getElementById('ipRuleEditExpiresAt').value = button.dataset.expiresAt || '';
    document.getElementById('ipRuleEditReason').value = button.dataset.reason || '';
    document.getElementById('ipRuleEditDetailMessage').value = button.dataset.detailMessage || '';
    fillIpRuleEditControlModes(hasBatch, button.dataset.controlMode || 'MANUAL');
    document.getElementById('ipRuleEditHistoryBtn').onclick = function () {
        closeModal('ipRuleEditModal');
        openBlockDetail(button.dataset.templateId, ADMIN_BLOCK_MSG.ipRuleHistory);
    };
    document.getElementById('ipRuleEditModal').classList.add('open');
}

async function submitIpRule() {
    const params = new URLSearchParams({
        matchType: document.getElementById('ipMatchType').value,
        ipAddress: document.getElementById('ipAddressInput').value.trim(),
        cidrNotation: document.getElementById('cidrNotationInput').value.trim(),
        rangeStartIp: document.getElementById('rangeStartInput').value.trim(),
        rangeEndIp: document.getElementById('rangeEndInput').value.trim(),
        countryCode: document.getElementById('countryCodeInput').value.trim(),
        asn: document.getElementById('asnInput').value.trim(),
        ruleAction: document.getElementById('ipRuleAction').value,
        controlMode: document.getElementById('ipControlMode').value,
        blockCategory: document.getElementById('ipBlockCategory').value,
        priority: document.getElementById('ipPriority').value,
        ipBlockBatchIdx: document.getElementById('ipBatchIdx').value,
        reason: document.getElementById('ipReason').value.trim(),
        detailMessage: document.getElementById('ipDetailMessage').value.trim(),
        expiresAt: document.getElementById('ipExpiresAt').value
    });
    const res = await fetch(CTX + '/admin/blocks/ip-rules', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saved);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saveFailed, 'error');
    }
}

async function submitIpRuleEdit() {
    const id = document.getElementById('ipRuleEditId').value;
    const params = new URLSearchParams({
        ruleAction: document.getElementById('ipRuleEditAction').value,
        controlMode: document.getElementById('ipRuleEditControlMode').value,
        blockCategory: document.getElementById('ipRuleEditCategory').value,
        priority: document.getElementById('ipRuleEditPriority').value,
        reason: document.getElementById('ipRuleEditReason').value.trim(),
        detailMessage: document.getElementById('ipRuleEditDetailMessage').value.trim(),
        expiresAt: document.getElementById('ipRuleEditExpiresAt').value
    });
    const res = await fetch(CTX + '/admin/blocks/ip-rules/' + id + '/update', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saved);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saveFailed, 'error');
    }
}

async function toggleIpRule(id, active) {
    const message = active ? ADMIN_BLOCK_MSG.confirmRuleOn : ADMIN_BLOCK_MSG.confirmRuleOff;
    if (!confirm(message)) return;
    const res = await fetch(CTX + '/admin/blocks/ip-rules/' + id + '/toggle', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: 'active=' + active
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updated);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updateFailed, 'error');
    }
}

async function returnToBatch(id) {
    if (!confirm(ADMIN_BLOCK_MSG.confirmReturnToBatch)) return;
    const res = await fetch(CTX + '/admin/blocks/ip-rules/' + id + '/return-to-batch', {
        method: 'POST',
        headers: {'X-Requested-With': 'XMLHttpRequest'}
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updated);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updateFailed, 'error');
    }
}

async function releaseUserBlock(targetKey) {
    if (!confirm(ADMIN_BLOCK_MSG.confirmReleaseUserBlock)) return;
    const params = new URLSearchParams({blockTargetKey: targetKey});
    const res = await fetch(CTX + '/admin/blocks/user-blocks/release', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.released);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.releaseFailed, 'error');
    }
}

async function submitUserBlockEdit() {
    const id = document.getElementById('userBlockEditId').value;
    const active = document.getElementById('userBlockEditActive').value;
    const params = new URLSearchParams({
        active: active,
        reason: document.getElementById('userBlockEditReason').value.trim(),
        expiresAt: document.getElementById('userBlockEditExpiresAt').value
    });
    const res = await fetch(CTX + '/admin/blocks/user-blocks/' + id + '/update', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saved);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saveFailed, 'error');
    }
}

async function submitBatch() {
    const params = new URLSearchParams({
        batchCode: document.getElementById('batchCode').value.trim(),
        batchName: document.getElementById('batchName').value.trim(),
        sourceType: document.getElementById('batchSourceType').value,
        sourceName: document.getElementById('batchSourceName').value.trim(),
        batchRuleAction: document.getElementById('batchRuleAction').value,
        defaultRulePriority: document.getElementById('batchDefaultPriority').value,
        defaultDisableStrategy: document.getElementById('batchDisableStrategy').value,
        defaultEnableStrategy: document.getElementById('batchEnableStrategy').value,
        description: document.getElementById('batchDescription').value.trim()
    });
    const res = await fetch(CTX + '/admin/blocks/batches', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.created);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.createFailed, 'error');
    }
}

async function submitBatchEdit() {
    const id = document.getElementById('batchEditId').value;
    const params = new URLSearchParams({
        batchCode: document.getElementById('batchEditCode').value.trim(),
        batchName: document.getElementById('batchEditName').value.trim(),
        sourceType: document.getElementById('batchEditSourceType').value,
        sourceName: document.getElementById('batchEditSourceName').value.trim(),
        batchRuleAction: document.getElementById('batchEditRuleAction').value,
        defaultRulePriority: document.getElementById('batchEditPriority').value,
        defaultDisableStrategy: document.getElementById('batchEditDisableStrategy').value,
        defaultEnableStrategy: document.getElementById('batchEditEnableStrategy').value,
        description: document.getElementById('batchEditDescription').value.trim()
    });
    const res = await fetch(CTX + '/admin/blocks/batches/' + id + '/update', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saved);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saveFailed, 'error');
    }
}

function openBatchToggleModal(button) {
    const nextActive = button.dataset.active === 'true';
    const batchName = button.dataset.batchName;
    const effectiveRules = button.dataset.effectiveRules;
    const activeRules = button.dataset.activeRules;
    const optionSelect = document.getElementById('batchToggleOption');
    optionSelect.innerHTML = '';

    document.getElementById('batchToggleId').value = button.dataset.id;
    document.getElementById('batchToggleActive').value = nextActive ? 'true' : 'false';
    document.getElementById('batchToggleTitle').textContent = nextActive ? '<spring:message code="admin.blocks.batchReactivate" javaScriptEscape="true"/>' : '<spring:message code="admin.blocks.batchDeactivate" javaScriptEscape="true"/>';

    if (nextActive) {
        document.getElementById('batchToggleSummary').textContent = ADMIN_BLOCK_MSG.batchToggleEnableSummary.replace('{0}', batchName);
        optionSelect.innerHTML =
            '<option value="BATCH_ONLY">BATCH_ONLY</option>' +
            '<option value="RESTORE_BATCH_CONTROL">RESTORE_BATCH_CONTROL</option>' +
            '<option value="FORCE_ENABLE_ALL">FORCE_ENABLE_ALL</option>';
        optionSelect.value = button.dataset.defaultEnableStrategy || 'BATCH_ONLY';
    } else {
        document.getElementById('batchToggleSummary').textContent = ADMIN_BLOCK_MSG.batchToggleDisableSummary
            .replace('{0}', batchName)
            .replace('{1}', effectiveRules)
            .replace('{2}', activeRules);
        optionSelect.innerHTML =
            '<option value="BATCH_ONLY">BATCH_ONLY</option>' +
            '<option value="CASCADE_ACTIVE_RULES">CASCADE_ACTIVE_RULES</option>';
        optionSelect.value = button.dataset.defaultDisableStrategy || 'BATCH_ONLY';
    }

    document.getElementById('batchToggleDescription').value = '';
    document.getElementById('batchToggleModal').classList.add('open');
}

async function fetchHistoryCurrentSetting(button) {
    const historyId = button.dataset.historyId;
    if (!historyId) return null;

    const url = CTX + '/admin/blocks/histories/' + encodeURIComponent(historyId) + '/current-setting';
    const res = await fetch(url, {
        headers: {'X-Requested-With': 'XMLHttpRequest'}
    });
    const data = await res.json();
    if (!res.ok || !data.success) {
        throw new Error(data.message || ADMIN_BLOCK_MSG.fetchError);
    }
    return data;
}

function buildHistoryCurrentButton(sourceButton, data) {
    return {
        dataset: Object.assign({}, data || {}, {
            templateId: sourceButton.dataset.templateId || ''
        })
    };
}

async function openHistoryCurrent(button) {
    try {
        const response = await fetchHistoryCurrentSetting(button);
        if (response && response.found && response.data) {
            const resolvedButton = buildHistoryCurrentButton(button, response.data);
            if (response.currentType === 'BATCH') {
                openBatchEditor(resolvedButton);
                return;
            }
            if (response.currentType === 'USER_BLOCK') {
                openUserBlockEditor(resolvedButton);
                return;
            }
            openIpRuleEditor(resolvedButton);
            return;
        }
    } catch (error) {
        adm_toast(error.message || ADMIN_BLOCK_MSG.fetchError, 'error');
        return;
    }

    if (button.dataset.templateId) {
        openBlockDetail(button.dataset.templateId, ADMIN_BLOCK_MSG.blockDetailTitle);
    }
    adm_toast(ADMIN_BLOCK_MSG.historyCurrentMissing, 'error');
}

async function submitBatchToggle() {
    const id = document.getElementById('batchToggleId').value;
    const active = document.getElementById('batchToggleActive').value;
    const operationOption = document.getElementById('batchToggleOption').value;
    const description = document.getElementById('batchToggleDescription').value.trim();
    const params = new URLSearchParams({
        active: active,
        operationOption: operationOption,
        description: description
    });
    const res = await fetch(CTX + '/admin/blocks/batches/' + id + '/toggle', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updated);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updateFailed, 'error');
    }
}

document.addEventListener('click', function (e) {
    const tabButton = e.target.closest('.js-block-tab');
    if (tabButton) {
        activateBlockTab(tabButton.dataset.tab);
        return;
    }

    const memberDetailBtn = e.target.closest('.js-open-member-detail');
    if (memberDetailBtn) {
        openMemberDetailModal(memberDetailBtn.dataset.userIdx);
        return;
    }

    const expiryPresetBtn = e.target.closest('.js-expiry-preset');
    if (expiryPresetBtn) {
        applyExpiryPreset(expiryPresetBtn.dataset.target, expiryPresetBtn.dataset.days);
        return;
    }

    const expiryClearBtn = e.target.closest('.js-expiry-clear');
    if (expiryClearBtn) {
        clearExpiryPreset(expiryClearBtn.dataset.target);
        return;
    }

    const detailBtn = e.target.closest('.js-detail-open');
    if (detailBtn) {
        openBlockDetail(detailBtn.dataset.templateId, ADMIN_BLOCK_MSG.blockDetailTitle);
        return;
    }

    const userBlockEditorBtn = e.target.closest('.js-open-user-block-editor');
    if (userBlockEditorBtn) {
        openUserBlockEditor(userBlockEditorBtn);
        return;
    }

    const ipRuleEditorBtn = e.target.closest('.js-open-ip-rule-editor');
    if (ipRuleEditorBtn) {
        openIpRuleEditor(ipRuleEditorBtn);
        return;
    }

    const releaseBtn = e.target.closest('.js-release-user-block');
    if (releaseBtn) {
        releaseUserBlock(releaseBtn.dataset.targetKey);
        return;
    }

    const ipToggleBtn = e.target.closest('.js-toggle-ip-rule');
    if (ipToggleBtn) {
        toggleIpRule(ipToggleBtn.dataset.id, ipToggleBtn.dataset.active === 'true');
        return;
    }

    const returnBtn = e.target.closest('.js-return-to-batch');
    if (returnBtn) {
        returnToBatch(returnBtn.dataset.id);
        return;
    }

    const batchToggleBtn = e.target.closest('.js-open-batch-toggle');
    if (batchToggleBtn) {
        openBatchToggleModal(batchToggleBtn);
        return;
    }

    const batchEditorBtn = e.target.closest('.js-open-batch-editor');
    if (batchEditorBtn) {
        openBatchEditor(batchEditorBtn);
        return;
    }

    const historyCurrentBtn = e.target.closest('.js-open-history-current');
    if (historyCurrentBtn) {
        openHistoryCurrent(historyCurrentBtn);
        return;
    }

    const prevBtn = e.target.closest('.js-local-prev');
    if (prevBtn) {
        const section = prevBtn.dataset.section;
        const state = getLocalState(section);
        state.page -= 1;
        renderLocalSection(section);
        return;
    }

    const nextBtn = e.target.closest('.js-local-next');
    if (nextBtn) {
        const section = nextBtn.dataset.section;
        const state = getLocalState(section);
        state.page += 1;
        renderLocalSection(section);
    }
});

document.querySelectorAll('.adm-modal-overlay').forEach(function (overlay) {
    overlay.addEventListener('click', function (e) {
        if (e.target === overlay) {
            overlay.classList.remove('open');
        }
    });
});

initializeLocalSections();
activateBlockTab(new URLSearchParams(window.location.search).get('tab') || 'dashboard');
</script>
<%@ include file="../layout-close.jsp" %>
