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
                <div class="adm-kpi-card"><div class="adm-kpi-label">활성 IP 규칙</div><div class="adm-kpi-value">${activeIpBlockCount}</div></div>
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
                            <td><span class="status-badge ${b.active ? 'active' : 'dormant'}">${b.snapshotStatus}</span></td>
                            <td style="max-width:260px;white-space:normal;">${empty b.reason ? '-' : b.reason}</td>
                            <td style="font-size:12px;">
                                <div><fmt:formatDate value="${b.blockedAt}" pattern="yyyy.MM.dd HH:mm"/></div>
                                <div style="color:#94a3b8;">만료: <c:choose><c:when test="${b.expiresAt != null}"><fmt:formatDate value="${b.expiresAt}" pattern="yyyy.MM.dd HH:mm"/></c:when><c:otherwise>없음</c:otherwise></c:choose></div>
                            </td>
                            <td><c:if test="${hasUserBlockAdmin and b.active}"><button class="adm-row-btn danger" onclick="releaseUserBlock('${fn:escapeXml(b.blockTargetKey)}')">해제</button></c:if></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userBlocks}"><tr><td colspan="7" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

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
                    <tr><th>규칙</th><th>매칭</th><th>분류</th><th>배치</th><th>상태</th><th>우선순위</th><th>사유</th><th>액션</th></tr>
                    </thead>
                    <tbody>
                    <c:forEach var="r" items="${ipBlocks}">
                        <tr>
                            <td><div style="font-weight:700;color:#e2e8f0;">${r.blockTargetKey}</div><div style="font-size:12px;color:#94a3b8;">대표값: ${r.ipAddress}</div></td>
                            <td><div>${r.matchType}</div><c:if test="${not empty r.cidrNotation}"><div style="font-size:12px;color:#94a3b8;">${r.cidrNotation}</div></c:if><c:if test="${not empty r.rangeStartIp}"><div style="font-size:12px;color:#94a3b8;">${r.rangeStartIp} ~ ${r.rangeEndIp}</div></c:if></td>
                            <td>${r.blockCategory}</td>
                            <td>${empty r.batchName ? '-' : r.batchName}</td>
                            <td><span class="status-badge ${r.active ? 'active' : 'dormant'}">${r.active ? 'ACTIVE' : 'INACTIVE'}</span></td>
                            <td>${r.priority}</td>
                            <td style="max-width:260px;white-space:normal;">${empty r.reason ? '-' : r.reason}</td>
                            <td><c:if test="${hasIpBlockAdmin or hasBlockPolicyAdmin}"><button class="adm-row-btn ${r.active ? 'danger' : 'detail'}" onclick="toggleIpRule(${r.ipBlocklistIdx}, ${r.active ? 'false' : 'true'})">${r.active ? '비활성화' : '재활성화'}</button></c:if></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty ipBlocks}"><tr><td colspan="8" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

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
                            <td><span class="status-badge ${b.active ? 'active' : 'dormant'}">${b.active ? 'ACTIVE' : 'INACTIVE'}</span></td>
                            <td>전체 ${b.totalRuleCount} / 활성 ${b.activeRuleCount}</td>
                            <td style="max-width:260px;white-space:normal;">${empty b.description ? '-' : b.description}</td>
                            <td><c:if test="${hasBlockPolicyAdmin}"><button class="adm-row-btn ${b.active ? 'danger' : 'detail'}" onclick="toggleBatch(${b.ipBlockBatchIdx}, ${b.active ? 'false' : 'true'})">${b.active ? '비활성화' : '재활성화'}</button></c:if></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty batches}"><tr><td colspan="6" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head"><div class="adm-card-title">통합 차단 이력</div><div class="adm-card-sub">회원 차단, 전역 차단, 자동 탐지 동기화 이력을 통합 조회합니다.</div></div>
        <div class="adm-card-body" style="padding:0;">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead><tr><th>시각</th><th>대상</th><th>유형</th><th>출처</th><th>상태</th><th>사유</th></tr></thead>
                    <tbody>
                    <c:forEach var="h" items="${histories}">
                        <tr>
                            <td><fmt:formatDate value="${h.blockedAt}" pattern="yyyy.MM.dd HH:mm"/></td>
                            <td><div style="font-weight:700;color:#e2e8f0;">${h.blockTargetKey}</div><div style="font-size:12px;color:#94a3b8;">${empty h.nickname ? '-' : h.nickname}</div></td>
                            <td>${h.blockType}<div style="font-size:12px;color:#94a3b8;">${h.ipMatchType}</div></td>
                            <td>${h.blockScope}<div style="font-size:12px;color:#94a3b8;">${h.historyKind}</div></td>
                            <td><span class="status-badge ${h.active ? 'active' : 'dormant'}">${h.active ? 'ACTIVE' : 'INACTIVE'}</span></td>
                            <td style="max-width:320px;white-space:normal;">${empty h.reason ? '-' : h.reason}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}"><tr><td colspan="6" style="text-align:center;padding:32px;color:#64748b;">데이터가 없습니다.</td></tr></c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="ipRuleModal"><div class="adm-modal" style="max-width:640px;"><div class="adm-modal-head"><div class="adm-modal-title">전역 IP 차단 규칙 추가</div><button class="adm-modal-close" onclick="closeModal('ipRuleModal')">✕</button></div><div class="adm-modal-body"><div class="sa-form-grid" style="grid-template-columns:1fr 1fr;"><div class="sa-form-group"><label class="sa-form-label">매칭 방식</label><select id="ipMatchType" class="adm-select" onchange="handleIpRuleTypeChange()"><option value="SINGLE_IP">단일 IP</option><option value="CIDR">CIDR</option><option value="RANGE">범위</option></select></div><div class="sa-form-group"><label class="sa-form-label">분류</label><select id="ipBlockCategory" class="adm-select"><option value="MANUAL">MANUAL</option><option value="SPAM">SPAM</option><option value="VPN">VPN</option><option value="SECURITY">SECURITY</option><option value="BRUTE_FORCE">BRUTE_FORCE</option></select></div><div class="sa-form-group" id="fieldSingleIp"><label class="sa-form-label">IP 주소</label><input id="ipAddressInput" class="adm-input" type="text" placeholder="예: 203.0.113.10"></div><div class="sa-form-group" id="fieldCidr" style="display:none;"><label class="sa-form-label">CIDR</label><input id="cidrNotationInput" class="adm-input" type="text" placeholder="예: 203.0.113.0/24"></div><div class="sa-form-group" id="fieldRangeStart" style="display:none;"><label class="sa-form-label">범위 시작 IP</label><input id="rangeStartInput" class="adm-input" type="text" placeholder="예: 203.0.113.1"></div><div class="sa-form-group" id="fieldRangeEnd" style="display:none;"><label class="sa-form-label">범위 끝 IP</label><input id="rangeEndInput" class="adm-input" type="text" placeholder="예: 203.0.113.255"></div><div class="sa-form-group"><label class="sa-form-label">배치</label><select id="ipBatchIdx" class="adm-select"><option value="">(없음)</option><c:forEach var="b" items="${batches}"><option value="${b.ipBlockBatchIdx}">${b.batchName} (${b.batchCode})</option></c:forEach></select></div><div class="sa-form-group"><label class="sa-form-label">우선순위</label><input id="ipPriority" class="adm-input" type="number" min="1" value="1"></div><div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label">만료 시각</label><input id="ipExpiresAt" class="adm-input" type="datetime-local"></div><div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label">사유</label><textarea id="ipReason" class="adm-input" style="min-height:90px;"></textarea></div></div></div><div class="adm-modal-foot"><button class="adm-btn adm-btn-ghost" onclick="closeModal('ipRuleModal')">취소</button><button class="adm-btn adm-btn-primary" onclick="submitIpRule()">저장</button></div></div></div>

