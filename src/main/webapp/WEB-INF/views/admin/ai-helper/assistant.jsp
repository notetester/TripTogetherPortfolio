<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_aiHelper_assistant_searchPlaceholder" code="admin.aiHelper.assistant.searchPlaceholder"/>
<spring:message var="msg_admin_aiHelper_assistant_modal_title_js" code="admin.aiHelper.assistant.modal.title" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_role_user_js" code="admin.aiHelper.assistant.role.user" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_role_ai_js" code="admin.aiHelper.assistant.role.ai" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_empty_messages_js" code="admin.aiHelper.assistant.empty.messages" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_message_viewFailed_js" code="admin.aiHelper.assistant.message.viewFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_message_viewError_js" code="admin.aiHelper.assistant.message.viewError" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_message_deleteConfirm_js" code="admin.aiHelper.assistant.message.deleteConfirm" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_message_deleteDone_js" code="admin.aiHelper.assistant.message.deleteDone" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_message_deleteFailed_js" code="admin.aiHelper.assistant.message.deleteFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_message_deleteError_js" code="admin.aiHelper.assistant.message.deleteError" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_table_session_js" code="admin.aiHelper.assistant.table.session" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_blockIpPlaceholder" code="admin.context.action.blockIpPlaceholder"/>
<spring:message var="msg_admin_context_action_reasonPlaceholder" code="admin.context.action.reasonPlaceholder"/>
<spring:message var="msg_admin_common_loading_js" code="admin.common.loading" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_close_js" code="admin.common.close" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_error_js" code="admin.common.error" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_yes_js" code="admin.common.yes" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_no_js" code="admin.common.no" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_none_js" code="admin.members.none" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_noLinkedProvider_js" code="admin.members.noLinkedProvider" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_verifiedMember_js" code="admin.members.verifiedMember" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_unverifiedMember_js" code="admin.members.unverifiedMember" javaScriptEscape="true"/>
<spring:message var="msg_admin_status_ACTIVE_js" code="admin.status.ACTIVE" javaScriptEscape="true"/>
<spring:message var="msg_admin_status_DORMANT_js" code="admin.status.DORMANT" javaScriptEscape="true"/>
<spring:message var="msg_admin_status_BLOCKED_js" code="admin.status.BLOCKED" javaScriptEscape="true"/>
<spring:message var="msg_admin_status_DELETED_js" code="admin.status.DELETED" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_blockModalTitleSuffix_js" code="admin.members.blockModalTitleSuffix" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_blockResponseParseError_js" code="admin.members.blockResponseParseError" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_statusResponseParseError_js" code="admin.members.statusResponseParseError" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_roleResponseParseError_js" code="admin.members.roleResponseParseError" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_blockTargetMissing_js" code="admin.members.blockTargetMissing" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_applying_js" code="admin.common.applying" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_toast_saveBlockSuccess_js" code="admin.context.toast.saveBlockSuccess" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_memberTitle_js" code="admin.context.memberTitle" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_detailTitleSuffix_js" code="admin.members.detailTitleSuffix" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_info_js" code="admin.context.tab.info" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_logins_js" code="admin.context.tab.logins" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_security_js" code="admin.context.tab.security" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_emailHistoryTab_js" code="admin.members.emailHistoryTab" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_activity_js" code="admin.context.tab.activity" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_blocks_js" code="admin.context.tab.blocks" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_actions_js" code="admin.context.tab.actions" javaScriptEscape="true"/>
<spring:message var="msg_admin_role_USER_js" code="admin.role.USER" javaScriptEscape="true"/>
<spring:message var="msg_admin_role_BUSINESS_js" code="admin.role.BUSINESS" javaScriptEscape="true"/>
<spring:message var="msg_admin_role_PARTNER_js" code="admin.role.PARTNER" javaScriptEscape="true"/>
<spring:message var="msg_admin_role_BOT_js" code="admin.role.BOT" javaScriptEscape="true"/>
<spring:message var="msg_admin_role_ADMIN_js" code="admin.role.ADMIN" javaScriptEscape="true"/>
<spring:message var="msg_admin_role_SUPERADMIN_js" code="admin.role.SUPERADMIN" javaScriptEscape="true"/>
<spring:message var="msg_admin_role_SYSTEM_js" code="admin.role.SYSTEM" javaScriptEscape="true"/>
<spring:message var="msg_admin_social_kakao_js" code="admin.social.kakao" javaScriptEscape="true"/>
<spring:message var="msg_admin_social_naver_js" code="admin.social.naver" javaScriptEscape="true"/>
<spring:message var="msg_admin_social_google_js" code="admin.social.google" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_requireBlockedIp_js" code="admin.context.requireBlockedIp" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_toast_saveBlockFail_js" code="admin.context.toast.saveBlockFail" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_toast_saveBlockError_js" code="admin.context.toast.saveBlockError" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_confirmStatusChangePrefix_js" code="admin.members.confirmStatusChangePrefix" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_confirmStatusChangeSuffix_js" code="admin.members.confirmStatusChangeSuffix" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_toast_saveStatusSuccess_js" code="admin.context.toast.saveStatusSuccess" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_toast_saveStatusFail_js" code="admin.context.toast.saveStatusFail" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_roleContextMissing_js" code="admin.members.roleContextMissing" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_roleAlreadySelected_js" code="admin.members.roleAlreadySelected" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_requireRoleReason_js" code="admin.context.requireRoleReason" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_confirmRoleChangeSuffix_js" code="admin.members.confirmRoleChangeSuffix" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_toast_saveRoleSuccess_js" code="admin.context.toast.saveRoleSuccess" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_toast_saveRoleFail_js" code="admin.context.toast.saveRoleFail" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_inputValue_js" code="admin.context.inputValue" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_targetEmail_js" code="admin.context.targetEmail" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_empty_security_js" code="admin.context.empty.security" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_requestEmail_js" code="admin.context.requestEmail" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_empty_emailRequests_js" code="admin.context.empty.emailRequests" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_used_js" code="admin.context.used" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_unused_js" code="admin.context.unused" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_empty_emailTokens_js" code="admin.context.empty.emailTokens" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_uri_js" code="admin.context.uri" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_empty_activity_js" code="admin.context.empty.activity" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_reason_js" code="admin.common.reason" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_empty_blocks_js" code="admin.context.empty.blocks" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_profileTitle_js" code="admin.context.action.profileTitle" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_nickname_js" code="admin.context.nickname" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_nationality_js" code="admin.context.nationality" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_preferredLanguage_js" code="admin.context.preferredLanguage" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_saveProfile_js" code="admin.context.action.saveProfile" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_statusRoleTitle_js" code="admin.context.action.statusRoleTitle" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_accountStatus_js" code="admin.members.accountStatus" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_apply_js" code="admin.common.apply" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_role_js" code="admin.common.role" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_roleReason_js" code="admin.context.action.roleReason" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_roleReasonPlaceholder_js" code="admin.context.action.roleReasonPlaceholder" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_changeRole_js" code="admin.context.action.changeRole" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_quickBlockTitle_js" code="admin.context.action.quickBlockTitle" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_blockType_js" code="admin.context.action.blockType" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_blockType_userOnly_js" code="admin.context.blockType.userOnly" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_blockType_ipOnly_js" code="admin.context.blockType.ipOnly" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_blockType_userIp_js" code="admin.context.blockType.userIp" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_blockedIp_js" code="admin.context.blockedIp" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_blockIpPlaceholder_js" code="admin.context.action.blockIpPlaceholder" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_blockExpires_js" code="admin.context.action.blockExpires" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_action_applyBlock_js" code="admin.context.action.applyBlock" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_emailRequests_js" code="admin.context.tab.emailRequests" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_emailTokens_js" code="admin.context.tab.emailTokens" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_memberNo_js" code="admin.context.memberNo" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_userId_js" code="admin.context.userId" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_email_js" code="admin.context.email" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_emailVerified_js" code="admin.members.emailVerified" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_emailLoginEnabled_js" code="admin.members.emailLoginEnabled" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_passwordLoginEnabled_js" code="admin.members.passwordLoginEnabled" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_createdAt_js" code="admin.context.createdAt" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_socialLinked_js" code="admin.members.socialLinked" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_loginSuccess_js" code="admin.members.loginSuccess" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_loginFailure_js" code="admin.members.loginFailure" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_lastLogin_js" code="admin.context.lastLogin" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_empty_logins_js" code="admin.context.empty.logins" javaScriptEscape="true"/>
<spring:message var="msg_admin_logs_success_js" code="admin.logs.success" javaScriptEscape="true"/>
<spring:message var="msg_admin_logs_failure_js" code="admin.logs.failure" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_time_js" code="admin.common.time" javaScriptEscape="true"/>
<spring:message var="msg_admin_logs_provider_js" code="admin.logs.provider" javaScriptEscape="true"/>
<spring:message var="msg_admin_logs_failReason_js" code="admin.logs.failReason" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_ip_js" code="admin.common.ip" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_toast_saveProfileSuccess_js" code="admin.context.toast.saveProfileSuccess" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_toast_saveProfileFail_js" code="admin.context.toast.saveProfileFail" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_toast_saveProfileError_js" code="admin.context.toast.saveProfileError" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_pageTitle" code="admin.aiHelper.assistant.pageTitle"/>
<spring:message var="msg_admin_aiHelper_assistant_tab_dashboard" code="admin.aiHelper.assistant.tab.dashboard"/>
<spring:message var="msg_admin_aiHelper_assistant_tab_messages" code="admin.aiHelper.assistant.tab.messages"/>
<spring:message var="msg_admin_aiHelper_assistant_kpi_totalSessions" code="admin.aiHelper.assistant.kpi.totalSessions"/>
<spring:message var="msg_admin_aiHelper_assistant_kpi_totalMessages" code="admin.aiHelper.assistant.kpi.totalMessages"/>
<spring:message var="msg_admin_aiHelper_assistant_kpi_todaySessions" code="admin.aiHelper.assistant.kpi.todaySessions"/>
<spring:message var="msg_admin_aiHelper_assistant_kpi_uniqueUsers" code="admin.aiHelper.assistant.kpi.uniqueUsers"/>
<spring:message var="msg_admin_aiHelper_assistant_section_sessions" code="admin.aiHelper.assistant.section.sessions"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCountFormat" code="admin.common.totalCountFormat"/>
<spring:message var="msg_admin_aiHelper_assistant_table_sessionId" code="admin.aiHelper.assistant.table.sessionId"/>
<spring:message var="msg_admin_aiHelper_assistant_table_title" code="admin.aiHelper.assistant.table.title"/>
<spring:message var="msg_admin_aiHelper_assistant_table_user" code="admin.aiHelper.assistant.table.user"/>
<spring:message var="msg_admin_aiHelper_assistant_table_messageCount" code="admin.aiHelper.assistant.table.messageCount"/>
<spring:message var="msg_admin_aiHelper_assistant_table_createdAt" code="admin.aiHelper.assistant.table.createdAt"/>
<spring:message var="msg_admin_aiHelper_assistant_table_lastActive" code="admin.aiHelper.assistant.table.lastActive"/>
<spring:message var="msg_admin_aiHelper_assistant_table_actions" code="admin.aiHelper.assistant.table.actions"/>
<spring:message var="msg_admin_aiHelper_assistant_action_delete" code="admin.aiHelper.assistant.action.delete"/>
<spring:message var="msg_admin_aiHelper_assistant_empty_sessions" code="admin.aiHelper.assistant.empty.sessions"/>
<spring:message var="msg_admin_aiHelper_assistant_userPrefix" code="admin.aiHelper.assistant.userPrefix"/>
<spring:message var="msg_admin_aiHelper_assistant_userDeleted" code="admin.aiHelper.assistant.userDeleted"/>
<spring:message var="msg_admin_aiHelper_assistant_action_view" code="admin.aiHelper.assistant.action.view"/>
<spring:message var="msg_admin_aiHelper_assistant_messagesDescription" code="admin.aiHelper.assistant.messagesDescription"/>
<spring:message var="msg_admin_aiHelper_assistant_table_id" code="admin.aiHelper.assistant.table.id"/>
<spring:message var="msg_admin_aiHelper_assistant_table_session" code="admin.aiHelper.assistant.table.session"/>
<spring:message var="msg_admin_aiHelper_assistant_table_role" code="admin.aiHelper.assistant.table.role"/>
<spring:message var="msg_admin_aiHelper_assistant_table_content" code="admin.aiHelper.assistant.table.content"/>
<spring:message var="msg_admin_common_time" code="admin.common.time"/>
<spring:message var="msg_admin_aiHelper_assistant_empty_messages" code="admin.aiHelper.assistant.empty.messages"/>
<spring:message var="msg_admin_aiHelper_assistant_role_user" code="admin.aiHelper.assistant.role.user"/>
<spring:message var="msg_admin_aiHelper_assistant_role_ai" code="admin.aiHelper.assistant.role.ai"/>
<spring:message var="msg_admin_aiHelper_assistant_action_viewSession" code="admin.aiHelper.assistant.action.viewSession"/>
<spring:message var="msg_admin_aiHelper_assistant_modal_title" code="admin.aiHelper.assistant.modal.title"/>
<spring:message var="msg_admin_common_close" code="admin.common.close"/>
<spring:message var="msg_admin_context_memberTitle" code="admin.context.memberTitle"/>
<spring:message var="msg_admin_common_loading" code="admin.common.loading"/>
<spring:message var="msg_admin_members_blockModalTitle" code="admin.members.blockModalTitle"/>
<spring:message var="msg_admin_context_action_blockType" code="admin.context.action.blockType"/>
<spring:message var="msg_admin_context_blockType_userOnly" code="admin.context.blockType.userOnly"/>
<spring:message var="msg_admin_context_blockType_ipOnly" code="admin.context.blockType.ipOnly"/>
<spring:message var="msg_admin_context_blockType_userIp" code="admin.context.blockType.userIp"/>
<spring:message var="msg_admin_members_blockedIpLabel" code="admin.members.blockedIpLabel"/>
<spring:message var="msg_admin_members_blockExpiresLabel" code="admin.members.blockExpiresLabel"/>
<spring:message var="msg_admin_members_blockReasonLabel" code="admin.members.blockReasonLabel"/>
<spring:message var="msg_admin_context_action_applyBlock" code="admin.context.action.applyBlock"/>
<c:set var="pageTitle" value="${msg_admin_aiHelper_assistant_pageTitle}"/>
<c:set var="activeMenu" value="aiHelper"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-ai-page adm-ai-assistant-page">
    <c:set var="aiListTotal" value="${empty total ? 0 : total}"/>
    <spring:message var="msg_admin_ai_listTotalCountDisplay" code="admin.common.totalCountFormat" arguments="${aiListTotal}"/>
    <spring:message var="msg_admin_ai_blocksTotalCountDisplay" code="admin.common.totalCountFormat" arguments="${fn:length(blocks)}"/>
    <spring:message var="msg_admin_ai_quotasTotalCountDisplay" code="admin.common.totalCountFormat" arguments="${fn:length(quotas)}"/>

    <%-- ── 도우미 내부 sub-tab ── --%>
    <div class="adm-ai-tabs">
        <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=dashboard"
           class="adm-ai-tab ${tab == 'dashboard' ? 'active' : ''}">
            ${msg_admin_aiHelper_assistant_tab_dashboard}
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=messages"
           class="adm-ai-tab ${tab == 'messages' ? 'active' : ''}">
            ${msg_admin_aiHelper_assistant_tab_messages}
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=inappropriate"
           class="adm-ai-tab ${tab == 'inappropriate' ? 'active' : ''}">
            부적절 메시지
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=blocks"
           class="adm-ai-tab ${tab == 'blocks' ? 'active' : ''}">
            차단 관리
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=quotas"
           class="adm-ai-tab ${tab == 'quotas' ? 'active' : ''}">
            한도 정책
        </a>
    </div>

    <%-- ══════════════════════════════════════════
         대시보드 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'dashboard'}">
        <div class="adm-ai-kpi-grid">
            <div class="adm-card adm-ai-kpi-card">
                <div class="adm-ai-kpi-label">🧭 ${msg_admin_aiHelper_assistant_kpi_totalSessions}</div>
                <div class="adm-ai-kpi-value is-sky">${stats.totalSessions}</div>
            </div>
            <div class="adm-card adm-ai-kpi-card">
                <div class="adm-ai-kpi-label">💬 ${msg_admin_aiHelper_assistant_kpi_totalMessages}</div>
                <div class="adm-ai-kpi-value is-blue">${stats.totalMessages}</div>
            </div>
            <div class="adm-card adm-ai-kpi-card">
                <div class="adm-ai-kpi-label">📅 ${msg_admin_aiHelper_assistant_kpi_todaySessions}</div>
                <div class="adm-ai-kpi-value is-green">${stats.todaySessions}</div>
            </div>
            <div class="adm-card adm-ai-kpi-card">
                <div class="adm-ai-kpi-label">👤 ${msg_admin_aiHelper_assistant_kpi_uniqueUsers}</div>
                <div class="adm-ai-kpi-value is-purple">${stats.uniqueUsers}</div>
            </div>
        </div>

        <div class="adm-card adm-ai-filter-card">
            <form method="get" action="${pageContext.request.contextPath}/admin/ai-helper" class="adm-ai-search-form">
                <input type="hidden" name="tab" value="dashboard"/>
                <input type="text" name="keyword" value="${keyword}" placeholder="${msg_admin_aiHelper_assistant_searchPlaceholder}" class="adm-input adm-ai-search-input"/>
                <button type="submit" class="adm-btn adm-btn-primary">${msg_admin_common_search}</button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper" class="adm-btn adm-btn-ghost">${msg_admin_common_reset}</a>
                </c:if>
            </form>
        </div>

        <div class="adm-card adm-ai-table-card">
            <div class="adm-card-head adm-ai-list-head">
                <div class="adm-card-title">
                    ${msg_admin_aiHelper_assistant_section_sessions}
                    <span class="adm-section-total-inline">${msg_admin_ai_listTotalCountDisplay}</span>
                </div>
            </div>
            <div class="adm-table-wrap">
            <table class="adm-table adm-ai-table adm-ai-sessions-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-ai-col-id"/>
                    <col class="adm-ai-col-title"/>
                    <col class="adm-ai-col-user"/>
                    <col class="adm-ai-col-count"/>
                    <col class="adm-ai-col-date"/>
                    <col class="adm-ai-col-date"/>
                    <col class="adm-ai-col-actions"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>${msg_admin_aiHelper_assistant_table_sessionId}</th>
                        <th>${msg_admin_aiHelper_assistant_table_title}</th>
                        <th>${msg_admin_aiHelper_assistant_table_user}</th>
                        <th>${msg_admin_aiHelper_assistant_table_messageCount}</th>
                        <th>${msg_admin_aiHelper_assistant_table_createdAt}</th>
                        <th>${msg_admin_aiHelper_assistant_table_lastActive}</th>
                        <th>${msg_admin_aiHelper_assistant_table_actions}</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty sessions}">
                            <tr><td colspan="7" class="adm-local-empty-cell">${msg_admin_aiHelper_assistant_empty_sessions}</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="s" items="${sessions}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${s.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">#${s.chatPostIdx}</button>
                                    </td>
                                    <td class="adm-ai-break-cell">
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${s.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">${s.title}</button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.nickname != null}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${s.userIdx}">
                                                    ${s.nickname} <span class="adm-ai-muted">(#${s.userIdx})</span>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="adm-ai-muted">${msg_admin_aiHelper_assistant_userPrefix} #${s.userIdx} (${msg_admin_aiHelper_assistant_userDeleted})</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${s.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">${s.messageCount}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${s.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)"><fmt:formatDate value="${s.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.lastMessageAt != null}">
                                                <button type="button"
                                                        class="adm-cell-link adm-cell-link--inline"
                                                        data-session-id="${s.chatPostIdx}"
                                                        onclick="viewAssistantMessages(this.dataset.sessionId)"><fmt:formatDate value="${s.lastMessageAt}" pattern="yyyy-MM-dd HH:mm"/></button>
                                            </c:when>
                                            <c:otherwise><span class="adm-ai-muted">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="adm-ai-action-cell">
                                        <div class="adm-row-actions">
                                            <button type="button"
                                                    class="adm-row-btn detail"
                                                    data-session-id="${s.chatPostIdx}"
                                                    onclick="viewAssistantMessages(this.dataset.sessionId)">${msg_admin_aiHelper_assistant_action_view}</button>
                                            <div class="action-menu-wrap">
                                                <button type="button"
                                                        class="adm-row-btn detail adm-row-btn-more"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu">
                                                    <button type="button"
                                                            class="action-menu-item danger"
                                                            data-session-id="${s.chatPostIdx}"
                                                            onclick="deleteAssistantSession(this.dataset.sessionId)">${msg_admin_aiHelper_assistant_action_delete}</button>
                                                </div>
                                            </div>
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

        <c:if test="${totalPages > 1}">
            <div class="adm-ai-pagination">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=dashboard&page=${p}&keyword=${keyword}"
                       class="adm-btn adm-ai-page-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}">${p}</a>
                </c:forEach>
            </div>
        </c:if>

    </c:if>

    <%-- ══════════════════════════════════════════
         메시지 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'messages'}">
        <div class="adm-card adm-ai-info-card">
            <div class="adm-ai-description">
                ${msg_admin_aiHelper_assistant_messagesDescription}
            </div>
        </div>

        <div class="adm-card adm-ai-table-card">
            <div class="adm-card-head adm-ai-list-head">
                <div class="adm-card-title">
                    ${msg_admin_aiHelper_assistant_tab_messages}
                    <span class="adm-section-total-inline">${msg_admin_ai_listTotalCountDisplay}</span>
                </div>
            </div>
            <div class="adm-table-wrap">
            <table class="adm-table adm-ai-table adm-ai-messages-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-ai-col-id"/>
                    <col class="adm-ai-col-session"/>
                    <col class="adm-ai-col-role"/>
                    <col class="adm-ai-col-user"/>
                    <col class="adm-ai-col-content"/>
                    <col class="adm-ai-col-date"/>
                    <col class="adm-ai-col-actions"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>${msg_admin_aiHelper_assistant_table_id}</th>
                        <th>${msg_admin_aiHelper_assistant_table_session}</th>
                        <th>${msg_admin_aiHelper_assistant_table_role}</th>
                        <th>${msg_admin_aiHelper_assistant_table_user}</th>
                        <th>${msg_admin_aiHelper_assistant_table_content}</th>
                        <th>${msg_admin_common_time}</th>
                        <th>${msg_admin_aiHelper_assistant_table_actions}</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty messages}">
                            <tr><td colspan="7" class="adm-local-empty-cell">${msg_admin_aiHelper_assistant_empty_messages}</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${messages}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${m.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">#${m.chatCommentIdx}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link"
                                                data-session-id="${m.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">
                                            <span>#${m.chatPostIdx}</span>
                                            <span class="adm-ai-subtext">${fn:escapeXml(m.sessionTitle)}</span>
                                        </button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.commentRole == 'USER'}">
                                                <span class="adm-ai-role-badge is-user">${msg_admin_aiHelper_assistant_role_user}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="adm-ai-role-badge is-ai">${msg_admin_aiHelper_assistant_role_ai}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.nickname != null}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${m.userIdx}">
                                                    ${m.nickname}
                                                </button>
                                            </c:when>
                                            <c:otherwise><span class="adm-ai-muted">${msg_admin_aiHelper_assistant_userPrefix} #${m.userIdx}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="adm-ai-ellipsis-cell">
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${m.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">
                                        <c:choose>
                                            <c:when test="${fn:length(m.content) > 200}">
                                                ${fn:escapeXml(fn:substring(m.content, 0, 200))}…
                                            </c:when>
                                            <c:otherwise>${fn:escapeXml(m.content)}</c:otherwise>
                                        </c:choose>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${m.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)"><fmt:formatDate value="${m.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></button>
                                    </td>
                                    <td class="adm-ai-action-cell">
                                        <div class="adm-row-actions is-single">
                                            <button type="button"
                                                    class="adm-row-btn detail"
                                                    data-session-id="${m.chatPostIdx}"
                                                    onclick="viewAssistantMessages(this.dataset.sessionId)">${msg_admin_aiHelper_assistant_action_viewSession}</button>
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

        <c:if test="${totalPages > 1}">
            <div class="adm-ai-pagination">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=messages&page=${p}"
                       class="adm-btn adm-ai-page-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}">${p}</a>
                </c:forEach>
            </div>
        </c:if>
    </c:if>

    <%-- ══════════════════════════════════════════
         부적절 메시지 탭
         스케줄러가 5분 주기로 Perspective API 호출하여 저장한 결과를 표시
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'inappropriate'}">
        <div class="adm-card adm-ai-table-card">
            <div class="adm-card-head adm-ai-list-head">
                <div class="adm-card-title">
                    부적절 메시지
                    <span class="adm-section-total-inline">${msg_admin_ai_listTotalCountDisplay}</span>
                </div>
            </div>
            <div class="adm-table-wrap">
            <table class="adm-table adm-ai-table adm-ai-moderation-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-ai-col-id"/>
                    <col class="adm-ai-col-session"/>
                    <col class="adm-ai-col-user"/>
                    <col class="adm-ai-col-content"/>
                    <col class="adm-ai-col-score"/>
                    <col class="adm-ai-col-date"/>
                    <col class="adm-ai-col-actions"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>판정 ID</th>
                        <th>세션</th>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>점수</th>
                        <th>판정시각</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty messages}">
                            <tr><td colspan="7" class="adm-local-empty-cell">부적절 판정된 메시지가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${messages}">
                                <tr>
                                    <td>${m.moderationId}</td>
                                    <td>#${m.chatPostIdx}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.nickname != null}">${m.nickname} <span class="adm-ai-muted">(#${m.userIdx})</span></c:when>
                                            <c:otherwise><span class="adm-ai-muted">#${m.userIdx}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="adm-ai-ellipsis-cell">
                                        <c:choose>
                                            <c:when test="${fn:length(m.content) > 200}">${fn:escapeXml(fn:substring(m.content, 0, 200))}…</c:when>
                                            <c:otherwise>${fn:escapeXml(m.content)}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.toxicityScore != null}">
                                                <span class="adm-ai-score">${m.toxicityScore}</span>
                                            </c:when>
                                            <c:otherwise><span class="adm-ai-muted">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatDate value="${m.checkedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td class="adm-ai-action-cell">
                                        <div class="adm-row-actions is-single">
                                            <button type="button" class="adm-row-btn detail" data-session-id="${m.chatPostIdx}" onclick="viewAssistantMessages(this.dataset.sessionId)">세션 보기</button>
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

        <c:if test="${totalPages > 1}">
            <div class="adm-ai-pagination">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=inappropriate&page=${p}"
                       class="adm-btn adm-ai-page-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}">${p}</a>
                </c:forEach>
            </div>
        </c:if>
    </c:if>

    <%-- ══════════════════════════════════════════
         차단 관리 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'blocks'}">
        <%-- 차단 등록 폼 --%>
        <div class="adm-card adm-ai-form-card">
            <div class="adm-ai-section-title">차단 등록</div>
            <div class="adm-ai-block-form">
                <div class="adm-ai-form-field is-type">
                    <label class="adm-filter-label" for="blkType">유형</label>
                    <select id="blkType" class="adm-select">
                        <option value="USER">USER</option>
                        <option value="IP">IP</option>
                    </select>
                </div>
                <div class="adm-ai-form-field">
                    <label class="adm-filter-label" for="blkValue">값 (user_idx 또는 IP)</label>
                    <input type="text" id="blkValue" class="adm-input" placeholder="예: 6 / 192.168.0.1">
                </div>
                <div class="adm-ai-form-field is-wide">
                    <label class="adm-filter-label" for="blkReason">사유</label>
                    <input type="text" id="blkReason" class="adm-input" placeholder="선택">
                </div>
                <div class="adm-ai-form-field">
                    <label class="adm-filter-label" for="blkExpires">만료(선택, YYYY-MM-DD HH:mm)</label>
                    <input type="text" id="blkExpires" class="adm-input" placeholder="비우면 영구">
                </div>
                <button type="button" class="adm-btn adm-btn-primary" onclick="createAssistantBlock()">등록</button>
            </div>
        </div>

        <div class="adm-card adm-ai-table-card">
            <div class="adm-card-head adm-ai-list-head">
                <div class="adm-card-title">
                    차단 기록
                    <span class="adm-section-total-inline">${msg_admin_ai_blocksTotalCountDisplay}</span>
                </div>
            </div>
            <div class="adm-table-wrap">
            <table class="adm-table adm-ai-table adm-ai-blocks-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-ai-col-id"/>
                    <col class="adm-ai-col-type"/>
                    <col class="adm-ai-col-value"/>
                    <col class="adm-ai-col-user"/>
                    <col class="adm-ai-col-reason"/>
                    <col class="adm-ai-col-date"/>
                    <col class="adm-ai-col-date"/>
                    <col class="adm-ai-col-status"/>
                    <col class="adm-ai-col-user"/>
                    <col class="adm-ai-col-actions-narrow"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>유형</th>
                        <th>값</th>
                        <th>대상 닉네임</th>
                        <th>사유</th>
                        <th>차단일</th>
                        <th>만료</th>
                        <th>상태</th>
                        <th>처리자</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty blocks}">
                            <tr><td colspan="10" class="adm-local-empty-cell">차단 기록이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${blocks}">
                                <tr>
                                    <td>${b.blockId}</td>
                                    <td>
                                        <span class="adm-ai-type-badge ${b.blockType == 'USER' ? 'is-user' : 'is-ip'}">${b.blockType}</span>
                                    </td>
                                    <td>${b.blockValue}</td>
                                    <td><c:if test="${b.targetNickname != null}">${b.targetNickname}</c:if></td>
                                    <td class="adm-ai-break-cell">${fn:escapeXml(b.reason)}</td>
                                    <td><fmt:formatDate value="${b.blockedAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.expiresAt != null}"><fmt:formatDate value="${b.expiresAtDate}" pattern="yyyy-MM-dd HH:mm"/></c:when>
                                            <c:otherwise><span class="adm-ai-muted">영구</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.isActive}"><span class="adm-ai-state is-active">활성</span></c:when>
                                            <c:otherwise><span class="adm-ai-muted">해제</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><c:if test="${b.blockedByNickname != null}">${b.blockedByNickname}</c:if></td>
                                    <td class="adm-ai-action-cell">
                                        <c:if test="${b.isActive}">
                                            <button type="button" class="adm-row-btn danger" data-block-id="${b.blockId}" onclick="deactivateAssistantBlock(this.dataset.blockId)">해제</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            </div>
        </div>
    </c:if>

    <%-- ══════════════════════════════════════════
         한도 정책 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'quotas'}">
        <div class="adm-card adm-ai-info-card">
            <div class="adm-ai-description">
                등급별 AI 도우미 이용 한도를 설정합니다. GUEST는 비로그인 유저용이며 가장 제한적입니다.<br>
                ADMIN/SUPERADMIN은 한도 체크에서 자동 제외됩니다.
            </div>
        </div>

        <div class="adm-card adm-ai-table-card">
            <div class="adm-card-head adm-ai-list-head">
                <div class="adm-card-title">
                    한도 정책
                    <span class="adm-section-total-inline">${msg_admin_ai_quotasTotalCountDisplay}</span>
                </div>
            </div>
            <div class="adm-table-wrap">
            <table class="adm-table adm-ai-table adm-ai-quotas-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-ai-col-grade"/>
                    <col class="adm-ai-col-quota"/>
                    <col class="adm-ai-col-quota"/>
                    <col class="adm-ai-col-period"/>
                    <col class="adm-ai-col-reset"/>
                    <col class="adm-ai-col-refund"/>
                    <col class="adm-ai-col-user"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>등급</th>
                        <th title="해당 유저의 CHAT_POST(세션) 총 보유 수 한도">세션 수</th>
                        <th>주기당 메시지 한도</th>
                        <th title="리셋 주기">주기(일)</th>
                        <th title="주기 시작(리셋) 시각 HH:MM">리셋 시각</th>
                        <th title="세션 삭제 시 그 세션의 현재 주기 내 유저 메시지 수만큼 한도 환급">환급 허용</th>
                        <th>마지막 수정자</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty quotas}">
                            <tr><td colspan="7" class="adm-local-empty-cell">등급이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="q" items="${quotas}">
                                <tr data-quota-id="${q.quotaId}" data-grade="${q.grade}">
                                    <td><strong>${q.grade}</strong></td>
                                    <td><input type="number" class="adm-input adm-ai-quota-input q-sessions" value="${q.maxSessions}" data-original="${q.maxSessions}"/></td>
                                    <td><input type="number" class="adm-input adm-ai-quota-input q-msg" value="${q.maxMessagesPerPeriod}" data-original="${q.maxMessagesPerPeriod}"/></td>
                                    <td>
                                        <select class="adm-select adm-ai-quota-select q-period" data-original="${q.periodDays}">
                                            <c:forEach var="d" items="1,2,3,4,5,7,14,30">
                                                <option value="${d}" ${q.periodDays == d ? 'selected' : ''}>${d}일</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td>
                                        <div class="adm-ai-time-controls">
                                            <select class="adm-select adm-ai-time-select q-reset-h" data-original="${q.resetHour}">
                                                <c:forEach var="h" begin="0" end="23">
                                                    <option value="${h}" ${q.resetHour == h ? 'selected' : ''}>
                                                        <fmt:formatNumber value="${h}" minIntegerDigits="2"/>
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <span class="adm-ai-time-separator">:</span>
                                            <select class="adm-select adm-ai-time-select q-reset-m" data-original="${q.resetMinute}">
                                                <c:forEach var="m" begin="0" end="59">
                                                    <option value="${m}" ${q.resetMinute == m ? 'selected' : ''}>
                                                        <fmt:formatNumber value="${m}" minIntegerDigits="2"/>
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </td>
                                    <td class="adm-ai-check-cell">
                                        <input type="checkbox" class="adm-ai-checkbox q-refund" ${q.quotaRefundEnabled ? 'checked' : ''} data-original="${q.quotaRefundEnabled ? 'true' : 'false'}"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty q.updatedBy}">
                                                <a class="quota-updater"
                                                   href="javascript:void(0);"
                                                   onclick="openDetail('${q.updatedBy}'); return false;"
                                                   title="회원 상세 보기">
                                                    <c:choose>
                                                        <c:when test="${not empty q.updaterNickname}">${q.updaterNickname}</c:when>
                                                        <c:otherwise>#${q.updatedBy}</c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </c:when>
                                            <c:otherwise><span class="adm-ai-muted">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            </div>
        </div>

        <%-- 전체 저장 / 기본값 복원 (원본으로 되돌리기) --%>
        <div class="adm-ai-footer-actions">
            <span id="quotaDirtyHint" class="adm-ai-dirty-hint"></span>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="resetAssistantQuotasToOriginal()"
                    title="불러온 DB 값으로 모두 되돌립니다">기본값 복원</button>
            <button type="button" class="adm-btn adm-btn-primary" onclick="saveAllAssistantQuotas()">전체 저장</button>
        </div>
    </c:if>

