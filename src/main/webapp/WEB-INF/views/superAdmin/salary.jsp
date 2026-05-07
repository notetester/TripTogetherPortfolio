<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_superAdmin_salary_filter_keywordPlaceholder" code="superAdmin.salary.filter.keywordPlaceholder"/>
<spring:message var="msg_superAdmin_salary_filter_departmentPlaceholder" code="superAdmin.salary.filter.departmentPlaceholder"/>
<spring:message var="msg_superAdmin_salary_filter_permissionPlaceholder" code="superAdmin.salary.filter.permissionPlaceholder"/>
<spring:message var="msg_superAdmin_salary_editTitleSuffix_js" code="superAdmin.salary.editTitleSuffix" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_toastSaved_js" code="superAdmin.salary.toastSaved" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_toastSaveFailed_js" code="superAdmin.salary.toastSaveFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_toastValidating_js" code="superAdmin.salary.preview.toastValidating" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_previewFailed_js" code="superAdmin.salary.preview.previewFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_networkError_js" code="superAdmin.salary.preview.networkError" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_summary_total_js" code="superAdmin.salary.preview.summary.total" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_summary_changed_js" code="superAdmin.salary.preview.summary.changed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_summary_unchanged_js" code="superAdmin.salary.preview.summary.unchanged" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_summary_error_js" code="superAdmin.salary.preview.summary.error" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_errorExcluded_js" code="superAdmin.salary.preview.errorExcluded" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_change_js" code="superAdmin.salary.preview.change" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_error_js" code="superAdmin.salary.preview.error" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_unchanged_js" code="superAdmin.salary.preview.unchanged" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_noChanges_js" code="superAdmin.salary.preview.noChanges" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_willApply_js" code="superAdmin.salary.preview.willApply" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_noRowsToApply_js" code="superAdmin.salary.preview.noRowsToApply" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_applyConfirm_js" code="superAdmin.salary.preview.applyConfirm" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_applyCompleted_js" code="superAdmin.salary.preview.applyCompleted" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_applyFailed_js" code="superAdmin.salary.preview.applyFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_section_seniority_js" code="superAdmin.salary.section.seniority" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_section_tier_js" code="superAdmin.salary.section.tier" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_section_level_js" code="superAdmin.salary.section.level" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_section_band_js" code="superAdmin.salary.section.band" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_section_grade_js" code="superAdmin.salary.section.grade" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_section_step_js" code="superAdmin.salary.section.step" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_preview_row_js" code="superAdmin.salary.preview.row" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_salary_pageTitle" code="superAdmin.salary.pageTitle"/>
<spring:message var="msg_superAdmin_salary_cardTitle" code="superAdmin.salary.cardTitle"/>
<spring:message var="msg_superAdmin_salary_cardDescription" code="superAdmin.salary.cardDescription"/>
<spring:message var="msg_superAdmin_salary_filter_accountStatusAll" code="superAdmin.salary.filter.accountStatusAll"/>
<spring:message var="msg_admin_status_ACTIVE" code="admin.status.ACTIVE"/>
<spring:message var="msg_admin_status_BLOCKED" code="admin.status.BLOCKED"/>
<spring:message var="msg_admin_status_DORMANT" code="admin.status.DORMANT"/>
<spring:message var="msg_admin_status_DELETED" code="admin.status.DELETED"/>
<spring:message var="msg_superAdmin_salary_action_search" code="superAdmin.salary.action.search"/>
<spring:message var="msg_superAdmin_salary_action_reset" code="superAdmin.salary.action.reset"/>
<spring:message var="msg_superAdmin_salary_action_uploadExcel" code="superAdmin.salary.action.uploadExcel"/>
<spring:message var="msg_superAdmin_salary_action_exportExcel" code="superAdmin.salary.action.exportExcel"/>
<spring:message var="msg_superAdmin_salary_table_count" code="superAdmin.salary.table.count"/>
<spring:message var="msg_superAdmin_salary_table_nickname" code="superAdmin.salary.table.nickname"/>
<spring:message var="msg_superAdmin_salary_table_department" code="superAdmin.salary.table.department"/>
<spring:message var="msg_superAdmin_salary_table_team" code="superAdmin.salary.table.team"/>
<spring:message var="msg_superAdmin_salary_table_positionCode" code="superAdmin.salary.table.positionCode"/>
<spring:message var="msg_superAdmin_salary_table_title" code="superAdmin.salary.table.title"/>
<spring:message var="msg_superAdmin_salary_table_rank" code="superAdmin.salary.table.rank"/>
<spring:message var="msg_superAdmin_salary_table_seniority" code="superAdmin.salary.table.seniority"/>
<spring:message var="msg_superAdmin_salary_table_tier" code="superAdmin.salary.table.tier"/>
<spring:message var="msg_superAdmin_salary_table_level" code="superAdmin.salary.table.level"/>
<spring:message var="msg_superAdmin_salary_table_band" code="superAdmin.salary.table.band"/>
<spring:message var="msg_superAdmin_salary_table_grade" code="superAdmin.salary.table.grade"/>
<spring:message var="msg_superAdmin_salary_table_step" code="superAdmin.salary.table.step"/>
<spring:message var="msg_superAdmin_salary_table_effectivePermission" code="superAdmin.salary.table.effectivePermission"/>
<spring:message var="msg_superAdmin_salary_table_manager" code="superAdmin.salary.table.manager"/>
<spring:message var="msg_superAdmin_salary_table_actions" code="superAdmin.salary.table.actions"/>
<spring:message var="msg_superAdmin_salary_action_edit" code="superAdmin.salary.action.edit"/>
<spring:message var="msg_superAdmin_salary_empty" code="superAdmin.salary.empty"/>
<spring:message var="msg_superAdmin_salary_modal_editTitle" code="superAdmin.salary.modal.editTitle"/>
<spring:message var="msg_superAdmin_salary_section_seniority" code="superAdmin.salary.section.seniority"/>
<spring:message var="msg_superAdmin_salary_option_select" code="superAdmin.salary.option.select"/>
<spring:message var="msg_superAdmin_salary_seniority_associate" code="superAdmin.salary.seniority.associate"/>
<spring:message var="msg_superAdmin_salary_seniority_junior" code="superAdmin.salary.seniority.junior"/>
<spring:message var="msg_superAdmin_salary_seniority_mid" code="superAdmin.salary.seniority.mid"/>
<spring:message var="msg_superAdmin_salary_seniority_senior" code="superAdmin.salary.seniority.senior"/>
<spring:message var="msg_superAdmin_salary_seniority_lead" code="superAdmin.salary.seniority.lead"/>
<spring:message var="msg_superAdmin_salary_seniority_principal" code="superAdmin.salary.seniority.principal"/>
<spring:message var="msg_superAdmin_salary_seniority_staff" code="superAdmin.salary.seniority.staff"/>
<spring:message var="msg_superAdmin_salary_seniority_fellow" code="superAdmin.salary.seniority.fellow"/>
<spring:message var="msg_superAdmin_salary_section_tier" code="superAdmin.salary.section.tier"/>
<spring:message var="msg_superAdmin_salary_section_level" code="superAdmin.salary.section.level"/>
<spring:message var="msg_superAdmin_salary_section_band" code="superAdmin.salary.section.band"/>
<spring:message var="msg_superAdmin_salary_section_grade" code="superAdmin.salary.section.grade"/>
<spring:message var="msg_superAdmin_salary_section_step" code="superAdmin.salary.section.step"/>
<spring:message var="msg_superAdmin_salary_step_1" code="superAdmin.salary.step.1"/>
<spring:message var="msg_superAdmin_salary_step_2" code="superAdmin.salary.step.2"/>
<spring:message var="msg_superAdmin_salary_step_3" code="superAdmin.salary.step.3"/>
<spring:message var="msg_superAdmin_salary_step_4" code="superAdmin.salary.step.4"/>
<spring:message var="msg_superAdmin_salary_step_5" code="superAdmin.salary.step.5"/>
<spring:message var="msg_superAdmin_salary_step_6" code="superAdmin.salary.step.6"/>
<spring:message var="msg_superAdmin_salary_step_7" code="superAdmin.salary.step.7"/>
<spring:message var="msg_superAdmin_salary_step_8" code="superAdmin.salary.step.8"/>
<spring:message var="msg_superAdmin_salary_step_9" code="superAdmin.salary.step.9"/>
<spring:message var="msg_superAdmin_salary_step_10" code="superAdmin.salary.step.10"/>
<spring:message var="msg_superAdmin_salary_step_11" code="superAdmin.salary.step.11"/>
<spring:message var="msg_superAdmin_salary_step_12" code="superAdmin.salary.step.12"/>
<spring:message var="msg_superAdmin_salary_step_13" code="superAdmin.salary.step.13"/>
<spring:message var="msg_superAdmin_salary_step_14" code="superAdmin.salary.step.14"/>
<spring:message var="msg_superAdmin_salary_step_15" code="superAdmin.salary.step.15"/>
<spring:message var="msg_admin_common_cancel" code="admin.common.cancel"/>
<spring:message var="msg_admin_common_save" code="admin.common.save"/>
<spring:message var="msg_superAdmin_salary_modal_previewTitle" code="superAdmin.salary.modal.previewTitle"/>
<spring:message var="msg_superAdmin_salary_preview_row" code="superAdmin.salary.preview.row"/>
<spring:message var="msg_superAdmin_salary_table_state" code="superAdmin.salary.table.state"/>
<spring:message var="msg_superAdmin_salary_table_email" code="superAdmin.salary.table.email"/>
<spring:message var="msg_superAdmin_salary_table_changedContent" code="superAdmin.salary.table.changedContent"/>
<spring:message var="msg_superAdmin_salary_action_apply" code="superAdmin.salary.action.apply"/>
<c:set var="pageTitle" value="${msg_superAdmin_salary_pageTitle}"/>
<c:set var="activeMenu" value="salary"/>


