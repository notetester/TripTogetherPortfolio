<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_fe4ca83b93" code="header.nav.explore"/>
<spring:message var="autoMsg_57a737b687" code="header.nav.planner"/>
<spring:message var="autoMsg_ebc0676222" code="header.nav.courses"/>
<spring:message var="autoMsg_03f3d3819f" code="header.nav.assistant"/>
<spring:message var="autoMsg_2f4d41911a" code="header.nav.community"/>
<spring:message var="autoMsg_14bfa33b52" code="header.nav.shopping"/>
<spring:message var="autoMsg_dde0f5b110" code="header.nav.wallet"/>
<spring:message var="autoMsg_8e8357a713" code="header.nav.shop"/>
<spring:message var="autoMsg_0082c2296b" code="header.nav.packages"/>
<spring:message var="autoMsg_f0caf89bd6" code="header.nav.packagesManage"/>
<spring:message var="autoMsg_92b44e9cef" code="header.nav.mypage"/>
<spring:message var="autoMsg_38799f0417" code="header.nav.admin"/>
<spring:message var="autoMsg_adba4e5d87" code="header.theme.toggle"/>
<spring:message var="autoMsg_e1554a21a2" code="header.theme.light"/>
<spring:message var="autoMsg_fe53ee6cf7" code="header.theme.dark"/>
<spring:message var="autoMsg_a1f0f447b7" code="header.lang.ko"/>
<spring:message var="autoMsg_54e1558573" code="header.lang.en"/>
<spring:message var="autoMsg_6f634254c7" code="header.lang.ja"/>
<spring:message var="autoMsg_978a9adc88" code="header.lang.zh"/>
<spring:message var="autoMsg_99e794082b" code="header.notification.bell"/>
<spring:message var="autoMsg_294e877212" code="header.notification.title"/>
<spring:message var="autoMsg_8aaf9aff12" code="header.notification.markAll"/>
<spring:message var="autoMsg_9d2c2c0955" code="header.notification.empty"/>
<spring:message var="autoMsg_b0c11b1f43" code="header.notification.type.community"/>
<spring:message var="autoMsg_528facd8d8" code="header.notification.type.inquiry"/>
<spring:message var="autoMsg_3165e47ac0" code="header.notification.type.report"/>
<spring:message var="autoMsg_d5bee8437a" code="header.notification.type.levelup"/>
<spring:message var="autoMsg_c8c4fc1cd0" code="header.notification.type.grade"/>
<spring:message var="autoMsg_6c6f3837f7" code="header.notification.type.accountBlock"/>
<spring:message var="autoMsg_b264eccb58" code="header.notification.type.default"/>
<spring:message var="autoMsg_675c16d2fa" code="header.notification.viewAll"/>
<spring:message var="autoMsg_40e13fb88f" code="header.auth.logout"/>
<spring:message var="autoMsg_31f9ea3baf" code="header.auth.login"/>
<spring:message var="autoMsg_c452e50cb1" code="header.notification.type.community" javaScriptEscape="true"/>
<spring:message var="autoMsg_97b9df4272" code="header.notification.type.inquiry" javaScriptEscape="true"/>
<spring:message var="autoMsg_d2ffce6673" code="header.notification.type.report" javaScriptEscape="true"/>
<spring:message var="autoMsg_8065198104" code="header.notification.type.levelup" javaScriptEscape="true"/>
<spring:message var="autoMsg_48fd5de961" code="header.notification.type.grade" javaScriptEscape="true"/>
<spring:message var="autoMsg_260381f518" code="header.notification.type.accountBlock" javaScriptEscape="true"/>
<spring:message var="autoMsg_7c88c563ba" code="header.notification.type.default" javaScriptEscape="true"/>
<spring:message var="autoMsg_c7f7723560" code="header.notification.close" javaScriptEscape="true"/>
<spring:message var="autoMsg_eca2f711c1" code="header.notification.justNow" javaScriptEscape="true"/>
<spring:message var="autoMsg_c85f2b505a" code="header.notification.view" javaScriptEscape="true"/>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%-- 정책: ADR-0012 (Spring Security CSRF 부분 도입) - 토큰 노출 + 자동 헤더 첨부 --%>
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <script>
    (function () {
        var meta = document.querySelector('meta[name="_csrf"]');
        var headerMeta = document.querySelector('meta[name="_csrf_header"]');
        var token = meta ? meta.getAttribute('content') : null;
        var header = headerMeta ? headerMeta.getAttribute('content') : null;
        if (!token || !header) return;

        // fetch monkey-patch: 같은 origin 의 요청에 자동으로 CSRF 헤더 첨부
        var origFetch = window.fetch;
        window.fetch = function (input, init) {
            init = init || {};
            var url = typeof input === 'string' ? input : (input && input.url) || '';
            var sameOrigin = url.startsWith('/') || url.startsWith(window.location.origin);
            if (sameOrigin) {
                if (init.headers instanceof Headers) {
                    init.headers.set(header, token);
                } else if (Array.isArray(init.headers)) {
                    init.headers.push([header, token]);
                } else {
                    init.headers = init.headers || {};
                    init.headers[header] = token;
                }
            }
            return origFetch.call(this, input, init);
        };

        // jQuery 가 로드된 시점에 ajaxSetup (jQuery 사용처 자동 적용)
        (function trySetupJQuery(retry) {
            if (window.jQuery) {
                window.jQuery.ajaxSetup({
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader(header, token);
                    }
                });
            } else if (retry < 30) {
                setTimeout(function () { trySetupJQuery(retry + 1); }, 100);
            }
        })(0);
    })();
    </script>
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
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/explore'">${autoMsg_fe4ca83b93}</button>

            <div class="nb-drop">
                <button type="button" class="nb nb-drop-trigger">${autoMsg_57a737b687}</button>
                <div class="nb-drop-menu">
                    <a href="${pageContext.request.contextPath}/courses">${autoMsg_ebc0676222}</a>
                    <a href="${pageContext.request.contextPath}/assistant">${autoMsg_03f3d3819f}</a>
                </div>
            </div>

            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/community/list'">${autoMsg_2f4d41911a}</button>

            <div class="nb-drop">
                <button type="button" class="nb nb-drop-trigger">${autoMsg_14bfa33b52}</button>
                <div class="nb-drop-menu">
                    <a href="${pageContext.request.contextPath}/wallet">${autoMsg_dde0f5b110}</a>
                    <a href="${pageContext.request.contextPath}/shop">${autoMsg_8e8357a713}</a>
                    <a href="${pageContext.request.contextPath}/packages">${autoMsg_0082c2296b}</a>
                    <c:if test="${not empty sessionScope.loginUser and (sessionScope.loginUser.userRole == 'BUSINESS' or sessionScope.loginUser.userRole == 'PARTNER')}">
                        <a href="${pageContext.request.contextPath}/packages/manage">${autoMsg_f0caf89bd6}</a>
                    </c:if>
                </div>
            </div>

            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/mypage'">${autoMsg_92b44e9cef}</button>
            <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userRole == 'ADMIN'}">
    <button class="nb" onclick="location.href='${pageContext.request.contextPath}/admin'">${autoMsg_38799f0417}</button>
    <button class="admin-mode-btn ${isAdminMode ? 'admin' : 'user'}"
            onclick="toggleViewMode()">
        ${isAdminMode ? '🛡️ ' : '👤 '}
        <spring:message code="${isAdminMode ? 'header.mode.admin' : 'header.mode.user'}"/>
    </button>
