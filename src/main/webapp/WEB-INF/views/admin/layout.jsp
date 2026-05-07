<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_layout_logoutTitle" code="admin.layout.logoutTitle"/>
<spring:message var="msg_admin_layout_languageTitle" code="admin.layout.languageTitle"/>
<spring:message var="msg_admin_layout_themeToggleTitle" code="admin.layout.themeToggleTitle"/>
<spring:message var="msg_admin_layout_menuToggle" code="admin.layout.menuToggle"/>
<spring:message var="msg_admin_translation_open_js" code="admin.translation.open" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_hide_js" code="admin.translation.hide" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_refresh_js" code="admin.translation.refresh" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_createNew_js" code="admin.translation.createNew" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_create_js" code="admin.translation.create" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_none_js" code="admin.translation.none" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_noTranslationSelected_js" code="admin.translation.noTranslationSelected" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_collapsedHint_js" code="admin.translation.collapsedHint" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_currentSource_js" code="admin.translation.currentSource" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_basedSource_js" code="admin.translation.basedSource" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_translatedText_js" code="admin.translation.translatedText" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_title_js" code="admin.translation.title" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_titlePlaceholder_js" code="admin.translation.titlePlaceholder" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_sourceLang_js" code="admin.translation.sourceLang" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_targetLang_js" code="admin.translation.targetLang" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_autoGenerate_js" code="admin.translation.autoGenerate" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_initialText_js" code="admin.translation.initialText" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_note_js" code="admin.translation.note" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_primary_js" code="admin.translation.primary" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_primaryShort_js" code="admin.translation.primaryShort" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_outdated_js" code="admin.translation.outdated" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_outdatedShort_js" code="admin.translation.outdatedShort" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_upToDate_js" code="admin.translation.upToDate" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_setPrimary_js" code="admin.translation.setPrimary" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_saveRevision_js" code="admin.translation.saveRevision" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_revisionHistory_js" code="admin.translation.revisionHistory" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_restoreRevision_js" code="admin.translation.restoreRevision" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_noRevision_js" code="admin.translation.noRevision" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_untitled_js" code="admin.translation.untitled" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_loading_js" code="admin.translation.loading" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_created_js" code="admin.translation.created" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_saved_js" code="admin.translation.saved" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_restored_js" code="admin.translation.restored" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_confirmRestore_js" code="admin.translation.confirmRestore" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_requestFailed_js" code="admin.translation.requestFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_enterTranslatedText_js" code="admin.translation.enterTranslatedText" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_loadFailed_js" code="admin.translation.loadFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_createFailed_js" code="admin.translation.createFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_saveFailed_js" code="admin.translation.saveFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_restoreFailed_js" code="admin.translation.restoreFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_translation_sectionTitle_js" code="admin.translation.sectionTitle" javaScriptEscape="true"/>
<spring:message var="msg_header_lang_ko_js" code="header.lang.ko" javaScriptEscape="true"/>
<spring:message var="msg_header_lang_en_js" code="header.lang.en" javaScriptEscape="true"/>
<spring:message var="msg_header_lang_ja_js" code="header.lang.ja" javaScriptEscape="true"/>
<spring:message var="msg_header_lang_zh_js" code="header.lang.zh" javaScriptEscape="true"/>
<spring:message var="msg_admin_layout_brandSub" code="admin.layout.brandSub"/>
<spring:message var="msg_admin_layout_section_main" code="admin.layout.section.main"/>
<spring:message var="msg_admin_layout_menu_dashboard" code="admin.layout.menu.dashboard"/>
<spring:message var="msg_admin_layout_section_members" code="admin.layout.section.members"/>
<spring:message var="msg_admin_layout_section_memberAuth" code="admin.layout.section.memberAuth"/>
<spring:message var="msg_admin_layout_section_blocking" code="admin.layout.section.blocking"/>
<spring:message var="msg_admin_layout_menu_members" code="admin.layout.menu.members"/>
<spring:message var="msg_admin_layout_menu_businessApplications" code="admin.layout.menu.businessApplications"/>
<spring:message var="msg_admin_layout_menu_blocks" code="admin.layout.menu.blocks"/>
<spring:message var="msg_admin_layout_menu_finance" code="admin.layout.menu.finance"/>
<spring:message var="msg_admin_layout_section_security" code="admin.layout.section.security"/>
<spring:message var="msg_admin_layout_menu_logins" code="admin.layout.menu.logins"/>
<spring:message var="msg_admin_layout_menu_security" code="admin.layout.menu.security"/>
<spring:message var="msg_admin_layout_menu_emailTokens" code="admin.layout.menu.emailTokens"/>
<spring:message var="msg_admin_layout_menu_emailRequests" code="admin.layout.menu.emailRequests"/>
<spring:message var="msg_admin_layout_menu_activityLogs" code="admin.layout.menu.activityLogs"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_admin_layout_menu_runtimeSettings" code="admin.layout.menu.runtimeSettings"/>
<spring:message var="msg_admin_layout_menu_initialSettings" code="admin.layout.menu.initialSettings"/>
<spring:message var="msg_admin_layout_menu_policyHistory" code="admin.layout.menu.policyHistory"/>
<spring:message var="msg_security_admin_nav_loginReviews" code="security.admin.nav.loginReviews"/>
<spring:message var="msg_security_admin_nav_assessments" code="security.admin.nav.assessments"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_nav_securityReviews" code="security.admin.nav.securityReviews"/>
<spring:message var="msg_security_admin_nav_appealPolicy" code="security.admin.nav.appealPolicy"/>
<spring:message var="msg_security_admin_nav_providerConfigs" code="security.admin.nav.providerConfigs"/>
<spring:message var="msg_security_admin_nav_providerHealth" code="security.admin.nav.providerHealth"/>
<spring:message var="msg_security_admin_nav_wafSync" code="security.admin.nav.wafSync"/>
<spring:message var="msg_security_admin_nav_appeals" code="security.admin.nav.appeals"/>
<spring:message var="msg_security_admin_nav_notificationPreferences" code="security.admin.nav.notificationPreferences"/>
<spring:message var="msg_admin_layout_section_operations" code="admin.layout.section.operations"/>
<spring:message var="msg_admin_layout_menu_inquiries" code="admin.layout.menu.inquiries"/>
<spring:message var="msg_admin_layout_menu_reports" code="admin.layout.menu.reports"/>
<spring:message var="msg_admin_layout_section_content" code="admin.layout.section.content"/>
<spring:message var="msg_admin_layout_menu_community" code="admin.layout.menu.community"/>
<spring:message var="msg_admin_layout_menu_explore" code="admin.layout.menu.explore"/>
<spring:message var="msg_admin_layout_menu_packages" code="admin.layout.menu.packages"/>
<spring:message var="msg_admin_layout_menu_courses" code="admin.layout.menu.courses"/>
<spring:message var="msg_admin_layout_menu_ads" code="admin.layout.menu.ads"/>
<spring:message var="msg_admin_layout_section_ai" code="admin.layout.section.ai"/>
<spring:message var="msg_admin_layout_menu_aiAssistant" code="admin.layout.menu.aiAssistant"/>
<spring:message var="msg_admin_layout_menu_aiChatbot" code="admin.layout.menu.aiChatbot"/>
<spring:message var="msg_admin_layout_section_system" code="admin.layout.section.system"/>
<spring:message var="msg_admin_layout_menu_policies" code="admin.layout.menu.policies"/>
<spring:message var="msg_admin_layout_menu_moderation" code="admin.layout.menu.moderation"/>
<spring:message var="msg_admin_layout_menu_superAdmin" code="admin.layout.menu.superAdmin"/>
<spring:message var="msg_admin_layout_menu_viewSite" code="admin.layout.menu.viewSite"/>
<spring:message var="msg_admin_role_ADMIN" code="admin.role.ADMIN"/>
<spring:message var="msg_admin_layout_language" code="admin.layout.language"/>
<spring:message var="msg_header_lang_ko" code="header.lang.ko"/>
<spring:message var="msg_header_lang_en" code="header.lang.en"/>
<spring:message var="msg_header_lang_ja" code="header.lang.ja"/>
<spring:message var="msg_header_lang_zh" code="header.lang.zh"/>
<spring:message var="msg_admin_layout_theme_light" code="admin.layout.theme.light"/>
<spring:message var="msg_admin_layout_path_admin" code="admin.layout.path.admin"/>
<spring:message var="msg_admin_layout_theme_dark" code="admin.layout.theme.dark"/>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/TripTogetherFavicon.png"> <%-- 파비콘 --%>
    <title>${pageTitle} — TripTogether Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
