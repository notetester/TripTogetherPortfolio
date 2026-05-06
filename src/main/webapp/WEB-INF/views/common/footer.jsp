<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message var="footerChatbotOpenMsg" code="footer.chatbot.open"/>
<spring:message var="footerChatbotTitleMsg" code="footer.chatbot.title"/>
<spring:message var="footerChatbotDialogMsg" code="footer.chatbot.dialog"/>
<spring:message var="footerChatbotHeaderResetMsg" code="footer.chatbot.header.reset"/>
<spring:message var="footerChatbotCloseMsg" code="footer.chatbot.close"/>
<spring:message var="footerChatbotPlaceholderMsg" code="footer.chatbot.placeholder"/>
<spring:message var="footerChatbotSendMsg" code="footer.chatbot.send"/>
<spring:message var="footerChatbotSuggestPopularMsg" code="footer.chatbot.suggest.popular" javaScriptEscape="true"/>
<spring:message var="footerChatbotSuggestPopularMsgMsg" code="footer.chatbot.suggest.popular.msg" javaScriptEscape="true"/>
<spring:message var="footerChatbotSuggestCoursesMsg" code="footer.chatbot.suggest.courses" javaScriptEscape="true"/>
<spring:message var="footerChatbotSuggestCoursesMsgMsg" code="footer.chatbot.suggest.courses.msg" javaScriptEscape="true"/>
<spring:message var="footerChatbotSuggestAssistantMsg" code="footer.chatbot.suggest.assistant" javaScriptEscape="true"/>
<spring:message var="footerChatbotSuggestAssistantMsgMsg" code="footer.chatbot.suggest.assistant.msg" javaScriptEscape="true"/>
<spring:message var="footerChatbotSuggestCommunityMsg" code="footer.chatbot.suggest.community" javaScriptEscape="true"/>
<spring:message var="footerChatbotSuggestCommunityMsgMsg" code="footer.chatbot.suggest.community.msg" javaScriptEscape="true"/>
<spring:message var="footerChatbotSuggestAuthMsg" code="footer.chatbot.suggest.auth" javaScriptEscape="true"/>
<spring:message var="footerChatbotSuggestAuthMsgMsg" code="footer.chatbot.suggest.auth.msg" javaScriptEscape="true"/>
<spring:message var="footerChatbotWelcomeTitleMsg" code="footer.chatbot.welcome.title" javaScriptEscape="true"/>
<spring:message var="footerChatbotWelcomeBody1Msg" code="footer.chatbot.welcome.body1" javaScriptEscape="true"/>
<spring:message var="footerChatbotWelcomeBody2Msg" code="footer.chatbot.welcome.body2" javaScriptEscape="true"/>
<spring:message var="footerChatbotErrorMsg" code="footer.chatbot.error" javaScriptEscape="true"/>
<spring:message var="footerChatbotMenuRenameMsg" code="footer.chatbot.menu.rename" javaScriptEscape="true"/>
<spring:message var="footerChatbotMenuDeleteMsg" code="footer.chatbot.menu.delete" javaScriptEscape="true"/>
<spring:message var="footerChatbotConfirmDeleteMsg" code="footer.chatbot.confirm.delete" javaScriptEscape="true"/>
<spring:message var="footerChatbotConfirmResetMsg" code="footer.chatbot.confirm.reset" javaScriptEscape="true"/>
<spring:message var="footerChatbotConfirmYesMsg" code="footer.chatbot.confirm.yes" javaScriptEscape="true"/>
<spring:message var="footerChatbotConfirmNoMsg" code="footer.chatbot.confirm.no" javaScriptEscape="true"/>
<spring:message var="footerChatbotEditPlaceholderMsg" code="footer.chatbot.edit.placeholder" javaScriptEscape="true"/>
<spring:message var="footerChatbotLinkNewtabMsg" code="footer.chatbot.link.newtab" javaScriptEscape="true"/>
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

<button id="chatbot-toggle" aria-label="${footerChatbotOpenMsg}" title="${footerChatbotTitleMsg}">
    <span id="cb-toggle-icon">✈️</span>
    <span id="chatbot-badge"></span>
</button>

<div id="chatbot-box" role="dialog" aria-label="${footerChatbotDialogMsg}">

    <%-- 로그인 유저 전용 사이드바 (대화 목록) --%>
    <c:if test="${not empty sessionScope.loginUser}">
        <aside id="cb-sidebar" class="cb-sidebar">
            <button type="button" id="cb-new" class="cb-new-btn"><spring:message code="footer.chatbot.newConversation"/></button>
            <div id="cb-conv-list" class="cb-conv-list"></div>
            <button type="button" id="cb-reset" class="cb-new-btn cb-new-btn--reset"
                    title="${footerChatbotHeaderResetMsg}" hidden>
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
            <button class="cb-close" id="cb-close" aria-label="${footerChatbotCloseMsg}">✕</button>
        </div>

        <div class="cb-body" id="cb-body"></div>

        <div class="cb-footer">
            <%-- 비로그인 유저용 초기화 버튼 (로그인 유저는 사이드바 하단에 있음) --%>
            <c:if test="${empty sessionScope.loginUser}">
                <button type="button" id="cb-reset" class="cb-new-btn cb-new-btn--reset cb-reset-inline"
                        title="${footerChatbotHeaderResetMsg}" hidden>
                    ↻ ${footerChatbotHeaderResetMsg}
                </button>
            </c:if>
            <div class="cb-suggestions" id="cb-suggestions"></div>
            <div class="cb-input-row">
                <textarea id="cb-input" placeholder="${footerChatbotPlaceholderMsg}" rows="1"></textarea>
                <button id="cb-send" aria-label="${footerChatbotSendMsg}">➤</button>
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
            suggestPopular:       '${footerChatbotSuggestPopularMsg}',
            suggestPopularMsg:    '${footerChatbotSuggestPopularMsgMsg}',
            suggestCourses:       '${footerChatbotSuggestCoursesMsg}',
            suggestCoursesMsg:    '${footerChatbotSuggestCoursesMsgMsg}',
            suggestAssistant:     '${footerChatbotSuggestAssistantMsg}',
            suggestAssistantMsg:  '${footerChatbotSuggestAssistantMsgMsg}',
            suggestCommunity:     '${footerChatbotSuggestCommunityMsg}',
            suggestCommunityMsg:  '${footerChatbotSuggestCommunityMsgMsg}',
            suggestAuth:          '${footerChatbotSuggestAuthMsg}',
            suggestAuthMsg:       '${footerChatbotSuggestAuthMsgMsg}',
            welcomeTitle:         '${footerChatbotWelcomeTitleMsg}',
            welcomeBody1:         '${footerChatbotWelcomeBody1Msg}',
            welcomeBody2:         '${footerChatbotWelcomeBody2Msg}',
            error:                '${footerChatbotErrorMsg}',
            menuRename:           '${footerChatbotMenuRenameMsg}',
            menuDelete:           '${footerChatbotMenuDeleteMsg}',
            confirmDelete:        '${footerChatbotConfirmDeleteMsg}',
            confirmReset:         '${footerChatbotConfirmResetMsg}',
            confirmYes:           '${footerChatbotConfirmYesMsg}',
            confirmNo:            '${footerChatbotConfirmNoMsg}',
            editPlaceholder:      '${footerChatbotEditPlaceholderMsg}',
            openNewTab:           '${footerChatbotLinkNewtabMsg}'
        }
    };
</script>
<script src="${pageContext.request.contextPath}/resources/js/common/chatbot.js" defer></script>
