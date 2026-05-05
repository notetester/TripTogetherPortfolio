<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="securityAppeals"/>
<spring:message var="pageTitle" code="security.admin.appeals.title"/>
<spring:message var="keywordPlaceholder" code="security.admin.placeholder.accountTitleTarget"/>
<spring:message var="appealAcceptComment" code="security.admin.comment.appealAccepted"/>
<spring:message var="appealHoldComment" code="security.admin.comment.needMoreCheck"/>
<spring:message var="appealRejectComment" code="security.admin.comment.appealRejected"/>
<spring:message var="appealCloseComment" code="security.admin.comment.appealClosed"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.appeals.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.appeals.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments"><spring:message code="security.admin.nav.securityAssessments"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews"><spring:message code="security.admin.nav.securityReviews"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label><spring:message code="security.admin.common.status"/>
                <select class="adm-input" name="status">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                    <option value="ACCEPTED" ${status == 'ACCEPTED' ? 'selected' : ''}>ACCEPTED</option>
                    <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                    <option value="CLOSED" ${status == 'CLOSED' ? 'selected' : ''}>CLOSED</option>
                </select>
            </label>
            <label><spring:message code="security.admin.common.targetType"/>
                <input class="adm-input" type="text" name="targetType" value="${fn:escapeXml(targetType)}" placeholder="USER_BLOCK">
            </label>
            <label><spring:message code="security.admin.common.search"/>
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${keywordPlaceholder}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit"><spring:message code="security.admin.common.search"/></button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th><spring:message code="security.admin.common.status"/></th>
                <th><spring:message code="security.admin.common.user"/></th>
                <th><spring:message code="security.admin.common.target"/></th>
                <th><spring:message code="security.admin.common.titleContent"/></th>
                <th><spring:message code="security.admin.common.submittedAt"/></th>
                <th><spring:message code="security.admin.common.action"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${appeals}">
                <tr>
                    <td><span class="adm-badge"><c:out value="${a.appealStatus}"/></span></td>
                    <td>
                        <c:choose>
                            <c:when test="${empty a.userId}">-</c:when>
                            <c:otherwise><c:out value="${a.userId}"/></c:otherwise>
                        </c:choose>
                        <br>
                        <small>
                            <c:choose>
                                <c:when test="${empty a.nickname}">-</c:when>
                                <c:otherwise><c:out value="${a.nickname}"/></c:otherwise>
                            </c:choose>
                        </small>
                    </td>
                    <td><c:out value="${a.targetType}"/><br><small><c:out value="${a.targetKey}"/></small></td>
                    <td>
                        <strong><c:out value="${a.appealTitle}"/></strong><br>
                        <small><c:out value="${a.appealContent}"/></small>
                        <c:if test="${not empty a.reviewComment}">
                            <br><small><spring:message code="security.admin.common.reviewComment"/>: <c:out value="${a.reviewComment}"/></small>
                        </c:if>
                        <div class="adm-muted" style="margin-top:8px;line-height:1.7;">
                            <small><spring:message code="security.admin.common.publicRequestId"/>: <c:out value="${a.publicRequestId}" default="-"/></small><br>
                            <small><spring:message code="security.admin.common.contactEmail"/>: <c:out value="${a.submitterEmail}" default="-"/></small><br>
                            <small><spring:message code="security.admin.common.privateInquiry"/>: <c:out value="${a.inquiryId}" default="-"/></small><br>
                            <small><spring:message code="security.admin.common.blockAccessRequest"/>: <c:out value="${a.blockAccessRequestId}" default="-"/></small><br>
                            <small><spring:message code="security.admin.common.blockRequest"/>: <c:out value="${a.blockRequestId}" default="-"/></small>
                        </div>
                    </td>
                    <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:if test="${a.appealStatus == 'PENDING' || a.appealStatus == 'HOLD'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/accept" style="display:inline;">
                                <input type="hidden" name="comment" value="${appealAcceptComment}">
                                <button class="adm-btn primary" type="submit"><spring:message code="security.admin.common.accept"/></button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/hold" style="display:inline;">
                                <input type="hidden" name="comment" value="${appealHoldComment}">
                                <button class="adm-btn" type="submit"><spring:message code="security.admin.common.hold"/></button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/reject" style="display:inline;">
                                <input type="hidden" name="comment" value="${appealRejectComment}">
                                <button class="adm-btn danger" type="submit"><spring:message code="security.admin.common.rejectAppeal"/></button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/close" style="display:inline;">
                                <input type="hidden" name="comment" value="${appealCloseComment}">
                                <button class="adm-btn" type="submit"><spring:message code="security.admin.common.closeAppeal"/></button>
                            </form>

                        </c:if>
                        <c:if test="${a.appealStatus != 'PENDING' && a.appealStatus != 'HOLD'}">
                            <small><c:out value="${a.reviewedByUserId}"/> / <fmt:formatDate value="${a.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></small>
                            <c:if test="${a.appealStatus == 'REJECTED'}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/close" style="display:inline;margin-left:6px;">
                                    <input type="hidden" name="comment" value="${appealCloseComment}">
                                    <button class="adm-btn" type="submit"><spring:message code="security.admin.common.closeAppeal"/></button>
                                </form>
                            </c:if>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty appeals}">
                <tr><td colspan="6" class="adm-empty"><spring:message code="security.admin.empty.appeals"/></td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
