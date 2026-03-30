<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageCSS" value="assistant/assistant.css"/>
<%@ include file="../common/header.jsp" %>
<body>
<div class="chat-wrap">

    <!-- 사이드바 -->
    <aside class="chat-side">
        <div class="side-header">
            <div class="ai-avatar">✈️</div>
            <div class="ai-info">
                <div class="ai-name">Trip AI</div>
                <div class="ai-status"><span class="dot"></span> 온라인</div>
            </div>
        </div>

        <div class="side-desc">
            <p>AI 여행 어시스턴트가 여행 계획부터 현지 정보까지 도와드립니다!</p>
        </div>

        <div class="quick-title">빠른 질문</div>
        <div class="quick-btns">
            <button class="qb" onclick="sendQuick('일본 도쿄 3박 4일 여행 코스 추천해줘')">🗼 도쿄 여행 코스</button>
            <button class="qb" onclick="sendQuick('유럽 여행 예산은 얼마나 필요해?')">💶 유럽 여행 예산</button>
            <button class="qb" onclick="sendQuick('동남아 배낭여행 추천 국가는?')">🌴 동남아 배낭여행</button>
            <button class="qb" onclick="sendQuick('제주도 2박 3일 여행 일정 만들어줘')">🍊 제주도 일정</button>
            <button class="qb" onclick="sendQuick('혼자 여행하기 좋은 안전한 나라 추천해줘')">🧳 혼자 여행 추천</button>
            <button class="qb" onclick="sendQuick('여행 준비물 체크리스트 알려줘')">📋 준비물 체크리스트</button>
        </div>

        <button class="reset-btn" onclick="resetChat()">🗑️ 대화 초기화</button>
    </aside>

    <!-- 메인 채팅 영역 -->
    <main class="chat-main">
        <div class="chat-header">
            <h2>✈️ AI 여행 어시스턴트</h2>
            <span class="chat-sub">여행에 관한 무엇이든 물어보세요</span>
        </div>

        <!-- 메시지 목록 -->
        <div class="chat-body" id="chatBody">
            <div class="msg-row ai">
                <div class="msg-avatar">✈️</div>
                <div class="msg-bubble">
                    안녕하세요! 저는 TripTogether의 AI 여행 어시스턴트입니다. 🌍<br><br>
                    여행지 추천, 일정 계획, 예산 정보, 현지 맛집, 교통 안내 등<br>
                    여행에 관한 모든 것을 도와드릴게요!<br><br>
                    어떤 여행을 꿈꾸고 계신가요? ✨
                </div>
            </div>
        </div>

        <!-- 입력 영역 -->
        <div class="chat-input-wrap">
            <div class="chat-input-inner">
                <textarea
                    id="chatInput"
                    class="chat-input"
                    placeholder="여행에 관해 궁금한 것을 입력하세요... (Enter로 전송, Shift+Enter로 줄바꿈)"
                    rows="1"
                    onkeydown="handleKey(event)"
                    oninput="autoResize(this)"
                ></textarea>
                <button class="send-btn" id="sendBtn" onclick="sendMessage()">
                    <span id="sendIcon">➤</span>
                </button>
            </div>
            <div class="chat-hint">AI 답변은 참고용입니다. 중요한 여행 정보는 공식 채널에서 확인하세요.</div>
        </div>
    </main>
</div>

<%@ include file="../common/footer.jsp" %>

<script>
    const CTX = '${pageContext.request.contextPath}';
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

        try {
            const res = await fetch(CTX + '/assistant/chat', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({message})
            });
            const data = await res.json();
            appendMessage('ai', data.answer || '응답을 받지 못했습니다.');
        } catch (e) {
            appendMessage('ai', '❌ 네트워크 오류가 발생했습니다.');
        } finally {
            setLoading(false);
        }
    }

    function sendQuick(text) {
        document.getElementById('chatInput').value = text;
        sendMessage();
    }

    async function resetChat() {
        if (!confirm('대화 내용을 모두 초기화할까요?')) return;
        await fetch(CTX + '/assistant/reset', {method: 'POST'});
        const body = document.getElementById('chatBody');
        body.innerHTML =
            '<div class="msg-row ai">' +
            '<div class="msg-avatar">✈️</div>' +
            '<div class="msg-bubble">대화가 초기화되었습니다.</div>' +
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
    }

    function formatText(text) {
        return text
            .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
            .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
            .replace(/\n/g, '<br>');
    }

    function escapeHtml(text) {
        return text.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
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