<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_appeal_form_email_placeholder" code="security.appeal.form.email.placeholder"/>
<spring:message var="msg_security_appeal_result_pageTitle" code="security.appeal.result.pageTitle"/>
<spring:message var="msg_security_appeal_result_title" code="security.appeal.result.title"/>
<spring:message var="msg_security_appeal_result_lead" code="security.appeal.result.lead"/>
<spring:message var="msg_security_appeal_result_publicRequestId" code="security.appeal.result.publicRequestId"/>
<spring:message var="msg_security_appeal_form_email" code="security.appeal.form.email"/>
<spring:message var="msg_security_appeal_result_submit" code="security.appeal.result.submit"/>
<spring:message var="msg_security_appeal_result_status" code="security.appeal.result.status"/>
<spring:message var="msg_security_appeal_form_subject" code="security.appeal.form.subject"/>
<spring:message var="msg_security_appeal_result_reviewComment" code="security.appeal.result.reviewComment"/>
<spring:message var="msg_security_appeal_result_notice" code="security.appeal.result.notice"/>
<!DOCTYPE html>
<html lang="${pageLang}">
<head>
    <meta charset="UTF-8">
    <title>${msg_security_appeal_result_pageTitle}</title>
    <style>
        body { margin:0; min-height:100vh; display:flex; align-items:center; justify-content:center; background:#f8fafc; font-family:Arial,'Noto Sans KR',sans-serif; color:#0f172a; }
        .card { width:min(680px, calc(100vw - 32px)); background:#fff; border:1px solid #e2e8f0; border-radius:22px; padding:34px; box-shadow:0 24px 70px rgba(15,23,42,.12); }
        h1 { margin:0 0 10px; font-size:28px; }
        p { color:#475569; line-height:1.7; }
        .info { background:#f1f5f9; border-radius:14px; padding:16px; margin:18px 0; font-size:14px; }
        .info div { margin:6px 0; }
        label { display:block; font-weight:700; margin-top:16px; }
        input { width:100%; box-sizing:border-box; border:1px solid #cbd5e1; border-radius:12px; padding:12px; margin-top:6px; font-size:14px; }
        button, .btn { display:inline-block; border:0; border-radius:12px; padding:12px 18px; font-weight:800; cursor:pointer; text-decoration:none; }
        button { background:#2563eb; color:#fff; margin-top:18px; }
        .btn { background:#e2e8f0; color:#0f172a; margin-top:18px; }
        .error { padding:14px; border-radius:12px; background:#fef2f2; color:#991b1b; margin-top:16px; }
        .status { display:inline-block; margin:12px 0; padding:8px 12px; border-radius:999px; background:#eff6ff; color:#1e3a8a; font-weight:800; }
        .note { color:#64748b; font-size:12px; line-height:1.6; margin-top:14px; }
    </style>
</head>
<body>
<main class="card">
    <h1>${msg_security_appeal_result_title}</h1>
    <p>${msg_security_appeal_result_lead}</p>

    <c:if test="${not empty errorMessage}">
        <div class="error"><c:out value="${errorMessage}"/></div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/security/appeal/result">
        <input type="hidden" name="lang" value="${fn:escapeXml(pageLang)}"/>
        <label>${msg_security_appeal_result_publicRequestId}
            <input type="text" name="publicRequestId" required maxlength="40" value="${fn:escapeXml(publicRequestId)}">
        </label>
        <label>${msg_security_appeal_form_email}
            <input type="email" name="submitterEmail" required maxlength="320" placeholder="${msg_security_appeal_form_email_placeholder}">
        </label>
        <button type="submit">${msg_security_appeal_result_submit}</button>
    </form>

    <c:if test="${not empty appeal}">
        <div class="info">
            <div><strong>${msg_security_appeal_result_publicRequestId}</strong>: <c:out value="${appeal.publicRequestId}"/></div>
            <div><strong>${msg_security_appeal_result_status}</strong>: <span class="status"><c:out value="${appeal.appealStatus}"/></span></div>
            <div><strong>${msg_security_appeal_form_subject}</strong>: <c:out value="${appeal.appealTitle}"/></div>
            <c:if test="${not empty appeal.reviewComment}">
                <div><strong>${msg_security_appeal_result_reviewComment}</strong>: <c:out value="${appeal.reviewComment}"/></div>
            </c:if>
        </div>
    </c:if>

    <p class="note">${msg_security_appeal_result_notice}</p>
</main>
</body>
</html>
