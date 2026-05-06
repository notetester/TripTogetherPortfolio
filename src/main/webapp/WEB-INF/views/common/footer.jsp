<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_footer_chatbot_open" code="footer.chatbot.open"/>
<spring:message var="msg_footer_chatbot_title" code="footer.chatbot.title"/>
<spring:message var="msg_footer_chatbot_dialog" code="footer.chatbot.dialog"/>
<spring:message var="msg_footer_chatbot_header_reset" code="footer.chatbot.header.reset"/>
<spring:message var="msg_footer_chatbot_close" code="footer.chatbot.close"/>
<spring:message var="msg_footer_chatbot_placeholder" code="footer.chatbot.placeholder"/>
<spring:message var="msg_footer_chatbot_send" code="footer.chatbot.send"/>
<spring:message var="msg_footer_chatbot_suggest_popular_js" code="footer.chatbot.suggest.popular" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_suggest_popular_msg_js" code="footer.chatbot.suggest.popular.msg" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_suggest_courses_js" code="footer.chatbot.suggest.courses" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_suggest_courses_msg_js" code="footer.chatbot.suggest.courses.msg" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_suggest_assistant_js" code="footer.chatbot.suggest.assistant" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_suggest_assistant_msg_js" code="footer.chatbot.suggest.assistant.msg" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_suggest_community_js" code="footer.chatbot.suggest.community" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_suggest_community_msg_js" code="footer.chatbot.suggest.community.msg" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_suggest_auth_js" code="footer.chatbot.suggest.auth" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_suggest_auth_msg_js" code="footer.chatbot.suggest.auth.msg" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_welcome_title_js" code="footer.chatbot.welcome.title" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_welcome_body1_js" code="footer.chatbot.welcome.body1" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_welcome_body2_js" code="footer.chatbot.welcome.body2" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_error_js" code="footer.chatbot.error" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_menu_rename_js" code="footer.chatbot.menu.rename" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_menu_delete_js" code="footer.chatbot.menu.delete" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_confirm_delete_js" code="footer.chatbot.confirm.delete" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_confirm_reset_js" code="footer.chatbot.confirm.reset" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_confirm_yes_js" code="footer.chatbot.confirm.yes" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_confirm_no_js" code="footer.chatbot.confirm.no" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_edit_placeholder_js" code="footer.chatbot.edit.placeholder" javaScriptEscape="true"/>
<spring:message var="msg_footer_chatbot_link_newtab_js" code="footer.chatbot.link.newtab" javaScriptEscape="true"/>
<spring:message var="msg_footer_copy" code="footer.copy"/>
<spring:message var="msg_footer_inquiry" code="footer.inquiry"/>
<spring:message var="msg_footer_chatbot_newConversation" code="footer.chatbot.newConversation"/>
<spring:message var="msg_footer_chatbot_name" code="footer.chatbot.name"/>
<spring:message var="msg_footer_chatbot_status" code="footer.chatbot.status"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/chatbot.css">

<footer class="site-footer">
    <div class="si">
        <div class="footer-inner">
            <div class="footer-logo">
                <div class="logo-icon" style="width:32px;height:32px;font-size:16px;">🌐</div>
                <span class="logo-text" style="font-size:18px;">TripTogether</span>
            </div>
            <p class="footer-copy">${msg_footer_copy}
                &nbsp;·&nbsp;
                <a href="${pageContext.request.contextPath}/inquiry/list" class="footer-inquiry-link">${msg_footer_inquiry}</a>
            </p>
        </div>
    </div>
</footer>

<button id="chatbot-toggle" aria-label="${msg_footer_chatbot_open}" title="${msg_footer_chatbot_title}">
    <span id="cb-toggle-icon">✈️</span>
    <span id="chatbot-badge"></span>
</button>

