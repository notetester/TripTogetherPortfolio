<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
function adm_toast(msg, type = 'success') {
    const c   = document.getElementById('adm-toast-container');
    const el  = document.createElement('div');
    el.className = 'adm-toast ' + type;
    el.innerHTML = (type === 'success' ? '✅ ' : '❌ ') + msg;
    c.appendChild(el);
    setTimeout(() => { el.style.opacity='0'; el.style.transform='translateX(16px)';
        el.style.transition='.3s'; setTimeout(()=>el.remove(),300); }, 2800);
}
document.addEventListener('keydown', e => {
    if (e.key === 'Escape') {
        document.querySelectorAll('.adm-modal-overlay.open').forEach(o => o.classList.remove('open'));
    }
});
</script>
    </div><%-- /adm-main --%>
</div><%-- /adm-shell --%>
</body>
</html>
