<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/context-modal.jspf" %>
<%-- 공통 토스트 + 닫기 스크립트 --%>
<script>
/* ── 토스트 ── */
function adm_toast(msg, type = 'success') {
    const c   = document.getElementById('adm-toast-container');
    const el  = document.createElement('div');
    el.className = 'adm-toast ' + type;
    el.innerHTML = (type === 'success' ? '✅ ' : '❌ ') + msg;
    c.appendChild(el);
    setTimeout(() => { el.style.opacity='0'; el.style.transform='translateX(16px)';
        el.style.transition='.3s'; setTimeout(()=>el.remove(),300); }, 2800);
}

/* ── 모달 외부 클릭 닫기 ── */
document.addEventListener('click', e => {
    document.querySelectorAll('.action-menu.open').forEach(m => {
        if (!m.parentElement.contains(e.target)) m.classList.remove('open');
    });
});

window.admToggleActionMenu = function(btn) {
    if (!btn) return;
    const menu = btn.nextElementSibling;
    if (!menu || !menu.classList.contains('action-menu')) return;
    document.querySelectorAll('.action-menu.open').forEach(m => {
        if (m !== menu) m.classList.remove('open');
    });
    menu.classList.toggle('open');
};

/* ── ESC 키 ── */
document.addEventListener('keydown', e => {
    if (e.key === 'Escape') {
        document.querySelectorAll('.adm-modal-overlay.open').forEach(o => o.classList.remove('open'));
        document.querySelectorAll('.action-menu.open').forEach(m => m.classList.remove('open'));
    }
});

/* ── 사이드바 햄버거 드로어 ── */
(function () {
    var toggle   = document.getElementById('sidebar-toggle');
    var sidebar  = document.getElementById('adm-sidebar');
    var backdrop = document.getElementById('admBackdrop');
    if (!toggle || !sidebar || !backdrop) return;

    var mqDesktop = window.matchMedia('(min-width: 1024px)');

    function openDrawer() {
        sidebar.classList.add('open');
        backdrop.hidden = false;
        requestAnimationFrame(function () { backdrop.classList.add('is-open'); });
        toggle.classList.add('is-open');
        toggle.setAttribute('aria-expanded', 'true');
        document.body.classList.add('adm-nav-lock');
    }
    function closeDrawer() {
        sidebar.classList.remove('open');
        backdrop.classList.remove('is-open');
        backdrop.hidden = true;
        toggle.classList.remove('is-open');
        toggle.setAttribute('aria-expanded', 'false');
        document.body.classList.remove('adm-nav-lock');
    }
    toggle.addEventListener('click', function () {
        if (sidebar.classList.contains('open')) closeDrawer(); else openDrawer();
    });
    backdrop.addEventListener('click', closeDrawer);
    sidebar.addEventListener('click', function (e) {
        if (mqDesktop.matches) return;
        var link = e.target.closest('a');
        if (link) closeDrawer();
    });
    var onChange = function (e) { if (e.matches) closeDrawer(); };
    if (mqDesktop.addEventListener) mqDesktop.addEventListener('change', onChange);
    else if (mqDesktop.addListener) mqDesktop.addListener(onChange);
})();
</script>
<script src="${pageContext.request.contextPath}/resources/js/admin/admin-list-tools.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/admin/admin-column-actions.js"></script>
    </div><%-- /adm-main --%>
    <div class="adm-backdrop" id="admBackdrop" hidden></div>
</div><%-- /adm-shell --%>
</body>
</html>
