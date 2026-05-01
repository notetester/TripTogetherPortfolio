<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
                        <span class="adm-nav-icon">⚙️</span> 로그인 위험 정책
                    </a>
                    <a class="adm-nav-item ${activeMenu=='loginRiskReviews'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/reviews">
                        <span class="adm-nav-icon">🧯</span> 로그인 위험 검토
                    </a>
                    <a class="adm-nav-item ${activeMenu=='loginRiskAssessments'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/assessments">
                        <span class="adm-nav-icon">🧠</span> 외부 위험 판단
                    </a>
                    <a class="adm-nav-item ${activeMenu=='adminNotificationPreferences'?'active':''}" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">
                        <span class="adm-nav-icon">🔔</span> 알림 설정
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
                <a href="${pageContext.request.contextPath}/auth/logout" class="adm-logout" title="<spring:message code="admin.layout.logoutTitle"/>">⏏</a>
            </div>
        </div>
    </aside>

    <div class="adm-main">
        <div class="adm-topbar">
            <button type="button" class="adm-nav-toggle" id="sidebar-toggle"
                    aria-label="메뉴" aria-expanded="false" aria-controls="adm-sidebar">
                <span class="adm-nav-toggle-bar"></span>
                <span class="adm-nav-toggle-bar"></span>
                <span class="adm-nav-toggle-bar"></span>
            </button>
            <div class="adm-topbar-title">${pageTitle}</div>
            <div class="adm-topbar-controls">
                <label class="adm-topbar-select-wrap" for="admLangSel" title="<spring:message code='admin.layout.languageTitle'/>">
                    <span class="adm-topbar-tool-label"><spring:message code="admin.layout.language"/></span>
                    <select class="adm-select adm-topbar-select" id="admLangSel" aria-label="<spring:message code='admin.layout.languageTitle'/>">
                        <option value="ko" ${pageContext.response.locale.language == 'ko' ? 'selected' : ''}><spring:message code="header.lang.ko"/></option>
                        <option value="en" ${pageContext.response.locale.language == 'en' ? 'selected' : ''}><spring:message code="header.lang.en"/></option>
                        <option value="ja" ${pageContext.response.locale.language == 'ja' ? 'selected' : ''}><spring:message code="header.lang.ja"/></option>
                        <option value="zh" ${pageContext.response.locale.language == 'zh' ? 'selected' : ''}><spring:message code="header.lang.zh"/></option>
                    </select>
                </label>
                <button class="sa-theme-btn" id="saThemeBtn" onclick="saToggleTheme()" title="<spring:message code="admin.layout.themeToggleTitle"/>">☀️ <spring:message code="admin.layout.theme.light"/></button>
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
    open: '<spring:message code="admin.translation.open" text="Translations" javaScriptEscape="true"/>',
    hide: '<spring:message code="admin.translation.hide" text="Hide" javaScriptEscape="true"/>',
    refresh: '<spring:message code="admin.translation.refresh" text="Refresh" javaScriptEscape="true"/>',
    createNew: '<spring:message code="admin.translation.createNew" text="Create new" javaScriptEscape="true"/>',
    create: '<spring:message code="admin.translation.create" text="Create" javaScriptEscape="true"/>',
    none: '<spring:message code="admin.translation.none" text="No translations" javaScriptEscape="true"/>',
    noTranslationSelected: '<spring:message code="admin.translation.noTranslationSelected" text="Select a translation" javaScriptEscape="true"/>',
    collapsedHint: '<spring:message code="admin.translation.collapsedHint" text="Open to load translations" javaScriptEscape="true"/>',
    currentSource: '<spring:message code="admin.translation.currentSource" text="Current source" javaScriptEscape="true"/>',
    basedSource: '<spring:message code="admin.translation.basedSource" text="Base source" javaScriptEscape="true"/>',
    translatedText: '<spring:message code="admin.translation.translatedText" text="Translated text" javaScriptEscape="true"/>',
    title: '<spring:message code="admin.translation.title" text="Title" javaScriptEscape="true"/>',
    titlePlaceholder: '<spring:message code="admin.translation.titlePlaceholder" text="e.g. ko→en draft" javaScriptEscape="true"/>',
    sourceLang: '<spring:message code="admin.translation.sourceLang" text="Source language" javaScriptEscape="true"/>',
    targetLang: '<spring:message code="admin.translation.targetLang" text="Target language" javaScriptEscape="true"/>',
    autoGenerate: '<spring:message code="admin.translation.autoGenerate" text="Generate draft automatically" javaScriptEscape="true"/>',
    initialText: '<spring:message code="admin.translation.initialText" text="Initial translation" javaScriptEscape="true"/>',
    note: '<spring:message code="admin.translation.note" text="Note" javaScriptEscape="true"/>',
    primary: '<spring:message code="admin.translation.primary" text="Primary version" javaScriptEscape="true"/>',
    primaryShort: '<spring:message code="admin.translation.primaryShort" text="Primary" javaScriptEscape="true"/>',
    outdated: '<spring:message code="admin.translation.outdated" text="Source snapshot changed" javaScriptEscape="true"/>',
    outdatedShort: '<spring:message code="admin.translation.outdatedShort" text="Old" javaScriptEscape="true"/>',
    upToDate: '<spring:message code="admin.translation.upToDate" text="Up to date" javaScriptEscape="true"/>',
    setPrimary: '<spring:message code="admin.translation.setPrimary" text="Mark as primary" javaScriptEscape="true"/>',
    saveRevision: '<spring:message code="admin.translation.saveRevision" text="Save revision" javaScriptEscape="true"/>',
    revisionHistory: '<spring:message code="admin.translation.revisionHistory" text="Revision history" javaScriptEscape="true"/>',
    restoreRevision: '<spring:message code="admin.translation.restoreRevision" text="Restore selected revision" javaScriptEscape="true"/>',
    noRevision: '<spring:message code="admin.translation.noRevision" text="No revisions" javaScriptEscape="true"/>',
    untitled: '<spring:message code="admin.translation.untitled" text="Untitled" javaScriptEscape="true"/>',
    loading: '<spring:message code="admin.translation.loading" text="Loading..." javaScriptEscape="true"/>',
    created: '<spring:message code="admin.translation.created" text="Translation created" javaScriptEscape="true"/>',
    saved: '<spring:message code="admin.translation.saved" text="Revision saved" javaScriptEscape="true"/>',
    restored: '<spring:message code="admin.translation.restored" text="Revision restored" javaScriptEscape="true"/>',
    confirmRestore: '<spring:message code="admin.translation.confirmRestore" text="Restore selected revision?" javaScriptEscape="true"/>',
    requestFailed: '<spring:message code="admin.translation.requestFailed" text="Request failed" javaScriptEscape="true"/>',
    enterTranslatedText: '<spring:message code="admin.translation.enterTranslatedText" text="Enter translated text" javaScriptEscape="true"/>',
    loadFailed: '<spring:message code="admin.translation.loadFailed" text="Failed to load translations" javaScriptEscape="true"/>',
    createFailed: '<spring:message code="admin.translation.createFailed" text="Failed to create translation" javaScriptEscape="true"/>',
    saveFailed: '<spring:message code="admin.translation.saveFailed" text="Failed to save translation" javaScriptEscape="true"/>',
    restoreFailed: '<spring:message code="admin.translation.restoreFailed" text="Failed to restore revision" javaScriptEscape="true"/>',
    sectionTitle: '<spring:message code="admin.translation.sectionTitle" text="Translation management" javaScriptEscape="true"/>',
    languages: {
        ko: '<spring:message code="header.lang.ko" text="Korean" javaScriptEscape="true"/>',
        en: '<spring:message code="header.lang.en" text="English" javaScriptEscape="true"/>',
        ja: '<spring:message code="header.lang.ja" text="日本語" javaScriptEscape="true"/>',
        zh: '<spring:message code="header.lang.zh" text="中文" javaScriptEscape="true"/>'
    }
};
</script>
<script src="${pageContext.request.contextPath}/resources/js/admin/admin-translation.js"></script>
