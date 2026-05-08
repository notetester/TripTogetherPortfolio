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
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(reviews)}"/>
<c:set var="pageTitle" value="${msg_security_admin_securityReviews_title}"/>
<c:set var="activeMenu" value="securityReviews"/>


<%@ include file="../layout.jsp" %>
<script>
    function openSecurityReviewDetail(id) {
        const modal = document.getElementById(id);
        if (modal) modal.classList.add("is-open");
    }
    function closeSecurityReviewDetail(id) {
        const modal = document.getElementById(id);
        if (modal) modal.classList.remove("is-open");
    }
    function sortStaticAdminTable(tableId, columnIndex) {
        const table = document.getElementById(tableId);
        const tbody = table ? table.querySelector("tbody") : null;
        if (!tbody) return;
        const prevIndex = Number(table.dataset.sortIndex || -1);
        const prevDir = table.dataset.sortDir || "ASC";
        const nextDir = prevIndex === columnIndex && prevDir === "ASC" ? "DESC" : "ASC";
        table.dataset.sortIndex = String(columnIndex);
        table.dataset.sortDir = nextDir;
        Array.from(tbody.querySelectorAll("tr"))
            .filter(function(row) { return row.children.length > columnIndex && !row.querySelector("td[colspan]"); })
            .sort(function(a, b) {
                const av = (a.children[columnIndex].innerText || "").replace(/\s+/g, " ").trim();
                const bv = (b.children[columnIndex].innerText || "").replace(/\s+/g, " ").trim();
                return av.localeCompare(bv, undefined, { numeric: true, sensitivity: "base" }) * (nextDir === "ASC" ? 1 : -1);
            })
            .forEach(function(row) { tbody.appendChild(row); });
        table.querySelectorAll("th").forEach(function(th, idx) {
            const ico = th.querySelector(".sort-ico");
            if (ico) ico.textContent = idx === columnIndex ? (nextDir === "ASC" ? "▲" : "▼") : "";
        });
    }
    function openFirstSecurityReviewDetail() {
        const button = document.querySelector("#securityReviewTable .js-security-review-detail-open");
        if (button) openSecurityReviewDetail(button.getAttribute("data-target"));
    }
    document.addEventListener("click", function(e) {
        const openButton = e.target.closest(".js-security-review-detail-open");
        if (openButton) {
            openSecurityReviewDetail(openButton.getAttribute("data-target"));
            return;
        }
        const closeButton = e.target.closest(".js-security-review-detail-close");
        if (closeButton) {
            closeSecurityReviewDetail(closeButton.getAttribute("data-target"));
            return;
        }
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

<div class="adm-content adm-governance-page adm-security-review-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_securityReviews_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_securityReviews_desc}</p>
        </div>
        <div class="adm-actions adm-security-review-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${msg_security_admin_nav_providerConfigs}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card adm-security-review-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-security-review-filterbar">
                <label>${msg_security_admin_common_status}
                    <select class="adm-select" name="status">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                        <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                        <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                        <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                    </select>
                </label>
                <label>${msg_security_admin_common_severity}
                    <select class="adm-select" name="severity">
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
                <label class="adm-security-review-keyword-field">${msg_security_admin_common_search}
                    <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_accountIpSummary}">
                </label>
                <div class="adm-security-review-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-security-review-list-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_security_admin_securityReviews_title}</div>
            <div class="adm-page-muted">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-table-wrap">
            <table id="securityReviewTable"
                   class="adm-table adm-section-table-fixed adm-security-review-table"
                   data-section="securityReviews">
                <thead>
                <tr>
                    <th onclick="sortStaticAdminTable('securityReviewTable', 0)">${msg_security_admin_common_status}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityReviewTable', 1)">${msg_security_admin_common_severity}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityReviewTable', 2)">${msg_security_admin_common_reviewType}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityReviewTable', 3)">${msg_security_admin_common_target}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityReviewTable', 4)">${msg_security_admin_common_summaryEvidence}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityReviewTable', 5)">${msg_security_admin_common_createdAt}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="openFirstSecurityReviewDetail()">${msg_security_admin_common_action}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="r" items="${reviews}">
                    <tr>
                        <td><span class="adm-badge"><c:out value="${r.reviewStatus}"/></span></td>
                        <td><div class="adm-security-review-primary"><c:out value="${r.severity}"/></div></td>
                        <td>
                            <div class="adm-security-review-primary"><c:out value="${r.reviewType}"/></div>
                            <div class="adm-page-muted"><c:out value="${r.assessmentScope}"/></div>
                        </td>
                        <td>
                            <div><c:out value="${r.subjectType}"/>: <c:out value="${r.subjectKey}"/></div>
                            <c:if test="${not empty r.userId}"><div class="adm-page-muted"><c:out value="${r.userId}"/> / <c:out value="${r.nickname}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-security-review-summary">
                                <strong><c:out value="${r.summary}"/></strong>
                                <span><c:out value="${r.detailMessage}"/></span>
                                <c:if test="${not empty r.reviewComment}">
                                    <span>${msg_security_admin_common_reviewComment}: <c:out value="${r.reviewComment}"/></span>
                                </c:if>
                            </div>
                        </td>
                        <td><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <div class="adm-security-review-row-actions">
                                <button class="adm-btn adm-btn-ghost js-security-review-detail-open" type="button" data-target="securityReviewDetail${r.reviewIdx}">
                                    ${msg_security_admin_common_detail}
                                </button>
                                <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-reviews/${r.reviewIdx}/approve">
                                        <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_approved)}">
                                        <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_approve}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-reviews/${r.reviewIdx}/hold">
                                        <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_needMoreCheck)}">
                                        <button class="adm-btn adm-btn-ghost" type="submit">${msg_security_admin_common_hold}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-reviews/${r.reviewIdx}/reject">
                                        <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_noAction)}">
                                        <button class="adm-btn adm-btn-danger" type="submit">${msg_security_admin_common_reject}</button>
                                    </form>
                                </c:if>
                                <c:if test="${r.reviewStatus != 'PENDING' && r.reviewStatus != 'HOLD'}">
                                    <div class="adm-page-muted"><c:out value="${r.reviewedByUserId}"/> / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <tr class="adm-local-empty"><td colspan="7" class="adm-local-empty-cell">${msg_security_admin_empty_reviews}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <c:forEach var="r" items="${reviews}">
            <div class="review-detail-modal" id="securityReviewDetail${r.reviewIdx}">
                <div class="review-detail-card" role="dialog" aria-modal="true" aria-labelledby="securityReviewTitle${r.reviewIdx}">
                    <div class="review-detail-head">
                        <div>
                            <h2 id="securityReviewTitle${r.reviewIdx}" class="review-detail-title">${msg_security_admin_securityReviews_detailTitle}</h2>
                            <div class="adm-page-muted">#<c:out value="${r.reviewIdx}"/> · <c:out value="${r.reviewStatus}"/> · <c:out value="${r.severity}"/></div>
                        </div>
                        <button class="adm-btn js-security-review-detail-close" type="button" data-target="securityReviewDetail${r.reviewIdx}">${msg_security_admin_common_close}</button>
                    </div>
                    <div class="review-detail-body">
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
                        <div class="review-detail-item">
                            <strong>${msg_security_admin_common_summaryEvidence}</strong>
                            <div class="review-detail-pre"><c:out value="${r.summary}" default="-"/></div>
                        </div>
                        <div class="review-detail-item">
                            <strong>${msg_security_admin_common_detailMessage}</strong>
                            <div class="review-detail-pre"><c:out value="${r.detailMessage}" default="-"/></div>
                        </div>
                        <div class="review-detail-item">
                            <strong>${msg_security_admin_common_reviewComment}</strong>
                            <div class="review-detail-pre"><c:out value="${r.reviewComment}" default="-"/></div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