<div class="adm-modal-overlay" id="batchModal"><div class="adm-modal" style="max-width:560px;"><div class="adm-modal-head"><div class="adm-modal-title">IP 차단 배치 생성</div><button class="adm-modal-close" onclick="closeModal('batchModal')">✕</button></div><div class="adm-modal-body"><div class="sa-form-grid" style="grid-template-columns:1fr 1fr;"><div class="sa-form-group"><label class="sa-form-label">배치 코드</label><input id="batchCode" class="adm-input" type="text" placeholder="예: VPN_FEED_202604"></div><div class="sa-form-group"><label class="sa-form-label">배치명</label><input id="batchName" class="adm-input" type="text" placeholder="예: VPN 공개 대역 2026.04"></div><div class="sa-form-group"><label class="sa-form-label">출처 유형</label><select id="batchSourceType" class="adm-select"><option value="MANUAL">MANUAL</option><option value="VPN_FEED">VPN_FEED</option><option value="SPAM_FEED">SPAM_FEED</option><option value="GEO_POLICY">GEO_POLICY</option><option value="AUTO_DETECTION">AUTO_DETECTION</option></select></div><div class="sa-form-group"><label class="sa-form-label">출처명</label><input id="batchSourceName" class="adm-input" type="text" placeholder="예: 운영자 수동 등록"></div><div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label">설명</label><textarea id="batchDescription" class="adm-input" style="min-height:90px;"></textarea></div></div></div><div class="adm-modal-foot"><button class="adm-btn adm-btn-ghost" onclick="closeModal('batchModal')">취소</button><button class="adm-btn adm-btn-primary" onclick="submitBatch()">생성</button></div></div></div>

