<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<div class="adm-content">
    <div class="adm-card adm-block-card-spaced">
        <div class="adm-card-body">
            <div class="adm-kpi-grid adm-block-kpi-grid">
                <c:set var="kpiPct1" value="${totalUserCount > 0 ? activeUserBlockCount * 100 / totalUserCount : 0}"/>
                <c:if test="${kpiPct1 > 100}"><c:set var="kpiPct1" value="100"/></c:if>
                <button type="button" class="adm-kpi-card adm-kpi-nav-btn" onclick="activateBlockTab('user-blocks');renderSectionByMode('user-blocks');">
                    <div class="adm-kpi-label">${msg_admin_blocks_kpi_activeUserBlocks}</div>
                    <div class="adm-kpi-value-row">
                        <span class="adm-kpi-num" title="${msg_admin_blocks_kpi_tooltip_numUserBlocks_js}">${activeUserBlockCount}</span>
                        <span class="adm-kpi-sep">/</span>
                        <span class="adm-kpi-den" title="${msg_admin_blocks_kpi_tooltip_denTotalUsers_js}">${totalUserCount}</span>
                    </div>
                    <div class="adm-kpi-bar-wrap" title="${kpiPct1}%">
                        <div class="adm-kpi-bar-fill" style="width:${kpiPct1}%;"></div>
                    </div>
                    <div class="adm-kpi-sub">${msg_admin_blocks_dashboard_stat_userBlocks}</div>
                </button>
                <c:set var="kpiPct2" value="${totalIpRuleCount > 0 ? activeIpBlockCount * 100 / totalIpRuleCount : 0}"/>
                <c:if test="${kpiPct2 > 100}"><c:set var="kpiPct2" value="100"/></c:if>
                <button type="button" class="adm-kpi-card adm-kpi-nav-btn" onclick="activateBlockTab('ip-rules');renderSectionByMode('ip-rules');">
                    <div class="adm-kpi-label">${msg_admin_blocks_kpi_activePolicies}</div>
                    <div class="adm-kpi-value-row">
                        <span class="adm-kpi-num" title="${msg_admin_blocks_kpi_tooltip_numActivePolicies_js}">${activeIpBlockCount}</span>
                        <span class="adm-kpi-sep">/</span>
                        <span class="adm-kpi-den" title="${msg_admin_blocks_kpi_tooltip_denTotalIpRules_js}">${totalIpRuleCount}</span>
                    </div>
                    <div class="adm-kpi-bar-wrap" title="${kpiPct2}%">
                        <div class="adm-kpi-bar-fill" style="width:${kpiPct2}%;"></div>
                    </div>
                    <div class="adm-kpi-sub">${msg_admin_blocks_dashboard_stat_ipRules}</div>
                </button>
                <c:set var="kpiPct3" value="${blockHistoryCount > 0 ? todayBlockCount * 100 / blockHistoryCount : 0}"/>
                <c:if test="${kpiPct3 > 100}"><c:set var="kpiPct3" value="100"/></c:if>
                <button type="button" class="adm-kpi-card adm-kpi-nav-btn" onclick="activateBlockTab('histories');renderSectionByMode('histories');">
                    <div class="adm-kpi-label">${msg_admin_blocks_kpi_history}</div>
                    <div class="adm-kpi-value-row">
                        <span class="adm-kpi-num" title="${msg_admin_blocks_kpi_tooltip_numTodayBlocks_js}">${todayBlockCount}</span>
                        <span class="adm-kpi-sep">/</span>
                        <span class="adm-kpi-den" title="${msg_admin_blocks_kpi_tooltip_denTotalHistory_js}">${blockHistoryCount}</span>
                    </div>
                    <div class="adm-kpi-bar-wrap" title="${kpiPct3}%">
                        <div class="adm-kpi-bar-fill" style="width:${kpiPct3}%;"></div>
                    </div>
                    <div class="adm-kpi-sub">${msg_admin_blocks_dashboard_stat_history}</div>
                </button>
                <c:set var="kpiPct4" value="${totalBatchCount > 0 ? activeBatchCount * 100 / totalBatchCount : 0}"/>
                <c:if test="${kpiPct4 > 100}"><c:set var="kpiPct4" value="100"/></c:if>
                <button type="button" class="adm-kpi-card adm-kpi-nav-btn" onclick="activateBlockTab('batches');renderSectionByMode('batches');">
                    <div class="adm-kpi-label">${msg_admin_blocks_kpi_activeBatches}</div>
                    <div class="adm-kpi-value-row">
                        <span class="adm-kpi-num" title="${msg_admin_blocks_kpi_tooltip_numActiveBatches_js}">${activeBatchCount}</span>
                        <span class="adm-kpi-sep">/</span>
                        <span class="adm-kpi-den" title="${msg_admin_blocks_kpi_tooltip_denTotalBatches_js}">${totalBatchCount}</span>
                    </div>
                    <div class="adm-kpi-bar-wrap" title="${kpiPct4}%">
                        <div class="adm-kpi-bar-fill" style="width:${kpiPct4}%;"></div>
                    </div>
                    <div class="adm-kpi-sub">${msg_admin_blocks_dashboard_stat_batches}</div>
                </button>
            </div>
        </div>
    </div>

    <div class="adm-card adm-block-card-spaced">
        <div class="adm-card-body adm-block-action-card-body">
            <div>
                <div class="adm-block-action-title">${msg_admin_blocks_runtimeCache_title}</div>
                <div class="adm-block-action-desc">${msg_admin_blocks_runtimeCache_desc}</div>
            </div>
            <button type="button" class="adm-btn adm-btn-primary js-sync-block-cache">${msg_admin_blocks_runtimeCache_sync}</button>
        </div>
    </div>


    <div class="adm-card adm-block-card-spaced">
        <div class="adm-card-body adm-block-action-card-body is-bottom">
            <div class="adm-block-feed-main">
                <div class="adm-block-action-title">${msg_admin_blocks_policyFeed_title}</div>
                <div class="adm-block-action-desc">${msg_admin_blocks_policyFeed_desc}</div>
            </div>
            <form id="policyFeedUploadForm" enctype="multipart/form-data" class="adm-block-feed-form">
                <label class="adm-block-field">
                    ${msg_admin_blocks_policyFeed_sourceName}
                    <input class="adm-input adm-block-source-input" type="text" name="sourceName" value="MANUAL_UPLOAD_FEED">
                </label>
                <label class="adm-block-field">
                    ${msg_admin_context_ruleAction}
                    <select class="adm-select" name="defaultRuleAction">
                        <option value="BLOCK">${msg_admin_context_ruleAction_block}</option>
                        <option value="ALLOW">${msg_admin_context_ruleAction_allow}</option>
                    </select>
                </label>
                <label class="adm-block-field">
                    ${msg_admin_blocks_policyFeed_file}
                    <input class="adm-input" type="file" name="file" accept=".csv,.json" required>
                </label>
                <button type="submit" class="adm-btn adm-btn-primary">${msg_admin_blocks_policyFeed_upload}</button>
            </form>
            <div id="policyFeedUploadResult" class="adm-block-upload-result"></div>
        </div>
    </div>

    <div class="adm-card adm-block-card-spaced">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/blocks">
                <input type="hidden" name="tab" id="blockActiveTabInput" value="${fn:escapeXml(param.tab)}">
                <div class="adm-filter-bar">
                    <div class="adm-block-filter-main">
                        <div class="adm-filter-label">${msg_admin_blocks_globalSearch}</div>
                        <div class="adm-search-box">
                            <span class="adm-search-ico">🔍</span>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${msg_admin_blocks_searchPlaceholder}">
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_blocks_ruleState}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="ACTIVE" ${search.status=='ACTIVE'?'selected':''}>${msg_admin_blocks_ruleOn}</option>
                            <option value="INACTIVE" ${search.status=='INACTIVE'?'selected':''}>${msg_admin_blocks_ruleOff}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_blocks_scope}</div>
                        <select class="adm-select" name="scope">
                            <option value="ALL" ${search.scope=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="USER_ACTION" ${search.scope=='USER_ACTION'?'selected':''}>${msg_admin_blocks_scope_userAction}</option>
                            <option value="GLOBAL" ${search.scope=='GLOBAL'?'selected':''}>${msg_admin_blocks_scope_global}</option>
                            <option value="AUTO_DETECTION" ${search.scope=='AUTO_DETECTION'?'selected':''}>${msg_admin_blocks_scope_autoDetection}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_context_ruleAction}</div>
                        <select class="adm-select" name="ruleAction">
                            <option value="ALL" ${search.ruleAction=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="BLOCK" ${search.ruleAction=='BLOCK'?'selected':''}>${msg_admin_context_ruleAction_block}</option>
                            <option value="ALLOW" ${search.ruleAction=='ALLOW'?'selected':''}>${msg_admin_context_ruleAction_allow}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_blocks_controlMode}</div>
                        <select class="adm-select" name="controlMode">
                            <option value="ALL" ${search.controlMode=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="MANUAL" ${search.controlMode=='MANUAL'?'selected':''}>${msg_admin_blocks_control_manual}</option>
                            <option value="BATCH" ${search.controlMode=='BATCH'?'selected':''}>${msg_admin_blocks_control_batch}</option>
                            <option value="MANUAL_OVERRIDE" ${search.controlMode=='MANUAL_OVERRIDE'?'selected':''}>${msg_admin_blocks_control_override}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_blocks_matchType}</div>
                        <select class="adm-select" name="matchType">
                            <option value="ALL" ${search.matchType=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="SINGLE_IP" ${search.matchType=='SINGLE_IP'?'selected':''}>${msg_admin_blocks_match_singleIp}</option>
                            <option value="CIDR" ${search.matchType=='CIDR'?'selected':''}>${msg_admin_blocks_match_cidr}</option>
                            <option value="RANGE" ${search.matchType=='RANGE'?'selected':''}>${msg_admin_blocks_match_range}</option>
                            <option value="COUNTRY" ${search.matchType=='COUNTRY'?'selected':''}>${msg_admin_blocks_match_country}</option>
                            <option value="ASN" ${search.matchType=='ASN'?'selected':''}>${msg_admin_blocks_match_asn}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_context_category}</div>
                        <select class="adm-select" name="category">
                            <option value="ALL" ${search.category=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="MANUAL" ${search.category=='MANUAL'?'selected':''}>${msg_admin_blocks_category_manual}</option>
                            <option value="SPAM" ${search.category=='SPAM'?'selected':''}>${msg_admin_blocks_category_spam}</option>
                            <option value="ABUSE" ${search.category=='ABUSE'?'selected':''}>${msg_admin_blocks_category_abuse}</option>
                            <option value="BRUTE_FORCE" ${search.category=='BRUTE_FORCE'?'selected':''}>${msg_admin_blocks_category_bruteForce}</option>
                            <option value="GEO" ${search.category=='GEO'?'selected':''}>${msg_admin_blocks_category_geo}</option>
                            <option value="VPN" ${search.category=='VPN'?'selected':''}>${msg_admin_blocks_category_vpn}</option>
                            <option value="SECURITY" ${search.category=='SECURITY'?'selected':''}>${msg_admin_blocks_category_security}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_blocks_effectiveState}</div>
                        <select class="adm-select" name="effectiveStatus">
                            <option value="ALL" ${search.effectiveStatus=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="EFFECTIVE" ${search.effectiveStatus=='EFFECTIVE'?'selected':''}>${msg_admin_blocks_effective_effective}</option>
                            <option value="RULE_INACTIVE" ${search.effectiveStatus=='RULE_INACTIVE'?'selected':''}>${msg_admin_blocks_effective_ruleInactive}</option>
                            <option value="BATCH_INACTIVE" ${search.effectiveStatus=='BATCH_INACTIVE'?'selected':''}>${msg_admin_blocks_effective_batchInactive}</option>
                            <option value="EXPIRED" ${search.effectiveStatus=='EXPIRED'?'selected':''}>${msg_admin_blocks_effective_expired}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_context_batch}</div>
                        <select class="adm-select" name="batchId">
                            <option value="">${msg_admin_common_all}</option>
                            <c:forEach var="bt" items="${batchFilterOptions}">
                                <option value="${bt.ipBlockBatchIdx}" ${search.batchId == bt.ipBlockBatchIdx ? 'selected' : ''}>${bt.batchName} (${bt.batchCode})</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="adm-block-filter-actions">
                        <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_apply}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/blocks" onclick="return resetBlockFilters();">${msg_admin_common_reset}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-tab-row adm-block-tab-row adm-block-card-spaced" id="blockTabBar">
        <button type="button" class="adm-tab js-block-tab" data-tab="dashboard">${msg_admin_layout_menu_dashboard}</button>
        <button type="button" class="adm-tab js-block-tab" data-tab="all">${msg_admin_common_all}</button>
        <button type="button" class="adm-tab js-block-tab" data-tab="user-blocks">${msg_admin_blocks_section_userBlocks}</button>
        <button type="button" class="adm-tab js-block-tab" data-tab="ip-rules">${msg_admin_blocks_section_ipRules}</button>
        <button type="button" class="adm-tab js-block-tab" data-tab="batches">${msg_admin_blocks_section_batches}</button>
        <button type="button" class="adm-tab js-block-tab" data-tab="histories">${msg_admin_blocks_section_histories}</button>
    </div>

    <div class="adm-card js-dashboard-panel adm-block-card-spaced is-hidden">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_blocks_dashboard_title}</div>
            <div class="adm-card-sub">${msg_admin_blocks_dashboard_sub}</div>
        </div>
        <div class="adm-card-body">
            <div class="adm-block-dashboard-grid">
                <div class="adm-block-dashboard-insight">
                    <div class="adm-block-insight-title">${msg_admin_blocks_dashboard_insight_priorityTitle}</div>
                    <div class="adm-block-insight-body">
                        <span>${msg_admin_blocks_dashboard_insight_priority1}</span>
                        <span>${msg_admin_blocks_dashboard_insight_priority2}</span>
                        <span>${msg_admin_blocks_dashboard_insight_priority3}</span>
                    </div>
                </div>
                <div class="adm-block-dashboard-insight">
                    <div class="adm-block-insight-title">${msg_admin_blocks_dashboard_insight_quickNavTitle}</div>
                    <div class="adm-block-insight-actions">
                        <button type="button" class="adm-inline-chip" onclick="activateBlockTab('user-blocks');renderSectionByMode('user-blocks');">${msg_admin_blocks_dashboard_insight_userBlocksChip}</button>
                        <button type="button" class="adm-inline-chip" onclick="activateBlockTab('ip-rules');renderSectionByMode('ip-rules');">${msg_admin_blocks_dashboard_insight_ipRulesChip}</button>
                        <button type="button" class="adm-inline-chip" onclick="activateBlockTab('histories');renderSectionByMode('histories');">${msg_admin_blocks_dashboard_insight_historyChip}</button>
                    </div>
                </div>
            </div>
            <div class="adm-dashboard-list-grid">
                <div class="adm-card adm-dashboard-nested-card">
                    <div class="adm-card-head">
                        <div class="adm-card-title adm-dashboard-title">${msg_admin_blocks_dashboard_recentUserBlocks}</div>
                        <div class="adm-dashboard-head-actions">
                            <div class="adm-card-sub">${msg_admin_blocks_dashboard_topFive}</div>
                            <button type="button" class="adm-dash-sort-reset js-dash-sort-reset is-hidden" data-table="dash-user-blocks"></button>
                        </div>
                    </div>
                    <div class="adm-card-body adm-block-card-body">
                        <div class="adm-table-wrap">
                            <table class="adm-table" id="dash-user-blocks">
                                <thead><tr>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="0" onclick="sortDashboardTable(this.closest('table'), 0)">${msg_admin_common_member}</th>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="1" onclick="sortDashboardTable(this.closest('table'), 1)">${msg_admin_common_target}</th>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="2" onclick="sortDashboardTable(this.closest('table'), 2)">${msg_admin_common_status}</th>
                                    <th onclick="openFirstBlockSectionAction('user-blocks')">${msg_admin_common_action}</th>
                                </tr></thead>
                                <tbody>
                                <c:forEach var="b" items="${dashboardUserBlocks}">
                                    <tr>
                                        <td>${empty b.nickname ? '-' : b.nickname}</td>
                                        <td>
                                            <div>${empty b.blockedIp ? b.blockTargetKey : b.blockedIp}</div>
                                            <div class="adm-inline-actions">
                                                <c:if test="${not empty b.blockedIp}">
                                                    <button type="button"
                                                            class="adm-inline-chip js-open-ip-context"
                                                            data-ip-address="${b.blockedIp}"
                                                            data-default-tab="blocks">
                                                        ${msg_admin_common_viewDetail}
                                                    </button>
                                                </c:if>
                                                <button type="button"
                                                        class="adm-inline-chip js-apply-block-filter"
                                                        data-section="user-blocks"
                                                        data-field="target"
                                                        data-keyword="${fn:escapeXml(empty b.blockedIp ? b.blockTargetKey : b.blockedIp)}">
                                                    ${msg_admin_common_sameTarget}
                                                </button>
                                            </div>
                                        </td>
                                        <td>
                                            <button type="button"
                                                    class="adm-inline-chip adm-dashboard-status-filter js-apply-block-filter"
                                                    data-section="user-blocks"
                                                    data-field="snapshotStatus"
                                                    data-keyword="${fn:escapeXml(b.snapshotStatus)}">
                                                <span class="status-badge ${b.active ? 'ACTIVE' : 'DORMANT'}">${b.snapshotStatus}</span>
                                            </button>
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
                                                    data-blocked-at="-"
                                                    data-last-history-at="-"
                                                    data-sync-at="-">${msg_admin_common_settings}</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty dashboardUserBlocks}">
                                    <tr><td colspan="4" class="adm-local-empty-cell">${msg_admin_common_noData}</td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="adm-card adm-dashboard-nested-card">
                    <div class="adm-card-head">
                        <div class="adm-card-title adm-dashboard-title">${msg_admin_blocks_dashboard_recentIpRules}</div>
                        <div class="adm-dashboard-head-actions">
                            <div class="adm-card-sub">${msg_admin_blocks_dashboard_ipRulesSub}</div>
                            <button type="button" class="adm-dash-sort-reset js-dash-sort-reset is-hidden" data-table="dash-ip-rules"></button>
                        </div>
                    </div>
                    <div class="adm-card-body adm-block-card-body">
                        <div class="adm-table-wrap">
                            <table class="adm-table" id="dash-ip-rules">
                                <thead><tr>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="0" onclick="sortDashboardTable(this.closest('table'), 0)">${msg_admin_common_target}</th>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="1" onclick="sortDashboardTable(this.closest('table'), 1)">${msg_admin_common_actionLabel}</th>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="2" onclick="sortDashboardTable(this.closest('table'), 2)">${msg_admin_blocks_effectiveState}</th>
                                    <th onclick="openFirstBlockSectionAction('ip-rules')">${msg_admin_common_action}</th>
                                </tr></thead>
                                <tbody>
                                <c:forEach var="r" items="${dashboardIpBlocks}">
                                    <tr>
                                        <td>
                                            <div>${empty r.targetDisplayValue ? r.blockTargetKey : r.targetDisplayValue}</div>
                                            <div class="adm-inline-actions">
                                                <c:if test="${not empty r.ipAddress}">
                                                    <button type="button"
                                                            class="adm-inline-chip js-open-ip-context"
                                                            data-ip-address="${r.ipAddress}"
                                                            data-default-tab="blocks">
                                                        ${msg_admin_common_viewDetail}
                                                    </button>
                                                </c:if>
                                                <button type="button"
                                                        class="adm-inline-chip js-apply-block-filter"
                                                        data-section="ip-rules"
                                                        data-field="target"
                                                        data-keyword="${fn:escapeXml(empty r.targetDisplayValue ? r.blockTargetKey : r.targetDisplayValue)}">
                                                    ${msg_admin_common_sameTarget}
                                                </button>
                                                <c:if test="${not empty r.ipBlockBatchIdx}">
                                                    <button type="button"
                                                            class="adm-inline-chip js-apply-block-filter"
                                                            data-section="ip-rules"
                                                            data-field="batch"
                                                            data-keyword="${fn:escapeXml(empty r.batchCode ? r.batchName : r.batchCode)}">
                                                        ${msg_admin_common_sameBatch}
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
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
                                                    data-batch-name="${fn:escapeXml(empty r.batchName ? msg_admin_blocks_individualRule : r.batchName)}"
                                                    data-batch-code="${fn:escapeXml(empty r.batchCode ? '' : r.batchCode)}"
                                                    data-batch-id="${empty r.ipBlockBatchIdx ? '' : r.ipBlockBatchIdx}"
                                                    data-blocked-at="-"
                                                    data-expires-display="-"
                                                    data-active="${r.active ? 'true' : 'false'}">${msg_admin_common_settings}</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty dashboardIpBlocks}">
                                    <tr><td colspan="4" class="adm-local-empty-cell">${msg_admin_common_noData}</td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="adm-card adm-dashboard-nested-card">
                    <div class="adm-card-head">
                        <div class="adm-card-title adm-dashboard-title">${msg_admin_blocks_dashboard_recentBatchOps}</div>
                        <div class="adm-dashboard-head-actions">
                            <div class="adm-card-sub">${msg_admin_blocks_dashboard_batchOpsSub}</div>
                            <button type="button" class="adm-dash-sort-reset js-dash-sort-reset is-hidden" data-table="dash-batches"></button>
                        </div>
                    </div>
                    <div class="adm-card-body adm-block-card-body">
                        <div class="adm-table-wrap">
                            <table class="adm-table" id="dash-batches">
                                <thead><tr>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="0" onclick="sortDashboardTable(this.closest('table'), 0)">${msg_admin_context_batch}</th>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="1" onclick="sortDashboardTable(this.closest('table'), 1)">${msg_admin_common_actionLabel}</th>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="2" onclick="sortDashboardTable(this.closest('table'), 2)">${msg_admin_blocks_impact}</th>
                                    <th onclick="openFirstBlockSectionAction('batches')">${msg_admin_common_action}</th>
                                </tr></thead>
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
                                                        data-batch-name="${fn:escapeXml(empty op.batchName ? '' : op.batchName)}">${msg_admin_common_settings}</button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty batchOperations}">
                                    <tr><td colspan="4" class="adm-local-empty-cell">${msg_admin_common_noData}</td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="adm-card adm-dashboard-nested-card">
                    <div class="adm-card-head">
                        <div class="adm-card-title adm-dashboard-title">${msg_admin_blocks_dashboard_recentHistory}</div>
                        <div class="adm-dashboard-head-actions">
                            <div class="adm-card-sub">${msg_admin_blocks_dashboard_historySub}</div>
                            <button type="button" class="adm-dash-sort-reset js-dash-sort-reset is-hidden" data-table="dash-histories"></button>
                        </div>
                    </div>
                    <div class="adm-card-body adm-block-card-body">
                        <div class="adm-table-wrap">
                            <table class="adm-table" id="dash-histories">
                                <thead><tr>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="0" onclick="sortDashboardTable(this.closest('table'), 0)">${msg_admin_common_time}</th>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="1" onclick="sortDashboardTable(this.closest('table'), 1)">${msg_admin_common_target}</th>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="2" onclick="sortDashboardTable(this.closest('table'), 2)">${msg_admin_blocks_changeKind}</th>
                                    <th class="adm-dashboard-sortable" data-dashboard-enhanced="true" data-sort-index="3" onclick="sortDashboardTable(this.closest('table'), 3)">${msg_admin_blocks_result}</th>
                                    <th onclick="openFirstBlockSectionAction('histories')">${msg_admin_common_action}</th>
                                </tr></thead>
                                <tbody>
                                <c:forEach var="h" items="${dashboardHistories}">
                                    <c:set var="historyDashboardAt" value="${h.blockedAtDate}"/>
                                    <c:if test="${not empty h.releasedAtDate}">
                                        <c:set var="historyDashboardAt" value="${h.releasedAtDate}"/>
                                    </c:if>
                                    <c:if test="${not empty h.listSyncedAtDate}">
                                        <c:set var="historyDashboardAt" value="${h.listSyncedAtDate}"/>
                                    </c:if>
                                    <fmt:formatDate var="historyDashboardTime" value="${historyDashboardAt}" pattern="MM.dd HH:mm"/>
                                    <c:set var="historyCurrentType" value="IP_RULE"/>
                                    <c:if test="${h.blockScope == 'USER_ACTION'}">
                                        <c:set var="historyCurrentType" value="USER_BLOCK"/>
                                    </c:if>
                                    <c:if test="${not empty h.batchOperationIdx and not empty h.ipBlockBatchIdx}">
                                        <c:set var="historyCurrentType" value="BATCH"/>
                                    </c:if>
                                    <tr>
                                        <td>
                                            <button type="button" class="adm-cell-link" data-section="histories" data-field="blockedAt" data-keyword="${fn:escapeXml(historyDashboardTime)}" onclick="applyBlockLocalFilter(this.dataset.section, this.dataset.field, this.dataset.keyword)">
                                                <span>${empty historyDashboardTime ? '-' : historyDashboardTime}</span>
                                            </button>
                                        </td>
                                        <td>
                                            <div>${h.blockTargetKey}</div>
                                            <div class="adm-inline-actions">
                                                <c:if test="${not empty h.blockedIp}">
                                                    <button type="button"
                                                            class="adm-inline-chip js-open-ip-context"
                                                            data-ip-address="${h.blockedIp}"
                                                            data-default-tab="blocks">
                                                        ${msg_admin_common_viewDetail}
                                                    </button>
                                                </c:if>
                                                <button type="button"
                                                        class="adm-inline-chip js-apply-block-filter"
                                                        data-section="histories"
                                                        data-field="target"
                                                        data-keyword="${fn:escapeXml(h.blockTargetKey)}">
                                                    ${msg_admin_common_sameTarget}
                                                </button>
                                                <c:if test="${not empty h.ipBlockBatchIdx}">
                                                    <button type="button"
                                                            class="adm-inline-chip js-apply-block-filter"
                                                            data-section="histories"
                                                            data-field="batch"
                                                            data-keyword="${fn:escapeXml(empty h.batchCode ? h.batchName : h.batchCode)}">
                                                        ${msg_admin_common_sameBatch}
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
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
                                                    data-template-id="detail-history-${h.blockIdx}">${msg_admin_blocks_currentSetting}</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty dashboardHistories}">
                                    <tr><td colspan="5" class="adm-local-empty-cell">${msg_admin_common_noData}</td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card js-section-card adm-block-card-spaced" data-section="user-blocks" data-enhanced="true">
        <div class="adm-card-head">
            <div>
                <div class="adm-card-title">${msg_admin_blocks_userBlocks_title}</div>
                <div class="adm-card-sub">${msg_admin_blocks_userBlocks_sub}</div>
            </div>
            <div class="adm-block-export-wrap">
                <select
