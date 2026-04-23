(function (window, document) {
    'use strict';

    const i18n = window.ADMIN_TRANSLATION_UI || {};

    function msg(key, fallback) {
        return Object.prototype.hasOwnProperty.call(i18n, key) ? i18n[key] : (fallback || key);
    }

    function escapeHtml(value) {
        if (value == null) return '';
        return String(value)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    function formatDate(value) {
        if (!value) return '-';
        const date = new Date(value);
        if (Number.isNaN(date.getTime())) return escapeHtml(value);
        return date.toLocaleString(window.ADMIN_CONTEXT_LOCALE || undefined, {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        });
    }

    function translationOptionLabel(item) {
        const badges = [];
        badges.push((item.targetLang || '').toUpperCase());
        if (item.isPrimary) badges.push(msg('primaryShort', '대표'));
        if (item.outdated) badges.push(msg('outdatedShort', '구버전'));
        const versionNo = item.currentRevision && item.currentRevision.versionNo ? item.currentRevision.versionNo : '-';
        badges.push('v' + versionNo);
        return '[' + badges.join('][') + '] ' + (item.title || msg('untitled', '제목 없음'));
    }

    function renderRevisionOptions(revisions, currentRevisionIdx) {
        if (!Array.isArray(revisions) || !revisions.length) {
            return '<option value="">' + escapeHtml(msg('noRevision', '버전 없음')) + '</option>';
        }
        return revisions.map(function (revision) {
            const selected = String(revision.translationRevisionIdx) === String(currentRevisionIdx) ? ' selected' : '';
            const label = 'v' + revision.versionNo
                + ' · ' + (revision.translationType || '-')
                + ' · ' + formatDate(revision.createdAt);
            return '<option value="' + escapeHtml(revision.translationRevisionIdx) + '"' + selected + '>' + escapeHtml(label) + '</option>';
        }).join('');
    }

    function renderTranslationDetail(widget, item) {
        const container = widget.querySelector('.js-translation-detail');
        if (!container) return;
        if (!item) {
            container.innerHTML = '<div class="adm-tr-empty">' + escapeHtml(msg('noTranslationSelected', '번역안을 선택해줘야 함')) + '</div>';
            return;
        }

        const currentRevision = item.currentRevision || {};
        const status = item.status || 'DRAFT';
        const visibility = item.visibilityScope || 'ADMIN_ONLY';
        const sourceTextSnapshot = currentRevision.sourceTextSnapshot || widget.dataset.sourceText || '';
        const translatedText = currentRevision.translatedText || '';

        container.innerHTML = ''
            + '<div class="adm-tr-detail-card">'
            + '  <div class="adm-tr-meta">'
            + '    <span class="adm-tr-pill">' + escapeHtml((item.targetLang || '').toUpperCase()) + '</span>'
            + '    <span class="adm-tr-pill">' + escapeHtml(status) + '</span>'
            + '    <span class="adm-tr-pill">' + escapeHtml(visibility) + '</span>'
            + (item.isPrimary ? '    <span class="adm-tr-pill is-primary">' + escapeHtml(msg('primary', '대표본')) + '</span>' : '')
            + (item.outdated ? '    <span class="adm-tr-pill is-warn">' + escapeHtml(msg('outdated', '현재 원문과 기준 스냅샷이 다름')) + '</span>' : '    <span class="adm-tr-pill is-ok">' + escapeHtml(msg('upToDate', '현재 원문 기준과 일치')) + '</span>')
            + '  </div>'
            + '  <div class="adm-tr-row">'
            + '    <label class="adm-tr-label">' + escapeHtml(msg('title', '제목')) + '</label>'
            + '    <input type="text" class="adm-input js-edit-title" value="' + escapeHtml(item.title || '') + '">'
            + '  </div>'
            + '  <div class="adm-tr-grid">'
            + '    <div>'
            + '      <label class="adm-tr-label">' + escapeHtml(msg('currentSource', '현재 원문')) + '</label>'
            + '      <div class="adm-tr-source-box">' + escapeHtml(widget.dataset.sourceText || '') + '</div>'
            + '    </div>'
            + '    <div>'
            + '      <label class="adm-tr-label">' + escapeHtml(msg('basedSource', '현재 버전 기준 원문')) + '</label>'
            + '      <div class="adm-tr-source-box">' + escapeHtml(sourceTextSnapshot) + '</div>'
            + '    </div>'
            + '  </div>'
            + '  <div class="adm-tr-row">'
            + '    <label class="adm-tr-label">' + escapeHtml(msg('translatedText', '번역문')) + '</label>'
            + '    <textarea class="adm-input adm-tr-textarea js-edit-text">' + escapeHtml(translatedText) + '</textarea>'
            + '  </div>'
            + '  <div class="adm-tr-row">'
            + '    <label class="adm-tr-label">' + escapeHtml(msg('note', '메모')) + '</label>'
            + '    <textarea class="adm-input adm-tr-note js-edit-note">' + escapeHtml(currentRevision.note || '') + '</textarea>'
            + '  </div>'
            + '  <div class="adm-tr-actions">'
            + '    <label class="adm-tr-check"><input type="checkbox" class="js-edit-primary"' + (item.isPrimary ? ' checked' : '') + '> ' + escapeHtml(msg('setPrimary', '이 번역안을 대표본으로 지정')) + '</label>'
            + '    <button type="button" class="adm-btn adm-btn-primary js-save-revision">' + escapeHtml(msg('saveRevision', '새 버전 저장')) + '</button>'
            + '  </div>'
            + '  <div class="adm-tr-history">'
            + '    <div class="adm-tr-history-head">' + escapeHtml(msg('revisionHistory', '버전 이력')) + '</div>'
            + '    <div class="adm-tr-history-row">'
            + '      <select class="adm-input js-revision-select">' + renderRevisionOptions(item.revisions, item.currentRevisionIdx) + '</select>'
            + '      <button type="button" class="adm-btn adm-btn-ghost js-restore-revision">' + escapeHtml(msg('restoreRevision', '선택 버전으로 되돌리기')) + '</button>'
            + '    </div>'
            + '  </div>'
            + '</div>';

        container.dataset.translationIdx = item.translationIdx;
    }

    function setTranslations(widget, translations) {
        widget.__translations = Array.isArray(translations) ? translations : [];
        const select = widget.querySelector('.js-translation-select');
        if (!select) return;

        if (!widget.__translations.length) {
            select.innerHTML = '<option value="">' + escapeHtml(msg('none', '생성된 번역본 없음')) + '</option>';
            renderTranslationDetail(widget, null);
            return;
        }

        select.innerHTML = widget.__translations.map(function (item, index) {
            const selected = item.isPrimary || index === 0 ? ' selected' : '';
            return '<option value="' + escapeHtml(item.translationIdx) + '"' + selected + '>' + escapeHtml(translationOptionLabel(item)) + '</option>';
        }).join('');

        const selectedId = select.value;
        const selected = widget.__translations.find(function (item) {
            return String(item.translationIdx) === String(selectedId);
        }) || widget.__translations[0];
        if (selected && String(select.value) !== String(selected.translationIdx)) {
            select.value = String(selected.translationIdx);
        }
        renderTranslationDetail(widget, selected);
    }

    function selectedTranslation(widget) {
        const select = widget.querySelector('.js-translation-select');
        if (!select || !widget.__translations) return null;
        return widget.__translations.find(function (item) {
            return String(item.translationIdx) === String(select.value);
        }) || null;
    }

    async function fetchJson(url, options) {
        const response = await fetch(url, options);
        let payload;
        try {
            payload = await response.json();
        } catch (e) {
            throw new Error(msg('requestFailed', '요청 처리 중 오류가 발생했음'));
        }
        if (!response.ok || !payload.success) {
            throw new Error((payload && payload.message) || msg('requestFailed', '요청 처리 중 오류가 발생했음'));
        }
        return payload;
    }

    function lookupUrl(widget) {
        const params = new URLSearchParams({
            sourceType: widget.dataset.sourceType,
            sourceIdx: widget.dataset.sourceIdx,
            fieldName: widget.dataset.fieldName,
            sourceText: widget.dataset.sourceText || ''
        });
        return (window.__CTX__ || '') + '/admin/translations/lookup?' + params.toString();
    }

    async function loadTranslations(widget, force) {
        if (widget.dataset.loading === 'true') return;
        if (!force && widget.dataset.loaded === 'true') return;
        widget.dataset.loading = 'true';
        const detail = widget.querySelector('.js-translation-detail');
        if (detail) {
            detail.innerHTML = '<div class="adm-tr-empty">' + escapeHtml(msg('loading', '불러오는 중...')) + '</div>';
        }
        try {
            const payload = await fetchJson(lookupUrl(widget), {headers: {'Accept': 'application/json'}});
            setTranslations(widget, payload.translations || []);
            widget.dataset.loaded = 'true';
        } catch (error) {
            if (detail) {
                detail.innerHTML = '<div class="adm-tr-empty is-error">' + escapeHtml(error.message || msg('loadFailed', '번역 목록을 불러오지 못했음')) + '</div>';
            }
        } finally {
            widget.dataset.loading = 'false';
        }
    }

    async function createTranslation(widget) {
        const sourceLang = widget.querySelector('.js-create-source-lang').value;
        const targetLang = widget.querySelector('.js-create-target-lang').value;
        const title = widget.querySelector('.js-create-title').value.trim();
        const autoTranslate = widget.querySelector('.js-create-auto').checked;
        const translatedText = widget.querySelector('.js-create-translated-text').value.trim();

        if (!autoTranslate && !translatedText) {
            alert(msg('enterTranslatedText', '수동 번역문을 입력해야 함'));
            return;
        }

        const payload = {
            sourceType: widget.dataset.sourceType,
            sourceIdx: Number(widget.dataset.sourceIdx),
            fieldName: widget.dataset.fieldName,
            sourceLang: sourceLang,
            targetLang: targetLang,
            sourceText: widget.dataset.sourceText || '',
            title: title,
            autoTranslate: autoTranslate,
            translatedText: translatedText,
            markPrimary: false
        };

        try {
            await fetchJson((window.__CTX__ || '') + '/admin/translations', {
                method: 'POST',
                headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
                body: JSON.stringify(payload)
            });
            if (typeof window.adm_toast === 'function') {
                window.adm_toast(msg('created', '번역안을 생성했음'));
            }
            widget.dataset.loaded = 'false';
            await loadTranslations(widget, true);
            widget.querySelector('.js-create-title').value = '';
            widget.querySelector('.js-create-translated-text').value = '';
            widget.querySelector('.js-create-box').classList.remove('open');
        } catch (error) {
            alert(error.message || msg('createFailed', '번역안 생성에 실패했음'));
        }
    }

    async function saveRevision(widget) {
        const current = selectedTranslation(widget);
        if (!current) return;
        const title = widget.querySelector('.js-edit-title').value.trim();
        const translatedText = widget.querySelector('.js-edit-text').value.trim();
        const note = widget.querySelector('.js-edit-note').value.trim();
        const markPrimary = widget.querySelector('.js-edit-primary').checked;
        if (!translatedText) {
            alert(msg('enterTranslatedText', '번역문을 입력해야 함'));
            return;
        }

        const payload = {
            sourceLang: current.sourceLang || widget.dataset.defaultSourceLang || 'ko',
            sourceText: widget.dataset.sourceText || '',
            translatedText: translatedText,
            title: title,
            note: note,
            markPrimary: markPrimary
        };

        try {
            await fetchJson((window.__CTX__ || '') + '/admin/translations/' + current.translationIdx + '/revisions', {
                method: 'POST',
                headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
                body: JSON.stringify(payload)
            });
            if (typeof window.adm_toast === 'function') {
                window.adm_toast(msg('saved', '새 번역 버전을 저장했음'));
            }
            widget.dataset.loaded = 'false';
            await loadTranslations(widget, true);
        } catch (error) {
            alert(error.message || msg('saveFailed', '번역 저장에 실패했음'));
        }
    }

    async function restoreRevision(widget) {
        const current = selectedTranslation(widget);
        if (!current) return;
        const revisionIdx = widget.querySelector('.js-revision-select').value;
        if (!revisionIdx) return;
        if (!window.confirm(msg('confirmRestore', '선택한 버전으로 되돌리겠음?'))) {
            return;
        }

        try {
            await fetchJson((window.__CTX__ || '') + '/admin/translations/' + current.translationIdx + '/restore', {
                method: 'POST',
                headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
                body: JSON.stringify({revisionIdx: Number(revisionIdx)})
            });
            if (typeof window.adm_toast === 'function') {
                window.adm_toast(msg('restored', '선택 버전으로 되돌렸음'));
            }
            widget.dataset.loaded = 'false';
            await loadTranslations(widget, true);
        } catch (error) {
            alert(error.message || msg('restoreFailed', '버전 복원에 실패했음'));
        }
    }

    function bind(widget) {
        widget.addEventListener('click', function (event) {
            const toggleBtn = event.target.closest('.js-translation-toggle');
            if (toggleBtn) {
                const body = widget.querySelector('.js-translation-body');
                const open = body.classList.toggle('open');
                toggleBtn.textContent = open ? msg('hide', '숨기기') : msg('open', '번역 보기');
                if (open) {
                    loadTranslations(widget, false);
                }
                return;
            }

            const refreshBtn = event.target.closest('.js-translation-refresh');
            if (refreshBtn) {
                loadTranslations(widget, true);
                return;
            }

            const newBtn = event.target.closest('.js-translation-create-toggle');
            if (newBtn) {
                widget.querySelector('.js-create-box').classList.toggle('open');
                return;
            }

            const createBtn = event.target.closest('.js-create-submit');
            if (createBtn) {
                createTranslation(widget);
                return;
            }

            const saveBtn = event.target.closest('.js-save-revision');
            if (saveBtn) {
                saveRevision(widget);
                return;
            }

            const restoreBtn = event.target.closest('.js-restore-revision');
            if (restoreBtn) {
                restoreRevision(widget);
                return;
            }
        });

        widget.addEventListener('change', function (event) {
            const select = event.target.closest('.js-translation-select');
            if (select) {
                renderTranslationDetail(widget, selectedTranslation(widget));
                return;
            }

            const autoCheck = event.target.closest('.js-create-auto');
            if (autoCheck) {
                const manualWrap = widget.querySelector('.js-create-manual-wrap');
                if (manualWrap) {
                    manualWrap.style.display = autoCheck.checked ? 'none' : '';
                }
            }
        });
    }

    function createMarkup(widget) {
        const title = widget.dataset.label || msg('sectionTitle', '번역 관리');
        const defaultSourceLang = widget.dataset.defaultSourceLang || 'ko';
        widget.innerHTML = ''
            + '<div class="adm-tr-widget-box">'
            + '  <div class="adm-tr-head">'
            + '    <div class="adm-tr-title">' + escapeHtml(title) + '</div>'
            + '    <div class="adm-tr-head-actions">'
            + '      <button type="button" class="adm-btn adm-btn-ghost js-translation-toggle">' + escapeHtml(msg('open', '번역 보기')) + '</button>'
            + '    </div>'
            + '  </div>'
            + '  <div class="adm-tr-body js-translation-body">'
            + '    <div class="adm-tr-toolbar">'
            + '      <select class="adm-input js-translation-select"><option value="">' + escapeHtml(msg('none', '생성된 번역본 없음')) + '</option></select>'
            + '      <button type="button" class="adm-btn adm-btn-ghost js-translation-refresh">' + escapeHtml(msg('refresh', '새로고침')) + '</button>'
            + '      <button type="button" class="adm-btn adm-btn-ghost js-translation-create-toggle">' + escapeHtml(msg('createNew', '새로 만들기')) + '</button>'
            + '    </div>'
            + '    <div class="adm-tr-create js-create-box">'
            + '      <div class="adm-tr-create-grid">'
            + '        <div><label class="adm-tr-label">' + escapeHtml(msg('sourceLang', '소스 언어')) + '</label><select class="adm-input js-create-source-lang">' + langOptions(defaultSourceLang) + '</select></div>'
            + '        <div><label class="adm-tr-label">' + escapeHtml(msg('targetLang', '타겟 언어')) + '</label><select class="adm-input js-create-target-lang">' + langOptions('en') + '</select></div>'
            + '      </div>'
            + '      <div class="adm-tr-row"><label class="adm-tr-label">' + escapeHtml(msg('title', '제목')) + '</label><input type="text" class="adm-input js-create-title" placeholder="' + escapeHtml(msg('titlePlaceholder', '예: ko→en 번역안')) + '"></div>'
            + '      <label class="adm-tr-check"><input type="checkbox" class="js-create-auto" checked> ' + escapeHtml(msg('autoGenerate', '자동 번역으로 초안 생성')) + '</label>'
            + '      <div class="adm-tr-row js-create-manual-wrap" style="display:none;"><label class="adm-tr-label">' + escapeHtml(msg('initialText', '초기 번역문')) + '</label><textarea class="adm-input adm-tr-note js-create-translated-text"></textarea></div>'
            + '      <div class="adm-tr-actions"><button type="button" class="adm-btn adm-btn-primary js-create-submit">' + escapeHtml(msg('create', '생성')) + '</button></div>'
            + '    </div>'
            + '    <div class="js-translation-detail"><div class="adm-tr-empty">' + escapeHtml(msg('collapsedHint', '버튼을 눌러 번역 목록을 확인')) + '</div></div>'
            + '  </div>'
            + '</div>';
    }

    function langOptions(selectedValue) {
        const langs = i18n.languages || {
            ko: '한국어',
            en: 'English',
            ja: '日本語',
            zh: '中文'
        };
        return Object.keys(langs).map(function (code) {
            const selected = code === selectedValue ? ' selected' : '';
            return '<option value="' + escapeHtml(code) + '"' + selected + '>' + escapeHtml(langs[code]) + '</option>';
        }).join('');
    }

    function mountWidget(widget) {
        if (!widget || widget.dataset.translationMounted === 'true') return;
        createMarkup(widget);
        bind(widget);
        widget.dataset.translationMounted = 'true';
    }

    function scan(root) {
        (root || document).querySelectorAll('.js-admin-translation-widget').forEach(mountWidget);
    }

    window.TripAdminTranslation = {
        scan: scan,
        mount: mountWidget
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function () {
            scan(document);
        });
    } else {
        scan(document);
    }
})(window, document);