</head>
<body>
<script>
(function(){
    // 구버전 키(sa_theme) → 신규 키(tt_theme) 일회성 마이그레이션
    var legacy = localStorage.getItem('sa_theme');
    if (legacy !== null) {
        if (!localStorage.getItem('tt_theme')) {
            localStorage.setItem('tt_theme', legacy === 'sa-light' ? 'light' : 'dark');
        }
        localStorage.removeItem('sa_theme');
    }
    // admin 기본 테마는 다크. tt_theme === 'light' 일 때만 sa-light 적용
    var t = localStorage.getItem('tt_theme');
    if (t === 'light') document.body.classList.add('sa-light');
})();
</script>
<div class="adm-shell">
    <aside class="adm-sidebar" id="adm-sidebar">
        <a class="adm-brand" href="${pageContext.request.contextPath}/admin">
            <div class="adm-brand-icon">🌐</div>
            <div>
                <div class="adm-brand-text">TripTogether</div>
                <div class="adm-brand-sub">${msg_admin_layout_brandSub}</div>
            </div>
        </a>

        <nav class="adm-nav">
            <%-- 메인 (플랫) --%>
            <div class="adm-nav-section">${msg_admin_layout_section_main}</div>
            <a class="adm-nav-item ${activeMenu=='dashboard'?'active':''}" href="${pageContext.request.contextPath}/admin">
                <span class="adm-nav-icon">📊</span> ${msg_admin_layout_menu_dashboard}
            </a>

            <%-- 회원 / 인증 --%>
            <c:if test="${hasMemberAdmin or hasAuditAdmin}">
            <div class="adm-nav-group" data-group="member-auth">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('member-auth')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title">${msg_admin_layout_section_memberAuth}</span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasMemberAdmin}">
                    <a class="adm-nav-item ${activeMenu=='members'?'active':''}" href="${pageContext.request.contextPath}/admin/members">
                        <span class="adm-nav-icon">👥</span> ${msg_admin_layout_menu_members}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='businessApplications'?'active':''}" href="${pageContext.request.contextPath}/admin/business-applications">
                        <span class="adm-nav-icon">🏢</span> ${msg_admin_layout_menu_businessApplications}
                    </a>
                    </c:if>
                    <c:if test="${hasAuditAdmin}">
                    <a class="adm-nav-item ${activeMenu=='emailVerifications'?'active':''}" href="${pageContext.request.contextPath}/admin/email-verifications">
                        <span class="adm-nav-icon">📧</span> ${msg_admin_layout_menu_emailRequests}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='emailTokens'?'active':''}" href="${pageContext.request.contextPath}/admin/email-tokens">
                        <span class="adm-nav-icon">🔗</span> ${msg_admin_layout_menu_emailTokens}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityProviderConfigs'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">
                        <span class="adm-nav-icon">🔌</span> ${msg_security_admin_nav_providerConfigs}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='providerHealthHistory'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/provider-health-history">
                        <span class="adm-nav-icon">🩺</span> ${msg_security_admin_nav_providerHealth}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='adminNotificationPreferences'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">
                        <span class="adm-nav-icon">🔔</span> ${msg_security_admin_nav_notificationPreferences}
                    </a>
                    </c:if>
                </div>
            </div>
            </c:if>

            <%-- 차단 / 리스크 --%>
            <c:if test="${hasAnyBlockAdmin or hasAuditAdmin}">
            <div class="adm-nav-group" data-group="blocking">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('blocking')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title">${msg_admin_layout_section_blocking}</span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasAnyBlockAdmin}">
                    <a class="adm-nav-item ${activeMenu=='blocks'?'active':''}" href="${pageContext.request.contextPath}/admin/blocks">
                        <span class="adm-nav-icon">⛔</span> ${msg_admin_layout_menu_blocks}
                    </a>
                    </c:if>
                    <c:if test="${hasAuditAdmin}">
                    <a class="adm-nav-item ${activeMenu=='loginRiskPolicies'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/policies">
                        <span class="adm-nav-icon">⚙️</span> ${msg_security_admin_nav_policies}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='loginRiskReviews'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/reviews">
                        <span class="adm-nav-icon">🧯</span> ${msg_security_admin_nav_loginReviews}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='loginRiskAssessments'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/assessments">
                        <span class="adm-nav-icon">🧠</span> ${msg_security_admin_nav_assessments}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityRiskAssessments'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">
                        <span class="adm-nav-icon">🛡️</span> ${msg_security_admin_nav_securityAssessments}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityReviews'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">
                        <span class="adm-nav-icon">🧾</span> ${msg_security_admin_nav_securityReviews}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityAppealPolicy'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/appeal-policy">
                        <span class="adm-nav-icon">📜</span> ${msg_security_admin_nav_appealPolicy}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityAppeals'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/appeals">
                        <span class="adm-nav-icon">📮</span> ${msg_security_admin_nav_appeals}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityWafSync'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/waf-sync">
                        <span class="adm-nav-icon">🌐</span> ${msg_security_admin_nav_wafSync}
                    </a>
                    </c:if>
                </div>
            </div>
            </c:if>

            <%-- 보안·감사 --%>
            <c:if test="${hasAuditAdmin}">
            <div class="adm-nav-group" data-group="security">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('security')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title">${msg_admin_layout_section_security}</span>
                </button>
                <div class="adm-nav-group-body">
                    <a class="adm-nav-item ${activeMenu=='logins'?'active':''}" href="${pageContext.request.contextPath}/admin/logins">
                        <span class="adm-nav-icon">🔐</span> ${msg_admin_layout_menu_logins}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='security'?'active':''}" href="${pageContext.request.contextPath}/admin/security">
                        <span class="adm-nav-icon">🛡️</span> ${msg_admin_layout_menu_security}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='activityLogs'?'active':''}" href="${pageContext.request.contextPath}/admin/activity-logs">
                        <span class="adm-nav-icon">🧭</span> ${msg_admin_layout_menu_activityLogs}
                    </a>
                </div>
            </div>
            </c:if>

            <%-- 운영 --%>
            <c:if test="${hasInquiryAdmin or hasReportAdmin or hasFinanceAdmin or hasFinanceOperator or hasFinancePolicyAdmin}">
            <div class="adm-nav-group" data-group="operations">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('operations')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title">${msg_admin_layout_section_operations}</span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasFinanceAdmin or hasFinanceOperator or hasFinancePolicyAdmin}">
                    <a class="adm-nav-item ${activeMenu=='finance'?'active':''}" href="${pageContext.request.contextPath}/admin/finance">
                        <span class="adm-nav-icon">💰</span> ${msg_admin_layout_menu_finance}
                    </a>
                    </c:if>
                    <c:if test="${hasInquiryAdmin}">
                    <a class="adm-nav-item ${activeMenu=='inquiries'?'active':''}" href="${pageContext.request.contextPath}/admin/inquiries">
                        <span class="adm-nav-icon">📩</span> ${msg_admin_layout_menu_inquiries}
                    </a>
                    </c:if>
                    <c:if test="${hasReportAdmin}">
                    <a class="adm-nav-item ${activeMenu=='reports'?'active':''}" href="${pageContext.request.contextPath}/admin/reports">
                        <span class="adm-nav-icon">🚨</span> ${msg_admin_layout_menu_reports}
                    </a>
                    </c:if>
                </div>
            </div>
            </c:if>

            <%-- 콘텐츠 --%>
            <c:if test="${hasCommunityAdmin or hasExploreAdmin or hasCourseAdmin}">
            <div class="adm-nav-group" data-group="content">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('content')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title">${msg_admin_layout_section_content}</span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasCommunityAdmin}">
                    <a class="adm-nav-item ${activeMenu=='community'?'active':''}" href="${pageContext.request.contextPath}/admin/community">
                        <span class="adm-nav-icon">📝</span> ${msg_admin_layout_menu_community}
                    </a>
                    </c:if>
                    <c:if test="${hasExploreAdmin}">
                    <a class="adm-nav-item ${activeMenu=='explore'?'active':''}" href="${pageContext.request.contextPath}/admin/explore">
                        <span class="adm-nav-icon">📍</span> ${msg_admin_layout_menu_explore}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='packages'?'active':''}" href="${pageContext.request.contextPath}/admin/packages">
                        <span class="adm-nav-icon">🎁</span> ${msg_admin_layout_menu_packages}
                    </a>
                    </c:if>
                    <c:if test="${hasCourseAdmin}">
                    <a class="adm-nav-item ${activeMenu=='courses'?'active':''}" href="${pageContext.request.contextPath}/admin/courses">
                        <span class="adm-nav-icon">🗺️</span> ${msg_admin_layout_menu_courses}
                    </a>
                    </c:if>
                    <c:if test="${hasCommunityAdmin}">
                    <a class="adm-nav-item ${activeMenu=='ads'?'active':''}" href="${pageContext.request.contextPath}/admin/ads">
                        <span class="adm-nav-icon">📢</span> ${msg_admin_layout_menu_ads}
                    </a>
                    </c:if>
                </div>
            </div>
            </c:if>

            <%-- AI 관리 --%>
            <c:if test="${hasAssistantAdmin or hasAiChatbotAdmin}">
            <div class="adm-nav-group" data-group="ai">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('ai')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title">${msg_admin_layout_section_ai}</span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasAssistantAdmin}">
                    <a class="adm-nav-item ${activeMenu=='aiHelper' and section ne 'chatbot'?'active':''}" href="${pageContext.request.contextPath}/admin/ai-helper">
                        <span class="adm-nav-icon">🤖</span> ${msg_admin_layout_menu_aiAssistant}
                    </a>
                    </c:if>
                    <c:if test="${hasAiChatbotAdmin}">
                    <a class="adm-nav-item ${activeMenu=='aiHelper' and section eq 'chatbot'?'active':''}" href="${pageContext.request.contextPath}/admin/ai-helper/chatbot">
                        <span class="adm-nav-icon">💬</span> ${msg_admin_layout_menu_aiChatbot}
                    </a>
                    </c:if>
                </div>
            </div>
            </c:if>

            <%-- 시스템 --%>
            <c:if test="${hasOpsPolicyAdmin or hasContentModerationAdmin or hasAuditAdmin or isSuperAdmin}">
            <div class="adm-nav-group" data-group="system">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('system')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title">${msg_admin_layout_section_system}</span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasAuditAdmin}">
                    <a class="adm-nav-item ${activeMenu=='runtimeSettings'?'active':''}" href="${pageContext.request.contextPath}/admin/runtime-settings">
                        <span class="adm-nav-icon">🧩</span> ${msg_admin_layout_menu_runtimeSettings}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='initialSettings'?'active':''}" href="${pageContext.request.contextPath}/admin/initial-settings">
                        <span class="adm-nav-icon">📦</span> ${msg_admin_layout_menu_initialSettings}
                    </a>
                    <a class="adm-nav-item ${activeMenu=='policyHistory'?'active':''}" href="${pageContext.request.contextPath}/admin/policy-history">
                        <span class="adm-nav-icon">🧾</span> ${msg_admin_layout_menu_policyHistory}
                    </a>
                    </c:if>
                    <c:if test="${hasOpsPolicyAdmin}">
                    <a class="adm-nav-item ${activeMenu=='policies'?'active':''}" href="${pageContext.request.contextPath}/admin/policies">
                        <span class="adm-nav-icon">⚙️</span> ${msg_admin_layout_menu_policies}
                    </a>
                    </c:if>
                    <c:if test="${hasContentModerationAdmin}">
                    <a class="adm-nav-item ${activeMenu=='moderation'?'active':''}" href="${pageContext.request.contextPath}/admin/moderation">
                        <span class="adm-nav-icon">🧰</span> ${msg_admin_layout_menu_moderation}
                    </a>
                    </c:if>
                    <c:if test="${isSuperAdmin}">
                    <a class="adm-nav-item ${activeMenu=='superAdmin'?'active':''}" href="${pageContext.request.contextPath}/superAdmin">
                        <span class="adm-nav-icon">🔑</span> ${msg_admin_layout_menu_superAdmin}
                    </a>
                    </c:if>
                </div>
            </div>
            </c:if>

            <div style="margin-top:16px; padding: 0 10px;">
                <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/" target="_blank">
                    <span class="adm-nav-icon">↗️</span> ${msg_admin_layout_menu_viewSite}
                </a>
            </div>
        </nav>

        <script>
        (function(){
            var KEY = 'adm_nav_groups';
            var state = {};
            try { state = JSON.parse(localStorage.getItem(KEY) || '{}'); } catch(e) { state = {}; }

            // active 항목이 속한 그룹은 자동 펼침
            document.querySelectorAll('.adm-nav-item.active').forEach(function(item){
                var g = item.closest('.adm-nav-group');
                if (g) {
                    g.classList.add('open');
                    state[g.getAttribute('data-group')] = true;
                }
            });
            // 저장된 상태 복원
            document.querySelectorAll('.adm-nav-group').forEach(function(g){
                if (state[g.getAttribute('data-group')]) g.classList.add('open');
            });

            window.admToggleNavGroup = function(key){
                var g = document.querySelector('.adm-nav-group[data-group="' + key + '"]');
                if (!g) return;
                g.classList.toggle('open');
                state[key] = g.classList.contains('open');
                try { localStorage.setItem(KEY, JSON.stringify(state)); } catch(e) {}
            };
        })();
        </script>

        <div class="adm-sidebar-foot">
            <div class="adm-user-chip">
                <div class="adm-user-av">${sessionScope.loginUser.nickname.substring(0,1)}</div>
                <div>
                    <div class="adm-user-name">${sessionScope.loginUser.nickname}</div>
                    <div class="adm-user-role">${msg_admin_role_ADMIN}</div>
                </div>
                <a href="${pageContext.request.contextPath}/auth/logout" class="adm-logout" title="${msg_admin_layout_logoutTitle}">⏏</a>
            </div>
        </div>
    </aside>

    <div class="adm-main">
        <div class="adm-topbar">
            <button type="button" class="adm-nav-toggle" id="sidebar-toggle"
                    aria-label="${msg_admin_layout_menuToggle}" aria-expanded="false" aria-controls="adm-sidebar">
                <span class="adm-nav-toggle-bar"></span>
                <span class="adm-nav-toggle-bar"></span>
                <span class="adm-nav-toggle-bar"></span>
            </button>
            <div class="adm-topbar-title">${pageTitle}</div>
            <div class="adm-topbar-controls">
                <label class="adm-topbar-select-wrap" for="admLangSel" title="${msg_admin_layout_languageTitle}">
                    <span class="adm-topbar-tool-label">${msg_admin_layout_language}</span>
                    <select class="adm-select adm-topbar-select" id="admLangSel" aria-label="${msg_admin_layout_languageTitle}">
                        <option value="ko" ${pageContext.response.locale.language == 'ko' ? 'selected' : ''}>${msg_header_lang_ko}</option>
                        <option value="en" ${pageContext.response.locale.language == 'en' ? 'selected' : ''}>${msg_header_lang_en}</option>
                        <option value="ja" ${pageContext.response.locale.language == 'ja' ? 'selected' : ''}>${msg_header_lang_ja}</option>
                        <option value="zh" ${pageContext.response.locale.language == 'zh' ? 'selected' : ''}>${msg_header_lang_zh}</option>
                    </select>
                </label>
                <button class="sa-theme-btn" id="saThemeBtn" onclick="saToggleTheme()" title="${msg_admin_layout_themeToggleTitle}">☀️ ${msg_admin_layout_theme_light}</button>
            </div>
            <div class="adm-topbar-path">
                <span>${msg_admin_layout_path_admin}</span>
                <c:if test="${not empty pageTitle}"><span>${pageTitle}</span></c:if>
            </div>
        </div>
        <div id="adm-toast-container"></div>


