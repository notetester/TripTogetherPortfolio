<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_superAdmin_member_list_filter_searchPlaceholder" code="superAdmin.member.list.filter.searchPlaceholder"/>
<spring:message var="msg_superAdmin_member_list_grant_searchPlaceholder" code="superAdmin.member.list.grant.searchPlaceholder"/>
<spring:message var="msg_superAdmin_member_list_detail_loading_js" code="superAdmin.member.list.detail.loading" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_groupNone_js" code="superAdmin.member.list.detail.groupNone" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_groupSelectPlaceholder_js" code="superAdmin.member.list.detail.groupSelectPlaceholder" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_groupAssignSection_js" code="superAdmin.member.list.detail.groupAssignSection" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_groupAssign_js" code="superAdmin.member.list.detail.groupAssign" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_groupRequired_js" code="superAdmin.member.list.toast.groupRequired" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_groupAssigned_js" code="superAdmin.member.list.toast.groupAssigned" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_groupAssignFailed_js" code="superAdmin.member.list.toast.groupAssignFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_confirm_groupRevoke_js" code="superAdmin.member.list.confirm.groupRevoke" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_groupRevoked_js" code="superAdmin.member.list.toast.groupRevoked" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_groupRevokeFailed_js" code="superAdmin.member.list.toast.groupRevokeFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_action_revoke_js" code="superAdmin.member.list.action.revoke" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_titleSuffix_js" code="superAdmin.member.list.detail.titleSuffix" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_badge_code_js" code="superAdmin.member.list.detail.badge.code" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_badge_group_js" code="superAdmin.member.list.detail.badge.group" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_badge_direct_js" code="superAdmin.member.list.detail.badge.direct" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_codeSelectClear_js" code="superAdmin.member.list.detail.codeSelectClear" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_codeSelectClearChange_js" code="superAdmin.member.list.detail.codeSelectClearChange" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_field_nickname_js" code="superAdmin.member.list.field.nickname" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_userId_js" code="admin.common.userId" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_field_email_js" code="superAdmin.member.list.field.email" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_field_title_js" code="superAdmin.member.list.field.title" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_field_organization_js" code="superAdmin.member.list.field.organization" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_field_department_js" code="superAdmin.member.list.field.department" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_field_team_js" code="superAdmin.member.list.field.team" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_codeSection_js" code="superAdmin.member.list.detail.codeSection" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_codeSave_js" code="superAdmin.member.list.detail.codeSave" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_codeSourceHint_js" code="superAdmin.member.list.detail.codeSourceHint" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_permissionSection_js" code="superAdmin.member.list.detail.permissionSection" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_permissionSourceHint_js" code="superAdmin.member.list.detail.permissionSourceHint" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_permissionCodeSaved_js" code="superAdmin.member.list.toast.permissionCodeSaved" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_saveFailed_js" code="superAdmin.member.list.toast.saveFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_audit_groupHistory_js" code="superAdmin.member.list.detail.audit.groupHistory" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_audit_permissionHistory_js" code="superAdmin.member.list.detail.audit.permissionHistory" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_detail_audit_empty_js" code="superAdmin.member.list.detail.audit.empty" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_audit_header_groupCode_js" code="superAdmin.member.list.audit.header.groupCode" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_audit_header_groupName_js" code="superAdmin.member.list.audit.header.groupName" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_audit_header_code_js" code="superAdmin.member.list.audit.header.code" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_audit_header_permissionName_js" code="superAdmin.member.list.audit.header.permissionName" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_audit_header_status_js" code="superAdmin.member.list.audit.header.status" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_audit_header_actor_js" code="superAdmin.member.list.audit.header.actor" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_audit_header_date_js" code="superAdmin.member.list.audit.header.date" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_audit_status_active_js" code="superAdmin.member.list.audit.status.active" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_audit_status_inactive_js" code="superAdmin.member.list.audit.status.inactive" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_audit_status_revoked_js" code="superAdmin.member.list.audit.status.revoked" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_permissionSaved_js" code="superAdmin.member.list.toast.permissionSaved" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_confirm_revokeAdmin_js" code="superAdmin.member.list.confirm.revokeAdmin" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_revokeDone_js" code="superAdmin.member.list.toast.revokeDone" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_revokeFailed_js" code="superAdmin.member.list.toast.revokeFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_searchRequired_js" code="superAdmin.member.list.toast.searchRequired" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_loading_js" code="admin.common.loading" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_searchEmpty_js" code="superAdmin.member.list.searchEmpty" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_grant_button_js" code="superAdmin.member.list.grant.button" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_grant_errorPrefix_js" code="superAdmin.member.list.grant.errorPrefix" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_confirm_grantAdmin_js" code="superAdmin.member.list.confirm.grantAdmin" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_grantDone_js" code="superAdmin.member.list.toast.grantDone" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_toast_grantFailed_js" code="superAdmin.member.list.toast.grantFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_bulk_selectedFormat_js" code="superAdmin.member.list.bulk.selectedFormat" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_confirm_bulkRevoke_js" code="superAdmin.member.list.confirm.bulkRevoke" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_bulk_toast_revokeDone_js" code="superAdmin.member.list.bulk.toast.revokeDone" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_bulk_toast_updateDone_js" code="superAdmin.member.list.bulk.toast.updateDone" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_bulk_emptyPolicies_js" code="superAdmin.member.list.bulk.emptyPolicies" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_member_list_pageTitle" code="superAdmin.member.list.pageTitle"/>
<spring:message var="msg_superAdmin_member_list_filter_search" code="superAdmin.member.list.filter.search"/>
<spring:message var="msg_superAdmin_member_list_search_all" code="superAdmin.member.list.search.all"/>
<spring:message var="msg_superAdmin_member_list_search_userId" code="superAdmin.member.list.search.userId"/>
<spring:message var="msg_superAdmin_member_list_search_nickname" code="superAdmin.member.list.search.nickname"/>
<spring:message var="msg_superAdmin_member_list_search_email" code="superAdmin.member.list.search.email"/>
<spring:message var="msg_superAdmin_member_list_filter_department" code="superAdmin.member.list.filter.department"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_superAdmin_member_list_filter_permissionCode" code="superAdmin.member.list.filter.permissionCode"/>
<spring:message var="msg_superAdmin_member_list_filter_accountStatus" code="superAdmin.member.list.filter.accountStatus"/>
<spring:message var="msg_admin_status_ACTIVE" code="admin.status.ACTIVE"/>
<spring:message var="msg_admin_status_BLOCKED" code="admin.status.BLOCKED"/>
<spring:message var="msg_admin_status_DORMANT" code="admin.status.DORMANT"/>
<spring:message var="msg_admin_status_DELETED" code="admin.status.DELETED"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_superAdmin_member_list_card_grantButton" code="superAdmin.member.list.card.grantButton"/>
<spring:message var="msg_superAdmin_member_list_table_member" code="superAdmin.member.list.table.member"/>
<spring:message var="msg_superAdmin_member_list_table_email" code="superAdmin.member.list.table.email"/>
<spring:message var="msg_superAdmin_member_list_table_title" code="superAdmin.member.list.table.title"/>
<spring:message var="msg_superAdmin_member_list_table_organization" code="superAdmin.member.list.table.organization"/>
<spring:message var="msg_superAdmin_member_list_table_permissionCode" code="superAdmin.member.list.table.permissionCode"/>
<spring:message var="msg_superAdmin_member_list_table_accountStatus" code="superAdmin.member.list.table.accountStatus"/>
<spring:message var="msg_superAdmin_member_list_table_createdAt" code="superAdmin.member.list.table.createdAt"/>
<spring:message var="msg_superAdmin_member_list_table_manage" code="superAdmin.member.list.table.manage"/>
<spring:message var="msg_superAdmin_member_list_result_empty" code="superAdmin.member.list.result.empty"/>
<spring:message var="msg_superAdmin_member_list_detail_codeSelectClear" code="superAdmin.member.list.detail.codeSelectClear"/>
<spring:message var="msg_superAdmin_member_list_action_permission" code="superAdmin.member.list.action.permission"/>
<spring:message var="msg_superAdmin_member_list_action_edit" code="superAdmin.member.list.action.edit"/>
<spring:message var="msg_superAdmin_member_list_action_revoke" code="superAdmin.member.list.action.revoke"/>
<spring:message var="msg_superAdmin_member_list_bulk_selectedFormat" code="superAdmin.member.list.bulk.selectedFormat"/>
<spring:message var="msg_superAdmin_member_list_bulk_button" code="superAdmin.member.list.bulk.button"/>
<spring:message var="msg_superAdmin_member_list_bulk_revoke" code="superAdmin.member.list.bulk.revoke"/>
<spring:message var="msg_superAdmin_member_list_bulk_cancel" code="superAdmin.member.list.bulk.cancel"/>
<spring:message var="msg_superAdmin_member_list_detail_title" code="superAdmin.member.list.detail.title"/>
<spring:message var="msg_superAdmin_member_list_detail_tabInfo" code="superAdmin.member.list.detail.tabInfo"/>
<spring:message var="msg_superAdmin_member_list_detail_audit" code="superAdmin.member.list.detail.audit"/>
<spring:message var="msg_superAdmin_member_list_detail_loading" code="superAdmin.member.list.detail.loading"/>
<spring:message var="msg_admin_common_close" code="admin.common.close"/>
<spring:message var="msg_admin_common_save" code="admin.common.save"/>
<spring:message var="msg_superAdmin_member_list_grant_modalTitle" code="superAdmin.member.list.grant.modalTitle"/>
<spring:message var="msg_superAdmin_member_list_bulk_applyTitle" code="superAdmin.member.list.bulk.applyTitle"/>
<spring:message var="msg_superAdmin_member_list_bulk_applyDescription" code="superAdmin.member.list.bulk.applyDescription"/>
<spring:message var="msg_admin_common_cancel" code="admin.common.cancel"/>
<spring:message var="msg_superAdmin_member_list_bulk_save" code="superAdmin.member.list.bulk.save"/>
<c:set var="pageTitle" value="${msg_superAdmin_member_list_pageTitle}"/>
<c:set var="activeMenu" value="members"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ══════════════════════════════════════════
         검색 바
    ══════════════════════════════════════════ --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form id="searchForm" method="get" action="${pageContext.request.contextPath}/superAdmin/members">
                <div class="adm-filter-bar">
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">${msg_superAdmin_member_list_filter_search}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:100px;">
                                <option value="all"      ${search.searchType=='all'      ? 'selected' : ''}>${msg_superAdmin_member_list_search_all}</option>
                                <option value="userId"   ${search.searchType=='userId'   ? 'selected' : ''}>${msg_superAdmin_member_list_search_userId}</option>
                                <option value="nickname" ${search.searchType=='nickname' ? 'selected' : ''}>${msg_superAdmin_member_list_search_nickname}</option>
                                <option value="email"    ${search.searchType=='email'    ? 'selected' : ''}>${msg_superAdmin_member_list_search_email}</option>
                            </select>
                            <div class="adm-search-box" style="flex:1;">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword"
                                       value="${fn:escapeXml(search.keyword)}" placeholder="${msg_superAdmin_member_list_filter_searchPlaceholder}">
                            </div>
                        </div>
                    </div>
                    <div style="flex:0 0 auto;">
                        <div class="adm-filter-label">${msg_superAdmin_member_list_filter_department}</div>
                        <select class="adm-select" name="filterDepartment" style="width:140px;">
                            <option value="">${msg_admin_common_all}</option>
                            <c:forEach var="dept" items="${['커뮤니티운영팀','여행서비스팀','고객지원팀','플랫폼개발팀','인프라팀','AI팀','마케팅팀','재무팀','인사팀','법무팀','사업개발팀','보안팀','개인정보보호팀']}" varStatus="s">
                                <c:set var="deptLabelCode" value="superAdmin.member.edit.option.department.${s.index}"/>
                                <option value="${dept}" <c:if test="${search.filterDepartment == dept}">selected</c:if>>
                                    <spring:message var="msg_deptLabelCode_text_dept" code="${deptLabelCode}" text="${dept}"/>${msg_deptLabelCode_text_dept}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div style="flex:0 0 auto;">
                        <div class="adm-filter-label">${msg_superAdmin_member_list_filter_permissionCode}</div>
                        <select class="adm-select" name="filterPermissionCode" style="width:140px;">
                            <option value="">${msg_admin_common_all}</option>
                            <c:forEach var="pc" items="${permissionCodePolicies}">
                                <option value="${fn:escapeXml(pc.adminPermissionCode)}" <c:if test="${search.filterPermissionCode == pc.adminPermissionCode}">selected</c:if>>${fn:escapeXml(pc.displayName)}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div style="flex:0 0 auto;">
                        <div class="adm-filter-label">${msg_superAdmin_member_list_filter_accountStatus}</div>
                        <select class="adm-select" name="filterAccountStatus" style="width:110px;">
                            <option value="">${msg_admin_common_all}</option>
                            <option value="ACTIVE"  <c:if test="${search.filterAccountStatus == 'ACTIVE'}">selected</c:if>>${msg_admin_status_ACTIVE}</option>
                            <option value="BLOCKED" <c:if test="${search.filterAccountStatus == 'BLOCKED'}">selected</c:if>>${msg_admin_status_BLOCKED}</option>
                            <option value="DORMANT" <c:if test="${search.filterAccountStatus == 'DORMANT'}">selected</c:if>>${msg_admin_status_DORMANT}</option>
                            <option value="DELETED" <c:if test="${search.filterAccountStatus == 'DELETED'}">selected</c:if>>${msg_admin_status_DELETED}</option>
                        </select>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:8px;">
                        <button type="submit" class="adm-btn adm-btn-primary">${msg_admin_common_search}</button>
                        <a href="${pageContext.request.contextPath}/superAdmin/members" class="adm-btn adm-btn-ghost">${msg_admin_common_reset}</a>
                        <button type="button" class="adm-btn adm-btn-ghost" onclick="openGrantModal()">${msg_superAdmin_member_list_card_grantButton}</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ══════════════════════════════════════════
         관리자 테이블
    ══════════════════════════════════════════ --%>
    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <table class="adm-table">
                <thead>
                    <tr>
                        <th style="width:40px;text-align:center;">
                            <input type="checkbox" class="sa-cb" id="cbAll" onclick="toggleAll(this)">
                        </th>
                        <th>${msg_superAdmin_member_list_table_member}</th>
                        <th>${msg_superAdmin_member_list_table_email}</th>
                        <th>${msg_superAdmin_member_list_table_title}</th>
                        <th>${msg_superAdmin_member_list_table_organization}</th>
                        <th>${msg_superAdmin_member_list_table_permissionCode}</th>
                        <th>${msg_superAdmin_member_list_table_accountStatus}</th>
                        <th>${msg_superAdmin_member_list_table_createdAt}</th>
                        <th>${msg_superAdmin_member_list_table_manage}</th>
                    </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty adminList}">
                        <tr><td colspan="9" style="text-align:center;padding:40px;color:#94a3b8;">${msg_superAdmin_member_list_result_empty}</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="m" items="${adminList}">
                        <tr>
                            <td style="text-align:center;">
                                <input type="checkbox" class="sa-cb row-cb"
                                       data-idx="${m.userIdx}" data-nickname="${m.nickname}"
                                       onchange="onRowCbChange()">
                            </td>
                            <td>
                                <div style="font-weight:600;">${m.nickname}</div>
                                <div style="font-size:12px;color:#94a3b8;">${m.userId}</div>
                            </td>
                            <td>${m.userEmail}</td>
                            <td>${not empty m.adminTitle ? m.adminTitle : '-'}</td>
                            <td>
                                <c:if test="${not empty m.adminOrganization}">${m.adminOrganization}</c:if>
                                <c:if test="${not empty m.adminDepartment}"> / ${m.adminDepartment}</c:if>
                                <c:if test="${empty m.adminOrganization and empty m.adminDepartment}">-</c:if>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty m.adminPermissionCode}">
                                        <span class="adm-badge adm-badge-blue">${m.adminPermissionCode}</span>
                                    </c:when>
                                    <c:otherwise><span style="color:#94a3b8;">${msg_superAdmin_member_list_detail_codeSelectClear}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${m.accountStatus == 'ACTIVE'}"><span class="adm-badge adm-badge-green">${msg_admin_status_ACTIVE}</span></c:when>
                                    <c:when test="${m.accountStatus == 'BLOCKED'}"><span class="adm-badge adm-badge-red">${msg_admin_status_BLOCKED}</span></c:when>
                                    <c:otherwise><span class="adm-badge">${m.accountStatus}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${m.createdAtDate}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <div style="display:flex;gap:6px;">
                                    <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                            data-id="${m.userIdx}"
                                            onclick="openDetailModal(this.getAttribute('data-id'))">${msg_superAdmin_member_list_action_permission}</button>
                                    <a class="adm-btn adm-btn-sm adm-btn-ghost"
                                       href="${pageContext.request.contextPath}/superAdmin/members/${m.userIdx}/edit">${msg_superAdmin_member_list_action_edit}</a>
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-id="${m.userIdx}"
                                            data-nickname="${m.nickname}"
                                            onclick="revokeAdmin(this.getAttribute('data-id'), this.getAttribute('data-nickname'))">${msg_superAdmin_member_list_action_revoke}</button>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <%-- 페이징 --%>
    <c:if test="${totalPage > 1}">
        <div class="adm-paging">
            <c:forEach begin="1" end="${totalPage}" var="p">
                <a class="adm-page-btn ${p == search.page ? 'active' : ''}"
                   href="?page=${p}&keyword=${fn:escapeXml(search.keyword)}&searchType=${search.searchType}&filterDepartment=${fn:escapeXml(search.filterDepartment)}&filterPermissionCode=${fn:escapeXml(search.filterPermissionCode)}&filterAccountStatus=${fn:escapeXml(search.filterAccountStatus)}">${p}</a>
            </c:forEach>
        </div>
    </c:if>
