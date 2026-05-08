<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_members_searchPlaceholder" code="admin.members.searchPlaceholder"/>
<spring:message var="msg_admin_blocks_mode_label" code="admin.blocks.mode.label"/>
<spring:message var="msg_admin_blocks_mode_tipClient" code="admin.blocks.mode.tipClient"/>
<spring:message var="msg_admin_blocks_mode_tipServer" code="admin.blocks.mode.tipServer"/>
<spring:message var="msg_admin_context_action_blockIpPlaceholder" code="admin.context.action.blockIpPlaceholder"/>
<spring:message var="msg_admin_context_action_reasonPlaceholder" code="admin.context.action.reasonPlaceholder"/>
<spring:message var="msg_admin_common_loading_js" code="admin.common.loading" javaScriptEscape="true"/>
<spring:message var="msg_admin_blocks_js_dashSortReset_js" code="admin.blocks.js.dashSortReset" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_totalCountFormat_js" code="admin.common.totalCountFormat" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_currentCountFormat_js" code="admin.common.currentCountFormat" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_exportSelected_js" code="admin.common.exportSelected" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_noResults_js" code="admin.common.noResults" javaScriptEscape="true"/>
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
<spring:message var="msg_admin_members_detail" code="admin.members.detail"/>
<spring:message var="msg_admin_members_detailTitleSuffix_js" code="admin.members.detailTitleSuffix" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_action_emailTitle_js" code="admin.members.action.emailTitle" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_emailPlaceholder_js" code="admin.members.emailPlaceholder" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_action_saveEmail_js" code="admin.members.action.saveEmail" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_emailResetNotice_js" code="admin.members.emailResetNotice" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_emailCellHint_js" code="admin.members.emailCellHint" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_emailUpdated_js" code="admin.members.emailUpdated" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_info_js" code="admin.context.tab.info" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_logins_js" code="admin.context.tab.logins" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_security_js" code="admin.context.tab.security" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_emailHistoryTab_js" code="admin.members.emailHistoryTab" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_activity_js" code="admin.context.tab.activity" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_blocks_js" code="admin.context.tab.blocks" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_actions_js" code="admin.context.tab.actions" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_chatbot_js" code="admin.context.tab.chatbot" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_selectIp_js" code="admin.context.chatbotFilter.selectIp" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_f1_js" code="admin.context.chatbotFilter.f1" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_f1_tip_js" code="admin.context.chatbotFilter.f1.tip" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_f2_js" code="admin.context.chatbotFilter.f2" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_f2_tip_js" code="admin.context.chatbotFilter.f2.tip" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_f3_js" code="admin.context.chatbotFilter.f3" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_f3_tip_js" code="admin.context.chatbotFilter.f3.tip" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_f4_js" code="admin.context.chatbotFilter.f4" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_f4_tip_js" code="admin.context.chatbotFilter.f4.tip" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_f5_js" code="admin.context.chatbotFilter.f5" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_f5_tip_js" code="admin.context.chatbotFilter.f5.tip" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_chatbotFilter_loadFailed_js" code="admin.context.chatbotFilter.loadFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_empty_chatbotClicks_js" code="admin.context.empty.chatbotClicks" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_anonymous_js" code="admin.common.anonymous" javaScriptEscape="true"/>
<spring:message var="msg_admin_context_tab_more_js" code="admin.context.tab.more" javaScriptEscape="true"/>
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
<spring:message var="msg_admin_context_email_js" code="admin.context.email" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_emailVerified_js" code="admin.members.emailVerified" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_emailLoginEnabled_js" code="admin.members.emailLoginEnabled" javaScriptEscape="true"/>
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
<spring:message var="msg_admin_common_saveFailed_js" code="admin.common.saveFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_members_pageTitle" code="admin.members.pageTitle"/>
<spring:message var="msg_admin_status_ACTIVE" code="admin.status.ACTIVE"/>
<spring:message var="msg_admin_status_DORMANT" code="admin.status.DORMANT"/>
<spring:message var="msg_admin_status_BLOCKED" code="admin.status.BLOCKED"/>
<spring:message var="msg_admin_status_DELETED" code="admin.status.DELETED"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_context_userId" code="admin.context.userId"/>
<spring:message var="msg_admin_context_nickname" code="admin.context.nickname"/>
<spring:message var="msg_admin_context_email" code="admin.context.email"/>
<spring:message var="msg_admin_members_accountStatus" code="admin.members.accountStatus"/>
<spring:message var="msg_admin_common_role" code="admin.common.role"/>
<spring:message var="msg_admin_role_USER" code="admin.role.USER"/>
<spring:message var="msg_admin_role_BUSINESS" code="admin.role.BUSINESS"/>
<spring:message var="msg_admin_role_PARTNER" code="admin.role.PARTNER"/>
<spring:message var="msg_admin_role_BOT" code="admin.role.BOT"/>
<spring:message var="msg_admin_role_ADMIN" code="admin.role.ADMIN"/>
<spring:message var="msg_admin_members_socialLinked" code="admin.members.socialLinked"/>
<spring:message var="msg_admin_social_kakao" code="admin.social.kakao"/>
<spring:message var="msg_admin_social_naver" code="admin.social.naver"/>
<spring:message var="msg_admin_social_google" code="admin.social.google"/>
<spring:message var="msg_admin_members_noLinkedProvider" code="admin.members.noLinkedProvider"/>
<spring:message var="msg_admin_context_createdAt" code="admin.context.createdAt"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_members_reset" code="admin.members.reset"/>
<spring:message var="msg_admin_members_listTitle" code="admin.members.listTitle"/>
<spring:message var="msg_admin_common_export" code="admin.common.export"/>
<spring:message var="msg_admin_common_exportAll" code="admin.common.exportAll"/>
<spring:message var="msg_admin_common_exportFiltered" code="admin.common.exportFiltered"/>
<spring:message var="msg_admin_common_exportSelected" code="admin.common.exportSelected"/>
<spring:message var="msg_admin_blocks_mode_client" code="admin.blocks.mode.client"/>
<spring:message var="msg_admin_blocks_mode_server" code="admin.blocks.mode.server"/>
<spring:message var="msg_admin_common_pageSize" code="admin.common.pageSize"/>
<spring:message var="msg_admin_common_pageSizeLabel" code="admin.common.pageSizeLabel"/>
<spring:message var="msg_admin_common_pageSize_10" code="admin.common.pageSize" arguments="10"/>
<spring:message var="msg_admin_common_pageSize_20" code="admin.common.pageSize" arguments="20"/>
<spring:message var="msg_admin_common_pageSize_50" code="admin.common.pageSize" arguments="50"/>
<spring:message var="msg_admin_common_pageSize_100" code="admin.common.pageSize" arguments="100"/>
<spring:message var="msg_admin_common_selectedCount" code="admin.common.selectedCount"/>
<spring:message var="msg_admin_common_clearSelection" code="admin.common.clearSelection"/>
<spring:message var="msg_admin_common_apply" code="admin.common.apply"/>
<spring:message var="msg_admin_common_member" code="admin.common.member"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_members_social" code="admin.members.social"/>
<spring:message var="msg_admin_members_login" code="admin.members.login"/>
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_context_memberTitle" code="admin.context.memberTitle"/>
<spring:message var="msg_admin_common_loading" code="admin.common.loading"/>
<spring:message var="msg_admin_common_close" code="admin.common.close"/>
<spring:message var="msg_admin_members_blockModalTitle" code="admin.members.blockModalTitle"/>
<spring:message var="msg_admin_context_action_blockType" code="admin.context.action.blockType"/>
<spring:message var="msg_admin_context_blockType_userOnly" code="admin.context.blockType.userOnly"/>
<spring:message var="msg_admin_context_blockType_ipOnly" code="admin.context.blockType.ipOnly"/>
<spring:message var="msg_admin_context_blockType_userIp" code="admin.context.blockType.userIp"/>
<spring:message var="msg_admin_members_blockedIpLabel" code="admin.members.blockedIpLabel"/>
<spring:message var="msg_admin_members_blockExpiresLabel" code="admin.members.blockExpiresLabel"/>
<spring:message var="msg_admin_members_blockReasonLabel" code="admin.members.blockReasonLabel"/>
<spring:message var="msg_admin_context_action_applyBlock" code="admin.context.action.applyBlock"/>
<c:set var="activeMenu" value="members"/>


