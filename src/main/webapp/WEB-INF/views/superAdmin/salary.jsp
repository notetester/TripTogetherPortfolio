<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="salary"/>
<c:set var="pageTitle"  value="급여/역량 현황"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">급여·역량 현황 일람표</div>
            <div style="font-size:13px;color:#94a3b8;">전체 관리자의 직급·역량·급여 정보를 확인하고 수정합니다.</div>
        </div>
        <div class="adm-card-body" style="padding:0;">

            <%-- 검색/필터 폼 (서버사이드) --%>
            <form method="get" action="${pageContext.request.contextPath}/superAdmin/salary" class="sa-salary-toolbar" id="salaryFilterForm">
                <input type="text" name="keyword"
                       value="${fn:escapeXml(search.keyword)}"
                       placeholder="닉네임·부서·직책 검색…" class="adm-input" style="width:220px;">
                <input type="text" name="filterDepartment"
                       value="${fn:escapeXml(search.filterDepartment)}"
                       placeholder="부서 필터" class="adm-input" style="width:140px;">
                <input type="text" name="filterPermissionCode"
                       value="${fn:escapeXml(search.filterPermissionCode)}"
                       placeholder="실효권한 필터" class="adm-input" style="width:140px;">
                <select name="filterAccountStatus" class="adm-select" style="width:130px;">
                    <option value="">계정상태 전체</option>
                    <option value="ACTIVE"   <c:if test="${search.filterAccountStatus == 'ACTIVE'}">selected</c:if>>ACTIVE</option>
                    <option value="BLOCKED"  <c:if test="${search.filterAccountStatus == 'BLOCKED'}">selected</c:if>>BLOCKED</option>
                    <option value="DORMANT"  <c:if test="${search.filterAccountStatus == 'DORMANT'}">selected</c:if>>DORMANT</option>
                    <option value="DELETED"  <c:if test="${search.filterAccountStatus == 'DELETED'}">selected</c:if>>DELETED</option>
                </select>
                <input type="hidden" name="pageSize" value="${search.pageSize}">
                <button type="submit" class="adm-btn adm-btn-primary">검색</button>
                <a href="${pageContext.request.contextPath}/superAdmin/salary" class="adm-btn adm-btn-ghost">초기화</a>
                <button type="button" class="adm-btn adm-btn-ghost" style="margin-left:auto;"
                        onclick="triggerSalaryUpload()">⬆ Excel 업로드</button>
                <input type="file" id="salaryUploadInput" accept=".xlsx,.xls" style="display:none;"
                       onchange="handleSalaryFile(event)">
                <a href="${pageContext.request.contextPath}/superAdmin/salary/export?keyword=${fn:escapeXml(search.keyword)}&filterDepartment=${fn:escapeXml(search.filterDepartment)}&filterPermissionCode=${fn:escapeXml(search.filterPermissionCode)}&filterAccountStatus=${fn:escapeXml(search.filterAccountStatus)}"
                   class="adm-btn adm-btn-ghost">
                    ⬇ Excel 내보내기
                </a>
                <span style="font-size:13px;color:#94a3b8;">${total}명</span>
            </form>

            <div style="overflow-x:auto;">
                <table class="sa-salary-table" id="salaryTable">
                    <thead>
                        <tr>
                            <th>닉네임</th>
                            <th>부서</th>
                            <th>팀</th>
                            <th>직책코드</th>
                            <th>직함</th>
                            <th>직급(Rank)</th>
                            <th>연차</th>
                            <th>티어</th>
                            <th>레벨</th>
                            <th>밴드</th>
                            <th>그레이드</th>
                            <th>스텝</th>
                            <th>실효권한</th>
                            <th>상급자</th>
                            <th>급여 편집</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${salaryList}">
                        <tr data-idx="${m.userIdx}"
                            data-seniority="${fn:escapeXml(m.adminSeniority)}"
                            data-tier="${fn:escapeXml(m.adminTier)}"
                            data-level="${fn:escapeXml(m.adminLevel)}"
                            data-band="${fn:escapeXml(m.adminBand)}"
                            data-grade="${fn:escapeXml(m.adminGrade)}"
                            data-step="${fn:escapeXml(m.adminStep)}"
                            data-nickname="${fn:escapeXml(m.nickname)}">
                            <td>
                                <a href="${pageContext.request.contextPath}/superAdmin/members/${m.userIdx}/edit" class="sa-salary-name">${fn:escapeXml(m.nickname)}</a>
                            </td>
                            <td>${fn:escapeXml(m.adminDepartment)}</td>
                            <td>${fn:escapeXml(m.adminTeam)}</td>
                            <td>
                                <c:if test="${not empty m.adminPositionCode}">
                                    <span class="sa-salary-badge sa-badge-pos">${fn:escapeXml(m.adminPositionCode)}</span>
                                </c:if>
                                <c:if test="${empty m.adminPositionCode}">—</c:if>
                            </td>
                            <td>${fn:escapeXml(m.adminTitle)}</td>
                            <td>${fn:escapeXml(m.adminRank)}</td>
                            <td>${fn:escapeXml(m.adminSeniority)}</td>
                            <td>
                                <c:if test="${not empty m.adminTier}">
                                    <span class="sa-salary-badge sa-badge-tier">${fn:escapeXml(m.adminTier)}</span>
                                </c:if>
                                <c:if test="${empty m.adminTier}">—</c:if>
                            </td>
                            <td>${fn:escapeXml(m.adminLevel)}</td>
                            <td>${fn:escapeXml(m.adminBand)}</td>
                            <td>${fn:escapeXml(m.adminGrade)}</td>
                            <td>${fn:escapeXml(m.adminStep)}</td>
                            <td>
                                <c:if test="${not empty m.adminPermissionCode}">
                                    <span class="sa-salary-badge sa-badge-perm">${fn:escapeXml(m.adminPermissionCode)}</span>
                                </c:if>
                                <c:if test="${empty m.adminPermissionCode}">—</c:if>
                            </td>
                            <td>${fn:escapeXml(m.adminManagerNickname)}</td>
                            <td>
                                <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                        onclick="openSalaryEdit(this.closest('tr'))">편집</button>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty salaryList}">
                <div style="text-align:center;padding:60px;color:#94a3b8;">해당 조건의 관리자가 없습니다.</div>
            </c:if>

            <%-- 페이징 --%>
            <c:if test="${totalPage > 1}">
            <div class="adm-paging">
                <c:forEach begin="1" end="${totalPage}" var="p">
                    <a href="?keyword=${fn:escapeXml(search.keyword)}&filterDepartment=${fn:escapeXml(search.filterDepartment)}&filterPermissionCode=${fn:escapeXml(search.filterPermissionCode)}&filterAccountStatus=${fn:escapeXml(search.filterAccountStatus)}&page=${p}&pageSize=${search.pageSize}"
                       class="adm-page-btn <c:if test="${search.page == p}">active</c:if>">${p}</a>
                </c:forEach>
            </div>
            </c:if>

        </div>
    </div>