</div>


<%-- ══════════════════════════════════════════
     일괄 처리 액션바
══════════════════════════════════════════ --%>
<div class="sa-bulk-bar sa-bulk-hidden" id="bulkBar">
    <span class="sa-bulk-count" id="bulkCount">0</span> <span id="bulkCountLabel">${msg_superAdmin_member_list_bulk_selectedFormat}</span>
    <button class="adm-btn adm-btn-sm adm-btn-primary" onclick="openBulkPermModal()">${msg_superAdmin_member_list_bulk_button}</button>
    <button class="adm-btn adm-btn-sm adm-btn-danger"  onclick="bulkRevoke()">${msg_superAdmin_member_list_bulk_revoke}</button>
    <button class="adm-btn adm-btn-sm adm-btn-ghost"   onclick="clearSelection()" style="color:#94a3b8;">${msg_superAdmin_member_list_bulk_cancel}</button>
</div>

<%-- ══════════════════════════════════════════
     상세 / 권한 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:680px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">${msg_superAdmin_member_list_detail_title}</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body" style="max-height:70vh;overflow-y:auto;">
            <div class="sa-tabs">
                <button class="sa-tab-btn active" onclick="switchTab('info',this)">${msg_superAdmin_member_list_detail_tabInfo}</button>
                <button class="sa-tab-btn"        onclick="switchTab('audit',this)">${msg_superAdmin_member_list_detail_audit}</button>
            </div>
            <div class="sa-tab-panel active" id="tabInfo">
                <div id="detailModalBody">
                    <div style="text-align:center;padding:40px;color:#94a3b8;">${msg_superAdmin_member_list_detail_loading}</div>
                </div>
            </div>
            <div class="sa-tab-panel" id="tabAudit">
                <div id="auditBody">
                    <div style="text-align:center;padding:40px;color:#94a3b8;">${msg_superAdmin_member_list_detail_loading}</div>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('detailModal')">${msg_admin_common_close}</button>
            <button class="adm-btn adm-btn-primary"  id="savePermBtn" onclick="savePermissions()">${msg_superAdmin_member_list_action_permission} ${msg_admin_common_save}</button>
        </div>
    </div>