<c:set var="pageTitle"  value="${msg_admin_members_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ══════════════════════════════════════════
         검색 / 필터 바
    ══════════════════════════════════════════ --%>
    <div class="adm-card adm-member-filter-card">
        <div class="adm-card-body">
            <form id="searchForm" method="get" action="${pageContext.request.contextPath}/admin/members">
                <div class="adm-filter-bar">

                    <%-- 키워드 검색 --%>
                    <div class="adm-member-keyword-field">
                        <div class="adm-filter-label">${msg_admin_common_search}</div>
                        <div class="adm-member-search-row">
                            <select class="adm-select adm-member-search-type" name="searchType">
                                <option value="all"      ${search.searchType=='all'      ? 'selected' : ''}>${msg_admin_common_all}</option>
                                <option value="userId"   ${search.searchType=='userId'   ? 'selected' : ''}>${msg_admin_context_userId}</option>
                                <option value="nickname" ${search.searchType=='nickname' ? 'selected' : ''}>${msg_admin_context_nickname}</option>
                                <option value="email"    ${search.searchType=='email'    ? 'selected' : ''}>${msg_admin_context_email}</option>
                            </select>
                            <div class="adm-search-box adm-member-search-box">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword"
                                       value="${search.keyword}" placeholder="${msg_admin_members_searchPlaceholder}">
                            </div>
                        </div>
                    </div>

                    <%-- 상태 필터 --%>
                    <div>
                        <div class="adm-filter-label">${msg_admin_members_accountStatus}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ? 'selected' : ''}>${msg_admin_common_all}</option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ? 'selected' : ''}>${msg_admin_status_ACTIVE}</option>
                            <option value="DORMANT" ${search.status=='DORMANT' ? 'selected' : ''}>${msg_admin_status_DORMANT}</option>
                            <option value="DELETED" ${search.status=='DELETED' ? 'selected' : ''}>${msg_admin_status_DELETED}</option>
                            <option value="BLOCKED" ${search.status=='BLOCKED' ? 'selected' : ''}>${msg_admin_status_BLOCKED}</option>
                        </select>
                    </div>

                    <%-- 권한 필터 --%>
                    <div>
                        <div class="adm-filter-label">${msg_admin_common_role}</div>
                        <select class="adm-select" name="role">
                            <option value="ALL"   ${search.role=='ALL'   ? 'selected' : ''}>${msg_admin_common_all}</option>
                            <option value="USER"  ${search.role=='USER'  ? 'selected' : ''}>${msg_admin_role_USER}</option>
                            <option value="BUSINESS" ${search.role=='BUSINESS' ? 'selected' : ''}>${msg_admin_role_BUSINESS}</option>
                            <option value="PARTNER"  ${search.role=='PARTNER'  ? 'selected' : ''}>${msg_admin_role_PARTNER}</option>
                            <option value="BOT"      ${search.role=='BOT'      ? 'selected' : ''}>${msg_admin_role_BOT}</option>
                            <option value="ADMIN" ${search.role=='ADMIN' ? 'selected' : ''}>${msg_admin_role_ADMIN}</option>
                        </select>
                    </div>

                    <%-- 소셜 필터 --%>
                    <div>
                        <div class="adm-filter-label">${msg_admin_members_socialLinked}</div>
                        <select class="adm-select" name="provider">
                            <option value="ALL"    ${search.provider=='ALL'    ? 'selected' : ''}>${msg_admin_common_all}</option>
                            <option value="KAKAO"  ${search.provider=='KAKAO'  ? 'selected' : ''}>${msg_admin_social_kakao}</option>
                            <option value="NAVER"  ${search.provider=='NAVER'  ? 'selected' : ''}>${msg_admin_social_naver}</option>
                            <option value="GOOGLE" ${search.provider=='GOOGLE' ? 'selected' : ''}>${msg_admin_social_google}</option>
                            <option value="NONE"   ${search.provider=='NONE'   ? 'selected' : ''}>${msg_admin_members_noLinkedProvider}</option>
                        </select>
                    </div>

                    <%-- 가입일 범위 --%>
                    <div>
                        <div class="adm-filter-label">${msg_admin_context_createdAt}</div>
                        <div class="adm-member-date-row">
                            <input class="adm-input adm-member-date-input" type="date" name="dateFrom"
                                   value="${search.dateFrom}">
                            <span class="adm-member-date-sep">~</span>
                            <input class="adm-input adm-member-date-input" type="date" name="dateTo"
                                   value="${search.dateTo}">
                        </div>
                    </div>

                    <%-- 버튼 --%>
                    <div class="adm-member-filter-actions">
                        <button type="submit" class="adm-btn adm-btn-primary">🔍 ${msg_admin_common_searchButton}</button>
                        <button type="button" class="adm-btn adm-btn-ghost" onclick="resetMemberFilters()">${msg_admin_members_reset}</button>
                    </div>

                    <input type="hidden" name="page" value="1">
                    <input type="hidden" name="size" value="${search.size}">
                    <input type="hidden" id="sortByInput" name="sortBy" value="${search.sortBy}">
                    <input type="hidden" id="sortDirInput" name="sortDir" value="${search.sortDir}">
                </div>
            </form>
        </div>
    </div>

    <%-- ══════════════════════════════════════════
         회원 목록 테이블
    ══════════════════════════════════════════ --%>
    <div class="adm-card js-member-section-card adm-overflow-visible" data-section="members" data-enhanced="true">
        <div class="adm-card-head adm-member-list-head">
            <div class="adm-card-title">
                👥 ${msg_admin_members_listTitle}
                <span id="memberTotalLabel" class="adm-member-total-label">
                    <spring:message var="msg_admin_members_totalMembers_args_total" code="admin.members.totalMembers" arguments="${total}"/>${msg_admin_members_totalMembers_args_total}
                </span>
            </div>
            <div class="adm-member-export-control adm-export-control">
                <select class="adm-select adm-member-export-format" id="exportFormat">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-export-toggle">${msg_admin_common_export} ▾</button>
                <div id="exportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="exportData('all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="exportData('search')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item" id="exportSelectedBtn" disabled onclick="exportData('selected')">${msg_admin_common_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <div class="adm-member-controlbar">
            <%-- 일괄 처리 바: 선택 전에도 슬롯을 유지해 보기 도구 위치가 튀지 않도록 한다. --%>
            <div id="bulkBar" class="adm-member-bulkbar" aria-live="polite">
                <span class="adm-member-bulk-count"><strong id="bulkCount">0</strong>${msg_admin_common_selectedCount}</span>
                <div class="adm-member-bulk-actions">
                    <select class="adm-select" id="bulkStatusSelect">
                        <option value="">상태 선택</option>
                        <option value="ACTIVE">${msg_admin_status_ACTIVE}</option>
                        <option value="DORMANT">${msg_admin_status_DORMANT}</option>
                        <option value="BLOCKED">${msg_admin_status_BLOCKED}</option>
                        <option value="DELETED">${msg_admin_status_DELETED}</option>
                    </select>
                    <button type="button" class="adm-btn adm-btn-primary adm-member-bulk-apply" onclick="applyBulkStatus()">${msg_admin_common_apply}</button>
                </div>
                <button type="button" class="adm-btn adm-btn-ghost adm-member-bulk-clear" onclick="clearSelection()">${msg_admin_common_clearSelection}</button>
            </div>

            <div class="adm-member-view-tools">
                <div id="memberPrimaryTools" class="adm-member-primary-tools">
                    <button type="button" class="adm-dash-sort-reset js-member-sort-reset adm-member-tool-item adm-member-sort-reset adm-is-hidden" onclick="resetMemberSort()"></button>
                    <label class="adm-member-tool-item adm-member-tool adm-member-mode-tool">
                        <span class="adm-member-tool-label">${msg_admin_blocks_mode_label}</span>
                        <select class="adm-select js-member-section-mode" id="memberModeSelect" title="${msg_admin_blocks_mode_label}">
                            <option value="client" title="${msg_admin_blocks_mode_tipClient}">${msg_admin_blocks_mode_client}</option>
                            <option value="server" title="${msg_admin_blocks_mode_tipServer}">${msg_admin_blocks_mode_server}</option>
                        </select>
                    </label>
                    <label class="adm-member-tool-item adm-member-tool adm-member-size-tool">
                        <span class="adm-member-tool-label">${msg_admin_common_pageSizeLabel}</span>
                        <select class="adm-select js-member-page-size" id="sizeSelect" onchange="changeSize(this.value)">
                            <option value="10"  ${search.size==10  ? 'selected' : ''}>${msg_admin_common_pageSize_10}</option>
                            <option value="20"  ${search.size==20  ? 'selected' : ''}>${msg_admin_common_pageSize_20}</option>
                            <option value="50"  ${search.size==50  ? 'selected' : ''}>${msg_admin_common_pageSize_50}</option>
                            <option value="100" ${search.size==100 ? 'selected' : ''}>${msg_admin_common_pageSize_100}</option>
                        </select>
                    </label>
                </div>
                <div class="adm-member-overflow-menu" id="memberOverflowMenu">
                    <button type="button" class="adm-btn adm-btn-ghost adm-member-overflow-toggle" aria-expanded="false" aria-controls="memberOverflowPanel">옵션 ▾</button>
                    <div id="memberOverflowPanel" class="adm-member-overflow-panel"></div>
                </div>
            </div>
        </div>

        <div class="adm-table-wrap adm-overflow-visible">
            <table class="adm-table adm-section-table-fixed adm-member-section-table" data-admin-list-ignore="true" data-section="members">
                <thead>
                <tr>
                    <th class="adm-member-check-head">
                        <input type="checkbox" id="checkAll" class="adm-check" onchange="toggleAll(this)">
                    </th>
                    <th class="js-member-sort" data-sort="nickname" onclick="memberSortBy('nickname')">
                        ${msg_admin_common_member}
                    </th>
                    <th class="js-member-sort" data-sort="email" onclick="memberSortBy('email')">
                        ${msg_admin_context_email}
                    </th>
                    <th class="js-member-sort" data-sort="status" onclick="memberSortBy('status')">
                        ${msg_admin_common_status}
                    </th>
                    <th class="js-member-sort" data-sort="role" onclick="memberSortBy('role')">
                        ${msg_admin_common_role}
                    </th>
                    <th class="js-member-sort" data-sort="social" onclick="memberSortBy('social')">
                        ${msg_admin_members_social}
                    </th>
                    <th class="js-member-sort" data-sort="lastLoginAt" onclick="memberSortBy('lastLoginAt')">
                        ${msg_admin_members_login}
                    </th>
                    <th class="js-member-sort" data-sort="createdAt" onclick="memberSortBy('createdAt')">
                        ${msg_admin_context_createdAt}
                    </th>
                    <th onclick="openFirstMemberDetail('actions')">${msg_admin_members_detail}</th>
                </tr>
                </thead>
                <tbody id="memberRowsBody">
                <%@ include file="_memberRowsFragment.jsp" %>
                </tbody>
            </table>
        </div>

        <%-- 페이징 --%>
        <div class="adm-local-pagination" data-section="members" id="memberPaging">
            <div class="adm-local-page-info js-member-page-info" data-section="members">총 ${total}건 / 현재 ${fn:length(list)}건</div>
            <div class="adm-local-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost js-member-prev" onclick="goPage(memberSectionState.page - 1)">${msg_admin_common_prev}</button>
                <span class="js-member-page-state" data-section="members">${paging.currentPage} / ${paging.totalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost js-member-next" onclick="goPage(memberSectionState.page + 1)">${msg_admin_common_next}</button>
            </div>
        </div>
    </div>
</div>

<%-- ══════════════════════════════════════════
     회원 상세 모달
══════════════════════════════════════════ --%>
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
    <div class="adm-modal adm-modal-sm">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockModalTitle">${msg_admin_members_blockModalTitle}</div>
            <button class="adm-modal-close" onclick="closeBlockModal()">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="blockUserIdx">
            <div class="sa-form-group">
                <label class="sa-form-label">${msg_admin_context_action_blockType}</label>
                <select id="blockType" class="adm-select adm-full-control" onchange="handleBlockTypeChange()">
                    <option value="USER_ONLY">${msg_admin_context_blockType_userOnly}</option>
                    <option value="IP_ONLY">${msg_admin_context_blockType_ipOnly}</option>
                    <option value="USER_IP">${msg_admin_context_blockType_userIp}</option>
                </select>
            </div>
            <div class="sa-form-group">
                <label class="sa-form-label">${msg_admin_members_blockedIpLabel}</label>
                <input id="blockedIp" class="adm-input" type="text" placeholder="${msg_admin_context_action_blockIpPlaceholder}">
            </div>
            <div class="sa-form-group">
                <label class="sa-form-label">${msg_admin_members_blockExpiresLabel}</label>
                <input id="blockedUntil" class="adm-input" type="datetime-local">
            </div>
            <div class="sa-form-group">
                <label class="sa-form-label">${msg_admin_members_blockReasonLabel}</label>
                <textarea id="blockedReason" class="adm-input adm-textarea-compact" placeholder="${msg_admin_context_action_reasonPlaceholder}"></textarea>
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

/* ── 회원 목록: 차단 관리형 서버/클라이언트 섹션 로직 ── */
const MEMBER_DEFAULT_SORT_BY = 'createdAt';
const MEMBER_DEFAULT_SORT_DIR = 'DESC';
const MEMBER_MODE_STORAGE = 'admMemberSectionMode';
const MEMBER_MODE_COOKIE = 'admMemberMode';
const MEMBER_CLIENT_MAX_SIZE = 10000;

var memberSectionState = {
    page: 1,
    pageSize: 20,
    sortBy: '',
    sortDir: 'ASC',
    mode: 'SERVER',
    clientRows: null,
    clientFilterKey: '',
    clientTotal: 0
};

function getSearchForm() {
    return document.getElementById('searchForm');
}

function getMemberTbody() {
    return document.getElementById('memberRowsBody');
}

function getMemberSearchFilterKey() {
    const form = getSearchForm();
    if (!form) return '';
    const params = new URLSearchParams();
    new FormData(form).forEach(function (val, key) {
        if (['page', 'size', 'sortBy', 'sortDir', 'mode'].includes(key)) return;
        if (val != null && String(val).trim().length > 0) params.append(key, String(val).trim());
    });
    return params.toString();
}

function buildMemberParams(pageOverride, options) {
    options = options || {};
    const form = getSearchForm();
    const params = new URLSearchParams();
    if (form) {
        new FormData(form).forEach(function (val, key) {
            if (['page', 'size', 'sortBy', 'sortDir', 'mode'].includes(key)) return;
            if (val != null && String(val).trim().length > 0) params.append(key, String(val).trim());
        });
    }
    const targetPage = pageOverride != null ? Number(pageOverride) : Number(memberSectionState.page || 1);
    params.set('page', String(Math.max(1, targetPage || 1)));
    params.set('size', String(options.clientFetch ? MEMBER_CLIENT_MAX_SIZE : (memberSectionState.pageSize || 20)));
    params.set('mode', options.clientFetch ? 'CLIENT' : memberSectionState.mode);
    if (options.includeSort !== false && memberSectionState.sortBy) {
        params.set('sortBy', memberSectionState.sortBy);
        params.set('sortDir', memberSectionState.sortDir === 'DESC' ? 'DESC' : 'ASC');
    }
    return params;
}

function syncMemberHiddenInputs() {
    const form = getSearchForm();
    if (!form) return;
    const pageInput = form.querySelector('[name=page]');
    const sizeInput = form.querySelector('[name=size]');
    const sortByInput = document.getElementById('sortByInput');
    const sortDirInput = document.getElementById('sortDirInput');
    if (pageInput) pageInput.value = String(memberSectionState.page || 1);
    if (sizeInput) sizeInput.value = String(memberSectionState.pageSize || 20);
    if (sortByInput) sortByInput.value = memberSectionState.sortBy || '';
    if (sortDirInput) sortDirInput.value = memberSectionState.sortBy ? memberSectionState.sortDir : '';
}

function setMemberModeCookie(mode) {
    document.cookie = MEMBER_MODE_COOKIE + '=' + (mode === 'CLIENT' ? 'client' : 'server') + ';path=' + (ctx || '/') + ';max-age=31536000;samesite=lax';
}

function loadStoredMemberMode() {
    try {
        const stored = localStorage.getItem(MEMBER_MODE_STORAGE);
        return stored === 'CLIENT' ? 'CLIENT' : 'SERVER';
    } catch (e) {
        return 'SERVER';
    }
}

function saveMemberMode(mode) {
    memberSectionState.mode = mode === 'CLIENT' ? 'CLIENT' : 'SERVER';
    try { localStorage.setItem(MEMBER_MODE_STORAGE, memberSectionState.mode); } catch (e) {}
    setMemberModeCookie(memberSectionState.mode);
    const select = document.getElementById('memberModeSelect');
    if (select) select.value = memberSectionState.mode === 'CLIENT' ? 'client' : 'server';
}

function updateMemberSortIndicators() {
    document.querySelectorAll('th[data-sort]').forEach(function (th) {
        const active = !!memberSectionState.sortBy && th.dataset.sort === memberSectionState.sortBy;
        th.classList.toggle('sorted', active);
        let ico = th.querySelector('.sort-ico');
        if (active) {
            if (!ico) {
                ico = document.createElement('span');
                ico.className = 'sort-ico';
                th.appendChild(ico);
            }
            const desc = memberSectionState.sortDir === 'DESC';
            ico.className = 'sort-ico ' + (desc ? 'desc' : 'asc');
            ico.textContent = desc ? '▼' : '▲';
        } else if (ico) {
            ico.remove();
        }
    });
    const resetBtn = document.querySelector('.js-member-sort-reset');
    if (resetBtn) {
        resetBtn.textContent = ADMIN_MEMBER_MSG.dashSortReset;
        resetBtn.classList.toggle('adm-is-hidden', !memberSectionState.sortBy);
    }
    syncMemberControlOverflow();
}

function updateMemberTotal(total) {
    const totalLabel = document.getElementById('memberTotalLabel');
    if (totalLabel) totalLabel.textContent = '총 ' + Number(total || 0).toLocaleString() + '명';
}

function updateMemberPaginationMeta(page, totalPages, total, renderedCount) {
    const safePages = Math.max(1, Number(totalPages || 1));
    const safePage = Math.min(Math.max(1, Number(page || 1)), safePages);
    memberSectionState.page = safePage;
    const pageInfo = document.querySelector('.js-member-page-info');
    if (pageInfo) {
        const totalText = ADMIN_MEMBER_MSG.totalCountFormat.replace('{0}', Number(total || 0).toLocaleString());
        const currentText = ADMIN_MEMBER_MSG.currentCountFormat.replace('{0}', Number(renderedCount || 0).toLocaleString());
        pageInfo.textContent = totalText + ' / ' + currentText;
    }
    const pageState = document.querySelector('.js-member-page-state');
    if (pageState) pageState.textContent = safePage + ' / ' + safePages;
    const prevBtn = document.querySelector('.js-member-prev');
    const nextBtn = document.querySelector('.js-member-next');
    if (prevBtn) prevBtn.disabled = safePage <= 1;
    if (nextBtn) nextBtn.disabled = safePage >= safePages;
    updateMemberTotal(total);
    syncMemberHiddenInputs();
}

function memberSortValue(row, field) {
    if (!row || !field) return '';
    if (field === 'email') return row.dataset.email || '';
    if (field === 'status') return row.dataset.status || '';
    if (field === 'role') return row.dataset.role || '';
    if (field === 'lastLoginAt') return row.dataset.lastLoginAt || '0';
    if (field === 'createdAt') return row.dataset.createdAt || '0';
    if (field === 'social' || field === 'socialCount') {
        const count = Number(row.dataset.socialCount || '0');
        const rank = Number(row.dataset.socialRank || '0');
        return String((Number.isFinite(count) ? count : 0) * 100 + (Number.isFinite(rank) ? rank : 0));
    }
    return row.dataset.nickname || '';
}

function compareMemberRows(a, b) {
    const field = memberSectionState.sortBy;
    if (!field) {
        return Number(a.dataset.originalIndex || 0) - Number(b.dataset.originalIndex || 0);
    }
    const av = memberSortValue(a, field);
    const bv = memberSortValue(b, field);
    const an = Number(av);
    const bn = Number(bv);
    let cmp;
    if (!Number.isNaN(an) && !Number.isNaN(bn) && /^-?\d+(\.\d+)?$/.test(String(av)) && /^-?\d+(\.\d+)?$/.test(String(bv))) {
        cmp = an - bn;
    } else {
        cmp = String(av).localeCompare(String(bv), ADMIN_MEMBER_LOCALE || undefined, {numeric: true, sensitivity: 'base'});
    }
    return cmp * (memberSectionState.sortDir === 'DESC' ? -1 : 1);
}

function markOriginalIndices(rows) {
    rows.forEach(function (row, idx) {
        if (row.dataset.originalIndex == null) row.dataset.originalIndex = String(idx);
    });
}

function renderMemberEmptyRow() {
    return '<tr class="adm-local-empty"><td colspan="9" class="adm-local-empty-cell">' + escapeHtml(ADMIN_MEMBER_MSG.noResults) + '</td></tr>';
}

async function renderServerMembers(pageOverride) {
    memberSectionState.mode = 'SERVER';
    const params = buildMemberParams(pageOverride, {includeSort: true});
    const tbody = getMemberTbody();
    if (!tbody) return;
    tbody.classList.add('is-loading');
    try {
        const res = await fetch(ctx + '/admin/members/fragment?' + params.toString(), {
            credentials: 'same-origin',
            headers: {'Accept': 'text/html', 'X-Requested-With': 'XMLHttpRequest'}
        });
        const html = await res.text();
        if (!res.ok) throw new Error(html || '목록을 불러오지 못했습니다.');
        tbody.innerHTML = html.trim() || renderMemberEmptyRow();
        const rows = Array.from(tbody.querySelectorAll('.js-member-row'));
        markOriginalIndices(rows);
        const total = Number(res.headers.get('X-Section-Total') || rows.length || 0);
        const page = Number(res.headers.get('X-Section-Page') || params.get('page') || 1);
        const size = Number(res.headers.get('X-Section-Size') || memberSectionState.pageSize || 20);
        const pages = Number(res.headers.get('X-Section-Pages') || 1);
        memberSectionState.pageSize = [10,20,50,100].includes(size) ? size : memberSectionState.pageSize;
        const sizeSelect = document.getElementById('sizeSelect');
        if (sizeSelect) sizeSelect.value = String(memberSectionState.pageSize);
        updateMemberPaginationMeta(page, pages, total, rows.length);
        updateMemberSortIndicators();
        clearSelection();
    } catch (e) {
        adm_toast(e.message || '목록을 불러오지 못했습니다.', 'error');
    } finally {
        tbody.classList.remove('is-loading');
    }
}

async function ensureClientMemberRows() {
    const filterKey = getMemberSearchFilterKey();
    if (memberSectionState.clientRows && memberSectionState.clientFilterKey === filterKey) return;
    const params = buildMemberParams(1, {clientFetch: true, includeSort: false});
    const res = await fetch(ctx + '/admin/members/fragment?' + params.toString(), {
        credentials: 'same-origin',
        headers: {'Accept': 'text/html', 'X-Requested-With': 'XMLHttpRequest'}
    });
    const html = await res.text();
    if (!res.ok) throw new Error(html || '전체 목록을 불러오지 못했습니다.');
    const temp = document.createElement('tbody');
    temp.innerHTML = html;
    const rows = Array.from(temp.querySelectorAll('.js-member-row'));
    markOriginalIndices(rows);
    memberSectionState.clientRows = rows;
    memberSectionState.clientFilterKey = filterKey;
    memberSectionState.clientTotal = Number(res.headers.get('X-Section-Total') || rows.length || 0);
}

async function renderClientMembers(pageOverride) {
    memberSectionState.mode = 'CLIENT';
    const tbody = getMemberTbody();
    if (!tbody) return;
    tbody.classList.add('is-loading');
    try {
        await ensureClientMemberRows();
        let rows = (memberSectionState.clientRows || []).slice();
        rows.sort(compareMemberRows);
        const total = rows.length;
        const pageSize = memberSectionState.pageSize || 20;
        const totalPages = Math.max(1, Math.ceil(total / pageSize));
        const page = Math.min(Math.max(1, Number(pageOverride || memberSectionState.page || 1)), totalPages);
        const start = (page - 1) * pageSize;
        const visible = rows.slice(start, start + pageSize);
        tbody.innerHTML = '';
        if (visible.length === 0) {
            tbody.innerHTML = renderMemberEmptyRow();
        } else {
            visible.forEach(function (row) { tbody.appendChild(row.cloneNode(true)); });
        }
        updateMemberPaginationMeta(page, totalPages, total, visible.length);
        updateMemberSortIndicators();
        clearSelection();
    } catch (e) {
        adm_toast(e.message || '전체 목록을 불러오지 못했습니다.', 'error');
    } finally {
        tbody.classList.remove('is-loading');
    }
}

async function renderMemberByMode(pageOverride) {
    if (memberSectionState.mode === 'CLIENT') {
        return renderClientMembers(pageOverride);
    }
    return renderServerMembers(pageOverride);
}

async function reloadMemberRows(pageOverride) {
    if (memberSectionState.mode === 'CLIENT') memberSectionState.clientRows = null;
    return renderMemberByMode(pageOverride || memberSectionState.page || 1);
}

async function refreshMemberSection() {
    if (memberSectionState.mode === 'CLIENT') memberSectionState.clientRows = null;
    return renderMemberByMode(memberSectionState.page || 1);
}

function memberSortBy(field) {
    const prevField = memberSectionState.sortBy || '';
    const prevDir = memberSectionState.sortDir || 'ASC';
    memberSectionState.sortBy = field;
    memberSectionState.sortDir = (prevField === field && prevDir === 'ASC') ? 'DESC' : 'ASC';
    memberSectionState.page = 1;
    renderMemberByMode(1);
}

function resetMemberSort() {
    memberSectionState.sortBy = '';
    memberSectionState.sortDir = 'ASC';
    memberSectionState.page = 1;
    renderMemberByMode(1);
}

function resetMemberFilters() {
    const form = getSearchForm();
    if (form) {
        const setValue = function (name, value) {
            const el = form.querySelector('[name=' + name + ']');
            if (el) el.value = value;
        };
        setValue('searchType', 'all');
        setValue('keyword', '');
        setValue('status', 'ALL');
        setValue('role', 'ALL');
        setValue('provider', 'ALL');
        setValue('dateFrom', '');
        setValue('dateTo', '');
    }
    memberSectionState.page = 1;
    memberSectionState.sortBy = '';
    memberSectionState.sortDir = 'ASC';
    memberSectionState.clientRows = null;
    renderMemberByMode(1);
}

function goPage(p) {
    const page = Math.max(1, Number(p || 1));
    renderMemberByMode(page);
}

function changeSize(size) {
    const parsed = Number(size);
    memberSectionState.pageSize = [10, 20, 50, 100].includes(parsed) ? parsed : 20;
    memberSectionState.page = 1;
    syncMemberHiddenInputs();
    renderMemberByMode(1);
}

/* ── 체크박스 ── */
function toggleAll(cb) {
    document.querySelectorAll('.js-row-check').forEach(function (c) { c.checked = cb.checked; });
    updateBulkBar();
}
function updateBulkBar() {
    const checked = document.querySelectorAll('.js-row-check:checked');
    const n = checked.length;
    const bulkBar = document.getElementById('bulkBar');
    if (bulkBar) {
        bulkBar.classList.toggle('is-active', n > 0);
        bulkBar.setAttribute('aria-hidden', n > 0 ? 'false' : 'true');
        bulkBar.querySelectorAll('select, button').forEach(function (control) {
            control.disabled = n === 0;
        });
    }
    const bulkCount = document.getElementById('bulkCount');
    if (bulkCount) bulkCount.textContent = n;
    const bulkStatusSelect = document.getElementById('bulkStatusSelect');
    if (bulkStatusSelect && n === 0) bulkStatusSelect.value = '';
    const selBtn = document.getElementById('exportSelectedBtn');
    if (selBtn) {
        selBtn.disabled = n === 0;
        selBtn.classList.toggle('has-selection', n > 0);
        selBtn.textContent = ADMIN_MEMBER_MSG.exportSelected + ' (' + n + ')';
    }
    const all = document.getElementById('checkAll');
    if (all) {
        const rows = document.querySelectorAll('.js-row-check');
        all.checked = rows.length > 0 && n === rows.length;
        all.indeterminate = n > 0 && n < rows.length;
    }
}
function clearSelection() {
    document.querySelectorAll('.js-row-check, #checkAll').forEach(function (c) {
        c.checked = false;
        c.indeterminate = false;
    });
    updateBulkBar();
}

/* ── 일괄 상태 변경 ── */
async function applyBulkStatus() {
    const status = document.getElementById('bulkStatusSelect').value;
    if (!status) { adm_toast('상태를 선택해주세요.', 'error'); return; }
    const ids = Array.from(document.querySelectorAll('.js-row-check:checked')).map(function (c) { return c.value; });
    if (!ids.length) { adm_toast('선택된 항목이 없습니다.', 'error'); return; }
    if (!confirm(ids.length + '명의 상태를 "' + status + '"(으)로 변경하시겠습니까?')) return;
    const params = new URLSearchParams();
    ids.forEach(function (id) { params.append('userIdxList', id); });
    params.append('status', status);
    const res = await fetch(ctx + '/admin/members/bulk/status', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
    });
    const data = await res.json();
    if (res.ok && data.success) {
        adm_toast(data.message);
        document.getElementById('bulkStatusSelect').value = '';
        await refreshMemberSection();
    } else {
        adm_toast(data.message || '처리 중 오류가 발생했습니다.', 'error');
    }
}

/* ── 내보내기 ── */
function exportData(scope) {
    const format = document.getElementById('exportFormat').value;
    const params = buildMemberParams(null, {includeSort: true});
    params.delete('page');
    params.set('scope', scope);
    params.set('format', format);
    if (scope === 'selected') {
        const ids = Array.from(document.querySelectorAll('.js-row-check:checked')).map(function (c) { return c.value; });
        if (!ids.length) { adm_toast('선택된 항목이 없습니다.', 'error'); return; }
        params.set('selectedIds', ids.join(','));
    }
    const exportDropdown = document.getElementById('exportDropdown');
    if (exportDropdown) exportDropdown.classList.remove('open');
    window.location.href = ctx + '/admin/members/export?' + params.toString();
}

let memberControlOverflowSync = null;

function isVisibleMemberTool(tool) {
    if (!tool) return false;
    return !tool.classList.contains('js-member-sort-reset') || !tool.classList.contains('adm-is-hidden');
}

function syncMemberControlOverflow() {
    if (typeof memberControlOverflowSync === 'function') memberControlOverflowSync();
}

function initMemberControlOverflow() {
    const primary = document.getElementById('memberPrimaryTools');
    const menu = document.getElementById('memberOverflowMenu');
    const panel = document.getElementById('memberOverflowPanel');
    const toggle = menu ? menu.querySelector('.adm-member-overflow-toggle') : null;
    if (!primary || !menu || !panel || !toggle) return;

    const tools = [
        { node: document.querySelector('.adm-member-sort-reset'), breakpoint: 1380 },
        { node: document.querySelector('.adm-member-mode-tool'), breakpoint: 1180 },
        { node: document.querySelector('.adm-member-size-tool'), breakpoint: 980 }
    ].filter(function (item) { return !!item.node; });

    memberControlOverflowSync = function () {
        const width = window.innerWidth || document.documentElement.clientWidth || 1600;
        tools.forEach(function (item) {
            const target = width <= item.breakpoint ? panel : primary;
            if (item.node.parentElement !== target) target.appendChild(item.node);
        });
        const hasItems = Array.from(panel.children).some(isVisibleMemberTool);
        menu.classList.toggle('has-items', hasItems);
        if (!hasItems) {
            menu.classList.remove('open');
            toggle.setAttribute('aria-expanded', 'false');
        }
    };

    toggle.addEventListener('click', function () {
        const willOpen = !menu.classList.contains('open');
        menu.classList.toggle('open', willOpen);
        toggle.setAttribute('aria-expanded', willOpen ? 'true' : 'false');
    });
    document.addEventListener('click', function (e) {
        if (!menu.contains(e.target)) {
            menu.classList.remove('open');
            toggle.setAttribute('aria-expanded', 'false');
        }
    });
    window.addEventListener('resize', syncMemberControlOverflow, { passive: true });
    syncMemberControlOverflow();
}

function initMemberSection() {
    const sizeSelect = document.getElementById('sizeSelect');
    memberSectionState.pageSize = Number(sizeSelect ? sizeSelect.value : 20) || 20;
    memberSectionState.page = Number((getSearchForm() && getSearchForm().querySelector('[name=page]') || {}).value || 1) || 1;
    saveMemberMode(loadStoredMemberMode());

    const modeSelect = document.getElementById('memberModeSelect');
    if (modeSelect) {
        modeSelect.addEventListener('change', function () {
            saveMemberMode(modeSelect.value === 'client' ? 'CLIENT' : 'SERVER');
            memberSectionState.page = 1;
            memberSectionState.clientRows = null;
            renderMemberByMode(1);
        });
    }
    const form = getSearchForm();
    if (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            memberSectionState.page = 1;
            memberSectionState.clientRows = null;
            renderMemberByMode(1);
        });
    }
    const exportToggle = document.querySelector('.js-export-toggle');
    const exportDropdown = document.getElementById('exportDropdown');
    if (exportToggle && exportDropdown) {
        exportToggle.addEventListener('click', function () { exportDropdown.classList.toggle('open'); });
        document.addEventListener('click', function (e) {
            if (!exportToggle.contains(e.target) && !exportDropdown.contains(e.target)) exportDropdown.classList.remove('open');
        });
    }

    const existingRows = Array.from(document.querySelectorAll('#memberRowsBody .js-member-row'));
    markOriginalIndices(existingRows);
    updateMemberPaginationMeta(memberSectionState.page, Number((document.querySelector('.js-member-page-state') || {}).textContent?.split('/')[1] || 1), Number('${total}' || existingRows.length), existingRows.length);
    updateMemberSortIndicators();
    updateBulkBar();
    initMemberControlOverflow();
    if (memberSectionState.mode === 'CLIENT') renderMemberByMode(1);
}

