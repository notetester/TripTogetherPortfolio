<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="loginRiskReviews"/>
<c:set var="pageTitle" value="로그인 위험 검토 큐"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>로그인 위험 검토 큐</h1>
            <p class="adm-page-desc">자동 차단하기 애매하거나 운영자 판단이 필요한 로그인 위험 건을 처리합니다.</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">정책 설정</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">알림 설정</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(5,minmax(0,1fr));gap:10px;">
            <label>상태
                <select class="adm-input" name="status">
                    <option value="">전체</option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                    <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                    <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                </select>
            </label>
            <label>심각도
                <select class="adm-input" name="severity">
                    <option value="">전체</option>
                    <option value="CRITICAL" ${severity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${severity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${severity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${severity == 'LOW' ? 'selected' : ''}>LOW</option>
                </select>
            </label>
            <label>유형
                <input class="adm-input" type="text" name="reviewType" value="${reviewType}" placeholder="IP_LOGIN_RISK">
            </label>
            <label>검색
                <input class="adm-input" type="text" name="keyword" value="${keyword}" placeholder="IP, 계정, 요약">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">검색</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>상태</th>
                <th>심각도</th>
                <th>검토 유형</th>
                <th>대상</th>
                <th>요약</th>
                <th>생성일</th>
                <th>처리</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${reviews}">
                <tr>
                    <td><span class="adm-badge">${r.reviewStatus}</span></td>
                    <td>${r.severity}</td>
                    <td>${r.reviewType}<br><small>${r.policyCode}</small></td>
                    <td>
                        ${r.subjectType}: ${r.subjectKey}<br>
                        <c:if test="${not empty r.userId}"><small>${r.userId} / ${r.nickname}</small></c:if>
                    </td>
                    <td>
                        <strong>${r.summary}</strong><br>
                        <small>${r.detailMessage}</small>
                        <c:if test="${not empty r.reviewComment}">
                            <br><small>처리 메모: ${r.reviewComment}</small>
                        </c:if>
                    </td>
                    <td><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/approve" style="display:inline;">
                                <input type="hidden" name="comment" value="승인 처리">
                                <button class="adm-btn primary" type="submit">승인</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/hold" style="display:inline;">
                                <input type="hidden" name="comment" value="추가 확인 필요">
                                <button class="adm-btn" type="submit">보류</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/reject" style="display:inline;">
                                <input type="hidden" name="comment" value="차단하지 않음">
                                <button class="adm-btn danger" type="submit">미승인</button>
                            </form>
                        </c:if>
                        <c:if test="${r.reviewStatus != 'PENDING' && r.reviewStatus != 'HOLD'}">
                            <small>${r.reviewedByUserId} / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></small>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty reviews}">
                <tr><td colspan="7" class="adm-empty">검토 대상이 없습니다.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