</div>

<%-- ══════════════════════════════════════════
     관리자 등록 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="grantModal">
    <div class="adm-modal" style="width:520px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">${msg_superAdmin_member_list_grant_modalTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('grantModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div style="display:flex;gap:8px;margin-bottom:16px;">
                <input class="adm-input" id="grantSearchInput" type="text" placeholder="${msg_superAdmin_member_list_grant_searchPlaceholder}">
                <button class="adm-btn adm-btn-primary" onclick="searchUsers()">${msg_admin_common_search}</button>
            </div>
            <div id="grantSearchResult"></div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('grantModal')">${msg_admin_common_close}</button>
        </div>
    </div>
</div>

<%-- ══════════════════════════════════════════
     일괄 권한 설정 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="bulkPermModal">
    <div class="adm-modal" style="width:520px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">${msg_superAdmin_member_list_bulk_applyTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('bulkPermModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div style="font-size:13px;color:#64748b;margin-bottom:12px; white-space:pre-line;">${msg_superAdmin_member_list_bulk_applyDescription}</div>
            <div id="bulkPermList"></div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('bulkPermModal')">${msg_admin_common_cancel}</button>
            <button class="adm-btn adm-btn-primary"  onclick="saveBulkPermissions()">${msg_superAdmin_member_list_bulk_save}</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentUserIdx  = null;
let allPolicies         = [];
let allPermCodePolicies = [];
let activeCodes         = [];
const MEMBER_LIST_MESSAGES = {
    loading: '${msg_superAdmin_member_list_detail_loading_js}',
    groupNoData: '${msg_superAdmin_member_list_detail_groupNone_js}',
    groupSelectPlaceholder: '${msg_superAdmin_member_list_detail_groupSelectPlaceholder_js}',
    groupAssignSection: '${msg_superAdmin_member_list_detail_groupAssignSection_js}',
    groupAssign: '${msg_superAdmin_member_list_detail_groupAssign_js}',
    groupRequired: '${msg_superAdmin_member_list_toast_groupRequired_js}',
    groupAssigned: '${msg_superAdmin_member_list_toast_groupAssigned_js}',
    groupAssignFailed: '${msg_superAdmin_member_list_toast_groupAssignFailed_js}',
    confirmGroupRevoke: '${msg_superAdmin_member_list_confirm_groupRevoke_js}',
    groupRevoked: '${msg_superAdmin_member_list_toast_groupRevoked_js}',
    groupRevokeFailed: '${msg_superAdmin_member_list_toast_groupRevokeFailed_js}',
    actionRevoke: '${msg_superAdmin_member_list_action_revoke_js}',
    detailTitleSuffix: '${msg_superAdmin_member_list_detail_titleSuffix_js}',
    sourceCode: '${msg_superAdmin_member_list_detail_badge_code_js}',
    sourceGroup: '${msg_superAdmin_member_list_detail_badge_group_js}',
    sourceDirect: '${msg_superAdmin_member_list_detail_badge_direct_js}',
    codeClear: '${msg_superAdmin_member_list_detail_codeSelectClear_js}',
    codeClearChange: '${msg_superAdmin_member_list_detail_codeSelectClearChange_js}',
    fieldNickname: '${msg_superAdmin_member_list_field_nickname_js}',
    fieldUserId: '${msg_admin_common_userId_js}',
    fieldEmail: '${msg_superAdmin_member_list_field_email_js}',
    fieldTitle: '${msg_superAdmin_member_list_field_title_js}',
    fieldOrganization: '${msg_superAdmin_member_list_field_organization_js}',
    fieldDepartment: '${msg_superAdmin_member_list_field_department_js}',
    fieldTeam: '${msg_superAdmin_member_list_field_team_js}',
    codeSection: '${msg_superAdmin_member_list_detail_codeSection_js}',
    codeSave: '${msg_superAdmin_member_list_detail_codeSave_js}',
    codeHint: '${msg_superAdmin_member_list_detail_codeSourceHint_js}',
    permissionSection: '${msg_superAdmin_member_list_detail_permissionSection_js}',
    permissionHint: '${msg_superAdmin_member_list_detail_permissionSourceHint_js}',
    permissionCodeSaved: '${msg_superAdmin_member_list_toast_permissionCodeSaved_js}',
    saveFailed: '${msg_superAdmin_member_list_toast_saveFailed_js}',
    auditGroupTitle: '${msg_superAdmin_member_list_detail_audit_groupHistory_js}',
    auditPermissionTitle: '${msg_superAdmin_member_list_detail_audit_permissionHistory_js}',
    auditEmpty: '${msg_superAdmin_member_list_detail_audit_empty_js}',
    auditHeaderGroupCode: '${msg_superAdmin_member_list_audit_header_groupCode_js}',
    auditHeaderGroupName: '${msg_superAdmin_member_list_audit_header_groupName_js}',
    auditHeaderCode: '${msg_superAdmin_member_list_audit_header_code_js}',
    auditHeaderPermissionName: '${msg_superAdmin_member_list_audit_header_permissionName_js}',
    auditHeaderStatus: '${msg_superAdmin_member_list_audit_header_status_js}',
    auditHeaderActor: '${msg_superAdmin_member_list_audit_header_actor_js}',
    auditHeaderDate: '${msg_superAdmin_member_list_audit_header_date_js}',
    auditStatusActive: '${msg_superAdmin_member_list_audit_status_active_js}',
    auditStatusInactive: '${msg_superAdmin_member_list_audit_status_inactive_js}',
    auditStatusRevoked: '${msg_superAdmin_member_list_audit_status_revoked_js}',
    permissionSaved: '${msg_superAdmin_member_list_toast_permissionSaved_js}',
    confirmRevokeAdmin: '${msg_superAdmin_member_list_confirm_revokeAdmin_js}',
    revokeDone: '${msg_superAdmin_member_list_toast_revokeDone_js}',
    revokeFailed: '${msg_superAdmin_member_list_toast_revokeFailed_js}',
    grantSearchRequired: '${msg_superAdmin_member_list_toast_searchRequired_js}',
    grantSearching: '${msg_admin_common_loading_js}',
    grantEmpty: '${msg_superAdmin_member_list_searchEmpty_js}',
    grantButton: '${msg_superAdmin_member_list_grant_button_js}',
    grantErrorPrefix: '${msg_superAdmin_member_list_grant_errorPrefix_js}',
    confirmGrantAdmin: '${msg_superAdmin_member_list_confirm_grantAdmin_js}',
    grantDone: '${msg_superAdmin_member_list_toast_grantDone_js}',
    grantFailed: '${msg_superAdmin_member_list_toast_grantFailed_js}',
    bulkSelectedFormat: '${msg_superAdmin_member_list_bulk_selectedFormat_js}',
    confirmBulkRevoke: '${msg_superAdmin_member_list_confirm_bulkRevoke_js}',
    bulkRevokeDone: '${msg_superAdmin_member_list_bulk_toast_revokeDone_js}',
    bulkUpdateDone: '${msg_superAdmin_member_list_bulk_toast_updateDone_js}',
    bulkEmptyPolicies: '${msg_superAdmin_member_list_bulk_emptyPolicies_js}'
};

function formatMemberListMessage(template) {
    var args = Array.prototype.slice.call(arguments, 1);
    return template.replace(/\u007B(\d+)\u007D/g, function(_, idx) {
        return args[idx] !== undefined ? args[idx] : '';
    });
}

const GROUP_LIST = [
<c:forEach var="g" items="${groupList}"><c:if test="${g.active}">{code:'${fn:escapeXml(g.groupCode)}',name:'${fn:escapeXml(g.displayName)}'},
</c:if></c:forEach>
];

function buildGroupAssignSection(adminGroups) {
    if (GROUP_LIST.length === 0) return '';
    var currentCodes = (adminGroups || []).map(function(g){ return g.groupCode; });
    var currentHtml = (adminGroups && adminGroups.length > 0)
        ? adminGroups.map(function(g){
            return '<div style="display:flex;align-items:center;gap:8px;margin-bottom:6px;">' +
                '<span class="adm-badge adm-badge-green" style="font-size:12px;">' + g.displayName + '</span>' +
                '<button class="adm-btn adm-btn-sm adm-btn-danger" ' +
                    'data-gcode="' + g.groupCode + '" ' +
                    'onclick="revokeGroup(this.getAttribute(\'data-gcode\'))">' + MEMBER_LIST_MESSAGES.actionRevoke + '</button>' +
                '</div>';
          }).join('')
        : '<div style="color:#94a3b8;font-size:13px;margin-bottom:8px;">' + MEMBER_LIST_MESSAGES.groupNoData + '</div>';

    var assignableGroups = GROUP_LIST.filter(function(g){ return !currentCodes.includes(g.code); });
    var assignHtml = assignableGroups.length > 0
        ? '<div style="display:flex;gap:8px;margin-top:8px;">' +
          '<select class="adm-select" id="grpAssignSel" style="flex:1;">' +
          '<option value="">' + MEMBER_LIST_MESSAGES.groupSelectPlaceholder + '</option>' +
          assignableGroups.map(function(g){ return '<option value="' + g.code + '">' + g.name + '</option>'; }).join('') +
          '</select>' +
          '<button class="adm-btn adm-btn-primary" onclick="assignGroup()">' + MEMBER_LIST_MESSAGES.groupAssign + '</button>' +
          '</div>'
        : '';

    return '<div class="sa-section-title">' + MEMBER_LIST_MESSAGES.groupAssignSection + '</div>' +
           '<div id="adminGroupList">' + currentHtml + '</div>' + assignHtml;
}

function buildGroupSelect() {
    return '';
}

function assignGroup() {
    var sel = document.getElementById('grpAssignSel');
    if (!sel || !sel.value) { adm_toast(MEMBER_LIST_MESSAGES.groupRequired, 'error'); return; }
    fetch(CTX + '/superAdmin/members/' + currentUserIdx + '/groups/assign', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(sel.value)
    })
    .then(function(r){ return r.json(); })
    .then(function(data){
        if (data.success) { adm_toast(MEMBER_LIST_MESSAGES.groupAssigned); reloadDetailModal(); }
        else adm_toast(data.message || MEMBER_LIST_MESSAGES.groupAssignFailed, 'error');
    });
}

function revokeGroup(groupCode) {
    if (!confirm(MEMBER_LIST_MESSAGES.confirmGroupRevoke)) return;
    fetch(CTX + '/superAdmin/members/' + currentUserIdx + '/groups/revoke', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(groupCode)
    })
    .then(function(r){ return r.json(); })
    .then(function(data){
        if (data.success) { adm_toast(MEMBER_LIST_MESSAGES.groupRevoked); reloadDetailModal(); }
        else adm_toast(data.message || MEMBER_LIST_MESSAGES.groupRevokeFailed, 'error');
    });
}

function reloadDetailModal() {
    fetch(CTX + '/superAdmin/members/' + currentUserIdx)
        .then(function(r){ return r.json(); })
        .then(function(data){
            allPolicies = data.permissionPolicies;
            allPermCodePolicies = data.permissionCodePolicies || [];
            activeCodes = (data.member.permissions || []).map(function(p){ return p.permissionCode; });
            renderDetailModal(data.member, data.permissionPolicies, data.adminGroups);
        });
}

/* ── 탭 전환 ── */
function switchTab(tab, btn) {
    document.querySelectorAll('.sa-tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.sa-tab-panel').forEach(p => p.classList.remove('active'));
    btn.classList.add('active');
    document.getElementById('tab' + tab.charAt(0).toUpperCase() + tab.slice(1)).classList.add('active');

    if (tab === 'info') {
        document.getElementById('savePermBtn').style.display = '';
    } else {
        document.getElementById('savePermBtn').style.display = 'none';
        loadAuditLog();
    }
}

/* ── 상세 모달 열기 ── */
function openDetailModal(userIdx) {
    currentUserIdx = userIdx;
    activeCodes    = [];
    document.getElementById('detailModal').classList.add('open');
    document.getElementById('detailModalBody').innerHTML = '<div style="text-align:center;padding:40px;color:#94a3b8;">' + MEMBER_LIST_MESSAGES.loading + '</div>';
    document.getElementById('auditBody').innerHTML       = '<div style="text-align:center;padding:40px;color:#94a3b8;">' + MEMBER_LIST_MESSAGES.loading + '</div>';
    document.getElementById('savePermBtn').style.display = '';
    document.querySelectorAll('.sa-tab-btn').forEach((b,i) => b.classList.toggle('active', i===0));
    document.querySelectorAll('.sa-tab-panel').forEach((p,i) => p.classList.toggle('active', i===0));

    fetch(CTX + '/superAdmin/members/' + userIdx)
        .then(r => r.json())
        .then(data => {
            allPolicies = data.permissionPolicies;
            allPermCodePolicies = data.permissionCodePolicies || [];
            activeCodes = (data.member.permissions || []).map(p => p.permissionCode);
            renderDetailModal(data.member, data.permissionPolicies, data.adminGroups);
        });
}

function renderDetailModal(m, policies, adminGroups) {
    document.getElementById('detailModalTitle').textContent = (m.nickname || '') + ' ' + MEMBER_LIST_MESSAGES.detailTitleSuffix;

    // 권한별 소스 맵 구성
    var sourceMap = {};
    (m.permissions || []).forEach(function(p) {
        if (!sourceMap[p.permissionCode]) sourceMap[p.permissionCode] = { isDirect: false, groupSources: [] };
            if (p.permissionSource === 'DIRECT') {
                sourceMap[p.permissionCode].isDirect = true;
            } else {
                var label;
                if (p.permissionSource === 'CODE_DIRECT' || p.permissionSource === 'CODE_GROUP') {
                    label = MEMBER_LIST_MESSAGES.sourceCode + ' ' + (p.sourceGroupCode || p.permissionSource);
                } else {
                    label = MEMBER_LIST_MESSAGES.sourceGroup + ' ' + (p.sourceGroupCode || p.permissionSource);
                }
                if (label && !sourceMap[p.permissionCode].groupSources.includes(label))
                    sourceMap[p.permissionCode].groupSources.push(label);
        }
    });

    activeCodes = Object.keys(sourceMap).filter(function(code) { return sourceMap[code].isDirect; });

    var permHtml = policies.map(function(p) {
        var info = sourceMap[p.permissionCode];
        var hasGroup = info && info.groupSources.length > 0;
        var isDirect = info && info.isDirect;
        var sourceLabel = hasGroup ? info.groupSources.join(', ') : '';

        if (hasGroup && !isDirect) {
            // 그룹에서만 부여 → disabled
            return '<label class="sa-perm-item sa-perm-from-group">' +
                '<input type="checkbox" disabled checked>' +
                '<div class="sa-perm-info">' +
                '<span class="sa-perm-name">' + (p.displayName || '') + '</span>' +
                '<span class="sa-perm-code">' + (p.permissionCode || '') + '</span>' +
                (p.description ? '<span class="sa-perm-desc">' + p.description + '</span>' : '') +
                '</div>' +
                '<span class="sa-perm-source">' + sourceLabel + '</span>' +
                '</label>';
        } else {
            return '<label class="sa-perm-item">' +
                '<input type="checkbox" name="permissionCodes" value="' + p.permissionCode + '"' +
                (isDirect ? ' checked' : '') + '>' +
                '<div class="sa-perm-info">' +
                '<span class="sa-perm-name">' + (p.displayName || '') + '</span>' +
                '<span class="sa-perm-code">' + (p.permissionCode || '') + '</span>' +
                (p.description ? '<span class="sa-perm-desc">' + p.description + '</span>' : '') +
                '</div>' +
                (hasGroup ? '<span class="sa-perm-source">' + sourceLabel + ' + ' + MEMBER_LIST_MESSAGES.sourceDirect + '</span>' : '') +
                '</label>';
        }
    }).join('');

    var codeOptions = '<option value="">' + (m.adminPermissionCode ? MEMBER_LIST_MESSAGES.codeClearChange : MEMBER_LIST_MESSAGES.codeClear) + '</option>';
    allPermCodePolicies.forEach(function(cp) {
        var sel = (m.adminPermissionCode === cp.adminPermissionCode) ? ' selected' : '';
        codeOptions += '<option value="' + cp.adminPermissionCode + '"' + sel + '>' +
            cp.displayName + ' (' + cp.adminPermissionCode + ')' + '</option>';
    });

    document.getElementById('detailModalBody').innerHTML =
        '<div class="sa-detail-grid">' +
            '<div class="sa-detail-row"><span class="sa-detail-label">' + MEMBER_LIST_MESSAGES.fieldNickname + '</span><span>' + (m.nickname || '') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">' + MEMBER_LIST_MESSAGES.fieldUserId + '</span><span>' + (m.userId || '-') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">' + MEMBER_LIST_MESSAGES.fieldEmail + '</span><span>' + (m.userEmail || '-') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">' + MEMBER_LIST_MESSAGES.fieldTitle + '</span><span>' + (m.adminTitle || '-') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">' + MEMBER_LIST_MESSAGES.fieldOrganization + '</span><span>' + (m.adminOrganization || '-') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">' + MEMBER_LIST_MESSAGES.fieldDepartment + '</span><span>' + (m.adminDepartment || '-') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">' + MEMBER_LIST_MESSAGES.fieldTeam + '</span><span>' + (m.adminTeam || '-') + '</span></div>' +
        '</div>' +
        '<div class="sa-section-title" style="margin-top:16px;">' + MEMBER_LIST_MESSAGES.codeSection + '</div>' +
        '<div class="sa-perm-code-row">' +
            '<select class="adm-select sa-perm-code-select" id="permCodeSelect" style="flex:1;">' + codeOptions + '</select>' +
            '<button class="adm-btn adm-btn-primary" onclick="savePermissionCode(' + m.userIdx + ')">' + MEMBER_LIST_MESSAGES.codeSave + '</button>' +
        '</div>' +
        '<div style="font-size:12px;color:#94a3b8;margin-top:4px;margin-bottom:8px;">' + MEMBER_LIST_MESSAGES.codeHint + '</div>' +
        buildGroupAssignSection(adminGroups) +
        '<div class="sa-section-title" style="margin-top:16px;">' + MEMBER_LIST_MESSAGES.permissionSection + '</div>' +
        '<div style="font-size:12px;color:#94a3b8;margin-bottom:8px;">' + MEMBER_LIST_MESSAGES.permissionHint + '</div>' +
        '<div class="sa-perm-list">' + permHtml + '</div>';
}

/* ── 이력 로드 ── */
function savePermissionCode(userIdx) {
    var code = document.getElementById('permCodeSelect').value;
    var params = new URLSearchParams();
    if (code) params.append('permissionCode', code);
    fetch(CTX + '/superAdmin/members/' + userIdx + '/permission-code', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast(MEMBER_LIST_MESSAGES.permissionCodeSaved);
            reloadDetailModal();
        } else {
            adm_toast(data.message || MEMBER_LIST_MESSAGES.saveFailed, 'error');
        }
    });
}

