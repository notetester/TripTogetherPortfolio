<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
window.TripAdminBlockDetailFallback = window.TripAdminBlockDetailFallback || (function () {
    function notice(message) {
        if (!message) return;
        if (typeof window.adm_toast === 'function') {
            try {
                window.adm_toast(message, 'error');
                return;
            } catch (e) {}
        }
        try {
            window.alert(message);
        } catch (e) {}
    }

    function getElement(id) {
        return document.getElementById(id);
    }

    function resolveDetailButton(button) {
        if (!button) {
            return null;
        }

        var templateId = button.getAttribute('data-template-id');
        if (templateId && getElement(templateId)) {
            return button;
        }

        if (!templateId) {
            return button;
        }

        var fallbackButton = Array.prototype.find.call(
            document.querySelectorAll('.js-open-block-detail'),
            function (candidate) {
                return candidate !== button
                    && candidate.getAttribute('data-template-id') === templateId
                    && !!getElement(templateId);
            }
        );

        return fallbackButton || button;
    }

    function open(templateId, title) {
        var template = getElement(templateId);
        var modal = getElement('blockDetailModal');
        var body = getElement('blockDetailBody');
        var titleEl = getElement('blockDetailTitle');

        if (!template || !modal || !body || !titleEl) {
            console.error('Block detail fallback open failed', {
                templateId: templateId,
                hasTemplate: !!template,
                hasModal: !!modal,
                hasBody: !!body,
                hasTitle: !!titleEl
            });
            notice((window.ADMIN_BLOCK_MSG && window.ADMIN_BLOCK_MSG.fetchError) || 'Failed to open detail modal.');
            return false;
        }

        titleEl.textContent = title || titleEl.getAttribute('data-default-title') || titleEl.textContent || 'Detail';
        body.innerHTML = '';
        if (template.content) {
            body.appendChild(document.importNode(template.content, true));
        } else {
            body.innerHTML = template.innerHTML || '';
        }
        modal.classList.add('open');

        if (window.TripAdminTranslation && typeof window.TripAdminTranslation.scan === 'function') {
            try {
                window.TripAdminTranslation.scan(body);
            } catch (error) {
                console.error('Block detail translation scan failed', error);
            }
        }
        return false;
    }

    function close() {
        var modal = getElement('blockDetailModal');
        if (modal) {
            modal.classList.remove('open');
        }
        return false;
    }

    function handleButtonClick(button) {
        var resolvedButton = resolveDetailButton(button);
        if (!resolvedButton) return false;
        var templateId = resolvedButton.getAttribute('data-template-id');
        var title = resolvedButton.getAttribute('data-detail-title');

        var section = (typeof window.sectionFromDetailTemplateId === 'function') ? window.sectionFromDetailTemplateId(templateId) : '';
        var forceDetailFetch = section && typeof window.getSectionMode === 'function' && window.getSectionMode(section) === 'SERVER';
        if (templateId && (forceDetailFetch || !getElement(templateId)) && typeof window.fetchBlockDetailTemplate === 'function') {
            window.fetchBlockDetailTemplate(templateId, forceDetailFetch).then(function (loaded) {
                if (loaded) {
                    open(templateId, title);
                } else {
                    notice((window.ADMIN_BLOCK_MSG && window.ADMIN_BLOCK_MSG.fetchError) || 'Failed to open detail modal.');
                }
            });
            return false;
        }

        return open(templateId, title);
    }

    function bindDirect() {
        document.querySelectorAll('.js-open-block-detail').forEach(function (button) {
            if (button.dataset.detailBound === 'true') {
                return;
            }
            button.dataset.detailBound = 'true';
            button.addEventListener('click', function (event) {
                event.preventDefault();
                event.stopPropagation();
                handleButtonClick(button);
            });
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', bindDirect);
    } else {
        bindDirect();
    }

    return {
        open: open,
        close: close,
        handleButtonClick: handleButtonClick,
        bindDirect: bindDirect
    };
})();
</script>