document.addEventListener('DOMContentLoaded', initMemberSection);

const ADMIN_MEMBER_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const ADMIN_MEMBER_MSG = {
    loading: '${msg_admin_common_loading_js}',
    dashSortReset: '${msg_admin_blocks_js_dashSortReset_js}',
    totalCountFormat: '${msg_admin_common_totalCountFormat_js}',
    currentCountFormat: '${msg_admin_common_currentCountFormat_js}',
    exportSelected: '${msg_admin_common_exportSelected_js}',
    noResults: '${msg_admin_common_noResults_js}',
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
    emailSectionTitle: '${msg_admin_members_action_emailTitle_js}',
    emailPlaceholder: '${msg_admin_members_emailPlaceholder_js}',
    saveEmail: '${msg_admin_members_action_saveEmail_js}',
    emailResetNotice: '${msg_admin_members_emailResetNotice_js}',
    emailCellHint: '${msg_admin_members_emailCellHint_js}',
    emailUpdated: '${msg_admin_members_emailUpdated_js}',
    infoTab: '${msg_admin_context_tab_info_js}',
    loginTab: '${msg_admin_context_tab_logins_js}',
    securityTab: '${msg_admin_context_tab_security_js}',
    emailHistoryTab: '${msg_admin_members_emailHistoryTab_js}',
    activityTab: '${msg_admin_context_tab_activity_js}',
    blockTab: '${msg_admin_context_tab_blocks_js}',
    actionsTab: '${msg_admin_context_tab_actions_js}',
    chatbotTab: '${msg_admin_context_tab_chatbot_js}',
    chatbotFilterSelectIp: '${msg_admin_context_chatbotFilter_selectIp_js}',
    chatbotFilterF1: '${msg_admin_context_chatbotFilter_f1_js}',
    chatbotFilterF1Tip: '${msg_admin_context_chatbotFilter_f1_tip_js}',
    chatbotFilterF2: '${msg_admin_context_chatbotFilter_f2_js}',
    chatbotFilterF2Tip: '${msg_admin_context_chatbotFilter_f2_tip_js}',
    chatbotFilterF3: '${msg_admin_context_chatbotFilter_f3_js}',
    chatbotFilterF3Tip: '${msg_admin_context_chatbotFilter_f3_tip_js}',
    chatbotFilterF4: '${msg_admin_context_chatbotFilter_f4_js}',
    chatbotFilterF4Tip: '${msg_admin_context_chatbotFilter_f4_tip_js}',
    chatbotFilterF5: '${msg_admin_context_chatbotFilter_f5_js}',
    chatbotFilterF5Tip: '${msg_admin_context_chatbotFilter_f5_tip_js}',
    chatbotFilterLoadFailed: '${msg_admin_context_chatbotFilter_loadFailed_js}',
    chatbotEmptyClicks: '${msg_admin_context_empty_chatbotClicks_js}',
    anonymous: '${msg_admin_common_anonymous_js}',
    tabMore: '${msg_admin_context_tab_more_js}'
};

