<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_aiHelper_chatbot_searchPlaceholder" code="admin.aiHelper.chatbot.searchPlaceholder"/>
<spring:message var="msg_admin_aiHelper_chatbot_valuePlaceholder" code="admin.aiHelper.chatbot.valuePlaceholder"/>
<spring:message var="msg_admin_aiHelper_chatbot_reasonPlaceholder" code="admin.aiHelper.chatbot.reasonPlaceholder"/>
<spring:message var="msg_admin_aiHelper_chatbot_modal_title_js" code="admin.aiHelper.chatbot.modal.title" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_role_user_js" code="admin.aiHelper.assistant.role.user" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_assistant_role_ai_js" code="admin.aiHelper.assistant.role.ai" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_empty_messages_js" code="admin.aiHelper.chatbot.empty.messages" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_viewFailed_js" code="admin.aiHelper.chatbot.message.viewFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_viewError_js" code="admin.aiHelper.chatbot.message.viewError" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_valueRequired_js" code="admin.aiHelper.chatbot.message.valueRequired" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_createBlockSuccess_js" code="admin.aiHelper.chatbot.message.createBlockSuccess" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_createBlockFailed_js" code="admin.aiHelper.chatbot.message.createBlockFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_deactivateConfirm_js" code="admin.aiHelper.chatbot.message.deactivateConfirm" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_deactivateFailed_js" code="admin.aiHelper.chatbot.message.deactivateFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_blockUserConfirm_js" code="admin.aiHelper.chatbot.message.blockUserConfirm" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_blockIpConfirm_js" code="admin.aiHelper.chatbot.message.blockIpConfirm" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_quickBlockReason_js" code="admin.aiHelper.chatbot.message.quickBlockReason" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_quotaSaved_js" code="admin.aiHelper.chatbot.message.quotaSaved" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_message_quotaSaveFailed_js" code="admin.aiHelper.chatbot.message.quotaSaveFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_conversationId_js" code="admin.aiHelper.chatbot.table.conversationId" javaScriptEscape="true"/>
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
<spring:message var="msg_admin_aiHelper_chatbot_pageTitle" code="admin.aiHelper.chatbot.pageTitle"/>
<spring:message var="msg_admin_aiHelper_chatbot_tab_dashboard" code="admin.aiHelper.chatbot.tab.dashboard"/>
<spring:message var="msg_admin_aiHelper_chatbot_tab_inappropriate" code="admin.aiHelper.chatbot.tab.inappropriate"/>
<spring:message var="msg_admin_aiHelper_chatbot_tab_blocks" code="admin.aiHelper.chatbot.tab.blocks"/>
<spring:message var="msg_admin_aiHelper_chatbot_tab_quotas" code="admin.aiHelper.chatbot.tab.quotas"/>
<spring:message var="msg_admin_aiHelper_chatbot_kpi_totalConversations" code="admin.aiHelper.chatbot.kpi.totalConversations"/>
<spring:message var="msg_admin_aiHelper_chatbot_kpi_todayConversations" code="admin.aiHelper.chatbot.kpi.todayConversations"/>
<spring:message var="msg_admin_aiHelper_chatbot_kpi_inappropriate" code="admin.aiHelper.chatbot.kpi.inappropriate"/>
<spring:message var="msg_admin_aiHelper_chatbot_kpi_activeBlocks" code="admin.aiHelper.chatbot.kpi.activeBlocks"/>
<spring:message var="msg_admin_aiHelper_assistant_section_sessions" code="admin.aiHelper.assistant.section.sessions"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCountFormat" code="admin.common.totalCountFormat"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_id" code="admin.aiHelper.chatbot.table.id"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_title" code="admin.aiHelper.chatbot.table.title"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_user" code="admin.aiHelper.chatbot.table.user"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_ip" code="admin.aiHelper.chatbot.table.ip"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_messageCount" code="admin.aiHelper.chatbot.table.messageCount"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_lastActive" code="admin.aiHelper.chatbot.table.lastActive"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_status" code="admin.aiHelper.chatbot.table.status"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_actions" code="admin.aiHelper.chatbot.table.actions"/>
<spring:message var="msg_admin_aiHelper_chatbot_action_blockUser" code="admin.aiHelper.chatbot.action.blockUser"/>
<spring:message var="msg_admin_aiHelper_chatbot_action_blockIp" code="admin.aiHelper.chatbot.action.blockIp"/>
<spring:message var="msg_admin_aiHelper_chatbot_empty_conversations" code="admin.aiHelper.chatbot.empty.conversations"/>
<spring:message var="msg_admin_aiHelper_assistant_userPrefix" code="admin.aiHelper.assistant.userPrefix"/>
<spring:message var="msg_admin_aiHelper_chatbot_guest" code="admin.aiHelper.chatbot.guest"/>
<spring:message var="msg_admin_aiHelper_chatbot_status_deleted" code="admin.aiHelper.chatbot.status.deleted"/>
<spring:message var="msg_admin_aiHelper_chatbot_status_active" code="admin.aiHelper.chatbot.status.active"/>
<spring:message var="msg_admin_aiHelper_chatbot_action_view" code="admin.aiHelper.chatbot.action.view"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_content" code="admin.aiHelper.chatbot.table.content"/>
<spring:message var="msg_admin_common_time" code="admin.common.time"/>
<spring:message var="msg_admin_aiHelper_chatbot_empty_inappropriate" code="admin.aiHelper.chatbot.empty.inappropriate"/>
<spring:message var="msg_admin_aiHelper_chatbot_action_viewConversation" code="admin.aiHelper.chatbot.action.viewConversation"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_type" code="admin.aiHelper.chatbot.table.type"/>
<spring:message var="msg_admin_aiHelper_chatbot_type_ip" code="admin.aiHelper.chatbot.type.ip"/>
<spring:message var="msg_admin_aiHelper_chatbot_type_user" code="admin.aiHelper.chatbot.type.user"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_value" code="admin.aiHelper.chatbot.table.value"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_reason" code="admin.aiHelper.chatbot.table.reason"/>
<spring:message var="msg_admin_aiHelper_chatbot_action_createBlock" code="admin.aiHelper.chatbot.action.createBlock"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_blockedBy" code="admin.aiHelper.chatbot.table.blockedBy"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_blockedAt" code="admin.aiHelper.chatbot.table.blockedAt"/>
<spring:message var="msg_admin_aiHelper_chatbot_table_expiresAt" code="admin.aiHelper.chatbot.table.expiresAt"/>
<spring:message var="msg_admin_aiHelper_chatbot_empty_blocks" code="admin.aiHelper.chatbot.empty.blocks"/>
<spring:message var="msg_admin_aiHelper_chatbot_value_permanent" code="admin.aiHelper.chatbot.value.permanent"/>
<spring:message var="msg_admin_aiHelper_chatbot_status_released" code="admin.aiHelper.chatbot.status.released"/>
<spring:message var="msg_admin_aiHelper_chatbot_action_release" code="admin.aiHelper.chatbot.action.release"/>
<spring:message var="msg_admin_aiHelper_chatbot_description_quota" code="admin.aiHelper.chatbot.description.quota"/>
<spring:message var="msg_admin_aiHelper_chatbot_description_quotaSub" code="admin.aiHelper.chatbot.description.quotaSub"/>
<spring:message var="msg_admin_aiHelper_chatbot_modal_title" code="admin.aiHelper.chatbot.modal.title"/>
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
<c:set var="pageTitle" value="${msg_admin_aiHelper_chatbot_pageTitle}"/>
<c:set var="activeMenu" value="aiHelper"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-ai-page adm-ai-chatbot-page">

    <%-- ── 챗봇 내부 sub-tab ── --%>
    <div class="adm-ai-tabs">
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=dashboard"
           class="adm-ai-tab ${tab == 'dashboard' ? 'active' : ''}">
            ${msg_admin_aiHelper_chatbot_tab_dashboard}
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=links"
           class="adm-ai-tab ${tab == 'links' ? 'active' : ''}">
            링크 클릭
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=inappropriate"
           class="adm-ai-tab ${tab == 'inappropriate' ? 'active' : ''}">
            ${msg_admin_aiHelper_chatbot_tab_inappropriate}
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=blocks"
           class="adm-ai-tab ${tab == 'blocks' ? 'active' : ''}">
            ${msg_admin_aiHelper_chatbot_tab_blocks}
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=quotas"
           class="adm-ai-tab ${tab == 'quotas' ? 'active' : ''}">
            ${msg_admin_aiHelper_chatbot_tab_quotas}
        </a>
    </div>

    <%-- ══════════════════════════════════════════
         대시보드 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'dashboard'}">
        <div class="adm-ai-kpi-grid">
            <div class="adm-card adm-ai-kpi-card">
                <div class="adm-ai-kpi-label">💬 ${msg_admin_aiHelper_chatbot_kpi_totalConversations}</div>
                <div class="adm-ai-kpi-value is-sky">${totalConversations}</div>
            </div>
            <div class="adm-card adm-ai-kpi-card">
                <div class="adm-ai-kpi-label">📅 ${msg_admin_aiHelper_chatbot_kpi_todayConversations}</div>
                <div class="adm-ai-kpi-value is-green">${todayConversations}</div>
            </div>
            <div class="adm-card adm-ai-kpi-card">
                <div class="adm-ai-kpi-label">⚠️ ${msg_admin_aiHelper_chatbot_kpi_inappropriate}</div>
                <div class="adm-ai-kpi-value is-orange">${inappropriateCount}</div>
            </div>
            <div class="adm-card adm-ai-kpi-card">
                <div class="adm-ai-kpi-label">⛔ ${msg_admin_aiHelper_chatbot_kpi_activeBlocks}</div>
                <div class="adm-ai-kpi-value is-red">${activeBlockCount}</div>
            </div>
        </div>

        <%-- ── 대화 세션 목록 (대시보드 내 통합) ── --%>
        <div class="adm-ai-section-title">${msg_admin_aiHelper_assistant_section_sessions}</div>

        <div class="adm-card adm-ai-filter-card">
            <form method="get" action="${pageContext.request.contextPath}/admin/ai-helper/chatbot" class="adm-ai-search-form">
                <input type="hidden" name="tab" value="dashboard"/>
                <input type="text" name="keyword" value="${keyword}" placeholder="${msg_admin_aiHelper_chatbot_searchPlaceholder}" class="adm-input adm-ai-search-input"/>
                <button type="submit" class="adm-btn adm-btn-primary">${msg_admin_common_search}</button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot" class="adm-btn adm-btn-ghost">${msg_admin_common_reset}</a>
                </c:if>
            </form>
            <div class="adm-ai-total">${msg_admin_common_totalCountFormat}</div>
        </div>

        <div class="adm-card adm-ai-table-card">
            <div class="adm-table-wrap">
            <table class="adm-table adm-ai-table adm-ai-conversations-table">
                <colgroup>
                    <col class="adm-ai-col-id"/>
                    <col class="adm-ai-col-title"/>
                    <col class="adm-ai-col-user"/>
                    <col class="adm-ai-col-ip"/>
                    <col class="adm-ai-col-count"/>
                    <col class="adm-ai-col-date"/>
                    <col class="adm-ai-col-status"/>
                    <col class="adm-ai-col-actions-wide"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>${msg_admin_aiHelper_chatbot_table_id}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_title}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_user}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_ip}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_messageCount}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_lastActive}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_status}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_actions}</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty conversations}">
                            <tr><td colspan="8" class="adm-local-empty-cell">${msg_admin_aiHelper_chatbot_empty_conversations}</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="c" items="${conversations}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">#${c.conversationId}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${c.title}</button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.userIdx != null}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${c.userIdx}">
                                                    ${msg_admin_aiHelper_assistant_userPrefix} #${c.userIdx}
                                                </button>
                                            </c:when>
                                            <c:otherwise><span class="adm-ai-muted">${msg_admin_aiHelper_chatbot_guest}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-inline-link js-open-ip-context"
                                                data-ip-address="${c.ipAddress}"
                                                data-default-tab="blocks">${c.ipAddress}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${c.messageCount}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${fn:replace(fn:substring(c.lastActive, 0, 16), 'T', ' ')}</button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.isDeleted}">
                                                <button type="button"
                                                        class="adm-cell-link adm-cell-link--inline adm-ai-status-link is-deleted"
                                                        data-conv-id="${c.conversationId}"
                                                        onclick="viewMessages(this.dataset.convId)">${msg_admin_aiHelper_chatbot_status_deleted}</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button"
                                                        class="adm-cell-link adm-cell-link--inline adm-ai-status-link is-active"
                                                        data-conv-id="${c.conversationId}"
                                                        onclick="viewMessages(this.dataset.convId)">${msg_admin_aiHelper_chatbot_status_active}</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="adm-ai-action-cell">
                                        <div class="adm-row-actions">
                                            <button type="button"
                                                    class="adm-row-btn detail"
                                                    data-conv-id="${c.conversationId}"
                                                    onclick="viewMessages(this.dataset.convId)">${msg_admin_aiHelper_chatbot_action_view}</button>
                                            <div class="action-menu-wrap">
                                                <button type="button"
                                                        class="adm-row-btn detail adm-row-btn-more"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu">
                                                    <c:if test="${c.userIdx != null}">
                                                        <button type="button"
                                                                class="action-menu-item"
                                                                data-block-value="${c.userIdx}"
                                                                onclick="blockUser(this.dataset.blockValue)">${msg_admin_aiHelper_chatbot_action_blockUser}</button>
                                                    </c:if>
                                                    <button type="button"
                                                            class="action-menu-item"
                                                            data-block-value="${c.ipAddress}"
                                                            onclick="blockIp(this.dataset.blockValue)">${msg_admin_aiHelper_chatbot_action_blockIp}</button>
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

        <%-- 페이징 --%>
        <c:if test="${totalPages > 1}">
            <div class="adm-ai-pagination">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=dashboard&page=${p}&keyword=${keyword}" class="adm-btn adm-ai-page-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}">${p}</a>
                </c:forEach>
            </div>
        </c:if>

    </c:if>

    <%-- ══════════════════════════════════════════
         링크 클릭 분석 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'links'}">
        <%-- 기간 필터 --%>
        <div class="adm-card adm-ai-link-filter-card">
            <div class="adm-ai-range-group">
                <div class="adm-ai-toolbar-label">기간</div>
                <div class="adm-ai-range-buttons">
                    <c:forEach var="d" items="7,30,90,365">
                        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=links&days=${d}"
                           class="adm-btn adm-ai-compact-btn ${rangeDays == d ? 'adm-btn-primary' : 'adm-btn-ghost'}">
                            최근 ${d}일
                        </a>
                    </c:forEach>
                </div>
            </div>
            <div class="adm-ai-toolbar-total">
                총 <strong>${totalClicks}</strong> 건
            </div>
        </div>

        <%-- 일별 추이 (CSS 막대) --%>
        <div class="adm-card adm-ai-chart-card">
            <div class="adm-ai-card-title">일별 클릭 추이</div>
            <c:choose>
                <c:when test="${empty dailyTrend}">
                    <div class="adm-ai-empty-panel">데이터가 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <c:set var="maxCount" value="0"/>
                    <c:forEach var="row" items="${dailyTrend}">
                        <c:if test="${row.clickCount > maxCount}">
                            <c:set var="maxCount" value="${row.clickCount}"/>
                        </c:if>
                    </c:forEach>
                    <div class="adm-ai-bar-chart">
                        <c:forEach var="row" items="${dailyTrend}">
                            <c:set var="pct" value="${maxCount > 0 ? (row.clickCount * 100 / maxCount) : 0}"/>
                            <div class="adm-ai-bar-item" title="${row.clickDate}: ${row.clickCount}">
                                <div class="adm-ai-bar-count">${row.clickCount}</div>
                                <div class="adm-ai-chart-bar" style="--adm-ai-pct:${pct}%;"></div>
                                <div class="adm-ai-bar-date">
                                    ${fn:substring(row.clickDate, 5, 10)}
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- 상위 URL 랭킹 --%>
        <div class="adm-card adm-ai-table-card">
            <div class="adm-ai-table-title">
                상위 클릭 URL (최대 20개)
            </div>
            <div class="adm-table-wrap">
            <table class="adm-table adm-ai-table adm-ai-links-table">
                <colgroup>
                    <col class="adm-ai-col-rank"/>
                    <col class="adm-ai-col-url"/>
                    <col class="adm-ai-col-clicks"/>
                    <col class="adm-ai-col-distribution"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>순위</th>
                        <th>URL</th>
                        <th class="adm-ai-number-head">클릭 수</th>
                        <th>분포</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty topUrls}">
                            <tr><td colspan="4" class="adm-local-empty-cell">데이터가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:set var="rankTopCount" value="${topUrls[0].clickCount}"/>
                            <c:forEach var="row" items="${topUrls}" varStatus="st">
                                <c:set var="pct" value="${rankTopCount > 0 ? (row.clickCount * 100 / rankTopCount) : 0}"/>
                                <tr>
                                    <td><strong>${st.index + 1}</strong></td>
                                    <td class="adm-ai-url-cell">
                                        <a href="${pageContext.request.contextPath}${row.url}" target="_blank" class="adm-ai-url-link">${row.url}</a>
                                    </td>
                                    <td class="adm-ai-number-cell">
                                        <button type="button" class="adm-row-btn detail adm-ai-count-btn"
                                                data-url="${row.url}" onclick="viewClickersByUrl(this.dataset.url)">
                                            ${row.clickCount}
                                        </button>
                                    </td>
                                    <td>
                                        <div class="adm-ai-progress">
                                            <div class="adm-ai-progress-bar" style="--adm-ai-pct:${pct}%;"></div>
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
    </c:if>

    <%-- ══════════════════════════════════════════
         부적절 메시지 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'inappropriate'}">
        <div class="adm-card adm-ai-table-card">
            <div class="adm-table-wrap">
            <table class="adm-table adm-ai-table adm-ai-moderation-table">
                <colgroup>
                    <col class="adm-ai-col-id"/>
                    <col class="adm-ai-col-user"/>
                    <col class="adm-ai-col-content"/>
                    <col class="adm-ai-col-date"/>
                    <col class="adm-ai-col-actions"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>${msg_admin_aiHelper_chatbot_table_id}</th>
                        <th>작성자</th>
                        <th>${msg_admin_aiHelper_chatbot_table_content}</th>
                        <th>${msg_admin_common_time}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_actions}</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty messages}">
                            <tr><td colspan="5" class="adm-local-empty-cell">${msg_admin_aiHelper_chatbot_empty_inappropriate}</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${messages}">
                                <tr>
                                    <td>${m.messageId}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty m.authorUserIdx}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${m.authorUserIdx}">
                                                    <c:choose>
                                                        <c:when test="${not empty m.authorNickname}">${m.authorNickname}</c:when>
                                                        <c:otherwise>#${m.authorUserIdx}</c:otherwise>
                                                    </c:choose>
                                                </button>
                                            </c:when>
                                            <c:otherwise><span class="adm-ai-muted">게스트</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="adm-ai-ellipsis-cell">${fn:escapeXml(m.content)}</td>
                                    <td>${fn:replace(fn:substring(m.createdAt, 0, 16), 'T', ' ')}</td>
                                    <td class="adm-ai-action-cell">
                                        <div class="adm-row-actions is-single">
                                            <button type="button"
                                                    class="adm-row-btn detail"
                                                    data-conv-id="${m.conversationId}"
                                                    onclick="viewMessages(this.dataset.convId)">${msg_admin_aiHelper_chatbot_action_viewConversation}</button>
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
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=inappropriate&page=${p}"
                       class="adm-btn adm-ai-page-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}">${p}</a>
                </c:forEach>
            </div>
        </c:if>
    </c:if>

    <%-- ══════════════════════════════════════════
         차단 관리 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'blocks'}">
        <div class="adm-card adm-ai-form-card">
            <div class="adm-ai-section-title">${msg_admin_aiHelper_chatbot_action_createBlock}</div>
            <div class="adm-ai-block-form adm-ai-block-form-compact">
                <div class="adm-ai-form-field is-type">
                    <label class="adm-filter-label" for="newBlockType">${msg_admin_aiHelper_chatbot_table_type}</label>
                    <select id="newBlockType" class="adm-select">
                        <option value="IP">${msg_admin_aiHelper_chatbot_type_ip}</option>
                        <option value="USER">${msg_admin_aiHelper_chatbot_type_user}</option>
                    </select>
                </div>
                <div class="adm-ai-form-field">
                    <label class="adm-filter-label" for="newBlockValue">${msg_admin_aiHelper_chatbot_table_value}</label>
                    <input type="text" id="newBlockValue" class="adm-input" placeholder="${msg_admin_aiHelper_chatbot_valuePlaceholder}"/>
                </div>
                <div class="adm-ai-form-field is-wide">
                    <label class="adm-filter-label" for="newBlockReason">${msg_admin_aiHelper_chatbot_table_reason}</label>
                    <input type="text" id="newBlockReason" class="adm-input" placeholder="${msg_admin_aiHelper_chatbot_reasonPlaceholder}"/>
                </div>
                <button type="button" class="adm-btn adm-btn-primary" onclick="createBlock()">${msg_admin_aiHelper_chatbot_action_createBlock}</button>
            </div>
        </div>

        <div class="adm-card adm-ai-table-card">
            <div class="adm-table-wrap">
            <table class="adm-table adm-ai-table adm-ai-blocks-table">
                <colgroup>
                    <col class="adm-ai-col-id"/>
                    <col class="adm-ai-col-type"/>
                    <col class="adm-ai-col-value"/>
                    <col class="adm-ai-col-reason"/>
                    <col class="adm-ai-col-user"/>
                    <col class="adm-ai-col-date"/>
                    <col class="adm-ai-col-date"/>
                    <col class="adm-ai-col-status"/>
                    <col class="adm-ai-col-actions-narrow"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>${msg_admin_aiHelper_chatbot_table_id}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_type}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_value}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_reason}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_blockedBy}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_blockedAt}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_expiresAt}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_status}</th>
                        <th>${msg_admin_aiHelper_chatbot_table_actions}</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty blocks}">
                            <tr><td colspan="9" class="adm-local-empty-cell">${msg_admin_aiHelper_chatbot_empty_blocks}</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${blocks}">
                                <tr>
                                    <td>#${b.blockId}</td>
                                    <td>
                                        <span class="adm-ai-type-badge ${b.blockType eq 'USER' ? 'is-user' : 'is-ip'}">${b.blockType}</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.blockType eq 'IP'}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-ip-context"
                                                        data-ip-address="${b.blockValue}"
                                                        data-default-tab="blocks">${b.blockValue}</button>
                                            </c:when>
                                            <c:when test="${b.blockType eq 'USER'}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${b.blockValue}">${b.blockValue}</button>
                                            </c:when>
                                            <c:otherwise>${b.blockValue}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="adm-ai-break-cell">${fn:escapeXml(b.reason)}</td>
                                    <td>${b.blockedBy}</td>
                                    <td>${fn:replace(fn:substring(b.blockedAt, 0, 16), 'T', ' ')}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.expiresAt != null}">${fn:replace(fn:substring(b.expiresAt, 0, 16), 'T', ' ')}</c:when>
                                            <c:otherwise><span class="adm-ai-muted">${msg_admin_aiHelper_chatbot_value_permanent}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.isActive}"><span class="adm-ai-state is-danger">${msg_admin_aiHelper_chatbot_status_active}</span></c:when>
                                            <c:otherwise><span class="adm-ai-muted">${msg_admin_aiHelper_chatbot_status_released}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="adm-ai-action-cell">
                                        <c:choose>
                                            <c:when test="${b.isActive}">
                                                <button type="button"
                                                        class="adm-row-btn danger"
                                                        data-block-id="${b.blockId}"
                                                        onclick="deactivateBlock(this.dataset.blockId)">${msg_admin_aiHelper_chatbot_action_release}</button>
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
    </c:if>

    <%-- ══════════════════════════════════════════
         정책 (등급별 한도) 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'quotas'}">
        <div class="adm-card adm-ai-info-card">
            <div class="adm-ai-description">
                ${msg_admin_aiHelper_chatbot_description_quota}<br>
                ${msg_admin_aiHelper_chatbot_description_quotaSub}
            </div>
        </div>

        <div class="adm-card adm-ai-table-card">
            <div class="adm-table-wrap">
            <table class="adm-table adm-ai-table adm-ai-quotas-table">
                <colgroup>
                    <col class="adm-ai-col-grade"/>
                    <col class="adm-ai-col-quota"/>
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
                        <th>동시 대화 수</th>
                        <th>주기당 메시지 한도</th>
                        <th>AI 컨텍스트 길이</th>
                        <th title="리셋 주기">주기(일)</th>
                        <th title="주기 시작(리셋) 시각 HH:MM">리셋 시각</th>
                        <th title="대화 삭제 시 그 대화에서 쓴 현재 주기 내 메시지 수만큼 한도 환급">환급 허용</th>
                        <th>마지막 수정자</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty quotas}">
                            <tr><td colspan="8" class="adm-local-empty-cell">등급이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="q" items="${quotas}">
                                <tr data-quota-id="${q.quotaId}">
                                    <td><strong>${q.grade}</strong></td>
                                    <td><input type="number" class="adm-input adm-ai-quota-input q-conv" value="${q.maxConversations}" data-original="${q.maxConversations}"/></td>
                                    <td><input type="number" class="adm-input adm-ai-quota-input q-msg" value="${q.maxMessagesPerPeriod}" data-original="${q.maxMessagesPerPeriod}"/></td>
                                    <td><input type="number" class="adm-input adm-ai-quota-input q-ctx" value="${q.maxContextMessages}" data-original="${q.maxContextMessages}"/></td>
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
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${q.updatedBy}">
                                                    <c:choose>
                                                        <c:when test="${not empty q.updaterNickname}">${q.updaterNickname}</c:when>
                                                        <c:otherwise>#${q.updatedBy}</c:otherwise>
                                                    </c:choose>
                                                </button>
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
            <button type="button" class="adm-btn adm-btn-ghost" onclick="resetQuotasToOriginal()"
                    title="불러온 DB 값으로 모두 되돌립니다">기본값 복원</button>
            <button type="button" class="adm-btn adm-btn-primary" onclick="saveAllQuotas()">전체 저장</button>
        </div>
    </c:if>