</div>

<%-- 세션 메시지 조회 모달 --%>
<div id="asstMsgModal" class="adm-ai-message-modal" hidden>
    <div class="adm-ai-message-dialog">
        <div class="adm-ai-message-head">
            <h3 id="asstMsgModalTitle" class="adm-ai-message-title">${msg_admin_aiHelper_assistant_modal_title}</h3>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="document.getElementById('asstMsgModal').hidden = true">${msg_admin_common_close}</button>
        </div>
        <div id="asstMsgModalBody" class="adm-ai-message-body"></div>
    </div>
</div>

<script>
(function () {
    const ctx = '${pageContext.request.contextPath}';
    const assistantMessages = {
        modalTitle: '${msg_admin_aiHelper_assistant_modal_title_js}',
        roleUser: '${msg_admin_aiHelper_assistant_role_user_js}',
        roleAi: '${msg_admin_aiHelper_assistant_role_ai_js}',
        empty: '${msg_admin_aiHelper_assistant_empty_messages_js}',
        viewFailed: '${msg_admin_aiHelper_assistant_message_viewFailed_js}',
        viewError: '${msg_admin_aiHelper_assistant_message_viewError_js}',
        deleteConfirm: '${msg_admin_aiHelper_assistant_message_deleteConfirm_js}',
        deleteDone: '${msg_admin_aiHelper_assistant_message_deleteDone_js}',
        deleteFailed: '${msg_admin_aiHelper_assistant_message_deleteFailed_js}',
        deleteError: '${msg_admin_aiHelper_assistant_message_deleteError_js}',
        sessionLabel: '${msg_admin_aiHelper_assistant_table_session_js}'
    };

    window.viewAssistantMessages = async function (sessionId) {
        try {
            const res = await fetch(ctx + '/admin/ai-helper/assistant/sessions/' + sessionId + '/messages');
            const data = await res.json();
            if (!data.success) { alert(assistantMessages.viewFailed); return; }
            const title = assistantMessages.sessionLabel + ' #' + sessionId + ' — ' + (data.session.title || '');
            document.getElementById('asstMsgModalTitle').textContent = title;
            const html = (data.messages || []).map(function (m) {
                const isUser = m.commentRole === 'USER';
                const roleLabel = isUser ? assistantMessages.roleUser : assistantMessages.roleAi;
                const roleClass = isUser ? 'is-user' : 'is-ai';
                const content  = (m.content || '').replace(/</g, '&lt;').replace(/>/g, '&gt;');
                return '<div class="adm-ai-message-item ' + roleClass + '">' +
                       '<div class="adm-ai-message-meta">#' + m.commentOrder + ' ' + roleLabel + '</div>' +
                       '<div class="adm-ai-message-content">' + content + '</div>' +
                       '</div>';
            }).join('');
            document.getElementById('asstMsgModalBody').innerHTML = html || '<div class="adm-local-empty-cell">' + assistantMessages.empty + '</div>';
            document.getElementById('asstMsgModal').hidden = false;
        } catch (e) {
            alert(assistantMessages.viewError);
        }
    };

    window.deleteAssistantSession = async function (sessionId) {
        if (!confirm(assistantMessages.deleteConfirm.replace('{0}', sessionId))) return;
        try {
            const res = await fetch(ctx + '/admin/ai-helper/assistant/sessions/' + sessionId + '/delete', {
                method: 'POST'
            });
            const data = await res.json();
            if (data.success) {
                alert(assistantMessages.deleteDone);
                location.reload();
            } else {
                alert(assistantMessages.deleteFailed + ': ' + (data.message || ''));
            }
        } catch (e) {
            alert(assistantMessages.deleteError);
        }
    };

    // ─── 차단 등록 ───
    window.createAssistantBlock = async function () {
        const blockType  = document.getElementById('blkType').value;
        const blockValue = document.getElementById('blkValue').value.trim();
        const reason     = document.getElementById('blkReason').value.trim();
        const expiresStr = document.getElementById('blkExpires').value.trim();
        if (!blockValue) { alert('값을 입력해주세요.'); return; }
        const body = { blockType: blockType, blockValue: blockValue };
        if (reason) body.reason = reason;
        if (expiresStr) {
            // 입력 포맷 "YYYY-MM-DD HH:mm" → ISO "YYYY-MM-DDTHH:mm:00"
            const m = expiresStr.match(/^(\d{4}-\d{2}-\d{2})[ T](\d{2}:\d{2})$/);
            if (!m) { alert('만료 형식은 YYYY-MM-DD HH:mm 입니다.'); return; }
            body.expiresAt = m[1] + 'T' + m[2] + ':00';
        }
        try {
            const res = await fetch(ctx + '/admin/ai-helper/assistant/blocks', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(body)
            });
            const data = await res.json();
            if (data.success) {
                alert('차단 등록 완료');
                location.reload();
            } else {
                alert('등록 실패: ' + (data.message || ''));
            }
        } catch (e) {
            alert('등록 중 오류');
        }
    };

    // ─── 차단 해제 ───
    window.deactivateAssistantBlock = async function (blockId) {
        if (!confirm('차단을 해제합니다. 계속하시겠습니까?')) return;
        try {
            const res = await fetch(ctx + '/admin/ai-helper/assistant/blocks/' + blockId + '/deactivate', {
                method: 'POST'
            });
            const data = await res.json();
            if (data.success) {
                alert('해제 완료');
                location.reload();
            } else {
                alert('해제 실패');
            }
        } catch (e) {
            alert('해제 중 오류');
        }
    };

    // ─── 등급별 한도 — 변경 감지 / 기본값 복원 / 전체 저장 ───
    function isAssistantRowDirty(row) {
        const els = row.querySelectorAll('input[data-original], select[data-original]');
        for (const el of els) {
            if (el.type === 'checkbox') {
                const original = el.dataset.original === 'true';
                if (el.checked !== original) return true;
            } else {
                if (String(el.value) !== String(el.dataset.original)) return true;
            }
        }
        return false;
    }

    function updateAssistantDirtyHint() {
        const hint = document.getElementById('quotaDirtyHint');
        if (!hint) return;
        const rows = document.querySelectorAll('tr[data-quota-id]');
        let count = 0;
        rows.forEach(function (row) {
            if (isAssistantRowDirty(row)) {
                row.classList.add('is-dirty');
                count++;
            } else {
                row.classList.remove('is-dirty');
            }
        });
        hint.textContent = count > 0 ? ('변경된 행 ' + count + '개') : '';
    }

    document.querySelectorAll('tr[data-quota-id] input[data-original], tr[data-quota-id] select[data-original]').forEach(function (el) {
        el.addEventListener('input', updateAssistantDirtyHint);
        el.addEventListener('change', updateAssistantDirtyHint);
    });

    window.resetAssistantQuotasToOriginal = function () {
        let reverted = 0;
        document.querySelectorAll('tr[data-quota-id] input[data-original], tr[data-quota-id] select[data-original]').forEach(function (el) {
            if (el.type === 'checkbox') {
                const target = el.dataset.original === 'true';
                if (el.checked !== target) { el.checked = target; reverted++; }
            } else {
                if (String(el.value) !== String(el.dataset.original)) { el.value = el.dataset.original; reverted++; }
            }
        });
        updateAssistantDirtyHint();
        if (reverted === 0) alert('되돌릴 변경 사항이 없습니다.');
    };

    window.saveAllAssistantQuotas = async function () {
        const rows = Array.from(document.querySelectorAll('tr[data-quota-id]'));
        const dirtyRows = rows.filter(isAssistantRowDirty);
        if (dirtyRows.length === 0) {
            alert('변경 사항이 없습니다.');
            return;
        }
        const tasks = dirtyRows.map(function (row) {
            const quotaId = row.dataset.quotaId;
            const payload = {
                grade:                row.dataset.grade,
                maxSessions:          parseInt(row.querySelector('.q-sessions').value, 10),
                maxMessagesPerPeriod: parseInt(row.querySelector('.q-msg').value, 10),
                periodDays:           parseInt(row.querySelector('.q-period').value, 10),
                resetHour:            parseInt(row.querySelector('.q-reset-h').value, 10),
                resetMinute:          parseInt(row.querySelector('.q-reset-m').value, 10),
                quotaRefundEnabled:   row.querySelector('.q-refund').checked
            };
            return fetch(ctx + '/admin/ai-helper/assistant/quotas/' + quotaId, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            }).then(function (res) { return res.json(); });
        });

        try {
            const results = await Promise.all(tasks);
            const failed = results.filter(function (r) { return !r.success; }).length;
            if (failed === 0) {
                alert('전체 ' + results.length + '건 저장 완료');
                location.reload();
            } else {
                alert('일부 저장 실패 (' + failed + '/' + results.length + '). 새로고침 후 재시도해 주세요.');
            }
        } catch (e) {
            alert('저장 중 오류가 발생했습니다.');
        }
    };
})();
</script>

