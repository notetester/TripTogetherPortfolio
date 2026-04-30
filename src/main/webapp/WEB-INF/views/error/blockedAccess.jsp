<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>접근 제한 - TripTogether</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans KR", sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #eef2ff 100%);
            color: #0f172a;
        }
        .blocked-card {
            width: min(720px, calc(100vw - 32px));
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 28px;
            box-shadow: 0 24px 70px rgba(15, 23, 42, 0.14);
            padding: 34px;
        }
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 7px 12px;
            border-radius: 999px;
            background: #fee2e2;
            color: #991b1b;
            font-weight: 800;
            font-size: 13px;
            letter-spacing: -.01em;
        }
        h1 {
            margin: 22px 0 10px;
            font-size: 30px;
            line-height: 1.25;
            letter-spacing: -.04em;
        }
        .lead {
            margin: 0 0 24px;
            color: #475569;
            line-height: 1.75;
            font-size: 15px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: 150px 1fr;
            border: 1px solid #e5e7eb;
            border-radius: 18px;
            overflow: hidden;
            background: #f8fafc;
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
            background: #f1f5f9;
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
    </style>
</head>
<body>
<main class="blocked-card">
    <span class="badge">보안 정책 차단</span>
    <h1>접근이 제한되었습니다.</h1>
    <p class="lead">
        현재 요청은 TripTogether 보안 정책에 의해 차단되었습니다.
        반복 로그인 실패, 계정 차단, IP/CIDR/RANGE/COUNTRY/ASN 정책 등 운영자가 설정한 규칙이 적용되었을 수 있습니다.
        문의가 필요한 경우 아래 요청 ID를 관리자에게 전달해 주세요.
    </p>

    <dl class="info-grid">
        <dt>요청 ID</dt>
        <dd><c:out value="${requestId}" default="-"/></dd>
        <dt>차단 유형</dt>
        <dd><c:out value="${blockKind}" default="-"/> / <c:out value="${matchType}" default="-"/></dd>
        <dt>대상 키</dt>
        <dd><c:out value="${targetKey}" default="-"/></dd>
        <dt>접속 IP</dt>
        <dd><c:out value="${clientIp}" default="-"/></dd>
        <dt>국가 / ASN</dt>
        <dd><c:out value="${countryCode}" default="-"/> / <c:out value="${asn}" default="-"/></dd>
        <dt>사유</dt>
        <dd><c:out value="${reason}" default="보안 정책에 의해 접근이 제한되었습니다."/></dd>
    </dl>

    <div class="actions">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/">메인으로 이동</a>
        <a class="btn" href="${pageContext.request.contextPath}/inquiry/list">문의하기</a>
    </div>
    <p class="note">
        대량 트래픽 공격은 CDN/WAF/Nginx 등 앞단 계층에서 완화하고,
        이 화면은 애플리케이션 내부의 정밀 차단 정책이 적용된 요청에 표시됩니다.
    </p>
</main>
</body>
</html>
