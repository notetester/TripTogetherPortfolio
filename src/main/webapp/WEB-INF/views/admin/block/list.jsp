<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="blocks"/>
<c:set var="pageTitle" value="차단 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div class="adm-kpi-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));">
                <div class="adm-kpi-card">
                    <div class="adm-kpi-label">활성 회원 차단</div>
                    <div class="adm-kpi-value">${activeUserBlockCount}</div>
                </div>
                <div class="adm-kpi-card">
                    <div class="adm-kpi-label">최종 적용 정책</div>
                    <div class="adm-kpi-value">${activeIpBlockCount}</div>
                </div>
                <div class="adm-kpi-card">
                    <div class="adm-kpi-label">차단 이력</div>
                    <div class="adm-kpi-value">${blockHistoryCount}</div>
                </div>
                <div class="adm-kpi-card">
                    <div class="adm-kpi-label">활성 배치</div>
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
                        <div class="adm-filter-label">통합 검색</div>
                        <div class="adm-search-box">
                            <span class="adm-search-ico">🔍</span>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="대상/사유/배치 검색">
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">개별 상태</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}>전체</option>
                            <option value="ACTIVE" ${search.status=='ACTIVE'?'selected':''}>개별 ON</option>
                            <option value="INACTIVE" ${search.status=='INACTIVE'?'selected':''}>개별 OFF</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">출처 범위</div>
                        <select class="adm-select" name="scope">
                            <option value="ALL" ${search.scope=='ALL'?'selected':''}>전체</option>
                            <option value="USER_ACTION" ${search.scope=='USER_ACTION'?'selected':''}>회원 액션</option>
                            <option value="GLOBAL" ${search.scope=='GLOBAL'?'selected':''}>전역 정책</option>
                            <option value="AUTO_DETECTION" ${search.scope=='AUTO_DETECTION'?'selected':''}>자동 탐지</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">규칙 동작</div>
                        <select class="adm-select" name="ruleAction">
                            <option value="ALL" ${search.ruleAction=='ALL'?'selected':''}>전체</option>
                            <option value="BLOCK" ${search.ruleAction=='BLOCK'?'selected':''}>차단</option>
                            <option value="ALLOW" ${search.ruleAction=='ALLOW'?'selected':''}>허용</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">제어 방식</div>
                        <select class="adm-select" name="controlMode">
                            <option value="ALL" ${search.controlMode=='ALL'?'selected':''}>전체</option>
                            <option value="MANUAL" ${search.controlMode=='MANUAL'?'selected':''}>수동</option>
                            <option value="BATCH" ${search.controlMode=='BATCH'?'selected':''}>배치 제어</option>
                            <option value="MANUAL_OVERRIDE" ${search.controlMode=='MANUAL_OVERRIDE'?'selected':''}>수동 예외</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">매칭 방식</div>
                        <select class="adm-select" name="matchType">
                            <option value="ALL" ${search.matchType=='ALL'?'selected':''}>전체</option>
                            <option value="SINGLE_IP" ${search.matchType=='SINGLE_IP'?'selected':''}>단일 IP</option>
                            <option value="CIDR" ${search.matchType=='CIDR'?'selected':''}>CIDR</option>
                            <option value="RANGE" ${search.matchType=='RANGE'?'selected':''}>범위</option>
                            <option value="COUNTRY" ${search.matchType=='COUNTRY'?'selected':''}>국가</option>
                            <option value="ASN" ${search.matchType=='ASN'?'selected':''}>ASN</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">분류</div>
                        <select class="adm-select" name="category">
                            <option value="ALL" ${search.category=='ALL'?'selected':''}>전체</option>
                            <option value="MANUAL" ${search.category=='MANUAL'?'selected':''}>MANUAL</option>
                            <option value="SPAM" ${search.category=='SPAM'?'selected':''}>SPAM</option>
                            <option value="ABUSE" ${search.category=='ABUSE'?'selected':''}>ABUSE</option>
                            <option value="BRUTE_FORCE" ${search.category=='BRUTE_FORCE'?'selected':''}>BRUTE_FORCE</option>
                            <option value="GEO" ${search.category=='GEO'?'selected':''}>GEO</option>
                            <option value="VPN" ${search.category=='VPN'?'selected':''}>VPN</option>
                            <option value="SECURITY" ${search.category=='SECURITY'?'selected':''}>SECURITY</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">최종 적용</div>
                        <select class="adm-select" name="effectiveStatus">
                            <option value="ALL" ${search.effectiveStatus=='ALL'?'selected':''}>전체</option>
                            <option value="EFFECTIVE" ${search.effectiveStatus=='EFFECTIVE'?'selected':''}>평가중</option>
                            <option value="RULE_INACTIVE" ${search.effectiveStatus=='RULE_INACTIVE'?'selected':''}>개별 OFF</option>
                            <option value="BATCH_INACTIVE" ${search.effectiveStatus=='BATCH_INACTIVE'?'selected':''}>배치 미적용</option>
                            <option value="EXPIRED" ${search.effectiveStatus=='EXPIRED'?'selected':''}>만료</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">배치</div>
                        <select class="adm-select" name="batchId">
                            <option value="">전체</option>
                            <c:forEach var="bt" items="${batches}">
                                <option value="${bt.ipBlockBatchIdx}" ${search.batchId == bt.ipBlockBatchIdx ? 'selected' : ''}>${bt.batchName} (${bt.batchCode})</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:8px;">
                        <button class="adm-btn adm-btn-primary" type="submit">적용</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/blocks">초기화</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-tab-row adm-block-tab-row" id="blockTabBar" style="margin-bottom:20px;">
        <button type="button" class="adm-tab js-block-tab" data-tab="dashboard">대시보드</button>
        <button type="button" class="adm-tab js-block-tab" data-tab="all">전체</button>
        <button type="button" class="adm-tab js-block-tab" data-tab="user-blocks">회원 차단</button>
        <button type="button" class="adm-tab js-block-tab" data-tab="ip-rules">IP 정책 규칙</button>
        <button type="button" class="adm-tab js-block-tab" data-tab="batches">IP 정책 배치</button>
        <button type="button" class="adm-tab js-block-tab" data-tab="histories">통합 차단 이력</button>
    </div>

    <div class="adm-card js-dashboard-panel" style="margin-bottom:20px;display:none;">
        <div class="adm-card-head">
            <div class="adm-card-title">운영 대시보드</div>
            <div class="adm-card-sub">최근 항목을 빠르게 훑고 바로 모달에서 조정할 수 있습니다.</div>
        </div>
        <div class="adm-card-body">
            <div class="adm-kpi-grid" style="display:grid;grid-template-columns:1fr;row-gap:28px;">
                <div class="adm-card" style="margin:0;">
                    <div class="adm-card-head">
                        <div class="adm-card-title" style="font-size:15px;">최근 회원 차단</div>
                        <div class="adm-card-sub">현재 스냅샷 기준 상위 5건</div>
                    </div>
                    <div class="adm-card-body" style="padding:0;">
                        <div class="adm-table-wrap">
                            <table class="adm-table">
                                <thead><tr><th>회원</th><th>대상</th><th>상태</th><th>액션</th></tr></thead>
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
                                                    data-sync-at="-">설정</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty userBlocks}">
                                    <tr><td colspan="4" style="text-align:center;color:#64748b;">데이터가 없습니다.</td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="adm-card" style="margin:0;">
                    <div class="adm-card-head">
                        <div class="adm-card-title" style="font-size:15px;">최근 IP 정책 규칙</div>
                        <div class="adm-card-sub">허용/차단, 수동 예외를 함께 확인</div>
                    </div>
                    <div class="adm-card-body" style="padding:0;">
                        <div class="adm-table-wrap">
                            <table class="adm-table">
                                <thead><tr><th>대상</th><th>동작</th><th>최종 적용</th><th>액션</th></tr></thead>
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
                                                    data-batch-name="${fn:escapeXml(empty r.batchName ? '개별 규칙' : r.batchName)}"
                                                    data-batch-code="${fn:escapeXml(empty r.batchCode ? '' : r.batchCode)}"
                                                    data-batch-id="${empty r.ipBlockBatchIdx ? '' : r.ipBlockBatchIdx}"
                                                    data-blocked-at="-"
                                                    data-expires-display="-"
                                                    data-active="${r.active ? 'true' : 'false'}">설정</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty ipBlocks}">
                                    <tr><td colspan="4" style="text-align:center;color:#64748b;">데이터가 없습니다.</td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="adm-card" style="margin:0;">
                    <div class="adm-card-head">
                        <div class="adm-card-title" style="font-size:15px;">최근 배치 작업</div>
                        <div class="adm-card-sub">배치 제어와 복구 흐름</div>
                    </div>
                    <div class="adm-card-body" style="padding:0;">
                        <div class="adm-table-wrap">
                            <table class="adm-table">
                                <thead><tr><th>배치</th><th>작업</th><th>영향</th><th>액션</th></tr></thead>
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
                                                        data-batch-name="${fn:escapeXml(empty op.batchName ? '' : op.batchName)}">설정</button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty batchOperations}">
                                    <tr><td colspan="4" style="text-align:center;color:#64748b;">데이터가 없습니다.</td></tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="adm-card" style="margin:0;">
                    <div class="adm-card-head">
                        <div class="adm-card-title" style="font-size:15px;">최근 통합 이력</div>
                        <div class="adm-card-sub">현재 설정으로 바로 이어집니다.</div>
                    </div>
                    <div class="adm-card-body" style="padding:0;">
                        <div class="adm-table-wrap">
                            <table class="adm-table">
                                <thead><tr><th>대상</th><th>변경</th><th>결과</th><th>액션</th></tr></thead>
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
                                                    data-template-id="detail-history-${h.blockIdx}">현재 설정</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty histories}">
                                    <tr><td colspan="4" style="text-align:center;color:#64748b;">데이터가 없습니다.</td></tr>
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
            <div class="adm-card-title">현재 회원 차단 상태</div>
            <div class="adm-card-sub">회원 기준 현재 활성/비활성 스냅샷</div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="user-blocks">
                        <option value="all">전체 항목</option>
                        <option value="nickname">회원 닉네임</option>
                        <option value="userId">회원 아이디</option>
                        <option value="target">차단 대상</option>
                        <option value="reason">사유</option>
                        <option value="blockType">차단 유형</option>
                        <option value="blockedAt">차단 날짜</option>
                        <option value="expiresAt">만료 날짜</option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="user-blocks" placeholder="회원 차단 내 검색">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="user-blocks">초기화</button>
                </div>
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-page-size" data-section="user-blocks">
                        <option value="10">10개씩</option>
                        <option value="20" selected>20개씩</option>
                        <option value="50">50개씩</option>
                    </select>
                </div>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr><th>회원</th><th>유형</th><th>대상</th><th>상태</th><th>사유</th><th>차단 / 만료</th><th>액션</th></tr>
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
                                <div style="color:#94a3b8;">만료:
                                    <c:choose>
                                        <c:when test="${b.expiresAtDate != null}"><fmt:formatDate value="${b.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when>
                                        <c:otherwise>없음</c:otherwise>
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
                                        data-sync-at="${userBlockSyncText}">설정</button>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-user-${b.blockIdx}">이력</button>
                                <c:if test="${hasUserBlockAdmin and b.active}">
                                    <button type="button" class="adm-row-btn danger js-release-user-block" data-target-key="${fn:escapeXml(b.blockTargetKey)}">해제</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userBlocks}">
                        <tr><td colspan="7" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="user-blocks">
                <div class="adm-local-page-info js-local-page-info" data-section="user-blocks">0건</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="user-blocks">이전</button>
                    <span class="js-local-page-state" data-section="user-blocks">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="user-blocks">다음</button>
                </div>
            </div>
        </div>
    </div>

    <c:forEach var="b" items="${userBlocks}">
        <template id="detail-user-${b.blockIdx}">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">회원</div><div class="detail-value">${empty b.nickname ? '-' : b.nickname} / ${empty b.userId ? '-' : b.userId}</div></div>
                <div class="detail-item"><div class="detail-label">이메일</div><div class="detail-value">${empty b.userEmail ? '-' : b.userEmail}</div></div>
                <div class="detail-item"><div class="detail-label">차단 유형</div><div class="detail-value">${b.blockType}</div></div>
                <div class="detail-item"><div class="detail-label">대상 키</div><div class="detail-value">${b.blockTargetKey}</div></div>
                <div class="detail-item"><div class="detail-label">차단 IP</div><div class="detail-value">${empty b.blockedIp ? '-' : b.blockedIp}</div></div>
                <div class="detail-item"><div class="detail-label">상태</div><div class="detail-value">${b.active ? '활성' : '비활성'} / ${b.snapshotStatus}</div></div>
                <div class="detail-item"><div class="detail-label">처리 관리자</div><div class="detail-value">${empty b.blockedByNickname ? '-' : b.blockedByNickname}</div></div>
                <div class="detail-item"><div class="detail-label">해제 관리자</div><div class="detail-value">${empty b.releasedByNickname ? '-' : b.releasedByNickname}</div></div>
                <div class="detail-item"><div class="detail-label">차단 시각</div><div class="detail-value"><fmt:formatDate value="${b.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
                <div class="detail-item"><div class="detail-label">만료 시각</div><div class="detail-value"><c:choose><c:when test="${b.expiresAtDate != null}"><fmt:formatDate value="${b.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>없음</c:otherwise></c:choose></div></div>
                <div class="detail-item"><div class="detail-label">해제 시각</div><div class="detail-value"><c:choose><c:when test="${b.releasedAtDate != null}"><fmt:formatDate value="${b.releasedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
                <div class="detail-item"><div class="detail-label">동기화</div><div class="detail-value"><c:choose><c:when test="${b.syncedAtDate != null}"><fmt:formatDate value="${b.syncedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
            </div>
            <div class="detail-item" style="margin-top:14px;"><div class="detail-label">상세 사유</div><div class="detail-value">${empty b.reason ? '-' : fn:escapeXml(b.reason)}</div></div>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th>항목</th><th>값</th></tr></thead>
                <tbody>
                <tr><td>요청 ID</td><td>${empty b.blockRequestId ? '-' : b.blockRequestId}</td></tr>
                <tr><td>출처 범위</td><td>${empty b.blockScope ? '-' : b.blockScope}</td></tr>
                <tr><td>IP 매칭</td><td>${empty b.ipMatchType ? '-' : b.ipMatchType}</td></tr>
                <tr><td>최근 이력</td><td><c:choose><c:when test="${b.lastHistoryAtDate != null}"><fmt:formatDate value="${b.lastHistoryAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></td></tr>
                </tbody>
            </table>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th>관련 이력</th><th>상태</th><th>시각</th><th>사유</th></tr></thead>
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
                <div class="adm-card-title">IP 정책 규칙</div>
                <div class="adm-card-sub">차단과 허용 규칙, 배치 제어, 수동 예외를 함께 관리합니다.</div>
            </div>
            <div style="display:flex;gap:8px;">
                <c:if test="${hasBlockPolicyAdmin}">
                    <button class="adm-btn adm-btn-ghost" type="button" onclick="openBatchModal()">배치 생성</button>
                </c:if>
                <c:if test="${hasIpBlockAdmin or hasBlockPolicyAdmin}">
                    <button class="adm-btn adm-btn-primary" type="button" onclick="openIpRuleModal()">정책 규칙 추가</button>
                </c:if>
            </div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="ip-rules">
                        <option value="all">전체 항목</option>
                        <option value="target">IP / 대상</option>
                        <option value="batch">배치</option>
                        <option value="reason">사유 / 상세 메모</option>
                        <option value="priority">우선순위</option>
                        <option value="policy">정책 / 제어 / 분류</option>
                        <option value="blockedAt">차단 날짜</option>
                        <option value="expiresAt">만료 날짜</option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="ip-rules" placeholder="IP 정책 규칙 내 검색">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="ip-rules">초기화</button>
                </div>
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-page-size" data-section="ip-rules">
                        <option value="10">10개씩</option>
                        <option value="20" selected>20개씩</option>
                        <option value="50">50개씩</option>
                    </select>
                </div>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr><th>대상</th><th>동작 / 제어</th><th>배치</th><th>상태</th><th>우선순위</th><th>사유</th><th>액션</th></tr>
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
                                        data-batch-name="${fn:escapeXml(empty r.batchName ? '개별 규칙' : r.batchName)}"
                                        data-batch-code="${fn:escapeXml(empty r.batchCode ? '' : r.batchCode)}"
                                        data-batch-id="${empty r.ipBlockBatchIdx ? '' : r.ipBlockBatchIdx}"
                                        data-blocked-at="${ipRuleBlockedAtText}"
                                        data-expires-display="${fn:escapeXml(empty ipRuleExpiresText ? '없음' : ipRuleExpiresText)}"
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
                                <div>${empty r.batchName ? '개별 규칙' : r.batchName}</div>
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
                                        data-batch-name="${fn:escapeXml(empty r.batchName ? '개별 규칙' : r.batchName)}"
                                        data-batch-code="${fn:escapeXml(empty r.batchCode ? '' : r.batchCode)}"
                                        data-batch-id="${empty r.ipBlockBatchIdx ? '' : r.ipBlockBatchIdx}"
                                        data-blocked-at="${ipRuleBlockedAtText}"
                                        data-expires-display="${fn:escapeXml(empty ipRuleExpiresText ? '없음' : ipRuleExpiresText)}"
                                        data-active="${r.active ? 'true' : 'false'}">설정</button>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-ip-${r.ipBlocklistIdx}">이력</button>
                                <c:if test="${hasIpBlockAdmin or hasBlockPolicyAdmin}">
                                    <button type="button" class="adm-row-btn ${r.active ? 'danger' : 'detail'} js-toggle-ip-rule" data-id="${r.ipBlocklistIdx}" data-active="${r.active ? 'false' : 'true'}">${r.active ? '개별 OFF' : '개별 ON'}</button>
                                    <c:if test="${r.ipBlockBatchIdx != null and r.controlMode == 'MANUAL_OVERRIDE'}">
                                        <button type="button" class="adm-row-btn detail js-return-to-batch" data-id="${r.ipBlocklistIdx}">배치 복귀</button>
                                    </c:if>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty ipBlocks}">
                        <tr><td colspan="7" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="ip-rules">
                <div class="adm-local-page-info js-local-page-info" data-section="ip-rules">0건</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="ip-rules">이전</button>
                    <span class="js-local-page-state" data-section="ip-rules">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="ip-rules">다음</button>
                </div>
            </div>
        </div>
    </div>

    <c:forEach var="r" items="${ipBlocks}">
        <template id="detail-ip-${r.ipBlocklistIdx}">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">대상 키</div><div class="detail-value">${r.blockTargetKey}</div></div>
                <div class="detail-item"><div class="detail-label">표시값</div><div class="detail-value">${empty r.targetDisplayValue ? '-' : r.targetDisplayValue}</div></div>
                <div class="detail-item"><div class="detail-label">규칙 동작</div><div class="detail-value">${r.ruleActionLabel}</div></div>
                <div class="detail-item"><div class="detail-label">제어 방식</div><div class="detail-value">${r.controlModeLabel}</div></div>
                <div class="detail-item"><div class="detail-label">개별 상태</div><div class="detail-value">${r.ruleStateLabel}</div></div>
                <div class="detail-item"><div class="detail-label">최종 적용</div><div class="detail-value">${r.finalStateLabel} / ${r.effectiveStatusLabel}</div></div>
                <div class="detail-item"><div class="detail-label">최종 상태 설명</div><div class="detail-value">${empty r.effectiveStatusReason ? '-' : fn:escapeXml(r.effectiveStatusReason)}</div></div>
                <div class="detail-item"><div class="detail-label">동기화 시각</div><div class="detail-value"><c:choose><c:when test="${r.effectiveSyncedAtDate != null}"><fmt:formatDate value="${r.effectiveSyncedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose> / ${empty r.effectiveSyncedBySource ? '-' : r.effectiveSyncedBySource}</div></div>
                <div class="detail-item"><div class="detail-label">매칭 방식</div><div class="detail-value">${r.matchType}</div></div>
                <div class="detail-item"><div class="detail-label">CIDR / 범위</div><div class="detail-value">${empty r.cidrNotation ? '-' : r.cidrNotation} <c:if test="${not empty r.rangeStartIp}">${r.rangeStartIp} ~ ${r.rangeEndIp}</c:if></div></div>
                <div class="detail-item"><div class="detail-label">국가 / ASN</div><div class="detail-value">${empty r.countryCode ? '-' : r.countryCode} / ${empty r.asn ? '-' : r.asn}</div></div>
                <div class="detail-item"><div class="detail-label">배치</div><div class="detail-value">${empty r.batchName ? '개별 규칙' : r.batchName} <c:if test="${not empty r.batchCode}">(${r.batchCode})</c:if> / ${r.batchStatusLabel}</div></div>
                <div class="detail-item"><div class="detail-label">우선순위</div><div class="detail-value">${r.priority}</div></div>
                <div class="detail-item"><div class="detail-label">생성 시각</div><div class="detail-value"><fmt:formatDate value="${r.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
                <div class="detail-item"><div class="detail-label">만료 시각</div><div class="detail-value"><c:choose><c:when test="${r.expiresAtDate != null}"><fmt:formatDate value="${r.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>없음</c:otherwise></c:choose></div></div>
                <div class="detail-item"><div class="detail-label">수동 예외</div><div class="detail-value">${empty r.manualOverrideReason ? '-' : fn:escapeXml(r.manualOverrideReason)} <c:if test="${r.manualOverrideAtDate != null}">/ <fmt:formatDate value="${r.manualOverrideAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:if></div></div>
                <div class="detail-item"><div class="detail-label">최근 제어</div><div class="detail-value">${empty r.lastControlAction ? '-' : r.lastControlAction} <c:if test="${r.lastControlAtDate != null}">/ <fmt:formatDate value="${r.lastControlAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:if></div></div>
            </div>
            <div class="detail-item" style="margin-top:14px;"><div class="detail-label">정책 사유</div><div class="detail-value">${empty r.reason ? '-' : fn:escapeXml(r.reason)}</div></div>
            <div class="detail-item" style="margin-top:14px;"><div class="detail-label">상세 메모</div><div class="detail-value">${empty r.detailMessage ? '-' : fn:escapeXml(r.detailMessage)}</div></div>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th>항목</th><th>값</th></tr></thead>
                <tbody>
                <tr><td>요청 ID</td><td>${empty r.blockRequestId ? '-' : r.blockRequestId}</td></tr>
                <tr><td>자동 차단</td><td>${r.autoBlock ? '예' : '아니오'} / ${empty r.autoBlockSource ? '-' : r.autoBlockSource}</td></tr>
                <tr><td>위험 점수</td><td>${empty r.riskScore ? '-' : r.riskScore}</td></tr>
                <tr><td>사용자 연동</td><td>${empty r.userIdx ? '-' : r.userIdx} / ${empty r.blockType ? '-' : r.blockType}</td></tr>
                </tbody>
            </table>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th>관련 이력</th><th>전/후 상태</th><th>시각</th><th>설명</th></tr></thead>
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
            <div class="adm-card-title">IP 정책 배치</div>
            <div class="adm-card-sub">배치 기본 전략과 개별 예외를 함께 관리합니다.</div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="batches">
                        <option value="all">전체 항목</option>
                        <option value="batch">배치명 / 코드</option>
                        <option value="source">출처</option>
                        <option value="description">설명</option>
                        <option value="policy">기본 정책</option>
                        <option value="status">상태</option>
                        <option value="updatedAt">최근 수정</option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="batches" placeholder="IP 정책 배치 내 검색">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="batches">초기화</button>
                </div>
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-page-size" data-section="batches">
                        <option value="10">10개씩</option>
                        <option value="20" selected>20개씩</option>
                        <option value="50">50개씩</option>
                    </select>
                </div>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead><tr><th>배치</th><th>기본 정책</th><th>현재 상태</th><th>규칙 통계</th><th>설명</th><th>액션</th></tr></thead>
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
                                <div style="font-size:12px;color:#94a3b8;">기본 우선순위 ${b.defaultRulePriority}</div>
                                <div style="font-size:11px;color:#64748b;">OFF: ${b.defaultDisableStrategyLabel}</div>
                                <div style="font-size:11px;color:#64748b;">ON: ${b.defaultEnableStrategyLabel}</div>
                            </td>
                            <td>
                                <div><span class="status-badge ${b.active ? 'ACTIVE' : 'DORMANT'}">${b.activeLabel}</span></div>
                                <div style="font-size:12px;color:#94a3b8;">차단 ${b.blockRuleCount} / 허용 ${b.allowRuleCount}</div>
                            </td>
                            <td>
                                <div>전체 ${b.totalRuleCount} / 개별 ON ${b.activeRuleCount}</div>
                                <div style="font-size:11px;color:#64748b;">배치 제어 ${b.batchManagedRuleCount} / 수동 예외 ${b.manualOverrideRuleCount}</div>
                                <div style="font-size:11px;color:#64748b;">최종 적용 ${b.effectiveRuleCount} / 만료 ${b.expiredRuleCount}</div>
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
                                        data-expired-rules="${b.expiredRuleCount}">설정</button>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-batch-${b.ipBlockBatchIdx}">상세</button>
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
                                        ${b.active ? '비활성화' : '재활성화'}
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty batches}">
                        <tr><td colspan="6" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="batches">
                <div class="adm-local-page-info js-local-page-info" data-section="batches">0건</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="batches">이전</button>
                    <span class="js-local-page-state" data-section="batches">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="batches">다음</button>
                </div>
            </div>
        </div>
    </div>

    <c:forEach var="b" items="${batches}">
        <template id="detail-batch-${b.ipBlockBatchIdx}">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">배치명</div><div class="detail-value">${b.batchName}</div></div>
                <div class="detail-item"><div class="detail-label">배치 코드</div><div class="detail-value">${b.batchCode}</div></div>
                <div class="detail-item"><div class="detail-label">상태</div><div class="detail-value">${b.activeLabel}</div></div>
                <div class="detail-item"><div class="detail-label">출처</div><div class="detail-value">${b.sourceType} / ${empty b.sourceName ? '-' : b.sourceName}</div></div>
                <div class="detail-item"><div class="detail-label">기본 동작</div><div class="detail-value">${b.batchRuleActionLabel} / 우선순위 ${b.defaultRulePriority}</div></div>
                <div class="detail-item"><div class="detail-label">기본 전략</div><div class="detail-value">OFF: ${b.defaultDisableStrategyLabel} / ON: ${b.defaultEnableStrategyLabel}</div></div>
                <div class="detail-item"><div class="detail-label">규칙 수</div><div class="detail-value">전체 ${b.totalRuleCount}, 개별 ON ${b.activeRuleCount}</div></div>
                <div class="detail-item"><div class="detail-label">제어 구성</div><div class="detail-value">배치 제어 ${b.batchManagedRuleCount}, 수동 예외 ${b.manualOverrideRuleCount}</div></div>
                <div class="detail-item"><div class="detail-label">최종 적용</div><div class="detail-value">${b.effectiveRuleCount}개 적용 / ${b.expiredRuleCount}개 만료</div></div>
                <div class="detail-item"><div class="detail-label">동작 구성</div><div class="detail-value">차단 ${b.blockRuleCount} / 허용 ${b.allowRuleCount}</div></div>
                <div class="detail-item"><div class="detail-label">생성</div><div class="detail-value">${empty b.createdByNickname ? '-' : b.createdByNickname} / <fmt:formatDate value="${b.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
                <div class="detail-item"><div class="detail-label">최근 수정</div><div class="detail-value">${empty b.updatedByNickname ? '-' : b.updatedByNickname} / <fmt:formatDate value="${b.updatedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
            </div>
            <div class="detail-item" style="margin-top:14px;"><div class="detail-label">상세 설명</div><div class="detail-value">${empty b.description ? '-' : fn:escapeXml(b.description)}</div></div>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th>최근 배치 작업</th><th>옵션</th><th>영향</th><th>시각</th></tr></thead>
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
                <thead><tr><th>연결 규칙</th><th>동작</th><th>제어</th><th>상태</th></tr></thead>
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
            <div class="adm-card-title">통합 차단 이력</div>
            <div class="adm-card-sub">규칙 생성, 개별 예외, 배치 동기화까지 함께 추적합니다.</div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="histories">
                        <option value="all">전체 항목</option>
                        <option value="target">대상</option>
                        <option value="member">회원</option>
                        <option value="change">변경 종류</option>
                        <option value="reason">사유 / 설명</option>
                        <option value="batch">배치</option>
                        <option value="blockedAt">차단 날짜</option>
                        <option value="expiresAt">만료 날짜</option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="histories" placeholder="통합 차단 이력 내 검색">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="histories">초기화</button>
                </div>
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-page-size" data-section="histories">
                        <option value="10">10개씩</option>
                        <option value="20" selected>20개씩</option>
                        <option value="50">50개씩</option>
                    </select>
                </div>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead><tr><th>시각</th><th>대상</th><th>동작</th><th>변경</th><th>결과</th><th>사유</th><th>액션</th></tr></thead>
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
                                        data-template-id="detail-history-${h.blockIdx}">현재 설정</button>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-history-${h.blockIdx}">상세</button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}">
                        <tr><td colspan="7" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="histories">
                <div class="adm-local-page-info js-local-page-info" data-section="histories">0건</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="histories">이전</button>
                    <span class="js-local-page-state" data-section="histories">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="histories">다음</button>
                </div>
            </div>
        </div>
    </div>
