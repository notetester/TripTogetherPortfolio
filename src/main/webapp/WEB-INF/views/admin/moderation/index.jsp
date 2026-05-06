<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_moderation_pageTitle" code="admin.moderation.pageTitle"/>
<spring:message var="msg_admin_moderation_saved" code="admin.moderation.saved"/>
<spring:message var="msg_admin_moderation_saveFailed" code="admin.moderation.saveFailed"/>
<spring:message var="msg_admin_moderation_requestFailed" code="admin.moderation.requestFailed"/>
<spring:message var="msg_admin_moderation_confirmReset" code="admin.moderation.confirmReset"/>
<spring:message var="msg_admin_moderation_updatedAt" code="admin.moderation.updatedAt"/>
<spring:message var="msg_admin_moderation_toxicityTitle" code="admin.moderation.toxicityTitle"/>
<spring:message var="msg_admin_moderation_toxicityDescription" code="admin.moderation.toxicityDescription"/>
<spring:message var="msg_admin_moderation_level_strict" code="admin.moderation.level.strict"/>
<spring:message var="msg_admin_moderation_level_normal" code="admin.moderation.level.normal"/>
<spring:message var="msg_admin_moderation_level_loose" code="admin.moderation.level.loose"/>
<spring:message var="msg_admin_moderation_postSpamTitle" code="admin.moderation.postSpamTitle"/>
<spring:message var="msg_admin_moderation_minutesWithin" code="admin.moderation.minutesWithin"/>
<spring:message var="msg_admin_moderation_blockAfterCount" code="admin.moderation.blockAfterCount"/>
<spring:message var="msg_admin_moderation_commentSpamTitle" code="admin.moderation.commentSpamTitle"/>
<spring:message var="msg_admin_moderation_inquirySpamTitle" code="admin.moderation.inquirySpamTitle"/>
<spring:message var="msg_admin_moderation_reportThresholdTitle" code="admin.moderation.reportThresholdTitle"/>
<spring:message var="msg_admin_moderation_blurAfterCount" code="admin.moderation.blurAfterCount"/>
<spring:message var="msg_admin_common_save" code="admin.common.save"/>
<spring:message var="msg_admin_moderation_resetDefaults" code="admin.moderation.resetDefaults"/>
<c:set var="activeMenu" value="moderation"/>


<c:set var="pageTitle" value="${msg_admin_moderation_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <div class="adm-card" style="max-width:680px;">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_moderation_pageTitle}</div>
            <div style="font-size:12px;color:#64748b;">
                <c:if test="${not empty policy.updatedAt}">
                    ${msg_admin_moderation_updatedAt} <fmt:formatDate value="${policy.updatedAtDate}" type="both" dateStyle="short" timeStyle="short"/>
                </c:if>
            </div>
        </div>

        <div class="adm-card-body">
            <form id="moderationForm" style="display:flex;flex-direction:column;gap:24px;">

                <%-- ▸ 악성 콘텐츠 감지 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">
                        ${msg_admin_moderation_toxicityTitle}
                    </div>
                    <div style="font-size:12px;color:#64748b;margin-bottom:10px;">
                        ${msg_admin_moderation_toxicityDescription}
                    </div>
                    <select name="toxicityLevel" class="adm-input" style="max-width:220px;">
                        <option value="STRICT" ${policy.toxicityLevel eq 'STRICT' ? 'selected' : ''}>${msg_admin_moderation_level_strict}</option>
                        <option value="NORMAL" ${policy.toxicityLevel eq 'NORMAL' ? 'selected' : ''}>${msg_admin_moderation_level_normal}</option>
                        <option value="LOOSE"  ${policy.toxicityLevel eq 'LOOSE'  ? 'selected' : ''}>${msg_admin_moderation_level_loose}</option>
                    </select>
                </div>

                <%-- ▸ 게시글 도배 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">${msg_admin_moderation_postSpamTitle}</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="postWindowMinutes" min="1" max="1440"
                               value="${policy.postWindowMinutes}" class="adm-input" style="width:80px;"/>
                        ${msg_admin_moderation_minutesWithin}
                        <input type="number" name="postMaxCount" min="1" max="100"
                               value="${policy.postMaxCount}" class="adm-input" style="width:80px;"/>
                        ${msg_admin_moderation_blockAfterCount}
                    </div>
                </div>

                <%-- ▸ 댓글 도배 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">${msg_admin_moderation_commentSpamTitle}</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="commentWindowMinutes" min="1" max="1440"
                               value="${policy.commentWindowMinutes}" class="adm-input" style="width:80px;"/>
                        ${msg_admin_moderation_minutesWithin}
                        <input type="number" name="commentMaxCount" min="1" max="100"
                               value="${policy.commentMaxCount}" class="adm-input" style="width:80px;"/>
                        ${msg_admin_moderation_blockAfterCount}
                    </div>
                </div>

                <%-- ▸ 문의 도배 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">${msg_admin_moderation_inquirySpamTitle}</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="inquiryWindowMinutes" min="1" max="1440"
                               value="${policy.inquiryWindowMinutes}" class="adm-input" style="width:80px;"/>
                        ${msg_admin_moderation_minutesWithin}
                        <input type="number" name="inquiryMaxCount" min="1" max="100"
                               value="${policy.inquiryMaxCount}" class="adm-input" style="width:80px;"/>
                        ${msg_admin_moderation_blockAfterCount}
                    </div>
                </div>

                <%-- ▸ 신고 누적 BLUR 임계값 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">${msg_admin_moderation_reportThresholdTitle}</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="reportThreshold" min="1" max="100"
                               value="${policy.reportThreshold}" class="adm-input" style="width:80px;"/>
                        ${msg_admin_moderation_blurAfterCount}
                    </div>
                </div>

                <div style="display:flex;gap:8px;border-top:1px solid #1e2736;padding-top:16px;">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveModeration()">${msg_admin_common_save}</button>
                    <button type="button" class="adm-btn adm-btn-ghost" onclick="resetDefaults()">${msg_admin_moderation_resetDefaults}</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';

function saveModeration() {
    var form = document.getElementById('moderationForm');
    var fd   = new FormData(form);
    var body = new URLSearchParams();
    fd.forEach(function(v, k) { body.append(k, v); });

    fetch(ctx + '/admin/moderation/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body.toString()
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) {
            alert(adminModerationSaved);
            location.reload();
        } else {
            alert(d.message || adminModerationSaveFailed);
        }
    }).catch(function() { alert(adminModerationRequestFailed); });
}

function resetDefaults() {
    if (!confirm(adminModerationConfirmReset)) return;
    var form = document.getElementById('moderationForm');
    form.toxicityLevel.value        = 'NORMAL';
    form.postWindowMinutes.value    = 5;
    form.postMaxCount.value         = 3;
    form.commentWindowMinutes.value = 1;
    form.commentMaxCount.value      = 5;
    form.inquiryWindowMinutes.value = 10;
    form.inquiryMaxCount.value      = 3;
    form.reportThreshold.value      = 3;
}
var adminModerationSaved = '${fn:escapeXml(msg_admin_moderation_saved)}';
var adminModerationSaveFailed = '${fn:escapeXml(msg_admin_moderation_saveFailed)}';
var adminModerationRequestFailed = '${fn:escapeXml(msg_admin_moderation_requestFailed)}';
var adminModerationConfirmReset = '${fn:escapeXml(msg_admin_moderation_confirmReset)}';
</script>

<%@ include file="../layout-close.jsp" %>