<%@ include file="layout.jsp" %>

<div class="adm-content sa-salary-page">
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_superAdmin_salary_cardTitle}</div>
            <div class="sa-card-subtitle">${msg_superAdmin_salary_cardDescription}</div>
        </div>
        <div class="adm-card-body sa-table-card-body">

            <%-- 검색/필터 폼 (서버사이드) --%>
            <form method="get" action="${pageContext.request.contextPath}/superAdmin/salary" class="sa-salary-toolbar" id="salaryFilterForm">
                <input type="text" name="keyword"
                       value="${fn:escapeXml(search.keyword)}"
                       placeholder="${msg_superAdmin_salary_filter_keywordPlaceholder}" class="adm-input sa-salary-keyword">
                <input type="text" name="filterDepartment"
                       value="${fn:escapeXml(search.filterDepartment)}"
                       placeholder="${msg_superAdmin_salary_filter_departmentPlaceholder}" class="adm-input sa-salary-filter">
                <input type="text" name="filterPermissionCode"
                       value="${fn:escapeXml(search.filterPermissionCode)}"
                       placeholder="${msg_superAdmin_salary_filter_permissionPlaceholder}" class="adm-input sa-salary-filter">
                <select name="filterAccountStatus" class="adm-select sa-salary-status">
                    <option value="">${msg_superAdmin_salary_filter_accountStatusAll}</option>
                    <option value="ACTIVE"   <c:if test="${search.filterAccountStatus == 'ACTIVE'}">selected</c:if>>${msg_admin_status_ACTIVE}</option>
                    <option value="BLOCKED"  <c:if test="${search.filterAccountStatus == 'BLOCKED'}">selected</c:if>>${msg_admin_status_BLOCKED}</option>
                    <option value="DORMANT"  <c:if test="${search.filterAccountStatus == 'DORMANT'}">selected</c:if>>${msg_admin_status_DORMANT}</option>
                    <option value="DELETED"  <c:if test="${search.filterAccountStatus == 'DELETED'}">selected</c:if>>${msg_admin_status_DELETED}</option>
                </select>
                <input type="hidden" name="pageSize" value="${search.pageSize}">
                <button type="submit" class="adm-btn adm-btn-primary">${msg_superAdmin_salary_action_search}</button>
                <a href="${pageContext.request.contextPath}/superAdmin/salary" class="adm-btn adm-btn-ghost">${msg_superAdmin_salary_action_reset}</a>
                <div class="sa-salary-actions">
                    <button type="button" class="adm-btn adm-btn-ghost"
                            onclick="triggerSalaryUpload()">${msg_superAdmin_salary_action_uploadExcel}</button>
                    <input type="file" id="salaryUploadInput" accept=".xlsx,.xls" class="sa-hidden-file"
                           onchange="handleSalaryFile(event)">
                    <a href="${pageContext.request.contextPath}/superAdmin/salary/export?keyword=${fn:escapeXml(search.keyword)}&filterDepartment=${fn:escapeXml(search.filterDepartment)}&filterPermissionCode=${fn:escapeXml(search.filterPermissionCode)}&filterAccountStatus=${fn:escapeXml(search.filterAccountStatus)}"
                       class="adm-btn adm-btn-ghost">
                        ${msg_superAdmin_salary_action_exportExcel}
                    </a>
                    <span class="sa-salary-count">${msg_superAdmin_salary_table_count}</span>
                </div>
            </form>

            <div class="sa-table-scroll">
                <table class="sa-salary-table" id="salaryTable">
                    <thead>
                        <tr>
                            <th>${msg_superAdmin_salary_table_nickname}</th>
                            <th>${msg_superAdmin_salary_table_department}</th>
                            <th>${msg_superAdmin_salary_table_team}</th>
                            <th>${msg_superAdmin_salary_table_positionCode}</th>
                            <th>${msg_superAdmin_salary_table_title}</th>
                            <th>${msg_superAdmin_salary_table_rank}</th>
                            <th>${msg_superAdmin_salary_table_seniority}</th>
                            <th>${msg_superAdmin_salary_table_tier}</th>
                            <th>${msg_superAdmin_salary_table_level}</th>
                            <th>${msg_superAdmin_salary_table_band}</th>
                            <th>${msg_superAdmin_salary_table_grade}</th>
                            <th>${msg_superAdmin_salary_table_step}</th>
                            <th>${msg_superAdmin_salary_table_effectivePermission}</th>
                            <th>${msg_superAdmin_salary_table_manager}</th>
                            <th>${msg_superAdmin_salary_table_actions}</th>
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
                                        onclick="openSalaryEdit(this.closest('tr'))">${msg_superAdmin_salary_action_edit}</button>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty salaryList}">
                <div class="sa-empty-cell sa-empty-cell-large">${msg_superAdmin_salary_empty}</div>
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
    <div class="adm-modal sa-modal-xs">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="salaryEditTitle">${msg_superAdmin_salary_modal_editTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('salaryEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-salary-edit-grid">
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_salary_section_seniority}</label>
                    <select class="adm-select sa-full-select" id="se_seniority">
                        <option value="">${msg_superAdmin_salary_option_select}</option>
                        <option value="어소시에이트">${msg_superAdmin_salary_seniority_associate}</option>
                        <option value="주니어">${msg_superAdmin_salary_seniority_junior}</option>
                        <option value="미드레벨">${msg_superAdmin_salary_seniority_mid}</option>
                        <option value="시니어">${msg_superAdmin_salary_seniority_senior}</option>
                        <option value="리드">${msg_superAdmin_salary_seniority_lead}</option>
                        <option value="프린시펄">${msg_superAdmin_salary_seniority_principal}</option>
                        <option value="스태프">${msg_superAdmin_salary_seniority_staff}</option>
                        <option value="펠로우">${msg_superAdmin_salary_seniority_fellow}</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_salary_section_tier}</label>
                    <select class="adm-select sa-full-select" id="se_tier">
                        <option value="">${msg_superAdmin_salary_option_select}</option>
                        <option>T1</option><option>T2</option><option>T3</option><option>T4</option><option>T5</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_salary_section_level}</label>
                    <select class="adm-select sa-full-select" id="se_level">
                        <option value="">${msg_superAdmin_salary_option_select}</option>
                        <option>L1</option><option>L2</option><option>L3</option><option>L4</option>
                        <option>L5</option><option>L6</option><option>L7</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_salary_section_band}</label>
                    <select class="adm-select sa-full-select" id="se_band">
                        <option value="">${msg_superAdmin_salary_option_select}</option>
                        <option>B1</option><option>B2</option><option>B3</option><option>B4</option><option>B5</option>
                        <option>B6</option><option>B7</option><option>B8</option><option>B9</option><option>B10</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_salary_section_grade}</label>
                    <select class="adm-select sa-full-select" id="se_grade">
                        <option value="">${msg_superAdmin_salary_option_select}</option>
                        <option>G1</option><option>G2</option><option>G3</option><option>G4</option><option>G5</option>
                        <option>G6</option><option>G7</option><option>G8</option><option>G9</option><option>G10</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_salary_section_step}</label>
                    <select class="adm-select sa-full-select" id="se_step">
                        <option value="">${msg_superAdmin_salary_option_select}</option>
                        <option value="1호봉">${msg_superAdmin_salary_step_1}</option>
                        <option value="2호봉">${msg_superAdmin_salary_step_2}</option>
                        <option value="3호봉">${msg_superAdmin_salary_step_3}</option>
                        <option value="4호봉">${msg_superAdmin_salary_step_4}</option>
                        <option value="5호봉">${msg_superAdmin_salary_step_5}</option>
                        <option value="6호봉">${msg_superAdmin_salary_step_6}</option>
                        <option value="7호봉">${msg_superAdmin_salary_step_7}</option>
                        <option value="8호봉">${msg_superAdmin_salary_step_8}</option>
                        <option value="9호봉">${msg_superAdmin_salary_step_9}</option>
                        <option value="10호봉">${msg_superAdmin_salary_step_10}</option>
                        <option value="11호봉">${msg_superAdmin_salary_step_11}</option>
                        <option value="12호봉">${msg_superAdmin_salary_step_12}</option>
                        <option value="13호봉">${msg_superAdmin_salary_step_13}</option>
                        <option value="14호봉">${msg_superAdmin_salary_step_14}</option>
                        <option value="15호봉">${msg_superAdmin_salary_step_15}</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('salaryEditModal')">${msg_admin_common_cancel}</button>
            <button class="adm-btn adm-btn-primary"  onclick="saveSalary()">${msg_admin_common_save}</button>
        </div>
    </div>
