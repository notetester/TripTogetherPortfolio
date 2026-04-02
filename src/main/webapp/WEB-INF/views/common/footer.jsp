<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- chatbot.css를 공통 header에 추가하거나 여기서 직접 로드 --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/chatbot.css">
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
<%--    &lt;%&ndash; 토글 버튼 (우측 하단 고정) &ndash;%&gt;--%>
<%--    <div id="chatbot-toggle" title="TripTogether 도우미">💬</div>--%>

<%--    &lt;%&ndash; 챗봇 창 (기본 hidden) &ndash;%&gt;--%>
<%--    <div id="chatbot-box" class="hidden">--%>
<%--        <div class="chatbot-header">--%>
<%--            <div class="chatbot-header-info">--%>
<%--                <span class="chatbot-dot"></span>--%>
<%--                <span>TripTogether Assistant</span>--%>
<%--            </div>--%>
<%--            <button id="chatbot-close">✕</button>--%>
<%--        </div>--%>
<%--        <div class="chatbot-body" id="chatbot-body">--%>
<%--            <div class="bot-msg">안녕하세요! 여행에 관해 무엇이든 물어보세요 ✈️</div>--%>
<%--        </div>--%>
<%--        <div class="chatbot-input">--%>
<%--            <input type="text" id="chatbot-input-field" placeholder="질문을 입력하세요...">--%>
<%--            <button id="chatbot-send">전송</button>--%>
<%--        </div>--%>
<%--    </div>--%>
</footer>

<%-- ══════════════════════════════════════════
     챗봇 토글 버튼
══════════════════════════════════════════ --%>
<button id="chatbot-toggle" aria-label="TripTogether 도우미 열기" title="AI 여행 도우미">
    <span id="cb-toggle-icon">✈️</span>
    <span id="chatbot-badge"></span>
</button>

<%-- ══════════════════════════════════════════
     챗봇 창
══════════════════════════════════════════ --%>
<div id="chatbot-box" role="dialog" aria-label="TripTogether 도우미">

    <%-- 헤더 --%>
    <div class="cb-header">
        <div class="cb-avatar">✈️</div>
        <div class="cb-header-info">
            <div class="cb-header-name">TripTogether 도우미</div>
            <div class="cb-header-status">
                <span class="cb-dot"></span>
                <span>온라인 · AI가 답변합니다</span>
            </div>
        </div>
        <button class="cb-close" id="cb-close" aria-label="닫기">✕</button>
    </div>

    <%-- 본문 (메시지 목록) --%>
    <div class="cb-body" id="cb-body"></div>

    <%-- 입력 --%>
    <div class="cb-footer">
        <div class="cb-suggestions" id="cb-suggestions"></div>
        <div class="cb-input-row">
            <textarea id="cb-input" placeholder="여행에 대해 물어보세요..." rows="1"></textarea>
            <button id="cb-send" aria-label="전송">➤</button>
        </div>
    </div>
</div>

