<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<spring:message var="emailPlaceholder" code="security.appeal.form.email.placeholder"/>
<!DOCTYPE html>
<html lang="${pageLang}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="security.appeal.verify.pageTitle"/></title>
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
    <h1><spring:message code="security.appeal.verify.title"/></h1>
    <p><spring:message code="security.appeal.verify.lead"/></p>

    <c:if test="${not empty form.errorMessage}">
        <div class="error"><c:out value="${form.errorMessage}"/></div>
    </c:if>

    <c:if test="${form.valid}">
        <div class="info">
            <div><strong><spring:message code="security.appeal.form.requestId"/></strong>: <c:out value="${form.requestId}" default="-"/></div>
            <div><strong><spring:message code="security.appeal.form.blockType"/></strong>: <c:out value="${form.blockKind}" default="-"/> / <c:out value="${form.blockMatchType}" default="-"/></div>
        </div>
        <form method="post" action="${pageContext.request.contextPath}/security/appeal/verify">
            <input type="hidden" name="requestId" value="${fn:escapeXml(requestId)}"/>
            <input type="hidden" name="lang" value="${fn:escapeXml(pageLang)}"/>
            <label><spring:message code="security.appeal.form.email"/>
                <input type="email" name="submitterEmail" required maxlength="320" placeholder="${emailPlaceholder}">
            </label>
            <button type="submit"><spring:message code="security.appeal.verify.submit"/></button>
        </form>
        <p class="note"><spring:message code="security.appeal.verify.notice"/></p>
    </c:if>
    <a class="btn" href="${pageContext.request.contextPath}/security/appeal/result?lang=${fn:escapeXml(pageLang)}"><spring:message code="security.appeal.result.lookupLink"/></a>
</main>
</body>
</html>
