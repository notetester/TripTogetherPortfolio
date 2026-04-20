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
                <div class="adm-kpi-card"><div class="adm-kpi-label">활성 회원 차단</div><div class="adm-kpi-value">${activeUserBlockCount}</div></div>
                <div class="adm-kpi-card"><div class="adm-kpi-label">실제 적용 IP 규칙</div><div class="adm-kpi-value">${activeIpBlockCount}</div></div>
                <div class="adm-kpi-card"><div class="adm-kpi-label">차단 이력</div><div class="adm-kpi-value">${blockHistoryCount}</div></div>
                <div class="adm-kpi-card"><div class="adm-kpi-label">활성 배치</div><div class="adm-kpi-value">${activeBatchCount}</div></div>
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
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="회원/아이피/사유/배치코드 검색">
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">상태</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}>전체</option>
                            <option value="ACTIVE" ${search.status=='ACTIVE'?'selected':''}>활성</option>
                            <option value="INACTIVE" ${search.status=='INACTIVE'?'selected':''}>비활성</option>
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
                        <div class="adm-filter-label">차단 유형</div>
                        <select class="adm-select" name="blockType">
                            <option value="ALL" ${search.blockType=='ALL'?'selected':''}>전체</option>
                            <option value="USER_ONLY" ${search.blockType=='USER_ONLY'?'selected':''}>유저만</option>
                            <option value="IP_ONLY" ${search.blockType=='IP_ONLY'?'selected':''}>IP만</option>
                            <option value="USER_IP" ${search.blockType=='USER_IP'?'selected':''}>유저+IP</option>
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
                        <div class="adm-filter-label">실제 적용</div>
                        <select class="adm-select" name="effectiveStatus">
                            <option value="ALL" ${search.effectiveStatus=='ALL'?'selected':''}>전체</option>
                            <option value="APPLIED" ${search.effectiveStatus=='APPLIED'?'selected':''}>적용중</option>
                            <option value="RULE_INACTIVE" ${search.effectiveStatus=='RULE_INACTIVE'?'selected':''}>규칙꺼짐</option>
                            <option value="BATCH_INACTIVE" ${search.effectiveStatus=='BATCH_INACTIVE'?'selected':''}>배치꺼짐</option>
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
                            <td><div style="font-weight:700;color:#e2e8f0;">${empty b.nickname ? '-' : b.nickname}</div><div style="font-size:12px;color:#94a3b8;">${empty b.userId ? '-' : b.userId}</div></td>
                            <td>${b.blockType}</td>
                            <td><div>${empty b.blockedIp ? '-' : b.blockedIp}</div><div style="font-size:11px;color:#64748b;">${b.blockTargetKey}</div></td>
                            <td><span class="status-badge ${b.active ? 'ACTIVE' : 'DORMANT'}">${b.snapshotStatus}</span></td>
                            <td style="max-width:260px;white-space:normal;">${empty b.reason ? '-' : b.reason}</td>
                            <td style="font-size:12px;">
                                <div><fmt:formatDate value="${b.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div>
                                <div style="color:#94a3b8;">만료: <c:choose><c:when test="${b.expiresAtDate != null}"><fmt:formatDate value="${b.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>없음</c:otherwise></c:choose></div>
                            </td>
                            <td>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-user-${b.blockIdx}">상세</button>
                                <c:if test="${hasUserBlockAdmin and b.active}">
                                    <button type="button" class="adm-row-btn danger js-release-user-block" data-target-key="${fn:escapeXml(b.blockTargetKey)}">해제</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userBlocks}"><tr><td colspan="7" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr></c:if>
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
                        <tr><td>${rel.historyKind}</td><td>${rel.active ? 'ACTIVE' : 'INACTIVE'}</td><td><fmt:formatDate value="${rel.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></td><td>${empty rel.reason ? '-' : fn:escapeXml(rel.reason)}</td></tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </template>
    </c:forEach>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div><div class="adm-card-title">전역 IP 차단 규칙</div><div class="adm-card-sub">단일 IP, CIDR, 범위 규칙을 관리합니다.</div></div>
            <div style="display:flex;gap:8px;">
                <c:if test="${hasBlockPolicyAdmin}"><button class="adm-btn adm-btn-ghost" type="button" onclick="openBatchModal()">배치 생성</button></c:if>
                <c:if test="${hasIpBlockAdmin or hasBlockPolicyAdmin}"><button class="adm-btn adm-btn-primary" type="button" onclick="openIpRuleModal()">IP 규칙 추가</button></c:if>
            </div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr><th>규칙</th><th>매칭</th><th>분류</th><th>배치</th><th>실제 적용</th><th>우선순위</th><th>사유</th><th>액션</th></tr>
                    </thead>
                    <tbody>
                    <c:forEach var="r" items="${ipBlocks}">
                        <tr>
                            <td><div style="font-weight:700;color:#e2e8f0;">${r.blockTargetKey}</div><div style="font-size:12px;color:#94a3b8;">대표값: ${r.ipAddress}</div></td>
                            <td><div>${r.matchType}</div><c:if test="${not empty r.cidrNotation}"><div style="font-size:12px;color:#94a3b8;">${r.cidrNotation}</div></c:if><c:if test="${not empty r.rangeStartIp}"><div style="font-size:12px;color:#94a3b8;">${r.rangeStartIp} ~ ${r.rangeEndIp}</div></c:if></td>
                            <td>${r.blockCategory}</td>
                            <td>${empty r.batchName ? '-' : r.batchName}<div style="font-size:11px;color:#64748b;">${r.batchStatusLabel}</div></td>
                            <td><span class="status-badge ${r.effectiveStatusBadgeClass}">${r.effectiveStatusLabel}</span><div style="font-size:11px;color:#64748b;">규칙 ${r.active ? 'ON' : 'OFF'}</div></td>
                            <td>${r.priority}</td>
                            <td style="max-width:260px;white-space:normal;">${empty r.reason ? '-' : r.reason}</td>
                            <td>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-ip-${r.ipBlocklistIdx}">상세</button>
                                <c:if test="${hasIpBlockAdmin or hasBlockPolicyAdmin}">
                                    <button type="button" class="adm-row-btn ${r.active ? 'danger' : 'detail'} js-toggle-ip-rule" data-id="${r.ipBlocklistIdx}" data-active="${r.active ? 'false' : 'true'}">${r.active ? '비활성화' : '재활성화'}</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty ipBlocks}"><tr><td colspan="8" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <c:forEach var="r" items="${ipBlocks}">
        <template id="detail-ip-${r.ipBlocklistIdx}">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">대상 키</div><div class="detail-value">${r.blockTargetKey}</div></div>
                <div class="detail-item"><div class="detail-label">실제 적용</div><div class="detail-value">${r.effectiveStatusLabel}</div></div>
                <div class="detail-item"><div class="detail-label">대표값</div><div class="detail-value">${empty r.ipAddress ? '-' : r.ipAddress}</div></div>
                <div class="detail-item"><div class="detail-label">매칭 방식</div><div class="detail-value">${r.matchType}</div></div>
                <div class="detail-item"><div class="detail-label">CIDR</div><div class="detail-value">${empty r.cidrNotation ? '-' : r.cidrNotation}</div></div>
                <div class="detail-item"><div class="detail-label">범위</div><div class="detail-value">${empty r.rangeStartIp ? '-' : r.rangeStartIp} <c:if test="${not empty r.rangeEndIp}">~ ${r.rangeEndIp}</c:if></div></div>
                <div class="detail-item"><div class="detail-label">국가 / ASN</div><div class="detail-value">${empty r.countryCode ? '-' : r.countryCode} / ${empty r.asn ? '-' : r.asn}</div></div>
                <div class="detail-item"><div class="detail-label">분류 / 출처</div><div class="detail-value">${r.blockCategory} / ${r.sourceScope}</div></div>
                <div class="detail-item"><div class="detail-label">배치</div><div class="detail-value">${empty r.batchName ? '개별 규칙' : r.batchName} <c:if test="${not empty r.batchCode}">(${r.batchCode})</c:if> / ${r.batchStatusLabel}</div></div>
                <div class="detail-item"><div class="detail-label">규칙 상태</div><div class="detail-value">${r.active ? '활성' : '비활성'} / 우선순위 ${r.priority}</div></div>
                <div class="detail-item"><div class="detail-label">차단 시각</div><div class="detail-value"><fmt:formatDate value="${r.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
                <div class="detail-item"><div class="detail-label">만료 시각</div><div class="detail-value"><c:choose><c:when test="${r.expiresAtDate != null}"><fmt:formatDate value="${r.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>없음</c:otherwise></c:choose></div></div>
                <div class="detail-item"><div class="detail-label">해제 시각</div><div class="detail-value"><c:choose><c:when test="${r.releasedAtDate != null}"><fmt:formatDate value="${r.releasedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
                <div class="detail-item"><div class="detail-label">처리 관리자</div><div class="detail-value">${empty r.blockedByNickname ? '-' : r.blockedByNickname}</div></div>
            </div>
            <div class="detail-item" style="margin-top:14px;"><div class="detail-label">상세 설명</div><div class="detail-value"><c:choose><c:when test="${not empty r.detailMessage}">${fn:escapeXml(r.detailMessage)}</c:when><c:when test="${not empty r.reason}">${fn:escapeXml(r.reason)}</c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
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
                <thead><tr><th>관련 이력</th><th>상태</th><th>시각</th><th>사유</th></tr></thead>
                <tbody>
                <c:forEach var="rel" items="${histories}">
                    <c:if test="${rel.blockTargetKey == r.blockTargetKey}">
                        <tr><td>${rel.historyKind}</td><td>${rel.active ? 'ACTIVE' : 'INACTIVE'}</td><td><fmt:formatDate value="${rel.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></td><td>${empty rel.reason ? '-' : fn:escapeXml(rel.reason)}</td></tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </template>
    </c:forEach>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head"><div class="adm-card-title">IP 차단 배치</div><div class="adm-card-sub">VPN 피드, 수동 정책 묶음 등 전역 IP 차단 배치를 관리합니다.</div></div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead><tr><th>배치</th><th>출처</th><th>상태</th><th>규칙 수</th><th>설명</th><th>액션</th></tr></thead>
                    <tbody>
                    <c:forEach var="b" items="${batches}">
                        <tr>
                            <td><div style="font-weight:700;color:#e2e8f0;">${b.batchName}</div><div style="font-size:12px;color:#94a3b8;">${b.batchCode}</div></td>
                            <td>${b.sourceType}<div style="font-size:12px;color:#94a3b8;">${empty b.sourceName ? '-' : b.sourceName}</div></td>
                            <td><span class="status-badge ${b.active ? 'ACTIVE' : 'DORMANT'}">${b.activeLabel}</span></td>
                            <td>
                                <div>전체 ${b.totalRuleCount} / 규칙 활성 ${b.activeRuleCount}</div>
                                <div style="font-size:11px;color:#94a3b8;">실제 적용 ${b.effectiveRuleCount} / 만료 ${b.expiredRuleCount}</div>
                            </td>
                            <td style="max-width:260px;white-space:normal;">${empty b.description ? '-' : b.description}</td>
                            <td>
                                <button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-batch-${b.ipBlockBatchIdx}">상세</button>
                                <c:if test="${hasBlockPolicyAdmin}">
                                    <button type="button" class="adm-row-btn ${b.active ? 'danger' : 'detail'} js-toggle-batch" data-id="${b.ipBlockBatchIdx}" data-active="${b.active ? 'false' : 'true'}" data-active-rules="${b.activeRuleCount}" data-effective-rules="${b.effectiveRuleCount}">${b.active ? '비활성화' : '재활성화'}</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty batches}"><tr><td colspan="6" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr></c:if>
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
                <div class="detail-item"><div class="detail-label">규칙 수</div><div class="detail-value">전체 ${b.totalRuleCount}, 규칙 활성 ${b.activeRuleCount}</div></div>
                <div class="detail-item"><div class="detail-label">실제 적용</div><div class="detail-value">${b.effectiveRuleCount}개 적용 / ${b.expiredRuleCount}개 만료</div></div>
                <div class="detail-item"><div class="detail-label">생성</div><div class="detail-value">${empty b.createdByNickname ? '-' : b.createdByNickname} / <fmt:formatDate value="${b.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
                <div class="detail-item"><div class="detail-label">최근 수정</div><div class="detail-value">${empty b.updatedByNickname ? '-' : b.updatedByNickname} / <fmt:formatDate value="${b.updatedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
            </div>
            <div class="detail-item" style="margin-top:14px;"><div class="detail-label">상세 설명</div><div class="detail-value">${empty b.description ? '-' : fn:escapeXml(b.description)}</div></div>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th>운영 안내</th><th>내용</th></tr></thead>
                <tbody>
                <tr><td>비활성화 영향</td><td>배치가 꺼지면 이 배치의 활성 규칙은 차단 판정에서 제외됩니다. 개별 규칙의 ON/OFF 값은 보존됩니다.</td></tr>
                <tr><td>재활성화 영향</td><td>배치를 다시 켜면 개별 규칙이 활성이고 만료되지 않은 규칙만 다시 적용됩니다.</td></tr>
                </tbody>
            </table>
            <table class="history-table" style="margin-top:14px;">
                <thead><tr><th>연결 규칙</th><th>적용</th><th>매칭</th><th>사유</th></tr></thead>
                <tbody>
                <c:forEach var="rule" items="${ipBlocks}">
                    <c:if test="${rule.ipBlockBatchIdx == b.ipBlockBatchIdx}">
                        <tr><td>${rule.blockTargetKey}</td><td>${rule.effectiveStatusLabel}</td><td>${rule.matchType}</td><td>${empty rule.reason ? '-' : fn:escapeXml(rule.reason)}</td></tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </template>
    </c:forEach>

    <div class="adm-card">
        <div class="adm-card-head"><div class="adm-card-title">통합 차단 이력</div><div class="adm-card-sub">회원 차단, 전역 차단, 자동 탐지 동기화 이력을 통합 조회합니다.</div></div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead><tr><th>시각</th><th>대상</th><th>유형</th><th>출처</th><th>상태</th><th>사유</th><th>액션</th></tr></thead>
                    <tbody>
                    <c:forEach var="h" items="${histories}">
                        <tr>
                            <td><fmt:formatDate value="${h.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></td>
                            <td><div style="font-weight:700;color:#e2e8f0;">${h.blockTargetKey}</div><div style="font-size:12px;color:#94a3b8;">${empty h.nickname ? '-' : h.nickname}</div></td>
                            <td>${h.blockType}<div style="font-size:12px;color:#94a3b8;">${h.ipMatchType}</div></td>
                            <td>${h.blockScope}<div style="font-size:12px;color:#94a3b8;">${h.historyKind}</div></td>
                            <td><span class="status-badge ${h.active ? 'ACTIVE' : 'DORMANT'}">${h.active ? 'ACTIVE' : 'INACTIVE'}</span></td>
                            <td style="max-width:320px;white-space:normal;">${empty h.reason ? '-' : h.reason}</td>
                            <td><button type="button" class="adm-row-btn detail js-detail-open" data-template-id="detail-history-${h.blockIdx}">상세</button></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}"><tr><td colspan="7" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr></c:if>
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
            <div class="detail-item"><div class="detail-label">상태</div><div class="detail-value">${h.active ? 'ACTIVE' : 'INACTIVE'} / ${h.historyKind}</div></div>
            <div class="detail-item"><div class="detail-label">회원</div><div class="detail-value">${empty h.nickname ? '-' : h.nickname} / ${empty h.userId ? '-' : h.userId}</div></div>
            <div class="detail-item"><div class="detail-label">차단 유형</div><div class="detail-value">${h.blockType}</div></div>
            <div class="detail-item"><div class="detail-label">차단 IP</div><div class="detail-value">${empty h.blockedIp ? '-' : h.blockedIp}</div></div>
            <div class="detail-item"><div class="detail-label">출처 / 매칭</div><div class="detail-value">${h.blockScope} / ${empty h.ipMatchType ? '-' : h.ipMatchType}</div></div>
            <div class="detail-item"><div class="detail-label">CIDR</div><div class="detail-value">${empty h.cidrNotation ? '-' : h.cidrNotation}</div></div>
            <div class="detail-item"><div class="detail-label">범위</div><div class="detail-value">${empty h.rangeStartIp ? '-' : h.rangeStartIp} <c:if test="${not empty h.rangeEndIp}">~ ${h.rangeEndIp}</c:if></div></div>
            <div class="detail-item"><div class="detail-label">배치</div><div class="detail-value">${empty h.batchName ? '-' : h.batchName} <c:if test="${not empty h.batchCode}">(${h.batchCode})</c:if></div></div>
            <div class="detail-item"><div class="detail-label">요청 ID</div><div class="detail-value">${empty h.blockRequestId ? '-' : h.blockRequestId}</div></div>
            <div class="detail-item"><div class="detail-label">차단 시각</div><div class="detail-value"><fmt:formatDate value="${h.blockedAtDate}" pattern="yyyy.MM.dd HH:mm"/></div></div>
            <div class="detail-item"><div class="detail-label">만료 시각</div><div class="detail-value"><c:choose><c:when test="${h.expiresAtDate != null}"><fmt:formatDate value="${h.expiresAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>없음</c:otherwise></c:choose></div></div>
            <div class="detail-item"><div class="detail-label">해제 시각</div><div class="detail-value"><c:choose><c:when test="${h.releasedAtDate != null}"><fmt:formatDate value="${h.releasedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
            <div class="detail-item"><div class="detail-label">동기화</div><div class="detail-value"><c:choose><c:when test="${h.listSyncedAtDate != null}"><fmt:formatDate value="${h.listSyncedAtDate}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div></div>
        </div>
        <div class="detail-item" style="margin-top:14px;"><div class="detail-label">상세 사유</div><div class="detail-value">${empty h.reason ? '-' : fn:escapeXml(h.reason)}</div></div>
        <table class="history-table" style="margin-top:14px;">
            <thead><tr><th>담당</th><th>관리자</th></tr></thead>
            <tbody>
            <tr><td>차단 처리</td><td>${empty h.blockedByNickname ? '-' : h.blockedByNickname}</td></tr>
            <tr><td>해제 처리</td><td>${empty h.releasedByNickname ? '-' : h.releasedByNickname}</td></tr>
            </tbody>
        </table>
    </template>
