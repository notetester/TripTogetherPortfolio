<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="businessApplications"/>
<c:set var="pageTitle"  value="기업 회원 신청 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>기업 회원 신청 관리</h1>
            <p>일반 회원이 요청한 비즈니스/파트너 권한을 검토하고 승인 또는 반려합니다.</p>
        </div>
    </div>

    <c:if test="${not empty businessApplicationMessage}">
        <div class="adm-alert adm-alert-success">${fn:escapeXml(businessApplicationMessage)}</div>
    </c:if>
    <c:if test="${not empty businessApplicationError}">
        <div class="adm-alert adm-alert-danger">${fn:escapeXml(businessApplicationError)}</div>
    </c:if>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/business-applications">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label">신청 상태</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${status eq 'ALL' ? 'selected' : ''}>전체</option>
                            <option value="PENDING" ${status eq 'PENDING' ? 'selected' : ''}>검토 대기</option>
                            <option value="APPROVED" ${status eq 'APPROVED' ? 'selected' : ''}>승인</option>
                            <option value="REJECTED" ${status eq 'REJECTED' ? 'selected' : ''}>반려</option>
                        </select>
                    </div>
                    <div style="display:flex;gap:6px;align-items:flex-end;">
                        <button type="submit" class="adm-btn adm-btn-primary">검색</button>
                        <a href="${pageContext.request.contextPath}/admin/business-applications"
                           class="adm-btn adm-btn-ghost">초기화</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>신청자</th>
                    <th>요청 권한</th>
                    <th>기업 정보</th>
                    <th>상태</th>
                    <th>신청일</th>
                    <th>검토</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="app" items="${applicationList}">
                    <tr>
                        <td>
                            <div class="mem-name">${fn:escapeXml(app.nickname)}</div>
                            <div class="mem-uid">
                                <c:choose>
                                    <c:when test="${not empty app.userId}">@${fn:escapeXml(app.userId)}</c:when>
                                    <c:otherwise>소셜 전용</c:otherwise>
                                </c:choose>
                            </div>
                            <div style="font-size:11px;color:#64748b;margin-top:2px;">현재 ${fn:escapeXml(app.currentUserRole)}</div>
                        </td>
                        <td>
                            <span class="role-badge ${app.requestedRole}">
                                <c:choose>
                                    <c:when test="${app.requestedRole eq 'BUSINESS'}">비즈니스</c:when>
                                    <c:when test="${app.requestedRole eq 'PARTNER'}">파트너</c:when>
                                    <c:otherwise>${fn:escapeXml(app.requestedRole)}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <div style="font-weight:700;color:#e2e8f0;">${fn:escapeXml(app.companyName)}</div>
                            <div style="font-size:12px;color:#94a3b8;margin-top:3px;">
                                사업자번호:
                                <c:choose>
                                    <c:when test="${not empty app.businessNumber}">${fn:escapeXml(app.businessNumber)}</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </div>
                            <div style="font-size:12px;color:#94a3b8;">
                                담당자 ${fn:escapeXml(app.managerName)} · ${fn:escapeXml(app.managerPhone)}
                            </div>
                            <c:if test="${not empty app.description}">
                                <div style="font-size:12px;color:#cbd5e1;margin-top:6px;max-width:420px;white-space:pre-wrap;">${fn:escapeXml(app.description)}</div>
                            </c:if>
                        </td>
                        <td>
                            <span class="status-badge ${app.applicationStatus}">
                                <c:choose>
                                    <c:when test="${app.applicationStatus eq 'PENDING'}">검토 대기</c:when>
                                    <c:when test="${app.applicationStatus eq 'APPROVED'}">승인</c:when>
                                    <c:when test="${app.applicationStatus eq 'REJECTED'}">반려</c:when>
                                    <c:otherwise>${fn:escapeXml(app.applicationStatus)}</c:otherwise>
                                </c:choose>
                            </span>
                            <c:if test="${not empty app.rejectReason}">
                                <div style="font-size:11px;color:#fca5a5;margin-top:6px;">${fn:escapeXml(app.rejectReason)}</div>
                            </c:if>
                            <c:if test="${not empty app.reviewerNickname}">
                                <div style="font-size:11px;color:#94a3b8;margin-top:4px;">검토자 ${fn:escapeXml(app.reviewerNickname)}</div>
                            </c:if>
                        </td>
                        <td>
                            <fmt:formatDate value="${app.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${app.applicationStatus eq 'PENDING'}">
                                    <div class="business-review-actions">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/business-applications/${app.applicationIdx}/approve">
                                            <button type="submit" class="adm-row-btn detail"
                                                    onclick="return confirm('이 신청을 승인하고 회원 권한을 변경할까요?')">승인</button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/business-applications/${app.applicationIdx}/reject">
                                            <input class="adm-input" name="rejectReason" maxlength="500" placeholder="반려 사유" required>
                                            <button type="submit" class="adm-row-btn danger">반려</button>
                                        </form>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;font-size:12px;">검토 완료</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty applicationList}">
                    <tr>
                        <td colspan="6" style="text-align:center;padding:40px;color:#64748b;">
                            기업 회원 신청 내역이 없습니다.
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
