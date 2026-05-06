<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_assistant_error_parse_js" code="assistant.error.parse" javaScriptEscape="true"/>
<spring:message var="msg_assistant_error_server_js" code="assistant.error.server" javaScriptEscape="true"/>
<spring:message var="msg_assistant_error_request_js" code="assistant.error.request" javaScriptEscape="true"/>
<spring:message var="msg_assistant_error_network_js" code="assistant.error.network" javaScriptEscape="true"/>
<spring:message var="msg_assistant_error_noResponse_js" code="assistant.error.noResponse" javaScriptEscape="true"/>
<spring:message var="msg_assistant_loading_js" code="assistant.loading" javaScriptEscape="true"/>
<spring:message var="msg_assistant_reset_confirm_js" code="assistant.reset.confirm" javaScriptEscape="true"/>
<spring:message var="msg_assistant_reset_done_js" code="assistant.reset.done" javaScriptEscape="true"/>
<spring:message var="msg_assistant_quick_tokyo_js" code="assistant.quick.tokyo" javaScriptEscape="true"/>
<spring:message var="msg_assistant_quick_budget_js" code="assistant.quick.budget" javaScriptEscape="true"/>
<spring:message var="msg_assistant_quick_backpacking_js" code="assistant.quick.backpacking" javaScriptEscape="true"/>
<spring:message var="msg_assistant_quick_jeju_js" code="assistant.quick.jeju" javaScriptEscape="true"/>
<spring:message var="msg_assistant_quick_solo_js" code="assistant.quick.solo" javaScriptEscape="true"/>
<spring:message var="msg_assistant_quick_checklist_js" code="assistant.quick.checklist" javaScriptEscape="true"/>
<spring:message var="msg_assistant_input_placeholder_js" code="assistant.input.placeholder" javaScriptEscape="true"/>
<spring:message var="msg_assistant_history_noIdx_js" code="assistant.history.noIdx" javaScriptEscape="true"/>
<spring:message var="msg_assistant_history_loadFailed_js" code="assistant.history.loadFailed" javaScriptEscape="true"/>
<spring:message var="msg_assistant_history_loadError_js" code="assistant.history.loadError" javaScriptEscape="true"/>
<spring:message var="msg_assistant_history_deleteConfirm_js" code="assistant.history.deleteConfirm" javaScriptEscape="true"/>
<spring:message var="msg_assistant_history_deleteFailed_js" code="assistant.history.deleteFailed" javaScriptEscape="true"/>
<spring:message var="msg_assistant_history_deleteError_js" code="assistant.history.deleteError" javaScriptEscape="true"/>
<spring:message var="msg_assistant_history_editTitleFailed_js" code="assistant.history.editTitleFailed" javaScriptEscape="true"/>
<spring:message var="msg_assistant_history_editTitleError_js" code="assistant.history.editTitleError" javaScriptEscape="true"/>
<spring:message var="msg_assistant_history_newChatGreeting_js" code="assistant.history.newChatGreeting" javaScriptEscape="true"/>
<spring:message var="msg_assistant_side_name" code="assistant.side.name"/>
<spring:message var="msg_assistant_side_status" code="assistant.side.status"/>
<spring:message var="msg_assistant_side_desc" code="assistant.side.desc"/>
<spring:message var="msg_assistant_quick_title" code="assistant.quick.title"/>
<spring:message var="msg_assistant_quick_tokyo_label" code="assistant.quick.tokyo.label"/>
<spring:message var="msg_assistant_quick_budget_label" code="assistant.quick.budget.label"/>
<spring:message var="msg_assistant_quick_backpacking_label" code="assistant.quick.backpacking.label"/>
<spring:message var="msg_assistant_quick_jeju_label" code="assistant.quick.jeju.label"/>
<spring:message var="msg_assistant_quick_solo_label" code="assistant.quick.solo.label"/>
<spring:message var="msg_assistant_quick_checklist_label" code="assistant.quick.checklist.label"/>
<spring:message var="msg_assistant_history_title" code="assistant.history.title"/>
<spring:message var="msg_assistant_history_edit" code="assistant.history.edit"/>
<spring:message var="msg_assistant_history_delete" code="assistant.history.delete"/>
<spring:message var="msg_assistant_history_empty" code="assistant.history.empty"/>
<spring:message var="msg_assistant_history_loginGuide" code="assistant.history.loginGuide"/>
<spring:message var="msg_assistant_history_newChat" code="assistant.history.newChat"/>
<spring:message var="msg_assistant_header_title" code="assistant.header.title"/>
<spring:message var="msg_assistant_header_subtitle" code="assistant.header.subtitle"/>
<spring:message var="msg_assistant_greeting_line1" code="assistant.greeting.line1"/>
<spring:message var="msg_assistant_greeting_line2" code="assistant.greeting.line2"/>
<spring:message var="msg_assistant_greeting_line3" code="assistant.greeting.line3"/>
<spring:message var="msg_assistant_greeting_line4" code="assistant.greeting.line4"/>
<spring:message var="msg_assistant_hint" code="assistant.hint"/>
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


