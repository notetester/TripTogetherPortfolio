<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_4aab537781" code="course.main.windowTitle"/>
<spring:message var="autoMsg_e18ca1cafe" code="course.main.badge"/>
<spring:message var="autoMsg_a591aa6ece" code="course.main.title"/>
<spring:message var="autoMsg_754dcd6187" code="course.main.desc"/>
<spring:message var="autoMsg_41d0328dfa" code="course.main.my.label"/>
<spring:message var="autoMsg_d663ee8045" code="course.main.my.title"/>
<spring:message var="autoMsg_8776f61111" code="course.main.my.desc"/>
<spring:message var="autoMsg_a8ba9b24ad" code="course.main.public.label"/>
<spring:message var="autoMsg_90e1b0a4ab" code="course.main.public.title"/>
<spring:message var="autoMsg_4e1de5f9b6" code="course.main.public.desc"/>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
  <meta charset="UTF-8">
  <title>${autoMsg_4aab537781}</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      background: #f8fafc;
      color: #1e293b;
      font-family: "Pretendard", "Noto Sans KR", sans-serif;
    }

    .courses-main-wrap {
      max-width: 1200px;
      margin: 0 auto;
      padding: 60px 20px 80px;
    }

    .hero-section {
      background: linear-gradient(135deg, #dbeafe 0%, #eff6ff 45%, #ffffff 100%);
      border-radius: 28px;
      padding: 64px 48px;
      box-shadow: 0 12px 32px rgba(15, 23, 42, 0.08);
      margin-bottom: 36px;
    }

    .hero-badge {
      display: inline-block;
      padding: 8px 14px;
      border-radius: 999px;
      background: #2563eb;
      color: #fff;
      font-size: 13px;
      font-weight: 700;
      margin-bottom: 18px;
    }

    .hero-title {
      font-size: 42px;
      font-weight: 800;
      line-height: 1.3;
      margin: 0 0 14px;
      color: #0f172a;
      white-space: pre-line;
    }

    .hero-desc {
      font-size: 17px;
      color: #475569;
      line-height: 1.7;
      margin: 0 0 30px;
    }

    .hero-btn-group {
      display: flex;
      flex-wrap: wrap;
      gap: 14px;
    }

    .hero-btn {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      min-width: 180px;
      padding: 14px 22px;
      border-radius: 14px;
      text-decoration: none;
      font-size: 15px;
      font-weight: 700;
      transition: all 0.2s ease;
    }

    .hero-btn.primary {
      background: #2563eb;
      color: #fff;
    }

    .hero-btn.primary:hover {
      background: #1d4ed8;
      transform: translateY(-1px);
    }

    .hero-btn.secondary {
      background: #fff;
      color: #2563eb;
      border: 1px solid #bfdbfe;
    }

    .hero-btn.secondary:hover {
      background: #eff6ff;
      transform: translateY(-1px);
    }

    .menu-grid {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 20px;
    }

    .menu-card {
      background: #fff;
      border-radius: 22px;
      padding: 28px 24px;
      box-shadow: 0 8px 24px rgba(15, 23, 42, 0.06);
      border: 1px solid #e2e8f0;
      text-decoration: none;
      color: inherit;
      transition: all 0.2s ease;
    }

    .menu-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 14px 32px rgba(15, 23, 42, 0.1);
    }

    .menu-label {
      display: inline-block;
      font-size: 13px;
      font-weight: 700;
      color: #2563eb;
      background: #eff6ff;
      padding: 6px 10px;
      border-radius: 999px;
      margin-bottom: 16px;
    }

    .menu-title {
      font-size: 24px;
      font-weight: 800;
      margin: 0 0 12px;
      color: #0f172a;
    }

    .menu-desc {
      font-size: 15px;
      line-height: 1.7;
      color: #64748b;
      margin: 0;
    }

    @media (max-width: 900px) {
      .hero-section {
        padding: 44px 28px;
      }

      .hero-title {
        font-size: 34px;
      }

      .menu-grid {
        grid-template-columns: 1fr;
      }
    }

    @media (max-width: 600px) {
      .courses-main-wrap {
        padding: 32px 16px 56px;
      }

      .hero-section {
        padding: 32px 20px;
        border-radius: 22px;
      }

      .hero-title {
        font-size: 28px;
      }

      .hero-desc {
        font-size: 15px;
      }

      .hero-btn {
        width: 100%;
      }

      .menu-card {
        padding: 22px 18px;
      }

      .menu-title {
        font-size: 21px;
      }
    }
  </style>
</head>
<body>
<%@ include file="../common/header.jsp" %>

<div class="courses-main-wrap">
  <section class="hero-section">
    <div class="hero-badge">${autoMsg_e18ca1cafe}</div>
    <h1 class="hero-title">${autoMsg_a591aa6ece}</h1>
    <p class="hero-desc">${autoMsg_754dcd6187}</p>

    <div class="hero-btn-group">
      <a href="${pageContext.request.contextPath}/courses/write" class="hero-btn primary">
        <spring:message code="course.main.manualCreate"/>
      </a>
      <a href="${pageContext.request.contextPath}/courses/ai/form" class="hero-btn secondary">
        <spring:message code="course.main.aiCreate"/>
      </a>
    </div>
  </section>

  <section class="menu-grid">
    <a href="${pageContext.request.contextPath}/courses/my" class="menu-card">
      <div class="menu-label">${autoMsg_41d0328dfa}</div>
      <h2 class="menu-title">${autoMsg_d663ee8045}</h2>
      <p class="menu-desc">${autoMsg_8776f61111}</p>
    </a>

    <a href="${pageContext.request.contextPath}/courses/public" class="menu-card">
      <div class="menu-label">${autoMsg_a8ba9b24ad}</div>
      <h2 class="menu-title">${autoMsg_90e1b0a4ab}</h2>
      <p class="menu-desc">${autoMsg_4e1de5f9b6}</p>
    </a>
  </section>
</div>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
