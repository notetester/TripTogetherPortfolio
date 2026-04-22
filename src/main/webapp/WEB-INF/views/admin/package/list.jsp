<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="packages"/>
<c:set var="pageTitle"  value="패키지 상품 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>패키지 상품 관리</h1>
            <p>비즈니스/파트너 회원이 승인 요청한 여행 패키지를 검토하고 사용자 노출 여부를 결정합니다.</p>
        </div>
    </div>

    <c:if test="${not empty packageReviewMessage}">
        <div class="adm-alert adm-alert-success">${fn:escapeXml(packageReviewMessage)}</div>
    </c:if>
    <c:if test="${not empty packageReviewError}">
        <div class="adm-alert adm-alert-danger">${fn:escapeXml(packageReviewError)}</div>
    </c:if>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/packages">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label">검토 상태</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${status eq 'ALL' ? 'selected' : ''}>전체</option>
                            <option value="PENDING" ${status eq 'PENDING' ? 'selected' : ''}>승인 대기</option>
                            <option value="APPROVED" ${status eq 'APPROVED' ? 'selected' : ''}>승인 완료</option>
                            <option value="REJECTED" ${status eq 'REJECTED' ? 'selected' : ''}>반려</option>
                            <option value="DRAFT" ${status eq 'DRAFT' ? 'selected' : ''}>임시저장</option>
                            <option value="BLOCKED" ${status eq 'BLOCKED' ? 'selected' : ''}>차단</option>
                        </select>
                    </div>
                    <div style="display:flex;gap:6px;align-items:flex-end;">
                        <button type="submit" class="adm-btn adm-btn-primary">검색</button>
                        <a href="${pageContext.request.contextPath}/admin/packages"
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
                    <th>패키지</th>
                    <th>판매자</th>
                    <th>연결 여행지</th>
                    <th>가격/일정</th>
                    <th>상태</th>
                    <th>검토</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pkg" items="${packageList}">
                    <tr>
                        <td>
                            <div style="display:flex;gap:12px;align-items:flex-start;min-width:280px;">
                                <div style="width:82px;height:58px;border-radius:10px;overflow:hidden;background:#1e293b;flex:0 0 auto;">
                                    <c:choose>
                                        <c:when test="${not empty pkg.mainImagePath}">
                                            <img src="${fn:escapeXml(pkg.mainImagePath)}"
                                                 alt="${fn:escapeXml(pkg.packageTitle)}"
                                                 style="width:100%;height:100%;object-fit:cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="height:100%;display:grid;place-items:center;color:#94a3b8;font-size:11px;font-weight:800;">NO IMG</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <div style="font-weight:800;color:#e2e8f0;">${fn:escapeXml(pkg.packageTitle)}</div>
                                    <c:if test="${not empty pkg.packageSummary}">
                                        <div style="font-size:12px;color:#94a3b8;margin-top:4px;max-width:420px;">
                                            ${fn:escapeXml(pkg.packageSummary)}
                                        </div>
                                    </c:if>
                                    <div style="font-size:11px;color:#64748b;margin-top:4px;">등록 ${pkg.createdAt}</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="mem-name">${fn:escapeXml(pkg.sellerNickname)}</div>
                            <div class="mem-uid">user_idx ${pkg.sellerUserIdx}</div>
                        </td>
                        <td>
                            <div style="font-weight:700;color:#e2e8f0;">${fn:escapeXml(pkg.spotName)}</div>
                            <div style="font-size:12px;color:#94a3b8;">${fn:escapeXml(pkg.spotRegion)}</div>
                        </td>
                        <td>
                            <div style="font-weight:800;color:#e2e8f0;">
                                <fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}
                            </div>
                            <div style="font-size:12px;color:#94a3b8;margin-top:4px;">
                                <c:choose>
                                    <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                        ${pkg.startDate} ~ ${pkg.endDate}
                                    </c:when>
                                    <c:otherwise>상시/미정</c:otherwise>
                                </c:choose>
                            </div>
                            <div style="font-size:12px;color:#94a3b8;">
                                최소 ${pkg.minPeople}명
                                <c:if test="${not empty pkg.maxPeople}"> / 최대 ${pkg.maxPeople}명</c:if>
                            </div>
                        </td>
                        <td>
                            <span class="status-badge ${pkg.packageStatus}">
                                <c:choose>
                                    <c:when test="${pkg.packageStatus eq 'PENDING'}">승인 대기</c:when>
                                    <c:when test="${pkg.packageStatus eq 'APPROVED'}">승인 완료</c:when>
                                    <c:when test="${pkg.packageStatus eq 'REJECTED'}">반려</c:when>
                                    <c:when test="${pkg.packageStatus eq 'DRAFT'}">임시저장</c:when>
                                    <c:when test="${pkg.packageStatus eq 'BLOCKED'}">차단</c:when>
                                    <c:otherwise>${fn:escapeXml(pkg.packageStatus)}</c:otherwise>
                                </c:choose>
                            </span>
                            <c:if test="${not empty pkg.rejectReason}">
                                <div style="font-size:11px;color:#fca5a5;margin-top:6px;max-width:240px;">
                                    ${fn:escapeXml(pkg.rejectReason)}
                                </div>
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${pkg.packageStatus eq 'PENDING'}">
                                    <div class="business-review-actions">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/packages/${pkg.packageIdx}/approve">
                                            <button type="submit" class="adm-row-btn detail"
                                                    onclick="return confirm('이 패키지를 승인하고 사용자에게 노출할까요?');">승인</button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/packages/${pkg.packageIdx}/reject">
                                            <input class="adm-input" name="rejectReason" maxlength="500" placeholder="반려 사유" required>
                                            <button type="submit" class="adm-row-btn danger">반려</button>
                                        </form>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;font-size:12px;">검토 대기 아님</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty packageList}">
                    <tr>
                        <td colspan="6" style="text-align:center;padding:40px;color:#64748b;">
                            조건에 맞는 패키지 상품이 없습니다.
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
