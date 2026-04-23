<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="assistant/assistant.css" />
<%@ include file="../common/header.jsp" %>

<%-- ==========================================================================
     [다국어] JavaScript에서 사용할 메시지를 서버 사이드에서 미리 변수로 꺼내 둔다.

     spring:message 의 var 속성을 사용하면 pageScope 변수에 저장되므로
     ${변수명} 으로 바로 접근할 수 있다.
     ========================================================================== --%>

<%-- 에러 메시지 --%>
<spring:message code="assistant.error.parse" var="msgErrorParse" />
<spring:message code="assistant.error.server" var="msgErrorServer" />
<spring:message code="assistant.error.request" var="msgErrorRequest" />
<spring:message code="assistant.error.network" var="msgErrorNetwork" />
<spring:message code="assistant.error.noResponse" var="msgErrorNoResponse" />

<%-- 로딩 / 초기화 관련 메시지 --%>
<spring:message code="assistant.loading" var="msgLoading" />
<spring:message code="assistant.reset.confirm" var="msgResetConfirm" />
<spring:message code="assistant.reset.done" var="msgResetDone" />

<%-- 퀵버튼에서 GPT에 보내는 질문 텍스트 --%>
<spring:message code="assistant.quick.tokyo" var="msgQuickTokyo" />
<spring:message code="assistant.quick.budget" var="msgQuickBudget" />
<spring:message code="assistant.quick.backpacking" var="msgQuickBackpacking" />
<spring:message code="assistant.quick.jeju" var="msgQuickJeju" />
<spring:message code="assistant.quick.solo" var="msgQuickSolo" />
<spring:message code="assistant.quick.checklist" var="msgQuickChecklist" />

<%-- input placeholder 용 메시지 --%>
<spring:message code="assistant.input.placeholder" var="msgInputPlaceholder" />

<body>
<div class="chat-wrap">

    <%-- ===================== 사이드바 영역 ===================== --%>
    <aside class="chat-side">
        <div class="side-header">
            <div class="ai-avatar">✈️</div>
            <div class="ai-info">
                <div class="ai-name"><spring:message code="assistant.side.name" /></div>
                <div class="ai-status">
                    <span class="dot"></span>
                    <spring:message code="assistant.side.status" />
                </div>
            </div>
        </div>

        <div class="side-desc">
            <p><spring:message code="assistant.side.desc" /></p>
        </div>

        <div class="quick-title"><spring:message code="assistant.quick.title" /></div>
        <div class="quick-btns">
            <button class="qb" onclick="sendQuick('${msgQuickTokyo}')">
                <spring:message code="assistant.quick.tokyo.label" />
            </button>
            <button class="qb" onclick="sendQuick('${msgQuickBudget}')">
                <spring:message code="assistant.quick.budget.label" />
            </button>
            <button class="qb" onclick="sendQuick('${msgQuickBackpacking}')">
                <spring:message code="assistant.quick.backpacking.label" />
            </button>
            <button class="qb" onclick="sendQuick('${msgQuickJeju}')">
                <spring:message code="assistant.quick.jeju.label" />
            </button>
            <button class="qb" onclick="sendQuick('${msgQuickSolo}')">
                <spring:message code="assistant.quick.solo.label" />
            </button>
            <button class="qb" onclick="sendQuick('${msgQuickChecklist}')">
                <spring:message code="assistant.quick.checklist.label" />
            </button>
        </div>

        <button class="reset-btn" onclick="resetChat()">
            <spring:message code="assistant.reset.btn" />
        </button>
    </aside>

    <%-- ===================== 메인 채팅 영역 ===================== --%>
    <main class="chat-main">
        <div class="chat-header">
            <h2><spring:message code="assistant.header.title" /></h2>
            <span class="chat-sub"><spring:message code="assistant.header.subtitle" /></span>
        </div>

        <div class="chat-body" id="chatBody">
            <div class="msg-row ai">
                <div class="msg-avatar">✈️</div>
                <div class="msg-bubble">
                    <spring:message code="assistant.greeting.line1" /><br><br>
                    <spring:message code="assistant.greeting.line2" /><br>
                    <spring:message code="assistant.greeting.line3" /><br><br>
                    <spring:message code="assistant.greeting.line4" />
                </div>
            </div>
        </div>

        <div class="chat-input-wrap">
            <div class="chat-input-inner">
                <textarea
                    id="chatInput"
                    class="chat-input"
                    placeholder="${msgInputPlaceholder}"
                    rows="1"
                    onkeydown="handleKey(event)"
                    oninput="autoResize(this)"
                ></textarea>
                <button class="send-btn" id="sendBtn" onclick="sendMessage()">
                    <span id="sendIcon">➤</span>
                </button>
            </div>
            <div class="chat-hint"><spring:message code="assistant.hint" /></div>
        </div>
    </main>