<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="modalTitle">${msg_admin_context_memberTitle}</div>
            <button class="adm-modal-close" onclick="closeDetail()">✕</button>
        </div>
        <div class="adm-modal-body" id="modalBody">
            <div class="adm-context-empty">${msg_admin_common_loading}</div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeDetail()">${msg_admin_common_close}</button>
        </div>
    </div>
</div>


<div class="adm-modal-overlay" id="blockModal">
    <div class="adm-modal adm-ai-block-dialog">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockModalTitle">${msg_admin_members_blockModalTitle}</div>
            <button class="adm-modal-close" onclick="closeBlockModal()">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="blockUserIdx">
            <div class="adm-ai-modal-field">
                <label class="form-label" for="blockType">${msg_admin_context_action_blockType}</label>
                <select id="blockType" class="adm-select" onchange="handleBlockTypeChange()">
                    <option value="USER_ONLY">${msg_admin_context_blockType_userOnly}</option>
                    <option value="IP_ONLY">${msg_admin_context_blockType_ipOnly}</option>
                    <option value="USER_IP">${msg_admin_context_blockType_userIp}</option>
                </select>
            </div>
            <div class="adm-ai-modal-field">
                <label class="form-label" for="blockedIp">${msg_admin_members_blockedIpLabel}</label>
                <input id="blockedIp" class="adm-input" type="text" placeholder="${msg_admin_context_action_blockIpPlaceholder}">
            </div>
            <div class="adm-ai-modal-field">
                <label class="form-label" for="blockedUntil">${msg_admin_members_blockExpiresLabel}</label>
                <input id="blockedUntil" class="adm-input" type="datetime-local">
            </div>
            <div class="adm-ai-modal-field">
                <label class="form-label" for="blockedReason">${msg_admin_members_blockReasonLabel}</label>
                <textarea id="blockedReason" class="adm-input adm-ai-modal-textarea" placeholder="${msg_admin_context_action_reasonPlaceholder}"></textarea>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeBlockModal()">${msg_admin_common_close}</button>
            <button id="blockSubmitBtn" class="adm-btn adm-btn-primary" type="button" onclick="submitBlock()">${msg_admin_context_action_applyBlock}</button>
        </div>
    </div>