</div>

<%-- URL 별 클릭자 목록 모달 --%>
<div id="clickersModal" class="adm-ai-message-modal" hidden>
    <div class="adm-ai-message-dialog adm-ai-clickers-dialog">
        <div class="adm-ai-message-head">
            <h3 id="clickersModalTitle" class="adm-ai-message-title adm-ai-modal-title-break">URL 클릭자 목록</h3>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="document.getElementById('clickersModal').hidden = true">닫기</button>
        </div>
        <div id="clickersModalBody" class="adm-ai-message-body"></div>
    </div>
</div>

<%-- 대화 메시지 조회 모달 --%>
<div id="msgModal" class="adm-ai-message-modal" hidden>
    <div class="adm-ai-message-dialog">
        <div class="adm-ai-message-head">
            <h3 id="msgModalTitle" class="adm-ai-message-title">${msg_admin_aiHelper_chatbot_modal_title}</h3>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="document.getElementById('msgModal').hidden = true">${msg_admin_common_close}</button>
        </div>
        <div id="msgModalBody" class="adm-ai-message-body"></div>
    </div>
</div>

<script>
(function () {
    const ctx = '${pageContext.request.contextPath}';
    const chatbotMessages = {
        modalTitle: '${msg_admin_aiHelper_chatbot_modal_title_js}',
        roleUser: '${msg_admin_aiHelper_assistant_role_user_js}',
        roleAi: '${msg_admin_aiHelper_assistant_role_ai_js}',
        emptyMessages: '${msg_admin_aiHelper_chatbot_empty_messages_js}',
        viewFailed: '${msg_admin_aiHelper_chatbot_message_viewFailed_js}',
        viewError: '${msg_admin_aiHelper_chatbot_message_viewError_js}',
        valueRequired: '${msg_admin_aiHelper_chatbot_message_valueRequired_js}',
        createBlockSuccess: '${msg_admin_aiHelper_chatbot_message_createBlockSuccess_js}',
        createBlockFailed: '${msg_admin_aiHelper_chatbot_message_createBlockFailed_js}',
        deactivateConfirm: '${msg_admin_aiHelper_chatbot_message_deactivateConfirm_js}',
        deactivateFailed: '${msg_admin_aiHelper_chatbot_message_deactivateFailed_js}',
        blockUserConfirm: '${msg_admin_aiHelper_chatbot_message_blockUserConfirm_js}',
        blockIpConfirm: '${msg_admin_aiHelper_chatbot_message_blockIpConfirm_js}',
        quickBlockReason: '${msg_admin_aiHelper_chatbot_message_quickBlockReason_js}',
        quotaSaved: '${msg_admin_aiHelper_chatbot_message_quotaSaved_js}',
        quotaSaveFailed: '${msg_admin_aiHelper_chatbot_message_quotaSaveFailed_js}',
        conversationLabel: '${msg_admin_aiHelper_chatbot_table_conversationId_js}'
    };

    window.viewMessages = async function (convId) {
        try {
            const res = await fetch(ctx + '/admin/ai-helper/conversations/' + convId + '/messages');
            const data = await res.json();
            if (!data.success) { alert(chatbotMessages.viewFailed); return; }
            document.getElementById('msgModalTitle').textContent =
                chatbotMessages.conversationLabel + ' #' + convId + ' — ' + (data.conversation.title || '');

            // messageId → [click, ...] 매핑
            const clicksByMsg = {};
            (data.linkClicks || []).forEach(function (c) {
                const key = String(c.messageId);
                if (!clicksByMsg[key]) clicksByMsg[key] = [];
                clicksByMsg[key].push(c);
            });
            const totalClicks = (data.linkClicks || []).length;

            const msgHtml = (data.messages || []).map(function (m) {
                const role = m.role === 'user' ? chatbotMessages.roleUser : chatbotMessages.roleAi;
                const roleClass = m.role === 'user' ? 'is-user' : 'is-ai';
                const flag = m.isInappropriate ? '<span class="adm-ai-inappropriate-badge">inappropriate</span>' : '';
                const body = m.role === 'assistant'
                    ? renderAssistantContent(m.content)
                    : '<div class="adm-ai-message-content">' + escHtml(m.content || '') + '</div>';
                const clicks = m.role === 'assistant' ? (clicksByMsg[String(m.messageId)] || []) : [];
                const badge = clicks.length > 0
                    ? '<span class="adm-ai-click-badge">클릭 ' + clicks.length + '</span>'
                    : '';
                let perMsgDetail = '';
                if (clicks.length > 0) {
                    perMsgDetail = '<div class="adm-ai-click-detail">' +
                                   '<div class="adm-ai-click-detail-title">이 메시지의 클릭 이력</div>';
                    clicks.forEach(function (c) {
                        perMsgDetail += '<div class="adm-ai-click-detail-row">' +
                                        escHtml(c.label || '-') +
                                        ' <span class="adm-ai-click-url">' + escHtml(c.url || '') + '</span>' +
                                        ' <span class="adm-ai-click-time">(' + escHtml(formatClickTime(c.clickedAt)) + ')</span>' +
                                        '</div>';
                    });
                    perMsgDetail += '</div>';
                }
                return '<div class="adm-ai-message-item ' + roleClass + '">' +
                       '<div class="adm-ai-message-meta">' + role + flag + badge + '</div>' +
                       body +
                       perMsgDetail +
                       '</div>';
            }).join('');

            const summary = '<div class="adm-ai-message-summary">' +
                            '총 메시지 <strong>' + (data.messages || []).length + '</strong>건 · ' +
                            '링크 클릭 <strong>' + totalClicks + '</strong>건' +
                            '</div>';

            document.getElementById('msgModalBody').innerHTML = summary + (msgHtml || '<div class="adm-local-empty-cell">' + chatbotMessages.emptyMessages + '</div>');
            document.getElementById('msgModal').hidden = false;
        } catch (e) { alert(chatbotMessages.viewError); }
    };

    function formatClickTime(s) {
        if (!s) return '';
        const str = String(s);
        return str.length >= 16 ? str.substring(0, 16).replace('T', ' ') : str;
    }

    // URL 별 클릭자 목록 모달
    window.viewClickersByUrl = async function (url) {
        try {
            const res = await fetch(ctx + '/admin/ai-helper/chatbot/clicks/by-url?url=' + encodeURIComponent(url));
            const data = await res.json();
            if (!data.success) { alert('조회 실패'); return; }
            document.getElementById('clickersModalTitle').textContent = 'URL 클릭자 — ' + url;
            const rows = (data.clickers || []);
            if (rows.length === 0) {
                document.getElementById('clickersModalBody').innerHTML =
                    '<div class="adm-local-empty-cell">클릭 이력이 없습니다.</div>';
            } else {
                let html = '<table class="adm-table adm-ai-table adm-ai-clickers-table">' +
                           '<thead><tr>' +
                           '<th>시각</th><th>유저</th><th>세션</th><th>IP</th><th>대화</th><th>메시지</th>' +
                           '</tr></thead><tbody>';
                rows.forEach(function (r) {
                    const userText = r.userIdx
                        ? (escHtml(r.nickname || '') + ' <span class="adm-ai-subtext">#' + r.userIdx + '</span>')
                        : '<span class="adm-ai-muted">게스트</span>';
                    const anon = r.anonSessionId ? ('<span class="adm-ai-mono adm-ai-subtext">' + escHtml(String(r.anonSessionId).substring(0, 12)) + '…</span>') : '-';
                    html += '<tr>' +
                            '<td class="adm-ai-nowrap">' + escHtml(formatClickTime(r.clickedAt)) + '</td>' +
                            '<td>' + userText + '</td>' +
                            '<td>' + anon + '</td>' +
                            '<td class="adm-ai-mono">' + escHtml(r.ipAddress || '-') + '</td>' +
                            '<td>#' + escHtml(r.conversationId) + '</td>' +
                            '<td>#' + escHtml(r.messageId) + '</td>' +
                            '</tr>';
                });
                html += '</tbody></table>';
                html = '<div class="adm-ai-small-total">총 <strong>' + rows.length + '</strong>건 (최대 100)</div>' + html;
                document.getElementById('clickersModalBody').innerHTML = html;
            }
            document.getElementById('clickersModal').hidden = false;
        } catch (e) { alert('조회 중 오류'); }
    };

    // assistant 메시지 content 렌더링
    //   - JSON 파싱 성공: message 텍스트 + links + quickReplies + inappropriate 를 블록으로 분리 표시
    //   - 파싱 실패 (구버전 단순 텍스트): 원문 그대로
    function renderAssistantContent(raw) {
        if (raw == null) return '';
        let parsed = null;
        try {
            const maybe = JSON.parse(raw);
            if (maybe && typeof maybe === 'object' && typeof maybe.message === 'string') parsed = maybe;
        } catch (e) {}

        if (!parsed) {
            return '<div class="adm-ai-message-content">' + escHtml(raw) + '</div>';
        }

        let out = '<div class="adm-ai-message-content">' + escHtml(parsed.message) + '</div>';

        if (parsed.inappropriate === true) {
            out += '<div class="adm-ai-inappropriate-badge is-block">inappropriate</div>';
        }

        if (Array.isArray(parsed.links) && parsed.links.length > 0) {
            out += '<div class="adm-ai-link-list-title">제시된 링크</div>';
            out += '<div class="adm-ai-link-list">';
            parsed.links.forEach(function (l) {
                const label = escHtml(l.label || '');
                const url = escHtml(l.url || '');
                const icon = escHtml(l.icon || '→');
                out += '<div class="adm-ai-link-row">' +
                       '<span class="adm-ai-link-icon">' + icon + '</span>' +
                       '<span class="adm-ai-link-label">' + label + '</span>' +
                       '<span class="adm-ai-link-url">' + url + '</span>' +
                       '</div>';
            });
            out += '</div>';
        }

        if (Array.isArray(parsed.quickReplies) && parsed.quickReplies.length > 0) {
            out += '<div class="adm-ai-link-list-title">빠른 답변</div>';
            out += '<div class="adm-ai-quick-list">';
            parsed.quickReplies.forEach(function (q) {
                out += '<span class="adm-ai-quick-pill">' +
                       escHtml(q) + '</span>';
            });
            out += '</div>';
        }

        return out;
    }

    function escHtml(s) {
        return String(s == null ? '' : s)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;');
    }

    window.createBlock = async function () {
        const type   = document.getElementById('newBlockType').value;
        const value  = document.getElementById('newBlockValue').value.trim();
        const reason = document.getElementById('newBlockReason').value.trim();
        if (!value) { alert(chatbotMessages.valueRequired); return; }
        const res = await fetch(ctx + '/admin/ai-helper/blocks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ blockType: type, blockValue: value, reason: reason })
        });
        const data = await res.json();
        if (data.success) { alert(chatbotMessages.createBlockSuccess); location.reload(); }
        else alert(chatbotMessages.createBlockFailed + ': ' + (data.message || ''));
    };

    window.deactivateBlock = async function (blockId) {
        if (!confirm(chatbotMessages.deactivateConfirm)) return;
        const res = await fetch(ctx + '/admin/ai-helper/blocks/' + blockId + '/deactivate', { method: 'POST' });
        const data = await res.json();
        if (data.success) location.reload();
        else alert(chatbotMessages.deactivateFailed);
    };

    window.blockUser = function (userIdx) {
        if (!confirm(chatbotMessages.blockUserConfirm)) return;
        doQuickBlock('USER', String(userIdx));
    };
    window.blockIp = function (ip) {
        if (!confirm(chatbotMessages.blockIpConfirm.replace('{0}', ip))) return;
        doQuickBlock('IP', ip);
    };
    async function doQuickBlock(type, value) {
        const res = await fetch(ctx + '/admin/ai-helper/blocks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ blockType: type, blockValue: value, reason: chatbotMessages.quickBlockReason })
        });
        const data = await res.json();
        alert(data.success ? chatbotMessages.createBlockSuccess : chatbotMessages.createBlockFailed);
    }

    // 행별 dirty 여부 계산 (input + select 모두)
    function isRowDirty(row) {
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

    function updateDirtyHint() {
        const hint = document.getElementById('quotaDirtyHint');
        if (!hint) return;
        const dirtyRows = document.querySelectorAll('tr[data-quota-id]');
        let count = 0;
        dirtyRows.forEach(function (row) {
            if (isRowDirty(row)) {
                row.classList.add('is-dirty');
                count++;
            } else {
                row.classList.remove('is-dirty');
            }
        });
        hint.textContent = count > 0 ? ('변경된 행 ' + count + '개') : '';
    }

    // 입력 변경 감지 바인딩 (input + select)
    document.querySelectorAll('tr[data-quota-id] input[data-original], tr[data-quota-id] select[data-original]').forEach(function (el) {
        el.addEventListener('input', updateDirtyHint);
        el.addEventListener('change', updateDirtyHint);
    });

    // 기본값 복원 — 모든 필드를 최초 로드 값으로 되돌림
    window.resetQuotasToOriginal = function () {
        let reverted = 0;
        document.querySelectorAll('tr[data-quota-id] input[data-original], tr[data-quota-id] select[data-original]').forEach(function (el) {
            if (el.type === 'checkbox') {
                const target = el.dataset.original === 'true';
                if (el.checked !== target) { el.checked = target; reverted++; }
            } else {
                if (String(el.value) !== String(el.dataset.original)) { el.value = el.dataset.original; reverted++; }
            }
        });
        updateDirtyHint();
        if (reverted === 0) alert('되돌릴 변경 사항이 없습니다.');
    };

    // 전체 저장 — 변경된 행만 순차 저장
    window.saveAllQuotas = async function () {
        const rows = Array.from(document.querySelectorAll('tr[data-quota-id]'));
        const dirtyRows = rows.filter(isRowDirty);
        if (dirtyRows.length === 0) {
            alert('변경 사항이 없습니다.');
            return;
        }
        const tasks = dirtyRows.map(function (row) {
            const quotaId = row.dataset.quotaId;
            const payload = {
                maxConversations:     parseInt(row.querySelector('.q-conv').value, 10),
                maxMessagesPerPeriod: parseInt(row.querySelector('.q-msg').value, 10),
                maxContextMessages:   parseInt(row.querySelector('.q-ctx').value, 10),
                periodDays:           parseInt(row.querySelector('.q-period').value, 10),
                resetHour:            parseInt(row.querySelector('.q-reset-h').value, 10),
                resetMinute:          parseInt(row.querySelector('.q-reset-m').value, 10),
                quotaRefundEnabled:   row.querySelector('.q-refund').checked
            };
            return fetch(ctx + '/admin/ai-helper/quotas/' + quotaId, {
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
            <div style="text-align:center;padding:40px;color:#475569;">${msg_admin_common_loading}</div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeDetail()">${msg_admin_common_close}</button>
        </div>
    </div>
</div>


<div class="adm-modal-overlay" id="blockModal">
    <div class="adm-modal" style="max-width:520px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockModalTitle">${msg_admin_members_blockModalTitle}</div>
            <button class="adm-modal-close" onclick="closeBlockModal()">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="blockUserIdx">
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label">${msg_admin_context_action_blockType}</label>
                <select id="blockType" class="adm-select" style="width:100%;" onchange="handleBlockTypeChange()">
                    <option value="USER_ONLY">${msg_admin_context_blockType_userOnly}</option>
                    <option value="IP_ONLY">${msg_admin_context_blockType_ipOnly}</option>
                    <option value="USER_IP">${msg_admin_context_blockType_userIp}</option>
                </select>
            </div>
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label">${msg_admin_members_blockedIpLabel}</label>
                <input id="blockedIp" class="adm-input" type="text" placeholder="${msg_admin_context_action_blockIpPlaceholder}">
            </div>
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label">${msg_admin_members_blockExpiresLabel}</label>
                <input id="blockedUntil" class="adm-input" type="datetime-local">
            </div>
            <div class="form-group">
                <label class="form-label">${msg_admin_members_blockReasonLabel}</label>
                <textarea id="blockedReason" class="adm-input" style="min-height:90px;resize:vertical;" placeholder="${msg_admin_context_action_reasonPlaceholder}"></textarea>
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
    return value ? escapeHtml(value) : '<span style="color:#475569">—</span>';
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
        ? '<span style="color:#4ade80">✓ ' + escapeHtml(ADMIN_MEMBER_MSG.yes) + '</span>'
        : '<span style="color:#475569">✗ ' + escapeHtml(ADMIN_MEMBER_MSG.no) + '</span>';
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
        return '<div style="text-align:center;padding:32px;color:#475569;">' + emptyMessage + '</div>';
    }
    return '<div style="display:flex;flex-direction:column;gap:10px;">' + items.map(renderer).join('') + '</div>';
}

function buildSecurityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.eventType || '-') + '</strong> / ' + escapeHtml(item.eventStage || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.occurredAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;">${msg_admin_context_inputValue_js}: ' + escapeHtml(item.inputIdentifier || '-') + '</div>'
            + '<div style="margin-top:4px;font-size:12px;color:#94a3b8;">${msg_admin_context_targetEmail_js}: ' + escapeHtml(item.targetEmail || '-') + '</div>'
            + '</div>';
    }, '${msg_admin_context_empty_security_js}');
}

function buildEmailRequestRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.status || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.requestedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;">${msg_admin_context_requestEmail_js}: ' + escapeHtml(item.pendingEmail || '-') + '</div>'
            + '</div>';
    }, '${msg_admin_context_empty_emailRequests_js}');
}

function buildEmailTokenRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.used ? '${msg_admin_context_used_js}' : '${msg_admin_context_unused_js}') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.createdAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;">${msg_admin_context_targetEmail_js}: ' + escapeHtml(item.email || '-') + '</div>'
            + '</div>';
    }, '${msg_admin_context_empty_emailTokens_js}');
}

function buildActivityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.activityCode || '-') + '</strong> / ' + escapeHtml(item.activityDomain || item.activityType || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.createdAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;">${msg_admin_context_uri_js}: ' + escapeHtml(item.requestUri || '-') + '</div>'
            + '</div>';
    }, '${msg_admin_context_empty_activity_js}');
}

function buildBlockRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.blockType || '-') + '</strong> / ' + escapeHtml(item.active ? 'ACTIVE' : 'INACTIVE') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.blockedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;">${msg_admin_common_reason_js}: ' + escapeHtml(item.reason || '-') + '</div>'
            + '<div style="margin-top:4px;font-size:12px;color:#94a3b8;">IP: ' + escapeHtml(item.blockedIp || '-') + '</div>'
            + '</div>';
    }, '${msg_admin_context_empty_blocks_js}');
}

function buildChatbotLinkClickRows(items) {
    return buildContextRows(items, function(item) {
        const url = item.url || '';
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div style="font-size:13px;"><strong>' + escapeHtml(item.label || '-') + '</strong></div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.clickedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;"><a href="' + ctx + escapeHtml(url) + '" target="_blank" style="color:#60a5fa;font-family:monospace;text-decoration:none;">' + escapeHtml(url) + '</a></div>'
            + '<div style="margin-top:4px;font-size:11px;color:#94a3b8;">'
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
        + '<div style="font-weight:700;margin-bottom:10px;">' + '${msg_admin_context_action_profileTitle_js}' + '</div>'
        + '<div class="detail-label">' + '${msg_admin_context_nickname_js}' + '</div><input id="memberProfileNickname" class="adm-input" type="text" value="' + escapeHtml(m.nickname || '') + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '${msg_admin_context_nationality_js}' + '</div><input id="memberProfileNationality" class="adm-input" type="text" value="' + escapeHtml(m.nationality || '') + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '${msg_admin_context_preferredLanguage_js}' + '</div><input id="memberProfileLang" class="adm-input" type="text" value="' + escapeHtml(m.preferredLang || '') + '">'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="saveMemberProfile(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_context_action_saveProfile_js}' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel">'
        + '<div style="font-weight:700;margin-bottom:10px;">' + '${msg_admin_context_action_statusRoleTitle_js}' + '</div>'
        + '<div class="detail-label">' + '${msg_admin_members_accountStatus_js}' + '</div>'
        + '<div style="display:flex;gap:8px;"><select id="memberStatusSelect" class="adm-select" style="width:100%;"><option value="ACTIVE">${msg_admin_status_ACTIVE_js}</option><option value="DORMANT">${msg_admin_status_DORMANT_js}</option><option value="BLOCKED">${msg_admin_status_BLOCKED_js}</option><option value="DELETED">${msg_admin_status_DELETED_js}</option></select><button type="button" class="adm-btn adm-btn-ghost" onclick="applyStatusFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_common_apply_js}' + '</button></div>'
        + '<div class="detail-label" style="margin-top:10px;">' + '${msg_admin_common_role_js}' + '</div>'
        + '<select id="memberRoleSelect" class="adm-select" style="width:100%;"><option value="USER">${msg_admin_role_USER_js}</option><option value="BUSINESS">${msg_admin_role_BUSINESS_js}</option><option value="PARTNER">${msg_admin_role_PARTNER_js}</option><option value="BOT">${msg_admin_role_BOT_js}</option><option value="ADMIN">${msg_admin_role_ADMIN_js}</option></select>'
        + '<div class="detail-label" style="margin-top:10px;">' + '${msg_admin_context_action_roleReason_js}' + '</div>'
        + '<input id="memberRoleReason" class="adm-input" type="text" maxlength="500" placeholder="' + '${msg_admin_context_action_roleReasonPlaceholder_js}' + '">'
        + '<button type="button" class="adm-btn adm-btn-ghost" style="margin-top:12px;" onclick="applyRoleFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_context_action_changeRole_js}' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel">'
        + '<div style="font-weight:700;margin-bottom:10px;">' + '${msg_admin_context_action_quickBlockTitle_js}' + '</div>'
        + '<div class="detail-label">' + '${msg_admin_context_action_blockType_js}' + '</div><select id="detailBlockType" class="adm-select" style="width:100%;"><option value="USER_ONLY">' + '${msg_admin_context_blockType_userOnly_js}' + '</option><option value="IP_ONLY">' + '${msg_admin_context_blockType_ipOnly_js}' + '</option><option value="USER_IP">' + '${msg_admin_context_blockType_userIp_js}' + '</option></select>'
        + '<div class="detail-label" style="margin-top:10px;">' + '${msg_admin_context_blockedIp_js}' + '</div><input id="detailBlockedIp" class="adm-input" type="text" placeholder="' + '${msg_admin_context_action_blockIpPlaceholder_js}' + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '${msg_admin_context_action_blockExpires_js}' + '</div><input id="detailBlockedUntil" class="adm-input" type="datetime-local">'
        + '<div class="detail-label" style="margin-top:10px;">' + '${msg_admin_common_reason_js}' + '</div><textarea id="detailBlockedReason" class="adm-input" style="min-height:88px;resize:vertical;"></textarea>'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="submitDetailBlock(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_context_action_applyBlock_js}' + '</button>'
        + '</div>'
        + '</div>';
}

/* ── 회원 상세 모달 ── */
async function openDetail(userIdx, defaultTab) {
    document.getElementById('detailModal').classList.add('open');
    document.getElementById('modalBody').innerHTML =
        '<div style="text-align:center;padding:40px;color:#475569;">' + escapeHtml(ADMIN_MEMBER_MSG.loading) + ' ⏳</div>';

    let data;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx);
        data = await res.json();
    } catch (error) {
        document.getElementById('modalBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(ADMIN_MEMBER_MSG.fetchError) + '</div>';
        return;
    }

    if (!data.success) {
        document.getElementById('modalBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(data.message || ADMIN_MEMBER_MSG.error) + '</div>';
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
        + '<div id="tab-info" style="display:' + (activeTab === 'info' ? '' : 'none') + ';"></div>'
        + '<div id="tab-hist" style="display:' + (activeTab === 'hist' ? '' : 'none') + ';"></div>'
        + '<div id="tab-security" style="display:' + (activeTab === 'security' ? '' : 'none') + ';"></div>'
        + '<div id="tab-emails" style="display:' + (activeTab === 'emails' ? '' : 'none') + ';"></div>'
        + '<div id="tab-activity" style="display:' + (activeTab === 'activity' ? '' : 'none') + ';"></div>'
        + '<div id="tab-blocks" style="display:' + (activeTab === 'blocks' ? '' : 'none') + ';"></div>'
        + '<div id="tab-chatbot" style="display:' + (activeTab === 'chatbot' ? '' : 'none') + ';"></div>'
        + '<div id="tab-actions" style="display:' + (activeTab === 'actions' ? '' : 'none') + ';"></div>';

    document.getElementById('tab-info').innerHTML = buildInfoTab(m);
    document.getElementById('tab-hist').innerHTML = buildHistTab(h);
    document.getElementById('tab-security').innerHTML = buildSecurityRows(securityAudits);
    document.getElementById('tab-emails').innerHTML = ''
        + '<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:16px;">'
        + '<div><div style="font-weight:700;margin-bottom:10px;">' + '${msg_admin_context_tab_emailRequests_js}' + '</div>' + buildEmailRequestRows(emailRequests) + '</div>'
        + '<div><div style="font-weight:700;margin-bottom:10px;">' + '${msg_admin_context_tab_emailTokens_js}' + '</div>' + buildEmailTokenRows(emailTokens) + '</div>'
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
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_email_js}' + '</div><div class="detail-value" style="font-size:12px;">' + formatNullable(m.userEmail) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_members_accountStatus_js}' + '</div><div class="detail-value">' + statusBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_common_role_js}' + '</div><div class="detail-value">' + roleBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_nationality_js}' + '</div><div class="detail-value">' + formatNullable(m.nationality) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_preferredLanguage_js}' + '</div><div class="detail-value">' + formatNullable(m.preferredLang) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_members_emailVerified_js}' + '</div><div class="detail-value">' + formatBooleanBadge(m.emailVerified) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_members_emailLoginEnabled_js}' + '</div><div class="detail-value">' + formatBooleanBadge(m.emailLoginEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_members_passwordLoginEnabled_js}' + '</div><div class="detail-value">' + formatBooleanBadge(m.passwordEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${msg_admin_context_createdAt_js}' + '</div><div class="detail-value" style="font-size:12px;">' + formatDateTime(m.createdAt) + '</div></div>'
        + '</div>'
        + '<div class="detail-item" style="margin-top:12px;">'
        + '<div class="detail-label">' + '${msg_admin_members_socialLinked_js}' + '</div>'
        + '<div class="detail-value" style="margin-top:4px;">' + socialHtml + '</div>'
        + '</div>'
        + '<div style="margin-top:12px;display:flex;gap:8px;flex-wrap:wrap;">'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '${msg_admin_members_loginSuccess_js}' + '</div>'
        + '<div style="font-size:20px;font-weight:700;color:#4ade80;margin-top:4px;">' + escapeHtml(m.loginSuccessCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '${msg_admin_members_loginFailure_js}' + '</div>'
        + '<div style="font-size:20px;font-weight:700;color:#f87171;margin-top:4px;">' + escapeHtml(m.loginFailCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:120px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '${msg_admin_context_lastLogin_js}' + '</div>'
        + '<div style="font-size:12px;font-weight:600;color:#94a3b8;margin-top:4px;">' + escapeHtml(lastLoginText) + '</div>'
        + '</div>'
        + '</div>';
}

function buildHistTab(history) {
    if (!history.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;">' + '${msg_admin_context_empty_logins_js}' + '</div>';
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
            + '<td style="font-size:11px;color:#475569;">' + escapeHtml(item.ipAddress || '—') + '</td>'
            + '</tr>';
    });

    return ''
        + '<div style="overflow-x:auto;max-height:340px;overflow-y:auto;">'
        + '<table class="history-table">'
        + '<thead><tr><th>' + '${msg_admin_common_time_js}' + '</th><th>' + '${msg_admin_logs_provider_js}' + '</th><th>' + '${msg_admin_logs_success_js}' + '</th><th>' + '${msg_admin_logs_failReason_js}' + '</th><th>${msg_admin_common_ip_js}</th></tr></thead>'
        + '<tbody>' + rows + '</tbody>'
        + '</table>'
        + '</div>';
}

function switchTab(tab, btn) {
    document.querySelectorAll('#detailModal .adm-tab').forEach(t => t.classList.remove('active'));
    btn.classList.add('active');
    ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'actions'].forEach(function(name) {
        const el = document.getElementById('tab-' + name);
        if (el) el.style.display = tab === name ? '' : 'none';
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