</div>

<%-- 급여 편집 모달 --%>
<div class="adm-modal-overlay" id="salaryEditModal">
    <div class="adm-modal" style="width:480px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="salaryEditTitle">급여/역량 편집</div>
            <button class="adm-modal-close" onclick="closeModal('salaryEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-salary-edit-grid">
                <div class="sa-form-group">
                    <label class="sa-form-label">숙련도 (Seniority)</label>
                    <select class="adm-select sa-full-select" id="se_seniority">
                        <option value="">-- 선택 --</option>
                        <option>어소시에이트</option><option>주니어</option><option>미드레벨</option>
                        <option>시니어</option><option>리드</option><option>프린시펄</option>
                        <option>스태프</option><option>펠로우</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">직무티어 (Tier)</label>
                    <select class="adm-select sa-full-select" id="se_tier">
                        <option value="">-- 선택 --</option>
                        <option>T1</option><option>T2</option><option>T3</option><option>T4</option><option>T5</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">직무단계 (Level)</label>
                    <select class="adm-select sa-full-select" id="se_level">
                        <option value="">-- 선택 --</option>
                        <option>L1</option><option>L2</option><option>L3</option><option>L4</option>
                        <option>L5</option><option>L6</option><option>L7</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">급여구간 (Band)</label>
                    <select class="adm-select sa-full-select" id="se_band">
                        <option value="">-- 선택 --</option>
                        <option>B1</option><option>B2</option><option>B3</option><option>B4</option><option>B5</option>
                        <option>B6</option><option>B7</option><option>B8</option><option>B9</option><option>B10</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">급여등급 (Grade)</label>
                    <select class="adm-select sa-full-select" id="se_grade">
                        <option value="">-- 선택 --</option>
                        <option>G1</option><option>G2</option><option>G3</option><option>G4</option><option>G5</option>
                        <option>G6</option><option>G7</option><option>G8</option><option>G9</option><option>G10</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">호봉 (Step)</label>
                    <select class="adm-select sa-full-select" id="se_step">
                        <option value="">-- 선택 --</option>
                        <option>1호봉</option><option>2호봉</option><option>3호봉</option><option>4호봉</option><option>5호봉</option>
                        <option>6호봉</option><option>7호봉</option><option>8호봉</option><option>9호봉</option><option>10호봉</option>
                        <option>11호봉</option><option>12호봉</option><option>13호봉</option><option>14호봉</option><option>15호봉</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('salaryEditModal')">취소</button>
            <button class="adm-btn adm-btn-primary"  onclick="saveSalary()">저장</button>
        </div>
    </div>
