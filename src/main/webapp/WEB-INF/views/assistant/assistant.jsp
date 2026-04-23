<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="assistant/assistant.css"/>
<%@ include file="../common/header.jsp" %>
<spring:message code="assistant.quick.tokyo.prompt" javaScriptEscape="true" var="assistantQuickTokyoPrompt"/>
<spring:message code="assistant.quick.europeBudget.prompt" javaScriptEscape="true" var="assistantQuickEuropeBudgetPrompt"/>
<spring:message code="assistant.quick.southeastAsia.prompt" javaScriptEscape="true" var="assistantQuickSoutheastAsiaPrompt"/>
<spring:message code="assistant.quick.jeju.prompt" javaScriptEscape="true" var="assistantQuickJejuPrompt"/>
<spring:message code="assistant.quick.solo.prompt" javaScriptEscape="true" var="assistantQuickSoloPrompt"/>
<spring:message code="assistant.quick.checklist.prompt" javaScriptEscape="true" var="assistantQuickChecklistPrompt"/>
<spring:message code="assistant.chat.placeholder" var="assistantChatPlaceholder"/>
<body>
<div class="chat-wrap">

    <aside class="chat-side">
        <div class="side-header">
            <div class="ai-avatar">✈️</div>
            <div class="ai-info">
                <div class="ai-name">Trip AI</div>
                <div class="ai-status"><span class="dot"></span> <spring:message code="assistant.status.online"/></div>
            </div>
        </div>

        <div class="side-desc">
            <p><spring:message code="assistant.side.description"/></p>
        </div>

        <div class="quick-title"><spring:message code="assistant.quick.title"/></div>
        <div class="quick-btns">
            <button class="qb" onclick="sendQuick('${assistantQuickTokyoPrompt}')">🗼 <spring:message code="assistant.quick.tokyo.label"/></button>
            <button class="qb" onclick="sendQuick('${assistantQuickEuropeBudgetPrompt}')">💶 <spring:message code="assistant.quick.europeBudget.label"/></button>
            <button class="qb" onclick="sendQuick('${assistantQuickSoutheastAsiaPrompt}')">🌴 <spring:message code="assistant.quick.southeastAsia.label"/></button>
            <button class="qb" onclick="sendQuick('${assistantQuickJejuPrompt}')">🍊 <spring:message code="assistant.quick.jeju.label"/></button>
            <button class="qb" onclick="sendQuick('${assistantQuickSoloPrompt}')">🧳 <spring:message code="assistant.quick.solo.label"/></button>
            <button class="qb" onclick="sendQuick('${assistantQuickChecklistPrompt}')">📋 <spring:message code="assistant.quick.checklist.label"/></button>
        </div>

        <button class="reset-btn" onclick="resetChat()">🗑️ <spring:message code="assistant.action.reset"/></button>
    </aside>

    <main class="chat-main">
        <div class="chat-header">
            <h2>✈️ <spring:message code="assistant.chat.title"/></h2>
            <span class="chat-sub"><spring:message code="assistant.chat.subtitle"/></span>
        </div>

        <div class="chat-body" id="chatBody">
            <div class="msg-row ai">
                <div class="msg-avatar">✈️</div>
                <div class="msg-bubble">
                    <spring:message code="assistant.chat.welcomeHtml"/>
                </div>
            </div>
        </div>

        <div class="chat-input-wrap">
            <div class="chat-input-inner">
                <textarea
                        id="chatInput"
                        class="chat-input"
                        placeholder="${assistantChatPlaceholder}"
                        rows="1"
                        onkeydown="handleKey(event)"
                        oninput="autoResize(this)"
                ></textarea>
                <button class="send-btn" id="sendBtn" onclick="sendMessage()">
                    <span id="sendIcon">➤</span>
                </button>
            </div>
            <div class="chat-hint"><spring:message code="assistant.chat.disclaimer"/></div>
        </div>
    </main>
</div>

<%@ include file="../common/footer.jsp" %>

