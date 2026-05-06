<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_error_blocked_language" code="error.blocked.language"/>
<spring:message var="msg_error_blocked_pageTitle" code="error.blocked.pageTitle"/>
<spring:message var="msg_error_blocked_badge" code="error.blocked.badge"/>
<spring:message var="msg_error_blocked_title" code="error.blocked.title"/>
<spring:message var="msg_error_blocked_lead" code="error.blocked.lead"/>
<spring:message var="msg_error_blocked_description" code="error.blocked.description"/>
<spring:message var="msg_error_blocked_contact" code="error.blocked.contact"/>
<spring:message var="msg_error_blocked_supportInfo" code="error.blocked.supportInfo"/>
<spring:message var="msg_error_blocked_requestId" code="error.blocked.requestId"/>
<spring:message var="msg_error_blocked_restrictionType" code="error.blocked.restrictionType"/>
<spring:message var="msg_error_blocked_ip" code="error.blocked.ip"/>
<spring:message var="msg_error_blocked_appeal" code="error.blocked.appeal"/>
<spring:message var="msg_error_blocked_home" code="error.blocked.home"/>
<spring:message var="msg_error_blocked_support" code="error.blocked.support"/>
<spring:message var="msg_error_blocked_notice" code="error.blocked.notice"/>
<!DOCTYPE html>
<html lang="${pageLang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${msg_error_blocked_pageTitle}</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans KR", "Noto Sans JP", "Microsoft YaHei", sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #eef2ff 100%);
            color: #0f172a;
        }
        .blocked-card {
            width: min(760px, calc(100vw - 32px));
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 28px;
            box-shadow: 0 24px 70px rgba(15, 23, 42, 0.14);
            padding: 34px;
        }
        .topbar {
            display: flex;
            justify-content: space-between;
            gap: 16px;
            align-items: flex-start;
            flex-wrap: wrap;
        }
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 7px 12px;
            border-radius: 999px;
            background: #eff6ff;
            color: #1d4ed8;
            font-weight: 800;
            font-size: 13px;
            letter-spacing: -.01em;
        }
        .language-switch {
            display: inline-flex;
            gap: 6px;
            padding: 4px;
            border: 1px solid #e5e7eb;
            border-radius: 999px;
            background: #f8fafc;
        }
        .language-switch a {
            min-width: 38px;
            padding: 6px 9px;
            border-radius: 999px;
            text-align: center;
            color: #475569;
            text-decoration: none;
            font-weight: 800;
            font-size: 12px;
        }
        .language-switch a.active {
            background: #1d4ed8;
            color: #fff;
        }
        h1 {
            margin: 22px 0 10px;
            font-size: 30px;
            line-height: 1.25;
            letter-spacing: -.04em;
        }
        .lead {
            margin: 0 0 12px;
            color: #475569;
            line-height: 1.78;
            font-size: 15px;
        }
        .support-box {
            margin-top: 24px;
            padding: 18px;
            border: 1px solid #dbeafe;
            border-radius: 18px;
            background: #f8fbff;
        }
        .support-title {
            margin: 0 0 12px;
            font-size: 14px;
            font-weight: 900;
            color: #1e3a8a;
        }
        .info-grid {
            display: grid;
            grid-template-columns: 155px 1fr;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            overflow: hidden;
            background: #fff;
        }
        .info-grid dt,
        .info-grid dd {
            margin: 0;
            padding: 13px 15px;
            border-bottom: 1px solid #e5e7eb;
            font-size: 13px;
        }
        .info-grid dt {
            color: #64748b;
            font-weight: 800;
            background: #f8fafc;
        }
        .info-grid dd {
            color: #111827;
            word-break: break-all;
        }
        .info-grid dt:last-of-type,
        .info-grid dd:last-of-type { border-bottom: 0; }
        .actions {
            display: flex;
            gap: 10px;
            margin-top: 24px;
            flex-wrap: wrap;
        }
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 42px;
            padding: 0 18px;
            border-radius: 12px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 800;
            border: 1px solid #cbd5e1;
            color: #0f172a;
            background: #fff;
        }
        .btn-primary {
            border-color: #2563eb;
            background: #2563eb;
            color: #fff;
        }
        .note {
            margin-top: 18px;
            color: #64748b;
            font-size: 12px;
            line-height: 1.65;
        }
        @media (max-width: 640px) {
            .blocked-card { padding: 24px; }
            h1 { font-size: 25px; }
            .info-grid { grid-template-columns: 1fr; }
            .info-grid dt { border-bottom: 0; padding-bottom: 4px; }
            .info-grid dd { padding-top: 4px; }
        }
    </style>
