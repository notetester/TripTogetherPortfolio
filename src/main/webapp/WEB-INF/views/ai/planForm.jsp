<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message var="autoMsg_d8203c1220" code="courses.ai.pageTitle"/>
<spring:message var="autoMsg_64f806d85e" code="courses.ai.subtitle.line1"/>
<spring:message var="autoMsg_c1a22099b2" code="courses.ai.destination"/>
<spring:message var="autoMsg_abebfb9d4b" code="courses.ai.companion"/>
<spring:message var="autoMsg_66ce3d3b63" code="courses.ai.select.placeholder"/>
<spring:message var="autoMsg_29c6568f86" code="courses.ai.companion.solo"/>
<spring:message var="autoMsg_eef6393039" code="courses.ai.companion.friends"/>
<spring:message var="autoMsg_3fb1fe3523" code="courses.ai.companion.couple"/>
<spring:message var="autoMsg_7201f3f897" code="courses.ai.companion.family"/>
<spring:message var="autoMsg_28ddc328ed" code="courses.ai.companion.parents"/>
<spring:message var="autoMsg_2e3191aae1" code="courses.ai.startDate"/>
<spring:message var="autoMsg_daee4d6c54" code="course.write.dateFormatHint"/>
<spring:message var="autoMsg_2a0384f48c" code="courses.ai.endDate"/>
<spring:message var="autoMsg_a7179285f8" code="courses.ai.style"/>
<spring:message var="autoMsg_cc44deb473" code="courses.ai.style.food"/>
<spring:message var="autoMsg_5b7ffa3314" code="courses.ai.style.cafe"/>
<spring:message var="autoMsg_35bf9d0696" code="courses.ai.style.healing"/>
<spring:message var="autoMsg_9346b54fdc" code="courses.ai.style.activity"/>
<spring:message var="autoMsg_1eaa05828e" code="courses.ai.style.sightseeing"/>
<spring:message var="autoMsg_dd447eccd8" code="courses.ai.style.photo"/>
<spring:message var="autoMsg_a35555f2cb" code="courses.ai.style.relaxed"/>
<spring:message var="autoMsg_62554c2fd5" code="courses.ai.budget"/>
<spring:message var="autoMsg_eeb4773614" code="courses.ai.budget.low"/>
<spring:message var="autoMsg_5b26a15131" code="courses.ai.budget.medium"/>
<spring:message var="autoMsg_dc022934f9" code="courses.ai.budget.high"/>
<spring:message var="autoMsg_b45b93de80" code="courses.ai.request"/>
<spring:message var="autoMsg_1986f15c23" code="courses.ai.submit"/>
<spring:message var="autoMsg_2a72f147dd" code="courses.ai.loading.title"/>
<spring:message var="autoMsg_2d627bccb8" code="courses.ai.loading.text1"/>
<%@ include file="../common/header.jsp" %>

