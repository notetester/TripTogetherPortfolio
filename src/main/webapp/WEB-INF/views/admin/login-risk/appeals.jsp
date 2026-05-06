<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_appeals_title" code="security.admin.appeals.title"/>
<spring:message var="msg_security_admin_placeholder_accountTitleTarget" code="security.admin.placeholder.accountTitleTarget"/>
<spring:message var="msg_security_admin_comment_appealAccepted" code="security.admin.comment.appealAccepted"/>
<spring:message var="msg_security_admin_comment_needMoreCheck" code="security.admin.comment.needMoreCheck"/>
<spring:message var="msg_security_admin_comment_appealRejected" code="security.admin.comment.appealRejected"/>
<spring:message var="msg_security_admin_comment_appealClosed" code="security.admin.comment.appealClosed"/>
<spring:message var="msg_security_admin_appeals_desc" code="security.admin.appeals.desc"/>
<spring:message var="msg_security_admin_nav_appealPolicy" code="security.admin.nav.appealPolicy"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_nav_securityReviews" code="security.admin.nav.securityReviews"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_targetType" code="security.admin.common.targetType"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_user" code="security.admin.common.user"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_titleContent" code="security.admin.common.titleContent"/>
<spring:message var="msg_security_admin_common_submittedAt" code="security.admin.common.submittedAt"/>
<spring:message var="msg_security_admin_common_action" code="security.admin.common.action"/>
<spring:message var="msg_security_admin_common_reviewComment" code="security.admin.common.reviewComment"/>
<spring:message var="msg_security_admin_common_publicRequestId" code="security.admin.common.publicRequestId"/>
<spring:message var="msg_security_admin_common_contactEmail" code="security.admin.common.contactEmail"/>
<spring:message var="msg_security_admin_common_privateInquiry" code="security.admin.common.privateInquiry"/>
<spring:message var="msg_security_admin_common_blockAccessRequest" code="security.admin.common.blockAccessRequest"/>
<spring:message var="msg_security_admin_common_blockRequest" code="security.admin.common.blockRequest"/>
<spring:message var="msg_security_admin_common_detail" code="security.admin.common.detail"/>
<spring:message var="msg_security_admin_common_accept" code="security.admin.common.accept"/>
<spring:message var="msg_security_admin_common_hold" code="security.admin.common.hold"/>
<spring:message var="msg_security_admin_common_rejectAppeal" code="security.admin.common.rejectAppeal"/>
<spring:message var="msg_security_admin_common_closeAppeal" code="security.admin.common.closeAppeal"/>
<spring:message var="msg_security_admin_appeals_detail_title" code="security.admin.appeals.detail.title"/>
<spring:message var="msg_security_admin_common_close" code="security.admin.common.close"/>
<spring:message var="msg_security_admin_common_reviewedBy" code="security.admin.common.reviewedBy"/>
<spring:message var="msg_security_admin_common_updatedAt" code="security.admin.common.updatedAt"/>
<spring:message var="msg_security_admin_empty_appeals" code="security.admin.empty.appeals"/>
<c:set var="pageTitle" value="${msg_security_admin_appeals_title}"/>
<c:set var="activeMenu" value="securityAppeals"/>


<%@ include file="../layout.jsp" %>

