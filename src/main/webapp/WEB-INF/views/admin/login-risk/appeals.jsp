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
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(appeals)}"/>
<c:set var="pageTitle" value="${msg_security_admin_appeals_title}"/>
<c:set var="activeMenu" value="securityAppeals"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-appeal-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_appeals_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_appeals_desc}</p>
        </div>
        <div class="adm-actions adm-appeal-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/appeal-policy">${msg_security_admin_nav_appealPolicy}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">${msg_security_admin_nav_securityReviews}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card adm-appeal-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-appeal-filterbar">
                <label>${msg_security_admin_common_status}
                    <select class="adm-select" name="status">
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
                <label class="adm-appeal-keyword-field">${msg_security_admin_common_search}
                    <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_accountTitleTarget}">
                </label>
                <div class="adm-appeal-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/appeals">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-appeal-list-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_security_admin_appeals_title}</div>
            <div class="adm-page-muted">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-appeal-bulk-actions">
            <span class="adm-page-muted">${msg_security_admin_common_action}</span>
            <button type="button" class="adm-btn adm-btn-primary js-appeal-bulk-action"
                    data-decision="accept"
                    data-comment="${fn:escapeXml(msg_security_admin_comment_appealAccepted)}">${msg_security_admin_common_accept}</button>
            <button type="button" class="adm-btn adm-btn-ghost js-appeal-bulk-action"
                    data-decision="hold"
                    data-comment="${fn:escapeXml(msg_security_admin_comment_needMoreCheck)}">${msg_security_admin_common_hold}</button>
            <button type="button" class="adm-btn adm-btn-danger js-appeal-bulk-action"
                    data-decision="reject"
                    data-comment="${fn:escapeXml(msg_security_admin_comment_appealRejected)}">${msg_security_admin_common_rejectAppeal}</button>
            <button type="button" class="adm-btn adm-btn-ghost js-appeal-bulk-action"
                    data-decision="close"
                    data-comment="${fn:escapeXml(msg_security_admin_comment_appealClosed)}">${msg_security_admin_common_closeAppeal}</button>
        </div>
        <div class="adm-table-wrap">
            <table id="securityAppealTable"
                   class="adm-table adm-section-table-fixed adm-appeal-table ap-table"
                   data-section="securityAppeals"
                   data-admin-list-ignore="hard">
                <colgroup>
                    <col class="ap-col-check"/>
                    <col class="ap-col-status"/>
                    <col class="ap-col-user"/>
                    <col class="ap-col-target"/>
                    <col class="ap-col-content"/>
                    <col class="ap-col-date"/>
                    <col class="ap-col-action"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="ap-th ap-th-check"><input type="checkbox" aria-label="전체 선택"></th>
                    <th class="ap-th" onclick="sortStaticAdminTable('securityAppealTable', 1)"><span class="ap-th-label">${msg_security_admin_common_status}</span><span class="ap-sort-ico" aria-hidden="true"></span></th>
                    <th class="ap-th" onclick="sortStaticAdminTable('securityAppealTable', 2)"><span class="ap-th-label">${msg_security_admin_common_user}</span><span class="ap-sort-ico" aria-hidden="true"></span></th>
                    <th class="ap-th" onclick="sortStaticAdminTable('securityAppealTable', 3)"><span class="ap-th-label">${msg_security_admin_common_target}</span><span class="ap-sort-ico" aria-hidden="true"></span></th>
                    <th class="ap-th" onclick="sortStaticAdminTable('securityAppealTable', 4)"><span class="ap-th-label">${msg_security_admin_common_titleContent}</span><span class="ap-sort-ico" aria-hidden="true"></span></th>
                    <th class="ap-th" onclick="sortStaticAdminTable('securityAppealTable', 5)"><span class="ap-th-label">${msg_security_admin_common_submittedAt}</span><span class="ap-sort-ico" aria-hidden="true"></span></th>
                    <th class="ap-th" onclick="openFirstAppealDetail()"><span class="ap-th-label">${msg_security_admin_common_action}</span></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="a" items="${appeals}">
                    <tr data-appeal-id="${a.appealIdx}">
                        <td class="ap-cell-check"><input type="checkbox" aria-label="행 선택"></td>
                        <td><span class="adm-badge"><c:out value="${a.appealStatus}"/></span></td>
                        <td>
                            <div class="adm-appeal-primary">
                                <c:choose>
                                    <c:when test="${empty a.userId}">-</c:when>
                                    <c:otherwise><c:out value="${a.userId}"/></c:otherwise>
                                </c:choose>
                            </div>
                            <div class="adm-page-muted">
                                <c:choose>
                                    <c:when test="${empty a.nickname}">-</c:when>
                                    <c:otherwise><c:out value="${a.nickname}"/></c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                        <td>
                            <div class="adm-appeal-primary"><c:out value="${a.targetType}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.targetKey}"/></div>
                        </td>
                        <td>
                            <div class="adm-appeal-summary">
                                <button class="adm-appeal-title-link js-appeal-modal-open" type="button" data-modal-id="appeal-modal-${a.appealIdx}">
                                    <c:out value="${a.appealTitle}"/>
                                </button>
                                <span class="adm-appeal-content-preview"><c:out value="${a.appealContent}"/></span>
                                <c:if test="${not empty a.reviewComment}">
                                    <span class="adm-appeal-review-preview">${msg_security_admin_common_reviewComment}: <c:out value="${a.reviewComment}"/></span>
                                </c:if>
                            </div>
                            <div class="adm-appeal-meta-grid">
                                <span>${msg_security_admin_common_publicRequestId}: <c:out value="${a.publicRequestId}" default="-"/></span>
                                <span>${msg_security_admin_common_contactEmail}: <c:out value="${a.submitterEmail}" default="-"/></span>
                                <span>${msg_security_admin_common_privateInquiry}: <c:out value="${a.inquiryId}" default="-"/></span>
                                <span>${msg_security_admin_common_blockAccessRequest}: <c:out value="${a.blockAccessRequestId}" default="-"/></span>
                                <span>${msg_security_admin_common_blockRequest}: <c:out value="${a.blockRequestId}" default="-"/></span>
                            </div>
                        </td>
                        <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <div class="adm-appeal-row-actions">
                                <button class="adm-btn adm-btn-ghost js-appeal-modal-open" type="button" data-modal-id="appeal-modal-${a.appealIdx}">
                                    ${msg_security_admin_common_detail}
                                </button>
                                <c:if test="${a.appealStatus == 'PENDING' || a.appealStatus == 'HOLD'}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/accept">
                                        <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_appealAccepted)}">
                                        <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_accept}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/hold">
                                        <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_needMoreCheck)}">
                                        <button class="adm-btn adm-btn-ghost" type="submit">${msg_security_admin_common_hold}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/reject">
                                        <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_appealRejected)}">
                                        <button class="adm-btn adm-btn-danger" type="submit">${msg_security_admin_common_rejectAppeal}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/close">
                                        <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_appealClosed)}">
                                        <button class="adm-btn adm-btn-ghost" type="submit">${msg_security_admin_common_closeAppeal}</button>
                                    </form>
                                </c:if>
                                <c:if test="${a.appealStatus != 'PENDING' && a.appealStatus != 'HOLD'}">
                                    <div class="adm-page-muted"><c:out value="${a.reviewedByUserId}"/> / <fmt:formatDate value="${a.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    <c:if test="${a.appealStatus == 'REJECTED'}">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeals/${a.appealIdx}/close">
                                            <input type="hidden" name="comment" value="${fn:escapeXml(msg_security_admin_comment_appealClosed)}">
                                            <button class="adm-btn adm-btn-ghost" type="submit">${msg_security_admin_common_closeAppeal}</button>
                                        </form>
                                    </c:if>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty appeals}">
                    <tr class="adm-local-empty"><td colspan="7" class="adm-local-empty-cell">${msg_security_admin_empty_appeals}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <c:forEach var="a" items="${appeals}">
            <div class="appeal-modal-backdrop" id="appeal-modal-${a.appealIdx}" hidden>
                <div class="appeal-modal-card" role="dialog" aria-modal="true" aria-labelledby="appeal-modal-title-${a.appealIdx}">
                    <div class="appeal-modal-head">
                        <div>
                            <h2 id="appeal-modal-title-${a.appealIdx}" class="appeal-modal-title">${msg_security_admin_appeals_detail_title}</h2>
                            <div class="adm-page-muted">${msg_security_admin_common_publicRequestId}: <c:out value="${a.publicRequestId}" default="-"/></div>
                        </div>
                        <button class="adm-btn adm-btn-ghost js-appeal-modal-close" type="button">${msg_security_admin_common_close}</button>
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
                        <div class="appeal-modal-stack">
                            <div class="appeal-modal-item">
                                <div class="appeal-modal-label">${msg_security_admin_common_titleContent}</div>
                                <div class="appeal-modal-value">
                                    <strong><c:out value="${a.appealTitle}" default="-"/></strong>
                                    <span><c:out value="${a.appealContent}" default="-"/></span>
                                </div>
                            </div>
                            <div class="appeal-modal-item">
                                <div class="appeal-modal-label">${msg_security_admin_common_reviewComment}</div>
                                <div class="appeal-modal-value"><c:out value="${a.reviewComment}" default="-"/></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