</head>
<body>
<c:set var="restrictionTypeCode" value="error.blocked.type.access"/>
<c:if test="${blockKind eq 'USER'}">
    <c:set var="restrictionTypeCode" value="error.blocked.type.account"/>
</c:if>

<c:url var="langKoUrl" value="/blocked-access">
    <c:param name="lang" value="ko"/>
    <c:param name="requestId" value="${requestId}"/>
    <c:param name="blockKind" value="${blockKind}"/>
    <c:param name="clientIp" value="${clientIp}"/>
</c:url>
<c:url var="langEnUrl" value="/blocked-access">
    <c:param name="lang" value="en"/>
    <c:param name="requestId" value="${requestId}"/>
    <c:param name="blockKind" value="${blockKind}"/>
    <c:param name="clientIp" value="${clientIp}"/>
</c:url>
<c:url var="langJaUrl" value="/blocked-access">
    <c:param name="lang" value="ja"/>
    <c:param name="requestId" value="${requestId}"/>
    <c:param name="blockKind" value="${blockKind}"/>
    <c:param name="clientIp" value="${clientIp}"/>
</c:url>
<c:url var="langZhUrl" value="/blocked-access">
    <c:param name="lang" value="zh"/>
    <c:param name="requestId" value="${requestId}"/>
    <c:param name="blockKind" value="${blockKind}"/>
    <c:param name="clientIp" value="${clientIp}"/>
</c:url>

<c:url var="appealUrl" value="/security/appeal/new">
    <c:param name="requestId" value="${requestId}"/>
    <c:param name="lang" value="${pageLang}"/>
</c:url>

<main class="blocked-card">
    <div class="topbar">
        <span class="badge">${msg_error_blocked_badge}</span>
        <nav class="language-switch" aria-label="${msg_error_blocked_language}">
            <a href="${langKoUrl}" class="${pageLang eq 'ko' ? 'active' : ''}">KO</a>
            <a href="${langEnUrl}" class="${pageLang eq 'en' ? 'active' : ''}">EN</a>
            <a href="${langJaUrl}" class="${pageLang eq 'ja' ? 'active' : ''}">JA</a>
            <a href="${langZhUrl}" class="${pageLang eq 'zh' ? 'active' : ''}">ZH</a>
        </nav>
    </div>

    <h1>${msg_error_blocked_title}</h1>
    <p class="lead">${msg_error_blocked_lead}</p>
    <p class="lead">${msg_error_blocked_description}</p>
    <p class="lead">${msg_error_blocked_contact}</p>

    <section class="support-box" aria-labelledby="supportInfoTitle">
        <p id="supportInfoTitle" class="support-title">${msg_error_blocked_supportInfo}</p>
        <dl class="info-grid">
            <dt>${msg_error_blocked_requestId}</dt>
            <dd><c:out value="${requestId}" default="-"/></dd>

            <dt>${msg_error_blocked_restrictionType}</dt>
            <dd><spring:message var="msg_restrictionTypeCode" code="${restrictionTypeCode}"/>${msg_restrictionTypeCode}</dd>

            <dt>${msg_error_blocked_ip}</dt>
            <dd><c:out value="${clientIp}" default="-"/></dd>
        </dl>
    </section>

    <div class="actions">
        <a class="btn btn-primary" href="${appealUrl}">${msg_error_blocked_appeal}</a>
        <a class="btn" href="${pageContext.request.contextPath}/">${msg_error_blocked_home}</a>
        <a class="btn" href="${pageContext.request.contextPath}/inquiry/list">${msg_error_blocked_support}</a>
    </div>

    <p class="note">${msg_error_blocked_notice}</p>
</main>
</body>
</html>