</c:if>

        </nav>
        <div class="hr">
            <button type="button" class="tt-theme-btn" id="ttThemeBtn" aria-label="${autoMsg_adba4e5d87}"
                    data-light-label="${autoMsg_e1554a21a2}"
                    data-dark-label="${autoMsg_fe53ee6cf7}">
                <span class="tt-theme-icon">🌙</span>
                <span class="tt-theme-label">${autoMsg_fe53ee6cf7}</span>
            </button>
            <label>
                <select class="lang-sel" id="langSel">
                    <option value="ko" ${pageContext.response.locale.language == 'ko' ? 'selected' : ''}>${autoMsg_a1f0f447b7}</option>
                    <option value="en" ${pageContext.response.locale.language == 'en' ? 'selected' : ''}>${autoMsg_54e1558573}</option>
                    <option value="ja" ${pageContext.response.locale.language == 'ja' ? 'selected' : ''}>${autoMsg_6f634254c7}</option>
                    <option value="zh" ${pageContext.response.locale.language == 'zh' ? 'selected' : ''}>${autoMsg_978a9adc88}</option>
                </select>
            </label>
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <%-- 알림 벨 --%>
                    <div class="noti-wrap">
                        <button type="button" class="noti-bell" id="notiBell" aria-label="${autoMsg_99e794082b}">
                            <span class="noti-bell-icon">🔔</span>
                            <c:if test="${headerUnreadCount > 0}">
                                <span class="noti-badge">${headerUnreadCount > 99 ? '99+' : headerUnreadCount}</span>
                            </c:if>
                        </button>
                        <div class="noti-dropdown" id="notiDropdown" hidden>
                            <div class="noti-dropdown-head">
                                <span class="noti-dropdown-title">${autoMsg_294e877212}</span>
                                <button type="button" class="noti-mark-all" id="notiMarkAll">${autoMsg_8aaf9aff12}</button>
                            </div>
                            <div class="noti-dropdown-body">
                                <c:choose>
                                    <c:when test="${empty headerRecentNotifications}">
                                        <div class="noti-empty">${autoMsg_9d2c2c0955}</div>
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
                                                        <c:when test="${n.sourceType eq 'community'}">${autoMsg_b0c11b1f43}</c:when>
                                                        <c:when test="${n.sourceType eq 'inquiry'}">${autoMsg_528facd8d8}</c:when>
                                                        <c:when test="${n.sourceType eq 'report'}">${autoMsg_3165e47ac0}</c:when>
                                                        <c:when test="${n.sourceType eq 'levelup'}">${autoMsg_d5bee8437a}</c:when>
                                                        <c:when test="${n.sourceType eq 'grade'}">${autoMsg_c8c4fc1cd0}</c:when>
                                                        <c:when test="${n.sourceType eq 'account_block'}">${autoMsg_6c6f3837f7}</c:when>
                                                        <c:otherwise>${autoMsg_b264eccb58}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <span class="noti-msg">${n.message}</span>
                                                <span class="noti-date">
                                                    <fmt:formatDate value="${n.createdAtDate}" pattern="MM-dd HH:mm"/>
                                                </span>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="noti-dropdown-foot">
                                <a href="${pageContext.request.contextPath}/mypage">${autoMsg_675c16d2fa}</a>
                            </div>
                        </div>
                    </div>
                    <span class="user-nick">${sessionScope.loginUser.nickname}</span>
                    <button class="btn-out" onclick="location.href='${pageContext.request.contextPath}/auth/logout'">${autoMsg_40e13fb88f}</button>
                </c:when>
                <c:otherwise>
                    <button class="btn-out" onclick="location.href='${pageContext.request.contextPath}/auth/login?redirect=' + encodeURIComponent(window.location.pathname + window.location.search)">${autoMsg_31f9ea3baf}</button>
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
        typeCommunity: '${autoMsg_c452e50cb1}',
        typeInquiry: '${autoMsg_97b9df4272}',
        typeReport: '${autoMsg_d2ffce6673}',
        typeLevelup: '${autoMsg_8065198104}',
        typeGrade: '${autoMsg_48fd5de961}',
        typeAccountBlock: '${autoMsg_260381f518}',
        typeDefault: '${autoMsg_7c88c563ba}',
        close: '${autoMsg_c7f7723560}',
        justNow: '${autoMsg_eca2f711c1}',
        view: '${autoMsg_c85f2b505a}'
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
