<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_c3936114df" code="admin.moderation.pageTitle"/>
<spring:message var="autoMsg_96a93203b0" code="admin.moderation.level.strict"/>
<spring:message var="autoMsg_8ed47f339d" code="admin.moderation.level.normal"/>
<spring:message var="autoMsg_6dde51bcc4" code="admin.moderation.level.loose"/>
<spring:message var="autoMsg_8aca983c16" code="admin.moderation.postSpamTitle"/>
<spring:message var="autoMsg_b4766eeb4b" code="admin.moderation.commentSpamTitle"/>
<spring:message var="autoMsg_44f199c773" code="admin.moderation.inquirySpamTitle"/>
<spring:message var="autoMsg_f1a97dfed7" code="admin.moderation.reportThresholdTitle"/>
<spring:message var="autoMsg_4972e1d1fe" code="admin.common.save"/>
<spring:message var="autoMsg_ae9743ff42" code="admin.moderation.resetDefaults"/>
<c:set var="activeMenu" value="moderation"/>
<spring:message code="admin.moderation.pageTitle" var="adminModerationPageTitle"/>
<spring:message code="admin.moderation.saved" var="adminModerationSaved"/>
<spring:message code="admin.moderation.saveFailed" var="adminModerationSaveFailed"/>
<spring:message code="admin.moderation.requestFailed" var="adminModerationRequestFailed"/>
<spring:message code="admin.moderation.confirmReset" var="adminModerationConfirmReset"/>
<c:set var="pageTitle" value="${adminModerationPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <div class="adm-card" style="max-width:680px;">
        <div class="adm-card-head">
            <div class="adm-card-title">${autoMsg_c3936114df}</div>
            <div style="font-size:12px;color:#64748b;">
                <c:if test="${not empty policy.updatedAt}">
                    <spring:message code="admin.moderation.updatedAt"/> <fmt:formatDate value="${policy.updatedAtDate}" type="both" dateStyle="short" timeStyle="short"/>
                </c:if>
            </div>
        </div>

        <div class="adm-card-body">
            <form id="moderationForm" style="display:flex;flex-direction:column;gap:24px;">

                <%-- ▸ 악성 콘텐츠 감지 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">
                        <spring:message code="admin.moderation.toxicityTitle"/>
                    </div>
                    <div style="font-size:12px;color:#64748b;margin-bottom:10px;">
                        <spring:message code="admin.moderation.toxicityDescription"/>
                    </div>
                    <select name="toxicityLevel" class="adm-input" style="max-width:220px;">
                        <option value="STRICT" ${policy.toxicityLevel eq 'STRICT' ? 'selected' : ''}>${autoMsg_96a93203b0}</option>
                        <option value="NORMAL" ${policy.toxicityLevel eq 'NORMAL' ? 'selected' : ''}>${autoMsg_8ed47f339d}</option>
                        <option value="LOOSE"  ${policy.toxicityLevel eq 'LOOSE'  ? 'selected' : ''}>${autoMsg_6dde51bcc4}</option>
                    </select>
                </div>

                <%-- ▸ 게시글 도배 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">${autoMsg_8aca983c16}</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="postWindowMinutes" min="1" max="1440"
                               value="${policy.postWindowMinutes}" class="adm-input" style="width:80px;"/>
                        <spring:message code="admin.moderation.minutesWithin"/>
                        <input type="number" name="postMaxCount" min="1" max="100"
                               value="${policy.postMaxCount}" class="adm-input" style="width:80px;"/>
                        <spring:message code="admin.moderation.blockAfterCount"/>
                    </div>
                </div>

                <%-- ▸ 댓글 도배 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">${autoMsg_b4766eeb4b}</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="commentWindowMinutes" min="1" max="1440"
                               value="${policy.commentWindowMinutes}" class="adm-input" style="width:80px;"/>
                        <spring:message code="admin.moderation.minutesWithin"/>
                        <input type="number" name="commentMaxCount" min="1" max="100"
                               value="${policy.commentMaxCount}" class="adm-input" style="width:80px;"/>
                        <spring:message code="admin.moderation.blockAfterCount"/>
                    </div>
                </div>

                <%-- ▸ 문의 도배 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">${autoMsg_44f199c773}</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="inquiryWindowMinutes" min="1" max="1440"
                               value="${policy.inquiryWindowMinutes}" class="adm-input" style="width:80px;"/>
                        <spring:message code="admin.moderation.minutesWithin"/>
                        <input type="number" name="inquiryMaxCount" min="1" max="100"
                               value="${policy.inquiryMaxCount}" class="adm-input" style="width:80px;"/>
                        <spring:message code="admin.moderation.blockAfterCount"/>
                    </div>
                </div>

                <%-- ▸ 신고 누적 BLUR 임계값 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">${autoMsg_f1a97dfed7}</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="reportThreshold" min="1" max="100"
                               value="${policy.reportThreshold}" class="adm-input" style="width:80px;"/>
                        <spring:message code="admin.moderation.blurAfterCount"/>
                    </div>
                </div>

                <div style="display:flex;gap:8px;border-top:1px solid #1e2736;padding-top:16px;">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveModeration()">${autoMsg_4972e1d1fe}</button>
                    <button type="button" class="adm-btn adm-btn-ghost" onclick="resetDefaults()">${autoMsg_ae9743ff42}</button>
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
var adminModerationSaved = '${fn:escapeXml(adminModerationSaved)}';
var adminModerationSaveFailed = '${fn:escapeXml(adminModerationSaveFailed)}';
var adminModerationRequestFailed = '${fn:escapeXml(adminModerationRequestFailed)}';
var adminModerationConfirmReset = '${fn:escapeXml(adminModerationConfirmReset)}';
</script>

<%@ include file="../layout-close.jsp" %>