<spring:message code="courses.ai.destination.placeholder" var="aiDestinationPlaceholder"/>
<spring:message code="courses.ai.request.placeholder" var="aiRequestPlaceholder"/>
<spring:message code="courses.ai.submit.loading" var="aiSubmitLoadingLabel"/>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
  <meta charset="UTF-8">
  <title>${autoMsg_d8203c1220}</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #f5f7fb;
      color: #222;
    }

    .container {
      width: 900px;
      margin: 50px auto;
      background: #ffffff;
      border-radius: 18px;
      padding: 40px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
    }

    h1 {
      margin: 0 0 10px;
      font-size: 32px;
    }

    .sub-text {
      margin-bottom: 30px;
      color: #666;
      font-size: 15px;
    }

    .error-box {
      margin-bottom: 20px;
      padding: 14px 16px;
      border-radius: 12px;
      background: #fff2f2;
      color: #d93025;
      border: 1px solid #f4c7c3;
      font-size: 14px;
    }

    .form-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }

    .form-group {
      display: flex;
      flex-direction: column;
    }

    .form-group.full {
      grid-column: 1 / 3;
    }

    label {
      font-weight: 700;
      margin-bottom: 8px;
      font-size: 14px;
    }

    input[type="text"],
    input[type="date"],
    select,
    textarea {
      width: 100%;
      padding: 12px 14px;
      border: 1px solid #dcdfe6;
      border-radius: 12px;
      font-size: 14px;
      outline: none;
      background: #fff;
    }

    input:focus,
    select:focus,
    textarea:focus {
      border-color: #222;
    }

    textarea {
      min-height: 130px;
      resize: vertical;
    }

    .btn-area {
      display: flex;
      justify-content: center;
      margin-top: 30px;
    }

    .btn-area.full {
      grid-column: 1 / 3;
    }

    .submit-btn {
      border: none;
      background: #111827;
      color: white;
      padding: 14px 24px;
      border-radius: 12px;
      font-size: 15px;
      font-weight: 700;
      cursor: pointer;
    }

    .submit-btn:hover {
      opacity: 0.92;
    }

    .hint {
      margin-top: 8px;
      color: #888;
      font-size: 12px;
    }

    .loading-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(17, 24, 39, 0.45);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 9999;
    }

    .loading-card {
      width: 320px;
      background: #fff;
      border-radius: 20px;
      padding: 32px 28px;
      text-align: center;
      box-shadow: 0 16px 40px rgba(0,0,0,0.15);
    }

    .loading-spinner {
      width: 48px;
      height: 48px;
      margin: 0 auto 16px;
      border: 4px solid #e5e7eb;
      border-top: 4px solid #111827;
      border-radius: 50%;
      animation: spin 0.9s linear infinite;
    }

    .loading-title {
      font-size: 18px;
      font-weight: 700;
      color: #111827;
      margin-bottom: 8px;
    }

    .loading-text {
      font-size: 14px;
      color: #6b7280;
      line-height: 1.5;
    }

    .submit-btn:disabled {
      opacity: 0.65;
      cursor: not-allowed;
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      font-size: 14px;
      color: #64748b;
      text-decoration: none;
      margin-bottom: 16px;
    }
    .back-link:hover {
      color: #2563eb;
    }

    @keyframes spin {
      100% { transform: rotate(360deg); }
    }
  </style>