function sortStaticAdminTable(tableId, columnIndex) {
    const table = document.getElementById(tableId);
    const tbody = table ? table.querySelector('tbody') : null;
    if (!tbody) return;
    const prevIndex = Number(table.dataset.sortIndex || -1);
    const prevDir = table.dataset.sortDir || 'ASC';
    const nextDir = prevIndex === columnIndex && prevDir === 'ASC' ? 'DESC' : 'ASC';
    table.dataset.sortIndex = String(columnIndex);
    table.dataset.sortDir = nextDir;
    Array.from(tbody.querySelectorAll('tr'))
        .filter(function(row) { return row.children.length > columnIndex && !row.querySelector('td[colspan]'); })
        .sort(function(a, b) {
            const av = (a.children[columnIndex].innerText || '').replace(/\s+/g, ' ').trim();
            const bv = (b.children[columnIndex].innerText || '').replace(/\s+/g, ' ').trim();
            return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * (nextDir === 'ASC' ? 1 : -1);
        })
        .forEach(function(row) { tbody.appendChild(row); });
    table.querySelectorAll('th').forEach(function(th, idx) {
        const ico = th.querySelector('.sort-ico');
        if (ico) ico.textContent = idx === columnIndex ? (nextDir === 'ASC' ? '▲' : '▼') : '';
    });
}
function openFirstAppealDetail() {
    const button = document.querySelector('#securityAppealTable .js-appeal-modal-open');
    if (button) button.click();
}
(function () {
    const orig = window.sortStaticAdminTable;
    window.sortStaticAdminTable = function (tableId, columnIndex) {
        orig(tableId, columnIndex);
        const table = document.getElementById(tableId);
        if (!table) return;
        const dir = table.dataset.sortDir || 'ASC';
        const idx = Number(table.dataset.sortIndex || -1);
        table.querySelectorAll('th').forEach(function (th, i) {
            const ico = th.querySelector('.ap-sort-ico');
            if (ico) ico.textContent = i === idx ? (dir === 'ASC' ? '▲' : '▼') : '';
        });
    };
})();
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
    document.querySelectorAll('.js-appeal-bulk-action').forEach(function (button) {
        button.addEventListener('click', function () {
            const rows = Array.from(document.querySelectorAll('#securityAppealTable .js-admin-list-row-check:checked'))
                .map(function (checkbox) { return checkbox.closest('tr'); })
                .filter(function (row) { return row && row.dataset.appealId; });
            if (!rows.length) {
                if (typeof window.adm_toast === 'function') window.adm_toast('선택된 이의제기가 없습니다.', 'error');
                else alert('선택된 이의제기가 없습니다.');
                return;
            }
            if (button.disabled) return;
            button.disabled = true;
            const decision = button.dataset.decision;
            const comment = button.dataset.comment || '';
            const body = new URLSearchParams();
            body.set('comment', comment);
            Promise.all(rows.map(function (row) {
                return fetch('${pageContext.request.contextPath}/admin/login-risk/appeals/' + encodeURIComponent(row.dataset.appealId) + '/' + decision, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: body.toString()
                });
            })).finally(function () {
                window.location.reload();
            });
        });
    });
})();
</script>