</c:forEach>

<div class="adm-modal-overlay" id="blockDetailModal">
    <div class="adm-modal" style="max-width:820px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockDetailTitle">차단 상세</div>
            <button class="adm-modal-close" onclick="closeModal('blockDetailModal')">✕</button>
        </div>
        <div class="adm-modal-body" id="blockDetailBody"></div>
    </div>
</div>

<div class="adm-modal-overlay" id="ipRuleModal">
    <div class="adm-modal" style="max-width:640px;">
        <div class="adm-modal-head"><div class="adm-modal-title">전역 IP 차단 규칙 추가</div><button class="adm-modal-close" onclick="closeModal('ipRuleModal')">✕</button></div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;">
                <div class="sa-form-group"><label class="sa-form-label">매칭 방식</label><select id="ipMatchType" class="adm-select" onchange="handleIpRuleTypeChange()"><option value="SINGLE_IP">단일 IP</option><option value="CIDR">CIDR</option><option value="RANGE">범위</option><option value="COUNTRY">국가</option><option value="ASN">ASN</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">분류</label><select id="ipBlockCategory" class="adm-select"><option value="MANUAL">MANUAL</option><option value="SPAM">SPAM</option><option value="ABUSE">ABUSE</option><option value="BRUTE_FORCE">BRUTE_FORCE</option><option value="GEO">GEO</option><option value="VPN">VPN</option><option value="SECURITY">SECURITY</option></select></div>
                <div class="sa-form-group" id="fieldSingleIp"><label class="sa-form-label">IP 주소</label><input id="ipAddressInput" class="adm-input" type="text" placeholder="예: 203.0.113.10"></div>
                <div class="sa-form-group" id="fieldCidr" style="display:none;"><label class="sa-form-label">CIDR</label><input id="cidrNotationInput" class="adm-input" type="text" placeholder="예: 203.0.113.0/24"></div>
                <div class="sa-form-group" id="fieldRangeStart" style="display:none;"><label class="sa-form-label">범위 시작 IP</label><input id="rangeStartInput" class="adm-input" type="text" placeholder="예: 203.0.113.1"></div>
                <div class="sa-form-group" id="fieldRangeEnd" style="display:none;"><label class="sa-form-label">범위 끝 IP</label><input id="rangeEndInput" class="adm-input" type="text" placeholder="예: 203.0.113.255"></div>
                <div class="sa-form-group" id="fieldCountry" style="display:none;"><label class="sa-form-label">국가 코드</label><input id="countryCodeInput" class="adm-input" type="text" placeholder="예: CN"></div>
                <div class="sa-form-group" id="fieldAsn" style="display:none;"><label class="sa-form-label">ASN</label><input id="asnInput" class="adm-input" type="text" placeholder="예: AS12345"></div>
                <div class="sa-form-group"><label class="sa-form-label">배치</label><select id="ipBatchIdx" class="adm-select"><option value="">(없음)</option><c:forEach var="b" items="${batches}"><option value="${b.ipBlockBatchIdx}">${b.batchName} (${b.batchCode}, ${b.active ? '활성' : '비활성'})</option></c:forEach></select></div>
                <div class="sa-form-group"><label class="sa-form-label">우선순위</label><input id="ipPriority" class="adm-input" type="number" min="1" value="1"></div>
                <div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label">만료 시각</label><input id="ipExpiresAt" class="adm-input" type="datetime-local"></div>
                <div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label">사유</label><textarea id="ipReason" class="adm-input" style="min-height:90px;"></textarea></div>
            </div>
        </div>
        <div class="adm-modal-foot"><button class="adm-btn adm-btn-ghost" onclick="closeModal('ipRuleModal')">취소</button><button class="adm-btn adm-btn-primary" onclick="submitIpRule()">저장</button></div>
    </div>