<script>
    const CTX = '${pageContext.request.contextPath}';
    let isLoading = false;
    <spring:message code="assistant.error.parse" javaScriptEscape="true" var="assistantErrorParseJs"/>
    <spring:message code="assistant.error.request" javaScriptEscape="true" var="assistantErrorRequestJs"/>
    <spring:message code="assistant.error.network" javaScriptEscape="true" var="assistantErrorNetworkJs"/>
    <spring:message code="assistant.error.noResponse" javaScriptEscape="true" var="assistantErrorNoResponseJs"/>
    <spring:message code="assistant.error.server" javaScriptEscape="true" var="assistantErrorServerJs"/>
    <spring:message code="assistant.reset.confirm" javaScriptEscape="true" var="assistantResetConfirmJs"/>
    <spring:message code="assistant.reset.done" javaScriptEscape="true" var="assistantResetDoneJs"/>
    <spring:message code="assistant.loading.answering" javaScriptEscape="true" var="assistantLoadingAnsweringJs"/>
    const assistantMessages = {
        errorNetwork: '${assistantErrorNetworkJs}',
        errorNoResponse: '${assistantErrorNoResponseJs}',
        errorParse: '${assistantErrorParseJs}',
        errorRequest: '${assistantErrorRequestJs}',
        errorServer: '${assistantErrorServerJs}',
        loadingAnswering: '${assistantLoadingAnsweringJs}',
        resetConfirm: '${assistantResetConfirmJs}',
        resetDone: '${assistantResetDoneJs}'
    };

    async function sendMessage() {
        if (isLoading) return;

        const input = document.getElementById('chatInput');
        const message = input.value.trim();
        if (!message) return;

        input.value = '';
        autoResize(input);
        appendMessage('user', message);
        setLoading(true);
        const loadingId = appendLoadingBubble();

        try {
            const res = await fetch(CTX + '/assistant/chat', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({message})
            });

            const rawText = await res.text();
            console.log('[assistant] status=', res.status);
            console.log('[assistant] raw response=', rawText);

            let data;
            try {
                data = JSON.parse(rawText);
            } catch (parseError) {
                removeLoadingBubble(loadingId);
                appendMessage('ai', assistantMessages.errorParse);
                return;
            }

            removeLoadingBubble(loadingId);

            if (!res.ok) {
                appendMessage('ai', data.answer || (assistantMessages.errorServer + ' status=' + res.status));
                return;
            }

            if (!data.success) {
                appendMessage('ai', data.answer || assistantMessages.errorRequest);
                return;
            }

            appendMessage('ai', data.answer || assistantMessages.errorNoResponse);
        } catch (e) {
            console.error('[assistant] fetch error=', e);
            removeLoadingBubble(loadingId);
            appendMessage('ai', assistantMessages.errorNetwork);
        } finally {
            setLoading(false);
        }
    }

    function sendQuick(text) {
        document.getElementById('chatInput').value = text;
        sendMessage();
    }

    async function resetChat() {
        if (!confirm(assistantMessages.resetConfirm)) return;

        try {
            const res = await fetch(CTX + '/assistant/reset', {method: 'POST'});
            console.log('[assistant] reset status=', res.status);
        } catch (e) {
            console.error('[assistant] reset error=', e);
        }

        const body = document.getElementById('chatBody');
        body.innerHTML =
            '<div class="msg-row ai">' +
            '<div class="msg-avatar">✈️</div>' +
            '<div class="msg-bubble">' + escapeHtml(assistantMessages.resetDone) + '</div>' +
            '</div>';
    }

    function appendMessage(role, text) {
        const body = document.getElementById('chatBody');
        const row = document.createElement('div');
        row.className = 'msg-row ' + role;

        if (role === 'ai') {
            row.innerHTML =
                '<div class="msg-avatar">✈️</div>' +
                '<div class="msg-bubble">' + formatText(text) + '</div>';
        } else {
            row.innerHTML = '<div class="msg-bubble">' + escapeHtml(text) + '</div>';
        }

        body.appendChild(row);
        body.scrollTop = body.scrollHeight;
        return row;
    }

    function appendLoadingBubble() {
        return appendMessage('ai', assistantMessages.loadingAnswering);
    }

    function removeLoadingBubble(node) {
        if (node && node.parentNode) {
            node.parentNode.removeChild(node);
        }
    }

    function setLoading(flag) {
        isLoading = flag;

        const btn = document.getElementById('sendBtn');
        const icon = document.getElementById('sendIcon');
        const input = document.getElementById('chatInput');

        btn.disabled = flag;
        input.disabled = flag;
        icon.textContent = flag ? '...' : '➤';

        if (!flag) input.focus();
    }

    function formatText(text) {
        return text
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
            .replace(/\n/g, '<br>');
    }

    function escapeHtml(text) {
        return text
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;');
    }

    function handleKey(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    }

    function autoResize(el) {
        el.style.height = 'auto';
        el.style.height = Math.min(el.scrollHeight, 120) + 'px';
    }
</script>
</body>
</html>
