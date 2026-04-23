<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>
    (function () {
        // 구버전 키(sa_theme) → 신규 키(tt_theme) 일회성 마이그레이션
        try {
            var legacy = localStorage.getItem('sa_theme');
            if (legacy !== null) {
                if (!localStorage.getItem('tt_theme')) {
                    localStorage.setItem('tt_theme', legacy === 'sa-light' ? 'light' : 'dark');
                }
                localStorage.removeItem('sa_theme');
            }
            // 일반 사이트 기본은 라이트. tt_theme === 'dark' 일 때만 html.dark 적용
            if (localStorage.getItem('tt_theme') === 'dark') {
                document.documentElement.classList.add('dark');
            }
        } catch (e) {}
    })();
    </script>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/TripTogetherFavicon.png"> <%-- 파비콘 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/notification.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/item-effects.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/dark-theme.css">
    <c:if test="${not empty pageCSS}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/${pageCSS}">
    </c:if>
</head>
<header>
    <div class="hi">
        <button type="button" class="nav-toggle" id="navToggle" aria-label="메뉴" aria-expanded="false" aria-controls="primaryNav">
            <span class="nav-toggle-bar"></span>
            <span class="nav-toggle-bar"></span>
            <span class="nav-toggle-bar"></span>
        </button>
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/'">
            <div class="logo-icon">🌐</div>
            <span class="logo-text">TripTogether</span>
        </div>
        <nav id="primaryNav">
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/explore'"><spring:message code="header.nav.explore"/></button>

            <div class="nb-drop">
                <button type="button" class="nb nb-drop-trigger"><spring:message code="header.nav.planner"/></button>
                <div class="nb-drop-menu">
                    <a href="${pageContext.request.contextPath}/courses"><spring:message code="header.nav.courses"/></a>
                    <a href="${pageContext.request.contextPath}/assistant"><spring:message code="header.nav.assistant"/></a>
                </div>
            </div>

            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/community/list'"><spring:message code="header.nav.community"/></button>

            <div class="nb-drop">
                <button type="button" class="nb nb-drop-trigger"><spring:message code="header.nav.shopping"/></button>
                <div class="nb-drop-menu">
                    <a href="${pageContext.request.contextPath}/wallet"><spring:message code="header.nav.wallet"/></a>
                    <a href="${pageContext.request.contextPath}/shop"><spring:message code="header.nav.shop"/></a>
                    <a href="${pageContext.request.contextPath}/packages"><spring:message code="header.nav.packages"/></a>
                    <c:if test="${not empty sessionScope.loginUser and (sessionScope.loginUser.userRole == 'BUSINESS' or sessionScope.loginUser.userRole == 'PARTNER')}">
                        <a href="${pageContext.request.contextPath}/packages/manage"><spring:message code="header.nav.packagesManage"/></a>
                    </c:if>
                </div>
            </div>

            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/mypage'"><spring:message code="header.nav.mypage"/></button>
            <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userRole == 'ADMIN'}">
    <button class="nb" onclick="location.href='${pageContext.request.contextPath}/admin'"><spring:message code="header.nav.admin"/></button>
    <button class="admin-mode-btn ${isAdminMode ? 'admin' : 'user'}"
            onclick="toggleViewMode()">
        ${isAdminMode ? '🛡️ ' : '👤 '}
        <spring:message code="${isAdminMode ? 'header.mode.admin' : 'header.mode.user'}"/>
    </button>
