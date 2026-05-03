<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageLang}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="security.appeal.form.pageTitle"/></title>
    <style>
        body { margin:0; min-height:100vh; display:flex; align-items:center; justify-content:center; background:#f8fafc; font-family:Arial,'Noto Sans KR',sans-serif; color:#0f172a; }
        .card { width:min(720px, calc(100vw - 32px)); background:#fff; border:1px solid #e2e8f0; border-radius:22px; padding:34px; box-shadow:0 24px 70px rgba(15,23,42,.12); }
        h1 { margin:0 0 10px; font-size:28px; }
        .lead { color:#475569; line-height:1.7; }
        .info { background:#f1f5f9; border-radius:14px; padding:16px; margin:18px 0; font-size:14px; }
        .info div { margin:6px 0; }
        label { display:block; font-weight:700; margin-top:16px; }
        input, textarea { width:100%; box-sizing:border-box; border:1px solid #cbd5e1; border-radius:12px; padding:12px; margin-top:6px; font-size:14px; }
        textarea { min-height:160px; resize:vertical; }
        .actions { display:flex; gap:10px; margin-top:20px; }
        button, .btn { border:0; border-radius:12px; padding:12px 18px; font-weight:800; cursor:pointer; text-decoration:none; }
        button { background:#2563eb; color:#fff; }
        .btn { background:#e2e8f0; color:#0f172a; }
        .error { padding:14px; border-radius:12px; background:#fef2f2; color:#991b1b; margin-top:16px; }
        .note { color:#64748b; font-size:12px; line-height:1.6; margin-top:14px; }
    </style>
</head>
<body>
<main class="card">
    <h1><spring:message code="security.appeal.form.title"/></h1>
    <p class="lead"><spring:message code="security.appeal.form.lead"/></p>

    <c:if test="${not form.valid}">
        <div class="error">${form.errorMessage}</div>
    </c:if>

    <c:if test="${form.valid}">
        <div class="info">
            <div><strong><spring:message code="security.appeal.form.targetType"/></strong>: <c:out value="${form.targetType}" default="-"/></div>
            <div><strong><spring:message code="security.appeal.form.targetKey"/></strong>: <c:out value="${form.targetKey}" default="-"/></div>
            <div><strong><spring:message code="security.appeal.form.requestId"/></strong>: <c:out value="${form.requestId}" default="-"/></div>
            <div><strong><spring:message code="security.appeal.form.blockType"/></strong>: <c:out value="${form.blockKind}" default="-"/> / <c:out value="${form.blockMatchType}" default="-"/></div>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/security/appeal">
            <input type="hidden" name="token" value="${token}">
            <input type="hidden" name="requestId" value="${requestId}">
            <input type="hidden" name="lang" value="${pageLang}">

            <label><spring:message code="security.appeal.form.email"/>
                <input type="email" name="submitterEmail" placeholder="<spring:message code='security.appeal.form.email.placeholder'/>">
            </label>

            <label><spring:message code="security.appeal.form.subject"/>
                <input type="text" name="appealTitle" required maxlength="200" value="<spring:message code='security.appeal.form.defaultTitle'/>">
            </label>

            <label><spring:message code="security.appeal.form.content"/>
                <textarea name="appealContent" required maxlength="2000" placeholder="<spring:message code='security.appeal.form.content.placeholder'/>"></textarea>
            </label>

            <div class="actions">
                <button type="submit"><spring:message code="security.appeal.form.submit"/></button>
                <a class="btn" href="${pageContext.request.contextPath}/"><spring:message code="security.appeal.form.home"/></a>
            </div>
        </form>
    </c:if>

    <p class="note"><spring:message code="security.appeal.form.notice"/></p>
</main>
</body>
</html>