</div>

<script>
const ctx = '${pageContext.request.contextPath}';
const ADMIN_MEMBER_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const ADMIN_MEMBER_MSG = {
    loading: '${msg_admin_common_loading_js}',
    close: '${msg_admin_common_close_js}',
    error: '${msg_admin_common_error_js}',
    yes: '${msg_admin_common_yes_js}',
    no: '${msg_admin_common_no_js}',
    none: '${msg_admin_members_none_js}',
    noLinkedProvider: '${msg_admin_members_noLinkedProvider_js}',
    verifiedMember: '${msg_admin_members_verifiedMember_js}',
    unverifiedMember: '${msg_admin_members_unverifiedMember_js}',
    statusActive: '${msg_admin_status_ACTIVE_js}',
    statusDormant: '${msg_admin_status_DORMANT_js}',
    statusBlocked: '${msg_admin_status_BLOCKED_js}',
    statusDeleted: '${msg_admin_status_DELETED_js}',
    blockModalTitleSuffix: '${msg_admin_members_blockModalTitleSuffix_js}',
    parsingBlockResponse: '${msg_admin_members_blockResponseParseError_js}',
    parsingStatusResponse: '${msg_admin_members_statusResponseParseError_js}',
    parsingRoleResponse: '${msg_admin_members_roleResponseParseError_js}',
    missingBlockTarget: '${msg_admin_members_blockTargetMissing_js}',
    applying: '${msg_admin_common_applying_js}',
    blockApplied: '${msg_admin_context_toast_saveBlockSuccess_js}',
    memberDetailsTitle: '${msg_admin_context_memberTitle_js}',
    memberDetailsSuffix: '${msg_admin_members_detailTitleSuffix_js}',
    infoTab: '${msg_admin_context_tab_info_js}',
    loginTab: '${msg_admin_context_tab_logins_js}',
    securityTab: '${msg_admin_context_tab_security_js}',
    emailHistoryTab: '${msg_admin_members_emailHistoryTab_js}',
    activityTab: '${msg_admin_context_tab_activity_js}',
    blockTab: '${msg_admin_context_tab_blocks_js}',
    actionsTab: '${msg_admin_context_tab_actions_js}'
};

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
    return value ? escapeHtml(value) : '<span class="adm-ai-muted">—</span>';
}

function formatDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString(ADMIN_MEMBER_LOCALE || undefined, {
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

    return date.toLocaleString(ADMIN_MEMBER_LOCALE || undefined, {
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatBooleanBadge(value) {
    return value
        ? '<span class="adm-ai-bool is-yes">✓ ' + escapeHtml(ADMIN_MEMBER_MSG.yes) + '</span>'
        : '<span class="adm-ai-bool is-no">✗ ' + escapeHtml(ADMIN_MEMBER_MSG.no) + '</span>';
}

function buildStatusBadge(status) {
    const safe = escapeHtml(status || '');
    return '<span class="status-badge ' + safe + '">' + (safe || '—') + '</span>';
}

function buildRoleBadge(role) {
    const safe = escapeHtml(role || '');
    return '<span class="role-badge ' + safe + '">' + roleLabel(safe) + '</span>';
}

function roleLabel(role) {
    const labels = {
        USER: '${msg_admin_role_USER_js}',
        BUSINESS: '${msg_admin_role_BUSINESS_js}',
        PARTNER: '${msg_admin_role_PARTNER_js}',
        BOT: '${msg_admin_role_BOT_js}',
        ADMIN: '${msg_admin_role_ADMIN_js}',
        SUPERADMIN: '${msg_admin_role_SUPERADMIN_js}',
        SYSTEM: '${msg_admin_role_SYSTEM_js}'
    };
    return labels[role] || role || '—';
}

function buildSocialHtml(linkedProviders) {
    if (!linkedProviders) {
        return '<span class="adm-social-empty">' + escapeHtml(ADMIN_MEMBER_MSG.noLinkedProvider) + '</span>';
    }

    const providerMap = {
        KAKAO: {
            label: '${msg_admin_social_kakao_js}',
            className: 'kakao',
            icon: '<span class="adm-social-icon kakao-mark">k</span>'
        },
        NAVER: {
            label: '${msg_admin_social_naver_js}',
            className: 'naver',
            icon: '<span class="adm-social-icon naver-mark">N</span>'
        },
        GOOGLE: {
            label: '${msg_admin_social_google_js}',
            className: 'google',
            icon: '<span class="adm-social-icon google-mark"><svg viewBox="0 0 48 48" aria-hidden="true" focusable="false"><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/><path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/></svg></span>'
        }
    };

    const items = linkedProviders
        .split(',')
        .map(provider => provider.trim())
        .filter(provider => provider.length > 0)
        .map(function(provider) {
            const info = providerMap[provider];
            if (!info) {
                return '<span class="adm-social-pill"><span class="adm-social-label">' + escapeHtml(provider) + '</span></span>';
            }
            return '<span class="adm-social-pill ' + info.className + '">' + info.icon + '<span class="adm-social-label">' + escapeHtml(info.label) + '</span></span>';
        });

    if (!items.length) {
        return '<span class="adm-social-empty">' + escapeHtml(ADMIN_MEMBER_MSG.noLinkedProvider) + '</span>';
    }

    return '<div class="adm-social-list">' + items.join('') + '</div>';
}

/* ── 페이지 이동 ── */
function goPage(p) {
    const form = document.getElementById('searchForm');
    form.querySelector('[name=page]').value = p;
    form.submit();
}

function changeSize(size) {
    const form = document.getElementById('searchForm');
    form.querySelector('[name=size]').value = size;
    form.querySelector('[name=page]').value = 1;
    form.submit();
}

/* ── 액션 메뉴 토글 ── */
function toggleMenu(btn) {
    const menu = btn.nextElementSibling;
    document.querySelectorAll('.action-menu.open').forEach(m => {
        if (m !== menu) m.classList.remove('open');
    });
    menu.classList.toggle('open');
}

function openBlockModal(triggerOrUserIdx, nickname) {
    const trigger = typeof triggerOrUserIdx === 'object' ? triggerOrUserIdx : null;
    const userIdx = trigger ? trigger.dataset.userIdx : triggerOrUserIdx;
    const resolvedNickname = trigger ? (trigger.dataset.nickname || '') : (nickname || '');

    document.getElementById('blockUserIdx').value = userIdx;
    document.getElementById('blockModalTitle').textContent = (resolvedNickname || '') + ' ' + ADMIN_MEMBER_MSG.blockModalTitleSuffix;
    document.getElementById('blockType').value = 'USER_ONLY';
    document.getElementById('blockedIp').value = '';
    document.getElementById('blockedIp').disabled = true;
    document.getElementById('blockedUntil').value = '';
    document.getElementById('blockedReason').value = '';
    document.getElementById('blockSubmitBtn').disabled = false;

    const menu = trigger ? trigger.closest('.action-menu') : null;
    if (menu) menu.classList.remove('open');

    document.getElementById('blockModal').classList.add('open');
}

function closeBlockModal() {
    document.getElementById('blockModal').classList.remove('open');
}

function handleBlockTypeChange() {
    const blockType = document.getElementById('blockType').value;
    const ipInput = document.getElementById('blockedIp');
    const requiresIp = blockType === 'IP_ONLY' || blockType === 'USER_IP';

    ipInput.disabled = !requiresIp;
    if (!requiresIp) ipInput.value = '';
}

async function submitBlock() {
    const submitBtn = document.getElementById('blockSubmitBtn');
    const userIdx = document.getElementById('blockUserIdx').value;
    const blockType = document.getElementById('blockType').value;
    const blockedIp = document.getElementById('blockedIp').value.trim();
    const blockedUntil = document.getElementById('blockedUntil').value;
    const reason = document.getElementById('blockedReason').value.trim();

    if (!userIdx) {
        adm_toast(ADMIN_MEMBER_MSG.missingBlockTarget, 'error');
        return;
    }
    if ((blockType === 'IP_ONLY' || blockType === 'USER_IP') && !blockedIp) {
        adm_toast('${msg_admin_context_requireBlockedIp_js}', 'error');
        document.getElementById('blockedIp').focus();
        return;
    }

    submitBtn.disabled = true;
    const originalText = submitBtn.textContent;
    submitBtn.textContent = ADMIN_MEMBER_MSG.applying;

    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/block', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ blockType, blockedIp, expiresAt: blockedUntil, reason })
        });

        let data = null;
        const contentType = res.headers.get('content-type') || '';
        if (contentType.includes('application/json')) {
            data = await res.json();
        } else {
            const text = await res.text();
            throw new Error(text || ADMIN_MEMBER_MSG.parsingBlockResponse);
        }

        if (res.ok && data && data.success) {
            closeBlockModal();
            adm_toast(ADMIN_MEMBER_MSG.blockApplied || '${msg_admin_context_toast_saveBlockSuccess_js}');
            setTimeout(() => location.reload(), 800);
        } else {
            adm_toast((data && data.message) || '${msg_admin_context_toast_saveBlockFail_js}', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast(e.message || '${msg_admin_context_toast_saveBlockError_js}', 'error');
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = originalText;
    }
}

/* ── 상태 변경 ── */
async function changeStatus(userIdx, status, el) {
    const labels = {
        ACTIVE: ADMIN_MEMBER_MSG.statusActive,
        DORMANT: ADMIN_MEMBER_MSG.statusDormant,
        BLOCKED: ADMIN_MEMBER_MSG.statusBlocked,
        DELETED: ADMIN_MEMBER_MSG.statusDeleted
    };
    if (!confirm('${msg_admin_members_confirmStatusChangePrefix_js}' + ' "' + (labels[status] || status) + '" ' + '${msg_admin_members_confirmStatusChangeSuffix_js}')) return;

    const menu = el.closest('.action-menu');
    if (menu) menu.classList.remove('open');

    const res = await fetch(ctx + '/admin/members/' + userIdx + '/status', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ status })
    });

    let data;
    try {
        data = await res.json();
    } catch (e) {
        adm_toast(ADMIN_MEMBER_MSG.parsingStatusResponse, 'error');
        return;
    }

    if (res.ok && data.success) {
        adm_toast(data.message || '${msg_admin_context_toast_saveStatusSuccess_js}');
        setTimeout(() => location.reload(), 800);
    } else {
        adm_toast(data.message || '${msg_admin_context_toast_saveStatusFail_js}', 'error');
    }
}