</c:if>

        </nav>
        <div class="hr">
            <button type="button" class="tt-theme-btn" id="ttThemeBtn" aria-label="<spring:message code='header.theme.toggle'/>"
                    data-light-label="<spring:message code='header.theme.light'/>"
                    data-dark-label="<spring:message code='header.theme.dark'/>">
                <span class="tt-theme-icon">🌙</span>
                <span class="tt-theme-label"><spring:message code="header.theme.dark"/></span>
            </button>
            <label>
                <select class="lang-sel" id="langSel">
                    <option value="ko" ${pageContext.response.locale.language == 'ko' ? 'selected' : ''}><spring:message code="header.lang.ko"/></option>
                    <option value="en" ${pageContext.response.locale.language == 'en' ? 'selected' : ''}><spring:message code="header.lang.en"/></option>
                    <option value="ja" ${pageContext.response.locale.language == 'ja' ? 'selected' : ''}><spring:message code="header.lang.ja"/></option>
                    <option value="zh" ${pageContext.response.locale.language == 'zh' ? 'selected' : ''}><spring:message code="header.lang.zh"/></option>
                </select>
            </label>
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <%-- 알림 벨 --%>
                    <div class="noti-wrap">
                        <button type="button" class="noti-bell" id="notiBell" aria-label="<spring:message code='header.notification.bell'/>">
                            <span class="noti-bell-icon">🔔</span>
                            <c:if test="${headerUnreadCount > 0}">
                                <span class="noti-badge">${headerUnreadCount > 99 ? '99+' : headerUnreadCount}</span>
                            </c:if>
                        </button>
                        <div class="noti-dropdown" id="notiDropdown" hidden>
                            <div class="noti-dropdown-head">
                                <span class="noti-dropdown-title"><spring:message code="header.notification.title"/></span>
                                <button type="button" class="noti-mark-all" id="notiMarkAll"><spring:message code="header.notification.markAll"/></button>
                            </div>
                            <div class="noti-dropdown-body">
                                <c:choose>
                                    <c:when test="${empty headerRecentNotifications}">
                                        <div class="noti-empty"><spring:message code="header.notification.empty"/></div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="n" items="${headerRecentNotifications}">
                                            <c:set var="readClass" value=""/>
                                            <c:if test="${n.isRead}">
                                                <c:set var="readClass" value="is-read"/>
                                            </c:if>
                                            <div class="noti-row ${readClass}"
                                                 data-id="${n.notificationId}"
                                                 data-target="${n.targetUrl}">
                                                <span class="noti-type">
                                                    <c:choose>
                                                        <c:when test="${n.sourceType eq 'community'}"><spring:message code="header.notification.type.community"/></c:when>
                                                        <c:when test="${n.sourceType eq 'inquiry'}"><spring:message code="header.notification.type.inquiry"/></c:when>
                                                        <c:when test="${n.sourceType eq 'report'}"><spring:message code="header.notification.type.report"/></c:when>
                                                        <c:when test="${n.sourceType eq 'levelup'}"><spring:message code="header.notification.type.levelup"/></c:when>
                                                        <c:when test="${n.sourceType eq 'grade'}"><spring:message code="header.notification.type.grade"/></c:when>
                                                        <c:when test="${n.sourceType eq 'account_block'}"><spring:message code="header.notification.type.accountBlock"/></c:when>
                                                        <c:otherwise><spring:message code="header.notification.type.default"/></c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <span class="noti-msg">${n.message}</span>
                                                <span class="noti-date">
                                                    <fmt:formatDate value="${n.createdAt}" pattern="MM-dd HH:mm"/>
                                                </span>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="noti-dropdown-foot">
                                <a href="${pageContext.request.contextPath}/mypage"><spring:message code="header.notification.viewAll"/></a>
                            </div>
                        </div>
                    </div>
                    <span class="user-nick">${sessionScope.loginUser.nickname}</span>
                    <button class="btn-out" onclick="location.href='${pageContext.request.contextPath}/auth/logout'"><spring:message code="header.auth.logout"/></button>
                </c:when>
                <c:otherwise>
                    <button class="btn-out" onclick="location.href='${pageContext.request.contextPath}/auth/login?redirect=' + encodeURIComponent(window.location.pathname + window.location.search)"><spring:message code="header.auth.login"/></button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="nav-backdrop" id="navBackdrop" hidden></div>
</header>

