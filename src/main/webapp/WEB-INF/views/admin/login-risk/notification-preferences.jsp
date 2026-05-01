<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activeMenu" value="adminNotificationPreferences"/>
<c:set var="pageTitle" value="관리자 알림 설정"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>관리자 알림 설정</h1>
            <p class="adm-page-desc">담당 업무에 맞춰 수신할 관리자 알림을 선택합니다.</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">정책 설정</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews">검토 큐</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <form method="post" class="adm-card">
        <div class="adm-card-header">
            <div class="adm-card-title">알림 카테고리</div>
        </div>
        <div class="adm-card-body">
            <c:forEach var="p" items="${preferences}">
                <label class="adm-check" style="display:block;margin:12px 0;">
                    <input type="checkbox" name="enabledCategories" value="${p.notificationCategory}" ${p.enabled ? 'checked' : ''}>
                    <strong>${p.notificationCategory}</strong>
                    <span class="adm-muted">
                        <c:choose>
                            <c:when test="${p.notificationCategory == 'LOGIN_RISK'}">로그인 위험/검토 큐</c:when>
                            <c:when test="${p.notificationCategory == 'BUSINESS_APPLICATION'}">기업/파트너 승인</c:when>
                            <c:when test="${p.notificationCategory == 'REPORT'}">신고 처리</c:when>
                            <c:when test="${p.notificationCategory == 'INQUIRY'}">문의 응대</c:when>
                            <c:when test="${p.notificationCategory == 'BLOCK_REVIEW'}">차단 검토</c:when>
                            <c:otherwise>기타 알림</c:otherwise>
                        </c:choose>
                    </span>
                </label>
            </c:forEach>
            <div class="adm-actions" style="margin-top:16px;">
                <button class="adm-btn primary" type="submit">저장</button>
            </div>
        </div>
    </form>
</div>
