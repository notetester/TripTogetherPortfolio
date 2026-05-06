<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_7b5435a2dd" code="footer.copy"/>
<spring:message var="autoMsg_627f110cf4" code="footer.inquiry"/>
<spring:message var="autoMsg_1cc82a4e6b" code="footer.chatbot.open"/>
<spring:message var="autoMsg_4802a71c98" code="footer.chatbot.title"/>
<spring:message var="autoMsg_9d523444bd" code="footer.chatbot.dialog"/>
<spring:message var="autoMsg_439fb3c5de" code="footer.chatbot.newConversation"/>
<spring:message var="autoMsg_5a463a8e9c" code="footer.chatbot.header.reset"/>
<spring:message var="autoMsg_350c005cce" code="footer.chatbot.name"/>
<spring:message var="autoMsg_6c1b4ef473" code="footer.chatbot.status"/>
<spring:message var="autoMsg_155988c0cc" code="footer.chatbot.close"/>
<spring:message var="autoMsg_d0a5fb0243" code="footer.chatbot.placeholder"/>
<spring:message var="autoMsg_fb9719a3a4" code="footer.chatbot.send"/>
<spring:message var="autoMsg_711486a278" code="footer.chatbot.suggest.popular" javaScriptEscape="true"/>
<spring:message var="autoMsg_e8f91f4a92" code="footer.chatbot.suggest.popular.msg" javaScriptEscape="true"/>
<spring:message var="autoMsg_97ae309f35" code="footer.chatbot.suggest.courses" javaScriptEscape="true"/>
<spring:message var="autoMsg_aca46d077c" code="footer.chatbot.suggest.courses.msg" javaScriptEscape="true"/>
<spring:message var="autoMsg_98b08debe6" code="footer.chatbot.suggest.assistant" javaScriptEscape="true"/>
<spring:message var="autoMsg_5626e094f8" code="footer.chatbot.suggest.assistant.msg" javaScriptEscape="true"/>
<spring:message var="autoMsg_9a805b2842" code="footer.chatbot.suggest.community" javaScriptEscape="true"/>
<spring:message var="autoMsg_11efbe2361" code="footer.chatbot.suggest.community.msg" javaScriptEscape="true"/>
<spring:message var="autoMsg_924b0a725c" code="footer.chatbot.suggest.auth" javaScriptEscape="true"/>
<spring:message var="autoMsg_38a2557349" code="footer.chatbot.suggest.auth.msg" javaScriptEscape="true"/>
<spring:message var="autoMsg_72c39a7aaf" code="footer.chatbot.welcome.title" javaScriptEscape="true"/>
<spring:message var="autoMsg_90167c4071" code="footer.chatbot.welcome.body1" javaScriptEscape="true"/>
<spring:message var="autoMsg_ec7a81334e" code="footer.chatbot.welcome.body2" javaScriptEscape="true"/>
<spring:message var="autoMsg_141ddab1b2" code="footer.chatbot.error" javaScriptEscape="true"/>
<spring:message var="autoMsg_74d9d9bf06" code="footer.chatbot.menu.rename" javaScriptEscape="true"/>
<spring:message var="autoMsg_1fbafbd8ce" code="footer.chatbot.menu.delete" javaScriptEscape="true"/>
<spring:message var="autoMsg_7bd3624146" code="footer.chatbot.confirm.delete" javaScriptEscape="true"/>
<spring:message var="autoMsg_7896d924c2" code="footer.chatbot.confirm.reset" javaScriptEscape="true"/>
<spring:message var="autoMsg_c14fdd4c9d" code="footer.chatbot.confirm.yes" javaScriptEscape="true"/>
<spring:message var="autoMsg_8902f4b5ee" code="footer.chatbot.confirm.no" javaScriptEscape="true"/>
<spring:message var="autoMsg_c461d0cee0" code="footer.chatbot.edit.placeholder" javaScriptEscape="true"/>
<spring:message var="autoMsg_7f1f126bd2" code="footer.chatbot.link.newtab" javaScriptEscape="true"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/chatbot.css">

<footer class="site-footer">
    <div class="si">
        <div class="footer-inner">
            <div class="footer-logo">
                <div class="logo-icon" style="width:32px;height:32px;font-size:16px;">🌐</div>
                <span class="logo-text" style="font-size:18px;">TripTogether</span>
            </div>
            <p class="footer-copy">${autoMsg_7b5435a2dd}
                &nbsp;·&nbsp;
                <a href="${pageContext.request.contextPath}/inquiry/list" class="footer-inquiry-link">${autoMsg_627f110cf4}</a>
            </p>
        </div>
    </div>
