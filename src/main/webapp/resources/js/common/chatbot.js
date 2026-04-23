(function () {
    'use strict';

    const root = document.getElementById('chatbot-box');
    if (!root) return;

    // ===== Config injected by footer.jsp through window.__chatbotConfig =====
    const cfg = window.__chatbotConfig || {};
    const ctx = cfg.ctx || '';
    const loggedIn = !!cfg.loggedIn;
    const locale = cfg.locale || undefined;
    const msg = cfg.msg || {};

    const STORAGE_KEY = loggedIn ? null : 'chatbot_anon_conv_id';

    // ===== DOM =====
    const toggle   = document.getElementById('chatbot-toggle');
    const box      = root;
    const sidebar  = document.getElementById('cb-sidebar');
    const convList = document.getElementById('cb-conv-list');
    const newBtn   = document.getElementById('cb-new');
    const body     = document.getElementById('cb-body');
    const input    = document.getElementById('cb-input');
    const sendBtn  = document.getElementById('cb-send');
    const badge    = document.getElementById('chatbot-badge');
    const suggs    = document.getElementById('cb-suggestions');
    const titleEl  = document.getElementById('cb-header-title');

    // ===== State =====
    let isOpen = false;
    let isTyping = false;
    let currentConvId = null;      // Active conversation ID. null means a fresh conversation.

    const INITIAL_SUGGESTIONS = [
        { label: msg.suggestPopular,   msg: msg.suggestPopularMsg },
        { label: msg.suggestCourses,   msg: msg.suggestCoursesMsg },
        { label: msg.suggestAssistant, msg: msg.suggestAssistantMsg },
        { label: msg.suggestCommunity, msg: msg.suggestCommunityMsg },
        ...(!loggedIn ? [{ label: msg.suggestAuth, msg: msg.suggestAuthMsg }] : [])
    ];

    // ===== Toggle =====
    function openChat() {
        isOpen = true;
        box.classList.add('open');
        toggle.classList.add('open');
        document.getElementById('cb-toggle-icon').textContent = '✕';
        if (badge) badge.classList.remove('show');

        // Load conversations only on the first open.
        if (!box.dataset.initialized) {
            box.dataset.initialized = '1';
            initChat();
        }
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

    // ===== Initialization =====
    async function initChat() {
        if (loggedIn) {
            await loadConversationList();
            // Open the most recent conversation when one exists.
            const convs = convList ? convList.querySelectorAll('[data-conv-id]') : [];
            if (convs.length > 0) {
                openConversation(parseInt(convs[0].dataset.convId, 10));
            } else {
                renderWelcome();
            }
        } else {
            // Anonymous users restore a conversation ID from sessionStorage.
            const savedId = STORAGE_KEY ? sessionStorage.getItem(STORAGE_KEY) : null;
            if (savedId) {
                await openConversation(parseInt(savedId, 10));
            } else {
                renderWelcome();
            }
        }
    }

    // ===== Conversation list for signed-in users =====
    async function loadConversationList() {
        if (!convList) return;
        try {
            const res = await fetch(ctx + '/chatbot/conversations');
            const data = await res.json();
            renderConversationList(data.conversations || []);
        } catch (e) {
            convList.innerHTML = '';
        }
    }

    function renderConversationList(list) {
        if (!convList) return;
        convList.innerHTML = '';
        list.forEach(c => {
            const row = document.createElement('div');
            row.className = 'cb-conv-item';
            row.dataset.convId = c.conversationId;
            if (currentConvId === c.conversationId) row.classList.add('active');

            const title = document.createElement('span');
            title.className = 'cb-conv-title';
            title.textContent = c.title || msg.untitledConversation || 'New Conversation';
            title.addEventListener('click', () => openConversation(c.conversationId));

            const menu = document.createElement('button');
            menu.className = 'cb-conv-menu';
            menu.type = 'button';
            menu.textContent = '⋯';
            menu.addEventListener('click', (e) => {
                e.stopPropagation();
                showConvMenu(c, row);
            });

            row.appendChild(title);
            row.appendChild(menu);
            convList.appendChild(row);
        });
    }

    function showConvMenu(conv, rowEl) {
        const action = window.prompt(
            msg.menuPrompt || '1: Rename title / 2: Delete / Cancel: empty',
            ''
        );
        if (!action) return;
        if (action === '1') {
            const newTitle = window.prompt(msg.renamePrompt || 'New title', conv.title || '');
            if (newTitle && newTitle.trim()) renameConversation(conv.conversationId, newTitle.trim());
        } else if (action === '2') {
            if (window.confirm(msg.deleteConfirm || 'Delete this conversation?')) deleteConversation(conv.conversationId);
        }
    }

    async function renameConversation(convId, newTitle) {
        try {
            await fetch(ctx + '/chatbot/conversations/' + convId + '/title', {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ title: newTitle })
            });
            await loadConversationList();
        } catch (e) {}
    }

    async function deleteConversation(convId) {
        try {
            await fetch(ctx + '/chatbot/conversations/' + convId, { method: 'DELETE' });
            if (currentConvId === convId) {
                currentConvId = null;
                renderWelcome();
            }
            await loadConversationList();
        } catch (e) {}
    }

    // ===== Start a new conversation =====
    if (newBtn) {
        newBtn.addEventListener('click', () => {
            currentConvId = null;
            if (STORAGE_KEY) sessionStorage.removeItem(STORAGE_KEY);
            body.innerHTML = '';
            if (titleEl) titleEl.textContent = msg.welcomeTitle || msg.untitledConversation || 'New Conversation';
            renderWelcome();
            if (loggedIn) loadConversationList();
            input.focus();
        });
    }

    // ===== Open a conversation =====
    async function openConversation(convId) {
        try {
            const res = await fetch(ctx + '/chatbot/conversations/' + convId + '/messages');
            if (!res.ok) {
                // 403/404 can happen when an anonymous session expires.
                if (STORAGE_KEY) sessionStorage.removeItem(STORAGE_KEY);
                currentConvId = null;
                renderWelcome();
                return;
            }
            const data = await res.json();
            currentConvId = convId;
            if (STORAGE_KEY) sessionStorage.setItem(STORAGE_KEY, String(convId));
            if (titleEl && data.conversation) titleEl.textContent = data.conversation.title || msg.untitledConversation || 'New Conversation';
            body.innerHTML = '';
            suggs.innerHTML = '';
            (data.messages || []).forEach(m => {
                if (m.role === 'user') {
                    appendUserMsg(m.content, false);
                } else {
                    try {
                        const parsed = JSON.parse(m.content);
                        appendBotResponse(parsed, false);
                    } catch (e) {
                        appendBotResponse({ message: m.content, links: [], quickReplies: [] }, false);
                    }
                }
            });
            if (loggedIn) {
                renderConversationList(
                    Array.from(convList.children).map(el => ({
                        conversationId: parseInt(el.dataset.convId, 10),
                        title: el.querySelector('.cb-conv-title').textContent
                    }))
                );
            }
            scrollBottom();
        } catch (e) {
            renderWelcome();
        }
    }

    // ===== Welcome screen =====
    function renderWelcome() {
        body.innerHTML = '';
        const wrap = document.createElement('div');
        wrap.className = 'cb-msg-wrap bot';
        wrap.innerHTML = '<div class="cb-welcome">' +
            '<div class="cb-welcome-title">' + escHtml(msg.welcomeTitle || 'Hello!') + '</div>' +
            escHtml(msg.welcomeBody1 || '') + '<br>' +
            escHtml(msg.welcomeBody2 || '') +
            '</div>';
        body.appendChild(wrap);
        renderSuggestions(INITIAL_SUGGESTIONS.map(s => s.label));
    }

    function renderSuggestions(chips) {
        suggs.innerHTML = '';
        chips.forEach(label => {
            const chip = document.createElement('button');
            chip.type = 'button';
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

    function appendUserMsg(text, shouldScroll) {
        const wrap = document.createElement('div');
        wrap.className = 'cb-msg-wrap user';
        wrap.innerHTML = '<div class="cb-msg user">' + escHtml(text) + '</div>' +
            '<div class="cb-time">' + getTime() + '</div>';
        body.appendChild(wrap);
        if (shouldScroll !== false) scrollBottom();
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

    function appendBotResponse(data, shouldScroll) {
        const wrap = document.createElement('div');
        wrap.className = 'cb-msg-wrap bot';

        if (data.message) {
            const msgEl = document.createElement('div');
            msgEl.className = 'cb-msg bot' + (data.inappropriate ? ' warn' : '');
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

        if (data.quickReplies && data.quickReplies.length > 0) {
            renderQuickReplies(data.quickReplies);
        } else {
            suggs.innerHTML = '';
        }

        if (shouldScroll !== false) scrollBottom();
    }

    function renderQuickReplies(replies) {
        suggs.innerHTML = '';
        replies.forEach(r => {
            const chip = document.createElement('button');
            chip.type = 'button';
            chip.className = 'cb-suggest-chip';
            chip.textContent = r;
            chip.addEventListener('click', () => {
                input.value = r;
                suggs.innerHTML = '';
                sendMessage();
            });
            suggs.appendChild(chip);
        });
    }

    // ===== Send message =====
    async function sendMessage() {
        const text = input.value.trim();
        if (!text || isTyping) return;

        input.value = '';
        suggs.innerHTML = '';
        appendUserMsg(text);

        isTyping = true;
        sendBtn.disabled = true;
        showTyping();

        try {
            const res = await fetch(ctx + '/chatbot/ask', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    message: text,
                    conversationId: currentConvId,
                    currentPath: window.location.pathname.replace(ctx, ''),
                    loggedIn: loggedIn
                })
            });
            const data = await res.json();
            hideTyping();
            appendBotResponse(data);

            // Store the conversation ID when the server created a new one.
            if (!currentConvId && data.conversationId) {
                currentConvId = data.conversationId;
                if (STORAGE_KEY) sessionStorage.setItem(STORAGE_KEY, String(currentConvId));
                if (loggedIn) loadConversationList();
            }
        } catch (e) {
            hideTyping();
            appendBotResponse({ message: msg.error || 'An error occurred.', links: [], quickReplies: [] });
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

    // ===== Utilities =====
    function scrollBottom() {
        requestAnimationFrame(() => { body.scrollTop = body.scrollHeight; });
    }

    function getTime() {
        return new Date().toLocaleTimeString(locale, { hour: '2-digit', minute: '2-digit' });
    }

    function escHtml(str) {
        return String(str)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;');
    }

    function formatBotText(text) {
        return escHtml(text).replace(/\n/g, '<br>');
    }
})();
