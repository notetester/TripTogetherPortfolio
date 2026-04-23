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
            <c:if test="${hasMemberAdmin or hasAnyBlockAdmin}">
            <div class="adm-nav-group" data-group="members">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('members')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title">회원 관리</span>
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
                </div>
            </div>
            </c:if>

            <%-- 보안·감사 --%>
            <c:if test="${hasAuditAdmin}">
            <div class="adm-nav-group" data-group="security">
                <button type="button" class="adm-nav-group-head" onclick="admToggleNavGroup('security')">
                    <span class="adm-nav-group-caret">▸</span>
                    <span class="adm-nav-group-title">보안·감사</span>
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
                    <span class="adm-nav-group-title">AI 관리</span>
                </button>
                <div class="adm-nav-group-body">
                    <c:if test="${hasAssistantAdmin}">
                    <a class="adm-nav-item ${activeMenu=='aiHelper' and section ne 'chatbot'?'active':''}" href="${pageContext.request.contextPath}/admin/ai-helper">
                        <span class="adm-nav-icon">🤖</span> AI 도우미 관리
                    </a>
                    </c:if>
                    <c:if test="${hasAiChatbotAdmin}">
                    <a class="adm-nav-item ${activeMenu=='aiHelper' and section eq 'chatbot'?'active':''}" href="${pageContext.request.contextPath}/admin/ai-helper/chatbot">
                        <span class="adm-nav-icon">💬</span> AI 챗봇 관리
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
            <button class="sa-theme-btn" id="saThemeBtn" onclick="saToggleTheme()" title="<spring:message code="admin.layout.themeToggleTitle"/>">☀️ <spring:message code="admin.layout.theme.light"/></button>
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
</script>

<script>
window.__CTX__ = '${pageContext.request.contextPath}';
window.ADMIN_TRANSLATION_UI = {
    open: '<spring:message code="admin.translation.open" text="번역 보기" javaScriptEscape="true"/>',
    hide: '<spring:message code="admin.translation.hide" text="숨기기" javaScriptEscape="true"/>',
    refresh: '<spring:message code="admin.translation.refresh" text="새로고침" javaScriptEscape="true"/>',
    createNew: '<spring:message code="admin.translation.createNew" text="새로 만들기" javaScriptEscape="true"/>',
    create: '<spring:message code="admin.translation.create" text="생성" javaScriptEscape="true"/>',
    none: '<spring:message code="admin.translation.none" text="생성된 번역본 없음" javaScriptEscape="true"/>',
    noTranslationSelected: '<spring:message code="admin.translation.noTranslationSelected" text="번역안을 선택해줘야 함" javaScriptEscape="true"/>',
    collapsedHint: '<spring:message code="admin.translation.collapsedHint" text="버튼을 눌러 번역 목록을 확인" javaScriptEscape="true"/>',
    currentSource: '<spring:message code="admin.translation.currentSource" text="현재 원문" javaScriptEscape="true"/>',
    basedSource: '<spring:message code="admin.translation.basedSource" text="현재 버전 기준 원문" javaScriptEscape="true"/>',
    translatedText: '<spring:message code="admin.translation.translatedText" text="번역문" javaScriptEscape="true"/>',
    title: '<spring:message code="admin.translation.title" text="제목" javaScriptEscape="true"/>',
    titlePlaceholder: '<spring:message code="admin.translation.titlePlaceholder" text="예: ko→en 번역안" javaScriptEscape="true"/>',
    sourceLang: '<spring:message code="admin.translation.sourceLang" text="소스 언어" javaScriptEscape="true"/>',
    targetLang: '<spring:message code="admin.translation.targetLang" text="타겟 언어" javaScriptEscape="true"/>',
    autoGenerate: '<spring:message code="admin.translation.autoGenerate" text="자동 번역으로 초안 생성" javaScriptEscape="true"/>',
    initialText: '<spring:message code="admin.translation.initialText" text="초기 번역문" javaScriptEscape="true"/>',
    note: '<spring:message code="admin.translation.note" text="메모" javaScriptEscape="true"/>',
    primary: '<spring:message code="admin.translation.primary" text="대표본" javaScriptEscape="true"/>',
    primaryShort: '<spring:message code="admin.translation.primaryShort" text="대표" javaScriptEscape="true"/>',
    outdated: '<spring:message code="admin.translation.outdated" text="현재 원문과 기준 스냅샷이 다름" javaScriptEscape="true"/>',
    outdatedShort: '<spring:message code="admin.translation.outdatedShort" text="구버전" javaScriptEscape="true"/>',
    upToDate: '<spring:message code="admin.translation.upToDate" text="현재 원문 기준과 일치" javaScriptEscape="true"/>',
    setPrimary: '<spring:message code="admin.translation.setPrimary" text="이 번역안을 대표본으로 지정" javaScriptEscape="true"/>',
    saveRevision: '<spring:message code="admin.translation.saveRevision" text="새 버전 저장" javaScriptEscape="true"/>',
    revisionHistory: '<spring:message code="admin.translation.revisionHistory" text="버전 이력" javaScriptEscape="true"/>',
    restoreRevision: '<spring:message code="admin.translation.restoreRevision" text="선택 버전으로 되돌리기" javaScriptEscape="true"/>',
    noRevision: '<spring:message code="admin.translation.noRevision" text="버전 없음" javaScriptEscape="true"/>',
    untitled: '<spring:message code="admin.translation.untitled" text="제목 없음" javaScriptEscape="true"/>',
    loading: '<spring:message code="admin.translation.loading" text="불러오는 중..." javaScriptEscape="true"/>',
    created: '<spring:message code="admin.translation.created" text="번역안을 생성했음" javaScriptEscape="true"/>',
    saved: '<spring:message code="admin.translation.saved" text="새 번역 버전을 저장했음" javaScriptEscape="true"/>',
    restored: '<spring:message code="admin.translation.restored" text="선택 버전으로 되돌렸음" javaScriptEscape="true"/>',
    confirmRestore: '<spring:message code="admin.translation.confirmRestore" text="선택한 버전으로 되돌리겠음?" javaScriptEscape="true"/>',
    requestFailed: '<spring:message code="admin.translation.requestFailed" text="요청 처리 중 오류가 발생했음" javaScriptEscape="true"/>',
    enterTranslatedText: '<spring:message code="admin.translation.enterTranslatedText" text="번역문을 입력해야 함" javaScriptEscape="true"/>',
    languages: {
        ko: '<spring:message code="header.lang.ko" text="한국어" javaScriptEscape="true"/>',
        en: '<spring:message code="header.lang.en" text="English" javaScriptEscape="true"/>',
        ja: '<spring:message code="header.lang.ja" text="日本語" javaScriptEscape="true"/>',
        zh: '<spring:message code="header.lang.zh" text="中文" javaScriptEscape="true"/>'
    }
};
</script>
<script src="${pageContext.request.contextPath}/resources/js/admin/admin-translation.js"></script>
