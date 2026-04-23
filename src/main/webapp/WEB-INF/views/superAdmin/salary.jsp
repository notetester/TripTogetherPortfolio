<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="salary"/>
<spring:message code="superAdmin.salary.pageTitle" var="pageTitle"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="superAdmin.salary.cardTitle"/></div>
            <div style="font-size:13px;color:#94a3b8;"><spring:message code="superAdmin.salary.cardDescription"/></div>
        </div>
        <div class="adm-card-body" style="padding:0;">

            <%-- 검색/필터 폼 (서버사이드) --%>
            <form method="get" action="${pageContext.request.contextPath}/superAdmin/salary" class="sa-salary-toolbar" id="salaryFilterForm">
                <input type="text" name="keyword"
                       value="${fn:escapeXml(search.keyword)}"
                       placeholder="<spring:message code='superAdmin.salary.filter.keywordPlaceholder'/>" class="adm-input" style="width:220px;">
                <input type="text" name="filterDepartment"
                       value="${fn:escapeXml(search.filterDepartment)}"
                       placeholder="<spring:message code='superAdmin.salary.filter.departmentPlaceholder'/>" class="adm-input" style="width:140px;">
                <input type="text" name="filterPermissionCode"
                       value="${fn:escapeXml(search.filterPermissionCode)}"
                       placeholder="<spring:message code='superAdmin.salary.filter.permissionPlaceholder'/>" class="adm-input" style="width:140px;">
                <select name="filterAccountStatus" class="adm-select" style="width:130px;">
                    <option value=""><spring:message code="superAdmin.salary.filter.accountStatusAll"/></option>
                    <option value="ACTIVE"   <c:if test="${search.filterAccountStatus == 'ACTIVE'}">selected</c:if>><spring:message code="admin.status.ACTIVE"/></option>
                    <option value="BLOCKED"  <c:if test="${search.filterAccountStatus == 'BLOCKED'}">selected</c:if>><spring:message code="admin.status.BLOCKED"/></option>
                    <option value="DORMANT"  <c:if test="${search.filterAccountStatus == 'DORMANT'}">selected</c:if>><spring:message code="admin.status.DORMANT"/></option>
                    <option value="DELETED"  <c:if test="${search.filterAccountStatus == 'DELETED'}">selected</c:if>><spring:message code="admin.status.DELETED"/></option>
                </select>
                <input type="hidden" name="pageSize" value="${search.pageSize}">
                <button type="submit" class="adm-btn adm-btn-primary"><spring:message code="superAdmin.salary.action.search"/></button>
                <a href="${pageContext.request.contextPath}/superAdmin/salary" class="adm-btn adm-btn-ghost"><spring:message code="superAdmin.salary.action.reset"/></a>
                <button type="button" class="adm-btn adm-btn-ghost" style="margin-left:auto;"
                        onclick="triggerSalaryUpload()"><spring:message code="superAdmin.salary.action.uploadExcel"/></button>
                <input type="file" id="salaryUploadInput" accept=".xlsx,.xls" style="display:none;"
                       onchange="handleSalaryFile(event)">
                <a href="${pageContext.request.contextPath}/superAdmin/salary/export?keyword=${fn:escapeXml(search.keyword)}&filterDepartment=${fn:escapeXml(search.filterDepartment)}&filterPermissionCode=${fn:escapeXml(search.filterPermissionCode)}&filterAccountStatus=${fn:escapeXml(search.filterAccountStatus)}"
                   class="adm-btn adm-btn-ghost">
                    <spring:message code="superAdmin.salary.action.exportExcel"/>
                </a>
                <span style="font-size:13px;color:#94a3b8;"><spring:message code="superAdmin.salary.table.count" arguments="${total}"/></span>
            </form>

            <div style="overflow-x:auto;">
                <table class="sa-salary-table" id="salaryTable">
                    <thead>
                        <tr>
                            <th><spring:message code="superAdmin.salary.table.nickname"/></th>
                            <th><spring:message code="superAdmin.salary.table.department"/></th>
                            <th><spring:message code="superAdmin.salary.table.team"/></th>
                            <th><spring:message code="superAdmin.salary.table.positionCode"/></th>
                            <th><spring:message code="superAdmin.salary.table.title"/></th>
                            <th><spring:message code="superAdmin.salary.table.rank"/></th>
                            <th><spring:message code="superAdmin.salary.table.seniority"/></th>
                            <th><spring:message code="superAdmin.salary.table.tier"/></th>
                            <th><spring:message code="superAdmin.salary.table.level"/></th>
                            <th><spring:message code="superAdmin.salary.table.band"/></th>
                            <th><spring:message code="superAdmin.salary.table.grade"/></th>
                            <th><spring:message code="superAdmin.salary.table.step"/></th>
                            <th><spring:message code="superAdmin.salary.table.effectivePermission"/></th>
                            <th><spring:message code="superAdmin.salary.table.manager"/></th>
                            <th><spring:message code="superAdmin.salary.table.actions"/></th>
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
                                        onclick="openSalaryEdit(this.closest('tr'))"><spring:message code="superAdmin.salary.action.edit"/></button>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty salaryList}">
                <div style="text-align:center;padding:60px;color:#94a3b8;"><spring:message code="superAdmin.salary.empty"/></div>
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
            <div class="adm-modal-title" id="salaryEditTitle"><spring:message code="superAdmin.salary.modal.editTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('salaryEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-salary-edit-grid">
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.salary.section.seniority"/></label>
                    <select class="adm-select sa-full-select" id="se_seniority">
                        <option value=""><spring:message code="superAdmin.salary.option.select"/></option>
                        <option value="어소시에이트"><spring:message code="superAdmin.salary.seniority.associate"/></option>
                        <option value="주니어"><spring:message code="superAdmin.salary.seniority.junior"/></option>
                        <option value="미드레벨"><spring:message code="superAdmin.salary.seniority.mid"/></option>
                        <option value="시니어"><spring:message code="superAdmin.salary.seniority.senior"/></option>
                        <option value="리드"><spring:message code="superAdmin.salary.seniority.lead"/></option>
                        <option value="프린시펄"><spring:message code="superAdmin.salary.seniority.principal"/></option>
                        <option value="스태프"><spring:message code="superAdmin.salary.seniority.staff"/></option>
                        <option value="펠로우"><spring:message code="superAdmin.salary.seniority.fellow"/></option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.salary.section.tier"/></label>
                    <select class="adm-select sa-full-select" id="se_tier">
                        <option value=""><spring:message code="superAdmin.salary.option.select"/></option>
                        <option>T1</option><option>T2</option><option>T3</option><option>T4</option><option>T5</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.salary.section.level"/></label>
                    <select class="adm-select sa-full-select" id="se_level">
                        <option value=""><spring:message code="superAdmin.salary.option.select"/></option>
                        <option>L1</option><option>L2</option><option>L3</option><option>L4</option>
                        <option>L5</option><option>L6</option><option>L7</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.salary.section.band"/></label>
                    <select class="adm-select sa-full-select" id="se_band">
                        <option value=""><spring:message code="superAdmin.salary.option.select"/></option>
                        <option>B1</option><option>B2</option><option>B3</option><option>B4</option><option>B5</option>
                        <option>B6</option><option>B7</option><option>B8</option><option>B9</option><option>B10</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.salary.section.grade"/></label>
                    <select class="adm-select sa-full-select" id="se_grade">
                        <option value=""><spring:message code="superAdmin.salary.option.select"/></option>
                        <option>G1</option><option>G2</option><option>G3</option><option>G4</option><option>G5</option>
                        <option>G6</option><option>G7</option><option>G8</option><option>G9</option><option>G10</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.salary.section.step"/></label>
                    <select class="adm-select sa-full-select" id="se_step">
                        <option value=""><spring:message code="superAdmin.salary.option.select"/></option>
                        <option value="1호봉"><spring:message code="superAdmin.salary.step.1"/></option>
                        <option value="2호봉"><spring:message code="superAdmin.salary.step.2"/></option>
                        <option value="3호봉"><spring:message code="superAdmin.salary.step.3"/></option>
                        <option value="4호봉"><spring:message code="superAdmin.salary.step.4"/></option>
                        <option value="5호봉"><spring:message code="superAdmin.salary.step.5"/></option>
                        <option value="6호봉"><spring:message code="superAdmin.salary.step.6"/></option>
                        <option value="7호봉"><spring:message code="superAdmin.salary.step.7"/></option>
                        <option value="8호봉"><spring:message code="superAdmin.salary.step.8"/></option>
                        <option value="9호봉"><spring:message code="superAdmin.salary.step.9"/></option>
                        <option value="10호봉"><spring:message code="superAdmin.salary.step.10"/></option>
                        <option value="11호봉"><spring:message code="superAdmin.salary.step.11"/></option>
                        <option value="12호봉"><spring:message code="superAdmin.salary.step.12"/></option>
                        <option value="13호봉"><spring:message code="superAdmin.salary.step.13"/></option>
                        <option value="14호봉"><spring:message code="superAdmin.salary.step.14"/></option>
                        <option value="15호봉"><spring:message code="superAdmin.salary.step.15"/></option>
                    </select>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('salaryEditModal')"><spring:message code="admin.common.cancel"/></button>
            <button class="adm-btn adm-btn-primary"  onclick="saveSalary()"><spring:message code="admin.common.save"/></button>
        </div>
    </div>
