<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_c034956397" code="security.appeal.verify.sent.pageTitle"/>
<spring:message var="autoMsg_4d867dbbaf" code="security.appeal.verify.sent.title"/>
<spring:message var="autoMsg_626346688b" code="security.appeal.verify.sent.lead"/>
<spring:message var="autoMsg_66b394c1c3" code="security.appeal.verify.sent.notice"/>
<spring:message var="autoMsg_89082c8d92" code="security.appeal.done.home"/>
<!DOCTYPE html>
<html lang="${pageLang}">
<head>
    <meta charset="UTF-8">
    <title>${autoMsg_c034956397}</title>
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
    <h1>${autoMsg_4d867dbbaf}</h1>
    <p>${autoMsg_626346688b}</p>
    <p class="note">${autoMsg_66b394c1c3}</p>
    <a class="btn" href="${pageContext.request.contextPath}/">${autoMsg_89082c8d92}</a>
</main>
</body>
</html>