</div>

<div class="adm-modal-overlay" id="batchModal"><div class="adm-modal" style="max-width:560px;"><div class="adm-modal-head"><div class="adm-modal-title">IP 차단 배치 생성</div><button class="adm-modal-close" onclick="closeModal('batchModal')">✕</button></div><div class="adm-modal-body"><div class="sa-form-grid" style="grid-template-columns:1fr 1fr;"><div class="sa-form-group"><label class="sa-form-label">배치 코드</label><input id="batchCode" class="adm-input" type="text" placeholder="예: VPN_FEED_202604"></div><div class="sa-form-group"><label class="sa-form-label">배치명</label><input id="batchName" class="adm-input" type="text" placeholder="예: VPN 공개 대역 2026.04"></div><div class="sa-form-group"><label class="sa-form-label">출처 유형</label><select id="batchSourceType" class="adm-select"><option value="MANUAL">MANUAL</option><option value="VPN_FEED">VPN_FEED</option><option value="SPAM_FEED">SPAM_FEED</option><option value="GEO_POLICY">GEO_POLICY</option><option value="AUTO_DETECTION">AUTO_DETECTION</option></select></div><div class="sa-form-group"><label class="sa-form-label">출처명</label><input id="batchSourceName" class="adm-input" type="text" placeholder="예: 운영자 수동 등록"></div><div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label">설명</label><textarea id="batchDescription" class="adm-input" style="min-height:90px;"></textarea></div></div></div><div class="adm-modal-foot"><button class="adm-btn adm-btn-ghost" onclick="closeModal('batchModal')">취소</button><button class="adm-btn adm-btn-primary" onclick="submitBatch()">생성</button></div></div></div>