</div>

<%-- 급여/역량 업로드 미리보기 모달 --%>
<div class="adm-modal-overlay" id="salaryUploadPreviewModal">
    <div class="adm-modal sa-modal-xl">
        <div class="adm-modal-head">
            <div class="adm-modal-title">${msg_superAdmin_salary_modal_previewTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('salaryUploadPreviewModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div id="salaryPreviewSummary" class="sa-preview-summary"></div>
            <div id="salaryPreviewWarn" class="sa-preview-warning"></div>
            <div class="sa-preview-table-wrap">
                <table class="sa-salary-table sa-preview-table" id="salaryPreviewTable">
                    <thead>
                        <tr>
                            <th class="sa-preview-row-col">${msg_superAdmin_salary_preview_row}</th>
                            <th class="sa-preview-state-col">${msg_superAdmin_salary_table_state}</th>
                            <th class="sa-preview-name-col">${msg_superAdmin_salary_table_nickname}</th>
                            <th class="sa-preview-email-col">${msg_superAdmin_salary_table_email}</th>
                            <th>${msg_superAdmin_salary_table_changedContent}</th>
                        </tr>
                    </thead>
                    <tbody id="salaryPreviewTbody"></tbody>
                </table>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('salaryUploadPreviewModal')">${msg_admin_common_cancel}</button>
            <button class="adm-btn adm-btn-primary" id="salaryApplyBtn" onclick="applySalaryUpload()">${msg_superAdmin_salary_action_apply}</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentSalaryIdx = null;
let salaryPreviewRows = [];
const SALARY_MESSAGES = {
    editTitleSuffix: '${msg_superAdmin_salary_editTitleSuffix_js}',
    saved: '${msg_superAdmin_salary_toastSaved_js}',
    saveFailed: '${msg_superAdmin_salary_toastSaveFailed_js}',
    validating: '${msg_superAdmin_salary_preview_toastValidating_js}',
    previewFailed: '${msg_superAdmin_salary_preview_previewFailed_js}',
    networkError: '${msg_superAdmin_salary_preview_networkError_js}',
    total: '${msg_superAdmin_salary_preview_summary_total_js}',
    changed: '${msg_superAdmin_salary_preview_summary_changed_js}',
    unchanged: '${msg_superAdmin_salary_preview_summary_unchanged_js}',
    error: '${msg_superAdmin_salary_preview_summary_error_js}',
    errorExcluded: '${msg_superAdmin_salary_preview_errorExcluded_js}',
    statusChange: '${msg_superAdmin_salary_preview_change_js}',
    statusError: '${msg_superAdmin_salary_preview_error_js}',
    statusUnchanged: '${msg_superAdmin_salary_preview_unchanged_js}',
    genericError: '${msg_superAdmin_salary_preview_error_js}',
    noChanges: '${msg_superAdmin_salary_preview_noChanges_js}',
    willApply: '${msg_superAdmin_salary_preview_willApply_js}',
    noRowsToApply: '${msg_superAdmin_salary_preview_noRowsToApply_js}',
    applyConfirm: '${msg_superAdmin_salary_preview_applyConfirm_js}',
    appliedCompleted: '${msg_superAdmin_salary_preview_applyCompleted_js}',
    applyFailed: '${msg_superAdmin_salary_preview_applyFailed_js}',
    fieldLabels: {
        Seniority: '${msg_superAdmin_salary_section_seniority_js}',
        Tier: '${msg_superAdmin_salary_section_tier_js}',
        Level: '${msg_superAdmin_salary_section_level_js}',
        Band: '${msg_superAdmin_salary_section_band_js}',
        Grade: '${msg_superAdmin_salary_section_grade_js}',
        Step: '${msg_superAdmin_salary_section_step_js}'
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
        '<span>' + SALARY_MESSAGES.total + ' <b>' + totalCnt + '</b>' + '${msg_superAdmin_salary_preview_row_js}' + '</span>' +
        '<span class="sa-preview-summary-change">' + SALARY_MESSAGES.changed + ' <b>' + changeCnt + '</b></span>' +
        '<span class="sa-preview-summary-muted">' + SALARY_MESSAGES.unchanged + ' <b>' + unchangedCnt + '</b></span>' +
        '<span class="sa-preview-summary-error">' + SALARY_MESSAGES.error + ' <b>' + errorCnt + '</b></span>';

    const warnEl = document.getElementById('salaryPreviewWarn');
    if (errorCnt > 0) {
        warnEl.classList.add('is-visible');
        warnEl.textContent = SALARY_MESSAGES.errorExcluded;
    } else {
        warnEl.classList.remove('is-visible');
    }

    const tbody = document.getElementById('salaryPreviewTbody');
    tbody.innerHTML = '';
    salaryPreviewRows.forEach(r => {
        const tr = document.createElement('tr');

        let badge;
        if (r.status === 'CHANGE') {
            badge = '<span class="sa-preview-badge is-change">' + SALARY_MESSAGES.statusChange + '</span>';
        } else if (r.status === 'ERROR') {
            badge = '<span class="sa-preview-badge is-error">' + SALARY_MESSAGES.statusError + '</span>';
        } else {
            badge = '<span class="sa-preview-badge is-unchanged">' + SALARY_MESSAGES.statusUnchanged + '</span>';
        }

        let diffHtml;
        if (r.status === 'ERROR') {
            diffHtml = '<span class="sa-preview-error">' + escapeHtml(r.errorMessage || SALARY_MESSAGES.genericError) + '</span>';
        } else if (r.status === 'CHANGE' && r.newValues) {
            const parts = [];
            Object.keys(r.newValues).forEach(k => {
                const oldV = (r.oldValues && r.oldValues[k]) || '∅';
                const newV = r.newValues[k] || '∅';
                const label = SALARY_MESSAGES.fieldLabels[k] || k;
                parts.push('<div><b>' + escapeHtml(label) + '</b>: <span class="sa-preview-old">' + escapeHtml(oldV) + '</span> → <span class="sa-preview-new">' + escapeHtml(newV) + '</span></div>');
            });
            diffHtml = parts.join('');
        } else {
            diffHtml = '<span class="sa-preview-muted">' + SALARY_MESSAGES.noChanges + '</span>';
        }

        tr.innerHTML =
            '<td>' + (r.rowNumber || '') + '</td>' +
            '<td>' + badge + '</td>' +
            '<td>' + escapeHtml(r.nickname || '') + '</td>' +
            '<td>' + escapeHtml(r.email || '') + '</td>' +
            '<td class="sa-preview-diff-cell">' + diffHtml + '</td>';
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
