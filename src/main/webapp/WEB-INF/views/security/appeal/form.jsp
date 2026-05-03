<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="${pageLang}">
<head>
    <meta charset="UTF-8">
    <title>보안 조치 이의제기</title>
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
    <h1>보안 조치 이의제기</h1>
    <p class="lead">
        접근 제한이나 계정 보호 조치에 대해 이의가 있는 경우 아래 내용을 작성해 주세요.
        접수 내용은 비공개로 처리되며 관리자 검토 후 조치됩니다.
    </p>

    <c:if test="${not form.valid}">
        <div class="error">${form.errorMessage}</div>
    </c:if>

    <c:if test="${form.valid}">
        <div class="info">
            <div><strong>대상 유형</strong>: <c:out value="${form.targetType}" default="-"/></div>
            <div><strong>대상 키</strong>: <c:out value="${form.targetKey}" default="-"/></div>
            <div><strong>요청 ID</strong>: <c:out value="${form.requestId}" default="-"/></div>
            <div><strong>차단 유형</strong>: <c:out value="${form.blockKind}" default="-"/> / <c:out value="${form.blockMatchType}" default="-"/></div>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/security/appeal">
            <input type="hidden" name="token" value="${token}">
            <input type="hidden" name="requestId" value="${requestId}">
            <input type="hidden" name="lang" value="${pageLang}">

            <label>연락 가능한 이메일
                <input type="email" name="submitterEmail" placeholder="name@example.com">
            </label>

            <label>제목
                <input type="text" name="appealTitle" required maxlength="200" value="보안 조치 이의제기">
            </label>

            <label>내용
                <textarea name="appealContent" required maxlength="2000" placeholder="본인이 시도하지 않은 로그인 실패, 오탐 가능성, 정상 이용 상황 등을 구체적으로 작성해 주세요."></textarea>
            </label>

            <div class="actions">
                <button type="submit">이의제기 접수</button>
                <a class="btn" href="${pageContext.request.contextPath}/">홈으로</a>
            </div>
        </form>
    </c:if>

    <p class="note">
        보안 정책의 악용을 막기 위해 일부 내부 판단 기준은 공개되지 않을 수 있습니다.
        접수번호는 제출 완료 화면에서 확인할 수 있습니다.
    </p>
</main>
</body>
</html>
