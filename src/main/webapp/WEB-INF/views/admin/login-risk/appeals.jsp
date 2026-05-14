<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations --%>
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
<spring:message var="msg_admin_common_export" code="admin.common.export"/>
<spring:message var="msg_admin_common_exportAll" code="admin.common.exportAll"/>
<spring:message var="msg_admin_common_exportFiltered" code="admin.common.exportFiltered"/>
<spring:message var="msg_admin_common_exportSelected" code="admin.common.exportSelected"/>
<spring:message var="msg_admin_common_apply" code="admin.common.apply"/>
<spring:message var="msg_admin_common_clearSelection" code="admin.common.clearSelection"/>
<spring:message var="msg_admin_common_selectedCount" code="admin.common.selectedCount"/>
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_common_pageSizeLabel" code="admin.common.pageSizeLabel"/>
<spring:message var="msg_admin_common_pageSize_10" code="admin.common.pageSize" arguments="10"/>
<spring:message var="msg_admin_common_pageSize_20" code="admin.common.pageSize" arguments="20"/>
<spring:message var="msg_admin_common_pageSize_50" code="admin.common.pageSize" arguments="50"/>
<spring:message var="msg_admin_common_pageSize_100" code="admin.common.pageSize" arguments="100"/>
<spring:message var="msg_lrr_sortReset" code="security.admin.loginReviews.sortReset"/>
<spring:message var="msg_lrr_pickAction" code="security.admin.loginReviews.pickActionMsg"/>
<spring:message var="msg_lrr_noSelection" code="security.admin.loginReviews.noSelectionMsg"/>
<spring:message var="msg_lrr_pageSearchPlaceholder" code="security.admin.loginReviews.pageSearchPlaceholder"/>
<spring:message var="msg_lrr_bulkActionPlaceholder" code="security.admin.loginReviews.bulkActionPlaceholder"/>

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

    <form id="apSearchForm" method="get" class="adm-card adm-appeal-filter-card adm-overflow-visible">
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
        <div class="adm-card-head ap-card-head">
            <div class="adm-card-title">
                ${msg_security_admin_appeals_title}
                <span class="ap-total-label" id="apTotalLabel">${msg_admin_common_totalCount}</span>
            </div>
            <div class="adm-export-control ap-export-control">
                <select class="adm-select ap-export-format" id="apExportFormat">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-ap-export-toggle">${msg_admin_common_export} ▾</button>
                <div id="apExportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="apExport('all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="apExport('filtered')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item" id="apExportSelectedBtn" disabled onclick="apExport('selected')">${msg_admin_common_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <div class="ap-controlbar">
            <div id="apBulkBar" class="ap-bulkbar" aria-live="polite" aria-hidden="true">
                <span class="ap-bulk-count"><strong id="apBulkCount">0</strong>${msg_admin_common_selectedCount}</span>
                <div class="ap-bulk-actions">
                    <select class="adm-select" id="apBulkActionSelect">
                        <option value="">${msg_lrr_bulkActionPlaceholder}</option>
                        <option value="accept">${msg_security_admin_common_accept}</option>
                        <option value="hold">${msg_security_admin_common_hold}</option>
                        <option value="reject">${msg_security_admin_common_rejectAppeal}</option>
                        <option value="close">${msg_security_admin_common_closeAppeal}</option>
                    </select>
                    <button type="button" class="adm-btn adm-btn-primary" onclick="apApplyBulk()">${msg_admin_common_apply}</button>
                </div>
                <button type="button" class="adm-btn adm-btn-ghost ap-bulk-clear" onclick="apClearSelection()">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="ap-view-tools">
                <button type="button" class="adm-btn adm-btn-ghost ap-sort-reset adm-is-hidden" id="apSortReset" onclick="apResetSort()">${msg_lrr_sortReset}</button>
                <label class="ap-tool ap-page-search-tool">
                    <input class="adm-input ap-page-search" id="apPageSearch" type="text" placeholder="${msg_lrr_pageSearchPlaceholder}" oninput="apSetPageSearch(this.value)">
                </label>
                <label class="ap-tool">
                    <span class="ap-tool-label">${msg_admin_common_pageSizeLabel}</span>
                    <select class="adm-select ap-page-size" id="apPageSize" onchange="apChangeSize(this.value)">
                        <option value="10">${msg_admin_common_pageSize_10}</option>
                        <option value="20" selected>${msg_admin_common_pageSize_20}</option>
                        <option value="50">${msg_admin_common_pageSize_50}</option>
                        <option value="100">${msg_admin_common_pageSize_100}</option>
                    </select>
                </label>
            </div>
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
                    <th class="ap-th ap-th-check"><input type="checkbox" id="apCheckAll" onchange="apToggleAll(this)" aria-label="select-all"></th>
                    <th class="ap-th ap-sortable" data-sort="status" onclick="apSortBy('status')"><span class="ap-th-label">${msg_security_admin_common_status}</span><span class="ap-sort-ico" aria-hidden="true"></span></th>
                    <th class="ap-th ap-sortable" data-sort="user" onclick="apSortBy('user')"><span class="ap-th-label">${msg_security_admin_common_user}</span><span class="ap-sort-ico" aria-hidden="true"></span></th>
                    <th class="ap-th ap-sortable" data-sort="target" onclick="apSortBy('target')"><span class="ap-th-label">${msg_security_admin_common_target}</span><span class="ap-sort-ico" aria-hidden="true"></span></th>
                    <th class="ap-th ap-sortable" data-sort="title" onclick="apSortBy('title')"><span class="ap-th-label">${msg_security_admin_common_titleContent}</span><span class="ap-sort-ico" aria-hidden="true"></span></th>
                    <th class="ap-th ap-sortable" data-sort="date" onclick="apSortBy('date')"><span class="ap-th-label">${msg_security_admin_common_submittedAt}</span><span class="ap-sort-ico" aria-hidden="true"></span></th>
                    <th class="ap-th"><span class="ap-th-label">${msg_security_admin_common_action}</span></th>
                </tr>
                </thead>
                <tbody id="apTableBody">
                <c:forEach var="a" items="${appeals}">
                    <tr data-row-id="${a.appealIdx}"
                        data-sort-status="${fn:escapeXml(a.appealStatus)}"
                        data-sort-user="${fn:escapeXml(a.userId)}|${fn:escapeXml(a.nickname)}"
                        data-sort-target="${fn:escapeXml(a.targetType)}:${fn:escapeXml(a.targetKey)}"
                        data-sort-title="${fn:escapeXml(a.appealTitle)}"
                        data-sort-date="<fmt:formatDate value='${a.createdAtDate}' pattern='yyyyMMddHHmm'/>">
                        <td class="ap-cell-check"><input type="checkbox" class="js-ap-row-check" value="${a.appealIdx}" onchange="apUpdateBulkCount()" aria-label="row-select"></td>
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
                </tbody>
            </table>
            <div class="ap-empty adm-is-hidden" id="apEmptyState">${msg_security_admin_empty_appeals}</div>
        </div>

        <div class="ap-pagination" id="apPaging">
            <div class="ap-page-info"><span id="apPageInfo"></span></div>
            <div class="ap-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" id="apPrevBtn" onclick="apGoPage(window.apState.page - 1)">${msg_admin_common_prev}</button>
                <span class="ap-page-state" id="apPageState"></span>
                <button type="button" class="adm-btn adm-btn-ghost" id="apNextBtn" onclick="apGoPage(window.apState.page + 1)">${msg_admin_common_next}</button>
            </div>
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
(function () {
    'use strict';
    /* ─── 이의제기 — 클라이언트 사이드 페이징·정렬·검색·체크박스 일괄처리 ───
       로딩 방식 결정: 서버 getSecurityAppeals() 는 LIMIT 없이 status/targetType/keyword 서버
       필터 후 전 결과 반환. detail 모달은 카드 하위 별도 영역에 존재, 행 detach 영향 없음.
       이전 코드의 개별 fetch 반복(N건 N요청)을 단일 POST bulk 로 일원화. */
    var ctx = '${pageContext.request.contextPath}';

    var AP_MSG = {
        exportSelectedLabel: '${msg_admin_common_exportSelected}',
        pickAction: '${msg_lrr_pickAction}',
        noSelection: '${msg_lrr_noSelection}',
        bulkConfirmTpl: '<spring:message code="security.admin.loginReviews.bulkConfirm" arguments="{0}" javaScriptEscape="true"/>',
        commentAccept: '${fn:escapeXml(msg_security_admin_comment_appealAccepted)}',
        commentHold: '${fn:escapeXml(msg_security_admin_comment_needMoreCheck)}',
        commentReject: '${fn:escapeXml(msg_security_admin_comment_appealRejected)}',
        commentClose: '${fn:escapeXml(msg_security_admin_comment_appealClosed)}'
    };

    var apState = {
        page: 1, pageSize: 20,
        sortBy: '', sortDir: 'ASC',
        pageSearch: '',
        rows: [], filtered: []
    };
    window.apState = apState;

    function cacheRows() {
        var tbody = document.getElementById('apTableBody');
        if (!tbody) return;
        apState.rows = Array.prototype.slice.call(tbody.querySelectorAll('tr[data-row-id]'));
    }
    function applyFilter() {
        var q = (apState.pageSearch || '').trim().toLowerCase();
        if (!q) { apState.filtered = apState.rows.slice(); return; }
        apState.filtered = apState.rows.filter(function (tr) {
            return ((tr.innerText || tr.textContent) || '').toLowerCase().indexOf(q) !== -1;
        });
    }
    function applySort() {
        if (!apState.sortBy) return;
        var dir = apState.sortDir === 'DESC' ? -1 : 1;
        var attr = 'data-sort-' + apState.sortBy;
        apState.filtered.sort(function (a, b) {
            var av = (a.getAttribute(attr) || '').toLowerCase();
            var bv = (b.getAttribute(attr) || '').toLowerCase();
            return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * dir;
        });
    }
    function render() {
        var tbody = document.getElementById('apTableBody');
        if (!tbody) return;
        var total = apState.filtered.length;
        var pageSize = apState.pageSize > 0 ? apState.pageSize : 20;
        var totalPage = Math.max(1, Math.ceil(total / pageSize));
        if (apState.page > totalPage) apState.page = totalPage;
        if (apState.page < 1) apState.page = 1;
        var start = (apState.page - 1) * pageSize;
        var slice = apState.filtered.slice(start, start + pageSize);

        apState.rows.forEach(function (tr) { if (tr.parentNode === tbody) tbody.removeChild(tr); });
        Array.prototype.slice.call(tbody.querySelectorAll('.ap-empty-row')).forEach(function (tr) { tr.remove(); });
        slice.forEach(function (tr) { tbody.appendChild(tr); });
        if (slice.length === 0) {
            var emptyTpl = document.getElementById('apEmptyState');
            var emptyText = emptyTpl ? emptyTpl.textContent : '';
            var emptyTr = document.createElement('tr');
            emptyTr.className = 'ap-empty-row';
            var td = document.createElement('td');
            td.colSpan = 7; td.className = 'ap-empty-cell'; td.textContent = emptyText;
            emptyTr.appendChild(td);
            tbody.appendChild(emptyTr);
        }

        var info = document.getElementById('apPageInfo');
        if (info) info.textContent = total + ' / ' + apState.rows.length;
        var stateEl = document.getElementById('apPageState');
        if (stateEl) stateEl.textContent = apState.page + ' / ' + totalPage;
        var prev = document.getElementById('apPrevBtn');
        var next = document.getElementById('apNextBtn');
        if (prev) prev.disabled = apState.page <= 1;
        if (next) next.disabled = apState.page >= totalPage;

        Array.prototype.slice.call(document.querySelectorAll('#securityAppealTable thead th.ap-sortable')).forEach(function (th) {
            var ico = th.querySelector('.ap-sort-ico');
            if (!ico) return;
            ico.textContent = (th.getAttribute('data-sort') === apState.sortBy)
                ? (apState.sortDir === 'DESC' ? '▼' : '▲')
                : '';
        });
        var resetBtn = document.getElementById('apSortReset');
        if (resetBtn) resetBtn.classList.toggle('adm-is-hidden', !apState.sortBy);

        updateBulkCount();
    }
    function applyAll() { applyFilter(); applySort(); render(); }

    function updateBulkCount() {
        var checked = document.querySelectorAll('#apTableBody .js-ap-row-check:checked');
        var n = checked.length;
        var bulkBar = document.getElementById('apBulkBar');
        if (bulkBar) {
            bulkBar.classList.toggle('is-active', n > 0);
            bulkBar.setAttribute('aria-hidden', n > 0 ? 'false' : 'true');
            bulkBar.querySelectorAll('select, button').forEach(function (el) { el.disabled = n === 0; });
        }
        var countEl = document.getElementById('apBulkCount');
        if (countEl) countEl.textContent = n;
        var selBtn = document.getElementById('apExportSelectedBtn');
        if (selBtn) {
            selBtn.disabled = n === 0;
            selBtn.textContent = AP_MSG.exportSelectedLabel + ' (' + n + ')';
        }
        var checkAll = document.getElementById('apCheckAll');
        if (checkAll) {
            var visible = document.querySelectorAll('#apTableBody .js-ap-row-check');
            checkAll.checked = visible.length > 0 && n === visible.length;
            checkAll.indeterminate = n > 0 && n < visible.length;
        }
    }
    window.apUpdateBulkCount = updateBulkCount;

    window.apToggleAll = function (cb) {
        document.querySelectorAll('#apTableBody .js-ap-row-check').forEach(function (c) { c.checked = cb.checked; });
        updateBulkCount();
    };
    window.apClearSelection = function () {
        document.querySelectorAll('#apTableBody .js-ap-row-check').forEach(function (c) { c.checked = false; });
        var checkAll = document.getElementById('apCheckAll');
        if (checkAll) { checkAll.checked = false; checkAll.indeterminate = false; }
        updateBulkCount();
    };

    window.apSortBy = function (field) {
        if (apState.sortBy === field) {
            apState.sortDir = (apState.sortDir === 'ASC') ? 'DESC' : 'ASC';
        } else { apState.sortBy = field; apState.sortDir = 'ASC'; }
        apState.page = 1; applyAll();
    };
    window.apResetSort = function () {
        apState.sortBy = ''; apState.sortDir = 'ASC'; apState.page = 1; applyAll();
    };
    window.apChangeSize = function (size) {
        var n = parseInt(size, 10);
        apState.pageSize = (n > 0 ? n : 20);
        apState.page = 1; render();
    };
    window.apGoPage = function (p) {
        var total = apState.filtered.length;
        var totalPage = Math.max(1, Math.ceil(total / apState.pageSize));
        var next = Math.min(Math.max(1, parseInt(p, 10) || 1), totalPage);
        if (next === apState.page) return;
        apState.page = next; render();
    };
    window.apSetPageSearch = function (text) {
        apState.pageSearch = text || ''; apState.page = 1; applyAll();
    };

    window.apApplyBulk = function () {
        var action = (document.getElementById('apBulkActionSelect') || {}).value || '';
        if (!action) { alert(AP_MSG.pickAction); return; }
        var checked = Array.prototype.slice.call(document.querySelectorAll('#apTableBody .js-ap-row-check:checked'));
        if (!checked.length) { alert(AP_MSG.noSelection); return; }
        var confirmMsg = (AP_MSG.bulkConfirmTpl || '').replace('{0}', String(checked.length));
        if (!window.confirm(confirmMsg)) return;

        /* 액션별 기본 코멘트 자동 선택 (모든 행 동일) */
        var comment = (action === 'accept') ? AP_MSG.commentAccept
                    : (action === 'hold') ? AP_MSG.commentHold
                    : (action === 'reject') ? AP_MSG.commentReject
                    : AP_MSG.commentClose;

        var ids = checked.map(function (c) { return c.value; }).join(',');
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = ctx + '/admin/login-risk/appeals/bulk';
        function addInput(name, value) {
            var inp = document.createElement('input');
            inp.type = 'hidden'; inp.name = name; inp.value = value;
            form.appendChild(inp);
        }
        addInput('action', action);
        addInput('ids', ids);
        addInput('comment', comment);
        document.body.appendChild(form);
        form.submit();
    };

    window.apExport = function (scope) {
        var format = (document.getElementById('apExportFormat') || {}).value || 'csv';
        var params = new URLSearchParams();
        params.set('scope', scope);
        params.set('format', format);
        if (scope === 'filtered') {
            var form = document.getElementById('apSearchForm');
            if (form) {
                var fd = new FormData(form);
                fd.forEach(function (v, k) { if (v) params.set(k, v); });
            }
        }
        if (scope === 'selected') {
            var ids = Array.prototype.slice.call(document.querySelectorAll('#apTableBody .js-ap-row-check:checked')).map(function (c) { return c.value; });
            if (!ids.length) { alert(AP_MSG.noSelection); return; }
            params.set('selectedIds', ids.join(','));
        }
        var dropdown = document.getElementById('apExportDropdown');
        if (dropdown) dropdown.classList.remove('open');
        window.location.href = ctx + '/admin/login-risk/appeals/export?' + params.toString();
    };

    function initExportDropdown() {
        var toggle = document.querySelector('.js-ap-export-toggle');
        var dropdown = document.getElementById('apExportDropdown');
        if (!toggle || !dropdown) return;
        toggle.addEventListener('click', function (e) {
            e.stopPropagation();
            dropdown.classList.toggle('open');
        });
        document.addEventListener('click', function (e) {
            if (!toggle.contains(e.target) && !dropdown.contains(e.target)) dropdown.classList.remove('open');
        });
    }

    function initModals() {
        document.querySelectorAll('.js-appeal-modal-open').forEach(function (button) {
            button.addEventListener('click', function () {
                var modal = document.getElementById(button.dataset.modalId);
                if (modal) modal.hidden = false;
            });
        });
        document.querySelectorAll('.js-appeal-modal-close').forEach(function (button) {
            button.addEventListener('click', function () {
                var modal = button.closest('.appeal-modal-backdrop');
                if (modal) modal.hidden = true;
            });
        });
        document.querySelectorAll('.appeal-modal-backdrop').forEach(function (backdrop) {
            backdrop.addEventListener('click', function (event) {
                if (event.target === backdrop) backdrop.hidden = true;
            });
        });
        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                document.querySelectorAll('.appeal-modal-backdrop:not([hidden])').forEach(function (m) { m.hidden = true; });
            }
        });
    }

    function init() {
        cacheRows();
        var sizeSel = document.getElementById('apPageSize');
        if (sizeSel) {
            var n = parseInt(sizeSel.value, 10);
            apState.pageSize = n > 0 ? n : 20;
        }
        initExportDropdown();
        initModals();
        applyAll();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else { init(); }
})();
</script>