<script>
(function(){
    var btn = document.getElementById('saThemeBtn');
    var isLight = document.body.classList.contains('sa-light');
    if (btn) btn.textContent = isLight ? '🌙 ${msg_admin_layout_theme_dark}' : '☀️ ${msg_admin_layout_theme_light}';
})();

function saToggleTheme() {
    var body = document.body;
    var btn  = document.getElementById('saThemeBtn');
    if (body.classList.contains('sa-light')) {
        body.classList.remove('sa-light');
        localStorage.setItem('tt_theme', 'dark');
        if (btn) btn.textContent = '☀️ ${msg_admin_layout_theme_light}';
    } else {
        body.classList.add('sa-light');
        localStorage.setItem('tt_theme', 'light');
        if (btn) btn.textContent = '🌙 ${msg_admin_layout_theme_dark}';
    }
}

(function(){
    var langSel = document.getElementById('admLangSel');
    if (!langSel) return;
    langSel.addEventListener('change', function() {
        var url = new URL(window.location.href);
        url.searchParams.set('lang', this.value);
        window.location.href = url.toString();
    });
})();
</script>

<script>
window.__CTX__ = '${pageContext.request.contextPath}';
window.ADMIN_TRANSLATION_UI = {
    open: '${msg_admin_translation_open_js}',
    hide: '${msg_admin_translation_hide_js}',
    refresh: '${msg_admin_translation_refresh_js}',
    createNew: '${msg_admin_translation_createNew_js}',
    create: '${msg_admin_translation_create_js}',
    none: '${msg_admin_translation_none_js}',
    noTranslationSelected: '${msg_admin_translation_noTranslationSelected_js}',
    collapsedHint: '${msg_admin_translation_collapsedHint_js}',
    currentSource: '${msg_admin_translation_currentSource_js}',
    basedSource: '${msg_admin_translation_basedSource_js}',
    translatedText: '${msg_admin_translation_translatedText_js}',
    title: '${msg_admin_translation_title_js}',
    titlePlaceholder: '${msg_admin_translation_titlePlaceholder_js}',
    sourceLang: '${msg_admin_translation_sourceLang_js}',
    targetLang: '${msg_admin_translation_targetLang_js}',
    autoGenerate: '${msg_admin_translation_autoGenerate_js}',
    initialText: '${msg_admin_translation_initialText_js}',
    note: '${msg_admin_translation_note_js}',
    primary: '${msg_admin_translation_primary_js}',
    primaryShort: '${msg_admin_translation_primaryShort_js}',
    outdated: '${msg_admin_translation_outdated_js}',
    outdatedShort: '${msg_admin_translation_outdatedShort_js}',
    upToDate: '${msg_admin_translation_upToDate_js}',
    setPrimary: '${msg_admin_translation_setPrimary_js}',
    saveRevision: '${msg_admin_translation_saveRevision_js}',
    revisionHistory: '${msg_admin_translation_revisionHistory_js}',
    restoreRevision: '${msg_admin_translation_restoreRevision_js}',
    noRevision: '${msg_admin_translation_noRevision_js}',
    untitled: '${msg_admin_translation_untitled_js}',
    loading: '${msg_admin_translation_loading_js}',
    created: '${msg_admin_translation_created_js}',
    saved: '${msg_admin_translation_saved_js}',
    restored: '${msg_admin_translation_restored_js}',
    confirmRestore: '${msg_admin_translation_confirmRestore_js}',
    requestFailed: '${msg_admin_translation_requestFailed_js}',
    enterTranslatedText: '${msg_admin_translation_enterTranslatedText_js}',
    loadFailed: '${msg_admin_translation_loadFailed_js}',
    createFailed: '${msg_admin_translation_createFailed_js}',
    saveFailed: '${msg_admin_translation_saveFailed_js}',
    restoreFailed: '${msg_admin_translation_restoreFailed_js}',
    sectionTitle: '${msg_admin_translation_sectionTitle_js}',
    languages: {
        ko: '${msg_header_lang_ko_js}',
        en: '${msg_header_lang_en_js}',
        ja: '${msg_header_lang_ja_js}',
        zh: '${msg_header_lang_zh_js}'
    }
};
</script>
<script src="${pageContext.request.contextPath}/resources/js/admin/admin-translation.js"></script>
