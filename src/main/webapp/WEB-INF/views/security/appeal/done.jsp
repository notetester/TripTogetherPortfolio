<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageLang}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="security.appeal.done.pageTitle"/></title>
    <style>
        body { margin:0; min-height:100vh; display:flex; align-items:center; justify-content:center; background:#f8fafc; font-family:Arial,'Noto Sans KR',sans-serif; color:#0f172a; }
        .card { width:min(620px, calc(100vw - 32px)); background:#fff; border:1px solid #e2e8f0; border-radius:22px; padding:34px; box-shadow:0 24px 70px rgba(15,23,42,.12); }
        h1 { margin:0 0 10px; font-size:28px; }
        .code { display:inline-block; margin:18px 0; padding:12px 16px; background:#eff6ff; color:#1e3a8a; border-radius:12px; font-weight:800; }
        p { color:#475569; line-height:1.7; }
        a { display:inline-block; margin-top:18px; padding:12px 18px; border-radius:12px; background:#2563eb; color:#fff; text-decoration:none; font-weight:800; }
    </style>
</head>
<body>
<main class="card">
    <h1><spring:message code="security.appeal.done.title"/></h1>
    <p><spring:message code="security.appeal.done.lead"/></p>
    <div class="code">${publicRequestId}</div>
    <p><spring:message code="security.appeal.done.notice"/></p>
    <a href="${pageContext.request.contextPath}/"><spring:message code="security.appeal.done.home"/></a>
</main>
</body>
</html>
