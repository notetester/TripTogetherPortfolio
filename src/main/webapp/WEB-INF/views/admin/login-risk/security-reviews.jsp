<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="activeMenu" value="securityReviews"/>
<spring:message var="pageTitle" code="security.admin.securityReviews.title"/>
<spring:message var="keywordPlaceholder" code="security.admin.placeholder.accountIpSummary"/>
<spring:message var="reviewTypePlaceholder" code="security.admin.placeholder.reviewType"/>
<spring:message var="manualCommentPlaceholder" code="security.admin.placeholder.reviewComment"/>
<spring:message var="securityReviewApproveComment" code="security.admin.comment.approved"/>
<spring:message var="securityReviewHoldComment" code="security.admin.comment.needMoreCheck"/>
<spring:message var="securityReviewRejectComment" code="security.admin.comment.noAction"/>
<%@ include file="../layout.jsp" %>
<style>
    .review-detail-modal { display:none; position:fixed; inset:0; background:rgba(15,23,42,.45); z-index:2000; align-items:center; justify-content:center; padding:24px; }
    .review-detail-modal.is-open { display:flex; }
    .review-detail-card { width:min(920px, calc(100vw - 48px)); max-height:calc(100vh - 80px); overflow:auto; background:#fff; border-radius:18px; box-shadow:0 24px 80px rgba(15,23,42,.28); padding:24px; }
    .review-detail-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px; margin-top:14px; }
    .review-detail-item { background:#f8fafc; border:1px solid #e2e8f0; border-radius:12px; padding:12px; }
    .review-detail-item strong { display:block; margin-bottom:6px; color:#334155; }
    .review-detail-pre { white-space:pre-wrap; line-height:1.65; }
</style>
<script>
    function openSecurityReviewDetail(id) {
        const modal = document.getElementById(id);
        if (modal) modal.classList.add("is-open");
    }
    function closeSecurityReviewDetail(id) {
        const modal = document.getElementById(id);
        if (modal) modal.classList.remove("is-open");
    }
    document.addEventListener("click", function(e) {
        if (e.target && e.target.classList && e.target.classList.contains("review-detail-modal")) {
            e.target.classList.remove("is-open");
        }
    });
    document.addEventListener("keydown", function(e) {
        if (e.key === "Escape") {
            document.querySelectorAll(".review-detail-modal.is-open").forEach(function(m) {
                m.classList.remove("is-open");
            });
        }
    });
</script>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.securityReviews.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.securityReviews.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments"><spring:message code="security.admin.nav.securityAssessments"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs"><spring:message code="security.admin.nav.providerConfigs"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(5,minmax(0,1fr));gap:10px;">
            <label><spring:message code="security.admin.common.status"/>
                <select class="adm-input" name="status">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                    <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                    <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                </select>
            </label>
            <label><spring:message code="security.admin.common.severity"/>
                <select class="adm-input" name="severity">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="CRITICAL" ${severity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${severity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${severity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${severity == 'LOW' ? 'selected' : ''}>LOW</option>
                </select>
            </label>
            <label><spring:message code="security.admin.common.type"/>
                <input class="adm-input" type="text" name="reviewType" value="${fn:escapeXml(reviewType)}" placeholder="${reviewTypePlaceholder}">
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
                <th><spring:message code="security.admin.common.severity"/></th>
                <th><spring:message code="security.admin.common.reviewType"/></th>
                <th><spring:message code="security.admin.common.target"/></th>
                <th><spring:message code="security.admin.common.summaryEvidence"/></th>
                <th><spring:message code="security.admin.common.createdAt"/></th>
                <th><spring:message code="security.admin.common.action"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${reviews}">
                <tr>
                    <td><span class="adm-badge"><c:out value="${r.reviewStatus}"/></span></td>
                    <td><c:out value="${r.severity}"/></td>
                    <td><c:out value="${r.reviewType}"/><br><small><c:out value="${r.assessmentScope}"/></small></td>
                    <td>
                        <c:out value="${r.subjectType}"/>: <c:out value="${r.subjectKey}"/><br>
                        <c:if test="${not empty r.userId}"><small><c:out value="${r.userId}"/> / <c:out value="${r.nickname}"/></small></c:if>
                    </td>
                    <td>
                        <strong><c:out value="${r.summary}"/></strong><br>
                        <small><c:out value="${r.detailMessage}"/></small>
                        <c:if test="${not empty r.reviewComment}">
                            <br><small><spring:message code="security.admin.common.reviewComment"/>: <c:out value="${r.reviewComment}"/></small>
                        </c:if>
                    </td>
                    <td><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <button class="adm-btn" type="button" onclick="openSecurityReviewDetail('securityReviewDetail${r.reviewIdx}')">
                            <spring:message code="security.admin.common.detail"/>
                        </button>
                        <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-reviews/${r.reviewIdx}/approve" style="display:inline;">
                                <input type="hidden" name="comment" value="${fn:escapeXml(securityReviewApproveComment)}">
                                <button class="adm-btn primary" type="submit"><spring:message code="security.admin.common.approve"/></button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-reviews/${r.reviewIdx}/hold" style="display:inline;">
                                <input type="hidden" name="comment" value="${fn:escapeXml(securityReviewHoldComment)}">
                                <button class="adm-btn" type="submit"><spring:message code="security.admin.common.hold"/></button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-reviews/${r.reviewIdx}/reject" style="display:inline;">
                                <input type="hidden" name="comment" value="${fn:escapeXml(securityReviewRejectComment)}">
                                <button class="adm-btn danger" type="submit"><spring:message code="security.admin.common.reject"/></button>
                            </form>
                        </c:if>
                        <c:if test="${r.reviewStatus != 'PENDING' && r.reviewStatus != 'HOLD'}">
                            <small><c:out value="${r.reviewedByUserId}"/> / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></small>
                        </c:if>
                    </td>
                </tr>
                <tr style="display:none;"><td colspan="7">
                    <div class="review-detail-modal" id="securityReviewDetail${r.reviewIdx}">
                        <div class="review-detail-card" role="dialog" aria-modal="true" aria-labelledby="securityReviewTitle${r.reviewIdx}">
                            <div class="adm-card-header" style="padding:0 0 14px;border-bottom:1px solid #e2e8f0;">
                                <div>
                                    <h2 id="securityReviewTitle${r.reviewIdx}" style="margin:0;"><spring:message code="security.admin.securityReviews.detailTitle"/></h2>
                                    <div class="adm-muted">#<c:out value="${r.reviewIdx}"/> · <c:out value="${r.reviewStatus}"/> · <c:out value="${r.severity}"/></div>
                                </div>
                                <button class="adm-btn" type="button" onclick="closeSecurityReviewDetail('securityReviewDetail${r.reviewIdx}')"><spring:message code="security.admin.common.close"/></button>
                            </div>
                            <div class="review-detail-grid">
                                <div class="review-detail-item">
                                    <strong><spring:message code="security.admin.common.reviewType"/></strong>
                                    <div><c:out value="${r.reviewType}" default="-"/> / <c:out value="${r.assessmentScope}" default="-"/></div>
                                </div>
                                <div class="review-detail-item">
                                    <strong><spring:message code="security.admin.common.target"/></strong>
                                    <div><c:out value="${r.subjectType}" default="-"/>: <c:out value="${r.subjectKey}" default="-"/></div>
                                </div>
                                <div class="review-detail-item">
                                    <strong><spring:message code="security.admin.common.user"/></strong>
                                    <div><c:out value="${r.userId}" default="-"/> / <c:out value="${r.nickname}" default="-"/></div>
                                </div>
                                <div class="review-detail-item">
                                    <strong><spring:message code="security.admin.common.ipAddress"/></strong>
                                    <div><c:out value="${r.ipAddress}" default="-"/></div>
                                </div>
                                <div class="review-detail-item">
                                    <strong><spring:message code="security.admin.common.createdAt"/></strong>
                                    <div><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                </div>
                                <div class="review-detail-item">
                                    <strong><spring:message code="security.admin.common.reviewedBy"/></strong>
                                    <div><c:out value="${r.reviewedByUserId}" default="-"/> / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                </div>
                            </div>
                            <div class="review-detail-item" style="margin-top:12px;">
                                <strong><spring:message code="security.admin.common.summaryEvidence"/></strong>
                                <div class="review-detail-pre"><c:out value="${r.summary}" default="-"/></div>
                            </div>
                            <div class="review-detail-item" style="margin-top:12px;">
                                <strong><spring:message code="security.admin.common.detailMessage"/></strong>
                                <div class="review-detail-pre"><c:out value="${r.detailMessage}" default="-"/></div>
                            </div>
                            <div class="review-detail-item" style="margin-top:12px;">
                                <strong><spring:message code="security.admin.common.reviewComment"/></strong>
                                <div class="review-detail-pre"><c:out value="${r.reviewComment}" default="-"/></div>
                            </div>
                        </div>
                    </div>
                </td></tr>

            </c:forEach>
            <c:if test="${empty reviews}">
                <tr><td colspan="7" class="adm-empty"><spring:message code="security.admin.empty.reviews"/></td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
