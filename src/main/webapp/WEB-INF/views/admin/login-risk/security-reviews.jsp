<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations --%>
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
<spring:message var="msg_lrr_bulkComment" code="security.admin.loginReviews.bulkComment"/>

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

    <form id="srSearchForm" method="get" class="adm-card adm-security-review-filter-card adm-overflow-visible">
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
        <div class="adm-card-head sr-card-head">
            <div class="adm-card-title">
                ${msg_security_admin_securityReviews_title}
                <span class="sr-total-label" id="srTotalLabel">${msg_admin_common_totalCount}</span>
            </div>
            <div class="adm-export-control sr-export-control">
                <select class="adm-select sr-export-format" id="srExportFormat">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-sr-export-toggle">${msg_admin_common_export} ▾</button>
                <div id="srExportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="srExport('all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="srExport('filtered')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item" id="srExportSelectedBtn" disabled onclick="srExport('selected')">${msg_admin_common_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <div class="sr-controlbar">
            <div id="srBulkBar" class="sr-bulkbar" aria-live="polite" aria-hidden="true">
                <span class="sr-bulk-count"><strong id="srBulkCount">0</strong>${msg_admin_common_selectedCount}</span>
                <div class="sr-bulk-actions">
                    <select class="adm-select" id="srBulkActionSelect">
                        <option value="">${msg_lrr_bulkActionPlaceholder}</option>
                        <option value="approve">${msg_security_admin_common_approve}</option>
                        <option value="hold">${msg_security_admin_common_hold}</option>
                        <option value="reject">${msg_security_admin_common_reject}</option>
                    </select>
                    <button type="button" class="adm-btn adm-btn-primary" onclick="srApplyBulk()">${msg_admin_common_apply}</button>
                </div>
                <button type="button" class="adm-btn adm-btn-ghost sr-bulk-clear" onclick="srClearSelection()">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="sr-view-tools">
                <button type="button" class="adm-btn adm-btn-ghost sr-sort-reset adm-is-hidden" id="srSortReset" onclick="srResetSort()">${msg_lrr_sortReset}</button>
                <label class="sr-tool sr-page-search-tool">
                    <input class="adm-input sr-page-search" id="srPageSearch" type="text" placeholder="${msg_lrr_pageSearchPlaceholder}" oninput="srSetPageSearch(this.value)">
                </label>
                <label class="sr-tool">
                    <span class="sr-tool-label">${msg_admin_common_pageSizeLabel}</span>
                    <select class="adm-select sr-page-size" id="srPageSize" onchange="srChangeSize(this.value)">
                        <option value="10">${msg_admin_common_pageSize_10}</option>
                        <option value="20" selected>${msg_admin_common_pageSize_20}</option>
                        <option value="50">${msg_admin_common_pageSize_50}</option>
                        <option value="100">${msg_admin_common_pageSize_100}</option>
                    </select>
                </label>
            </div>
        </div>

        <div class="adm-table-wrap">
            <table id="securityReviewTable"
                   class="adm-table adm-section-table-fixed adm-security-review-table sr-table"
                   data-section="securityReviews"
                   data-admin-list-ignore="hard">
                <colgroup>
                    <col class="sr-col-check"/>
                    <col class="sr-col-status"/>
                    <col class="sr-col-severity"/>
                    <col class="sr-col-type"/>
                    <col class="sr-col-target"/>
                    <col class="sr-col-summary"/>
                    <col class="sr-col-date"/>
                    <col class="sr-col-action"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="sr-th sr-th-check"><input type="checkbox" id="srCheckAll" onchange="srToggleAll(this)" aria-label="select-all"></th>
                    <th class="sr-th sr-sortable" data-sort="status" onclick="srSortBy('status')"><span class="sr-th-label">${msg_security_admin_common_status}</span><span class="sr-sort-ico" aria-hidden="true"></span></th>
                    <th class="sr-th sr-sortable" data-sort="severity" onclick="srSortBy('severity')"><span class="sr-th-label">${msg_security_admin_common_severity}</span><span class="sr-sort-ico" aria-hidden="true"></span></th>
                    <th class="sr-th sr-sortable" data-sort="type" onclick="srSortBy('type')"><span class="sr-th-label">${msg_security_admin_common_reviewType}</span><span class="sr-sort-ico" aria-hidden="true"></span></th>
                    <th class="sr-th sr-sortable" data-sort="target" onclick="srSortBy('target')"><span class="sr-th-label">${msg_security_admin_common_target}</span><span class="sr-sort-ico" aria-hidden="true"></span></th>
                    <th class="sr-th sr-sortable" data-sort="summary" onclick="srSortBy('summary')"><span class="sr-th-label">${msg_security_admin_common_summaryEvidence}</span><span class="sr-sort-ico" aria-hidden="true"></span></th>
                    <th class="sr-th sr-sortable" data-sort="date" onclick="srSortBy('date')"><span class="sr-th-label">${msg_security_admin_common_createdAt}</span><span class="sr-sort-ico" aria-hidden="true"></span></th>
                    <th class="sr-th"><span class="sr-th-label">${msg_security_admin_common_action}</span></th>
                </tr>
                </thead>
                <tbody id="srTableBody">
                <c:forEach var="r" items="${reviews}">
                    <tr data-row-id="${r.reviewIdx}"
                        data-sort-status="${fn:escapeXml(r.reviewStatus)}"
                        data-sort-severity="${fn:escapeXml(r.severity)}"
                        data-sort-type="${fn:escapeXml(r.reviewType)}"
                        data-sort-target="${fn:escapeXml(r.subjectType)}:${fn:escapeXml(r.subjectKey)}"
                        data-sort-summary="${fn:escapeXml(r.summary)}"
                        data-sort-date="<fmt:formatDate value='${r.createdAtDate}' pattern='yyyyMMddHHmm'/>">
                        <td class="sr-cell-check"><input type="checkbox" class="js-sr-row-check" value="${r.reviewIdx}" onchange="srUpdateBulkCount()" aria-label="row-select"></td>
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
                </tbody>
            </table>
            <div class="sr-empty adm-is-hidden" id="srEmptyState">${msg_security_admin_empty_reviews}</div>
        </div>

        <div class="sr-pagination" id="srPaging">
            <div class="sr-page-info"><span id="srPageInfo"></span></div>
            <div class="sr-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" id="srPrevBtn" onclick="srGoPage(window.srState.page - 1)">${msg_admin_common_prev}</button>
                <span class="sr-page-state" id="srPageState"></span>
                <button type="button" class="adm-btn adm-btn-ghost" id="srNextBtn" onclick="srGoPage(window.srState.page + 1)">${msg_admin_common_next}</button>
            </div>
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

<script>
(function () {
    'use strict';
    /* ─── 일반 검토 큐 — 클라이언트 사이드 페이징·정렬·검색·체크박스 일괄처리 ───
       로딩 방식 결정: 서버 getSecurityReviews() 는 LIMIT 없이 status/severity/reviewType/keyword
       서버 필터 후 전 결과 반환. detail 모달은 서버 렌더된 행마다 함께 출력되므로 클라이언트
       페이징으로 행을 detach 해도 모달 노드는 카드 하위에 그대로 남아 detail 동작 영향 없음. */
    var ctx = '${pageContext.request.contextPath}';

    var SR_MSG = {
        exportSelectedLabel: '${msg_admin_common_exportSelected}',
        pickAction: '${msg_lrr_pickAction}',
        noSelection: '${msg_lrr_noSelection}',
        bulkConfirmTpl: '<spring:message code="security.admin.loginReviews.bulkConfirm" arguments="{0}" javaScriptEscape="true"/>',
        bulkComment: '${msg_lrr_bulkComment}'
    };

    var srState = {
        page: 1, pageSize: 20,
        sortBy: '', sortDir: 'ASC',
        pageSearch: '',
        rows: [], filtered: []
    };
    window.srState = srState;

    function cacheRows() {
        var tbody = document.getElementById('srTableBody');
        if (!tbody) return;
        srState.rows = Array.prototype.slice.call(tbody.querySelectorAll('tr[data-row-id]'));
    }
    function applyFilter() {
        var q = (srState.pageSearch || '').trim().toLowerCase();
        if (!q) { srState.filtered = srState.rows.slice(); return; }
        srState.filtered = srState.rows.filter(function (tr) {
            return ((tr.innerText || tr.textContent) || '').toLowerCase().indexOf(q) !== -1;
        });
    }
    function applySort() {
        if (!srState.sortBy) return;
        var dir = srState.sortDir === 'DESC' ? -1 : 1;
        var attr = 'data-sort-' + srState.sortBy;
        srState.filtered.sort(function (a, b) {
            var av = (a.getAttribute(attr) || '').toLowerCase();
            var bv = (b.getAttribute(attr) || '').toLowerCase();
            return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * dir;
        });
    }
    function render() {
        var tbody = document.getElementById('srTableBody');
        if (!tbody) return;
        var total = srState.filtered.length;
        var pageSize = srState.pageSize > 0 ? srState.pageSize : 20;
        var totalPage = Math.max(1, Math.ceil(total / pageSize));
        if (srState.page > totalPage) srState.page = totalPage;
        if (srState.page < 1) srState.page = 1;
        var start = (srState.page - 1) * pageSize;
        var slice = srState.filtered.slice(start, start + pageSize);

        srState.rows.forEach(function (tr) { if (tr.parentNode === tbody) tbody.removeChild(tr); });
        Array.prototype.slice.call(tbody.querySelectorAll('.sr-empty-row')).forEach(function (tr) { tr.remove(); });
        slice.forEach(function (tr) { tbody.appendChild(tr); });
        if (slice.length === 0) {
            var emptyTpl = document.getElementById('srEmptyState');
            var emptyText = emptyTpl ? emptyTpl.textContent : '';
            var emptyTr = document.createElement('tr');
            emptyTr.className = 'sr-empty-row';
            var td = document.createElement('td');
            td.colSpan = 8; td.className = 'sr-empty-cell'; td.textContent = emptyText;
            emptyTr.appendChild(td);
            tbody.appendChild(emptyTr);
        }

        var info = document.getElementById('srPageInfo');
        if (info) info.textContent = total + ' / ' + srState.rows.length;
        var stateEl = document.getElementById('srPageState');
        if (stateEl) stateEl.textContent = srState.page + ' / ' + totalPage;
        var prev = document.getElementById('srPrevBtn');
        var next = document.getElementById('srNextBtn');
        if (prev) prev.disabled = srState.page <= 1;
        if (next) next.disabled = srState.page >= totalPage;

        Array.prototype.slice.call(document.querySelectorAll('#securityReviewTable thead th.sr-sortable')).forEach(function (th) {
            var ico = th.querySelector('.sr-sort-ico');
            if (!ico) return;
            ico.textContent = (th.getAttribute('data-sort') === srState.sortBy)
                ? (srState.sortDir === 'DESC' ? '▼' : '▲')
                : '';
        });
        var resetBtn = document.getElementById('srSortReset');
        if (resetBtn) resetBtn.classList.toggle('adm-is-hidden', !srState.sortBy);

        updateBulkCount();
    }
    function applyAll() { applyFilter(); applySort(); render(); }

    function updateBulkCount() {
        var checked = document.querySelectorAll('#srTableBody .js-sr-row-check:checked');
        var n = checked.length;
        var bulkBar = document.getElementById('srBulkBar');
        if (bulkBar) {
            bulkBar.classList.toggle('is-active', n > 0);
            bulkBar.setAttribute('aria-hidden', n > 0 ? 'false' : 'true');
            bulkBar.querySelectorAll('select, button').forEach(function (el) { el.disabled = n === 0; });
        }
        var countEl = document.getElementById('srBulkCount');
        if (countEl) countEl.textContent = n;
        var selBtn = document.getElementById('srExportSelectedBtn');
        if (selBtn) {
            selBtn.disabled = n === 0;
            selBtn.textContent = SR_MSG.exportSelectedLabel + ' (' + n + ')';
        }
        var checkAll = document.getElementById('srCheckAll');
        if (checkAll) {
            var visible = document.querySelectorAll('#srTableBody .js-sr-row-check');
            checkAll.checked = visible.length > 0 && n === visible.length;
            checkAll.indeterminate = n > 0 && n < visible.length;
        }
    }
    window.srUpdateBulkCount = updateBulkCount;

    window.srToggleAll = function (cb) {
        document.querySelectorAll('#srTableBody .js-sr-row-check').forEach(function (c) { c.checked = cb.checked; });
        updateBulkCount();
    };
    window.srClearSelection = function () {
        document.querySelectorAll('#srTableBody .js-sr-row-check').forEach(function (c) { c.checked = false; });
        var checkAll = document.getElementById('srCheckAll');
        if (checkAll) { checkAll.checked = false; checkAll.indeterminate = false; }
        updateBulkCount();
    };

    window.srSortBy = function (field) {
        if (srState.sortBy === field) {
            srState.sortDir = (srState.sortDir === 'ASC') ? 'DESC' : 'ASC';
        } else { srState.sortBy = field; srState.sortDir = 'ASC'; }
        srState.page = 1; applyAll();
    };
    window.srResetSort = function () {
        srState.sortBy = ''; srState.sortDir = 'ASC'; srState.page = 1; applyAll();
    };
    window.srChangeSize = function (size) {
        var n = parseInt(size, 10);
        srState.pageSize = (n > 0 ? n : 20);
        srState.page = 1; render();
    };
    window.srGoPage = function (p) {
        var total = srState.filtered.length;
        var totalPage = Math.max(1, Math.ceil(total / srState.pageSize));
        var next = Math.min(Math.max(1, parseInt(p, 10) || 1), totalPage);
        if (next === srState.page) return;
        srState.page = next; render();
    };
    window.srSetPageSearch = function (text) {
        srState.pageSearch = text || ''; srState.page = 1; applyAll();
    };

    window.srApplyBulk = function () {
        var action = (document.getElementById('srBulkActionSelect') || {}).value || '';
        if (!action) { alert(SR_MSG.pickAction); return; }
        var checked = Array.prototype.slice.call(document.querySelectorAll('#srTableBody .js-sr-row-check:checked'));
        if (!checked.length) { alert(SR_MSG.noSelection); return; }
        var confirmMsg = (SR_MSG.bulkConfirmTpl || '').replace('{0}', String(checked.length));
        if (!window.confirm(confirmMsg)) return;

        var ids = checked.map(function (c) { return c.value; }).join(',');
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = ctx + '/admin/login-risk/security-reviews/bulk';
        function addInput(name, value) {
            var inp = document.createElement('input');
            inp.type = 'hidden'; inp.name = name; inp.value = value;
            form.appendChild(inp);
        }
        addInput('action', action);
        addInput('ids', ids);
        addInput('comment', SR_MSG.bulkComment);
        document.body.appendChild(form);
        form.submit();
    };

    window.srExport = function (scope) {
        var format = (document.getElementById('srExportFormat') || {}).value || 'csv';
        var params = new URLSearchParams();
        params.set('scope', scope);
        params.set('format', format);
        if (scope === 'filtered') {
            var form = document.getElementById('srSearchForm');
            if (form) {
                var fd = new FormData(form);
                fd.forEach(function (v, k) { if (v) params.set(k, v); });
            }
        }
        if (scope === 'selected') {
            var ids = Array.prototype.slice.call(document.querySelectorAll('#srTableBody .js-sr-row-check:checked')).map(function (c) { return c.value; });
            if (!ids.length) { alert(SR_MSG.noSelection); return; }
            params.set('selectedIds', ids.join(','));
        }
        var dropdown = document.getElementById('srExportDropdown');
        if (dropdown) dropdown.classList.remove('open');
        window.location.href = ctx + '/admin/login-risk/security-reviews/export?' + params.toString();
    };

    function initExportDropdown() {
        var toggle = document.querySelector('.js-sr-export-toggle');
        var dropdown = document.getElementById('srExportDropdown');
        if (!toggle || !dropdown) return;
        toggle.addEventListener('click', function (e) {
            e.stopPropagation();
            dropdown.classList.toggle('open');
        });
        document.addEventListener('click', function (e) {
            if (!toggle.contains(e.target) && !dropdown.contains(e.target)) dropdown.classList.remove('open');
        });
    }

    function init() {
        cacheRows();
        var sizeSel = document.getElementById('srPageSize');
        if (sizeSel) {
            var n = parseInt(sizeSel.value, 10);
            srState.pageSize = n > 0 ? n : 20;
        }
        initExportDropdown();
        applyAll();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else { init(); }
})();
</script>

<style>
/* ── 일반 검토 큐 페이지 전용 (sr-) ── */
.adm-security-review-page .sr-table { width: 100%; min-width: 1220px; table-layout: fixed; }
.adm-security-review-page .sr-col-check    { width: 42px; }
.adm-security-review-page .sr-th-check, .adm-security-review-page .sr-cell-check { text-align: center; padding: 8px 4px; }
.adm-security-review-page .sr-col-status   { width: 100px; }
.adm-security-review-page .sr-col-severity { width: 90px; }
.adm-security-review-page .sr-col-type     { width: 170px; }
.adm-security-review-page .sr-col-target   { width: 200px; }
.adm-security-review-page .sr-col-summary  { width: auto; }
.adm-security-review-page .sr-col-date     { width: 140px; }
.adm-security-review-page .sr-col-action   { width: 240px; }

.adm-security-review-page .sr-th {
    white-space: nowrap; overflow: hidden;
    user-select: none;
    padding-right: 18px; box-sizing: border-box;
}
.adm-security-review-page .sr-th.sr-sortable { cursor: pointer; }
.adm-security-review-page .sr-th .sr-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.adm-security-review-page .sr-th .sr-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .adm-security-review-page .sr-th .sr-sort-ico { color: #2563eb; }

.adm-security-review-page .sr-table td {
    vertical-align: top; overflow: hidden;
    word-break: break-word;
}
.adm-security-review-page .sr-table .adm-security-review-summary {
    white-space: normal; line-height: 1.45;
    max-height: 8em; overflow: hidden; text-overflow: ellipsis;
}
.adm-security-review-page .sr-table .adm-security-review-row-actions {
    display: flex; flex-wrap: wrap; gap: 4px;
}

/* card head + export */
.adm-security-review-page .sr-card-head { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap; }
.adm-security-review-page .sr-total-label { margin-left: 8px; font-size: 12px; color: #94a3b8; font-weight: normal; }
.adm-security-review-page .sr-export-control { position: relative; display: inline-flex; align-items: center; gap: 6px; }
.adm-security-review-page .sr-export-control .sr-export-format { min-width: 84px; }
.adm-security-review-page .sr-export-control .adm-export-dropdown {
    display: none; position: absolute; top: 100%; right: 0; margin-top: 4px;
    background: var(--adm-card-bg, #1e293b); border: 1px solid var(--adm-border, #334155);
    border-radius: 6px; padding: 4px; z-index: 30; min-width: 200px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.25);
}
.adm-security-review-page .sr-export-control .adm-export-dropdown.open { display: block; }
.adm-security-review-page .sr-export-control .adm-export-item {
    display: block; width: 100%; text-align: left; padding: 6px 10px;
    background: transparent; color: inherit; border: 0; cursor: pointer;
    font-size: 13px; border-radius: 4px;
}
.adm-security-review-page .sr-export-control .adm-export-item:disabled { opacity: 0.5; cursor: not-allowed; }
.adm-security-review-page .sr-export-control .adm-export-item:hover:not(:disabled) { background: rgba(148,163,184,0.15); }

/* controlbar */
.adm-security-review-page .sr-controlbar { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 8px 14px; flex-wrap: wrap; }
.adm-security-review-page .sr-bulkbar { display: flex; align-items: center; gap: 10px; opacity: 0.55; transition: opacity 0.2s; }
.adm-security-review-page .sr-bulkbar.is-active { opacity: 1; }
.adm-security-review-page .sr-bulk-count { font-size: 13px; }
.adm-security-review-page .sr-bulk-count strong { font-size: 15px; margin-right: 2px; color: #fbbf24; }
.adm-security-review-page .sr-bulk-actions { display: inline-flex; gap: 6px; align-items: center; }
.adm-security-review-page .sr-view-tools { display: inline-flex; gap: 8px; align-items: center; flex-wrap: wrap; }
.adm-security-review-page .sr-tool { display: inline-flex; gap: 4px; align-items: center; }
.adm-security-review-page .sr-tool-label { font-size: 12px; color: #94a3b8; }
.adm-security-review-page .sr-page-search { min-width: 220px; }
.adm-security-review-page .sr-sort-reset { font-size: 12px; }

/* pagination */
.adm-security-review-page .sr-pagination { display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; gap: 10px; flex-wrap: wrap; }
.adm-security-review-page .sr-page-info { font-size: 12px; color: #94a3b8; }
.adm-security-review-page .sr-page-actions { display: inline-flex; gap: 8px; align-items: center; }
.adm-security-review-page .sr-page-state { font-size: 13px; min-width: 60px; text-align: center; }

.adm-security-review-page .sr-empty,
.adm-security-review-page .sr-empty-cell { padding: 16px; text-align: center; color: #94a3b8; }
.adm-security-review-page .adm-is-hidden { display: none !important; }

@media (max-width: 1180px) {
    .adm-security-review-page .adm-security-review-filterbar { flex-wrap: wrap; }
    .adm-security-review-page .sr-controlbar { flex-direction: column; align-items: stretch; }
    .adm-security-review-page .sr-bulkbar { flex-wrap: wrap; }
    .adm-security-review-page .sr-view-tools { justify-content: flex-end; }
}
</style>

<%@ include file="../layout-close.jsp" %>