let _chatbotDetailUserIdx = null;
let _detailTabsRo = null;

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
    return value ? escapeHtml(value) : '<span class="adm-muted-inline">—</span>';
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
        ? '<span class="adm-bool is-yes">✓ ' + escapeHtml(ADMIN_MEMBER_MSG.yes) + '</span>'
        : '<span class="adm-bool is-no">✗ ' + escapeHtml(ADMIN_MEMBER_MSG.no) + '</span>';
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

/* ── 액션 메뉴 토글 ── */
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
            setTimeout(() => refreshMemberSection(), 800);
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
        setTimeout(() => refreshMemberSection(), 800);
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
        setTimeout(() => refreshMemberSection(), 800);
    } else {
        adm_toast(data.message || '${msg_admin_context_toast_saveRoleFail_js}', 'error');
    }
}

function buildContextRows(items, renderer, emptyMessage) {
    if (!Array.isArray(items) || !items.length) {
        return '<div class="adm-context-empty is-compact">' + emptyMessage + '</div>';
    }
    return '<div class="adm-context-stack">' + items.map(renderer).join('') + '</div>';
}

function buildSecurityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div class="adm-context-record-head">'
            + '<div class="adm-context-record-title"><strong>' + escapeHtml(item.eventType || '-') + '</strong> / ' + escapeHtml(item.eventStage || '-') + '</div>'
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
            + '<div class="adm-context-record-title"><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.status || '-') + '</div>'
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
            + '<div class="adm-context-record-title"><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.used ? '${msg_admin_context_used_js}' : '${msg_admin_context_unused_js}') + '</div>'
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
            + '<div class="adm-context-record-title"><strong>' + escapeHtml(item.activityCode || '-') + '</strong> / ' + escapeHtml(item.activityDomain || item.activityType || '-') + '</div>'
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
            + '<div class="adm-context-record-title"><strong>' + escapeHtml(item.blockType || '-') + '</strong> / ' + escapeHtml(item.active ? 'ACTIVE' : 'INACTIVE') + '</div>'
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
            + '<div class="adm-context-record-line"><a href="' + ctx + escapeHtml(url) + '" target="_blank" class="adm-context-mono-link">' + escapeHtml(url) + '</a></div>'
            + '<div class="adm-context-record-code">'
            + 'conv #' + escapeHtml(item.conversationId || '-')
            + ' · msg #' + escapeHtml(item.messageId || '-')
            + ' · IP: ' + escapeHtml(item.ipAddress || '-')
            + (item.userIdx ? '' : ' · <span class="adm-context-warning-text">' + escapeHtml(ADMIN_MEMBER_MSG.anonymous) + '</span>')
            + '</div>'
            + '</div>';
    }, ADMIN_MEMBER_MSG.chatbotEmptyClicks);
}

