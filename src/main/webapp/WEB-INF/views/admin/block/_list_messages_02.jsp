<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%-- Request-scoped i18n declarations for admin/block/list dynamic JSP fragments. --%>
<spring:message var="msg_admin_blocks_js_done_js" code="admin.blocks.js.done" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_yes_js" code="admin.common.yes" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_no_js" code="admin.common.no" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_members_noLinkedProvider_js" code="admin.members.noLinkedProvider" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_social_kakao_js" code="admin.social.kakao" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_social_naver_js" code="admin.social.naver" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_social_google_js" code="admin.social.google" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_memberNo_js" code="admin.context.memberNo" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_userId_js" code="admin.context.userId" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_nickname_js" code="admin.context.nickname" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_email_js" code="admin.context.email" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_members_accountStatus_js" code="admin.members.accountStatus" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_role_js" code="admin.common.role" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_nationality_js" code="admin.context.nationality" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_preferredLanguage_js" code="admin.context.preferredLanguage" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_members_emailVerified_js" code="admin.members.emailVerified" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_members_emailLoginEnabled_js" code="admin.members.emailLoginEnabled" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_members_passwordLoginEnabled_js" code="admin.members.passwordLoginEnabled" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_createdAt_js" code="admin.context.createdAt" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_members_socialLinked_js" code="admin.members.socialLinked" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_members_loginSuccess_js" code="admin.members.loginSuccess" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_members_loginFailure_js" code="admin.members.loginFailure" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_lastLogin_js" code="admin.context.lastLogin" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_empty_logins_js" code="admin.context.empty.logins" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_logs_success_js" code="admin.logs.success" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_logs_failure_js" code="admin.logs.failure" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_time_js" code="admin.common.time" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_logs_provider_js" code="admin.logs.provider" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_result_js" code="admin.blocks.result" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_logs_failReason_js" code="admin.logs.failReason" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_ip_js" code="admin.common.ip" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_batches_editTitle_js" code="admin.blocks.batches.editTitle" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_control_batch_js" code="admin.blocks.control.batch" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_control_override_js" code="admin.blocks.control.override" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_control_manual_js" code="admin.blocks.control.manual" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_userBlocks_editTitle_js" code="admin.blocks.userBlocks.editTitle" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_ipRules_editTitle_js" code="admin.blocks.ipRules.editTitle" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_batchReactivate_js" code="admin.blocks.batchReactivate" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_batchDeactivate_js" code="admin.blocks.batchDeactivate" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_policyFeed_uploading_js" code="admin.blocks.policyFeed.uploading" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_policyFeed_uploadSuccess_js" code="admin.blocks.policyFeed.uploadSuccess" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_policyFeed_uploadFailed_js" code="admin.blocks.policyFeed.uploadFailed" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_pageTitle" code="admin.blocks.pageTitle" scope="request"/>
<spring:message var="msg_admin_blocks_individualRule" code="admin.blocks.individualRule" scope="request"/>
<spring:message var="msg_admin_members_none" code="admin.members.none" scope="request"/>
<spring:message var="msg_admin_common_settings" code="admin.common.settings" scope="request"/>
<spring:message var="msg_admin_common_history" code="admin.common.history" scope="request"/>
<spring:message var="msg_admin_blocks_ruleOff" code="admin.blocks.ruleOff" scope="request"/>
<spring:message var="msg_admin_blocks_ruleOn" code="admin.blocks.ruleOn" scope="request"/>
<spring:message var="msg_admin_blocks_returnToBatch" code="admin.blocks.returnToBatch" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_activeUserBlocks" code="admin.blocks.kpi.activeUserBlocks" scope="request"/>
<spring:message var="msg_admin_blocks_dashboard_stat_userBlocks" code="admin.blocks.dashboard.stat.userBlocks" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_activePolicies" code="admin.blocks.kpi.activePolicies" scope="request"/>
<spring:message var="msg_admin_blocks_dashboard_stat_ipRules" code="admin.blocks.dashboard.stat.ipRules" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_history" code="admin.blocks.kpi.history" scope="request"/>
<spring:message var="msg_admin_blocks_dashboard_stat_history" code="admin.blocks.dashboard.stat.history" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_activeBatches" code="admin.blocks.kpi.activeBatches" scope="request"/>
<spring:message var="msg_admin_blocks_dashboard_stat_batches" code="admin.blocks.dashboard.stat.batches" scope="request"/>
<spring:message var="msg_admin_blocks_runtimeCache_title" code="admin.blocks.runtimeCache.title" scope="request"/>
<spring:message var="msg_admin_blocks_runtimeCache_desc" code="admin.blocks.runtimeCache.desc" scope="request"/>
<spring:message var="msg_admin_blocks_runtimeCache_sync" code="admin.blocks.runtimeCache.sync" scope="request"/>
<spring:message var="msg_admin_blocks_policyFeed_title" code="admin.blocks.policyFeed.title" scope="request"/>
<spring:message var="msg_admin_blocks_policyFeed_desc" code="admin.blocks.policyFeed.desc" scope="request"/>
<spring:message var="msg_admin_blocks_policyFeed_sourceName" code="admin.blocks.policyFeed.sourceName" scope="request"/>
<spring:message var="msg_admin_context_ruleAction" code="admin.context.ruleAction" scope="request"/>
<spring:message var="msg_admin_context_ruleAction_block" code="admin.context.ruleAction.block" scope="request"/>
<spring:message var="msg_admin_context_ruleAction_allow" code="admin.context.ruleAction.allow" scope="request"/>
<spring:message var="msg_admin_blocks_policyFeed_file" code="admin.blocks.policyFeed.file" scope="request"/>
<spring:message var="msg_admin_blocks_policyFeed_upload" code="admin.blocks.policyFeed.upload" scope="request"/>
<spring:message var="msg_admin_blocks_globalSearch" code="admin.blocks.globalSearch" scope="request"/>
<spring:message var="msg_admin_blocks_ruleState" code="admin.blocks.ruleState" scope="request"/>
<spring:message var="msg_admin_common_all" code="admin.common.all" scope="request"/>
<spring:message var="msg_admin_blocks_scope" code="admin.blocks.scope" scope="request"/>
<spring:message var="msg_admin_blocks_scope_userAction" code="admin.blocks.scope.userAction" scope="request"/>
<spring:message var="msg_admin_blocks_scope_global" code="admin.blocks.scope.global" scope="request"/>
<spring:message var="msg_admin_blocks_scope_autoDetection" code="admin.blocks.scope.autoDetection" scope="request"/>
<spring:message var="msg_admin_blocks_controlMode" code="admin.blocks.controlMode" scope="request"/>
<spring:message var="msg_admin_blocks_control_manual" code="admin.blocks.control.manual" scope="request"/>
<spring:message var="msg_admin_blocks_control_batch" code="admin.blocks.control.batch" scope="request"/>
<spring:message var="msg_admin_blocks_control_override" code="admin.blocks.control.override" scope="request"/>