<script>
const CTX='${pageContext.request.contextPath}';
function openIpRuleModal(){ document.getElementById('ipRuleModal').classList.add('open'); }
function openBatchModal(){ document.getElementById('batchModal').classList.add('open'); }
function closeModal(id){ document.getElementById(id).classList.remove('open'); }
function handleIpRuleTypeChange(){const type=document.getElementById('ipMatchType').value;document.getElementById('fieldSingleIp').style.display = type==='SINGLE_IP' ? '' : 'none';document.getElementById('fieldCidr').style.display = type==='CIDR' ? '' : 'none';document.getElementById('fieldRangeStart').style.display = type==='RANGE' ? '' : 'none';document.getElementById('fieldRangeEnd').style.display = type==='RANGE' ? '' : 'none';}
async function submitIpRule(){const params=new URLSearchParams({matchType:document.getElementById('ipMatchType').value,ipAddress:document.getElementById('ipAddressInput').value.trim(),cidrNotation:document.getElementById('cidrNotationInput').value.trim(),rangeStartIp:document.getElementById('rangeStartInput').value.trim(),rangeEndIp:document.getElementById('rangeEndInput').value.trim(),blockCategory:document.getElementById('ipBlockCategory').value,priority:document.getElementById('ipPriority').value,ipBlockBatchIdx:document.getElementById('ipBatchIdx').value,reason:document.getElementById('ipReason').value.trim(),expiresAt:document.getElementById('ipExpiresAt').value});const res=await fetch(CTX+'/admin/blocks/ip-rules',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'},body:params.toString()});const data=await res.json();if(data.success){adm_toast(data.message||'저장되었습니다.');location.reload();}else adm_toast(data.message||'저장 실패','error');}
async function toggleIpRule(id,active){if(!confirm(active ? '이 규칙을 재활성화하시겠습니까?' : '이 규칙을 비활성화하시겠습니까?')) return;const res=await fetch(CTX+'/admin/blocks/ip-rules/'+id+'/toggle',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'},body:'active='+active});const data=await res.json();if(data.success){adm_toast(data.message||'변경되었습니다.');location.reload();}else adm_toast(data.message||'변경 실패','error');}
async function releaseUserBlock(targetKey){if(!confirm('이 회원 차단을 해제하시겠습니까?')) return;const res=await fetch(CTX+'/admin/blocks/user-blocks/release',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'},body:'blockTargetKey='+encodeURIComponent(targetKey)});const data=await res.json();if(data.success){adm_toast(data.message||'해제되었습니다.');location.reload();}else adm_toast(data.message||'해제 실패','error');}
async function submitBatch(){const params=new URLSearchParams({batchCode:document.getElementById('batchCode').value.trim(),batchName:document.getElementById('batchName').value.trim(),sourceType:document.getElementById('batchSourceType').value,sourceName:document.getElementById('batchSourceName').value.trim(),description:document.getElementById('batchDescription').value.trim()});const res=await fetch(CTX+'/admin/blocks/batches',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'},body:params.toString()});const data=await res.json();if(data.success){adm_toast(data.message||'생성되었습니다.');location.reload();}else adm_toast(data.message||'생성 실패','error');}
async function toggleBatch(id,active){if(!confirm(active ? '배치를 활성화하시겠습니까?' : '배치를 비활성화하시겠습니까?')) return;const res=await fetch(CTX+'/admin/blocks/batches/'+id+'/toggle',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'},body:'active='+active});const data=await res.json();if(data.success){adm_toast(data.message||'변경되었습니다.');location.reload();}else adm_toast(data.message||'변경 실패','error');}
</script>
<%@ include file="../layout-close.jsp" %>