function loadAuditLog() {
    if (!currentUserIdx) return;
    fetch(CTX + '/superAdmin/members/' + currentUserIdx + '/audit')
        .then(r => r.json())
        .then(data => {
            var html = '';

            // 그룹 배정 이력
            var gLogs = data.groupLogs || [];
            if (gLogs.length > 0) {
                var gRows = gLogs.map(function(l) {
                    var status = l.active
                        ? '<span class="sa-status-active">' + MEMBER_LIST_MESSAGES.auditStatusActive + '</span>'
                        : '<span class="sa-status-inactive">' + MEMBER_LIST_MESSAGES.auditStatusRevoked + '</span>';
                    var at = l.grantedAt ? new Date(l.grantedAt).toLocaleString('ko-KR') : '-';
                    return '<tr>' +
                        '<td><span class="sa-perm-code" style="background:#d1fae5;color:#065f46;border-radius:4px;padding:1px 6px;">' + (l.groupCode || '') + '</span></td>' +
                        '<td>' + (l.displayName || '-') + '</td>' +
                        '<td>' + status + '</td>' +
                        '<td>' + (l.grantedByNickname || '-') + '</td>' +
                        '<td style="font-size:12px;color:#94a3b8;">' + at + '</td>' +
                        '</tr>';
                }).join('');
                html += '<div class="sa-section-title" style="margin-bottom:8px;">' + MEMBER_LIST_MESSAGES.auditGroupTitle + '</div>' +
                    '<table class="sa-audit-table" style="margin-bottom:20px;">' +
                    '<thead><tr><th>' + MEMBER_LIST_MESSAGES.auditHeaderGroupCode + '</th><th>' + MEMBER_LIST_MESSAGES.auditHeaderGroupName + '</th><th>' + MEMBER_LIST_MESSAGES.auditHeaderStatus + '</th><th>' + MEMBER_LIST_MESSAGES.auditHeaderActor + '</th><th>' + MEMBER_LIST_MESSAGES.auditHeaderDate + '</th></tr></thead>' +
                    '<tbody>' + gRows + '</tbody></table>';
            }

            // 직접 권한 이력
            var pLogs = (data.logs || []).filter(function(l) { return l.grantedByNickname || l.active; });
            if (pLogs.length > 0) {
                var pRows = pLogs.map(function(l) {
                    var status = l.active
                        ? '<span class="sa-status-active">' + MEMBER_LIST_MESSAGES.auditStatusActive + '</span>'
                        : '<span class="sa-status-inactive">' + MEMBER_LIST_MESSAGES.auditStatusInactive + '</span>';
                    var grantedBy = l.grantedByNickname || '-';
                    var updatedAt = l.updatedAt ? new Date(l.updatedAt).toLocaleString('ko-KR') : '-';
                    return '<tr>' +
                        '<td><span class="sa-perm-code" style="background:#e0e7ff;color:#4338ca;border-radius:4px;padding:1px 6px;">' + (l.permissionCode || '') + '</span></td>' +
                        '<td>' + (l.displayName || '-') + '</td>' +
                        '<td>' + status + '</td>' +
                        '<td>' + grantedBy + '</td>' +
                        '<td style="font-size:12px;color:#94a3b8;">' + updatedAt + '</td>' +
                        '</tr>';
                }).join('');
                html += '<div class="sa-section-title" style="margin-bottom:8px;">' + MEMBER_LIST_MESSAGES.auditPermissionTitle + '</div>' +
                    '<table class="sa-audit-table">' +
                    '<thead><tr><th>' + MEMBER_LIST_MESSAGES.auditHeaderCode + '</th><th>' + MEMBER_LIST_MESSAGES.auditHeaderPermissionName + '</th><th>' + MEMBER_LIST_MESSAGES.auditHeaderStatus + '</th><th>' + MEMBER_LIST_MESSAGES.auditHeaderActor + '</th><th>' + MEMBER_LIST_MESSAGES.auditHeaderDate + '</th></tr></thead>' +
                    '<tbody>' + pRows + '</tbody></table>';
            }

            document.getElementById('auditBody').innerHTML = html ||
                '<div style="text-align:center;padding:40px;color:#94a3b8;">' + MEMBER_LIST_MESSAGES.auditEmpty + '</div>';
        });
}