function buildChatbotTab(initialClicks, loginAudits, userIdx) {
    _chatbotDetailUserIdx = userIdx;
    const ips = [];
    const seen = {};
    (loginAudits || []).forEach(function(a) {
        if (a.ipAddress && !seen[a.ipAddress]) {
            seen[a.ipAddress] = true;
            ips.push(a.ipAddress);
        }
    });

    let ipOptions = '<option value="">' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterSelectIp) + '</option>';
    ips.forEach(function(ip) {
        ipOptions += '<option value="' + escapeHtml(ip) + '">' + escapeHtml(ip) + '</option>';
    });

    return ''
        + '<div class="adm-chatbot-filter">'
        + '<span class="adm-chatbot-filter-label">IP</span>'
        + '<select id="chatbotIpSelect" class="adm-select adm-chatbot-ip-select" onchange="chatbotOnIpChange()">'
        + ipOptions
        + '</select>'
        + '<div class="adm-chatbot-mode-group" id="chatbotModeGroup">'
        + '<button type="button" class="adm-chatbot-mode-btn active" data-mode="1" title="' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF1Tip) + '" onclick="chatbotOnModeClick(this)">' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF1) + '</button>'
        + '<button type="button" class="adm-chatbot-mode-btn" data-mode="2" title="' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF2Tip) + '" onclick="chatbotOnModeClick(this)" disabled>' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF2) + '</button>'
        + '<button type="button" class="adm-chatbot-mode-btn" data-mode="3" title="' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF3Tip) + '" onclick="chatbotOnModeClick(this)" disabled>' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF3) + '</button>'
        + '<button type="button" class="adm-chatbot-mode-btn" data-mode="4" title="' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF4Tip) + '" onclick="chatbotOnModeClick(this)" disabled>' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF4) + '</button>'
        + '<button type="button" class="adm-chatbot-mode-btn" data-mode="5" title="' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF5Tip) + '" onclick="chatbotOnModeClick(this)" disabled>' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF5) + '</button>'
        + '</div>'
        + '</div>'
        + '<div id="chatbotClickRows">' + buildChatbotLinkClickRows(initialClicks) + '</div>';
}

