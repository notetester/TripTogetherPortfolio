<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="site-footer">
    <div class="si">
        <div class="footer-inner">
            <div class="footer-logo">
                <div class="logo-icon" style="width:32px;height:32px;font-size:16px;">🌐</div>
                <span class="logo-text" style="font-size:18px;">TripTogether</span>
            </div>
            <p class="footer-copy">© 2026 TripTogether. All rights reserved. AI 기반 여행 플랫폼</p>
        </div>
    </div>
    <%-- 토글 버튼 (우측 하단 고정) --%>
    <div id="chatbot-toggle" title="TripTogether 도우미">💬</div>

    <%-- 챗봇 창 (기본 hidden) --%>
    <div id="chatbot-box" class="hidden">
        <div class="chatbot-header">
            <div class="chatbot-header-info">
                <span class="chatbot-dot"></span>
                <span>TripTogether Assistant</span>
            </div>
            <button id="chatbot-close">✕</button>
        </div>
        <div class="chatbot-body" id="chatbot-body">
            <div class="bot-msg">안녕하세요! 여행에 관해 무엇이든 물어보세요 ✈️</div>
        </div>
        <div class="chatbot-input">
            <input type="text" id="chatbot-input-field" placeholder="질문을 입력하세요...">
            <button id="chatbot-send">전송</button>
        </div>
    </div>
</footer>
<script>
    document.getElementById('chatbot-toggle').addEventListener('click', function () {
        document.getElementById('chatbot-box').classList.toggle('hidden');
    });
    document.getElementById('chatbot-close').addEventListener('click', function () {
        document.getElementById('chatbot-box').classList.add('hidden');
    });
    document.getElementById('chatbot-send').addEventListener('click', function () {
        var input = document.getElementById('chatbot-input-field');
        var text = input.value.trim();
        if (!text) return;
        var body = document.getElementById('chatbot-body');
        var userMsg = document.createElement('div');
        userMsg.className = 'user-msg';
        userMsg.textContent = text;
        body.appendChild(userMsg);
        input.value = '';
        body.scrollTop = body.scrollHeight;
    });
    document.getElementById('chatbot-input-field').addEventListener('keydown', function (e) {
        if (e.key === 'Enter') document.getElementById('chatbot-send').click();
    });
</script>