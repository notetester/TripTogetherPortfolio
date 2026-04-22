(function () {
    'use strict';

    const bell = document.getElementById('notiBell');
    const dropdown = document.getElementById('notiDropdown');
    const markAllBtn = document.getElementById('notiMarkAll');
    if (!bell || !dropdown) return;

    const body = dropdown.querySelector('.noti-dropdown-body');
    if (!body) return;

    // contextPath 추출 (예: /TripTogether)
    const ctx = (function () {
        const script = document.currentScript
            || document.querySelector('script[src*="/resources/js/common/notification.js"]');
        if (!script) return '';
        const match = script.getAttribute('src').match(/^(.*)\/resources\/js\/common\/notification\.js/);
        return match ? match[1] : '';
    })();

    // 소스 타입 → 표시 라벨
    const TYPE_LABELS = {
        community: '[커뮤니티]',
        inquiry:   '[문의]',
        report:    '[신고]',
        levelup:   '[레벨업]',
        grade:     '[등급]'
    };
    function typeLabel(sourceType) {
        return TYPE_LABELS[sourceType] || '[알림]';
    }

    // 날짜 포맷 (MM-dd HH:mm)
    function formatDate(value) {
        const d = value ? new Date(value) : new Date();
        const pad = function (n) { return String(n).padStart(2, '0'); };
        return pad(d.getMonth() + 1) + '-' + pad(d.getDate())
            + ' ' + pad(d.getHours()) + ':' + pad(d.getMinutes());
    }

    // ===== 드롭다운 토글 =====
    function closeDropdown() { dropdown.hidden = true; }
    function toggleDropdown() {
        if (dropdown.hidden) dropdown.hidden = false;
        else closeDropdown();
    }

    bell.addEventListener('click', function (e) {
        e.stopPropagation();
        toggleDropdown();
    });
    dropdown.addEventListener('click', function (e) {
        e.stopPropagation();
    });
    document.addEventListener('click', function () {
        if (!dropdown.hidden) closeDropdown();
    });
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && !dropdown.hidden) closeDropdown();
    });

    // ===== 배지 조작 =====
    function getBadge() {
        return bell.querySelector('.noti-badge');
    }
    function hideBadge() {
        const badge = getBadge();
        if (badge) badge.remove();
    }
    function decrementBadge() {
        const badge = getBadge();
        if (!badge) return;
        const current = badge.textContent;
        if (current === '99+') return;
        const next = parseInt(current, 10) - 1;
        if (next <= 0) badge.remove();
        else badge.textContent = String(next);
    }
    function incrementBadge() {
        let badge = getBadge();
        if (!badge) {
            badge = document.createElement('span');
            badge.className = 'noti-badge';
            badge.textContent = '1';
            bell.appendChild(badge);
            return;
        }
        const current = badge.textContent;
        if (current === '99+') return;
        const next = parseInt(current, 10) + 1;
        badge.textContent = next > 99 ? '99+' : String(next);
    }

    // ===== 드롭다운 행 생성/삽입 =====
    const MAX_ROWS = 5;

    function createRow(noti) {
        const row = document.createElement('div');
        row.className = 'noti-row';
        row.dataset.id = noti.notificationId;
        row.dataset.target = noti.targetUrl || '/mypage';

        const type = document.createElement('span');
        type.className = 'noti-type';
        type.textContent = typeLabel(noti.sourceType);

        const msg = document.createElement('span');
        msg.className = 'noti-msg';
        msg.textContent = noti.message || '';

        const date = document.createElement('span');
        date.className = 'noti-date';
        date.textContent = formatDate(noti.createdAt);

        row.appendChild(type);
        row.appendChild(msg);
        row.appendChild(date);
        return row;
    }

    function prependRow(noti) {
        const empty = body.querySelector('.noti-empty');
        if (empty) empty.remove();

        body.insertBefore(createRow(noti), body.firstChild);

        const rows = body.querySelectorAll('.noti-row');
        for (let i = MAX_ROWS; i < rows.length; i++) {
            rows[i].remove();
        }
    }

    // ===== 이벤트 위임: 행 클릭 → 읽음 처리 + 이동 =====
    body.addEventListener('click', function (e) {
        const row = e.target.closest('.noti-row');
        if (!row) return;
        const id = row.dataset.id;
        const fallback = ctx + (row.dataset.target || '/mypage');
        const wasUnread = !row.classList.contains('is-read');

        fetch(ctx + '/api/notifications/' + id + '/read', {
            method: 'POST',
            headers: {'X-Requested-With': 'XMLHttpRequest'}
        }).then(function (r) { return r.json(); })
          .then(function (data) {
              if (wasUnread) {
                  row.classList.add('is-read');
                  decrementBadge();
              }
              location.href = (data.success && data.targetUrl)
                  ? ctx + data.targetUrl
                  : fallback;
          })
          .catch(function () { location.href = fallback; });
    });

    // ===== 모두 읽음 =====
    if (markAllBtn) {
        markAllBtn.addEventListener('click', function () {
            fetch(ctx + '/api/notifications/read-all', {
                method: 'POST',
                headers: {'X-Requested-With': 'XMLHttpRequest'}
            }).then(function (r) { return r.json(); })
              .then(function (data) {
                  if (!data.success) return;
                  body.querySelectorAll('.noti-row').forEach(function (row) {
                      row.classList.add('is-read');
                  });
                  hideBadge();
              })
              .catch(function () {});
        });
    }

    // ===== 토스트 (Phase 3-4에서 구현) =====
    function showToast(_noti) {
        // stub — 다음 단계에서 구현
    }

    // ===== SSE 구독 =====
    if (typeof EventSource === 'undefined') return;

    const sse = new EventSource(ctx + '/sse/notifications');
    sse.addEventListener('notification', function (e) {
        try {
            const noti = JSON.parse(e.data);
            incrementBadge();
            prependRow(noti);
            showToast(noti);
        } catch (err) {
            // JSON 파싱 실패 무시
        }
    });
    // 브라우저가 자동 재연결 처리 (기본 3초 간격)
    sse.onerror = function () {};
})();
