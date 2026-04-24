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

    .history-title-input {
        width: 100%;
        border: none;
        outline: none;
        font-size: 14px;
        color: #374151;
        background: transparent;
    }

    .history-empty,
    .history-login-guide {
        font-size: 12px;
        color: #9ca3af;
        line-height: 1.5;
    }
</style>

<%-- ============================================================
     JS용 메시지 변수 — 서버 사이드에서 미리 꺼내 둠
     ============================================================ --%>
<spring:message code="assistant.error.parse"          var="msgErrorParse"               javaScriptEscape="true"/>
<spring:message code="assistant.error.server"         var="msgErrorServer"              javaScriptEscape="true"/>
<spring:message code="assistant.error.request"        var="msgErrorRequest"             javaScriptEscape="true"/>
<spring:message code="assistant.error.network"        var="msgErrorNetwork"             javaScriptEscape="true"/>
<spring:message code="assistant.error.noResponse"     var="msgErrorNoResponse"          javaScriptEscape="true"/>
<spring:message code="assistant.loading"              var="msgLoading"                  javaScriptEscape="true"/>
<spring:message code="assistant.reset.confirm"        var="msgResetConfirm"             javaScriptEscape="true"/>
<spring:message code="assistant.reset.done"           var="msgResetDone"                javaScriptEscape="true"/>
<spring:message code="assistant.quick.tokyo"          var="msgQuickTokyo"               javaScriptEscape="true"/>
<spring:message code="assistant.quick.budget"         var="msgQuickBudget"              javaScriptEscape="true"/>
<spring:message code="assistant.quick.backpacking"    var="msgQuickBackpacking"         javaScriptEscape="true"/>
<spring:message code="assistant.quick.jeju"           var="msgQuickJeju"                javaScriptEscape="true"/>
<spring:message code="assistant.quick.solo"           var="msgQuickSolo"                javaScriptEscape="true"/>
<spring:message code="assistant.quick.checklist"      var="msgQuickChecklist"           javaScriptEscape="true"/>
<spring:message code="assistant.input.placeholder"    var="msgInputPlaceholder"         javaScriptEscape="true"/>
<spring:message code="assistant.history.noIdx"        var="msgHistoryNoIdx"             javaScriptEscape="true"/>
<spring:message code="assistant.history.loadFailed"   var="msgHistoryLoadFailed"        javaScriptEscape="true"/>
<spring:message code="assistant.history.loadError"    var="msgHistoryLoadError"         javaScriptEscape="true"/>
<spring:message code="assistant.history.deleteConfirm" var="msgHistoryDeleteConfirm"    javaScriptEscape="true"/>
<spring:message code="assistant.history.deleteFailed" var="msgHistoryDeleteFailed"      javaScriptEscape="true"/>
<spring:message code="assistant.history.deleteError"  var="msgHistoryDeleteError"       javaScriptEscape="true"/>
<spring:message code="assistant.history.editTitleFailed" var="msgHistoryEditTitleFailed" javaScriptEscape="true"/>
<spring:message code="assistant.history.editTitleError"  var="msgHistoryEditTitleError"  javaScriptEscape="true"/>
<spring:message code="assistant.history.newChatGreeting" var="msgHistoryNewChatGreeting" javaScriptEscape="true"/>

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

        <div class="history-section">
            <div class="history-header">
                <span class="history-title"><spring:message code="assistant.history.title" /></span>
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
                                                data-idx="${chatPost.chat_post_idx}"
                                                onclick="loadHistory(this.dataset.idx, this)">
                                            <c:out value="${chatPost.title}" />
                                        </button>
                                        <button type="button"
                                                class="history-edit-btn"
                                                data-idx="${chatPost.chat_post_idx}"
                                                onclick="editHistoryTitle(this.dataset.idx, this)">
                                            <spring:message code="assistant.history.edit" />
                                        </button>
                                        <button type="button"
                                                class="history-delete-btn"
                                                data-idx="${chatPost.chat_post_idx}"
                                                onclick="deleteHistory(this.dataset.idx)">
                                            <spring:message code="assistant.history.delete" />
                                        </button>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="history-empty"><spring:message code="assistant.history.empty" /></p>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <p class="history-login-guide"><spring:message code="assistant.history.loginGuide" /></p>
                </c:otherwise>
            </c:choose>
        </div>

        <button class="reset-btn" onclick="startNewChat()">
            <spring:message code="assistant.history.newChat" />
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