</div>

<%-- 급여/역량 업로드 미리보기 모달 --%>
<div class="adm-modal-overlay" id="salaryUploadPreviewModal">
    <div class="adm-modal" style="width:1100px;max-width:98vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title"><spring:message code="superAdmin.salary.modal.previewTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('salaryUploadPreviewModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div id="salaryPreviewSummary" style="display:flex;gap:16px;margin-bottom:12px;font-size:13px;"></div>
            <div id="salaryPreviewWarn" style="display:none;margin-bottom:10px;padding:8px 12px;background:#fef3c7;color:#92400e;border-radius:6px;font-size:13px;"></div>
            <div style="max-height:60vh;overflow:auto;border:1px solid #e5e7eb;border-radius:6px;">
                <table class="sa-salary-table" id="salaryPreviewTable" style="font-size:12px;">
                    <thead>
                        <tr>
                            <th style="width:50px;"><spring:message code="superAdmin.salary.preview.row"/></th>
                            <th style="width:90px;"><spring:message code="superAdmin.salary.table.state"/></th>
                            <th style="width:120px;"><spring:message code="superAdmin.salary.table.nickname"/></th>
                            <th style="width:200px;"><spring:message code="superAdmin.salary.table.email"/></th>
                            <th><spring:message code="superAdmin.salary.table.changedContent"/></th>
                        </tr>
                    </thead>
                    <tbody id="salaryPreviewTbody"></tbody>
                </table>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('salaryUploadPreviewModal')"><spring:message code="admin.common.cancel"/></button>
            <button class="adm-btn adm-btn-primary" id="salaryApplyBtn" onclick="applySalaryUpload()"><spring:message code="superAdmin.salary.action.apply"/></button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentSalaryIdx = null;
