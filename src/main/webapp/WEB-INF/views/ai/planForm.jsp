<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="course.ai.destinationPlaceholder" var="courseAiDestinationPlaceholder"/>
<spring:message code="course.ai.requestPlaceholder" var="courseAiRequestPlaceholder"/>
<spring:message code="course.ai.submitting" javaScriptEscape="true" var="courseAiSubmittingJs"/>

<%@ include file="../common/header.jsp" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
  <meta charset="UTF-8">
  <title><spring:message code="course.ai.title"/></title>
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

    @keyframes spin {
      100% { transform: rotate(360deg); }
    }
  </style>
</head>
<body>
<div class="container">
  <h1><spring:message code="course.ai.title"/></h1>
  <div class="sub-text">
    <spring:message code="course.ai.descLine1"/> <br>
    <spring:message code="course.ai.descLine2"/>
  </div>

  <c:if test="${not empty errorMessage}">
    <div class="error-box">
      ${errorMessage}
    </div>
  </c:if>

  <form id="aiPlanForm" method="post" action="${pageContext.request.contextPath}/courses/ai/generate">
    <div class="form-grid">

      <div class="form-group">
        <label for="destination"><spring:message code="course.ai.destination"/></label>
        <input type="text"
               id="destination"
               name="destination"
               value="${requestDto.destination}"
               placeholder="${courseAiDestinationPlaceholder}">
      </div>

      <div class="form-group">
        <label for="companion"><spring:message code="course.ai.companion"/></label>
        <select id="companion" name="companion">
          <option value=""><spring:message code="course.ai.selectPlaceholder"/></option>
          <option value="혼자" <c:if test="${requestDto.companion eq '혼자'}">selected</c:if>><spring:message code="course.ai.companion.alone"/></option>
          <option value="친구" <c:if test="${requestDto.companion eq '친구'}">selected</c:if>><spring:message code="course.ai.companion.friends"/></option>
          <option value="연인" <c:if test="${requestDto.companion eq '연인'}">selected</c:if>><spring:message code="course.ai.companion.couple"/></option>
          <option value="가족" <c:if test="${requestDto.companion eq '가족'}">selected</c:if>><spring:message code="course.ai.companion.family"/></option>
          <option value="부모님" <c:if test="${requestDto.companion eq '부모님'}">selected</c:if>><spring:message code="course.ai.companion.parents"/></option>
        </select>
      </div>

      <div class="form-group">
        <label for="startDate"><spring:message code="course.ai.startDate"/></label>
        <input type="date"
               id="startDate"
               name="startDate"
               value="${requestDto.startDate}">
        <div class="hint"><spring:message code="course.write.dateFormatHint"/></div>
      </div>

      <div class="form-group">
        <label for="endDate"><spring:message code="course.ai.endDate"/></label>
        <input type="date"
               id="endDate"
               name="endDate"
               value="${requestDto.endDate}">
        <div class="hint"><spring:message code="course.write.dateFormatHint"/></div>
      </div>

      <div class="form-group">
        <label for="style"><spring:message code="course.ai.style"/></label>
        <select id="style" name="style">
          <option value=""><spring:message code="course.ai.selectPlaceholder"/></option>
          <option value="맛집 중심" <c:if test="${requestDto.style eq '맛집 중심'}">selected</c:if>><spring:message code="course.ai.style.food"/></option>
          <option value="감성 카페" <c:if test="${requestDto.style eq '감성 카페'}">selected</c:if>><spring:message code="course.ai.style.cafe"/></option>
          <option value="힐링 여행" <c:if test="${requestDto.style eq '힐링 여행'}">selected</c:if>><spring:message code="course.ai.style.healing"/></option>
          <option value="액티비티" <c:if test="${requestDto.style eq '액티비티'}">selected</c:if>><spring:message code="course.ai.style.activity"/></option>
          <option value="관광지 중심" <c:if test="${requestDto.style eq '관광지 중심'}">selected</c:if>><spring:message code="course.ai.style.landmark"/></option>
          <option value="사진/포토스팟" <c:if test="${requestDto.style eq '사진/포토스팟'}">selected</c:if>><spring:message code="course.ai.style.photo"/></option>
          <option value="여유로운 일정" <c:if test="${requestDto.style eq '여유로운 일정'}">selected</c:if>><spring:message code="course.ai.style.relaxed"/></option>
        </select>
      </div>

      <div class="form-group">
        <label for="budget"><spring:message code="course.ai.budget"/></label>
        <select id="budget" name="budget">
          <option value=""><spring:message code="course.ai.selectPlaceholder"/></option>
          <option value="낮음" <c:if test="${requestDto.budget eq '낮음'}">selected</c:if>><spring:message code="course.ai.budget.low"/></option>
          <option value="낮음" <c:if test="${requestDto.budget eq '중간'}">selected</c:if>><spring:message code="course.ai.budget.medium"/></option>
          <option value="낮음" <c:if test="${requestDto.budget eq '높음'}">selected</c:if>><spring:message code="course.ai.budget.high"/></option>
        </select>
      </div>

      <div class="form-group full">
        <label for="requestText"><spring:message code="course.ai.requestText"/></label>
        <textarea id="requestText"
                  name="requestText"
                  placeholder="${courseAiRequestPlaceholder}">${requestDto.requestText}</textarea>
        <div class="hint">
          <spring:message code="course.ai.requestHint"/>
        </div>
      </div>

      <div class="btn-area full">
        <button type="submit" class="submit-btn"><spring:message code="course.ai.submit"/></button>
      </div>

    </div>
  </form>
</div>

<div id="loadingOverlay" class="loading-overlay" style="display:none;">
  <div class="loading-card">
    <div class="loading-spinner"></div>
    <div class="loading-title"><spring:message code="course.ai.loadingTitle"/></div>
    <div class="loading-text">
      <spring:message code="course.ai.loadingText"/>
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
    submitBtn.textContent = '${courseAiSubmittingJs}';
  });
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