</div>

<%@ include file="../common/footer.jsp" %>

<script>
    const CTX = '${pageContext.request.contextPath}';

    // --- 다국어 메시지 상수 ---
    const MSG_ERROR_PARSE = '${msgErrorParse}';
    const MSG_ERROR_SERVER = '${msgErrorServer}';
    const MSG_ERROR_REQUEST = '${msgErrorRequest}';
    const MSG_ERROR_NETWORK = '${msgErrorNetwork}';
    const MSG_ERROR_NO_RESPONSE = '${msgErrorNoResponse}';
    const MSG_LOADING = '${msgLoading}';
    const MSG_RESET_CONFIRM = '${msgResetConfirm}';
    const MSG_RESET_DONE = '${msgResetDone}';

    let isLoading = false;

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
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ message })
            });

            const rawText = await res.text();
            console.log('[assistant] status=', res.status);
            console.log('[assistant] raw response=', rawText);

            let data;
            try {
                data = JSON.parse(rawText);
            } catch (parseError) {
                removeLoadingBubble(loadingId);
                appendMessage('ai', MSG_ERROR_PARSE);
                return;
            }

            removeLoadingBubble(loadingId);

            if (!res.ok) {
                appendMessage('ai', data.answer || (MSG_ERROR_SERVER + ' (' + res.status + ')'));
                return;
            }

            if (!data.success) {
                appendMessage('ai', data.answer || MSG_ERROR_REQUEST);
                return;
            }

            appendMessage('ai', data.answer || MSG_ERROR_NO_RESPONSE);
        } catch (e) {
            console.error('[assistant] fetch error=', e);
            removeLoadingBubble(loadingId);
            appendMessage('ai', MSG_ERROR_NETWORK);
        } finally {
            setLoading(false);
        }
    }

    function sendQuick(text) {
        document.getElementById('chatInput').value = text;
        sendMessage();
    }

    async function resetChat() {
        if (!confirm(MSG_RESET_CONFIRM)) return;

        try {
            const res = await fetch(CTX + '/assistant/reset', { method: 'POST' });
            console.log('[assistant] reset status=', res.status);
        } catch (e) {
            console.error('[assistant] reset error=', e);
        }

        const body = document.getElementById('chatBody');
        body.innerHTML =
            '<div class="msg-row ai">' +
                '<div class="msg-avatar">✈️</div>' +
                '<div class="msg-bubble">' + escapeHtml(MSG_RESET_DONE) + '</div>' +
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
            row.innerHTML =
                '<div class="msg-bubble">' + escapeHtml(text) + '</div>';
        }

        body.appendChild(row);
        body.scrollTop = body.scrollHeight;
        return row;
    }

    function appendLoadingBubble() {
        return appendMessage('ai', MSG_LOADING);
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
        return escapeHtml(text)
            .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
            .replace(/\n/g, '<br>');
    }

    function escapeHtml(text) {
        return String(text)
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