<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message var="adminLogoutTitle" code="admin.layout.logoutTitle"/>
<spring:message var="adminLanguageTitle" code="admin.layout.languageTitle"/>
<spring:message var="adminThemeToggleTitle" code="admin.layout.themeToggleTitle"/>
<spring:message var="adminMenuToggleLabel" code="admin.layout.menuToggle"/>
<spring:message var="adminTranslationOpenMsg" code="admin.translation.open" javaScriptEscape="true"/>
<spring:message var="adminTranslationHideMsg" code="admin.translation.hide" javaScriptEscape="true"/>
<spring:message var="adminTranslationRefreshMsg" code="admin.translation.refresh" javaScriptEscape="true"/>
<spring:message var="adminTranslationCreateNewMsg" code="admin.translation.createNew" javaScriptEscape="true"/>
<spring:message var="adminTranslationCreateMsg" code="admin.translation.create" javaScriptEscape="true"/>
<spring:message var="adminTranslationNoneMsg" code="admin.translation.none" javaScriptEscape="true"/>
<spring:message var="adminTranslationNoTranslationSelectedMsg" code="admin.translation.noTranslationSelected" javaScriptEscape="true"/>
<spring:message var="adminTranslationCollapsedHintMsg" code="admin.translation.collapsedHint" javaScriptEscape="true"/>
<spring:message var="adminTranslationCurrentSourceMsg" code="admin.translation.currentSource" javaScriptEscape="true"/>
<spring:message var="adminTranslationBasedSourceMsg" code="admin.translation.basedSource" javaScriptEscape="true"/>
<spring:message var="adminTranslationTranslatedTextMsg" code="admin.translation.translatedText" javaScriptEscape="true"/>
<spring:message var="adminTranslationTitleMsg" code="admin.translation.title" javaScriptEscape="true"/>
<spring:message var="adminTranslationTitlePlaceholderMsg" code="admin.translation.titlePlaceholder" javaScriptEscape="true"/>
<spring:message var="adminTranslationSourceLangMsg" code="admin.translation.sourceLang" javaScriptEscape="true"/>
<spring:message var="adminTranslationTargetLangMsg" code="admin.translation.targetLang" javaScriptEscape="true"/>
<spring:message var="adminTranslationAutoGenerateMsg" code="admin.translation.autoGenerate" javaScriptEscape="true"/>
<spring:message var="adminTranslationInitialTextMsg" code="admin.translation.initialText" javaScriptEscape="true"/>
<spring:message var="adminTranslationNoteMsg" code="admin.translation.note" javaScriptEscape="true"/>
<spring:message var="adminTranslationPrimaryMsg" code="admin.translation.primary" javaScriptEscape="true"/>
<spring:message var="adminTranslationPrimaryShortMsg" code="admin.translation.primaryShort" javaScriptEscape="true"/>
<spring:message var="adminTranslationOutdatedMsg" code="admin.translation.outdated" javaScriptEscape="true"/>
<spring:message var="adminTranslationOutdatedShortMsg" code="admin.translation.outdatedShort" javaScriptEscape="true"/>
<spring:message var="adminTranslationUpToDateMsg" code="admin.translation.upToDate" javaScriptEscape="true"/>
<spring:message var="adminTranslationSetPrimaryMsg" code="admin.translation.setPrimary" javaScriptEscape="true"/>
<spring:message var="adminTranslationSaveRevisionMsg" code="admin.translation.saveRevision" javaScriptEscape="true"/>
<spring:message var="adminTranslationRevisionHistoryMsg" code="admin.translation.revisionHistory" javaScriptEscape="true"/>
<spring:message var="adminTranslationRestoreRevisionMsg" code="admin.translation.restoreRevision" javaScriptEscape="true"/>
<spring:message var="adminTranslationNoRevisionMsg" code="admin.translation.noRevision" javaScriptEscape="true"/>
<spring:message var="adminTranslationUntitledMsg" code="admin.translation.untitled" javaScriptEscape="true"/>
<spring:message var="adminTranslationLoadingMsg" code="admin.translation.loading" javaScriptEscape="true"/>
<spring:message var="adminTranslationCreatedMsg" code="admin.translation.created" javaScriptEscape="true"/>
<spring:message var="adminTranslationSavedMsg" code="admin.translation.saved" javaScriptEscape="true"/>
<spring:message var="adminTranslationRestoredMsg" code="admin.translation.restored" javaScriptEscape="true"/>
<spring:message var="adminTranslationConfirmRestoreMsg" code="admin.translation.confirmRestore" javaScriptEscape="true"/>
<spring:message var="adminTranslationRequestFailedMsg" code="admin.translation.requestFailed" javaScriptEscape="true"/>
<spring:message var="adminTranslationEnterTranslatedTextMsg" code="admin.translation.enterTranslatedText" javaScriptEscape="true"/>
<spring:message var="adminTranslationLoadFailedMsg" code="admin.translation.loadFailed" javaScriptEscape="true"/>
<spring:message var="adminTranslationCreateFailedMsg" code="admin.translation.createFailed" javaScriptEscape="true"/>
<spring:message var="adminTranslationSaveFailedMsg" code="admin.translation.saveFailed" javaScriptEscape="true"/>
<spring:message var="adminTranslationRestoreFailedMsg" code="admin.translation.restoreFailed" javaScriptEscape="true"/>
<spring:message var="adminTranslationSectionTitleMsg" code="admin.translation.sectionTitle" javaScriptEscape="true"/>
<spring:message var="headerLangKoMsg" code="header.lang.ko" javaScriptEscape="true"/>
<spring:message var="headerLangEnMsg" code="header.lang.en" javaScriptEscape="true"/>
<spring:message var="headerLangJaMsg" code="header.lang.ja" javaScriptEscape="true"/>
<spring:message var="headerLangZhMsg" code="header.lang.zh" javaScriptEscape="true"/>
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
                <div class="adm-brand-sub"><spring:message code="admin.layout.brandSub"/></div>
            </div>
        </a>

        <nav class="adm-nav">
            <%-- 메인 (플랫) --%>
            <div class="adm-nav-section"><spring:message code="admin.layout.section.main"/></div>
            <a class="adm-nav-item ${activeMenu=='dashboard'?'active':''}" href="${pageContext.request.contextPath}/admin">
                <span class="adm-nav-icon">📊</span> <spring:message code="admin.layout.menu.dashboard"/>
            </a>

            <%-- 회원 관리 --%>
            <c:if test="${hasMemberAdmin or hasAnyBlockAdmin or hasFinanceAdmin or hasFinanceOperator or hasFinancePolicyAdmin}">
            <div class="adm-nav-group" data-group="members">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('members')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title"><spring:message code="admin.layout.section.members"/></span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasMemberAdmin}">
                    <a class="adm-nav-item ${activeMenu=='members'?'active':''}" href="${pageContext.request.contextPath}/admin/members">
                        <span class="adm-nav-icon">👥</span> <spring:message code="admin.layout.menu.members"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='businessApplications'?'active':''}" href="${pageContext.request.contextPath}/admin/business-applications">
                        <span class="adm-nav-icon">🏢</span> <spring:message code="admin.layout.menu.businessApplications"/>
                    </a>
                    </c:if>
                    <c:if test="${hasAnyBlockAdmin}">
                    <a class="adm-nav-item ${activeMenu=='blocks'?'active':''}" href="${pageContext.request.contextPath}/admin/blocks">
                        <span class="adm-nav-icon">⛔</span> <spring:message code="admin.layout.menu.blocks"/>
                    </a>
                    </c:if>
                    <c:if test="${hasFinanceAdmin or hasFinanceOperator or hasFinancePolicyAdmin}">
                    <a class="adm-nav-item ${activeMenu=='finance'?'active':''}" href="${pageContext.request.contextPath}/admin/finance">
                        <span class="adm-nav-icon">💰</span> <spring:message code="admin.layout.menu.finance"/>
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
                    <span class="adm-nav-group-title"><spring:message code="admin.layout.section.security"/></span>
                </button>
                <div class="adm-nav-group-body">
                    <a class="adm-nav-item ${activeMenu=='logins'?'active':''}" href="${pageContext.request.contextPath}/admin/logins">
                        <span class="adm-nav-icon">🔐</span> <spring:message code="admin.layout.menu.logins"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='security'?'active':''}" href="${pageContext.request.contextPath}/admin/security">
                        <span class="adm-nav-icon">🛡️</span> <spring:message code="admin.layout.menu.security"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='emailTokens'?'active':''}" href="${pageContext.request.contextPath}/admin/email-tokens">
                        <span class="adm-nav-icon">🔗</span> <spring:message code="admin.layout.menu.emailTokens"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='emailVerifications'?'active':''}" href="${pageContext.request.contextPath}/admin/email-verifications">
                        <span class="adm-nav-icon">📧</span> <spring:message code="admin.layout.menu.emailRequests"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='activityLogs'?'active':''}" href="${pageContext.request.contextPath}/admin/activity-logs">
                        <span class="adm-nav-icon">🧭</span> <spring:message code="admin.layout.menu.activityLogs"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='loginRiskPolicies'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/policies">
                        <span class="adm-nav-icon">⚙️</span> <spring:message code="security.admin.nav.policies"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='runtimeSettings'?'active':''}" href="${pageContext.request.contextPath}/admin/runtime-settings">
                        <span class="adm-nav-icon">🧩</span> <spring:message code="admin.layout.menu.runtimeSettings"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='initialSettings'?'active':''}" href="${pageContext.request.contextPath}/admin/initial-settings">
                        <span class="adm-nav-icon">📦</span> <spring:message code="admin.layout.menu.initialSettings"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='policyHistory'?'active':''}" href="${pageContext.request.contextPath}/admin/policy-history">
                        <span class="adm-nav-icon">🧾</span> <spring:message code="admin.layout.menu.policyHistory"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='loginRiskReviews'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/reviews">
                        <span class="adm-nav-icon">🧯</span> <spring:message code="security.admin.nav.loginReviews"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='loginRiskAssessments'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/assessments">
                        <span class="adm-nav-icon">🧠</span> <spring:message code="security.admin.nav.assessments"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityRiskAssessments'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">
                        <span class="adm-nav-icon">🛡️</span> <spring:message code="security.admin.nav.securityAssessments"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityReviews'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">
                        <span class="adm-nav-icon">🧾</span> <spring:message code="security.admin.nav.securityReviews"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityProviderConfigs'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">
                        <span class="adm-nav-icon">🔌</span> <spring:message code="security.admin.nav.providerConfigs"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='providerHealthHistory'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/provider-health-history">
                        <span class="adm-nav-icon">🩺</span> <spring:message code="security.admin.nav.providerHealth"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityWafSync'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/waf-sync">
                        <span class="adm-nav-icon">🌐</span> <spring:message code="security.admin.nav.wafSync"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='securityAppeals'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/appeals">
                        <span class="adm-nav-icon">📮</span> <spring:message code="security.admin.nav.appeals"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='adminNotificationPreferences'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">
                        <span class="adm-nav-icon">🔔</span> <spring:message code="security.admin.nav.notificationPreferences"/>
                    </a>
                </div>
            </div>
            </c:if>

            <%-- 운영 --%>
            <c:if test="${hasInquiryAdmin or hasReportAdmin}">
            <div class="adm-nav-group" data-group="operations">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('operations')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title"><spring:message code="admin.layout.section.operations"/></span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasInquiryAdmin}">
                    <a class="adm-nav-item ${activeMenu=='inquiries'?'active':''}" href="${pageContext.request.contextPath}/admin/inquiries">
                        <span class="adm-nav-icon">📩</span> <spring:message code="admin.layout.menu.inquiries"/>
                    </a>
                    </c:if>
                    <c:if test="${hasReportAdmin}">
                    <a class="adm-nav-item ${activeMenu=='reports'?'active':''}" href="${pageContext.request.contextPath}/admin/reports">
                        <span class="adm-nav-icon">🚨</span> <spring:message code="admin.layout.menu.reports"/>
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
                    <span class="adm-nav-group-title"><spring:message code="admin.layout.section.content"/></span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasCommunityAdmin}">
                    <a class="adm-nav-item ${activeMenu=='community'?'active':''}" href="${pageContext.request.contextPath}/admin/community">
                        <span class="adm-nav-icon">📝</span> <spring:message code="admin.layout.menu.community"/>
                    </a>
                    </c:if>
                    <c:if test="${hasExploreAdmin}">
                    <a class="adm-nav-item ${activeMenu=='explore'?'active':''}" href="${pageContext.request.contextPath}/admin/explore">
                        <span class="adm-nav-icon">📍</span> <spring:message code="admin.layout.menu.explore"/>
                    </a>
                    <a class="adm-nav-item ${activeMenu=='packages'?'active':''}" href="${pageContext.request.contextPath}/admin/packages">
                        <span class="adm-nav-icon">🎁</span> <spring:message code="admin.layout.menu.packages"/>
                    </a>
                    </c:if>
                    <c:if test="${hasCourseAdmin}">
                    <a class="adm-nav-item ${activeMenu=='courses'?'active':''}" href="${pageContext.request.contextPath}/admin/courses">
                        <span class="adm-nav-icon">🗺️</span> <spring:message code="admin.layout.menu.courses"/>
                    </a>
                    </c:if>
                    <c:if test="${hasCommunityAdmin}">
                    <a class="adm-nav-item ${activeMenu=='ads'?'active':''}" href="${pageContext.request.contextPath}/admin/ads">
                        <span class="adm-nav-icon">📢</span> <spring:message code="admin.layout.menu.ads"/>
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
                    <span class="adm-nav-group-title"><spring:message code="admin.layout.section.ai"/></span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasAssistantAdmin}">
                    <a class="adm-nav-item ${activeMenu=='aiHelper' and section ne 'chatbot'?'active':''}" href="${pageContext.request.contextPath}/admin/ai-helper">
                        <span class="adm-nav-icon">🤖</span> <spring:message code="admin.layout.menu.aiAssistant"/>
                    </a>
                    </c:if>
                    <c:if test="${hasAiChatbotAdmin}">
                    <a class="adm-nav-item ${activeMenu=='aiHelper' and section eq 'chatbot'?'active':''}" href="${pageContext.request.contextPath}/admin/ai-helper/chatbot">
                        <span class="adm-nav-icon">💬</span> <spring:message code="admin.layout.menu.aiChatbot"/>
                    </a>
                    </c:if>
                </div>
            </div>
            </c:if>

            <%-- 시스템 --%>
            <c:if test="${hasOpsPolicyAdmin or hasContentModerationAdmin or isSuperAdmin}">
            <div class="adm-nav-group" data-group="system">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('system')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title"><spring:message code="admin.layout.section.system"/></span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasOpsPolicyAdmin}">
                    <a class="adm-nav-item ${activeMenu=='policies'?'active':''}" href="${pageContext.request.contextPath}/admin/policies">
                        <span class="adm-nav-icon">⚙️</span> <spring:message code="admin.layout.menu.policies"/>
                    </a>
                    </c:if>
                    <c:if test="${hasContentModerationAdmin}">
                    <a class="adm-nav-item ${activeMenu=='moderation'?'active':''}" href="${pageContext.request.contextPath}/admin/moderation">
                        <span class="adm-nav-icon">🧰</span> <spring:message code="admin.layout.menu.moderation"/>
                    </a>
                    </c:if>
                    <c:if test="${isSuperAdmin}">
                    <a class="adm-nav-item ${activeMenu=='superAdmin'?'active':''}" href="${pageContext.request.contextPath}/superAdmin">
                        <span class="adm-nav-icon">🔑</span> <spring:message code="admin.layout.menu.superAdmin"/>
                    </a>
                    </c:if>
                </div>
            </div>
            </c:if>

            <div style="margin-top:16px; padding: 0 10px;">
                <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/" target="_blank">
                    <span class="adm-nav-icon">↗️</span> <spring:message code="admin.layout.menu.viewSite"/>
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
                    <div class="adm-user-role"><spring:message code="admin.role.ADMIN"/></div>
                </div>
                <a href="${pageContext.request.contextPath}/auth/logout" class="adm-logout" title="${adminLogoutTitle}">⏏</a>
            </div>
        </div>
    </aside>

    <div class="adm-main">
        <div class="adm-topbar">
            <button type="button" class="adm-nav-toggle" id="sidebar-toggle"
                    aria-label="${adminMenuToggleLabel}" aria-expanded="false" aria-controls="adm-sidebar">
                <span class="adm-nav-toggle-bar"></span>
                <span class="adm-nav-toggle-bar"></span>
                <span class="adm-nav-toggle-bar"></span>
            </button>
            <div class="adm-topbar-title">${pageTitle}</div>
            <div class="adm-topbar-controls">
                <label class="adm-topbar-select-wrap" for="admLangSel" title="${adminLanguageTitle}">
                    <span class="adm-topbar-tool-label"><spring:message code="admin.layout.language"/></span>
                    <select class="adm-select adm-topbar-select" id="admLangSel" aria-label="${adminLanguageTitle}">
                        <option value="ko" ${pageContext.response.locale.language == 'ko' ? 'selected' : ''}><spring:message code="header.lang.ko"/></option>
                        <option value="en" ${pageContext.response.locale.language == 'en' ? 'selected' : ''}><spring:message code="header.lang.en"/></option>
                        <option value="ja" ${pageContext.response.locale.language == 'ja' ? 'selected' : ''}><spring:message code="header.lang.ja"/></option>
                        <option value="zh" ${pageContext.response.locale.language == 'zh' ? 'selected' : ''}><spring:message code="header.lang.zh"/></option>
                    </select>
                </label>
                <button class="sa-theme-btn" id="saThemeBtn" onclick="saToggleTheme()" title="${adminThemeToggleTitle}">☀️ <spring:message code="admin.layout.theme.light"/></button>
            </div>
            <div class="adm-topbar-path">
                <span><spring:message code="admin.layout.path.admin"/></span>
                <c:if test="${not empty pageTitle}"><span>${pageTitle}</span></c:if>
            </div>
        </div>
        <div id="adm-toast-container"></div>
