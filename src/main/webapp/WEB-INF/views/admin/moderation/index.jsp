<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
            <div class="adm-card-title"><spring:message code="admin.moderation.pageTitle"/></div>
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
                        <option value="STRICT" ${policy.toxicityLevel eq 'STRICT' ? 'selected' : ''}><spring:message code="admin.moderation.level.strict"/></option>
                        <option value="NORMAL" ${policy.toxicityLevel eq 'NORMAL' ? 'selected' : ''}><spring:message code="admin.moderation.level.normal"/></option>
                        <option value="LOOSE"  ${policy.toxicityLevel eq 'LOOSE'  ? 'selected' : ''}><spring:message code="admin.moderation.level.loose"/></option>
                    </select>
                </div>

                <%-- ▸ 게시글 도배 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;"><spring:message code="admin.moderation.postSpamTitle"/></div>
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
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;"><spring:message code="admin.moderation.commentSpamTitle"/></div>
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
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;"><spring:message code="admin.moderation.inquirySpamTitle"/></div>
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
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;"><spring:message code="admin.moderation.reportThresholdTitle"/></div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="reportThreshold" min="1" max="100"
                               value="${policy.reportThreshold}" class="adm-input" style="width:80px;"/>
                        <spring:message code="admin.moderation.blurAfterCount"/>
                    </div>
                </div>

                <div style="display:flex;gap:8px;border-top:1px solid #1e2736;padding-top:16px;">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveModeration()"><spring:message code="admin.common.save"/></button>
                    <button type="button" class="adm-btn adm-btn-ghost" onclick="resetDefaults()"><spring:message code="admin.moderation.resetDefaults"/></button>
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