let salaryPreviewRows = [];
const SALARY_MESSAGES = {
    editTitleSuffix: '<spring:message code="superAdmin.salary.editTitleSuffix" javaScriptEscape="true"/>',
    saved: '<spring:message code="superAdmin.salary.toastSaved" javaScriptEscape="true"/>',
    saveFailed: '<spring:message code="superAdmin.salary.toastSaveFailed" javaScriptEscape="true"/>',
    validating: '<spring:message code="superAdmin.salary.preview.toastValidating" javaScriptEscape="true"/>',
    previewFailed: '<spring:message code="superAdmin.salary.preview.previewFailed" javaScriptEscape="true"/>',
    networkError: '<spring:message code="superAdmin.salary.preview.networkError" javaScriptEscape="true"/>',
    total: '<spring:message code="superAdmin.salary.preview.summary.total" javaScriptEscape="true"/>',
    changed: '<spring:message code="superAdmin.salary.preview.summary.changed" javaScriptEscape="true"/>',
    unchanged: '<spring:message code="superAdmin.salary.preview.summary.unchanged" javaScriptEscape="true"/>',
    error: '<spring:message code="superAdmin.salary.preview.summary.error" javaScriptEscape="true"/>',
    errorExcluded: '<spring:message code="superAdmin.salary.preview.errorExcluded" javaScriptEscape="true"/>',
    statusChange: '<spring:message code="superAdmin.salary.preview.change" javaScriptEscape="true"/>',
    statusError: '<spring:message code="superAdmin.salary.preview.error" javaScriptEscape="true"/>',
    statusUnchanged: '<spring:message code="superAdmin.salary.preview.unchanged" javaScriptEscape="true"/>',
    genericError: '<spring:message code="superAdmin.salary.preview.error" javaScriptEscape="true"/>',
    noChanges: '<spring:message code="superAdmin.salary.preview.noChanges" javaScriptEscape="true"/>',
    willApply: '<spring:message code="superAdmin.salary.preview.willApply" javaScriptEscape="true"/>',
    noRowsToApply: '<spring:message code="superAdmin.salary.preview.noRowsToApply" javaScriptEscape="true"/>',
    applyConfirm: '<spring:message code="superAdmin.salary.preview.applyConfirm" javaScriptEscape="true"/>',
    appliedCompleted: '<spring:message code="superAdmin.salary.preview.applyCompleted" javaScriptEscape="true"/>',
    applyFailed: '<spring:message code="superAdmin.salary.preview.applyFailed" javaScriptEscape="true"/>',
    fieldLabels: {
        Seniority: '<spring:message code="superAdmin.salary.section.seniority" javaScriptEscape="true"/>',
        Tier: '<spring:message code="superAdmin.salary.section.tier" javaScriptEscape="true"/>',
        Level: '<spring:message code="superAdmin.salary.section.level" javaScriptEscape="true"/>',
        Band: '<spring:message code="superAdmin.salary.section.band" javaScriptEscape="true"/>',
        Grade: '<spring:message code="superAdmin.salary.section.grade" javaScriptEscape="true"/>',
        Step: '<spring:message code="superAdmin.salary.section.step" javaScriptEscape="true"/>'
    }
};