<spring:message code="admin.layout.theme.light" var="adminThemeLightText"/>
<spring:message code="admin.layout.theme.dark" var="adminThemeDarkText"/>
<script>
(function(){
    var btn = document.getElementById('saThemeBtn');
    var isLight = document.body.classList.contains('sa-light');
    if (btn) btn.textContent = isLight ? '🌙 ${adminThemeDarkText}' : '☀️ ${adminThemeLightText}';
})();

function saToggleTheme() {
    var body = document.body;
    var btn  = document.getElementById('saThemeBtn');
    if (body.classList.contains('sa-light')) {
        body.classList.remove('sa-light');
        localStorage.setItem('tt_theme', 'dark');
        if (btn) btn.textContent = '☀️ ${adminThemeLightText}';
    } else {
        body.classList.add('sa-light');
        localStorage.setItem('tt_theme', 'light');
        if (btn) btn.textContent = '🌙 ${adminThemeDarkText}';
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
    open: '${adminTranslationOpenMsg}',
    hide: '${adminTranslationHideMsg}',
    refresh: '${adminTranslationRefreshMsg}',
    createNew: '${adminTranslationCreateNewMsg}',
    create: '${adminTranslationCreateMsg}',
    none: '${adminTranslationNoneMsg}',
    noTranslationSelected: '${adminTranslationNoTranslationSelectedMsg}',
    collapsedHint: '${adminTranslationCollapsedHintMsg}',
    currentSource: '${adminTranslationCurrentSourceMsg}',
    basedSource: '${adminTranslationBasedSourceMsg}',
    translatedText: '${adminTranslationTranslatedTextMsg}',
    title: '${adminTranslationTitleMsg}',
    titlePlaceholder: '${adminTranslationTitlePlaceholderMsg}',
    sourceLang: '${adminTranslationSourceLangMsg}',
    targetLang: '${adminTranslationTargetLangMsg}',
    autoGenerate: '${adminTranslationAutoGenerateMsg}',
    initialText: '${adminTranslationInitialTextMsg}',
    note: '${adminTranslationNoteMsg}',
    primary: '${adminTranslationPrimaryMsg}',
    primaryShort: '${adminTranslationPrimaryShortMsg}',
    outdated: '${adminTranslationOutdatedMsg}',
    outdatedShort: '${adminTranslationOutdatedShortMsg}',
    upToDate: '${adminTranslationUpToDateMsg}',
    setPrimary: '${adminTranslationSetPrimaryMsg}',
    saveRevision: '${adminTranslationSaveRevisionMsg}',
    revisionHistory: '${adminTranslationRevisionHistoryMsg}',
    restoreRevision: '${adminTranslationRestoreRevisionMsg}',
    noRevision: '${adminTranslationNoRevisionMsg}',
    untitled: '${adminTranslationUntitledMsg}',
    loading: '${adminTranslationLoadingMsg}',
    created: '${adminTranslationCreatedMsg}',
    saved: '${adminTranslationSavedMsg}',
    restored: '${adminTranslationRestoredMsg}',
    confirmRestore: '${adminTranslationConfirmRestoreMsg}',
    requestFailed: '${adminTranslationRequestFailedMsg}',
    enterTranslatedText: '${adminTranslationEnterTranslatedTextMsg}',
    loadFailed: '${adminTranslationLoadFailedMsg}',
    createFailed: '${adminTranslationCreateFailedMsg}',
    saveFailed: '${adminTranslationSaveFailedMsg}',
    restoreFailed: '${adminTranslationRestoreFailedMsg}',
    sectionTitle: '${adminTranslationSectionTitleMsg}',
    languages: {
        ko: '${headerLangKoMsg}',
        en: '${headerLangEnMsg}',
        ja: '${headerLangJaMsg}',
        zh: '${headerLangZhMsg}'
    }
};
</script>
<script src="${pageContext.request.contextPath}/resources/js/admin/admin-translation.js"></script>
