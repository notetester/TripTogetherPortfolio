<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/chatbot.css">

<footer class="site-footer">
    <div class="si">
        <div class="footer-inner">
            <div class="footer-logo">
                <div class="logo-icon" style="width:32px;height:32px;font-size:16px;">🌐</div>
                <span class="logo-text" style="font-size:18px;">TripTogether</span>
            </div>
            <p class="footer-copy"><spring:message code="footer.copy"/>
                &nbsp;·&nbsp;
                <a href="${pageContext.request.contextPath}/inquiry/list" class="footer-inquiry-link"><spring:message code="footer.inquiry"/></a>
            </p>
        </div>
    </div>
</footer>

<button id="chatbot-toggle" aria-label="<spring:message code="footer.chatbot.open"/>" title="<spring:message code="footer.chatbot.title"/>">
    <span id="cb-toggle-icon">✈️</span>
    <span id="chatbot-badge"></span>
</button>

<div id="chatbot-box" role="dialog" aria-label="<spring:message code="footer.chatbot.dialog"/>">

    <%-- 로그인 유저 전용 사이드바 (대화 목록) --%>
    <c:if test="${not empty sessionScope.loginUser}">
        <aside id="cb-sidebar" class="cb-sidebar">
            <button type="button" id="cb-new" class="cb-new-btn">＋ 새 대화</button>
            <div id="cb-conv-list" class="cb-conv-list"></div>
            <button type="button" id="cb-reset" class="cb-new-btn cb-new-btn--reset"
                    title="<spring:message code="footer.chatbot.header.reset"/>" hidden>
                <spring:message code="footer.chatbot.header.reset"/>
            </button>
        </aside>
    </c:if>

    <%-- 메인 영역 --%>
    <section class="cb-main">
        <div class="cb-header">
            <div class="cb-avatar">✈️</div>
            <div class="cb-header-info">
                <div class="cb-header-name" id="cb-header-title"><spring:message code="footer.chatbot.name"/></div>
                <div class="cb-header-status">
                    <span class="cb-dot"></span>
                    <span><spring:message code="footer.chatbot.status"/></span>
                </div>
            </div>
            <button class="cb-close" id="cb-close" aria-label="<spring:message code="footer.chatbot.close"/>">✕</button>
        </div>

        <div class="cb-body" id="cb-body"></div>

        <div class="cb-footer">
            <%-- 비로그인 유저용 초기화 버튼 (로그인 유저는 사이드바 하단에 있음) --%>
            <c:if test="${empty sessionScope.loginUser}">
                <button type="button" id="cb-reset" class="cb-new-btn cb-new-btn--reset cb-reset-inline"
                        title="<spring:message code="footer.chatbot.header.reset"/>" hidden>
                    ↻ <spring:message code="footer.chatbot.header.reset"/>
                </button>
            </c:if>
            <div class="cb-suggestions" id="cb-suggestions"></div>
            <div class="cb-input-row">
                <textarea id="cb-input" placeholder="<spring:message code="footer.chatbot.placeholder"/>" rows="1"></textarea>
                <button id="cb-send" aria-label="<spring:message code="footer.chatbot.send"/>">➤</button>
            </div>
        </div>
    </section>
</div>

<script>
    window.__chatbotConfig = {
        ctx: '${pageContext.request.contextPath}',
        loggedIn: ${not empty sessionScope.loginUser},
        msg: {
            suggestPopular:       '<spring:message code="footer.chatbot.suggest.popular" javaScriptEscape="true"/>',
            suggestPopularMsg:    '<spring:message code="footer.chatbot.suggest.popular.msg" javaScriptEscape="true"/>',
            suggestCourses:       '<spring:message code="footer.chatbot.suggest.courses" javaScriptEscape="true"/>',
            suggestCoursesMsg:    '<spring:message code="footer.chatbot.suggest.courses.msg" javaScriptEscape="true"/>',
            suggestAssistant:     '<spring:message code="footer.chatbot.suggest.assistant" javaScriptEscape="true"/>',
            suggestAssistantMsg:  '<spring:message code="footer.chatbot.suggest.assistant.msg" javaScriptEscape="true"/>',
            suggestCommunity:     '<spring:message code="footer.chatbot.suggest.community" javaScriptEscape="true"/>',
            suggestCommunityMsg:  '<spring:message code="footer.chatbot.suggest.community.msg" javaScriptEscape="true"/>',
            suggestAuth:          '<spring:message code="footer.chatbot.suggest.auth" javaScriptEscape="true"/>',
            suggestAuthMsg:       '<spring:message code="footer.chatbot.suggest.auth.msg" javaScriptEscape="true"/>',
            welcomeTitle:         '<spring:message code="footer.chatbot.welcome.title" javaScriptEscape="true"/>',
            welcomeBody1:         '<spring:message code="footer.chatbot.welcome.body1" javaScriptEscape="true"/>',
            welcomeBody2:         '<spring:message code="footer.chatbot.welcome.body2" javaScriptEscape="true"/>',
            error:                '<spring:message code="footer.chatbot.error" javaScriptEscape="true"/>',
            menuRename:           '<spring:message code="footer.chatbot.menu.rename" javaScriptEscape="true"/>',
            menuDelete:           '<spring:message code="footer.chatbot.menu.delete" javaScriptEscape="true"/>',
            confirmDelete:        '<spring:message code="footer.chatbot.confirm.delete" javaScriptEscape="true"/>',
            confirmReset:         '<spring:message code="footer.chatbot.confirm.reset" javaScriptEscape="true"/>',
            confirmYes:           '<spring:message code="footer.chatbot.confirm.yes" javaScriptEscape="true"/>',
            confirmNo:            '<spring:message code="footer.chatbot.confirm.no" javaScriptEscape="true"/>',
            editPlaceholder:      '<spring:message code="footer.chatbot.edit.placeholder" javaScriptEscape="true"/>',
            openNewTab:           '<spring:message code="footer.chatbot.link.newtab" javaScriptEscape="true"/>'
        }
    };
</script>
<script src="${pageContext.request.contextPath}/resources/js/common/chatbot.js" defer></script>