function openSalaryEdit(row) {
    currentSalaryIdx = row.getAttribute('data-idx');
    document.getElementById('salaryEditTitle').textContent = (row.getAttribute('data-nickname') || '') + SALARY_MESSAGES.editTitleSuffix;
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
        if (data.success) { adm_toast(SALARY_MESSAGES.saved); closeModal('salaryEditModal'); location.reload(); }
        else adm_toast(data.message || SALARY_MESSAGES.saveFailed, 'error');
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
    adm_toast(SALARY_MESSAGES.validating);
    fetch(CTX + '/superAdmin/salary/upload/preview', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' },
        body: fd
    })
    .then(r => r.json())
    .then(data => {
        if (!data.success) { adm_toast(data.message || SALARY_MESSAGES.previewFailed, 'error'); return; }
        renderSalaryPreview(data.preview);
        document.getElementById('salaryUploadPreviewModal').classList.add('open');
    })
    .catch(() => adm_toast(SALARY_MESSAGES.networkError, 'error'));
}

function renderSalaryPreview(preview) {
    salaryPreviewRows = preview.rows || [];
    const changeCnt    = preview.changeCount    || 0;
    const unchangedCnt = preview.unchangedCount || 0;
    const errorCnt     = preview.errorCount     || 0;
    const totalCnt     = preview.totalCount     || salaryPreviewRows.length;

    document.getElementById('salaryPreviewSummary').innerHTML =
        '<span>' + SALARY_MESSAGES.total + ' <b>' + totalCnt + '</b>' + '<spring:message code="superAdmin.salary.preview.row" javaScriptEscape="true"/>' + '</span>' +
        '<span style="color:#2563eb;">' + SALARY_MESSAGES.changed + ' <b>' + changeCnt + '</b></span>' +
        '<span style="color:#64748b;">' + SALARY_MESSAGES.unchanged + ' <b>' + unchangedCnt + '</b></span>' +
        '<span style="color:#dc2626;">' + SALARY_MESSAGES.error + ' <b>' + errorCnt + '</b></span>';

    const warnEl = document.getElementById('salaryPreviewWarn');
    if (errorCnt > 0) {
        warnEl.style.display = 'block';
        warnEl.textContent = SALARY_MESSAGES.errorExcluded;
    } else {
        warnEl.style.display = 'none';
    }

    const tbody = document.getElementById('salaryPreviewTbody');
    tbody.innerHTML = '';
    salaryPreviewRows.forEach(r => {
        const tr = document.createElement('tr');

        let badge;
        if (r.status === 'CHANGE') {
            badge = '<span style="display:inline-block;padding:2px 8px;border-radius:10px;background:#dbeafe;color:#1d4ed8;font-size:11px;">' + SALARY_MESSAGES.statusChange + '</span>';
        } else if (r.status === 'ERROR') {
            badge = '<span style="display:inline-block;padding:2px 8px;border-radius:10px;background:#fee2e2;color:#b91c1c;font-size:11px;">' + SALARY_MESSAGES.statusError + '</span>';
        } else {
            badge = '<span style="display:inline-block;padding:2px 8px;border-radius:10px;background:#f1f5f9;color:#64748b;font-size:11px;">' + SALARY_MESSAGES.statusUnchanged + '</span>';
        }

        let diffHtml;
        if (r.status === 'ERROR') {
            diffHtml = '<span style="color:#b91c1c;">' + escapeHtml(r.errorMessage || SALARY_MESSAGES.genericError) + '</span>';
        } else if (r.status === 'CHANGE' && r.newValues) {
            const parts = [];
            Object.keys(r.newValues).forEach(k => {
                const oldV = (r.oldValues && r.oldValues[k]) || '∅';
                const newV = r.newValues[k] || '∅';
                const label = SALARY_MESSAGES.fieldLabels[k] || k;
                parts.push('<div><b>' + escapeHtml(label) + '</b>: <span style="color:#64748b;text-decoration:line-through;">' + escapeHtml(oldV) + '</span> → <span style="color:#1d4ed8;">' + escapeHtml(newV) + '</span></div>');
            });
            diffHtml = parts.join('');
        } else {
            diffHtml = '<span style="color:#94a3b8;">' + SALARY_MESSAGES.noChanges + '</span>';
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
    btn.textContent = SALARY_MESSAGES.willApply.replace('{0}', changeCnt);
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

    if (apply.length === 0) { adm_toast(SALARY_MESSAGES.noRowsToApply, 'error'); return; }
    if (!confirm(SALARY_MESSAGES.applyConfirm.replace('{0}', apply.length))) return;

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
            adm_toast(SALARY_MESSAGES.appliedCompleted.replace('{0}', data.applied));
            closeModal('salaryUploadPreviewModal');
            location.reload();
        } else {
            adm_toast(data.message || SALARY_MESSAGES.applyFailed, 'error');
            btn.disabled = false;
        }
    })
    .catch(() => {
        adm_toast(SALARY_MESSAGES.networkError, 'error');
        btn.disabled = false;
    });
}
</script>

<%@ include file="layout-close.jsp" %>