/* ── 권한 저장 (직접) ── */
function savePermissions() {
    const checked = [...document.querySelectorAll('input[name="permissionCodes"]:checked')]
                        .map(el => el.value);
    const params = new URLSearchParams();
    checked.forEach(c => params.append('permissionCodes', c));

    fetch(CTX + '/superAdmin/members/' + currentUserIdx + '/permissions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(MEMBER_LIST_MESSAGES.permissionSaved); closeModal('detailModal'); location.reload(); }
        else adm_toast(data.message || MEMBER_LIST_MESSAGES.saveFailed, 'error');
    });
}

/* ── 관리자 해제 ── */
function revokeAdmin(userIdx, nickname) {
    if (!confirm(formatMemberListMessage(MEMBER_LIST_MESSAGES.confirmRevokeAdmin, nickname))) return;
    fetch(CTX + '/superAdmin/members/revoke', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'userIdx=' + userIdx
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(MEMBER_LIST_MESSAGES.revokeDone); location.reload(); }
        else adm_toast(data.message || MEMBER_LIST_MESSAGES.revokeFailed, 'error');
    });
}

/* ── 관리자 등록 모달 ── */
function openGrantModal() {
    document.getElementById('grantSearchResult').innerHTML = '';
    document.getElementById('grantSearchInput').value = '';
    document.getElementById('grantModal').classList.add('open');
    setTimeout(() => document.getElementById('grantSearchInput').focus(), 100);
}
document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('grantSearchInput').addEventListener('keydown', function (e) {
        if (e.key === 'Enter') searchUsers();
    });
});

