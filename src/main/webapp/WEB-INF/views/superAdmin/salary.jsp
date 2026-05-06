<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_c42a5e83ae" code="superAdmin.salary.cardTitle"/>
<spring:message var="autoMsg_824f29ff27" code="superAdmin.salary.cardDescription"/>
<spring:message var="autoMsg_1e2f82da6b" code="superAdmin.salary.filter.keywordPlaceholder"/>
<spring:message var="autoMsg_2cadae8687" code="superAdmin.salary.filter.departmentPlaceholder"/>
<spring:message var="autoMsg_ef442f769a" code="superAdmin.salary.filter.permissionPlaceholder"/>
<spring:message var="autoMsg_26c63a4826" code="superAdmin.salary.filter.accountStatusAll"/>
<spring:message var="autoMsg_9cfa19741d" code="admin.status.ACTIVE"/>
<spring:message var="autoMsg_0d35892572" code="admin.status.BLOCKED"/>
<spring:message var="autoMsg_36ef8f126c" code="admin.status.DORMANT"/>
<spring:message var="autoMsg_ad99f84c88" code="admin.status.DELETED"/>
<spring:message var="autoMsg_9ad2529f9c" code="superAdmin.salary.action.search"/>
<spring:message var="autoMsg_c3c2a5b8ae" code="superAdmin.salary.action.reset"/>
<spring:message var="autoMsg_0a0af26aeb" code="superAdmin.salary.action.uploadExcel"/>
<spring:message var="autoMsg_cbedaf44f2" code="superAdmin.salary.table.count"/>
<spring:message var="autoMsg_4948a772d9" code="superAdmin.salary.table.nickname"/>
<spring:message var="autoMsg_a31adc6294" code="superAdmin.salary.table.department"/>
<spring:message var="autoMsg_3bc6d27609" code="superAdmin.salary.table.team"/>
<spring:message var="autoMsg_da5201320c" code="superAdmin.salary.table.positionCode"/>
<spring:message var="autoMsg_d863e3f81a" code="superAdmin.salary.table.title"/>
<spring:message var="autoMsg_2f204788d2" code="superAdmin.salary.table.rank"/>
<spring:message var="autoMsg_1a6c01855f" code="superAdmin.salary.table.seniority"/>
<spring:message var="autoMsg_022ea809f7" code="superAdmin.salary.table.tier"/>
<spring:message var="autoMsg_473b670549" code="superAdmin.salary.table.level"/>
<spring:message var="autoMsg_cc3cddb498" code="superAdmin.salary.table.band"/>
<spring:message var="autoMsg_51a56bd0af" code="superAdmin.salary.table.grade"/>
<spring:message var="autoMsg_6ca2e74e95" code="superAdmin.salary.table.step"/>
<spring:message var="autoMsg_19b3443b13" code="superAdmin.salary.table.effectivePermission"/>
<spring:message var="autoMsg_63143af798" code="superAdmin.salary.table.manager"/>
<spring:message var="autoMsg_e946eb1016" code="superAdmin.salary.table.actions"/>
<spring:message var="autoMsg_1341417b27" code="superAdmin.salary.action.edit"/>
<spring:message var="autoMsg_21117d53e9" code="superAdmin.salary.empty"/>
<spring:message var="autoMsg_ffb41aa8fe" code="superAdmin.salary.modal.editTitle"/>
<spring:message var="autoMsg_01a1a455c3" code="superAdmin.salary.section.seniority"/>
<spring:message var="autoMsg_c6b16a8fb5" code="superAdmin.salary.option.select"/>
<spring:message var="autoMsg_b461adc12e" code="superAdmin.salary.seniority.associate"/>
<spring:message var="autoMsg_247125ea87" code="superAdmin.salary.seniority.junior"/>
<spring:message var="autoMsg_80c17ab457" code="superAdmin.salary.seniority.mid"/>
<spring:message var="autoMsg_61e0ef2a7f" code="superAdmin.salary.seniority.senior"/>
<spring:message var="autoMsg_68015cb58d" code="superAdmin.salary.seniority.lead"/>
<spring:message var="autoMsg_ce4a74ec7e" code="superAdmin.salary.seniority.principal"/>
<spring:message var="autoMsg_05ebb13caf" code="superAdmin.salary.seniority.staff"/>
<spring:message var="autoMsg_7a3f34462f" code="superAdmin.salary.seniority.fellow"/>
<spring:message var="autoMsg_570ff8d2b1" code="superAdmin.salary.section.tier"/>
<spring:message var="autoMsg_f5fc46452e" code="superAdmin.salary.section.level"/>
<spring:message var="autoMsg_4ec61f3338" code="superAdmin.salary.section.band"/>
<spring:message var="autoMsg_478b29a27d" code="superAdmin.salary.section.grade"/>
<spring:message var="autoMsg_30e575cbaa" code="superAdmin.salary.section.step"/>
<spring:message var="autoMsg_1657921108" code="superAdmin.salary.step.1"/>
<spring:message var="autoMsg_84da388511" code="superAdmin.salary.step.2"/>
<spring:message var="autoMsg_81840b237b" code="superAdmin.salary.step.3"/>
<spring:message var="autoMsg_1d0c59f4cd" code="superAdmin.salary.step.4"/>
<spring:message var="autoMsg_972234ce7a" code="superAdmin.salary.step.5"/>
<spring:message var="autoMsg_52d288c7d9" code="superAdmin.salary.step.6"/>
<spring:message var="autoMsg_8cb2c06353" code="superAdmin.salary.step.7"/>
<spring:message var="autoMsg_8b9ba45382" code="superAdmin.salary.step.8"/>
<spring:message var="autoMsg_372898fe85" code="superAdmin.salary.step.9"/>
<spring:message var="autoMsg_18b0dc0a76" code="superAdmin.salary.step.10"/>
<spring:message var="autoMsg_973fba1b43" code="superAdmin.salary.step.11"/>
<spring:message var="autoMsg_b74c6634e1" code="superAdmin.salary.step.12"/>
<spring:message var="autoMsg_a2ae034f1d" code="superAdmin.salary.step.13"/>
<spring:message var="autoMsg_0df4351eaa" code="superAdmin.salary.step.14"/>
<spring:message var="autoMsg_db591ded80" code="superAdmin.salary.step.15"/>
<spring:message var="autoMsg_8e9c51d784" code="admin.common.cancel"/>
<spring:message var="autoMsg_df410ddc82" code="admin.common.save"/>
<spring:message var="autoMsg_6298dad309" code="superAdmin.salary.modal.previewTitle"/>
<spring:message var="autoMsg_d2e66c6c07" code="superAdmin.salary.preview.row"/>
<spring:message var="autoMsg_c4c5b3b297" code="superAdmin.salary.table.state"/>
<spring:message var="autoMsg_6981705ef7" code="superAdmin.salary.table.email"/>
<spring:message var="autoMsg_dd665cf361" code="superAdmin.salary.table.changedContent"/>
<spring:message var="autoMsg_2e5c819b3c" code="superAdmin.salary.action.apply"/>
<spring:message var="autoMsg_a15c77af05" code="superAdmin.salary.editTitleSuffix" javaScriptEscape="true"/>
<spring:message var="autoMsg_8128d782f8" code="superAdmin.salary.toastSaved" javaScriptEscape="true"/>
<spring:message var="autoMsg_9ecf8ff203" code="superAdmin.salary.toastSaveFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_277579cf67" code="superAdmin.salary.preview.toastValidating" javaScriptEscape="true"/>
<spring:message var="autoMsg_26f9a3c69c" code="superAdmin.salary.preview.previewFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_6ca10e2fa7" code="superAdmin.salary.preview.networkError" javaScriptEscape="true"/>
<spring:message var="autoMsg_755087fb1a" code="superAdmin.salary.preview.summary.total" javaScriptEscape="true"/>
<spring:message var="autoMsg_8e91fc0db1" code="superAdmin.salary.preview.summary.changed" javaScriptEscape="true"/>
<spring:message var="autoMsg_da7d1320fc" code="superAdmin.salary.preview.summary.unchanged" javaScriptEscape="true"/>
<spring:message var="autoMsg_cedf63ca99" code="superAdmin.salary.preview.summary.error" javaScriptEscape="true"/>
<spring:message var="autoMsg_baa7474a77" code="superAdmin.salary.preview.errorExcluded" javaScriptEscape="true"/>
<spring:message var="autoMsg_43d99b32ef" code="superAdmin.salary.preview.change" javaScriptEscape="true"/>
<spring:message var="autoMsg_74b9891d10" code="superAdmin.salary.preview.error" javaScriptEscape="true"/>
<spring:message var="autoMsg_7a4d4dcc13" code="superAdmin.salary.preview.unchanged" javaScriptEscape="true"/>
<spring:message var="autoMsg_79819e4adc" code="superAdmin.salary.preview.noChanges" javaScriptEscape="true"/>
<spring:message var="autoMsg_0cecd9b7d2" code="superAdmin.salary.preview.willApply" javaScriptEscape="true"/>
<spring:message var="autoMsg_52ec820513" code="superAdmin.salary.preview.noRowsToApply" javaScriptEscape="true"/>
<spring:message var="autoMsg_47808fa097" code="superAdmin.salary.preview.applyConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_09984a8396" code="superAdmin.salary.preview.applyCompleted" javaScriptEscape="true"/>
<spring:message var="autoMsg_b38f175947" code="superAdmin.salary.preview.applyFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_a973886010" code="superAdmin.salary.section.seniority" javaScriptEscape="true"/>
<spring:message var="autoMsg_20d3dc73a3" code="superAdmin.salary.section.tier" javaScriptEscape="true"/>
<spring:message var="autoMsg_4b860e09fb" code="superAdmin.salary.section.level" javaScriptEscape="true"/>
<spring:message var="autoMsg_f8617dee7a" code="superAdmin.salary.section.band" javaScriptEscape="true"/>
<spring:message var="autoMsg_8423abb3a0" code="superAdmin.salary.section.grade" javaScriptEscape="true"/>
<spring:message var="autoMsg_b2c4bcffde" code="superAdmin.salary.section.step" javaScriptEscape="true"/>
<spring:message var="autoMsg_6851ee13ae" code="superAdmin.salary.preview.row" javaScriptEscape="true"/>
<c:set var="activeMenu" value="salary"/>
<spring:message code="superAdmin.salary.pageTitle" var="pageTitle"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${autoMsg_c42a5e83ae}</div>
            <div style="font-size:13px;color:#94a3b8;">${autoMsg_824f29ff27}</div>
        </div>
        <div class="adm-card-body" style="padding:0;">

            <%-- 검색/필터 폼 (서버사이드) --%>
            <form method="get" action="${pageContext.request.contextPath}/superAdmin/salary" class="sa-salary-toolbar" id="salaryFilterForm">
                <input type="text" name="keyword"
                       value="${fn:escapeXml(search.keyword)}"
                       placeholder="${autoMsg_1e2f82da6b}" class="adm-input" style="width:220px;">
                <input type="text" name="filterDepartment"
                       value="${fn:escapeXml(search.filterDepartment)}"
                       placeholder="${autoMsg_2cadae8687}" class="adm-input" style="width:140px;">
                <input type="text" name="filterPermissionCode"
                       value="${fn:escapeXml(search.filterPermissionCode)}"
                       placeholder="${autoMsg_ef442f769a}" class="adm-input" style="width:140px;">
                <select name="filterAccountStatus" class="adm-select" style="width:130px;">
                    <option value="">${autoMsg_26c63a4826}</option>
                    <option value="ACTIVE"   <c:if test="${search.filterAccountStatus == 'ACTIVE'}">selected</c:if>>${autoMsg_9cfa19741d}</option>
                    <option value="BLOCKED"  <c:if test="${search.filterAccountStatus == 'BLOCKED'}">selected</c:if>>${autoMsg_0d35892572}</option>
                    <option value="DORMANT"  <c:if test="${search.filterAccountStatus == 'DORMANT'}">selected</c:if>>${autoMsg_36ef8f126c}</option>
                    <option value="DELETED"  <c:if test="${search.filterAccountStatus == 'DELETED'}">selected</c:if>>${autoMsg_ad99f84c88}</option>
                </select>
                <input type="hidden" name="pageSize" value="${search.pageSize}">
                <button type="submit" class="adm-btn adm-btn-primary">${autoMsg_9ad2529f9c}</button>
                <a href="${pageContext.request.contextPath}/superAdmin/salary" class="adm-btn adm-btn-ghost">${autoMsg_c3c2a5b8ae}</a>
                <button type="button" class="adm-btn adm-btn-ghost" style="margin-left:auto;"
                        onclick="triggerSalaryUpload()">${autoMsg_0a0af26aeb}</button>
                <input type="file" id="salaryUploadInput" accept=".xlsx,.xls" style="display:none;"
                       onchange="handleSalaryFile(event)">
                <a href="${pageContext.request.contextPath}/superAdmin/salary/export?keyword=${fn:escapeXml(search.keyword)}&filterDepartment=${fn:escapeXml(search.filterDepartment)}&filterPermissionCode=${fn:escapeXml(search.filterPermissionCode)}&filterAccountStatus=${fn:escapeXml(search.filterAccountStatus)}"
                   class="adm-btn adm-btn-ghost">
                    <spring:message code="superAdmin.salary.action.exportExcel"/>
                </a>
                <span style="font-size:13px;color:#94a3b8;">${autoMsg_cbedaf44f2}</span>
            </form>

            <div style="overflow-x:auto;">
                <table class="sa-salary-table" id="salaryTable">
                    <thead>
                        <tr>
                            <th>${autoMsg_4948a772d9}</th>
                            <th>${autoMsg_a31adc6294}</th>
                            <th>${autoMsg_3bc6d27609}</th>
                            <th>${autoMsg_da5201320c}</th>
                            <th>${autoMsg_d863e3f81a}</th>
                            <th>${autoMsg_2f204788d2}</th>
                            <th>${autoMsg_1a6c01855f}</th>
                            <th>${autoMsg_022ea809f7}</th>
                            <th>${autoMsg_473b670549}</th>
                            <th>${autoMsg_cc3cddb498}</th>
                            <th>${autoMsg_51a56bd0af}</th>
                            <th>${autoMsg_6ca2e74e95}</th>
                            <th>${autoMsg_19b3443b13}</th>
                            <th>${autoMsg_63143af798}</th>
                            <th>${autoMsg_e946eb1016}</th>
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
                                        onclick="openSalaryEdit(this.closest('tr'))">${autoMsg_1341417b27}</button>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty salaryList}">
                <div style="text-align:center;padding:60px;color:#94a3b8;">${autoMsg_21117d53e9}</div>
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
            <div class="adm-modal-title" id="salaryEditTitle">${autoMsg_ffb41aa8fe}</div>
            <button class="adm-modal-close" onclick="closeModal('salaryEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-salary-edit-grid">
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_01a1a455c3}</label>
                    <select class="adm-select sa-full-select" id="se_seniority">
                        <option value="">${autoMsg_c6b16a8fb5}</option>
                        <option value="어소시에이트">${autoMsg_b461adc12e}</option>
                        <option value="주니어">${autoMsg_247125ea87}</option>
                        <option value="미드레벨">${autoMsg_80c17ab457}</option>
                        <option value="시니어">${autoMsg_61e0ef2a7f}</option>
                        <option value="리드">${autoMsg_68015cb58d}</option>
                        <option value="프린시펄">${autoMsg_ce4a74ec7e}</option>
                        <option value="스태프">${autoMsg_05ebb13caf}</option>
                        <option value="펠로우">${autoMsg_7a3f34462f}</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_570ff8d2b1}</label>
                    <select class="adm-select sa-full-select" id="se_tier">
                        <option value="">${autoMsg_c6b16a8fb5}</option>
                        <option>T1</option><option>T2</option><option>T3</option><option>T4</option><option>T5</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_f5fc46452e}</label>
                    <select class="adm-select sa-full-select" id="se_level">
                        <option value="">${autoMsg_c6b16a8fb5}</option>
                        <option>L1</option><option>L2</option><option>L3</option><option>L4</option>
                        <option>L5</option><option>L6</option><option>L7</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_4ec61f3338}</label>
                    <select class="adm-select sa-full-select" id="se_band">
                        <option value="">${autoMsg_c6b16a8fb5}</option>
                        <option>B1</option><option>B2</option><option>B3</option><option>B4</option><option>B5</option>
                        <option>B6</option><option>B7</option><option>B8</option><option>B9</option><option>B10</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_478b29a27d}</label>
                    <select class="adm-select sa-full-select" id="se_grade">
                        <option value="">${autoMsg_c6b16a8fb5}</option>
                        <option>G1</option><option>G2</option><option>G3</option><option>G4</option><option>G5</option>
                        <option>G6</option><option>G7</option><option>G8</option><option>G9</option><option>G10</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_30e575cbaa}</label>
                    <select class="adm-select sa-full-select" id="se_step">
                        <option value="">${autoMsg_c6b16a8fb5}</option>
                        <option value="1호봉">${autoMsg_1657921108}</option>
                        <option value="2호봉">${autoMsg_84da388511}</option>
                        <option value="3호봉">${autoMsg_81840b237b}</option>
                        <option value="4호봉">${autoMsg_1d0c59f4cd}</option>
                        <option value="5호봉">${autoMsg_972234ce7a}</option>
                        <option value="6호봉">${autoMsg_52d288c7d9}</option>
                        <option value="7호봉">${autoMsg_8cb2c06353}</option>
                        <option value="8호봉">${autoMsg_8b9ba45382}</option>
                        <option value="9호봉">${autoMsg_372898fe85}</option>
                        <option value="10호봉">${autoMsg_18b0dc0a76}</option>
                        <option value="11호봉">${autoMsg_973fba1b43}</option>
                        <option value="12호봉">${autoMsg_b74c6634e1}</option>
                        <option value="13호봉">${autoMsg_a2ae034f1d}</option>
                        <option value="14호봉">${autoMsg_0df4351eaa}</option>
                        <option value="15호봉">${autoMsg_db591ded80}</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('salaryEditModal')">${autoMsg_8e9c51d784}</button>
            <button class="adm-btn adm-btn-primary"  onclick="saveSalary()">${autoMsg_df410ddc82}</button>
        </div>
    </div>