/* ── 권한 변경 ── */
function changeRoleFromMenu(button) {
    const box = button.closest('.role-change-box');
    if (!box) return;

    const select = box.querySelector('.role-change-select');
    const reasonInput = box.querySelector('.role-change-reason');
    const userIdx = button.dataset.userIdx;
    const role = select ? select.value : '';
    const currentRole = select ? select.dataset.currentRole : '';
    const reason = reasonInput ? reasonInput.value.trim() : '';

    if (!role || !userIdx) {
        adm_toast('${msg_admin_members_roleContextMissing_js}', 'error');
        return;
    }
    if (role === currentRole) {
        adm_toast('${msg_admin_members_roleAlreadySelected_js}', 'error');
        return;
    }
    if (!reason) {
        adm_toast('${msg_admin_context_requireRoleReason_js}', 'error');
        if (reasonInput) reasonInput.focus();
        return;
    }

    changeRole(userIdx, role, reason, button);
}

async function changeRole(userIdx, role, reason, el) {
    if (!confirm('"' + roleLabel(role) + '" ' + '${msg_admin_members_confirmRoleChangeSuffix_js}')) return;

    const menu = el.closest('.action-menu');
    if (menu) menu.classList.remove('open');

    const res = await fetch(ctx + '/admin/members/' + userIdx + '/role', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ role, reason })
    });

    let data;
    try {
        data = await res.json();
    } catch (e) {
        adm_toast(ADMIN_MEMBER_MSG.parsingRoleResponse, 'error');
        return;
    }

    if (res.ok && data.success) {
        adm_toast(data.message || '${msg_admin_context_toast_saveRoleSuccess_js}');
        setTimeout(() => location.reload(), 800);
    } else {
        adm_toast(data.message || '${msg_admin_context_toast_saveRoleFail_js}', 'error');
    }
}

function buildContextRows(items, renderer, emptyMessage) {
    if (!Array.isArray(items) || !items.length) {
        return '<div class="adm-context-empty">' + emptyMessage + '</div>';
    }
    return '<div class="adm-context-stack">' + items.map(renderer).join('') + '</div>';
}

function buildSecurityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div class="adm-context-record-head">'
            + '<div><strong>' + escapeHtml(item.eventType || '-') + '</strong> / ' + escapeHtml(item.eventStage || '-') + '</div>'
            + '<div class="adm-context-record-time">' + escapeHtml(formatHistoryDateTime(item.occurredAt)) + '</div>'
            + '</div>'
            + '<div class="adm-context-record-line">${msg_admin_context_inputValue_js}: ' + escapeHtml(item.inputIdentifier || '-') + '</div>'
            + '<div class="adm-context-record-subline">${msg_admin_context_targetEmail_js}: ' + escapeHtml(item.targetEmail || '-') + '</div>'
            + '</div>';
    }, '${msg_admin_context_empty_security_js}');
}

function buildEmailRequestRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div class="adm-context-record-head">'
            + '<div><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.status || '-') + '</div>'
            + '<div class="adm-context-record-time">' + escapeHtml(formatHistoryDateTime(item.requestedAt)) + '</div>'
            + '</div>'
            + '<div class="adm-context-record-line">${msg_admin_context_requestEmail_js}: ' + escapeHtml(item.pendingEmail || '-') + '</div>'
            + '</div>';
    }, '${msg_admin_context_empty_emailRequests_js}');
}

function buildEmailTokenRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div class="adm-context-record-head">'
            + '<div><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.used ? '${msg_admin_context_used_js}' : '${msg_admin_context_unused_js}') + '</div>'
            + '<div class="adm-context-record-time">' + escapeHtml(formatHistoryDateTime(item.createdAt)) + '</div>'
            + '</div>'
            + '<div class="adm-context-record-line">${msg_admin_context_targetEmail_js}: ' + escapeHtml(item.email || '-') + '</div>'
            + '</div>';
    }, '${msg_admin_context_empty_emailTokens_js}');
}

function buildActivityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div class="adm-context-record-head">'
            + '<div><strong>' + escapeHtml(item.activityCode || '-') + '</strong> / ' + escapeHtml(item.activityDomain || item.activityType || '-') + '</div>'
            + '<div class="adm-context-record-time">' + escapeHtml(formatHistoryDateTime(item.createdAt)) + '</div>'
            + '</div>'
            + '<div class="adm-context-record-line">${msg_admin_context_uri_js}: ' + escapeHtml(item.requestUri || '-') + '</div>'
            + '</div>';
    }, '${msg_admin_context_empty_activity_js}');
}

function buildBlockRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div class="adm-context-record-head">'
            + '<div><strong>' + escapeHtml(item.blockType || '-') + '</strong> / ' + escapeHtml(item.active ? 'ACTIVE' : 'INACTIVE') + '</div>'
            + '<div class="adm-context-record-time">' + escapeHtml(formatHistoryDateTime(item.blockedAt)) + '</div>'
            + '</div>'
            + '<div class="adm-context-record-line">${msg_admin_common_reason_js}: ' + escapeHtml(item.reason || '-') + '</div>'
            + '<div class="adm-context-record-subline">IP: ' + escapeHtml(item.blockedIp || '-') + '</div>'
            + '</div>';
    }, '${msg_admin_context_empty_blocks_js}');
}

function buildChatbotLinkClickRows(items) {
    return buildContextRows(items, function(item) {
        const url = item.url || '';
        return ''
            + '<div class="adm-context-record">'
            + '<div class="adm-context-record-head">'
            + '<div class="adm-context-record-title"><strong>' + escapeHtml(item.label || '-') + '</strong></div>'
            + '<div class="adm-context-record-time">' + escapeHtml(formatHistoryDateTime(item.clickedAt)) + '</div>'
            + '</div>'
            + '<div class="adm-context-record-line"><a class="adm-context-mono-link" href="' + ctx + escapeHtml(url) + '" target="_blank">' + escapeHtml(url) + '</a></div>'
            + '<div class="adm-context-record-code">'
            + 'conv #' + escapeHtml(item.conversationId || '-')
            + ' · msg #' + escapeHtml(item.messageId || '-')
            + ' · IP: ' + escapeHtml(item.ipAddress || '-')
            + '</div>'
            + '</div>';
    }, '기록된 챗봇 링크 클릭이 없습니다.');
}

function buildActionTab(m) {
    return ''
        + '<div class="adm-context-actions-grid">'
        + '<div class="adm-context-panel">'
        + '<div class="adm-context-panel-title">' + '${msg_admin_context_action_profileTitle_js}' + '</div>'
        + '<div class="detail-label">' + '${msg_admin_context_nickname_js}' + '</div><input id="memberProfileNickname" class="adm-input" type="text" value="' + escapeHtml(m.nickname || '') + '">'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_context_nationality_js}' + '</div><input id="memberProfileNationality" class="adm-input" type="text" value="' + escapeHtml(m.nationality || '') + '">'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_context_preferredLanguage_js}' + '</div><input id="memberProfileLang" class="adm-input" type="text" value="' + escapeHtml(m.preferredLang || '') + '">'
        + '<button type="button" class="adm-btn adm-btn-primary adm-context-panel-btn" onclick="saveMemberProfile(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_context_action_saveProfile_js}' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel">'
        + '<div class="adm-context-panel-title">' + '${msg_admin_context_action_statusRoleTitle_js}' + '</div>'
        + '<div class="detail-label">' + '${msg_admin_members_accountStatus_js}' + '</div>'
        + '<div class="adm-context-action-row"><select id="memberStatusSelect" class="adm-select"><option value="ACTIVE">${msg_admin_status_ACTIVE_js}</option><option value="DORMANT">${msg_admin_status_DORMANT_js}</option><option value="BLOCKED">${msg_admin_status_BLOCKED_js}</option><option value="DELETED">${msg_admin_status_DELETED_js}</option></select><button type="button" class="adm-btn adm-btn-ghost" onclick="applyStatusFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_common_apply_js}' + '</button></div>'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_common_role_js}' + '</div>'
        + '<select id="memberRoleSelect" class="adm-select adm-context-full-control"><option value="USER">${msg_admin_role_USER_js}</option><option value="BUSINESS">${msg_admin_role_BUSINESS_js}</option><option value="PARTNER">${msg_admin_role_PARTNER_js}</option><option value="BOT">${msg_admin_role_BOT_js}</option><option value="ADMIN">${msg_admin_role_ADMIN_js}</option></select>'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_context_action_roleReason_js}' + '</div>'
        + '<input id="memberRoleReason" class="adm-input" type="text" maxlength="500" placeholder="' + '${msg_admin_context_action_roleReasonPlaceholder_js}' + '">'
        + '<button type="button" class="adm-btn adm-btn-ghost adm-context-panel-btn" onclick="applyRoleFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_context_action_changeRole_js}' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel">'
        + '<div class="adm-context-panel-title">' + '${msg_admin_context_action_quickBlockTitle_js}' + '</div>'
        + '<div class="detail-label">' + '${msg_admin_context_action_blockType_js}' + '</div><select id="detailBlockType" class="adm-select adm-context-full-control"><option value="USER_ONLY">' + '${msg_admin_context_blockType_userOnly_js}' + '</option><option value="IP_ONLY">' + '${msg_admin_context_blockType_ipOnly_js}' + '</option><option value="USER_IP">' + '${msg_admin_context_blockType_userIp_js}' + '</option></select>'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_context_blockedIp_js}' + '</div><input id="detailBlockedIp" class="adm-input" type="text" placeholder="' + '${msg_admin_context_action_blockIpPlaceholder_js}' + '">'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_context_action_blockExpires_js}' + '</div><input id="detailBlockedUntil" class="adm-input" type="datetime-local">'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_common_reason_js}' + '</div><textarea id="detailBlockedReason" class="adm-input adm-ai-modal-textarea"></textarea>'
        + '<button type="button" class="adm-btn adm-btn-primary adm-context-panel-btn" onclick="submitDetailBlock(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_context_action_applyBlock_js}' + '</button>'
        + '</div>'
        + '</div>';
}

/* ── 회원 상세 모달 ── */
async function openDetail(userIdx, defaultTab) {
    document.getElementById('detailModal').classList.add('open');
    document.getElementById('modalBody').innerHTML =
        '<div class="adm-context-empty">' + escapeHtml(ADMIN_MEMBER_MSG.loading) + '</div>';

    let data;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx);
        data = await res.json();
    } catch (error) {
        document.getElementById('modalBody').innerHTML =
            '<div class="adm-context-empty is-error">' + escapeHtml(ADMIN_MEMBER_MSG.fetchError) + '</div>';
        return;
    }

    if (!data.success) {
        document.getElementById('modalBody').innerHTML =
            '<div class="adm-context-empty is-error">' + escapeHtml(data.message || ADMIN_MEMBER_MSG.error) + '</div>';
        return;
    }

    const m = data.member || {};
    const h = Array.isArray(data.history) ? data.history : [];
    const securityAudits = Array.isArray(data.securityAudits) ? data.securityAudits : [];
    const emailRequests = Array.isArray(data.emailRequests) ? data.emailRequests : [];
    const emailTokens = Array.isArray(data.emailTokens) ? data.emailTokens : [];
    const activityLogs = Array.isArray(data.activityLogs) ? data.activityLogs : [];
    const recentBlocks = Array.isArray(data.recentBlocks) ? data.recentBlocks : [];
    const chatbotLinkClicks = Array.isArray(data.chatbotLinkClicks) ? data.chatbotLinkClicks : [];
    const activeTab = ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'chatbot', 'actions'].includes(defaultTab) ? defaultTab : 'info';

    document.getElementById('modalTitle').textContent = (m.nickname || ADMIN_MEMBER_MSG.memberDetailsTitle) + ' ' + ADMIN_MEMBER_MSG.memberDetailsSuffix;

    document.getElementById('modalBody').innerHTML = ''
        + '<div class="adm-tabs">'
        + '<button class="adm-tab ' + (activeTab === 'info' ? 'active' : '') + '" onclick="switchTab(\'info\', this)">' + ADMIN_MEMBER_MSG.infoTab + '</button>'
        + '<button class="adm-tab ' + (activeTab === 'hist' ? 'active' : '') + '" onclick="switchTab(\'hist\', this)">' + ADMIN_MEMBER_MSG.loginTab + ' (' + h.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'security' ? 'active' : '') + '" onclick="switchTab(\'security\', this)">' + ADMIN_MEMBER_MSG.securityTab + ' (' + securityAudits.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'emails' ? 'active' : '') + '" onclick="switchTab(\'emails\', this)">' + ADMIN_MEMBER_MSG.emailHistoryTab + '</button>'
        + '<button class="adm-tab ' + (activeTab === 'activity' ? 'active' : '') + '" onclick="switchTab(\'activity\', this)">' + ADMIN_MEMBER_MSG.activityTab + ' (' + activityLogs.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'blocks' ? 'active' : '') + '" onclick="switchTab(\'blocks\', this)">' + ADMIN_MEMBER_MSG.blockTab + ' (' + recentBlocks.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'chatbot' ? 'active' : '') + '" onclick="switchTab(\'chatbot\', this)">챗봇 링크 (' + chatbotLinkClicks.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'actions' ? 'active' : '') + '" onclick="switchTab(\'actions\', this)">' + ADMIN_MEMBER_MSG.actionsTab + '</button>'
        + '</div>'
        + '<div id="tab-info" class="adm-tab-panel" ' + (activeTab === 'info' ? '' : 'hidden') + '></div>'
        + '<div id="tab-hist" class="adm-tab-panel" ' + (activeTab === 'hist' ? '' : 'hidden') + '></div>'
        + '<div id="tab-security" class="adm-tab-panel" ' + (activeTab === 'security' ? '' : 'hidden') + '></div>'
        + '<div id="tab-emails" class="adm-tab-panel" ' + (activeTab === 'emails' ? '' : 'hidden') + '></div>'
        + '<div id="tab-activity" class="adm-tab-panel" ' + (activeTab === 'activity' ? '' : 'hidden') + '></div>'
        + '<div id="tab-blocks" class="adm-tab-panel" ' + (activeTab === 'blocks' ? '' : 'hidden') + '></div>'
        + '<div id="tab-chatbot" class="adm-tab-panel" ' + (activeTab === 'chatbot' ? '' : 'hidden') + '></div>'
        + '<div id="tab-actions" class="adm-tab-panel" ' + (activeTab === 'actions' ? '' : 'hidden') + '></div>';

    document.getElementById('tab-info').innerHTML = buildInfoTab(m);
    document.getElementById('tab-hist').innerHTML = buildHistTab(h);
    document.getElementById('tab-security').innerHTML = buildSecurityRows(securityAudits);
    document.getElementById('tab-emails').innerHTML = ''
        + '<div class="adm-context-two-col">'
        + '<div><div class="adm-context-panel-title">' + '${msg_admin_context_tab_emailRequests_js}' + '</div>' + buildEmailRequestRows(emailRequests) + '</div>'
        + '<div><div class="adm-context-panel-title">' + '${msg_admin_context_tab_emailTokens_js}' + '</div>' + buildEmailTokenRows(emailTokens) + '</div>'
        + '</div>';
    document.getElementById('tab-activity').innerHTML = buildActivityRows(activityLogs);
    document.getElementById('tab-blocks').innerHTML = buildBlockRows(recentBlocks);
    document.getElementById('tab-chatbot').innerHTML = buildChatbotLinkClickRows(chatbotLinkClicks);
    document.getElementById('tab-actions').innerHTML = buildActionTab(m);
    const statusSelect = document.getElementById('memberStatusSelect');
    const roleSelect = document.getElementById('memberRoleSelect');
    if (statusSelect) statusSelect.value = m.accountStatus || 'ACTIVE';
    if (roleSelect) roleSelect.value = m.userRole || 'USER';
}