<script>
    const CTX = '${pageContext.request.contextPath}';

    const MSG_ERROR_PARSE       = '${msgErrorParse}';
    const MSG_ERROR_SERVER      = '${msgErrorServer}';
    const MSG_ERROR_REQUEST     = '${msgErrorRequest}';
    const MSG_ERROR_NETWORK     = '${msgErrorNetwork}';
    const MSG_ERROR_NO_RESPONSE = '${msgErrorNoResponse}';
    const MSG_LOADING           = '${msgLoading}';
    const MSG_RESET_CONFIRM     = '${msgResetConfirm}';
    const MSG_RESET_DONE        = '${msgResetDone}';
    const MSG_HISTORY_NO_IDX         = '${msgHistoryNoIdx}';
    const MSG_HISTORY_LOAD_FAILED    = '${msgHistoryLoadFailed}';
    const MSG_HISTORY_LOAD_ERROR     = '${msgHistoryLoadError}';
    const MSG_HISTORY_DELETE_CONFIRM = '${msgHistoryDeleteConfirm}';
    const MSG_HISTORY_DELETE_FAILED  = '${msgHistoryDeleteFailed}';
    const MSG_HISTORY_DELETE_ERROR   = '${msgHistoryDeleteError}';
    const MSG_HISTORY_EDIT_FAILED    = '${msgHistoryEditTitleFailed}';
    const MSG_HISTORY_EDIT_ERROR     = '${msgHistoryEditTitleError}';
    const MSG_NEW_CHAT_GREETING      = '${msgHistoryNewChatGreeting}';

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
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ message: message, chatPostIdx: currentChatPostIdx })
            });

            const rawText = await res.text();
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
            alert(MSG_HISTORY_NO_IDX);
            return;
        }

        try {
            const res = await fetch(CTX + '/assistant/history/' + chatPostIdx);
            const data = await res.json();

            if (!data.success) {
                alert(data.message || MSG_HISTORY_LOAD_FAILED);
                return;
            }

            currentChatPostIdx = data.chatPostIdx;

            document.querySelectorAll('.history-item').forEach(function(item) {
                item.classList.remove('active');
            });

            const item = button.closest('.history-item');
            if (item) item.classList.add('active');

            const body = document.getElementById('chatBody');
            body.innerHTML = '';
            data.history.forEach(function(msg) {
                appendMessage(msg.role === 'assistant' ? 'ai' : 'user', msg.content);
            });
        } catch (e) {
            console.error(e);
            alert(MSG_HISTORY_LOAD_ERROR);
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
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ title: newTitle })
                });
                const data = await res.json();
                if (data.success) {
                    location.reload();
                } else {
                    alert(data.message || MSG_HISTORY_EDIT_FAILED);
                    location.reload();
                }
            } catch (e) {
                console.error(e);
                alert(MSG_HISTORY_EDIT_ERROR);
                location.reload();
            }
        }

        input.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') { e.preventDefault(); input.blur(); }
            if (e.key === 'Escape') { location.reload(); }
        });
        input.addEventListener('blur', saveTitle);
    }

    async function deleteHistory(chatPostIdx) {
        if (!chatPostIdx) {
            alert(MSG_HISTORY_NO_IDX);
            return;
        }
        if (!confirm(MSG_HISTORY_DELETE_CONFIRM)) return;

        try {
            const res = await fetch(CTX + '/assistant/history/' + chatPostIdx + '/delete', {
                method: 'POST'
            });
            const data = await res.json();
            if (data.success) {
                location.reload();
            } else {
                alert(MSG_HISTORY_DELETE_FAILED);
            }
        } catch (e) {
            console.error(e);
            alert(MSG_HISTORY_DELETE_ERROR);
        }
    }

    async function startNewChat() {
        currentChatPostIdx = null;

        try {
            await fetch(CTX + '/assistant/reset', { method: 'POST' });
        } catch (e) {
            console.error(e);
        }

        const body = document.getElementById('chatBody');
        body.innerHTML =
            '<div class="msg-row ai">' +
            '<div class="msg-avatar">✈️</div>' +
            '<div class="msg-bubble">' + escapeHtml(MSG_NEW_CHAT_GREETING) + '</div>' +
            '</div>';

        document.querySelectorAll('.history-item').forEach(function(item) {
            item.classList.remove('active');
        });

        setTimeout(function() { location.reload(); }, 300);
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
        return appendMessage('ai', MSG_LOADING);
    }

    function removeLoadingBubble(node) {
        if (node && node.parentNode) {
            node.parentNode.removeChild(node);
        }
    }

    function setLoading(flag) {
        isLoading = flag;
        const btn   = document.getElementById('sendBtn');
        const icon  = document.getElementById('sendIcon');
        const input = document.getElementById('chatInput');
        btn.disabled   = flag;
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

<%@ include file="../common/footer.jsp" %>

</body>
</html>