<script>
    (function () {
        const ctx     = '${pageContext.request.contextPath}';
        const loggedIn = ${ not empty sessionScope.loginUser ? 'true' : 'false' };

        /* ── 상태 ── */
        let isOpen    = false;
        let isTyping  = false;
        let history   = [];          // {role, content}[]

        /* ── 초기 빠른 선택 메뉴 ── */
        const INITIAL_SUGGESTIONS = [
            { label: '인기 여행지 추천 ✈️', msg: '인기 여행지를 추천해줘' },
            { label: '여행 코스 보기 🗺️',   msg: '여행 코스를 보고 싶어' },
            { label: 'AI 도우미 사용법 ✨',  msg: 'AI 도우미는 어떻게 쓰나요?' },
            { label: '커뮤니티 둘러보기 💬', msg: '커뮤니티에서 뭘 할 수 있어?' },
            ...(!loggedIn ? [{ label: '로그인 / 회원가입 👤', msg: '로그인하려면 어떻게 해?' }] : []),
        ];

        const toggle  = document.getElementById('chatbot-toggle');
        const box     = document.getElementById('chatbot-box');
        const body    = document.getElementById('cb-body');
        const input   = document.getElementById('cb-input');
        const sendBtn = document.getElementById('cb-send');
        const badge   = document.getElementById('chatbot-badge');
        const suggs   = document.getElementById('cb-suggestions');

        /* ── 열기 / 닫기 ── */
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

        /* ── 웰컴 카드 렌더링 ── */
        function renderWelcome() {
            const wrap = document.createElement('div');
            wrap.className = 'cb-msg-wrap bot';
            wrap.innerHTML = `
            <div class="cb-welcome">
                <div class="cb-welcome-title">👋 안녕하세요!</div>
                TripTogether 여행 도우미입니다.<br>
                여행지 추천, 코스 정보, 사이트 이용 방법 등 무엇이든 물어보세요!
            </div>`;
            body.appendChild(wrap);

            /* 초기 빠른 선택 칩 */
            renderSuggestions(INITIAL_SUGGESTIONS.map(s => s.label));
        }

        /* ── 빠른 선택 칩 렌더링 ── */
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

        /* ── 사용자 메시지 렌더링 ── */
        function appendUserMsg(text) {
            const wrap = document.createElement('div');
            wrap.className = 'cb-msg-wrap user';
            wrap.innerHTML = `
            <div class="cb-msg user">${escHtml(text)}</div>
            <div class="cb-time">${getTime()}</div>`;
            body.appendChild(wrap);
            scrollBottom();
        }

        /* ── 타이핑 인디케이터 ── */
        function showTyping() {
            const el = document.createElement('div');
            el.id = 'cb-typing';
            el.className = 'cb-msg-wrap bot';
            el.innerHTML = `<div class="cb-typing"><span></span><span></span><span></span></div>`;
            body.appendChild(el);
            scrollBottom();
        }
        function hideTyping() {
            const el = document.getElementById('cb-typing');
            if (el) el.remove();
        }

        /* ── 봇 메시지 + 링크 + 빠른 답변 렌더링 ── */
        function appendBotResponse(data) {
            const wrap = document.createElement('div');
            wrap.className = 'cb-msg-wrap bot';

            // 텍스트 메시지
            if (data.message) {
                const msgEl = document.createElement('div');
                msgEl.className = 'cb-msg bot';
                msgEl.innerHTML = formatBotText(data.message);
                wrap.appendChild(msgEl);
            }

            body.appendChild(wrap);

            // 링크 버튼 (별도 wrap)
            if (data.links && data.links.length > 0) {
                const linksWrap = document.createElement('div');
                linksWrap.className = 'cb-links';
                data.links.forEach(link => {
                    const a = document.createElement('a');
                    a.className = 'cb-link-btn';
                    a.href = ctx + link.url;
                    a.innerHTML = `<span class="cb-link-icon">${link.icon || '→'}</span>${escHtml(link.label)}`;
                    linksWrap.appendChild(a);
                });
                body.appendChild(linksWrap);
            }

            // 타임스탬프
            const timeEl = document.createElement('div');
            timeEl.className = 'cb-time';
            timeEl.style.alignSelf = 'flex-start';
            timeEl.textContent = getTime();
            body.appendChild(timeEl);

            // 빠른 답변 칩 업데이트
            if (data.quickReplies && data.quickReplies.length > 0) {
                suggs.innerHTML = '';
                data.quickReplies.forEach(reply => {
                    const chip = document.createElement('button');
                    chip.className = 'cb-suggest-chip';
                    chip.textContent = reply;
                    chip.addEventListener('click', () => {
                        input.value = reply;
                        suggs.innerHTML = '';
                        sendMessage();
                    });
                    suggs.appendChild(chip);
                });
            } else {
                suggs.innerHTML = '';
            }

            scrollBottom();
        }

        /* ── 메시지 전송 ── */
        async function sendMessage() {
            const text = input.value.trim();
            if (!text || isTyping) return;

            input.value = '';
            input.style.height = 'auto';
            suggs.innerHTML = '';

            appendUserMsg(text);

            // 히스토리에 추가 (최근 6턴만 유지)
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
                        message:     text,
                        history:     history.slice(0, -1), // 방금 추가한 것 제외
                        currentPath: window.location.pathname.replace(ctx, ''),
                        loggedIn:    loggedIn
                    })
                });

                const data = await res.json();
                hideTyping();
                appendBotResponse(data);

                // assistant 히스토리 기록 (JSON 문자열로 저장)
                history.push({ role: 'assistant', content: JSON.stringify(data) });

            } catch (e) {
                hideTyping();
                appendBotResponse({
                    message: '죄송해요, 잠시 오류가 발생했어요. 다시 시도해주세요. 🙏',
                    links: [],
                    quickReplies: []
                });
            } finally {
                isTyping = false;
                sendBtn.disabled = false;
            }
        }

        /* ── 입력 이벤트 ── */
        sendBtn.addEventListener('click', sendMessage);
        input.addEventListener('keydown', function (e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        });
        // 자동 높이
        input.addEventListener('input', function () {
            this.style.height = 'auto';
            this.style.height = Math.min(this.scrollHeight, 80) + 'px';
        });

        /* ── ESC로 닫기 ── */
        document.addEventListener('keydown', e => {
            if (e.key === 'Escape' && isOpen) closeChat();
        });

        /* ── 유틸 ── */
        function scrollBottom() {
            requestAnimationFrame(() => { body.scrollTop = body.scrollHeight; });
        }

        function getTime() {
            return new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
        }

        function escHtml(str) {
            return str
                .replace(/&/g, '&amp;').replace(/</g, '&lt;')
                .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }

        function formatBotText(text) {
            // 줄바꿈 처리, HTML 이스케이프 후 이모지는 그대로
            return escHtml(text).replace(/\n/g, '<br>');
        }

        /* ── 페이지 로드 3초 후 자동 뱃지 (비로그인 한정) ── */
        if (!loggedIn) {
            setTimeout(() => {
                if (!isOpen) badge.classList.add('show');
            }, 3000);
        }

    })();
</script>