</div>

<%-- 급여/역량 업로드 미리보기 모달 --%>
<div class="adm-modal-overlay" id="salaryUploadPreviewModal">
    <div class="adm-modal" style="width:1100px;max-width:98vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">급여/역량 엑셀 업로드 미리보기</div>
            <button class="adm-modal-close" onclick="closeModal('salaryUploadPreviewModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div id="salaryPreviewSummary" style="display:flex;gap:16px;margin-bottom:12px;font-size:13px;"></div>
            <div id="salaryPreviewWarn" style="display:none;margin-bottom:10px;padding:8px 12px;background:#fef3c7;color:#92400e;border-radius:6px;font-size:13px;"></div>
            <div style="max-height:60vh;overflow:auto;border:1px solid #e5e7eb;border-radius:6px;">
                <table class="sa-salary-table" id="salaryPreviewTable" style="font-size:12px;">
                    <thead>
                        <tr>
                            <th style="width:50px;">행</th>
                            <th style="width:90px;">상태</th>
                            <th style="width:120px;">닉네임</th>
                            <th style="width:200px;">이메일</th>
                            <th>변경 내용</th>
                        </tr>
                    </thead>
                    <tbody id="salaryPreviewTbody"></tbody>
                </table>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('salaryUploadPreviewModal')">취소</button>
            <button class="adm-btn adm-btn-primary" id="salaryApplyBtn" onclick="applySalaryUpload()">적용</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentSalaryIdx = null;
let salaryPreviewRows = [];

function openSalaryEdit(row) {
    currentSalaryIdx = row.getAttribute('data-idx');
    document.getElementById('salaryEditTitle').textContent = (row.getAttribute('data-nickname') || '') + ' 급여/역량 편집';
    setSelect('se_seniority', row.getAttribute('data-seniority'));
    setSelect('se_tier',      row.getAttribute('data-tier'));
    setSelect('se_level',     row.getAttribute('data-level'));
    setSelect('se_band',      row.getAttribute('data-band'));
    setSelect('se_grade',     row.getAttribute('data-grade'));
    setSelect('se_step',      row.getAttribute('data-step'));
    document.getElementById('salaryEditModal').classList.add('open');
}

function setSelect(id, val) {
    const el = document.getElementById(id);
    el.value = val || '';
}

function saveSalary() {
    const params = new URLSearchParams({
        adminSeniority: document.getElementById('se_seniority').value,
        adminTier:      document.getElementById('se_tier').value,
        adminLevel:     document.getElementById('se_level').value,
        adminBand:      document.getElementById('se_band').value,
        adminGrade:     document.getElementById('se_grade').value,
        adminStep:      document.getElementById('se_step').value
    });
    fetch(CTX + '/superAdmin/members/' + currentSalaryIdx + '/salary', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('저장되었습니다.'); closeModal('salaryEditModal'); location.reload(); }
        else adm_toast(data.message || '저장 실패', 'error');
    });
}

function closeModal(id) { document.getElementById(id).classList.remove('open'); }

function triggerSalaryUpload() {
    document.getElementById('salaryUploadInput').value = '';
    document.getElementById('salaryUploadInput').click();
}

function handleSalaryFile(e) {
    const file = e.target.files && e.target.files[0];
    if (!file) return;
    const fd = new FormData();
    fd.append('file', file);
    adm_toast('파일 검증 중…');
    fetch(CTX + '/superAdmin/salary/upload/preview', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' },
        body: fd
    })
    .then(r => r.json())
    .then(data => {
        if (!data.success) { adm_toast(data.message || '미리보기 실패', 'error'); return; }
        renderSalaryPreview(data.preview);
        document.getElementById('salaryUploadPreviewModal').classList.add('open');
    })
    .catch(() => adm_toast('네트워크 오류', 'error'));
}