</head>
<body>
<div class="container">

  <a href="${pageContext.request.contextPath}/courses/list" class="back-link">
    <spring:message code="course.write.backToList"/>
  </a>

  <h1>${autoMsg_d8203c1220}</h1>
  <div class="sub-text">
    ${autoMsg_64f806d85e} <br>
    <spring:message code="courses.ai.subtitle.line2"/>
  </div>

  <c:if test="${not empty errorMessage}">
    <div class="error-box">
      ${errorMessage}
    </div>
  </c:if>

  <form id="aiPlanForm" method="post" action="${pageContext.request.contextPath}/courses/ai/generate">
    <div class="form-grid">

      <div class="form-group">
        <label for="destination">${autoMsg_c1a22099b2}</label>
        <input type="text"
               id="destination"
               name="destination"
               value="${requestDto.destination}"
               placeholder="${aiDestinationPlaceholder}">
      </div>

      <div class="form-group">
        <label for="companion">${autoMsg_abebfb9d4b}</label>
        <select id="companion" name="companion">
          <option value="">${autoMsg_66ce3d3b63}</option>
          <option value="혼자" <c:if test="${requestDto.companion eq '혼자'}">selected</c:if>>${autoMsg_29c6568f86}</option>
          <option value="친구" <c:if test="${requestDto.companion eq '친구'}">selected</c:if>>${autoMsg_eef6393039}</option>
          <option value="연인" <c:if test="${requestDto.companion eq '연인'}">selected</c:if>>${autoMsg_3fb1fe3523}</option>
          <option value="가족" <c:if test="${requestDto.companion eq '가족'}">selected</c:if>>${autoMsg_7201f3f897}</option>
          <option value="부모님" <c:if test="${requestDto.companion eq '부모님'}">selected</c:if>>${autoMsg_28ddc328ed}</option>
        </select>
      </div>

      <div class="form-group">
        <label for="startDate">${autoMsg_2e3191aae1}</label>
        <input type="date"
               id="startDate"
               name="startDate"
               value="${requestDto.startDate}">
        <div class="hint">${autoMsg_daee4d6c54}</div>
      </div>

      <div class="form-group">
        <label for="endDate">${autoMsg_2a0384f48c}</label>
        <input type="date"
               id="endDate"
               name="endDate"
               value="${requestDto.endDate}">
        <div class="hint">${autoMsg_daee4d6c54}</div>
      </div>

      <div class="form-group">
        <label for="style">${autoMsg_a7179285f8}</label>
        <select id="style" name="style">
          <option value="">${autoMsg_66ce3d3b63}</option>
          <option value="맛집 중심" <c:if test="${requestDto.style eq '맛집 중심'}">selected</c:if>>${autoMsg_cc44deb473}</option>
          <option value="감성 카페" <c:if test="${requestDto.style eq '감성 카페'}">selected</c:if>>${autoMsg_5b7ffa3314}</option>
          <option value="힐링 여행" <c:if test="${requestDto.style eq '힐링 여행'}">selected</c:if>>${autoMsg_35bf9d0696}</option>
          <option value="액티비티" <c:if test="${requestDto.style eq '액티비티'}">selected</c:if>>${autoMsg_9346b54fdc}</option>
          <option value="관광지 중심" <c:if test="${requestDto.style eq '관광지 중심'}">selected</c:if>>${autoMsg_1eaa05828e}</option>
          <option value="사진/포토스팟" <c:if test="${requestDto.style eq '사진/포토스팟'}">selected</c:if>>${autoMsg_dd447eccd8}</option>
          <option value="여유로운 일정" <c:if test="${requestDto.style eq '여유로운 일정'}">selected</c:if>>${autoMsg_a35555f2cb}</option>
        </select>
      </div>

      <div class="form-group">
        <label for="budget">${autoMsg_62554c2fd5}</label>
        <select id="budget" name="budget">
          <option value="">${autoMsg_66ce3d3b63}</option>
          <option value="낮음" <c:if test="${requestDto.budget eq '낮음'}">selected</c:if>>${autoMsg_eeb4773614}</option>
          <option value="중간" <c:if test="${requestDto.budget eq '중간'}">selected</c:if>>${autoMsg_5b26a15131}</option>
          <option value="높음" <c:if test="${requestDto.budget eq '높음'}">selected</c:if>>${autoMsg_dc022934f9}</option>
        </select>
      </div>

      <div class="form-group full">
        <label for="requestText">${autoMsg_b45b93de80}</label>
        <textarea id="requestText"
                  name="requestText"
                  placeholder="${aiRequestPlaceholder}">${requestDto.requestText}</textarea>
        <div class="hint">
          <spring:message code="courses.ai.request.hint"/>
        </div>
      </div>

      <div class="btn-area full">
        <button type="submit" class="submit-btn">${autoMsg_1986f15c23}</button>
      </div>

    </div>
  </form>
</div>

<div id="loadingOverlay" class="loading-overlay" style="display:none;">
  <div class="loading-card">
    <div class="loading-spinner"></div>
    <div class="loading-title">${autoMsg_2a72f147dd}</div>
    <div class="loading-text">
      ${autoMsg_2d627bccb8}<br>
      <spring:message code="courses.ai.loading.text2"/>
    </div>
  </div>
</div>

<script>
  const aiPlanForm = document.getElementById('aiPlanForm');

  aiPlanForm.addEventListener('submit', function () {
    const overlay = document.getElementById('loadingOverlay');
    const submitBtn = document.querySelector('.submit-btn');

    overlay.style.display = 'flex';
    submitBtn.disabled = true;
    submitBtn.textContent = '${aiSubmitLoadingLabel}';
  });
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
