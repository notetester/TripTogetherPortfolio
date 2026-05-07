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
<spring:message var="msg_admin_moderation_totalCountDisplay" code="admin.common.totalCountFormat" arguments="5"/>
<c:set var="activeMenu" value="moderation"/>


<c:set var="pageTitle" value="${msg_admin_moderation_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-moderation-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_admin_moderation_pageTitle}</h1>
            <p class="adm-page-desc">${msg_admin_moderation_toxicityDescription}</p>
        </div>
        <c:if test="${not empty policy.updatedAt}">
            <div class="adm-moderation-updated">
                ${msg_admin_moderation_updatedAt}
                <span><fmt:formatDate value="${policy.updatedAtDate}" type="both" dateStyle="short" timeStyle="short"/></span>
            </div>
        </c:if>
    </div>

    <div class="adm-moderation-dashboard">
        <div class="adm-moderation-metric">
            <span>검열 강도</span>
            <strong>
                <c:choose>
                    <c:when test="${policy.toxicityLevel eq 'STRICT'}">${msg_admin_moderation_level_strict}</c:when>
                    <c:when test="${policy.toxicityLevel eq 'LOOSE'}">${msg_admin_moderation_level_loose}</c:when>
                    <c:otherwise>${msg_admin_moderation_level_normal}</c:otherwise>
                </c:choose>
            </strong>
            <em>${msg_admin_moderation_toxicityTitle}</em>
        </div>
        <div class="adm-moderation-metric">
            <span>게시글 스팸</span>
            <strong>${policy.postMaxCount}</strong>
            <em>${policy.postWindowMinutes}${msg_admin_moderation_minutesWithin}</em>
        </div>
        <div class="adm-moderation-metric">
            <span>댓글 스팸</span>
            <strong>${policy.commentMaxCount}</strong>
            <em>${policy.commentWindowMinutes}${msg_admin_moderation_minutesWithin}</em>
        </div>
        <div class="adm-moderation-metric">
            <span>문의 스팸</span>
            <strong>${policy.inquiryMaxCount}</strong>
            <em>${policy.inquiryWindowMinutes}${msg_admin_moderation_minutesWithin}</em>
        </div>
        <div class="adm-moderation-metric">
            <span>신고 블러</span>
            <strong>${policy.reportThreshold}</strong>
            <em>${msg_admin_moderation_blurAfterCount}</em>
        </div>
    </div>

    <div class="adm-card adm-moderation-rule-table-card">
        <div class="adm-card-head">
            <div class="adm-card-title">악성 콘텐츠 운영 기준</div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table class="adm-table adm-moderation-rule-table">
                    <thead>
                    <tr>
                        <th>정책</th>
                        <th>현재 기준</th>
                        <th>탐지 창</th>
                        <th>처리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>${msg_admin_moderation_toxicityTitle}</td>
                        <td>
                            <c:choose>
                                <c:when test="${policy.toxicityLevel eq 'STRICT'}">${msg_admin_moderation_level_strict}</c:when>
                                <c:when test="${policy.toxicityLevel eq 'LOOSE'}">${msg_admin_moderation_level_loose}</c:when>
                                <c:otherwise>${msg_admin_moderation_level_normal}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>-</td>
                        <td>${msg_admin_moderation_toxicityDescription}</td>
                    </tr>
                    <tr>
                        <td>${msg_admin_moderation_postSpamTitle}</td>
                        <td>${policy.postMaxCount}${msg_admin_moderation_blockAfterCount}</td>
                        <td>${policy.postWindowMinutes}${msg_admin_moderation_minutesWithin}</td>
                        <td>자동 차단 후보</td>
                    </tr>
                    <tr>
                        <td>${msg_admin_moderation_commentSpamTitle}</td>
                        <td>${policy.commentMaxCount}${msg_admin_moderation_blockAfterCount}</td>
                        <td>${policy.commentWindowMinutes}${msg_admin_moderation_minutesWithin}</td>
                        <td>자동 차단 후보</td>
                    </tr>
                    <tr>
                        <td>${msg_admin_moderation_inquirySpamTitle}</td>
                        <td>${policy.inquiryMaxCount}${msg_admin_moderation_blockAfterCount}</td>
                        <td>${policy.inquiryWindowMinutes}${msg_admin_moderation_minutesWithin}</td>
                        <td>관리 검토</td>
                    </tr>
                    <tr>
                        <td>${msg_admin_moderation_reportThresholdTitle}</td>
                        <td>${policy.reportThreshold}${msg_admin_moderation_blurAfterCount}</td>
                        <td>-</td>
                        <td>콘텐츠 블러</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="adm-card adm-moderation-card">
        <div class="adm-card-head">
            <div class="adm-card-title">
                ${msg_admin_moderation_pageTitle}
                <span class="adm-section-total-inline">${msg_admin_moderation_totalCountDisplay}</span>
            </div>
        </div>
        <div class="adm-card-body">
            <form id="moderationForm" class="adm-moderation-form">
                <section class="adm-moderation-section adm-moderation-section-wide">
                    <div class="adm-moderation-section-head">
                        <div class="adm-moderation-section-title">${msg_admin_moderation_toxicityTitle}</div>
                        <div class="adm-muted">${msg_admin_moderation_toxicityDescription}</div>
                    </div>
                    <select name="toxicityLevel" class="adm-select adm-moderation-select">
                        <option value="STRICT" ${policy.toxicityLevel eq 'STRICT' ? 'selected' : ''}>${msg_admin_moderation_level_strict}</option>
                        <option value="NORMAL" ${policy.toxicityLevel eq 'NORMAL' ? 'selected' : ''}>${msg_admin_moderation_level_normal}</option>
                        <option value="LOOSE"  ${policy.toxicityLevel eq 'LOOSE'  ? 'selected' : ''}>${msg_admin_moderation_level_loose}</option>
                    </select>
                </section>

                <section class="adm-moderation-section">
                    <div class="adm-moderation-section-title">${msg_admin_moderation_postSpamTitle}</div>
                    <div class="adm-moderation-rule-row">
                        <label class="adm-moderation-number-chip">
                            <input type="number" name="postWindowMinutes" min="1" max="1440"
                                   value="${policy.postWindowMinutes}" class="adm-input adm-moderation-number"/>
                            <span>${msg_admin_moderation_minutesWithin}</span>
                        </label>
                        <label class="adm-moderation-number-chip">
                            <input type="number" name="postMaxCount" min="1" max="100"
                                   value="${policy.postMaxCount}" class="adm-input adm-moderation-number"/>
                            <span>${msg_admin_moderation_blockAfterCount}</span>
                        </label>
                    </div>
                </section>

                <section class="adm-moderation-section">
                    <div class="adm-moderation-section-title">${msg_admin_moderation_commentSpamTitle}</div>
                    <div class="adm-moderation-rule-row">
                        <label class="adm-moderation-number-chip">
                            <input type="number" name="commentWindowMinutes" min="1" max="1440"
                                   value="${policy.commentWindowMinutes}" class="adm-input adm-moderation-number"/>
                            <span>${msg_admin_moderation_minutesWithin}</span>
                        </label>
                        <label class="adm-moderation-number-chip">
                            <input type="number" name="commentMaxCount" min="1" max="100"
                                   value="${policy.commentMaxCount}" class="adm-input adm-moderation-number"/>
                            <span>${msg_admin_moderation_blockAfterCount}</span>
                        </label>
                    </div>
                </section>

                <section class="adm-moderation-section">
                    <div class="adm-moderation-section-title">${msg_admin_moderation_inquirySpamTitle}</div>
                    <div class="adm-moderation-rule-row">
                        <label class="adm-moderation-number-chip">
                            <input type="number" name="inquiryWindowMinutes" min="1" max="1440"
                                   value="${policy.inquiryWindowMinutes}" class="adm-input adm-moderation-number"/>
                            <span>${msg_admin_moderation_minutesWithin}</span>
                        </label>
                        <label class="adm-moderation-number-chip">
                            <input type="number" name="inquiryMaxCount" min="1" max="100"
                                   value="${policy.inquiryMaxCount}" class="adm-input adm-moderation-number"/>
                            <span>${msg_admin_moderation_blockAfterCount}</span>
                        </label>
                    </div>
                </section>

                <section class="adm-moderation-section">
                    <div class="adm-moderation-section-title">${msg_admin_moderation_reportThresholdTitle}</div>
                    <div class="adm-moderation-rule-row adm-moderation-rule-row-short">
                        <label class="adm-moderation-number-chip">
                            <input type="number" name="reportThreshold" min="1" max="100"
                                   value="${policy.reportThreshold}" class="adm-input adm-moderation-number"/>
                            <span>${msg_admin_moderation_blurAfterCount}</span>
                        </label>
                    </div>
                </section>

                <div class="adm-moderation-actions">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveModeration()">${msg_admin_common_save}</button>
                    <button type="button" class="adm-btn adm-btn-ghost" onclick="resetDefaults()">${msg_admin_moderation_resetDefaults}</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';

function notifyModeration(message, type) {
    if (window.adm_toast) {
        adm_toast(message, type || 'success');
    } else {
        alert(message);
    }
}

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
            notifyModeration(adminModerationSaved);
            location.reload();
        } else {
            notifyModeration(d.message || adminModerationSaveFailed, 'error');
        }
    }).catch(function() { notifyModeration(adminModerationRequestFailed, 'error'); });
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