<c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userRole == 'ADMIN'}">
<script>
function toggleViewMode() {
    fetch('${pageContext.request.contextPath}/community/admin/viewmode', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(function(res) { return res.json(); })
    .then(function(data) {
        if (data.success) location.reload();
    });
}
</script>
</c:if>

<script>
window.__notificationConfig = {
    ctx: '${pageContext.request.contextPath}',
    locale: '${pageContext.response.locale}',
    labels: {
        typeCommunity: '<spring:message code="header.notification.type.community" javaScriptEscape="true"/>',
        typeInquiry: '<spring:message code="header.notification.type.inquiry" javaScriptEscape="true"/>',
        typeReport: '<spring:message code="header.notification.type.report" javaScriptEscape="true"/>',
        typeLevelup: '<spring:message code="header.notification.type.levelup" javaScriptEscape="true"/>',
        typeGrade: '<spring:message code="header.notification.type.grade" javaScriptEscape="true"/>',
        typeAccountBlock: '<spring:message code="header.notification.type.accountBlock" javaScriptEscape="true"/>',
        typeDefault: '<spring:message code="header.notification.type.default" javaScriptEscape="true"/>',
        close: '<spring:message code="header.notification.close" javaScriptEscape="true"/>'
    }
};

(function () {
    const btn = document.getElementById('ttThemeBtn');
    if (!btn) return;

    const iconEl = btn.querySelector('.tt-theme-icon');
    const labelEl = btn.querySelector('.tt-theme-label');
    const lightLabel = btn.dataset.lightLabel;
    const darkLabel = btn.dataset.darkLabel;

    const syncIcon = function () {
        const isDark = document.documentElement.classList.contains('dark');
        if (iconEl) iconEl.textContent = isDark ? '☀️' : '🌙';
        if (labelEl) labelEl.textContent = isDark ? lightLabel : darkLabel;
    };
    syncIcon();

    btn.addEventListener('click', function () {
        const html = document.documentElement;
        if (html.classList.contains('dark')) {
            html.classList.remove('dark');
            localStorage.setItem('tt_theme', 'light');
        } else {
            html.classList.add('dark');
            localStorage.setItem('tt_theme', 'dark');
        }
        syncIcon();
    });
})();

(function () {
    const langSel = document.getElementById('langSel');
    if (!langSel) return;

    langSel.addEventListener('change', function () {
        const url = new URL(window.location.href);
        url.searchParams.set('lang', this.value);
        window.location.href = url.toString();
    });
})();

(function () {
    const navButtons = document.querySelectorAll('.js-header-nav[data-url]');
    navButtons.forEach(function (button) {
        button.addEventListener('click', function () {
            window.location.href = button.dataset.url;
        });
    });
})();

(function () {
    const toggle   = document.getElementById('navToggle');
    const nav      = document.getElementById('primaryNav');
    const backdrop = document.getElementById('navBackdrop');
    if (!toggle || !nav || !backdrop) return;

    const mqMobile = window.matchMedia('(max-width: 767px)');

    function openNav() {
        nav.classList.add('is-open');
        backdrop.hidden = false;
        requestAnimationFrame(function () { backdrop.classList.add('is-open'); });
        toggle.classList.add('is-open');
        toggle.setAttribute('aria-expanded', 'true');
        document.body.classList.add('nav-lock');
    }
    function closeNav() {
        nav.classList.remove('is-open');
        backdrop.classList.remove('is-open');
        backdrop.hidden = true;
        toggle.classList.remove('is-open');
        toggle.setAttribute('aria-expanded', 'false');
        document.body.classList.remove('nav-lock');
        document.querySelectorAll('.nb-drop.is-open').forEach(function (d) { d.classList.remove('is-open'); });
    }
    function toggleNav() {
        if (nav.classList.contains('is-open')) closeNav(); else openNav();
    }

    toggle.addEventListener('click', toggleNav);
    backdrop.addEventListener('click', closeNav);

    // 모바일에서 nav 내부 일반 버튼/링크 클릭 시 닫기 (드롭다운 트리거 제외)
    nav.addEventListener('click', function (e) {
        if (!mqMobile.matches) return;
        const trigger = e.target.closest('.nb-drop-trigger');
        if (trigger) return;
        const interactive = e.target.closest('a, button');
        if (interactive) closeNav();
    });

    // 드롭다운 (플래너·쇼핑) 모바일 클릭 토글
    document.querySelectorAll('.nb-drop-trigger').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            if (!mqMobile.matches) return;
            e.preventDefault();
            const drop = btn.closest('.nb-drop');
            if (!drop) return;
            document.querySelectorAll('.nb-drop.is-open').forEach(function (d) {
                if (d !== drop) d.classList.remove('is-open');
            });
            drop.classList.toggle('is-open');
        });
    });

    // 데스크탑 폭으로 넓어지면 강제 닫기
    const mqClose = window.matchMedia('(min-width: 768px)');
    const handleChange = function (e) { if (e.matches) closeNav(); };
    if (mqClose.addEventListener) mqClose.addEventListener('change', handleChange);
    else if (mqClose.addListener) mqClose.addListener(handleChange);
})();
</script>
<c:if test="${not empty sessionScope.loginUser}">
<script src="${pageContext.request.contextPath}/resources/js/common/notification.js" defer></script>
</c:if>