function searchUsers() {
    const keyword = document.getElementById('grantSearchInput').value.trim();
    const resultEl = document.getElementById('grantSearchResult');
    if (!keyword) {
        resultEl.innerHTML = '<div style="color:#94a3b8;text-align:center;padding:20px;">' + MEMBER_LIST_MESSAGES.grantSearchRequired + '</div>';
        return;
    }
    resultEl.innerHTML = '<div style="text-align:center;padding:20px;color:#94a3b8;">' + MEMBER_LIST_MESSAGES.grantSearching + '</div>';
    fetch(CTX + '/superAdmin/users/search?keyword=' + encodeURIComponent(keyword) + '&pageSize=20')
        .then(r => {
            if (!r.ok) throw new Error('HTTP ' + r.status);
            return r.json();
        })
        .then(data => {
            if (!data.users || data.users.length === 0) {
                resultEl.innerHTML = '<div style="color:#94a3b8;text-align:center;padding:20px;">' + MEMBER_LIST_MESSAGES.grantEmpty + '</div>';
                return;
            }
            resultEl.innerHTML = data.users.map(function(u) {
                return '<div class="sa-user-row">' +
                    '<div>' +
                        '<div style="font-weight:600;">' + (u.nickname || '') + '</div>' +
                        '<div style="font-size:12px;color:#94a3b8;">' + (u.userId || '') + ' · ' + (u.userEmail || '') + '</div>' +
                    '</div>' +
                    '<button class="adm-btn adm-btn-sm adm-btn-primary"' +
                        ' data-id="' + u.userIdx + '"' +
                        ' data-nickname="' + (u.nickname || '') + '"' +
                        ' onclick="grantAdmin(this.getAttribute(\'data-id\'), this.getAttribute(\'data-nickname\'))">' + MEMBER_LIST_MESSAGES.grantButton + '</button>' +
                '</div>';
            }).join('');
        })
        .catch(err => {
            resultEl.innerHTML = '<div style="color:#ef4444;text-align:center;padding:20px;">' + MEMBER_LIST_MESSAGES.grantErrorPrefix + ' ' + err.message + '</div>';
        });
}