<style>
/* ── 이의제기 페이지 전용 ── */
.adm-appeal-page .ap-table { width: 100%; min-width: 1140px; table-layout: fixed; }
.adm-appeal-page .ap-col-check   { width: 42px; }
.adm-appeal-page .ap-th-check, .adm-appeal-page .ap-cell-check { text-align: center; padding: 8px 4px; }
.adm-appeal-page .ap-col-status  { width: 110px; }
.adm-appeal-page .ap-col-user    { width: 180px; }
.adm-appeal-page .ap-col-target  { width: 200px; }
.adm-appeal-page .ap-col-content { width: auto; }
.adm-appeal-page .ap-col-date    { width: 140px; }
.adm-appeal-page .ap-col-action  { width: 130px; }

.adm-appeal-page .ap-th {
    white-space: nowrap; overflow: hidden;
    cursor: pointer; user-select: none;
    padding-right: 18px; box-sizing: border-box;
}
.adm-appeal-page .ap-th .ap-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.adm-appeal-page .ap-th .ap-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .adm-appeal-page .ap-th .ap-sort-ico { color: #2563eb; }

.adm-appeal-page .ap-table td {
    vertical-align: top; overflow: hidden;
    word-break: break-word;
}
.adm-appeal-page .ap-table .adm-appeal-summary,
.adm-appeal-page .ap-table .adm-appeal-content {
    white-space: normal; line-height: 1.45;
    max-height: 6em; overflow: hidden; text-overflow: ellipsis;
}

@media (max-width: 1100px) {
    .adm-appeal-page .adm-appeal-filterbar { flex-wrap: wrap; }
}
</style>

<%@ include file="../layout-close.jsp" %>