<style>
    .appeal-modal-backdrop[hidden] { display:none; }
    .appeal-modal-backdrop { position:fixed; inset:0; z-index:2000; background:rgba(15,23,42,.55); display:flex; align-items:center; justify-content:center; padding:24px; }
    .appeal-modal-card { width:min(920px, 96vw); max-height:88vh; overflow:auto; background:#fff; border-radius:20px; box-shadow:0 24px 70px rgba(15,23,42,.28); border:1px solid #e2e8f0; }
    .appeal-modal-head { display:flex; justify-content:space-between; gap:12px; align-items:flex-start; padding:20px 22px; border-bottom:1px solid #e2e8f0; }
    .appeal-modal-body { padding:20px 22px; }
    .appeal-modal-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px; }
    .appeal-modal-item { border:1px solid #e2e8f0; border-radius:14px; padding:12px; background:#f8fafc; }
    .appeal-modal-label { font-size:12px; color:#64748b; font-weight:700; margin-bottom:6px; }
    .appeal-modal-value { white-space:pre-wrap; color:#0f172a; word-break:break-word; }
    .appeal-modal-close { border:0; background:#e2e8f0; border-radius:10px; padding:8px 12px; cursor:pointer; font-weight:800; }
    @media (max-width: 720px) { .appeal-modal-grid { grid-template-columns:1fr; } }
</style>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_appeals_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_appeals_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/appeal-policy">${msg_security_admin_nav_appealPolicy}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">${msg_security_admin_nav_securityReviews}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label>${msg_security_admin_common_status}
                <select class="adm-input" name="status">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                    <option value="ACCEPTED" ${status == 'ACCEPTED' ? 'selected' : ''}>ACCEPTED</option>
                    <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                    <option value="CLOSED" ${status == 'CLOSED' ? 'selected' : ''}>CLOSED</option>
                </select>
            </label>
            <label>${msg_security_admin_common_targetType}
                <input class="adm-input" type="text" name="targetType" value="${fn:escapeXml(targetType)}" placeholder="USER_BLOCK">
            </label>
            <label>${msg_security_admin_common_search}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_accountTitleTarget}">
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
                <th>${msg_security_admin_common_user}</th>
                <th>${msg_security_admin_common_target}</th>
                <th>${msg_security_admin_common_titleContent}</th>
                <th>${msg_security_admin_common_submittedAt}</th>
                <th>${msg_security_admin_common_action}</th>
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
                            <br><small>${msg_security_admin_common_reviewComment}: <c:out value="${a.reviewComment}"/></small>
                        </c:if>
                        <div class="adm-muted" style="margin-top:8px;line-height:1.7;">
                            <small>${msg_security_admin_common_publicRequestId}: <c:out value="${a.publicRequestId}" default="-"/></small><br>
                            <small>${msg_security_admin_common_contactEmail}: <c:out value="${a.submitterEmail}" default="-"/></small><br>
                            <small>${msg_security_admin_common_privateInquiry}: <c:out value="${a.inquiryId}" default="-"/></small><br>
                            <small>${msg_security_admin_common_blockAccessRequest}: <c:out value="${a.blockAccessRequestId}" default="-"/></small><br>
                            <small>${msg_security_admin_common_blockRequest}: <c:out value="${a.blockRequestId}" default="-"/></small>
                        </div>
                    </td>
                    <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <button class="adm-btn js-appeal-modal-open" type="button" data-modal-id="appeal-modal-${a.appealIdx}">
                            ${msg_security_admin_common_detail}
                        </button>
                        <c:if test="${a.appealStatus == 'PENDING' || a.appealStatus == 'HOLD'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/accept" style="display:inline;">
                                <input type="hidden" name="comment" value="${msg_security_admin_comment_appealAccepted}">
                                <button class="adm-btn primary" type="submit">${msg_security_admin_common_accept}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/hold" style="display:inline;">
                                <input type="hidden" name="comment" value="${msg_security_admin_comment_needMoreCheck}">
                                <button class="adm-btn" type="submit">${msg_security_admin_common_hold}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/reject" style="display:inline;">
                                <input type="hidden" name="comment" value="${msg_security_admin_comment_appealRejected}">
                                <button class="adm-btn danger" type="submit">${msg_security_admin_common_rejectAppeal}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/close" style="display:inline;">
                                <input type="hidden" name="comment" value="${msg_security_admin_comment_appealClosed}">
                                <button class="adm-btn" type="submit">${msg_security_admin_common_closeAppeal}</button>
                            </form>
                        </c:if>
                        <c:if test="${a.appealStatus != 'PENDING' && a.appealStatus != 'HOLD'}">
                            <small><c:out value="${a.reviewedByUserId}"/> / <fmt:formatDate value="${a.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></small>
                            <c:if test="${a.appealStatus == 'REJECTED'}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/close" style="display:inline;margin-left:6px;">
                                    <input type="hidden" name="comment" value="${msg_security_admin_comment_appealClosed}">
                                    <button class="adm-btn" type="submit">${msg_security_admin_common_closeAppeal}</button>
                                </form>
                            </c:if>
                        </c:if>
                    </td>
                </tr>
                <tr style="display:none;"><td colspan="6">
                    <div class="appeal-modal-backdrop" id="appeal-modal-${a.appealIdx}" hidden>
                        <div class="appeal-modal-card" role="dialog" aria-modal="true" aria-labelledby="appeal-modal-title-${a.appealIdx}">
                            <div class="appeal-modal-head">
                                <div>
                                    <h2 id="appeal-modal-title-${a.appealIdx}" style="margin:0;">${msg_security_admin_appeals_detail_title}</h2>
                                    <div class="adm-muted">${msg_security_admin_common_publicRequestId}: <c:out value="${a.publicRequestId}" default="-"/></div>
                                </div>
                                <button class="appeal-modal-close js-appeal-modal-close" type="button">${msg_security_admin_common_close}</button>
                            </div>
                            <div class="appeal-modal-body">
                                <div class="appeal-modal-grid">
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${msg_security_admin_common_status}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.appealStatus}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${msg_security_admin_common_user}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.userId}" default="-"/> / <c:out value="${a.nickname}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${msg_security_admin_common_target}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.targetType}" default="-"/> / <c:out value="${a.targetKey}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${msg_security_admin_common_contactEmail}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.submitterEmail}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${msg_security_admin_common_privateInquiry}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.inquiryId}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${msg_security_admin_common_blockAccessRequest}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.blockAccessRequestId}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${msg_security_admin_common_blockRequest}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.blockRequestId}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${msg_security_admin_common_submittedAt}</div>
                                        <div class="appeal-modal-value"><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${msg_security_admin_common_reviewedBy}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.reviewedByUserId}" default="-"/> / <fmt:formatDate value="${a.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${msg_security_admin_common_updatedAt}</div>
                                        <div class="appeal-modal-value"><fmt:formatDate value="${a.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    </div>
                                </div>
                                <div class="appeal-modal-item" style="margin-top:12px;">
                                    <div class="appeal-modal-label">${msg_security_admin_common_titleContent}</div>
                                    <div class="appeal-modal-value"><strong><c:out value="${a.appealTitle}" default="-"/></strong>
<c:out value="${a.appealContent}" default="-"/></div>
                                </div>
                                <div class="appeal-modal-item" style="margin-top:12px;">
                                    <div class="appeal-modal-label">${msg_security_admin_common_reviewComment}</div>
                                    <div class="appeal-modal-value"><c:out value="${a.reviewComment}" default="-"/></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </td></tr>
            </c:forEach>
            <c:if test="${empty appeals}">
                <tr><td colspan="6" class="adm-empty">${msg_security_admin_empty_appeals}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<script>
(function () {
    const closeModal = function (modal) {
        if (modal) modal.hidden = true;
    };
    const openModal = function (modal) {
        if (modal) modal.hidden = false;
    };
    document.querySelectorAll('.js-appeal-modal-open').forEach(function (button) {
        button.addEventListener('click', function () {
            openModal(document.getElementById(button.dataset.modalId));
        });
    });
    document.querySelectorAll('.js-appeal-modal-close').forEach(function (button) {
        button.addEventListener('click', function () {
            closeModal(button.closest('.appeal-modal-backdrop'));
        });
    });
    document.querySelectorAll('.appeal-modal-backdrop').forEach(function (backdrop) {
        backdrop.addEventListener('click', function (event) {
            if (event.target === backdrop) closeModal(backdrop);
        });
    });
    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            document.querySelectorAll('.appeal-modal-backdrop:not([hidden])').forEach(closeModal);
        }
    });
})();
</script>