</div>

<%-- 급여/역량 업로드 미리보기 모달 --%>
<div class="adm-modal-overlay" id="salaryUploadPreviewModal">
    <div class="adm-modal" style="width:1100px;max-width:98vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">${autoMsg_6298dad309}</div>
            <button class="adm-modal-close" onclick="closeModal('salaryUploadPreviewModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div id="salaryPreviewSummary" style="display:flex;gap:16px;margin-bottom:12px;font-size:13px;"></div>
            <div id="salaryPreviewWarn" style="display:none;margin-bottom:10px;padding:8px 12px;background:#fef3c7;color:#92400e;border-radius:6px;font-size:13px;"></div>
            <div style="max-height:60vh;overflow:auto;border:1px solid #e5e7eb;border-radius:6px;">
                <table class="sa-salary-table" id="salaryPreviewTable" style="font-size:12px;">
                    <thead>
                        <tr>
                            <th style="width:50px;">${autoMsg_d2e66c6c07}</th>
                            <th style="width:90px;">${autoMsg_c4c5b3b297}</th>
                            <th style="width:120px;">${autoMsg_4948a772d9}</th>
                            <th style="width:200px;">${autoMsg_6981705ef7}</th>
                            <th>${autoMsg_dd665cf361}</th>
                        </tr>
                    </thead>
                    <tbody id="salaryPreviewTbody"></tbody>
                </table>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('salaryUploadPreviewModal')">${autoMsg_8e9c51d784}</button>
            <button class="adm-btn adm-btn-primary" id="salaryApplyBtn" onclick="applySalaryUpload()">${autoMsg_2e5c819b3c}</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentSalaryIdx = null;
