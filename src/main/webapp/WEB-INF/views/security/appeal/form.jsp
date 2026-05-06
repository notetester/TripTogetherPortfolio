<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:message var="autoMsg_db9969780f" code="security.appeal.form.pageTitle"/>
<spring:message var="autoMsg_5d9ea3680e" code="security.appeal.form.title"/>
<spring:message var="autoMsg_ced9213acd" code="security.appeal.form.lead"/>
<spring:message var="autoMsg_1f97b571d8" code="security.appeal.form.targetType"/>
<spring:message var="autoMsg_0aeb9b30b2" code="security.appeal.form.targetKey"/>
<spring:message var="autoMsg_082be46783" code="security.appeal.form.requestId"/>
<spring:message var="autoMsg_e726797710" code="security.appeal.form.blockType"/>
<spring:message var="autoMsg_bb513b5431" code="security.appeal.form.email"/>
<spring:message var="autoMsg_e9c2993818" code="security.appeal.form.emailVerifiedNotice"/>
<spring:message var="autoMsg_432d443576" code="security.appeal.form.subject"/>
<spring:message var="autoMsg_dd9033de5f" code="security.appeal.form.content"/>
<spring:message var="autoMsg_e1d574d193" code="security.appeal.form.submit"/>
<spring:message var="autoMsg_3de0f832fb" code="security.appeal.form.home"/>
<spring:message var="autoMsg_bdaabae369" code="security.appeal.form.notice"/>
<spring:message var="autoMsg_1bbb553caa" code="security.appeal.form.duplicateNotice"/>
<spring:message var="emailPlaceholder" code="security.appeal.form.email.placeholder"/>
<spring:message var="defaultTitle" code="security.appeal.form.defaultTitle"/>
<spring:message var="contentPlaceholder" code="security.appeal.form.content.placeholder"/>
<!DOCTYPE html>
<html lang="${pageLang}">
<head>
    <meta charset="UTF-8">
    <title>${autoMsg_db9969780f}</title>
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
    <h1>${autoMsg_5d9ea3680e}</h1>
    <p class="lead">${autoMsg_ced9213acd}</p>

    <c:if test="${not form.valid}">
        <div class="error"><c:out value="${form.errorMessage}"/></div>
    </c:if>

    <c:if test="${form.valid}">
        <div class="info">
            <div><strong>${autoMsg_1f97b571d8}</strong>: <c:out value="${form.targetType}" default="-"/></div>
            <div><strong>${autoMsg_0aeb9b30b2}</strong>: <c:out value="${form.targetKey}" default="-"/></div>
            <div><strong>${autoMsg_082be46783}</strong>: <c:out value="${form.requestId}" default="-"/></div>
            <div><strong>${autoMsg_e726797710}</strong>: <c:out value="${form.blockKind}" default="-"/> / <c:out value="${form.blockMatchType}" default="-"/></div>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/security/appeal">
            <input type="hidden" name="token" value="${fn:escapeXml(token)}">
            <input type="hidden" name="requestId" value="${fn:escapeXml(requestId)}">
            <input type="hidden" name="lang" value="${fn:escapeXml(pageLang)}">

            <label>${autoMsg_bb513b5431}
                <input type="email" name="submitterEmail" value="${fn:escapeXml(form.submitterEmail)}" readonly>
            </label>
            <p class="note">${autoMsg_e9c2993818}</p>

            <label>${autoMsg_432d443576}
                <input type="text" name="appealTitle" required maxlength="200" value="${defaultTitle}">
            </label>

            <label>${autoMsg_dd9033de5f}
                <textarea name="appealContent" required maxlength="2000" placeholder="${contentPlaceholder}"></textarea>
            </label>

            <div class="actions">
                <button type="submit">${autoMsg_e1d574d193}</button>
                <a class="btn" href="${pageContext.request.contextPath}/">${autoMsg_3de0f832fb}</a>
            </div>
        </form>
    </c:if>

    <p class="note">${autoMsg_bdaabae369}</p>
    <p class="note">${autoMsg_1bbb553caa}</p>
</main>
</body>
</html>