<script>
const CTX='${pageContext.request.contextPath}';
function openIpRuleModal(){ document.getElementById('ipRuleModal').classList.add('open'); handleIpRuleTypeChange(); }
function openBatchModal(){ document.getElementById('batchModal').classList.add('open'); }
function closeModal(id){ document.getElementById(id).classList.remove('open'); }

function handleIpRuleTypeChange(){
    const type = document.getElementById('ipMatchType').value;
    document.getElementById('fieldSingleIp').style.display = type === 'SINGLE_IP' ? '' : 'none';
    document.getElementById('fieldCidr').style.display = type === 'CIDR' ? '' : 'none';
    document.getElementById('fieldRangeStart').style.display = type === 'RANGE' ? '' : 'none';
    document.getElementById('fieldRangeEnd').style.display = type === 'RANGE' ? '' : 'none';
    document.getElementById('fieldCountry').style.display = type === 'COUNTRY' ? '' : 'none';
    document.getElementById('fieldAsn').style.display = type === 'ASN' ? '' : 'none';
}

function openBlockDetail(templateId) {
    const template = document.getElementById(templateId);
    if (!template) return;
    document.getElementById('blockDetailBody').innerHTML = template.innerHTML;
    document.getElementById('blockDetailModal').classList.add('open');
}