function grantAdmin(userIdx, nickname) {
    if (!confirm(formatMemberListMessage(MEMBER_LIST_MESSAGES.confirmGrantAdmin, nickname))) return;
    fetch(CTX + '/superAdmin/members/grant', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'userIdx=' + userIdx
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(MEMBER_LIST_MESSAGES.grantDone); closeModal('grantModal'); location.reload(); }
        else adm_toast(data.message || MEMBER_LIST_MESSAGES.grantFailed, 'error');
    });
}

/* ── 일괄 처리 ── */
function toggleAll(cb) {
    document.querySelectorAll('.row-cb').forEach(el => el.checked = cb.checked);
    onRowCbChange();
}

function onRowCbChange() {
    const checked = document.querySelectorAll('.row-cb:checked');
    const bar     = document.getElementById('bulkBar');
    document.getElementById('cbAll').checked = (checked.length > 0 && checked.length === document.querySelectorAll('.row-cb').length);
    if (checked.length > 0) {
        document.getElementById('bulkCount').textContent = checked.length;
        document.getElementById('bulkCountLabel').textContent = formatMemberListMessage(MEMBER_LIST_MESSAGES.bulkSelectedFormat, checked.length);
        bar.classList.remove('sa-bulk-hidden');
    } else {
        bar.classList.add('sa-bulk-hidden');
    }
}