function buildInfoTab(m) {
    const statusBadge = buildStatusBadge(m.accountStatus);
    const roleBadge = buildRoleBadge(m.userRole);
    const socialHtml = buildSocialHtml(m.linkedProviders);
    const lastLoginText = formatDateTime(m.lastLoginAt);

    return ''
        + '<div class="detail-grid">'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_memberNo_js}' + '</div><div class="detail-value">#' + escapeHtml(m.userIdx) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_userId_js}' + '</div><div class="detail-value">' + formatNullable(m.userId) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_nickname_js}' + '</div><div class="detail-value">' + formatNullable(m.nickname) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_email_js}' + '</div><div class="detail-value is-small">' + formatNullable(m.userEmail) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_members_accountStatus_js}' + '</div><div class="detail-value">' + statusBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_common_role_js}' + '</div><div class="detail-value">' + roleBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_nationality_js}' + '</div><div class="detail-value">' + formatNullable(m.nationality) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_preferredLanguage_js}' + '</div><div class="detail-value">' + formatNullable(m.preferredLang) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_members_emailVerified_js}' + '</div><div class="detail-value">' + formatBooleanBadge(m.emailVerified) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_members_emailLoginEnabled_js}' + '</div><div class="detail-value">' + formatBooleanBadge(m.emailLoginEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_members_passwordLoginEnabled_js}' + '</div><div class="detail-value">' + formatBooleanBadge(m.passwordEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_createdAt_js}' + '</div><div class="detail-value is-small">' + formatDateTime(m.createdAt) + '</div></div>'
        + '</div>'
        + '<div class="detail-item adm-context-social-item">'
        + '<div class="detail-label">' + '${msg_admin_members_socialLinked_js}' + '</div>'
        + '<div class="detail-value adm-context-social-value">' + socialHtml + '</div>'
        + '</div>'
        + '<div class="adm-context-metric-grid">'
        + '<div class="adm-context-metric">'
        + '<div class="adm-context-metric-label">' + '${msg_admin_members_loginSuccess_js}' + '</div>'
        + '<div class="adm-context-metric-value is-success">' + escapeHtml(m.loginSuccessCount ?? 0) + '</div>'
        + '</div>'
        + '<div class="adm-context-metric">'
        + '<div class="adm-context-metric-label">' + '${msg_admin_members_loginFailure_js}' + '</div>'
        + '<div class="adm-context-metric-value is-danger">' + escapeHtml(m.loginFailCount ?? 0) + '</div>'
        + '</div>'
        + '<div class="adm-context-metric">'
        + '<div class="adm-context-metric-label">' + '${msg_admin_context_lastLogin_js}' + '</div>'
        + '<div class="adm-context-metric-time">' + escapeHtml(lastLoginText) + '</div>'
        + '</div>'
        + '</div>';
}

function buildHistTab(history) {
    if (!history.length) {
        return '<div class="adm-context-empty">' + '${msg_admin_context_empty_logins_js}' + '</div>';
    }

    const methodMap = {
        ID: '${msg_admin_context_userId_js}',
        EMAIL: '${msg_admin_context_email_js}',
        KAKAO: '${msg_admin_social_kakao_js}',
        NAVER: '${msg_admin_social_naver_js}',
        GOOGLE: '${msg_admin_social_google_js}'
    };

    let rows = '';
    history.forEach(function(item) {
        const ok = !!item.success;
        rows += ''
            + '<tr>'
            + '<td>' + escapeHtml(formatHistoryDateTime(item.loginAt)) + '</td>'
            + '<td>' + escapeHtml(methodMap[item.loginMethod] || item.loginMethod || '—') + '</td>'
            + '<td class="' + (ok ? 'h-success' : 'h-fail') + '">' + (ok ? '✅ ' + '${msg_admin_logs_success_js}' : '❌ ' + '${msg_admin_logs_failure_js}') + '</td>'
            + '<td>' + escapeHtml(item.failReason || '—') + '</td>'
            + '<td class="adm-context-ip-cell">' + escapeHtml(item.ipAddress || '—') + '</td>'
            + '</tr>';
    });

    return ''
        + '<div class="adm-context-table-scroll">'
        + '<table class="history-table">'
        + '<thead><tr><th>' + '${msg_admin_common_time_js}' + '</th><th>' + '${msg_admin_logs_provider_js}' + '</th><th>' + '${msg_admin_logs_success_js}' + '</th><th>' + '${msg_admin_logs_failReason_js}' + '</th><th>${msg_admin_common_ip_js}</th></tr></thead>'
        + '<tbody>' + rows + '</tbody>'
        + '</table>'
        + '</div>';
}

function switchTab(tab, btn) {
    document.querySelectorAll('#detailModal .adm-tab').forEach(t => t.classList.remove('active'));
    btn.classList.add('active');
    ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'chatbot', 'actions'].forEach(function(name) {
        const el = document.getElementById('tab-' + name);
        if (el) el.hidden = tab !== name;
    });
}

async function saveMemberProfile(userIdx, button) {
    const nickname = document.getElementById('memberProfileNickname').value.trim();
    const nationality = document.getElementById('memberProfileNationality').value.trim();
    const preferredLang = document.getElementById('memberProfileLang').value.trim();

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/profile', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ nickname, nationality, preferredLang })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || '${msg_admin_context_toast_saveProfileSuccess_js}');
            setTimeout(() => location.reload(), 700);
        } else {
            adm_toast(data.message || '${msg_admin_context_toast_saveProfileFail_js}', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('${msg_admin_context_toast_saveProfileError_js}', 'error');
    } finally {
        button.disabled = false;
    }
}

function applyStatusFromDetail(userIdx, button) {
    const status = document.getElementById('memberStatusSelect').value;
    changeStatus(userIdx, status, button);
}

function applyRoleFromDetail(userIdx, button) {
    const role = document.getElementById('memberRoleSelect').value;
    const reason = document.getElementById('memberRoleReason').value.trim();
    if (!reason) {
        adm_toast('${msg_admin_context_requireRoleReason_js}', 'error');
        return;
    }
    changeRole(userIdx, role, reason, button);
}

async function submitDetailBlock(userIdx, button) {
    const blockType = document.getElementById('detailBlockType').value;
    const blockedIp = document.getElementById('detailBlockedIp').value.trim();
    const expiresAt = document.getElementById('detailBlockedUntil').value;
    const reason = document.getElementById('detailBlockedReason').value.trim();

    if ((blockType === 'IP_ONLY' || blockType === 'USER_IP') && !blockedIp) {
        adm_toast('${msg_admin_context_requireBlockedIp_js}', 'error');
        return;
    }

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/block', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ blockType, blockedIp, expiresAt, reason })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || '${msg_admin_context_toast_saveBlockSuccess_js}');
            setTimeout(() => location.reload(), 700);
        } else {
            adm_toast(data.message || '${msg_admin_context_toast_saveBlockFail_js}', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('${msg_admin_context_toast_saveBlockError_js}', 'error');
    } finally {
        button.disabled = false;
    }
}

function closeDetail() {
    document.getElementById('detailModal').classList.remove('open');
    // 외부에서 ?detailUserIdx=N 으로 들어와 자동 오픈된 경우, 닫힘 후 파라미터 제거 (리프레시 재오픈 방지)
    try {
        const url = new URL(window.location.href);
        if (url.searchParams.has('detailUserIdx')) {
            url.searchParams.delete('detailUserIdx');
            window.history.replaceState(null, '', url.toString());
        }
    } catch (e) {}
}

document.getElementById('detailModal').addEventListener('click', function (e) {
    if (e.target === this) closeDetail();
});

document.getElementById('blockModal').addEventListener('click', function (e) {
    if (e.target === this) closeBlockModal();
});
</script>

<%@ include file="../layout-close.jsp" %>