async function submitIpRule(){
    const params = new URLSearchParams({
        matchType: document.getElementById('ipMatchType').value,
        ipAddress: document.getElementById('ipAddressInput').value.trim(),
        cidrNotation: document.getElementById('cidrNotationInput').value.trim(),
        rangeStartIp: document.getElementById('rangeStartInput').value.trim(),
        rangeEndIp: document.getElementById('rangeEndInput').value.trim(),
        countryCode: document.getElementById('countryCodeInput').value.trim(),
        asn: document.getElementById('asnInput').value.trim(),
        blockCategory: document.getElementById('ipBlockCategory').value,
        priority: document.getElementById('ipPriority').value,
        ipBlockBatchIdx: document.getElementById('ipBatchIdx').value,
        reason: document.getElementById('ipReason').value.trim(),
        expiresAt: document.getElementById('ipExpiresAt').value
    });
    const res = await fetch(CTX + '/admin/blocks/ip-rules', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'}, body:params.toString()});
    const data = await res.json();
    if (data.success) { adm_toast(data.message || '저장되었습니다.'); location.reload(); }
    else adm_toast(data.message || '저장 실패','error');
}

async function toggleIpRule(id, active){
    if (!confirm(active ? '이 규칙을 재활성화하시겠습니까?' : '이 규칙을 비활성화하시겠습니까?')) return;
    const res = await fetch(CTX + '/admin/blocks/ip-rules/' + id + '/toggle', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'}, body:'active=' + active});
    const data = await res.json();
    if (data.success) { adm_toast(data.message || '변경되었습니다.'); location.reload(); }
    else adm_toast(data.message || '변경 실패','error');
}

async function releaseUserBlock(targetKey){
    if (!confirm('이 회원 차단을 해제하시겠습니까?')) return;
    const params = new URLSearchParams({blockTargetKey: targetKey});
    const res = await fetch(CTX + '/admin/blocks/user-blocks/release', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'}, body:params.toString()});
    const data = await res.json();
    if (data.success) { adm_toast(data.message || '해제되었습니다.'); location.reload(); }
    else adm_toast(data.message || '해제 실패','error');
}

async function submitBatch(){
    const params = new URLSearchParams({
        batchCode: document.getElementById('batchCode').value.trim(),
        batchName: document.getElementById('batchName').value.trim(),
        sourceType: document.getElementById('batchSourceType').value,
        sourceName: document.getElementById('batchSourceName').value.trim(),
        description: document.getElementById('batchDescription').value.trim()
    });
    const res = await fetch(CTX + '/admin/blocks/batches', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'}, body:params.toString()});
    const data = await res.json();
    if (data.success) { adm_toast(data.message || '생성되었습니다.'); location.reload(); }
    else adm_toast(data.message || '생성 실패','error');
}

async function toggleBatch(id, active, activeRules, effectiveRules){
    const message = active
        ? '배치를 활성화하시겠습니까? 개별 규칙이 활성이고 만료되지 않은 규칙만 다시 적용됩니다.'
        : '배치를 비활성화하시겠습니까? 현재 실제 적용 중인 규칙 ' + effectiveRules + '개가 차단 판정에서 제외됩니다.';
    if (!confirm(message)) return;
    const res = await fetch(CTX + '/admin/blocks/batches/' + id + '/toggle', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'}, body:'active=' + active});
    const data = await res.json();
    if (data.success) { adm_toast(data.message || '변경되었습니다.'); location.reload(); }
    else adm_toast(data.message || '변경 실패','error');
}

document.addEventListener('click', function(e) {
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
    const batchToggleBtn = e.target.closest('.js-toggle-batch');
    if (batchToggleBtn) {
        toggleBatch(batchToggleBtn.dataset.id, batchToggleBtn.dataset.active === 'true', batchToggleBtn.dataset.activeRules, batchToggleBtn.dataset.effectiveRules);
    }
});
</script>
<%@ include file="../layout-close.jsp" %>
