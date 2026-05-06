<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:message var="autoMsg_a68f57e9d3" code="security.admin.appeals.title"/>
<spring:message var="autoMsg_e20f6c379c" code="security.admin.appeals.desc"/>
<spring:message var="autoMsg_41b2c66cb0" code="security.admin.nav.appealPolicy"/>
<spring:message var="autoMsg_1afb018f98" code="security.admin.nav.securityAssessments"/>
<spring:message var="autoMsg_f63b5df652" code="security.admin.nav.securityReviews"/>
<spring:message var="autoMsg_7c2793c963" code="security.admin.common.status"/>
<spring:message var="autoMsg_a6e280d954" code="security.admin.common.all"/>
<spring:message var="autoMsg_a4e3dd912d" code="security.admin.common.targetType"/>
<spring:message var="autoMsg_6323fa4cf4" code="security.admin.common.search"/>
<spring:message var="autoMsg_8f477a7d77" code="security.admin.common.user"/>
<spring:message var="autoMsg_8af23f6165" code="security.admin.common.target"/>
<spring:message var="autoMsg_2378563148" code="security.admin.common.titleContent"/>
<spring:message var="autoMsg_c9b50fff01" code="security.admin.common.submittedAt"/>
<spring:message var="autoMsg_fd29393cbe" code="security.admin.common.action"/>
<spring:message var="autoMsg_5e3a9b3898" code="security.admin.common.reviewComment"/>
<spring:message var="autoMsg_0c79a8b4f1" code="security.admin.common.publicRequestId"/>
<spring:message var="autoMsg_175b2b9aca" code="security.admin.common.contactEmail"/>
<spring:message var="autoMsg_d5f4c8bbd9" code="security.admin.common.privateInquiry"/>
<spring:message var="autoMsg_4dcc7ce325" code="security.admin.common.blockAccessRequest"/>
<spring:message var="autoMsg_dc3be70388" code="security.admin.common.blockRequest"/>
<spring:message var="autoMsg_953a0bc963" code="security.admin.common.accept"/>
<spring:message var="autoMsg_797135d529" code="security.admin.common.hold"/>
<spring:message var="autoMsg_de606c2612" code="security.admin.common.rejectAppeal"/>
<spring:message var="autoMsg_68136b8194" code="security.admin.common.closeAppeal"/>
<spring:message var="autoMsg_bdc7d98cc7" code="security.admin.appeals.detail.title"/>
<spring:message var="autoMsg_ff6cf323ba" code="security.admin.common.close"/>
<spring:message var="autoMsg_23a0645217" code="security.admin.common.reviewedBy"/>
<spring:message var="autoMsg_cfc9f2e2a3" code="security.admin.common.updatedAt"/>
<spring:message var="autoMsg_4c3a22d52b" code="security.admin.empty.appeals"/>
<c:set var="activeMenu" value="securityAppeals"/>
<spring:message var="pageTitle" code="security.admin.appeals.title"/>
<spring:message var="keywordPlaceholder" code="security.admin.placeholder.accountTitleTarget"/>
<spring:message var="appealAcceptComment" code="security.admin.comment.appealAccepted"/>
<spring:message var="appealHoldComment" code="security.admin.comment.needMoreCheck"/>
<spring:message var="appealRejectComment" code="security.admin.comment.appealRejected"/>
<spring:message var="appealCloseComment" code="security.admin.comment.appealClosed"/>
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
            <h1>${autoMsg_a68f57e9d3}</h1>
            <p class="adm-page-desc">${autoMsg_e20f6c379c}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/appeal-policy">${autoMsg_41b2c66cb0}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${autoMsg_1afb018f98}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">${autoMsg_f63b5df652}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label>${autoMsg_7c2793c963}
                <select class="adm-input" name="status">
                    <option value="">${autoMsg_a6e280d954}</option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                    <option value="ACCEPTED" ${status == 'ACCEPTED' ? 'selected' : ''}>ACCEPTED</option>
                    <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                    <option value="CLOSED" ${status == 'CLOSED' ? 'selected' : ''}>CLOSED</option>
                </select>
            </label>
            <label>${autoMsg_a4e3dd912d}
                <input class="adm-input" type="text" name="targetType" value="${fn:escapeXml(targetType)}" placeholder="USER_BLOCK">
            </label>
            <label>${autoMsg_6323fa4cf4}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${keywordPlaceholder}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">${autoMsg_6323fa4cf4}</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>${autoMsg_7c2793c963}</th>
                <th>${autoMsg_8f477a7d77}</th>
                <th>${autoMsg_8af23f6165}</th>
                <th>${autoMsg_2378563148}</th>
                <th>${autoMsg_c9b50fff01}</th>
                <th>${autoMsg_fd29393cbe}</th>
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
                            <br><small>${autoMsg_5e3a9b3898}: <c:out value="${a.reviewComment}"/></small>
                        </c:if>
                        <div class="adm-muted" style="margin-top:8px;line-height:1.7;">
                            <small>${autoMsg_0c79a8b4f1}: <c:out value="${a.publicRequestId}" default="-"/></small><br>
                            <small>${autoMsg_175b2b9aca}: <c:out value="${a.submitterEmail}" default="-"/></small><br>
                            <small>${autoMsg_d5f4c8bbd9}: <c:out value="${a.inquiryId}" default="-"/></small><br>
                            <small>${autoMsg_4dcc7ce325}: <c:out value="${a.blockAccessRequestId}" default="-"/></small><br>
                            <small>${autoMsg_dc3be70388}: <c:out value="${a.blockRequestId}" default="-"/></small>
                        </div>
                    </td>
                    <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <button class="adm-btn js-appeal-modal-open" type="button" data-modal-id="appeal-modal-${a.appealIdx}">
                            <spring:message code="security.admin.common.detail"/>
                        </button>
                        <c:if test="${a.appealStatus == 'PENDING' || a.appealStatus == 'HOLD'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/accept" style="display:inline;">
                                <input type="hidden" name="comment" value="${appealAcceptComment}">
                                <button class="adm-btn primary" type="submit">${autoMsg_953a0bc963}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/hold" style="display:inline;">
                                <input type="hidden" name="comment" value="${appealHoldComment}">
                                <button class="adm-btn" type="submit">${autoMsg_797135d529}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/reject" style="display:inline;">
                                <input type="hidden" name="comment" value="${appealRejectComment}">
                                <button class="adm-btn danger" type="submit">${autoMsg_de606c2612}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/close" style="display:inline;">
                                <input type="hidden" name="comment" value="${appealCloseComment}">
                                <button class="adm-btn" type="submit">${autoMsg_68136b8194}</button>
                            </form>
                        </c:if>
                        <c:if test="${a.appealStatus != 'PENDING' && a.appealStatus != 'HOLD'}">
                            <small><c:out value="${a.reviewedByUserId}"/> / <fmt:formatDate value="${a.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></small>
                            <c:if test="${a.appealStatus == 'REJECTED'}">
                                <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/close" style="display:inline;margin-left:6px;">
                                    <input type="hidden" name="comment" value="${appealCloseComment}">
                                    <button class="adm-btn" type="submit">${autoMsg_68136b8194}</button>
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
                                    <h2 id="appeal-modal-title-${a.appealIdx}" style="margin:0;">${autoMsg_bdc7d98cc7}</h2>
                                    <div class="adm-muted">${autoMsg_0c79a8b4f1}: <c:out value="${a.publicRequestId}" default="-"/></div>
                                </div>
                                <button class="appeal-modal-close js-appeal-modal-close" type="button">${autoMsg_ff6cf323ba}</button>
                            </div>
                            <div class="appeal-modal-body">
                                <div class="appeal-modal-grid">
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${autoMsg_7c2793c963}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.appealStatus}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${autoMsg_8f477a7d77}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.userId}" default="-"/> / <c:out value="${a.nickname}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${autoMsg_8af23f6165}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.targetType}" default="-"/> / <c:out value="${a.targetKey}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${autoMsg_175b2b9aca}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.submitterEmail}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${autoMsg_d5f4c8bbd9}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.inquiryId}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${autoMsg_4dcc7ce325}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.blockAccessRequestId}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${autoMsg_dc3be70388}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.blockRequestId}" default="-"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${autoMsg_c9b50fff01}</div>
                                        <div class="appeal-modal-value"><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${autoMsg_23a0645217}</div>
                                        <div class="appeal-modal-value"><c:out value="${a.reviewedByUserId}" default="-"/> / <fmt:formatDate value="${a.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    </div>
                                    <div class="appeal-modal-item">
                                        <div class="appeal-modal-label">${autoMsg_cfc9f2e2a3}</div>
                                        <div class="appeal-modal-value"><fmt:formatDate value="${a.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    </div>
                                </div>
                                <div class="appeal-modal-item" style="margin-top:12px;">
                                    <div class="appeal-modal-label">${autoMsg_2378563148}</div>
                                    <div class="appeal-modal-value"><strong><c:out value="${a.appealTitle}" default="-"/></strong>
<c:out value="${a.appealContent}" default="-"/></div>
                                </div>
                                <div class="appeal-modal-item" style="margin-top:12px;">
                                    <div class="appeal-modal-label">${autoMsg_5e3a9b3898}</div>
                                    <div class="appeal-modal-value"><c:out value="${a.reviewComment}" default="-"/></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </td></tr>
            </c:forEach>
            <c:if test="${empty appeals}">
                <tr><td colspan="6" class="adm-empty">${autoMsg_4c3a22d52b}</td></tr>
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