function chatbotOnIpChange() {
    const ip = document.getElementById('chatbotIpSelect').value;
    document.querySelectorAll('#chatbotModeGroup .adm-chatbot-mode-btn').forEach(function(btn) {
        const mode = parseInt(btn.dataset.mode);
        if (mode === 1) return;
        if (ip) {
            btn.disabled = false;
        } else {
            btn.disabled = true;
            btn.classList.remove('active');
        }
    });
    if (!ip) {
        const f1 = document.querySelector('#chatbotModeGroup .adm-chatbot-mode-btn[data-mode="1"]');
        if (f1) f1.classList.add('active');
    }
    const activeBtn = document.querySelector('#chatbotModeGroup .adm-chatbot-mode-btn.active');
    const mode = activeBtn ? parseInt(activeBtn.dataset.mode) : 1;
    chatbotLoadFilter(_chatbotDetailUserIdx, ip || null, !ip ? 1 : mode);
}

function chatbotOnModeClick(btn) {
    if (btn.disabled) return;
    document.querySelectorAll('#chatbotModeGroup .adm-chatbot-mode-btn').forEach(function(b) { b.classList.remove('active'); });
    btn.classList.add('active');
    const ip = document.getElementById('chatbotIpSelect').value || null;
    chatbotLoadFilter(_chatbotDetailUserIdx, ip, parseInt(btn.dataset.mode));
}