function renderSalaryPreview(preview) {
    salaryPreviewRows = preview.rows || [];
    const changeCnt    = preview.changeCount    || 0;
    const unchangedCnt = preview.unchangedCount || 0;
    const errorCnt     = preview.errorCount     || 0;
    const totalCnt     = preview.totalCount     || salaryPreviewRows.length;

    document.getElementById('salaryPreviewSummary').innerHTML =
        '<span>총 <b>' + totalCnt + '</b>행</span>' +
        '<span style="color:#2563eb;">변경 <b>' + changeCnt + '</b></span>' +
        '<span style="color:#64748b;">미변경 <b>' + unchangedCnt + '</b></span>' +
        '<span style="color:#dc2626;">오류 <b>' + errorCnt + '</b></span>';

    const warnEl = document.getElementById('salaryPreviewWarn');
    if (errorCnt > 0) {
        warnEl.style.display = 'block';
        warnEl.textContent = '오류 행은 적용 대상에서 제외되며, 변경 행만 반영됨.';
    } else {
        warnEl.style.display = 'none';
    }

    const tbody = document.getElementById('salaryPreviewTbody');
    tbody.innerHTML = '';
    salaryPreviewRows.forEach(r => {
        const tr = document.createElement('tr');

        let badge;
        if (r.status === 'CHANGE') {
            badge = '<span style="display:inline-block;padding:2px 8px;border-radius:10px;background:#dbeafe;color:#1d4ed8;font-size:11px;">CHANGE</span>';
        } else if (r.status === 'ERROR') {
            badge = '<span style="display:inline-block;padding:2px 8px;border-radius:10px;background:#fee2e2;color:#b91c1c;font-size:11px;">ERROR</span>';
        } else {
            badge = '<span style="display:inline-block;padding:2px 8px;border-radius:10px;background:#f1f5f9;color:#64748b;font-size:11px;">UNCHANGED</span>';
        }

        let diffHtml;
        if (r.status === 'ERROR') {
            diffHtml = '<span style="color:#b91c1c;">' + escapeHtml(r.errorMessage || '오류') + '</span>';
        } else if (r.status === 'CHANGE' && r.newValues) {
            const parts = [];
            Object.keys(r.newValues).forEach(k => {
                const oldV = (r.oldValues && r.oldValues[k]) || '∅';
                const newV = r.newValues[k] || '∅';
                parts.push('<div><b>' + escapeHtml(k) + '</b>: <span style="color:#64748b;text-decoration:line-through;">' + escapeHtml(oldV) + '</span> → <span style="color:#1d4ed8;">' + escapeHtml(newV) + '</span></div>');
            });
            diffHtml = parts.join('');
        } else {
            diffHtml = '<span style="color:#94a3b8;">변경 없음</span>';
        }

        tr.innerHTML =
            '<td>' + (r.rowNumber || '') + '</td>' +
            '<td>' + badge + '</td>' +
            '<td>' + escapeHtml(r.nickname || '') + '</td>' +
            '<td>' + escapeHtml(r.email || '') + '</td>' +
            '<td style="white-space:normal;">' + diffHtml + '</td>';
        tbody.appendChild(tr);
    });

    const btn = document.getElementById('salaryApplyBtn');
    btn.textContent = changeCnt + '행 적용';
    btn.disabled = (changeCnt === 0);
}

function escapeHtml(s) {
    if (s == null) return '';
    return String(s).replace(/[&<>"']/g, c => ({
        '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'
    }[c]));
}

function applySalaryUpload() {
    const apply = salaryPreviewRows
        .filter(r => r.status === 'CHANGE')
        .map(r => ({
            userIdx:   r.userIdx,
            email:     r.email,
            seniority: (r.newValues && r.newValues['Seniority']) || null,
            tier:      (r.newValues && r.newValues['Tier'])      || null,
            level:     (r.newValues && r.newValues['Level'])     || null,
            band:      (r.newValues && r.newValues['Band'])      || null,
            grade:     (r.newValues && r.newValues['Grade'])     || null,
            step:      (r.newValues && r.newValues['Step'])      || null
        }));

    if (apply.length === 0) { adm_toast('변경할 행이 없음', 'error'); return; }
    if (!confirm(apply.length + '행을 적용하시겠습니까?')) return;

    const btn = document.getElementById('salaryApplyBtn');
    btn.disabled = true;

    fetch(CTX + '/superAdmin/salary/upload/apply', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
        body: JSON.stringify({ rows: apply })
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast(data.applied + '행 적용 완료');
            closeModal('salaryUploadPreviewModal');
            location.reload();
        } else {
            adm_toast(data.message || '적용 실패', 'error');
            btn.disabled = false;
        }
    })
    .catch(() => {
        adm_toast('네트워크 오류', 'error');
        btn.disabled = false;
    });
}
</script>

<%@ include file="layout-close.jsp" %>