<style>
/* ── 이의제기 페이지 전용 (ap-) ── */
.adm-appeal-page .ap-table { width: 100%; min-width: 1140px; table-layout: fixed; }
.adm-appeal-page .ap-col-check   { width: 42px; }
.adm-appeal-page .ap-th-check, .adm-appeal-page .ap-cell-check { text-align: center; padding: 8px 4px; }
.adm-appeal-page .ap-col-status  { width: 110px; }
.adm-appeal-page .ap-col-user    { width: 180px; }
.adm-appeal-page .ap-col-target  { width: 200px; }
.adm-appeal-page .ap-col-content { width: auto; }
.adm-appeal-page .ap-col-date    { width: 140px; }
.adm-appeal-page .ap-col-action  { width: 200px; }

.adm-appeal-page .ap-th {
    white-space: nowrap; overflow: hidden;
    user-select: none;
    padding-right: 18px; box-sizing: border-box;
}
.adm-appeal-page .ap-th.ap-sortable { cursor: pointer; }
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

/* card head + export */
.adm-appeal-page .ap-card-head { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap; }
.adm-appeal-page .ap-total-label { margin-left: 8px; font-size: 12px; color: #94a3b8; font-weight: normal; }
.adm-appeal-page .ap-export-control { position: relative; display: inline-flex; align-items: center; gap: 6px; }
.adm-appeal-page .ap-export-control .ap-export-format { min-width: 84px; }
.adm-appeal-page .ap-export-control .adm-export-dropdown {
    display: none; position: absolute; top: 100%; right: 0; margin-top: 4px;
    background: var(--adm-card-bg, #1e293b); border: 1px solid var(--adm-border, #334155);
    border-radius: 6px; padding: 4px; z-index: 30; min-width: 200px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.25);
}
.adm-appeal-page .ap-export-control .adm-export-dropdown.open { display: block; }
.adm-appeal-page .ap-export-control .adm-export-item {
    display: block; width: 100%; text-align: left; padding: 6px 10px;
    background: transparent; color: inherit; border: 0; cursor: pointer;
    font-size: 13px; border-radius: 4px;
}
.adm-appeal-page .ap-export-control .adm-export-item:disabled { opacity: 0.5; cursor: not-allowed; }
.adm-appeal-page .ap-export-control .adm-export-item:hover:not(:disabled) { background: rgba(148,163,184,0.15); }

/* controlbar */
.adm-appeal-page .ap-controlbar { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 8px 14px; flex-wrap: wrap; }
.adm-appeal-page .ap-bulkbar { display: flex; align-items: center; gap: 10px; opacity: 0.55; transition: opacity 0.2s; }
.adm-appeal-page .ap-bulkbar.is-active { opacity: 1; }
.adm-appeal-page .ap-bulk-count { font-size: 13px; }
.adm-appeal-page .ap-bulk-count strong { font-size: 15px; margin-right: 2px; color: #fbbf24; }
.adm-appeal-page .ap-bulk-actions { display: inline-flex; gap: 6px; align-items: center; }
.adm-appeal-page .ap-view-tools { display: inline-flex; gap: 8px; align-items: center; flex-wrap: wrap; }
.adm-appeal-page .ap-tool { display: inline-flex; gap: 4px; align-items: center; }
.adm-appeal-page .ap-tool-label { font-size: 12px; color: #94a3b8; }
.adm-appeal-page .ap-page-search { min-width: 220px; }
.adm-appeal-page .ap-sort-reset { font-size: 12px; }

/* pagination */
.adm-appeal-page .ap-pagination { display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; gap: 10px; flex-wrap: wrap; }
.adm-appeal-page .ap-page-info { font-size: 12px; color: #94a3b8; }
.adm-appeal-page .ap-page-actions { display: inline-flex; gap: 8px; align-items: center; }
.adm-appeal-page .ap-page-state { font-size: 13px; min-width: 60px; text-align: center; }

.adm-appeal-page .ap-empty,
.adm-appeal-page .ap-empty-cell { padding: 16px; text-align: center; color: #94a3b8; }
.adm-appeal-page .adm-is-hidden { display: none !important; }

@media (max-width: 1100px) {
    .adm-appeal-page .adm-appeal-filterbar { flex-wrap: wrap; }
    .adm-appeal-page .ap-controlbar { flex-direction: column; align-items: stretch; }
    .adm-appeal-page .ap-bulkbar { flex-wrap: wrap; }
    .adm-appeal-page .ap-view-tools { justify-content: flex-end; }
}
</style>

<%@ include file="../layout-close.jsp" %>