let salaryPreviewRows = [];
const SALARY_MESSAGES = {
    editTitleSuffix: '${autoMsg_a15c77af05}',
    saved: '${autoMsg_8128d782f8}',
    saveFailed: '${autoMsg_9ecf8ff203}',
    validating: '${autoMsg_277579cf67}',
    previewFailed: '${autoMsg_26f9a3c69c}',
    networkError: '${autoMsg_6ca10e2fa7}',
    total: '${autoMsg_755087fb1a}',
    changed: '${autoMsg_8e91fc0db1}',
    unchanged: '${autoMsg_da7d1320fc}',
    error: '${autoMsg_cedf63ca99}',
    errorExcluded: '${autoMsg_baa7474a77}',
    statusChange: '${autoMsg_43d99b32ef}',
    statusError: '${autoMsg_74b9891d10}',
    statusUnchanged: '${autoMsg_7a4d4dcc13}',
    genericError: '${autoMsg_74b9891d10}',
    noChanges: '${autoMsg_79819e4adc}',
    willApply: '${autoMsg_0cecd9b7d2}',
    noRowsToApply: '${autoMsg_52ec820513}',
    applyConfirm: '${autoMsg_47808fa097}',
    appliedCompleted: '${autoMsg_09984a8396}',
    applyFailed: '${autoMsg_b38f175947}',
    fieldLabels: {
        Seniority: '${autoMsg_a973886010}',
        Tier: '${autoMsg_20d3dc73a3}',
        Level: '${autoMsg_4b860e09fb}',
        Band: '${autoMsg_f8617dee7a}',
        Grade: '${autoMsg_8423abb3a0}',
        Step: '${autoMsg_b2c4bcffde}'
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
        '<span>' + SALARY_MESSAGES.total + ' <b>' + totalCnt + '</b>' + '${autoMsg_6851ee13ae}' + '</span>' +
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
