<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_securityReviews_title" code="security.admin.securityReviews.title"/>
<spring:message var="msg_security_admin_placeholder_accountIpSummary" code="security.admin.placeholder.accountIpSummary"/>
<spring:message var="msg_security_admin_placeholder_reviewType" code="security.admin.placeholder.reviewType"/>
<spring:message var="msg_security_admin_placeholder_reviewComment" code="security.admin.placeholder.reviewComment"/>
<spring:message var="msg_security_admin_comment_approved" code="security.admin.comment.approved"/>
<spring:message var="msg_security_admin_comment_needMoreCheck" code="security.admin.comment.needMoreCheck"/>
<spring:message var="msg_security_admin_comment_noAction" code="security.admin.comment.noAction"/>
<spring:message var="msg_security_admin_securityReviews_desc" code="security.admin.securityReviews.desc"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_nav_providerConfigs" code="security.admin.nav.providerConfigs"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_severity" code="security.admin.common.severity"/>
<spring:message var="msg_security_admin_common_type" code="security.admin.common.type"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_reviewType" code="security.admin.common.reviewType"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_summaryEvidence" code="security.admin.common.summaryEvidence"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_common_action" code="security.admin.common.action"/>
<spring:message var="msg_security_admin_common_reviewComment" code="security.admin.common.reviewComment"/>
<spring:message var="msg_security_admin_common_detail" code="security.admin.common.detail"/>
<spring:message var="msg_security_admin_common_approve" code="security.admin.common.approve"/>
<spring:message var="msg_security_admin_common_hold" code="security.admin.common.hold"/>
<spring:message var="msg_security_admin_common_reject" code="security.admin.common.reject"/>
<spring:message var="msg_security_admin_securityReviews_detailTitle" code="security.admin.securityReviews.detailTitle"/>
<spring:message var="msg_security_admin_common_close" code="security.admin.common.close"/>
<spring:message var="msg_security_admin_common_user" code="security.admin.common.user"/>
<spring:message var="msg_security_admin_common_ipAddress" code="security.admin.common.ipAddress"/>
<spring:message var="msg_security_admin_common_reviewedBy" code="security.admin.common.reviewedBy"/>
<spring:message var="msg_security_admin_common_detailMessage" code="security.admin.common.detailMessage"/>
<spring:message var="msg_security_admin_empty_reviews" code="security.admin.empty.reviews"/>
<c:set var="pageTitle" value="${msg_security_admin_securityReviews_title}"/>
<c:set var="activeMenu" value="securityReviews"/>


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
            <h1>${msg_security_admin_securityReviews_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_securityReviews_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${msg_security_admin_nav_providerConfigs}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(5,minmax(0,1fr));gap:10px;">
            <label>${msg_security_admin_common_status}
                <select class="adm-input" name="status">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                    <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                    <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                </select>
            </label>
            <label>${msg_security_admin_common_severity}
                <select class="adm-input" name="severity">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="CRITICAL" ${severity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${severity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${severity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${severity == 'LOW' ? 'selected' : ''}>LOW</option>
                </select>
            </label>
            <label>${msg_security_admin_common_type}
                <input class="adm-input" type="text" name="reviewType" value="${fn:escapeXml(reviewType)}" placeholder="${msg_security_admin_placeholder_reviewType}">
            </label>
            <label>${msg_security_admin_common_search}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_accountIpSummary}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">${msg_security_admin_common_search}</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>${msg_security_admin_common_status}</th>
                <th>${msg_security_admin_common_severity}</th>
                <th>${msg_security_admin_common_reviewType}</th>
                <th>${msg_security_admin_common_target}</th>
                <th>${msg_security_admin_common_summaryEvidence}</th>
                <th>${msg_security_admin_common_createdAt}</th>
                <th>${msg_security_admin_common_action}</th>
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
                            <br><small>${msg_security_admin_common_reviewComment}: <c:out value="${r.reviewComment}"/></small>
                        </c:if>
                    </td>
                    <td><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <button class="adm-btn" type="button" onclick="openSecurityReviewDetail('securityReviewDetail${r.reviewIdx}')">
                            ${msg_security_admin_common_detail}
                        </button>
                        <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-reviews/${r.reviewIdx}/approve" style="display:inline;">
                                <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_approved)}">
                                <button class="adm-btn primary" type="submit">${msg_security_admin_common_approve}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-reviews/${r.reviewIdx}/hold" style="display:inline;">
                                <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_needMoreCheck)}">
                                <button class="adm-btn" type="submit">${msg_security_admin_common_hold}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-reviews/${r.reviewIdx}/reject" style="display:inline;">
                                <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_noAction)}">
                                <button class="adm-btn danger" type="submit">${msg_security_admin_common_reject}</button>
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
                                    <h2 id="securityReviewTitle${r.reviewIdx}" style="margin:0;">${msg_security_admin_securityReviews_detailTitle}</h2>
                                    <div class="adm-muted">#<c:out value="${r.reviewIdx}"/> · <c:out value="${r.reviewStatus}"/> · <c:out value="${r.severity}"/></div>
                                </div>
                                <button class="adm-btn" type="button" onclick="closeSecurityReviewDetail('securityReviewDetail${r.reviewIdx}')">${msg_security_admin_common_close}</button>
                            </div>
                            <div class="review-detail-grid">
                                <div class="review-detail-item">
                                    <strong>${msg_security_admin_common_reviewType}</strong>
                                    <div><c:out value="${r.reviewType}" default="-"/> / <c:out value="${r.assessmentScope}" default="-"/></div>
                                </div>
                                <div class="review-detail-item">
                                    <strong>${msg_security_admin_common_target}</strong>
                                    <div><c:out value="${r.subjectType}" default="-"/>: <c:out value="${r.subjectKey}" default="-"/></div>
                                </div>
                                <div class="review-detail-item">
                                    <strong>${msg_security_admin_common_user}</strong>
                                    <div><c:out value="${r.userId}" default="-"/> / <c:out value="${r.nickname}" default="-"/></div>
                                </div>
                                <div class="review-detail-item">
                                    <strong>${msg_security_admin_common_ipAddress}</strong>
                                    <div><c:out value="${r.ipAddress}" default="-"/></div>
                                </div>
                                <div class="review-detail-item">
                                    <strong>${msg_security_admin_common_createdAt}</strong>
                                    <div><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                </div>
                                <div class="review-detail-item">
                                    <strong>${msg_security_admin_common_reviewedBy}</strong>
                                    <div><c:out value="${r.reviewedByUserId}" default="-"/> / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                </div>
                            </div>
                            <div class="review-detail-item" style="margin-top:12px;">
                                <strong>${msg_security_admin_common_summaryEvidence}</strong>
                                <div class="review-detail-pre"><c:out value="${r.summary}" default="-"/></div>
                            </div>
                            <div class="review-detail-item" style="margin-top:12px;">
                                <strong>${msg_security_admin_common_detailMessage}</strong>
                                <div class="review-detail-pre"><c:out value="${r.detailMessage}" default="-"/></div>
                            </div>
                            <div class="review-detail-item" style="margin-top:12px;">
                                <strong>${msg_security_admin_common_reviewComment}</strong>
                                <div class="review-detail-pre"><c:out value="${r.reviewComment}" default="-"/></div>
                            </div>
                        </div>
                    </div>
                </td></tr>

            </c:forEach>
            <c:if test="${empty reviews}">
                <tr><td colspan="7" class="adm-empty">${msg_security_admin_empty_reviews}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
