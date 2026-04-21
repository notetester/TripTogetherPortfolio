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

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">현재 회원 차단 상태</div>
            <div class="adm-card-sub">회원 기준 현재 활성/비활성 스냅샷</div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr><th>회원</th><th>유형</th><th>대상</th><th>상태</th><th>사유</th><th>차단 / 만료</th><th>액션</th></tr>
                    </thead>
                    <tbody>
                    <c:forEach var="b" items="${userBlocks}">
                        <tr>
                            <td>
                                <div style="font-weight:700;color:#e2e8f0;">${empty b.nickname ? '-' : b.nickname}</div>
                                <div style="font-size:12px;color:#94a3b8;">${empty b.userId ? '-' : b.userId}</div>
                            </td>
                            <td>${b.blockType}</td>
                            <td>
                                <div>${empty b.blockedIp ? '-' : b.blockedIp}</div>
                                <div style="font-size:11px;color:#64748b;">${b.blockTargetKey}</div>
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
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-user-${b.blockIdx}">상세</button>
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

    <div class="adm-card" style="margin-bottom:20px;">
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
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr><th>대상</th><th>동작 / 제어</th><th>배치</th><th>상태</th><th>우선순위</th><th>사유</th><th>액션</th></tr>
                    </thead>
                    <tbody>
                    <c:forEach var="r" items="${ipBlocks}">
                        <tr>
                            <td>
                                <div style="font-weight:700;color:#e2e8f0;">${empty r.targetDisplayValue ? r.blockTargetKey : r.targetDisplayValue}</div>
                                <div style="font-size:12px;color:#94a3b8;">${r.blockTargetKey}</div>
                                <div style="font-size:11px;color:#64748b;">${r.matchType}</div>
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
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-ip-${r.ipBlocklistIdx}">상세</button>
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

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">IP 정책 배치</div>
            <div class="adm-card-sub">배치 기본 전략과 개별 예외를 함께 관리합니다.</div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead><tr><th>배치</th><th>기본 정책</th><th>현재 상태</th><th>규칙 통계</th><th>설명</th><th>액션</th></tr></thead>
                    <tbody>
                    <c:forEach var="b" items="${batches}">
                        <tr>
                            <td>
                                <div style="font-weight:700;color:#e2e8f0;">${b.batchName}</div>
                                <div style="font-size:12px;color:#94a3b8;">${b.batchCode}</div>
                                <div style="font-size:11px;color:#64748b;">${b.sourceType} / ${empty b.sourceName ? '-' : b.sourceName}</div>
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

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">통합 차단 이력</div>
            <div class="adm-card-sub">규칙 생성, 개별 예외, 배치 동기화까지 함께 추적합니다.</div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead><tr><th>시각</th><th>대상</th><th>동작</th><th>변경</th><th>결과</th><th>사유</th><th>액션</th></tr></thead>
                    <tbody>
                    <c:forEach var="h" items="${histories}">
                        <tr>
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
                            <td><button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-history-${h.blockIdx}">상세</button></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}">
                        <tr><td colspan="7" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr>
                    </c:if>
                    </tbody>
                </table>
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
            <div class="adm-modal-title">차단 상세</div>
            <button class="adm-modal-close" onclick="closeModal('blockDetailModal')">✕</button>
        </div>
        <div class="adm-modal-body" id="blockDetailBody"></div>
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

<script>
const CTX = '${pageContext.request.contextPath}';

function openIpRuleModal() {
    document.getElementById('ipRuleModal').classList.add('open');
    handleIpRuleTypeChange();
    handleIpBatchChange();
}

function openBatchModal() {
    document.getElementById('batchModal').classList.add('open');
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

function openBlockDetail(templateId) {
    const template = document.getElementById(templateId);
    if (!template) return;
    document.getElementById('blockDetailBody').innerHTML = template.innerHTML;
    document.getElementById('blockDetailModal').classList.add('open');
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
    const detailBtn = e.target.closest('.js-detail-open');
    if (detailBtn) {
        openBlockDetail(detailBtn.dataset.templateId);
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
    }
});
</script>
<%@ include file="../layout-close.jsp" %>