async function chatbotLoadFilter(userIdx, ip, mode) {
    const rows = document.getElementById('chatbotClickRows');
    if (!rows) return;
    rows.innerHTML = '<div class="adm-context-empty is-compact">' + escapeHtml(ADMIN_MEMBER_MSG.loading) + '</div>';
    let url = ctx + '/admin/members/' + userIdx + '/chatbot-clicks?mode=' + (mode || 1);
    if (ip) url += '&ip=' + encodeURIComponent(ip);
    try {
        const res = await fetch(url);
        const data = await res.json();
        rows.innerHTML = buildChatbotLinkClickRows(Array.isArray(data.clicks) ? data.clicks : []);
    } catch (e) {
        rows.innerHTML = '<div class="adm-context-empty is-error is-compact">' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterLoadFailed) + '</div>';
    }
}

function buildActionTab(m) {
    return ''
        + '<div class="adm-context-actions-grid">'
        + '<div class="adm-context-panel" id="memberProfilePanel">'
        + '<div class="adm-context-panel-title">' + '${msg_admin_context_action_profileTitle_js}' + '</div>'
        + '<div class="detail-label">' + '${msg_admin_context_nickname_js}' + '</div><input id="memberProfileNickname" class="adm-input" type="text" value="' + escapeHtml(m.nickname || '') + '">'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_context_nationality_js}' + '</div><input id="memberProfileNationality" class="adm-input" type="text" value="' + escapeHtml(m.nationality || '') + '">'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_context_preferredLanguage_js}' + '</div><input id="memberProfileLang" class="adm-input" type="text" value="' + escapeHtml(m.preferredLang || '') + '">'
        + '<button type="button" class="adm-btn adm-btn-primary adm-context-panel-btn" onclick="saveMemberProfile(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_context_action_saveProfile_js}' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel" id="memberEmailPanel">'
        + '<div class="adm-context-panel-title">' + ADMIN_MEMBER_MSG.emailSectionTitle + '</div>'
        + '<div class="detail-label">' + '${msg_admin_context_email_js}' + '</div><input id="memberEmailInput" class="adm-input" type="email" placeholder="' + ADMIN_MEMBER_MSG.emailPlaceholder + '" value="' + escapeHtml(m.userEmail || '') + '">'
        + '<div class="adm-cell-link-note adm-context-field">' + escapeHtml(ADMIN_MEMBER_MSG.emailResetNotice) + '</div>'
        + '<div class="adm-context-inline-badges">'
        + '<span class="status-badge ' + (m.emailVerified ? 'ACTIVE' : 'DORMANT') + '">' + '${msg_admin_members_emailVerified_js}' + ': ' + (m.emailVerified ? escapeHtml(ADMIN_MEMBER_MSG.yes) : escapeHtml(ADMIN_MEMBER_MSG.no)) + '</span>'
        + '<span class="status-badge ' + (m.emailLoginEnabled ? 'ACTIVE' : 'DORMANT') + '">' + '${msg_admin_members_emailLoginEnabled_js}' + ': ' + (m.emailLoginEnabled ? escapeHtml(ADMIN_MEMBER_MSG.yes) : escapeHtml(ADMIN_MEMBER_MSG.no)) + '</span>'
        + '</div>'
        + '<button type="button" class="adm-btn adm-btn-primary adm-context-panel-btn" onclick="saveMemberEmail(' + escapeHtml(m.userIdx) + ', this)">' + ADMIN_MEMBER_MSG.saveEmail + '</button>'
        + '</div>'
        + '<div class="adm-context-panel" id="memberStatusRolePanel">'
        + '<div class="adm-context-panel-title">' + '${msg_admin_context_action_statusRoleTitle_js}' + '</div>'
        + '<div class="detail-label">' + '${msg_admin_members_accountStatus_js}' + '</div>'
        + '<div class="adm-context-action-row"><select id="memberStatusSelect" class="adm-select"><option value="ACTIVE">${msg_admin_status_ACTIVE_js}</option><option value="DORMANT">${msg_admin_status_DORMANT_js}</option><option value="BLOCKED">${msg_admin_status_BLOCKED_js}</option><option value="DELETED">${msg_admin_status_DELETED_js}</option></select><button type="button" class="adm-btn adm-btn-ghost" onclick="applyStatusFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_common_apply_js}' + '</button></div>'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_common_role_js}' + '</div>'
        + '<select id="memberRoleSelect" class="adm-select adm-context-full-control"><option value="USER">${msg_admin_role_USER_js}</option><option value="BUSINESS">${msg_admin_role_BUSINESS_js}</option><option value="PARTNER">${msg_admin_role_PARTNER_js}</option><option value="BOT">${msg_admin_role_BOT_js}</option><option value="ADMIN">${msg_admin_role_ADMIN_js}</option></select>'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_context_action_roleReason_js}' + '</div>'
        + '<input id="memberRoleReason" class="adm-input" type="text" maxlength="500" placeholder="' + '${msg_admin_context_action_roleReasonPlaceholder_js}' + '">'
        + '<button type="button" class="adm-btn adm-btn-ghost adm-context-panel-btn" onclick="applyRoleFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_context_action_changeRole_js}' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel" id="memberQuickBlockPanel">'
        + '<div class="adm-context-panel-title">' + '${msg_admin_context_action_quickBlockTitle_js}' + '</div>'
        + '<div class="detail-label">' + '${msg_admin_context_action_blockType_js}' + '</div><select id="detailBlockType" class="adm-select adm-context-full-control"><option value="USER_ONLY">' + '${msg_admin_context_blockType_userOnly_js}' + '</option><option value="IP_ONLY">' + '${msg_admin_context_blockType_ipOnly_js}' + '</option><option value="USER_IP">' + '${msg_admin_context_blockType_userIp_js}' + '</option></select>'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_context_blockedIp_js}' + '</div><input id="detailBlockedIp" class="adm-input" type="text" placeholder="' + '${msg_admin_context_action_blockIpPlaceholder_js}' + '">'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_context_action_blockExpires_js}' + '</div><input id="detailBlockedUntil" class="adm-input" type="datetime-local">'
        + '<div class="detail-label adm-context-field">' + '${msg_admin_common_reason_js}' + '</div><textarea id="detailBlockedReason" class="adm-input adm-context-textarea"></textarea>'
        + '<button type="button" class="adm-btn adm-btn-primary adm-context-panel-btn" onclick="submitDetailBlock(' + escapeHtml(m.userIdx) + ', this)">' + '${msg_admin_context_action_applyBlock_js}' + '</button>'
        + '</div>'
        + '</div>';
}

