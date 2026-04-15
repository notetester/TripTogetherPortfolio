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
    <div class="cb-header">
        <div class="cb-avatar">✈️</div>
        <div class="cb-header-info">
            <div class="cb-header-name"><spring:message code="footer.chatbot.name"/></div>
            <div class="cb-header-status">
                <span class="cb-dot"></span>
                <span><spring:message code="footer.chatbot.status"/></span>
            </div>
        </div>
        <button class="cb-close" id="cb-close" aria-label="<spring:message code="footer.chatbot.close"/>">✕</button>
    </div>

    <div class="cb-body" id="cb-body"></div>

    <div class="cb-footer">
        <div class="cb-suggestions" id="cb-suggestions"></div>
        <div class="cb-input-row">
            <textarea id="cb-input" placeholder="<spring:message code="footer.chatbot.placeholder"/>" rows="1"></textarea>
            <button id="cb-send" aria-label="<spring:message code="footer.chatbot.send"/>">➤</button>
        </div>
    </div>
</div>

<script>
    (function () {
        const ctx = '${pageContext.request.contextPath}';
        const loggedIn = ${not empty sessionScope.loginUser};
        const msg = {
            suggestPopular: '<spring:message code="footer.chatbot.suggest.popular" javaScriptEscape="true"/>',
            suggestPopularMsg: '<spring:message code="footer.chatbot.suggest.popular.msg" javaScriptEscape="true"/>',
            suggestCourses: '<spring:message code="footer.chatbot.suggest.courses" javaScriptEscape="true"/>',
            suggestCoursesMsg: '<spring:message code="footer.chatbot.suggest.courses.msg" javaScriptEscape="true"/>',
            suggestAssistant: '<spring:message code="footer.chatbot.suggest.assistant" javaScriptEscape="true"/>',
            suggestAssistantMsg: '<spring:message code="footer.chatbot.suggest.assistant.msg" javaScriptEscape="true"/>',
            suggestCommunity: '<spring:message code="footer.chatbot.suggest.community" javaScriptEscape="true"/>',
            suggestCommunityMsg: '<spring:message code="footer.chatbot.suggest.community.msg" javaScriptEscape="true"/>',
            suggestAuth: '<spring:message code="footer.chatbot.suggest.auth" javaScriptEscape="true"/>',
            suggestAuthMsg: '<spring:message code="footer.chatbot.suggest.auth.msg" javaScriptEscape="true"/>',
            welcomeTitle: '<spring:message code="footer.chatbot.welcome.title" javaScriptEscape="true"/>',
            welcomeBody1: '<spring:message code="footer.chatbot.welcome.body1" javaScriptEscape="true"/>',
            welcomeBody2: '<spring:message code="footer.chatbot.welcome.body2" javaScriptEscape="true"/>',
            error: '<spring:message code="footer.chatbot.error" javaScriptEscape="true"/>'
        };
        // JSP EL 이 boolean 리터럴(true/false)로 출력되므로 JS에서 그대로 사용 가능하다.

        let isOpen = false;
        let isTyping = false;
        let history = [];

        const INITIAL_SUGGESTIONS = [
            { label: msg.suggestPopular, msg: msg.suggestPopularMsg },
            { label: msg.suggestCourses, msg: msg.suggestCoursesMsg },
            { label: msg.suggestAssistant, msg: msg.suggestAssistantMsg },
            { label: msg.suggestCommunity, msg: msg.suggestCommunityMsg },
            ...(!loggedIn ? [{ label: msg.suggestAuth, msg: msg.suggestAuthMsg }] : []),
        ];

        const toggle = document.getElementById('chatbot-toggle');
        const box = document.getElementById('chatbot-box');
        const body = document.getElementById('cb-body');
        const input = document.getElementById('cb-input');
        const sendBtn = document.getElementById('cb-send');
        const badge = document.getElementById('chatbot-badge');
        const suggs = document.getElementById('cb-suggestions');

        function openChat() {
            isOpen = true;
            box.classList.add('open');
            toggle.classList.add('open');
            document.getElementById('cb-toggle-icon').textContent = '✕';
            badge.classList.remove('show');
            if (body.children.length === 0) renderWelcome();
            setTimeout(() => { input.focus(); scrollBottom(); }, 50);
        }

        function closeChat() {
            isOpen = false;
            box.classList.remove('open');
            toggle.classList.remove('open');
            document.getElementById('cb-toggle-icon').textContent = '✈️';
        }

        toggle.addEventListener('click', () => isOpen ? closeChat() : openChat());
        document.getElementById('cb-close').addEventListener('click', closeChat);

        function renderWelcome() {
            const wrap = document.createElement('div');
            wrap.className = 'cb-msg-wrap bot';
            wrap.innerHTML = '<div class="cb-welcome">' +
                '<div class="cb-welcome-title">' + escHtml(msg.welcomeTitle) + '</div>' +
                escHtml(msg.welcomeBody1) + '<br>' +
                escHtml(msg.welcomeBody2) +
                '</div>';
            body.appendChild(wrap);
            renderSuggestions(INITIAL_SUGGESTIONS.map(s => s.label));
        }

        function renderSuggestions(chips) {
            suggs.innerHTML = '';
            chips.forEach(label => {
                const chip = document.createElement('button');
                chip.className = 'cb-suggest-chip';
                chip.textContent = label;
                chip.addEventListener('click', () => {
                    const found = INITIAL_SUGGESTIONS.find(s => s.label === label);
                    input.value = found ? found.msg : label;
                    suggs.innerHTML = '';
                    sendMessage();
                });
                suggs.appendChild(chip);
            });
        }

        function appendUserMsg(text) {
            const wrap = document.createElement('div');
            wrap.className = 'cb-msg-wrap user';
            wrap.innerHTML = '<div class="cb-msg user">' + escHtml(text) + '</div>' +
                '<div class="cb-time">' + getTime() + '</div>';
            body.appendChild(wrap);
            scrollBottom();
        }

        function showTyping() {
            const el = document.createElement('div');
            el.id = 'cb-typing';
            el.className = 'cb-msg-wrap bot';
            el.innerHTML = '<div class="cb-typing"><span></span><span></span><span></span></div>';
            body.appendChild(el);
            scrollBottom();
        }

        function hideTyping() {
            const el = document.getElementById('cb-typing');
            if (el) el.remove();
        }

        function appendBotResponse(data) {
            const wrap = document.createElement('div');
            wrap.className = 'cb-msg-wrap bot';

            if (data.message) {
                const msgEl = document.createElement('div');
                msgEl.className = 'cb-msg bot';
                msgEl.innerHTML = formatBotText(data.message);
                wrap.appendChild(msgEl);
            }

            body.appendChild(wrap);

            if (data.links && data.links.length > 0) {
                const linksWrap = document.createElement('div');
                linksWrap.className = 'cb-links';
                data.links.forEach(link => {
                    const a = document.createElement('a');
                    a.className = 'cb-link-btn';
                    a.href = ctx + link.url;
                    a.innerHTML = '<span class="cb-link-icon">' + (link.icon || '→') + '</span>' + escHtml(link.label);
                    linksWrap.appendChild(a);
                });
                body.appendChild(linksWrap);
            }

            const timeEl = document.createElement('div');
            timeEl.className = 'cb-time';
            timeEl.style.alignSelf = 'flex-start';
            timeEl.textContent = getTime();
            body.appendChild(timeEl);

            suggs.innerHTML = '';
            scrollBottom();
        }

        async function sendMessage() {
            const text = input.value.trim();
            if (!text || isTyping) return;

            input.value = '';
            suggs.innerHTML = '';

            appendUserMsg(text);

            history.push({ role: 'user', content: text });
            if (history.length > 12) history = history.slice(history.length - 12);

            isTyping = true;
            sendBtn.disabled = true;
            showTyping();

            try {
                const res = await fetch(ctx + '/chatbot/ask', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        message: text,
                        history: history.slice(0, -1),
                        currentPath: window.location.pathname.replace(ctx, ''),
                        loggedIn: loggedIn
                    })
                });

                const data = await res.json();
                hideTyping();
                appendBotResponse(data);

                history.push({ role: 'assistant', content: JSON.stringify(data) });

            } catch (e) {
                hideTyping();
                appendBotResponse({ message: msg.error, links: [], quickReplies: [] });
            } finally {
                isTyping = false;
                sendBtn.disabled = false;
            }
        }

        sendBtn.addEventListener('click', sendMessage);
        input.addEventListener('keydown', function (e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        });

        function scrollBottom() {
            requestAnimationFrame(() => { body.scrollTop = body.scrollHeight; });
        }

        function getTime() {
            return new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
        }

        function escHtml(str) {
            return str
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;');
        }

    })();
</script>
