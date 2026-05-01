<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="securityAppeals"/>
<c:set var="pageTitle" value="보안 조치 이의제기"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>보안 조치 이의제기</h1>
            <p class="adm-page-desc">자동 차단, 콘텐츠 조치, 접근 제한에 대한 이의제기를 운영자가 검토합니다.</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">보안 위험 판단</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">일반 검토 큐</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label>상태
                <select class="adm-input" name="status">
                    <option value="">전체</option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                    <option value="ACCEPTED" ${status == 'ACCEPTED' ? 'selected' : ''}>ACCEPTED</option>
                    <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                </select>
            </label>
            <label>대상 유형
                <input class="adm-input" type="text" name="targetType" value="${targetType}" placeholder="USER_BLOCK">
            </label>
            <label>검색
                <input class="adm-input" type="text" name="keyword" value="${keyword}" placeholder="계정, 제목, 대상">
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
                <th>사용자</th>
                <th>대상</th>
                <th>제목/내용</th>
                <th>접수일</th>
                <th>처리</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${appeals}">
                <tr>
                    <td><span class="adm-badge">${a.appealStatus}</span></td>
                    <td>${empty a.userId ? '-' : a.userId}<br><small>${empty a.nickname ? '-' : a.nickname}</small></td>
                    <td>${a.targetType}<br><small>${a.targetKey}</small></td>
                    <td>
                        <strong>${a.appealTitle}</strong><br>
                        <small>${a.appealContent}</small>
                        <c:if test="${not empty a.reviewComment}">
                            <br><small>처리 메모: ${a.reviewComment}</small>
                        </c:if>
                    </td>
                    <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:if test="${a.appealStatus == 'PENDING' || a.appealStatus == 'HOLD'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/accept" style="display:inline;">
                                <input type="hidden" name="comment" value="이의제기 수용">
                                <button class="adm-btn primary" type="submit">수용</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/hold" style="display:inline;">
                                <input type="hidden" name="comment" value="추가 확인 필요">
                                <button class="adm-btn" type="submit">보류</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/reject" style="display:inline;">
                                <input type="hidden" name="comment" value="이의제기 미수용">
                                <button class="adm-btn danger" type="submit">미수용</button>
                            </form>
                        </c:if>
                        <c:if test="${a.appealStatus != 'PENDING' && a.appealStatus != 'HOLD'}">
                            <small>${a.reviewedByUserId} / <fmt:formatDate value="${a.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></small>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty appeals}">
                <tr><td colspan="6" class="adm-empty">이의제기 데이터가 없습니다.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