</div>

<c:forEach var="h" items="${histories}">
    <template id="detail-history-${h.blockIdx}">
        <div class="detail-grid">
            <div class="detail-item"><div class="detail-label">대상 키</div><div class="detail-value">${h.blockTargetKey}</div></div>
            <div class="detail-item"><div class="detail-label">이력 종류</div><div class="detail-value">${h.historyKind}</div></div>
            <div class="detail-item"><div class="detail-label">규칙 동작</div><div class="detail-value">${empty h.ruleAction ? '-' : h.ruleAction}</div></div>
            <div class="detail-item"><div class="detail-label">제어 방식</div><div class="detail-value">${empty h.controlMode ? '-' : h.controlMode}</div></div>
            <div class="detail-item"><div class="detail-label">회원</div><div class="detail-value">${empty h.nickname ? '-' : h.nickname} / ${empty h.userId ? '-' : h.userId}</div></div>
            <div class="detail-item"><div class="detail-label">차단 유형</div><div class="detail-value">${h.blockType}</div></div>
            <div class="detail-item"><div class="detail-label">차단 IP</div><div class="detail-value">${empty h.blockedIp ? '-' : h.blockedIp}</div></div>
            <div class="detail-item"><div class="detail-label">출처 / 매칭</div><div class="detail-value">${h.blockScope} / ${empty h.ipMatchType ? '-' : h.ipMatchType}</div></div>
            <div class="detail-item"><div class="detail-label">배치</div><div class="detail-value">${empty h.batchName ? '-' : h.batchName} <c:if test="${not empty h.batchCode}">(${h.batchCode})</c:if></div></div>
            <div class="detail-item"><div class="detail-label">배치 작업</div><div class="detail-value">${empty h.batchOperationIdx ? '-' : h.batchOperationIdx}</div></div>
            <div class="detail-item"><div class="detail-label">차단 시각</div><div class="detail-value"><fmt:formatDate value="${h.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
            <div class="detail-item"><div class="detail-label">만료 시각</div><div class="detail-value"><c:choose><c:when test="${h.expiresAtDate != null}"><fmt:formatDate value="${h.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>없음</c:otherwise></c:choose></div></div>
            <div class="detail-item"><div class="detail-label">해제 시각</div><div class="detail-value"><c:choose><c:when test="${h.releasedAtDate != null}"><fmt:formatDate value="${h.releasedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
            <div class="detail-item"><div class="detail-label">동기화</div><div class="detail-value"><c:choose><c:when test="${h.listSyncedAtDate != null}"><fmt:formatDate value="${h.listSyncedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
        </div>
        <div class="detail-item" style="margin-top:14px;"><div class="detail-label">변경 설명</div><div class="detail-value">${empty h.controlReason ? '-' : fn:escapeXml(h.controlReason)}</div></div>
        <table class="history-table" style="margin-top:14px;">
            <thead><tr><th>스냅샷</th><th>변경 전</th><th>변경 후</th></tr></thead>
            <tbody>
            <tr><td>개별 상태</td><td>${empty h.beforeRuleIsActive ? '-' : (h.beforeRuleIsActive ? 'ON' : 'OFF')}</td><td>${empty h.afterRuleIsActive ? '-' : (h.afterRuleIsActive ? 'ON' : 'OFF')}</td></tr>
            <tr><td>배치 상태</td><td>${empty h.beforeBatchIsActive ? '-' : (h.beforeBatchIsActive ? 'ON' : 'OFF')}</td><td>${empty h.afterBatchIsActive ? '-' : (h.afterBatchIsActive ? 'ON' : 'OFF')}</td></tr>
            <tr><td>최종 적용</td><td>${empty h.beforeEffectiveStatus ? '-' : h.beforeEffectiveStatus}</td><td>${empty h.afterEffectiveStatus ? '-' : h.afterEffectiveStatus}</td></tr>
            <tr><td>결과 코드</td><td colspan="2">${empty h.effectiveResult ? '-' : h.effectiveResult}</td></tr>
            </tbody>
        </table>
    </template>
