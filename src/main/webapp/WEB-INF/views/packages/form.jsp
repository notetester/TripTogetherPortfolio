<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="packages/packages.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<main class="pkg-wrap">
    <section class="pkg-hero pkg-hero--form">
        <div>
            <p class="pkg-eyebrow">PACKAGE FORM</p>
            <h1>
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}"><spring:message code="package.form.revisionTitle"/></c:when>
                    <c:when test="${formMode eq 'EDIT'}">패키지 상품 수정</c:when>
                    <c:otherwise>패키지 상품 등록</c:otherwise>
                </c:choose>
            </h1>
            <p>
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}"><spring:message code="package.form.revisionDesc"/></c:when>
                    <c:otherwise>승인 요청 전에는 임시저장으로 내용을 다듬을 수 있습니다.</c:otherwise>
                </c:choose>
            </p>
        </div>
        <a class="pkg-ghost-link" href="${pageContext.request.contextPath}/packages/manage">목록으로</a>
    </section>

    <section class="pkg-panel pkg-form-panel">
        <c:if test="${not empty packageError}">
            <div class="pkg-alert pkg-alert--error">${packageError}</div>
        </c:if>

        <c:choose>
            <c:when test="${formMode eq 'EDIT'}">
                <c:set var="formAction" value="${pageContext.request.contextPath}/packages/manage/${packageForm.packageIdx}/edit"/>
            </c:when>
            <c:otherwise>
                <c:set var="formAction" value="${pageContext.request.contextPath}/packages/manage/write"/>
            </c:otherwise>
        </c:choose>

        <form class="pkg-form" method="post" action="${formAction}">
            <div class="pkg-form-grid">
                <label class="pkg-field pkg-field--wide">
                    <span>연결 여행지 <em>*</em></span>
                    <select name="spotIdx" required>
                        <option value="">여행지를 선택하세요</option>
                        <c:forEach var="spot" items="${spotOptions}">
                            <option value="${spot.spotIdx}" ${packageForm.spotIdx eq spot.spotIdx ? 'selected' : ''}>
                                [${spot.region}] ${spot.name}
                            </option>
                        </c:forEach>
                    </select>
                    <small>패키지는 반드시 기존 여행지 하나와 연결됩니다.</small>
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>패키지 상품명 <em>*</em></span>
                    <input type="text" name="packageTitle" maxlength="150" required
                           value="${packageForm.packageTitle}" placeholder="예: 도쿄 야경 미식 3일 패키지">
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>짧은 소개</span>
                    <input type="text" name="packageSummary" maxlength="300"
                           value="${packageForm.packageSummary}" placeholder="목록 카드에 노출될 한 줄 소개">
                </label>

                <label class="pkg-field">
                    <span>가격 <em>*</em></span>
                    <input type="number" name="packagePrice" min="0" required
                           value="${empty packageForm.packagePrice ? 0 : packageForm.packagePrice}">
                </label>

                <label class="pkg-field">
                    <span>통화</span>
                    <input type="text" name="currencyCode" maxlength="10"
                           value="${empty packageForm.currencyCode ? 'KRW' : packageForm.currencyCode}">
                </label>

                <label class="pkg-field">
                    <span>시작일</span>
                    <input type="date" name="startDate" value="${packageForm.startDate}">
                </label>

                <label class="pkg-field">
                    <span>종료일</span>
                    <input type="date" name="endDate" value="${packageForm.endDate}">
                </label>

                <label class="pkg-field">
                    <span>최소 인원 <em>*</em></span>
                    <input type="number" name="minPeople" min="1" required
                           value="${empty packageForm.minPeople ? 1 : packageForm.minPeople}">
                </label>

                <label class="pkg-field">
                    <span>최대 인원</span>
                    <input type="number" name="maxPeople" min="1" value="${packageForm.maxPeople}">
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>대표 이미지 경로</span>
                    <input type="text" name="mainImagePath" value="${packageForm.mainImagePath}"
                           placeholder="예: /TripTogether/upload/package/sample.jpg 또는 https://...">
                    <small>파일 업로드 기능은 다음 단계에서 붙일 수 있도록 현재는 경로 입력 방식으로 열어둡니다.</small>
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>상세 설명 <em>*</em></span>
                    <textarea name="packageContent" rows="12" required
                              placeholder="포함 사항, 일정, 유의사항, 취소 규정 등을 적어주세요.">${packageForm.packageContent}</textarea>
                </label>
            </div>

            <div class="pkg-form-actions">
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}">
                        <button type="submit" name="action" value="PENDING" class="pkg-primary-btn">
                            <spring:message code="package.revision.request"/>
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button type="submit" name="action" value="DRAFT" class="pkg-secondary-btn">임시저장</button>
                        <button type="submit" name="action" value="PENDING" class="pkg-primary-btn">저장 후 승인 요청</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </form>
    </section>
</main>

</body>
</html>
