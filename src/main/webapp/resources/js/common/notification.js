(function () {
    'use strict';

    const bell = document.getElementById('notiBell');
    const dropdown = document.getElementById('notiDropdown');
    const markAllBtn = document.getElementById('notiMarkAll');
    if (!bell || !dropdown) return;

    // contextPath 추출 (예: /TripTogether) — script 태그 src에서 유도
    const ctx = (function () {
        const script = document.currentScript
            || document.querySelector('script[src*="/resources/js/common/notification.js"]');
        if (!script) return '';
        const match = script.getAttribute('src').match(/^(.*)\/resources\/js\/common\/notification\.js/);
        return match ? match[1] : '';
    })();

    // ===== 드롭다운 열기/닫기 =====
    function openDropdown() {
        dropdown.hidden = false;
    }
    function closeDropdown() {
        dropdown.hidden = true;
    }
    function toggleDropdown() {
        if (dropdown.hidden) openDropdown();
        else closeDropdown();
    }

    bell.addEventListener('click', function (e) {
        e.stopPropagation();
        toggleDropdown();
    });

    // 드롭다운 내부 클릭은 닫히지 않도록 (아이템 클릭 제외)
    dropdown.addEventListener('click', function (e) {
        e.stopPropagation();
    });

    // 외부 클릭 → 닫기
    document.addEventListener('click', function () {
        if (!dropdown.hidden) closeDropdown();
    });

    // ESC → 닫기
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
        if (current === '99+') return; // 99+ 유지
        const next = parseInt(current, 10) - 1;
        if (next <= 0) badge.remove();
        else badge.textContent = String(next);
    }

    // ===== 알림 아이템 클릭 → 읽음 처리 + 이동 =====
    dropdown.querySelectorAll('.noti-row').forEach(function (row) {
        row.addEventListener('click', function () {
            const id = row.dataset.id;
            const targetUrl = row.dataset.target || '/mypage';
            const wasUnread = !row.classList.contains('is-read');
            const fallback = ctx + (row.dataset.target || '/mypage');

            fetch(ctx + '/api/notifications/' + id + '/read', {
                method: 'POST',
                headers: {'X-Requested-With': 'XMLHttpRequest'}
            }).then(function (r) { return r.json(); })
              .then(function (data) {
                  if (wasUnread) {
                      row.classList.add('is-read');
                      decrementBadge();
                  }
                  const url = (data.success && data.targetUrl)
                      ? ctx + data.targetUrl
                      : fallback;
                  location.href = url;
              })
              .catch(function () {
                  location.href = fallback;
              });
        });
    });

    // ===== 모두 읽음 버튼 =====
    if (markAllBtn) {
        markAllBtn.addEventListener('click', function () {
            fetch(ctx + '/api/notifications/read-all', {
                method: 'POST',
                headers: {'X-Requested-With': 'XMLHttpRequest'}
            }).then(function (r) { return r.json(); })
              .then(function (data) {
                  if (!data.success) return;
                  dropdown.querySelectorAll('.noti-row').forEach(function (row) {
                      row.classList.add('is-read');
                  });
                  hideBadge();
              })
              .catch(function () { /* 네트워크 에러 무시 */ });
        });
    }
})();