<body>
<div class="chat-wrap">

    <%-- ===================== 사이드바 영역 ===================== --%>
    <aside class="chat-side">
        <div class="side-header">
            <div class="ai-avatar">✈️</div>
            <div class="ai-info">
                <div class="ai-name">${msg_assistant_side_name}</div>
                <div class="ai-status">
                    <span class="dot"></span>
                    ${msg_assistant_side_status}
                </div>
            </div>
        </div>

        <div class="side-desc">
            <p>${msg_assistant_side_desc}</p>
        </div>

        <div class="quick-title">${msg_assistant_quick_title}</div>
        <div class="quick-btns">
            <button class="qb" onclick="sendQuick('${msg_assistant_quick_tokyo_js}')">
                ${msg_assistant_quick_tokyo_label}
            </button>
            <button class="qb" onclick="sendQuick('${msg_assistant_quick_budget_js}')">
                ${msg_assistant_quick_budget_label}
            </button>
            <button class="qb" onclick="sendQuick('${msg_assistant_quick_backpacking_js}')">
                ${msg_assistant_quick_backpacking_label}
            </button>
            <button class="qb" onclick="sendQuick('${msg_assistant_quick_jeju_js}')">
                ${msg_assistant_quick_jeju_label}
            </button>
            <button class="qb" onclick="sendQuick('${msg_assistant_quick_solo_js}')">
                ${msg_assistant_quick_solo_label}
            </button>
            <button class="qb" onclick="sendQuick('${msg_assistant_quick_checklist_js}')">
                ${msg_assistant_quick_checklist_label}
            </button>
        </div>

        <div class="history-section">
            <div class="history-header">
                <span class="history-title">${msg_assistant_history_title}</span>
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
                                            ${msg_assistant_history_edit}
                                        </button>
                                        <button type="button"
                                                class="history-delete-btn"
                                                data-idx="${chatPost.chat_post_idx}"
                                                onclick="deleteHistory(this.dataset.idx)">
                                            ${msg_assistant_history_delete}
                                        </button>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="history-empty">${msg_assistant_history_empty}</p>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <p class="history-login-guide">${msg_assistant_history_loginGuide}</p>
                </c:otherwise>
            </c:choose>
        </div>

        <button class="reset-btn" onclick="startNewChat()">
            ${msg_assistant_history_newChat}
        </button>
    </aside>

    <%-- ===================== 메인 채팅 영역 ===================== --%>
    <main class="chat-main">
        <div class="chat-header">
            <h2>${msg_assistant_header_title}</h2>
            <span class="chat-sub">${msg_assistant_header_subtitle}</span>
        </div>

        <div class="chat-body" id="chatBody">
            <div class="msg-row ai">
                <div class="msg-avatar">✈️</div>
                <div class="msg-bubble">
                    ${msg_assistant_greeting_line1}<br><br>
                    ${msg_assistant_greeting_line2}<br>
                    ${msg_assistant_greeting_line3}<br><br>
                    ${msg_assistant_greeting_line4}
                </div>
            </div>
        </div>

        <div class="chat-input-wrap">
            <div class="chat-input-inner">
                <textarea
                    id="chatInput"
                    class="chat-input"
                    placeholder="${msg_assistant_input_placeholder_js}"
                    rows="1"
                    onkeydown="handleKey(event)"
                    oninput="autoResize(this)"
                ></textarea>
                <button class="send-btn" id="sendBtn" onclick="sendMessage()">
                    <span id="sendIcon">➤</span>
                </button>
            </div>
            <div class="chat-hint">${msg_assistant_hint}</div>
        </div>
    </main>
</div>

<script>
    const CTX = '${pageContext.request.contextPath}';

    const MSG_ERROR_PARSE       = '${msg_assistant_error_parse_js}';
    const MSG_ERROR_SERVER      = '${msg_assistant_error_server_js}';
    const MSG_ERROR_REQUEST     = '${msg_assistant_error_request_js}';
    const MSG_ERROR_NETWORK     = '${msg_assistant_error_network_js}';
    const MSG_ERROR_NO_RESPONSE = '${msg_assistant_error_noResponse_js}';
    const MSG_LOADING           = '${msg_assistant_loading_js}';
    const MSG_RESET_CONFIRM     = '${msg_assistant_reset_confirm_js}';
    const MSG_RESET_DONE        = '${msg_assistant_reset_done_js}';
    const MSG_HISTORY_NO_IDX         = '${msg_assistant_history_noIdx_js}';
    const MSG_HISTORY_LOAD_FAILED    = '${msg_assistant_history_loadFailed_js}';
    const MSG_HISTORY_LOAD_ERROR     = '${msg_assistant_history_loadError_js}';
    const MSG_HISTORY_DELETE_CONFIRM = '${msg_assistant_history_deleteConfirm_js}';
    const MSG_HISTORY_DELETE_FAILED  = '${msg_assistant_history_deleteFailed_js}';
    const MSG_HISTORY_DELETE_ERROR   = '${msg_assistant_history_deleteError_js}';
    const MSG_HISTORY_EDIT_FAILED    = '${msg_assistant_history_editTitleFailed_js}';
    const MSG_HISTORY_EDIT_ERROR     = '${msg_assistant_history_editTitleError_js}';
    const MSG_NEW_CHAT_GREETING      = '${msg_assistant_history_newChatGreeting_js}';

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