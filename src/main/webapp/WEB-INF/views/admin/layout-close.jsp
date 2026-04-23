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
</script>
    </div><%-- /adm-main --%>
</div><%-- /adm-shell --%>
</body>
</html>