/* ── 회원 상세 모달 ── */
function openFirstMemberDetail(defaultTab) {
    const row = document.querySelector('#memberRowsBody .js-member-row');
    const userIdx = row ? row.dataset.userIdx : null;
    if (userIdx) openDetail(userIdx, defaultTab || 'actions');
}
async function openDetail(userIdx, defaultTab, focusSection) {
    document.getElementById('detailModal').classList.add('open');
    document.getElementById('modalBody').innerHTML =
        '<div class="adm-context-empty">' + escapeHtml(ADMIN_MEMBER_MSG.loading) + ' ⏳</div>';

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
    const loginAudits = Array.isArray(data.loginAudits) ? data.loginAudits : [];
    const activeTab = ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'chatbot', 'actions'].includes(defaultTab) ? defaultTab : 'info';

    document.getElementById('modalTitle').textContent = (m.nickname || ADMIN_MEMBER_MSG.memberDetailsTitle) + ' ' + ADMIN_MEMBER_MSG.memberDetailsSuffix;

    document.getElementById('modalBody').innerHTML = ''
        + '<div class="adm-tabs-nav" id="detailTabsNav">'
        + '<div class="adm-tabs">'
        + '<button class="adm-tab ' + (activeTab === 'info' ? 'active' : '') + '" data-tab="info">' + escapeHtml(ADMIN_MEMBER_MSG.infoTab) + '</button>'
        + '<button class="adm-tab ' + (activeTab === 'hist' ? 'active' : '') + '" data-tab="hist">' + escapeHtml(ADMIN_MEMBER_MSG.loginTab) + ' (' + h.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'security' ? 'active' : '') + '" data-tab="security">' + escapeHtml(ADMIN_MEMBER_MSG.securityTab) + ' (' + securityAudits.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'emails' ? 'active' : '') + '" data-tab="emails">' + escapeHtml(ADMIN_MEMBER_MSG.emailHistoryTab) + '</button>'
        + '<button class="adm-tab ' + (activeTab === 'activity' ? 'active' : '') + '" data-tab="activity">' + escapeHtml(ADMIN_MEMBER_MSG.activityTab) + ' (' + activityLogs.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'blocks' ? 'active' : '') + '" data-tab="blocks">' + escapeHtml(ADMIN_MEMBER_MSG.blockTab) + ' (' + recentBlocks.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'chatbot' ? 'active' : '') + '" data-tab="chatbot">' + escapeHtml(ADMIN_MEMBER_MSG.chatbotTab) + ' (' + chatbotLinkClicks.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'actions' ? 'active' : '') + '" data-tab="actions">' + escapeHtml(ADMIN_MEMBER_MSG.actionsTab) + '</button>'
        + '</div>'
        + '<div class="adm-tabs-more" id="detailTabsMore" hidden>'
        + '<button type="button" class="adm-tabs-more-btn" id="detailTabsMoreBtn">' + escapeHtml(ADMIN_MEMBER_MSG.tabMore) + '</button>'
        + '<div class="adm-tabs-dropdown" id="detailTabsDropdown" hidden></div>'
        + '</div>'
        + '</div>'
        + '<div id="tab-info" class="adm-tab-panel"' + (activeTab === 'info' ? '' : ' hidden') + '></div>'
        + '<div id="tab-hist" class="adm-tab-panel"' + (activeTab === 'hist' ? '' : ' hidden') + '></div>'
        + '<div id="tab-security" class="adm-tab-panel"' + (activeTab === 'security' ? '' : ' hidden') + '></div>'
        + '<div id="tab-emails" class="adm-tab-panel"' + (activeTab === 'emails' ? '' : ' hidden') + '></div>'
        + '<div id="tab-activity" class="adm-tab-panel"' + (activeTab === 'activity' ? '' : ' hidden') + '></div>'
        + '<div id="tab-blocks" class="adm-tab-panel"' + (activeTab === 'blocks' ? '' : ' hidden') + '></div>'
        + '<div id="tab-chatbot" class="adm-tab-panel"' + (activeTab === 'chatbot' ? '' : ' hidden') + '></div>'
        + '<div id="tab-actions" class="adm-tab-panel"' + (activeTab === 'actions' ? '' : ' hidden') + '></div>';

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
    document.getElementById('tab-chatbot').innerHTML = buildChatbotTab(chatbotLinkClicks, loginAudits, userIdx);
    document.getElementById('tab-actions').innerHTML = buildActionTab(m);
    initDetailTabsNav(activeTab);
    const statusSelect = document.getElementById('memberStatusSelect');
    const roleSelect = document.getElementById('memberRoleSelect');
    if (statusSelect) statusSelect.value = m.accountStatus || 'ACTIVE';
    if (roleSelect) roleSelect.value = m.userRole || 'USER';
    if (focusSection) {
        focusMemberSection(activeTab, focusSection);
    }
}

function focusMemberSection(activeTab, focusSection) {
    if (activeTab === 'actions') {
        const panelMap = {
            email: 'memberEmailPanel',
            statusRole: 'memberStatusRolePanel',
            quickBlock: 'memberQuickBlockPanel',
            profile: 'memberProfilePanel'
        };
        const targetId = panelMap[focusSection];
        const panel = targetId ? document.getElementById(targetId) : null;
        if (panel) {
            panel.classList.add('is-focus-flash');
            panel.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            const focusable = panel.querySelector('input, textarea, select, button');
            if (focusable) {
                focusable.focus({ preventScroll: true });
                if (typeof focusable.select === 'function' && focusSection === 'email') {
                    focusable.select();
                }
            }
            setTimeout(() => panel.classList.remove('is-focus-flash'), 1800);
        }
        return;
    }

    if (activeTab === 'hist') {
        const table = document.querySelector('#tab-hist table');
        if (table) table.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
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
        return '<div class="adm-context-empty is-compact">' + '${msg_admin_context_empty_logins_js}' + '</div>';
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

const DETAIL_TAB_KEYS = ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'chatbot', 'actions'];

function switchTab(tabKey) {
    DETAIL_TAB_KEYS.forEach(function(name) {
        const el = document.getElementById('tab-' + name);
        if (el) el.hidden = tabKey !== name;
    });
    const nav = document.getElementById('detailTabsNav');
    if (!nav) return;
    nav.querySelectorAll('.adm-tab').forEach(function(b) { b.classList.remove('active'); });
    nav.querySelectorAll('.adm-tab[data-tab="' + tabKey + '"]').forEach(function(b) { b.classList.add('active'); });
    const moreBtn = document.getElementById('detailTabsMoreBtn');
    if (moreBtn) {
        const inDropdown = !!document.querySelector('#detailTabsDropdown .adm-tab[data-tab="' + tabKey + '"]');
        moreBtn.classList.toggle('has-active', inDropdown);
    }
}

function initDetailTabsNav(activeTab) {
    const nav = document.getElementById('detailTabsNav');
    if (!nav) return;

    const row = nav.querySelector('.adm-tabs');
    const moreWrap = document.getElementById('detailTabsMore');
    const moreBtn = document.getElementById('detailTabsMoreBtn');
    const dropdown = document.getElementById('detailTabsDropdown');

    // 이벤트 위임 — row와 dropdown 모두 커버
    nav.addEventListener('click', function(e) {
        const btn = e.target.closest('.adm-tab[data-tab]');
        if (!btn) return;
        dropdown.hidden = true;
        switchTab(btn.dataset.tab);
    });

    moreBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        dropdown.hidden = !dropdown.hidden;
    });

    document.addEventListener('click', function _closeDropdown() {
        if (!dropdown) { document.removeEventListener('click', _closeDropdown); return; }
        dropdown.hidden = true;
    });

    function reflow() {
        const allTabs = Array.from(row.querySelectorAll(':scope > .adm-tab'));
        // 전체 복원 후 측정
        allTabs.forEach(function(t) { t.classList.remove('adm-is-hidden'); });
        moreWrap.hidden = true;
        dropdown.hidden = true;
        dropdown.innerHTML = '';

        const navWidth = nav.offsetWidth;
        const totalTabsWidth = allTabs.reduce(function(acc, t) { return acc + t.offsetWidth + 2; }, 0);

        if (totalTabsWidth <= navWidth) {
            if (moreBtn) moreBtn.classList.remove('has-active');
            return;
        }

        // 더보기 버튼이 필요함 — 버튼 너비 확보
        moreWrap.hidden = false;
        const availWidth = navWidth - moreWrap.offsetWidth - 2;

        // 앞에서부터 누적해서 자를 위치 결정
        let acc = 0;
        let cutAt = allTabs.length;
        for (let i = 0; i < allTabs.length; i++) {
            acc += allTabs[i].offsetWidth + 2;
            if (acc > availWidth) { cutAt = i; break; }
        }

        // cutAt 이후 탭 → 숨기고 드롭다운에 복제
        let hasActiveInDropdown = false;
        for (let i = cutAt; i < allTabs.length; i++) {
            const original = allTabs[i];
            if (original.classList.contains('active')) hasActiveInDropdown = true;
            original.classList.add('adm-is-hidden');
            const clone = original.cloneNode(true);
            clone.classList.remove('adm-is-hidden');
            dropdown.appendChild(clone);
        }
        moreBtn.classList.toggle('has-active', hasActiveInDropdown);
    }

    reflow();

    if (_detailTabsRo) _detailTabsRo.disconnect();
    _detailTabsRo = new ResizeObserver(reflow);
    _detailTabsRo.observe(nav);
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
            setTimeout(() => refreshMemberSection(), 700);
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

async function saveMemberEmail(userIdx, button) {
    const email = document.getElementById('memberEmailInput').value.trim();

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/email', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ email })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || ADMIN_MEMBER_MSG.emailUpdated);
            await openDetail(userIdx, 'actions', 'email');
        } else {
            adm_toast(data.message || '${msg_admin_common_saveFailed_js}', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('${msg_admin_common_saveFailed_js}', 'error');
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
            setTimeout(() => refreshMemberSection(), 700);
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
    if (_detailTabsRo) { _detailTabsRo.disconnect(); _detailTabsRo = null; }
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

document.addEventListener('click', function (e) {
    const detailTrigger = e.target.closest('.js-member-open-detail');
    if (!detailTrigger) return;
    openDetail(detailTrigger.dataset.userIdx, detailTrigger.dataset.defaultTab, detailTrigger.dataset.focusSection);
});

document.addEventListener('DOMContentLoaded', function () {
    updateBulkBar();

    // URL 파라미터로 상세 자동 오픈
    const detailUserIdx = '${fn:escapeXml(param.detailUserIdx)}';
    if (detailUserIdx) {
        openDetail(detailUserIdx);
    }
});
</script>

<%@ include file="../layout-close.jsp" %>