</c:forEach>

<div class="adm-modal-overlay" id="blockDetailModal">
    <div class="adm-modal" style="max-width:860px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockDetailTitle">차단 상세</div>
            <button class="adm-modal-close" onclick="closeModal('blockDetailModal')">✕</button>
        </div>
        <div class="adm-modal-body" id="blockDetailBody"></div>
    </div>
</div>

<div class="adm-modal-overlay" id="memberDetailModal">
    <div class="adm-modal" style="max-width:860px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="memberDetailTitle">회원 상세</div>
            <button class="adm-modal-close" onclick="closeModal('memberDetailModal')">✕</button>
        </div>
        <div class="adm-modal-body" id="memberDetailBody">
            <div style="text-align:center;padding:40px;color:#64748b;">불러오는 중...</div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('memberDetailModal')">닫기</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="userBlockEditModal">
    <div class="adm-modal" style="max-width:720px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="userBlockEditTitle">회원 차단 설정</div>
            <button class="adm-modal-close" onclick="closeModal('userBlockEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="userBlockEditId">
            <input type="hidden" id="userBlockEditTemplateId">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">회원</div><div class="detail-value" id="userBlockEditMember">-</div></div>
                <div class="detail-item"><div class="detail-label">대상 키</div><div class="detail-value" id="userBlockEditTarget">-</div></div>
                <div class="detail-item"><div class="detail-label">차단 유형</div><div class="detail-value" id="userBlockEditType">-</div></div>
                <div class="detail-item"><div class="detail-label">현재 상태</div><div class="detail-value" id="userBlockEditStatus">-</div></div>
                <div class="detail-item"><div class="detail-label">차단 시각</div><div class="detail-value" id="userBlockEditBlockedAt">-</div></div>
                <div class="detail-item"><div class="detail-label">최근 반영</div><div class="detail-value" id="userBlockEditSyncAt">-</div></div>
            </div>
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;margin-top:18px;">
                <div class="sa-form-group">
                    <label class="sa-form-label">현재 상태</label>
                    <select id="userBlockEditActive" class="adm-select">
                        <option value="true">차단 유지</option>
                        <option value="false">차단 해제</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">만료 시각</label>
                    <input id="userBlockEditExpiresAt" class="adm-input" type="datetime-local">
                    <div class="adm-quick-row">
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="userBlockEditExpiresAt" data-days="1">+1일</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="userBlockEditExpiresAt" data-days="7">+7일</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="userBlockEditExpiresAt" data-days="30">+30일</button>
                        <button type="button" class="adm-chip-btn js-expiry-clear" data-target="userBlockEditExpiresAt">무기한</button>
                    </div>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">차단 사유</label>
                    <textarea id="userBlockEditReason" class="adm-input" style="min-height:120px;"></textarea>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('userBlockEditModal')">닫기</button>
            <button class="adm-btn adm-btn-ghost" type="button" id="userBlockEditHistoryBtn">관련 이력</button>
            <button class="adm-btn adm-btn-primary" type="button" onclick="submitUserBlockEdit()">저장</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="ipRuleEditModal">
    <div class="adm-modal" style="max-width:760px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="ipRuleEditTitle">IP 정책 상세 설정</div>
            <button class="adm-modal-close" onclick="closeModal('ipRuleEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="ipRuleEditId">
            <input type="hidden" id="ipRuleEditTemplateId">
            <input type="hidden" id="ipRuleEditHasBatch">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">대상</div><div class="detail-value" id="ipRuleEditTarget">-</div></div>
                <div class="detail-item"><div class="detail-label">배치</div><div class="detail-value" id="ipRuleEditBatch">-</div></div>
                <div class="detail-item"><div class="detail-label">개별 상태</div><div class="detail-value" id="ipRuleEditRuleState">-</div></div>
                <div class="detail-item"><div class="detail-label">최종 적용</div><div class="detail-value" id="ipRuleEditFinalState">-</div></div>
                <div class="detail-item"><div class="detail-label">생성 시각</div><div class="detail-value" id="ipRuleEditBlockedAt">-</div></div>
                <div class="detail-item"><div class="detail-label">현재 만료</div><div class="detail-value" id="ipRuleEditExpiresDisplay">-</div></div>
            </div>
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;margin-top:18px;">
                <div class="sa-form-group">
                    <label class="sa-form-label">규칙 동작</label>
                    <select id="ipRuleEditAction" class="adm-select">
                        <option value="BLOCK">차단</option>
                        <option value="ALLOW">허용</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">제어 방식</label>
                    <select id="ipRuleEditControlMode" class="adm-select"></select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">분류</label>
                    <select id="ipRuleEditCategory" class="adm-select">
                        <option value="MANUAL">MANUAL</option>
                        <option value="SPAM">SPAM</option>
                        <option value="ABUSE">ABUSE</option>
                        <option value="BRUTE_FORCE">BRUTE_FORCE</option>
                        <option value="GEO">GEO</option>
                        <option value="VPN">VPN</option>
                        <option value="SECURITY">SECURITY</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">우선순위</label>
                    <input id="ipRuleEditPriority" class="adm-input" type="number" min="1">
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">만료 시각</label>
                    <input id="ipRuleEditExpiresAt" class="adm-input" type="datetime-local">
                    <div class="adm-quick-row">
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipRuleEditExpiresAt" data-days="1">+1일</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipRuleEditExpiresAt" data-days="7">+7일</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipRuleEditExpiresAt" data-days="30">+30일</button>
                        <button type="button" class="adm-chip-btn js-expiry-clear" data-target="ipRuleEditExpiresAt">무기한</button>
                    </div>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">정책 사유</label>
                    <textarea id="ipRuleEditReason" class="adm-input" style="min-height:100px;"></textarea>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">상세 메모</label>
                    <textarea id="ipRuleEditDetailMessage" class="adm-input" style="min-height:100px;"></textarea>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('ipRuleEditModal')">닫기</button>
            <button class="adm-btn adm-btn-ghost" type="button" id="ipRuleEditHistoryBtn">관련 이력</button>
            <button class="adm-btn adm-btn-primary" type="button" onclick="submitIpRuleEdit()">저장</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="ipRuleModal">
    <div class="adm-modal" style="max-width:720px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">IP 정책 규칙 추가</div>
            <button class="adm-modal-close" onclick="closeModal('ipRuleModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label">규칙 동작</label>
                    <select id="ipRuleAction" class="adm-select">
                        <option value="BLOCK">차단</option>
                        <option value="ALLOW">허용</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">제어 방식</label>
                    <select id="ipControlMode" class="adm-select">
                        <option value="MANUAL">수동</option>
                        <option value="BATCH">배치 제어</option>
                        <option value="MANUAL_OVERRIDE">수동 예외</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">매칭 방식</label>
                    <select id="ipMatchType" class="adm-select" onchange="handleIpRuleTypeChange()">
                        <option value="SINGLE_IP">단일 IP</option>
                        <option value="CIDR">CIDR</option>
                        <option value="RANGE">범위</option>
                        <option value="COUNTRY">국가</option>
                        <option value="ASN">ASN</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">분류</label>
                    <select id="ipBlockCategory" class="adm-select">
                        <option value="MANUAL">MANUAL</option>
                        <option value="SPAM">SPAM</option>
                        <option value="ABUSE">ABUSE</option>
                        <option value="BRUTE_FORCE">BRUTE_FORCE</option>
                        <option value="GEO">GEO</option>
                        <option value="VPN">VPN</option>
                        <option value="SECURITY">SECURITY</option>
                    </select>
                </div>
                <div class="sa-form-group" id="fieldSingleIp">
                    <label class="sa-form-label">IP 주소</label>
                    <input id="ipAddressInput" class="adm-input" type="text" placeholder="예: 203.0.113.10">
                </div>
                <div class="sa-form-group" id="fieldCidr" style="display:none;">
                    <label class="sa-form-label">CIDR</label>
                    <input id="cidrNotationInput" class="adm-input" type="text" placeholder="예: 203.0.113.0/24">
                </div>
                <div class="sa-form-group" id="fieldRangeStart" style="display:none;">
                    <label class="sa-form-label">범위 시작 IP</label>
                    <input id="rangeStartInput" class="adm-input" type="text" placeholder="예: 203.0.113.1">
                </div>
                <div class="sa-form-group" id="fieldRangeEnd" style="display:none;">
                    <label class="sa-form-label">범위 끝 IP</label>
                    <input id="rangeEndInput" class="adm-input" type="text" placeholder="예: 203.0.113.255">
                </div>
                <div class="sa-form-group" id="fieldCountry" style="display:none;">
                    <label class="sa-form-label">국가 코드</label>
                    <input id="countryCodeInput" class="adm-input" type="text" placeholder="예: CN">
                </div>
                <div class="sa-form-group" id="fieldAsn" style="display:none;">
                    <label class="sa-form-label">ASN</label>
                    <input id="asnInput" class="adm-input" type="text" placeholder="예: AS12345">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">배치</label>
                    <select id="ipBatchIdx" class="adm-select" onchange="handleIpBatchChange()">
                        <option value="">(없음)</option>
                        <c:forEach var="b" items="${batches}">
                            <option value="${b.ipBlockBatchIdx}">${b.batchName} (${b.batchCode})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">우선순위</label>
                    <input id="ipPriority" class="adm-input" type="number" min="1" value="1">
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">만료 시각</label>
                    <input id="ipExpiresAt" class="adm-input" type="datetime-local">
                    <div class="adm-quick-row">
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipExpiresAt" data-days="1">+1일</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipExpiresAt" data-days="7">+7일</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipExpiresAt" data-days="30">+30일</button>
                        <button type="button" class="adm-chip-btn js-expiry-clear" data-target="ipExpiresAt">무기한</button>
                    </div>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">정책 사유</label>
                    <textarea id="ipReason" class="adm-input" style="min-height:90px;"></textarea>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">상세 메모</label>
                    <textarea id="ipDetailMessage" class="adm-input" style="min-height:90px;"></textarea>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('ipRuleModal')">취소</button>
            <button class="adm-btn adm-btn-primary" onclick="submitIpRule()">저장</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="batchModal">
    <div class="adm-modal" style="max-width:620px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">IP 정책 배치 생성</div>
            <button class="adm-modal-close" onclick="closeModal('batchModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;">
                <div class="sa-form-group"><label class="sa-form-label">배치 코드</label><input id="batchCode" class="adm-input" type="text" placeholder="예: VPN_FEED_202604"></div>
                <div class="sa-form-group"><label class="sa-form-label">배치명</label><input id="batchName" class="adm-input" type="text" placeholder="예: VPN 공개 대역 2026.04"></div>
                <div class="sa-form-group"><label class="sa-form-label">출처 유형</label><select id="batchSourceType" class="adm-select"><option value="MANUAL">MANUAL</option><option value="VPN_FEED">VPN_FEED</option><option value="SPAM_FEED">SPAM_FEED</option><option value="GEO_POLICY">GEO_POLICY</option><option value="AUTO_DETECTION">AUTO_DETECTION</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">출처명</label><input id="batchSourceName" class="adm-input" type="text" placeholder="예: 운영자 수동 등록"></div>
                <div class="sa-form-group"><label class="sa-form-label">기본 동작</label><select id="batchRuleAction" class="adm-select"><option value="BLOCK">차단</option><option value="ALLOW">허용</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">기본 우선순위</label><input id="batchDefaultPriority" class="adm-input" type="number" min="1" value="1"></div>
                <div class="sa-form-group"><label class="sa-form-label">OFF 기본 전략</label><select id="batchDisableStrategy" class="adm-select"><option value="BATCH_ONLY">배치만 OFF</option><option value="CASCADE_ACTIVE_RULES">규칙도 함께 OFF</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">ON 기본 전략</label><select id="batchEnableStrategy" class="adm-select"><option value="BATCH_ONLY">배치만 ON</option><option value="RESTORE_BATCH_CONTROL">배치 복구</option><option value="FORCE_ENABLE_ALL">전부 ON</option></select></div>
                <div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label">설명</label><textarea id="batchDescription" class="adm-input" style="min-height:90px;"></textarea></div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('batchModal')">취소</button>
            <button class="adm-btn adm-btn-primary" onclick="submitBatch()">생성</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="batchEditModal">
    <div class="adm-modal" style="max-width:720px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="batchEditTitle">IP 정책 배치 설정</div>
            <button class="adm-modal-close" onclick="closeModal('batchEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="batchEditId">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">현재 상태</div><div class="detail-value" id="batchEditStatus">-</div></div>
                <div class="detail-item"><div class="detail-label">최근 수정</div><div class="detail-value" id="batchEditUpdatedAt">-</div></div>
                <div class="detail-item"><div class="detail-label">생성 시각</div><div class="detail-value" id="batchEditCreatedAt">-</div></div>
                <div class="detail-item"><div class="detail-label">규칙 통계</div><div class="detail-value" id="batchEditStats">-</div></div>
            </div>
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;margin-top:18px;">
                <div class="sa-form-group"><label class="sa-form-label">배치 코드</label><input id="batchEditCode" class="adm-input" type="text"></div>
                <div class="sa-form-group"><label class="sa-form-label">배치명</label><input id="batchEditName" class="adm-input" type="text"></div>
                <div class="sa-form-group"><label class="sa-form-label">출처 유형</label><select id="batchEditSourceType" class="adm-select"><option value="MANUAL">MANUAL</option><option value="VPN_FEED">VPN_FEED</option><option value="SPAM_FEED">SPAM_FEED</option><option value="GEO_POLICY">GEO_POLICY</option><option value="AUTO_DETECTION">AUTO_DETECTION</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">출처명</label><input id="batchEditSourceName" class="adm-input" type="text"></div>
                <div class="sa-form-group"><label class="sa-form-label">기본 동작</label><select id="batchEditRuleAction" class="adm-select"><option value="BLOCK">차단</option><option value="ALLOW">허용</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">기본 우선순위</label><input id="batchEditPriority" class="adm-input" type="number" min="1"></div>
                <div class="sa-form-group"><label class="sa-form-label">OFF 기본 전략</label><select id="batchEditDisableStrategy" class="adm-select"><option value="BATCH_ONLY">배치만 OFF</option><option value="CASCADE_ACTIVE_RULES">규칙도 함께 OFF</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">ON 기본 전략</label><select id="batchEditEnableStrategy" class="adm-select"><option value="BATCH_ONLY">배치만 ON</option><option value="RESTORE_BATCH_CONTROL">배치 복구</option><option value="FORCE_ENABLE_ALL">전부 ON</option></select></div>
                <div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label">설명</label><textarea id="batchEditDescription" class="adm-input" style="min-height:100px;"></textarea></div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('batchEditModal')">닫기</button>
            <button class="adm-btn adm-btn-primary" type="button" onclick="submitBatchEdit()">저장</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="batchToggleModal">
    <div class="adm-modal" style="max-width:620px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="batchToggleTitle">배치 상태 변경</div>
            <button class="adm-modal-close" onclick="closeModal('batchToggleModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="batchToggleId">
            <input type="hidden" id="batchToggleActive">
            <div class="detail-item" style="margin-bottom:14px;">
                <div class="detail-label">영향 안내</div>
                <div class="detail-value" id="batchToggleSummary">-</div>
            </div>
            <div class="sa-form-group">
                <label class="sa-form-label">적용 옵션</label>
                <select id="batchToggleOption" class="adm-select"></select>
            </div>
            <div class="sa-form-group" style="margin-top:14px;">
                <label class="sa-form-label">운영 메모</label>
                <textarea id="batchToggleDescription" class="adm-input" style="min-height:90px;"></textarea>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('batchToggleModal')">취소</button>
            <button class="adm-btn adm-btn-primary" onclick="submitBatchToggle()">적용</button>
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
        emptyRow.innerHTML = '<td colspan="' + colspan + '">조건에 맞는 데이터가 없습니다.</td>';
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
        info.textContent = '총 ' + total + '건 / 현재 ' + shown + '건';
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

    return date.toLocaleString('ko-KR', {
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

    return date.toLocaleString('ko-KR', {
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatBooleanBadge(value) {
    return value
        ? '<span style="color:#4ade80">✓ 예</span>'
        : '<span style="color:#475569">✗ 아니오</span>';
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
        return '<span style="color:#475569;font-size:12px;">연동 없음</span>';
    }

    const providerMap = {
        KAKAO: 'k 카카오',
        NAVER: 'N 네이버',
        GOOGLE: 'G Google'
    };

    return linkedProviders
        .split(',')
        .map(provider => provider.trim())
        .filter(provider => provider.length > 0)
        .map(provider => '<span style="margin-right:8px;font-size:12px;color:#94a3b8;">' + escapeHtml(providerMap[provider] || provider) + '</span>')
        .join('') || '<span style="color:#475569;font-size:12px;">연동 없음</span>';
}

function buildMemberInfoTab(member) {
    const statusBadge = buildStatusBadge(member.accountStatus);
    const roleBadge = buildRoleBadge(member.userRole);
    const socialHtml = buildSocialHtml(member.linkedProviders);
    const lastLoginText = formatDateTime(member.lastLoginAt);

    return ''
        + '<div class="detail-grid">'
        + '<div class="detail-item"><div class="detail-label">회원 번호</div><div class="detail-value">#' + escapeHtml(member.userIdx) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">아이디</div><div class="detail-value">' + formatNullable(member.userId) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">닉네임</div><div class="detail-value">' + formatNullable(member.nickname) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">이메일</div><div class="detail-value" style="font-size:12px;">' + formatNullable(member.userEmail) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">계정 상태</div><div class="detail-value">' + statusBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">권한</div><div class="detail-value">' + roleBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">국적</div><div class="detail-value">' + formatNullable(member.nationality) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">선호 언어</div><div class="detail-value">' + formatNullable(member.preferredLang) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">이메일 인증</div><div class="detail-value">' + formatBooleanBadge(member.emailVerified) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">이메일 로그인</div><div class="detail-value">' + formatBooleanBadge(member.emailLoginEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">비밀번호 로그인</div><div class="detail-value">' + formatBooleanBadge(member.passwordEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">가입일</div><div class="detail-value" style="font-size:12px;">' + formatDateTime(member.createdAt) + '</div></div>'
        + '</div>'
        + '<div class="detail-item" style="margin-top:12px;">'
        + '<div class="detail-label">소셜 연동</div>'
        + '<div class="detail-value" style="margin-top:4px;">' + socialHtml + '</div>'
        + '</div>'
        + '<div style="margin-top:12px;display:flex;gap:8px;flex-wrap:wrap;">'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">로그인 성공</div>'
        + '<div style="font-size:20px;font-weight:700;color:#4ade80;margin-top:4px;">' + escapeHtml(member.loginSuccessCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">로그인 실패</div>'
        + '<div style="font-size:20px;font-weight:700;color:#f87171;margin-top:4px;">' + escapeHtml(member.loginFailCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:120px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">최근 로그인</div>'
        + '<div style="font-size:12px;font-weight:600;color:#94a3b8;margin-top:4px;">' + escapeHtml(lastLoginText) + '</div>'
        + '</div>'
        + '</div>';
}

function buildMemberHistTab(history) {
    if (!history.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;">로그인 이력이 없습니다.</div>';
    }

    const methodMap = {
        ID: '아이디',
        EMAIL: '이메일',
        KAKAO: '카카오',
        NAVER: '네이버',
        GOOGLE: 'Google'
    };

    let rows = '';
    history.forEach(function(item) {
        const ok = !!item.success;
        rows += ''
            + '<tr>'
            + '<td>' + escapeHtml(formatHistoryDateTime(item.loginAt)) + '</td>'
            + '<td>' + escapeHtml(methodMap[item.loginMethod] || item.loginMethod || '—') + '</td>'
            + '<td class="' + (ok ? 'h-success' : 'h-fail') + '">' + (ok ? '✅ 성공' : '❌ 실패') + '</td>'
            + '<td>' + escapeHtml(item.failReason || '—') + '</td>'
            + '<td style="font-size:11px;color:#475569;">' + escapeHtml(item.ipAddress || '—') + '</td>'
            + '</tr>';
    });

    return ''
        + '<div style="overflow-x:auto;max-height:340px;overflow-y:auto;">'
        + '<table class="history-table">'
        + '<thead><tr><th>시각</th><th>방법</th><th>결과</th><th>실패 사유</th><th>IP</th></tr></thead>'
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
        '<div style="text-align:center;padding:40px;color:#475569;">불러오는 중... ⏳</div>';

    const res = await fetch(CTX + '/admin/members/' + userIdx, {
        headers: {'X-Requested-With': 'XMLHttpRequest'}
    });
    const data = await res.json();

    if (!data.success) {
        document.getElementById('memberDetailBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(data.message || '회원 정보를 불러오지 못했습니다.') + '</div>';
        return;
    }

    const member = data.member || {};
    const history = Array.isArray(data.history) ? data.history : [];
    document.getElementById('memberDetailTitle').textContent = (member.nickname || '회원') + ' 상세 정보';
    document.getElementById('memberDetailBody').innerHTML = ''
        + '<div class="adm-tabs">'
        + '<button class="adm-tab active" onclick="switchMemberTab(\'info\', this)">기본 정보</button>'
        + '<button class="adm-tab" onclick="switchMemberTab(\'hist\', this)">로그인 이력 (' + history.length + ')</button>'
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
        adm_toast('배치 설정 정보를 찾지 못했습니다.', 'error');
        return;
    }

    document.getElementById('batchEditId').value = resolvedButton.dataset.batchId || '';
    document.getElementById('batchEditTitle').textContent = (resolvedButton.dataset.batchName || 'IP 정책 배치') + ' 설정';
    document.getElementById('batchEditStatus').textContent = resolvedButton.dataset.statusLabel || '-';
    document.getElementById('batchEditUpdatedAt').textContent = resolvedButton.dataset.updatedAt || '-';
    document.getElementById('batchEditCreatedAt').textContent = resolvedButton.dataset.createdAt || '-';
    document.getElementById('batchEditStats').textContent = '전체 ' + (resolvedButton.dataset.totalRules || '0')
        + ' / 개별 ON ' + (resolvedButton.dataset.activeRules || '0')
        + ' / 최종 적용 ' + (resolvedButton.dataset.effectiveRules || '0')
        + ' / 만료 ' + (resolvedButton.dataset.expiredRules || '0');
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
    document.getElementById('blockDetailTitle').textContent = title || '차단 상세';
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
            + '<option value="BATCH">배치 제어</option>'
            + '<option value="MANUAL_OVERRIDE">수동 예외</option>';
        select.value = currentMode === 'MANUAL_OVERRIDE' ? 'MANUAL_OVERRIDE' : 'BATCH';
    } else {
        select.innerHTML = '<option value="MANUAL">수동</option>';
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
    document.getElementById('userBlockEditTitle').textContent = displayName + ' 차단 설정';

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
    document.getElementById('userBlockEditStatus').textContent = (button.dataset.active === 'true' ? '차단 유지' : '차단 해제') + ' / ' + (button.dataset.snapshotStatus || '-');
    document.getElementById('userBlockEditBlockedAt').textContent = button.dataset.blockedAt || '-';
    document.getElementById('userBlockEditSyncAt').textContent = button.dataset.syncAt || '-';
    document.getElementById('userBlockEditActive').value = button.dataset.active === 'true' ? 'true' : 'false';
    document.getElementById('userBlockEditExpiresAt').value = button.dataset.expiresAt || '';
    document.getElementById('userBlockEditReason').value = button.dataset.reason || '';
    document.getElementById('userBlockEditHistoryBtn').onclick = function () {
        closeModal('userBlockEditModal');
        openBlockDetail(button.dataset.templateId, '회원 차단 이력');
    };
    document.getElementById('userBlockEditModal').classList.add('open');
}

function openIpRuleEditor(button) {
    const batchId = button.dataset.batchId || '';
    const hasBatch = batchId !== '';
    const batchLabel = hasBatch
        ? (button.dataset.batchName || '-') + (button.dataset.batchCode ? ' (' + button.dataset.batchCode + ')' : '')
        : '개별 규칙';

    document.getElementById('ipRuleEditId').value = button.dataset.id;
    document.getElementById('ipRuleEditTemplateId').value = button.dataset.templateId || '';
    document.getElementById('ipRuleEditHasBatch').value = hasBatch ? 'true' : 'false';
    document.getElementById('ipRuleEditTitle').textContent = (button.dataset.targetDisplay || button.dataset.targetKey || 'IP 규칙') + ' 상세 설정';
    document.getElementById('ipRuleEditTarget').textContent = (button.dataset.targetDisplay || '-') + ' / ' + (button.dataset.targetKey || '-');
    document.getElementById('ipRuleEditBatch').textContent = batchLabel + ' / ' + (button.dataset.batchStatusLabel || '개별 규칙');
    document.getElementById('ipRuleEditRuleState').textContent = button.dataset.ruleStateLabel || '-';
    document.getElementById('ipRuleEditFinalState').textContent = (button.dataset.finalStateLabel || '-') + ' / ' + (button.dataset.effectiveStatusLabel || '-');
    document.getElementById('ipRuleEditBlockedAt').textContent = button.dataset.blockedAt || '-';
    document.getElementById('ipRuleEditExpiresDisplay').textContent = button.dataset.expiresDisplay || '없음';
    document.getElementById('ipRuleEditAction').value = button.dataset.ruleAction || 'BLOCK';
    document.getElementById('ipRuleEditCategory').value = button.dataset.blockCategory || 'MANUAL';
    document.getElementById('ipRuleEditPriority').value = button.dataset.priority || '1';
    document.getElementById('ipRuleEditExpiresAt').value = button.dataset.expiresAt || '';
    document.getElementById('ipRuleEditReason').value = button.dataset.reason || '';
    document.getElementById('ipRuleEditDetailMessage').value = button.dataset.detailMessage || '';
    fillIpRuleEditControlModes(hasBatch, button.dataset.controlMode || 'MANUAL');
    document.getElementById('ipRuleEditHistoryBtn').onclick = function () {
        closeModal('ipRuleEditModal');
        openBlockDetail(button.dataset.templateId, 'IP 정책 이력');
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
        adm_toast(data.message || '저장되었습니다.');
        location.reload();
    } else {
        adm_toast(data.message || '저장 실패', 'error');
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
        adm_toast(data.message || '저장되었습니다.');
        location.reload();
    } else {
        adm_toast(data.message || '저장 실패', 'error');
    }
}

async function toggleIpRule(id, active) {
    const message = active ? '이 규칙을 개별 ON 하시겠습니까?' : '이 규칙을 개별 OFF 하시겠습니까?';
    if (!confirm(message)) return;
    const res = await fetch(CTX + '/admin/blocks/ip-rules/' + id + '/toggle', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: 'active=' + active
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || '변경되었습니다.');
        location.reload();
    } else {
        adm_toast(data.message || '변경 실패', 'error');
    }
}

async function returnToBatch(id) {
    if (!confirm('이 규칙을 배치 제어 상태로 되돌리시겠습니까? 수동 예외 설정은 해제됩니다.')) return;
    const res = await fetch(CTX + '/admin/blocks/ip-rules/' + id + '/return-to-batch', {
        method: 'POST',
        headers: {'X-Requested-With': 'XMLHttpRequest'}
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || '변경되었습니다.');
        location.reload();
    } else {
        adm_toast(data.message || '변경 실패', 'error');
    }
}

async function releaseUserBlock(targetKey) {
    if (!confirm('이 회원 차단을 해제하시겠습니까?')) return;
    const params = new URLSearchParams({blockTargetKey: targetKey});
    const res = await fetch(CTX + '/admin/blocks/user-blocks/release', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || '해제되었습니다.');
        location.reload();
    } else {
        adm_toast(data.message || '해제 실패', 'error');
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
        adm_toast(data.message || '저장되었습니다.');
        location.reload();
    } else {
        adm_toast(data.message || '저장 실패', 'error');
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
        adm_toast(data.message || '생성되었습니다.');
        location.reload();
    } else {
        adm_toast(data.message || '생성 실패', 'error');
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
        adm_toast(data.message || '저장되었습니다.');
        location.reload();
    } else {
        adm_toast(data.message || '저장 실패', 'error');
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
    document.getElementById('batchToggleTitle').textContent = nextActive ? '배치 재활성화' : '배치 비활성화';

    if (nextActive) {
        document.getElementById('batchToggleSummary').textContent = batchName + ' 배치를 다시 평가 대상에 넣습니다.';
        optionSelect.innerHTML =
            '<option value="BATCH_ONLY">배치만 ON</option>' +
            '<option value="RESTORE_BATCH_CONTROL">이전 배치 OFF로 꺼진 규칙 복구</option>' +
            '<option value="FORCE_ENABLE_ALL">배치 내 규칙 전부 ON</option>';
        optionSelect.value = button.dataset.defaultEnableStrategy || 'BATCH_ONLY';
    } else {
        document.getElementById('batchToggleSummary').textContent = batchName + ' 배치를 평가 대상에서 제외합니다. 현재 최종 적용 규칙 ' + effectiveRules + '개, 개별 ON 규칙 ' + activeRules + '개입니다.';
        optionSelect.innerHTML =
            '<option value="BATCH_ONLY">배치만 OFF</option>' +
            '<option value="CASCADE_ACTIVE_RULES">배치 제어 규칙도 함께 OFF</option>';
        optionSelect.value = button.dataset.defaultDisableStrategy || 'BATCH_ONLY';
    }

    document.getElementById('batchToggleDescription').value = '';
    document.getElementById('batchToggleModal').classList.add('open');
}

async function fetchHistoryCurrentSetting(button) {
    const historyId = button.dataset.historyId;
    if (!historyId) return null;

    const url = CTX + '/admin/blocks/histories/' + encodeURIComponent(historyId)
        + '/current-setting?currentType=' + encodeURIComponent(button.dataset.currentType || '');
    const res = await fetch(url, {
        headers: {'X-Requested-With': 'XMLHttpRequest'}
    });
    const data = await res.json();
    if (!res.ok || !data.success) {
        throw new Error(data.message || '현재 설정 조회에 실패했습니다.');
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
    const currentType = button.dataset.currentType;
    const targetKey = button.dataset.targetKey || '';
    const ruleAction = button.dataset.ruleAction || '';
    const batchId = button.dataset.batchId || '';

    if (currentType === 'BATCH' && batchId) {
        const batchButton = findFirstButton('.js-open-batch-editor', function (candidate) {
            return candidate.dataset.batchId === batchId && candidate.dataset.sourceType;
        });
        if (batchButton) {
            openBatchEditor(batchButton);
            return;
        }
    }

    if (currentType === 'USER_BLOCK') {
        const userButton = findFirstButton('.js-open-user-block-editor', function (candidate) {
            return candidate.dataset.targetKey === targetKey;
        });
        if (userButton) {
            openUserBlockEditor(userButton);
            return;
        }
    }

    const ruleButton = findFirstButton('.js-open-ip-rule-editor', function (candidate) {
        const sameTarget = candidate.dataset.targetKey === targetKey;
        const sameAction = !ruleAction || candidate.dataset.ruleAction === ruleAction;
        const sameBatch = batchId ? candidate.dataset.batchId === batchId : true;
        return sameTarget && sameAction && sameBatch;
    });
    if (ruleButton) {
        openIpRuleEditor(ruleButton);
        return;
    }

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
        adm_toast(error.message || '현재 설정 조회에 실패했습니다.', 'error');
        return;
    }

    if (button.dataset.templateId) {
        openBlockDetail(button.dataset.templateId, '차단 상세');
    }
    adm_toast('이력 기준 현재 설정을 찾지 못했습니다. 대상이 삭제되었거나 더 이상 연결되지 않았을 수 있습니다.', 'error');
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
        adm_toast(data.message || '변경되었습니다.');
        location.reload();
    } else {
        adm_toast(data.message || '변경 실패', 'error');
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
        openBlockDetail(detailBtn.dataset.templateId, '차단 상세');
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