</footer>

<button id="chatbot-toggle" aria-label="${autoMsg_1cc82a4e6b}" title="${autoMsg_4802a71c98}">
    <span id="cb-toggle-icon">✈️</span>
    <span id="chatbot-badge"></span>
</button>

<div id="chatbot-box" role="dialog" aria-label="${autoMsg_9d523444bd}">

    <%-- 로그인 유저 전용 사이드바 (대화 목록) --%>
    <c:if test="${not empty sessionScope.loginUser}">
        <aside id="cb-sidebar" class="cb-sidebar">
            <button type="button" id="cb-new" class="cb-new-btn">${autoMsg_439fb3c5de}</button>
            <div id="cb-conv-list" class="cb-conv-list"></div>
            <button type="button" id="cb-reset" class="cb-new-btn cb-new-btn--reset"
                    title="${autoMsg_5a463a8e9c}" hidden>
                <spring:message code="footer.chatbot.header.reset"/>
            </button>
        </aside>
    </c:if>

    <%-- 메인 영역 --%>
    <section class="cb-main">
        <div class="cb-header">
            <div class="cb-avatar">✈️</div>
            <div class="cb-header-info">
                <div class="cb-header-name" id="cb-header-title">${autoMsg_350c005cce}</div>
                <div class="cb-header-status">
                    <span class="cb-dot"></span>
                    <span>${autoMsg_6c1b4ef473}</span>
                </div>
            </div>
            <button class="cb-close" id="cb-close" aria-label="${autoMsg_155988c0cc}">✕</button>
        </div>

        <div class="cb-body" id="cb-body"></div>

        <div class="cb-footer">
            <%-- 비로그인 유저용 초기화 버튼 (로그인 유저는 사이드바 하단에 있음) --%>
            <c:if test="${empty sessionScope.loginUser}">
                <button type="button" id="cb-reset" class="cb-new-btn cb-new-btn--reset cb-reset-inline"
                        title="${autoMsg_5a463a8e9c}" hidden>
                    ↻ ${autoMsg_5a463a8e9c}
                </button>
            </c:if>
            <div class="cb-suggestions" id="cb-suggestions"></div>
            <div class="cb-input-row">
                <textarea id="cb-input" placeholder="${autoMsg_d0a5fb0243}" rows="1"></textarea>
                <button id="cb-send" aria-label="${autoMsg_fb9719a3a4}">➤</button>
            </div>
        </div>
    </section>
</div>

<script>
    window.__chatbotConfig = {
        ctx: '${pageContext.request.contextPath}',
        loggedIn: ${not empty sessionScope.loginUser},
        locale: '${pageContext.response.locale}',
        msg: {
            suggestPopular:       '${autoMsg_711486a278}',
            suggestPopularMsg:    '${autoMsg_e8f91f4a92}',
            suggestCourses:       '${autoMsg_97ae309f35}',
            suggestCoursesMsg:    '${autoMsg_aca46d077c}',
            suggestAssistant:     '${autoMsg_98b08debe6}',
            suggestAssistantMsg:  '${autoMsg_5626e094f8}',
            suggestCommunity:     '${autoMsg_9a805b2842}',
            suggestCommunityMsg:  '${autoMsg_11efbe2361}',
            suggestAuth:          '${autoMsg_924b0a725c}',
            suggestAuthMsg:       '${autoMsg_38a2557349}',
            welcomeTitle:         '${autoMsg_72c39a7aaf}',
            welcomeBody1:         '${autoMsg_90167c4071}',
            welcomeBody2:         '${autoMsg_ec7a81334e}',
            error:                '${autoMsg_141ddab1b2}',
            menuRename:           '${autoMsg_74d9d9bf06}',
            menuDelete:           '${autoMsg_1fbafbd8ce}',
            confirmDelete:        '${autoMsg_7bd3624146}',
            confirmReset:         '${autoMsg_7896d924c2}',
            confirmYes:           '${autoMsg_c14fdd4c9d}',
            confirmNo:            '${autoMsg_8902f4b5ee}',
            editPlaceholder:      '${autoMsg_c461d0cee0}',
            openNewTab:           '${autoMsg_7f1f126bd2}'
        }
    };
</script>
<script src="${pageContext.request.contextPath}/resources/js/common/chatbot.js" defer></script>