<div id="chatbot-box" role="dialog" aria-label="${msg_footer_chatbot_dialog}">

    <%-- 로그인 유저 전용 사이드바 (대화 목록) --%>
    <c:if test="${not empty sessionScope.loginUser}">
        <aside id="cb-sidebar" class="cb-sidebar">
            <button type="button" id="cb-new" class="cb-new-btn">${msg_footer_chatbot_newConversation}</button>
            <div id="cb-conv-list" class="cb-conv-list"></div>
            <button type="button" id="cb-reset" class="cb-new-btn cb-new-btn--reset"
                    title="${msg_footer_chatbot_header_reset}" hidden>
                ${msg_footer_chatbot_header_reset}
            </button>
        </aside>
    </c:if>

    <%-- 메인 영역 --%>
    <section class="cb-main">
        <div class="cb-header">
            <div class="cb-avatar">✈️</div>
            <div class="cb-header-info">
                <div class="cb-header-name" id="cb-header-title">${msg_footer_chatbot_name}</div>
                <div class="cb-header-status">
                    <span class="cb-dot"></span>
                    <span>${msg_footer_chatbot_status}</span>
                </div>
            </div>
            <button class="cb-close" id="cb-close" aria-label="${msg_footer_chatbot_close}">✕</button>
        </div>

        <div class="cb-body" id="cb-body"></div>

        <div class="cb-footer">
            <%-- 비로그인 유저용 초기화 버튼 (로그인 유저는 사이드바 하단에 있음) --%>
            <c:if test="${empty sessionScope.loginUser}">
                <button type="button" id="cb-reset" class="cb-new-btn cb-new-btn--reset cb-reset-inline"
                        title="${msg_footer_chatbot_header_reset}" hidden>
                    ↻ ${msg_footer_chatbot_header_reset}
                </button>
            </c:if>
            <div class="cb-suggestions" id="cb-suggestions"></div>
            <div class="cb-input-row">
                <textarea id="cb-input" placeholder="${msg_footer_chatbot_placeholder}" rows="1"></textarea>
                <button id="cb-send" aria-label="${msg_footer_chatbot_send}">➤</button>
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
            suggestPopular:       '${msg_footer_chatbot_suggest_popular_js}',
            suggestPopularMsg:    '${msg_footer_chatbot_suggest_popular_msg_js}',
            suggestCourses:       '${msg_footer_chatbot_suggest_courses_js}',
            suggestCoursesMsg:    '${msg_footer_chatbot_suggest_courses_msg_js}',
            suggestAssistant:     '${msg_footer_chatbot_suggest_assistant_js}',
            suggestAssistantMsg:  '${msg_footer_chatbot_suggest_assistant_msg_js}',
            suggestCommunity:     '${msg_footer_chatbot_suggest_community_js}',
            suggestCommunityMsg:  '${msg_footer_chatbot_suggest_community_msg_js}',
            suggestAuth:          '${msg_footer_chatbot_suggest_auth_js}',
            suggestAuthMsg:       '${msg_footer_chatbot_suggest_auth_msg_js}',
            welcomeTitle:         '${msg_footer_chatbot_welcome_title_js}',
            welcomeBody1:         '${msg_footer_chatbot_welcome_body1_js}',
            welcomeBody2:         '${msg_footer_chatbot_welcome_body2_js}',
            error:                '${msg_footer_chatbot_error_js}',
            menuRename:           '${msg_footer_chatbot_menu_rename_js}',
            menuDelete:           '${msg_footer_chatbot_menu_delete_js}',
            confirmDelete:        '${msg_footer_chatbot_confirm_delete_js}',
            confirmReset:         '${msg_footer_chatbot_confirm_reset_js}',
            confirmYes:           '${msg_footer_chatbot_confirm_yes_js}',
            confirmNo:            '${msg_footer_chatbot_confirm_no_js}',
            editPlaceholder:      '${msg_footer_chatbot_edit_placeholder_js}',
            openNewTab:           '${msg_footer_chatbot_link_newtab_js}'
        }
    };
</script>
<script src="${pageContext.request.contextPath}/resources/js/common/chatbot.js" defer></script>