function clearSelection() {
    document.querySelectorAll('.row-cb').forEach(el => el.checked = false);
    document.getElementById('cbAll').checked = false;
    document.getElementById('bulkBar').classList.add('sa-bulk-hidden');
}

function getSelectedIdxList() {
    return [...document.querySelectorAll('.row-cb:checked')].map(el => el.getAttribute('data-idx'));
}

function bulkRevoke() {
    const list = getSelectedIdxList();
    if (list.length === 0) return;
    if (!confirm(formatMemberListMessage(MEMBER_LIST_MESSAGES.confirmBulkRevoke, list.length))) return;

    const params = new URLSearchParams();
    list.forEach(idx => params.append('userIdxList', idx));

    fetch(CTX + '/superAdmin/members/bulk-revoke', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(formatMemberListMessage(MEMBER_LIST_MESSAGES.bulkRevokeDone, list.length)); location.reload(); }
        else adm_toast(data.message || MEMBER_LIST_MESSAGES.revokeFailed, 'error');
    });
}

function openBulkPermModal() {
    const list = getSelectedIdxList();
    if (list.length === 0) return;
    var permHtml = allPolicies.length > 0
        ? allPolicies.map(function(p) {
            return '<label class="sa-perm-item">' +
                '<input type="checkbox" name="bulkPermCodes" value="' + p.permissionCode + '">' +
                '<div class="sa-perm-info">' +
                '<span class="sa-perm-name">' + (p.displayName || '') + '</span>' +
                '<span class="sa-perm-code">' + (p.permissionCode || '') + '</span>' +
                (p.description ? '<span class="sa-perm-desc">' + p.description + '</span>' : '') +
                '</div>' +
                '</label>';
          }).join('')
        : '<div style="color:#94a3b8;text-align:center;padding:20px;">' + MEMBER_LIST_MESSAGES.bulkEmptyPolicies + '</div>';

    // allPolicies가 비어있으면 서버에서 불러오기
    if (allPolicies.length === 0) {
        fetch(CTX + '/superAdmin/members/1') // 임시 any user call to get policies
            .then(r => r.json())
            .then(data => {
                allPolicies = data.permissionPolicies || [];
                openBulkPermModal();
            });
        return;
    }
    document.getElementById('bulkPermList').innerHTML = buildGroupSelect() + '<div class="sa-perm-list">' + permHtml + '</div>';
    document.getElementById('bulkPermModal').classList.add('open');
}

function saveBulkPermissions() {
    const userIdxList = getSelectedIdxList();
    const codes = [...document.querySelectorAll('input[name="bulkPermCodes"]:checked')].map(el => el.value);
    const params = new URLSearchParams();
    userIdxList.forEach(idx => params.append('userIdxList', idx));
    codes.forEach(c => params.append('permissionCodes', c));

    fetch(CTX + '/superAdmin/members/bulk-permissions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(formatMemberListMessage(MEMBER_LIST_MESSAGES.bulkUpdateDone, userIdxList.length)); closeModal('bulkPermModal'); clearSelection(); location.reload(); }
        else adm_toast(data.message || MEMBER_LIST_MESSAGES.saveFailed, 'error');
    });
}

function closeModal(id) {
    document.getElementById(id).classList.remove('open');
}
</script>


<%@ include file="../layout-close.jsp" %>
