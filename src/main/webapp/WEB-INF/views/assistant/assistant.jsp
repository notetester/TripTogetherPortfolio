<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="assistant/assistant.css" />
<%@ include file="../common/header.jsp" %>

<style>
    .history-section {
        margin-top: 22px;
        padding-top: 16px;
        border-top: 1px solid #e5e7eb;
    }

    .history-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 12px;
    }

    .history-title {
        font-size: 13px;
        font-weight: 700;
        color: #374151;
    }

    .new-chat-btn {
        border: none;
        background: transparent;
        color: #4f46e5;
        font-size: 12px;
        cursor: pointer;
    }

    .history-list {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .history-item {
        display: flex;
        align-items: center;
        gap: 6px;
        padding: 10px;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        background: #fff;
    }

    .history-load-btn {
        flex: 1;
        border: none;
        background: transparent;
        text-align: left;
        font-size: 13px;
        color: #374151;
        cursor: pointer;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }

    .history-edit-btn,
    .history-delete-btn {
        border: none;
        background: #f3f4f6;
        color: #6b7280;
        font-size: 11px;
        padding: 4px 6px;
        border-radius: 6px;
        cursor: pointer;
    }

    .history-edit-btn {
        color: #6b7280;
    }

    .history-delete-btn {
        color: #ef4444;
    }

    .history-empty,
    .history-login-guide {
        font-size: 12px;
        color: #9ca3af;
        line-height: 1.5;
    }

    .history-item.active {
        border-color: #6366f1;
        background: #eef2ff;
    }

    .history-item.active .history-load-btn {
        color: #4f46e5;
        font-weight: 700;
    }

    .history-item.editing {
        padding: 8px;
        border-color: #6366f1;
        background: #fff;
    }

    .history-title-input {
        width: 100%;
        border: none;
        outline: none;
        font-size: 14px;
        color: #374151;
        background: transparent;
    }
</style>

<%-- ==========================================================================
     [????곗뵯??? JavaScript???????????꿔꺂????????????嶺뚮Ĳ?됭짆??????嶺?獄?????붺몭?겹럷????⑤슢堉??????????Β?ル빝?????됰Ŧ???
     ========================================================================== --%>

<%-- ??????꿔꺂???????? --%>
<spring:message code="assistant.error.parse" var="msgErrorParse" />
<spring:message code="assistant.error.server" var="msgErrorServer" />
<spring:message code="assistant.error.request" var="msgErrorRequest" />
<spring:message code="assistant.error.network" var="msgErrorNetwork" />
<spring:message code="assistant.error.noResponse" var="msgErrorNoResponse" />

<%-- ?汝??吏??뮤?/ ?潁??용끏??????援온???꿔꺂???????? --%>
<spring:message code="assistant.loading" var="msgLoading" />
<spring:message code="assistant.reset.confirm" var="msgResetConfirm" />
<spring:message code="assistant.reset.done" var="msgResetDone" />

<%-- ??????濚밸Ŧ援잒キ????⑤슢??????꿔꺂???熬곻퐢利?????紐꾨쫯??--%>
<spring:message code="assistant.quick.tokyo" var="msgQuickTokyo" />
<spring:message code="assistant.quick.budget" var="msgQuickBudget" />
<spring:message code="assistant.quick.backpacking" var="msgQuickBackpacking" />
<spring:message code="assistant.quick.jeju" var="msgQuickJeju" />
<spring:message code="assistant.quick.solo" var="msgQuickSolo" />
<spring:message code="assistant.quick.checklist" var="msgQuickChecklist" />

<%-- input placeholder ???꿔꺂???????? --%>
<spring:message code="assistant.input.placeholder" var="msgInputPlaceholder" />

<body>
<div class="chat-wrap">

    <%-- ===================== ?????嶺뚮Ĳ???????쇨덧??===================== --%>
    <aside class="chat-side">
        <div class="side-header">
            <div class="ai-avatar">&#129302;</div>
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

        <div class="history-section">
            <div class="history-header">
                <span class="history-title">이전 대화</span>
            </div>

            <c:choose>
                <c:when test="${isLogin}">
                    <c:choose>
                        <c:when test="${not empty chatPostList}">
                            <div class="history-list">
                                <c:forEach var="chatPost" items="${chatPostList}">
                                    <div class="history-item" id="history-${chatPost.chat_post_idx}">
                                        <button type="button"
                                                class="history-load-btn"
                                                onclick="loadHistory('${chatPost.chat_post_idx}', this)">
                                            <c:out value="${chatPost.title}" />
                                        </button>
                                        <button type="button"
                                                class="history-edit-btn"
                                                onclick="editHistoryTitle('${chatPost.chat_post_idx}', this)">
                                            수정
                                        </button>
                                        <button type="button"
                                                class="history-delete-btn"
                                                onclick="deleteHistory('${chatPost.chat_post_idx}')">
                                            삭제
                                        </button>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="history-empty">저장된 대화가 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <p class="history-login-guide">로그인하면 이전 대화를 저장하고 다시 불러올 수 있습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <button class="reset-btn" onclick="startNewChat()"><spring:message code="assistant.reset.btn" /></button>
    </aside>

    <%-- ===================== ?꿔꺂??????????????쇨덧??===================== --%>
    <main class="chat-main">
        <div class="chat-header">
            <h2><spring:message code="assistant.header.title" /></h2>
            <span class="chat-sub"><spring:message code="assistant.header.subtitle" /></span>
        </div>

        <div class="chat-body" id="chatBody">
            <div class="msg-row ai">
                <div class="msg-avatar">&#129302;</div>
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
                    <span id="sendIcon">&#10148;</span>
                </button>
            </div>
            <div class="chat-hint"><spring:message code="assistant.hint" /></div>
        </div>
    </main>
</div>

<script>
    const CTX = '${pageContext.request.contextPath}';

    // --- ????곗뵯????꿔꺂???????? ????쇨덧??---
    const MSG_ERROR_PARSE = '${msgErrorParse}';
    const MSG_ERROR_SERVER = '${msgErrorServer}';
    const MSG_ERROR_REQUEST = '${msgErrorRequest}';
    const MSG_ERROR_NETWORK = '${msgErrorNetwork}';
    const MSG_ERROR_NO_RESPONSE = '${msgErrorNoResponse}';
    const MSG_LOADING = '${msgLoading}';
    const MSG_RESET_CONFIRM = '${msgResetConfirm}';
    const MSG_RESET_DONE = '${msgResetDone}';

    let isLoading = false;
    let currentChatPostIdx = null;

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
                body: JSON.stringify({
                    message: message,
                    chatPostIdx: currentChatPostIdx
                })
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

            if (data.chatPostIdx) {
                currentChatPostIdx = data.chatPostIdx;
            }

            appendMessage('ai', data.answer || MSG_ERROR_NO_RESPONSE);

        } catch (e) {
            console.error(e);
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

    async function loadHistory(chatPostIdx, button) {
        if (!chatPostIdx) {
            alert("대화 번호를 찾을 수 없습니다.");
            return;
        }

        try {
            const res = await fetch(CTX + '/assistant/history/' + chatPostIdx);
            const data = await res.json();

            if (!data.success) {
                alert(data.message || "대화 기록을 불러오지 못했습니다.");
                return;
            }

            currentChatPostIdx = data.chatPostIdx;

            document.querySelectorAll('.history-item').forEach(item => {
                item.classList.remove('active');
            });

            const item = button.closest('.history-item');
            if (item) item.classList.add('active');

            const body = document.getElementById('chatBody');
            body.innerHTML = '';

            data.history.forEach(msg => {
                appendMessage(msg.role === 'assistant' ? 'ai' : 'user', msg.content);
            });
        } catch (e) {
            console.error(e);
            alert("대화 기록을 불러오는 중 오류가 발생했습니다.");
        }
    }

    function editHistoryTitle(chatPostIdx, button) {
        const item = button.closest('.history-item');
        const titleBtn = item.querySelector('.history-load-btn');
        const oldTitle = titleBtn.textContent.trim();

        item.classList.add('editing');
        item.innerHTML = '';

        const input = document.createElement('input');
        input.type = 'text';
        input.className = 'history-title-input';
        input.value = oldTitle;

        item.appendChild(input);
        input.focus();
        input.select();

        let saved = false;

        async function saveTitle() {
            if (saved) return;
            saved = true;

            const newTitle = input.value.trim();
            if (!newTitle || newTitle === oldTitle) {
                location.reload();
                return;
            }

            try {
                const res = await fetch(CTX + '/assistant/history/' + chatPostIdx + '/title', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({title: newTitle})
                });

                const data = await res.json();
                if (data.success) {
                    location.reload();
                } else {
                    alert(data.message || '제목 수정에 실패했습니다.');
                    location.reload();
                }
            } catch (e) {
                console.error(e);
                alert('제목 수정 중 오류가 발생했습니다.');
                location.reload();
            }
        }

        input.addEventListener('keydown', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                input.blur();
            }

            if (e.key === 'Escape') {
                location.reload();
            }
        });

        input.addEventListener('blur', saveTitle);
    }

    async function deleteHistory(chatPostIdx) {
        if (!chatPostIdx) {
            alert("대화 번호를 찾을 수 없습니다.");
            return;
        }

        if (!confirm("이 대화를 삭제할까요?")) return;

        try {
            const res = await fetch(CTX + '/assistant/history/' + chatPostIdx + '/delete', {
                method: 'POST'
            });

            const data = await res.json();
            if (data.success) {
                location.reload();
            } else {
                alert("대화 삭제에 실패했습니다.");
            }
        } catch (e) {
            console.error(e);
            alert("대화 삭제 중 오류가 발생했습니다.");
        }
    }

    async function startNewChat() {
        if (!confirm(MSG_RESET_CONFIRM)) return;

        currentChatPostIdx = null;

        try {
            await fetch(CTX + '/assistant/reset', {method: 'POST'});
        } catch (e) {
            console.error(e);
        }

        const body = document.getElementById('chatBody');
        body.innerHTML =
            '<div class="msg-row ai">' +
            '<div class="msg-avatar">&#129302;</div>' +
            '<div class="msg-bubble">' + escapeHtml(MSG_RESET_DONE) + '</div>' +
            '</div>';

        document.querySelectorAll('.history-item').forEach(item => {
            item.classList.remove('active');
        });

        setTimeout(() => {
            location.reload();
        }, 300);
    }

    function appendMessage(role, text) {
        const body = document.getElementById('chatBody');
        const row = document.createElement('div');
        row.className = 'msg-row ' + role;

        if (role === 'ai') {
            row.innerHTML =
                '<div class="msg-avatar">&#129302;</div>' +
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
        icon.textContent = flag ? '...' : '\u27A1';

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

<%@ include file="../common/footer.jsp" %>
</body>
</html>

