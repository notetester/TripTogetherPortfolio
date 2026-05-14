<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations --%>
<spring:message var="msg_security_admin_loginReviews_title" code="security.admin.loginReviews.title"/>
<spring:message var="msg_security_admin_comment_approved" code="security.admin.comment.approved"/>
<spring:message var="msg_security_admin_comment_needMoreCheck" code="security.admin.comment.needMoreCheck"/>
<spring:message var="msg_security_admin_comment_notBlocked" code="security.admin.comment.notBlocked"/>
<spring:message var="msg_security_admin_loginReviews_desc" code="security.admin.loginReviews.desc"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_security_admin_nav_externalAssessments" code="security.admin.nav.externalAssessments"/>
<spring:message var="msg_security_admin_nav_notifications" code="security.admin.nav.notifications"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_severity" code="security.admin.common.severity"/>
<spring:message var="msg_security_admin_common_type" code="security.admin.common.type"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_reviewType" code="security.admin.common.reviewType"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_summary" code="security.admin.common.summary"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_common_action" code="security.admin.common.action"/>
<spring:message var="msg_security_admin_common_reviewComment" code="security.admin.common.reviewComment"/>
<spring:message var="msg_security_admin_common_approve" code="security.admin.common.approve"/>
<spring:message var="msg_security_admin_common_hold" code="security.admin.common.hold"/>
<spring:message var="msg_security_admin_common_reject" code="security.admin.common.reject"/>
<spring:message var="msg_security_admin_empty_reviews" code="security.admin.empty.reviews"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
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
<spring:message var="msg_lrr_bulkComment" code="security.admin.loginReviews.bulkComment"/>
<spring:message var="msg_lrr_bulkActionPlaceholder" code="security.admin.loginReviews.bulkActionPlaceholder"/>
<spring:message var="msg_lrr_searchTypeLabel" code="security.admin.loginReviews.searchTypeLabel"/>
<spring:message var="msg_lrr_searchType_all" code="security.admin.loginReviews.searchType.all"/>
<spring:message var="msg_lrr_searchType_target" code="security.admin.loginReviews.searchType.target"/>
<spring:message var="msg_lrr_searchType_user" code="security.admin.loginReviews.searchType.user"/>
<spring:message var="msg_lrr_searchType_summary" code="security.admin.loginReviews.searchType.summary"/>
<spring:message var="msg_lrr_searchType_detail" code="security.admin.loginReviews.searchType.detail"/>
<spring:message var="msg_lrr_searchType_policyCode" code="security.admin.loginReviews.searchType.policyCode"/>
<spring:message var="msg_lrr_searchPlaceholder" code="security.admin.loginReviews.searchPlaceholder"/>
<spring:message var="msg_lrr_modeLabel" code="security.admin.loginReviews.modeLabel"/>
<spring:message var="msg_lrr_modeClient" code="security.admin.loginReviews.modeClient"/>
<spring:message var="msg_lrr_modeServer" code="security.admin.loginReviews.modeServer"/>
<spring:message var="msg_lrr_modeTipClient" code="security.admin.loginReviews.modeTipClient"/>
<spring:message var="msg_lrr_modeTipServer" code="security.admin.loginReviews.modeTipServer"/>
<spring:message var="msg_lrr_showMore" code="security.admin.loginReviews.showMore"/>
<spring:message var="msg_lrr_showLess" code="security.admin.loginReviews.showLess"/>
<spring:message var="msg_lrr_inPageSearchLabel" code="security.admin.loginReviews.inPageSearchLabel"/>

<c:set var="pageTitle" value="${msg_security_admin_loginReviews_title}"/>
<c:set var="activeMenu" value="loginRiskReviews"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-login-review-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_loginReviews_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_loginReviews_desc}</p>
        </div>
        <div class="adm-actions adm-login-review-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/policies">${msg_security_admin_nav_policies}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${msg_security_admin_nav_externalAssessments}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">${msg_security_admin_nav_notifications}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <%-- ══════ 검색 / 필터 바 (회원관리 패턴 .adm-filter-bar) ══════ --%>
    <div class="adm-card adm-login-review-filter-card">
        <div class="adm-card-body">
            <form id="lrrSearchForm" method="get" action="${pageContext.request.contextPath}/admin/login-risk/reviews">
                <div class="adm-filter-bar lrr-filter-bar">
                    <div class="lrr-keyword-field">
                        <div class="adm-filter-label">${msg_security_admin_common_search}</div>
                        <div class="lrr-search-row">
                            <select class="adm-select lrr-search-type" name="searchType">
                                <option value="all" ${searchType == 'all' ? 'selected' : ''}>${msg_lrr_searchType_all}</option>
                                <option value="target" ${searchType == 'target' ? 'selected' : ''}>${msg_lrr_searchType_target}</option>
                                <option value="user" ${searchType == 'user' ? 'selected' : ''}>${msg_lrr_searchType_user}</option>
                                <option value="summary" ${searchType == 'summary' ? 'selected' : ''}>${msg_lrr_searchType_summary}</option>
                                <option value="detail" ${searchType == 'detail' ? 'selected' : ''}>${msg_lrr_searchType_detail}</option>
                                <option value="policyCode" ${searchType == 'policyCode' ? 'selected' : ''}>${msg_lrr_searchType_policyCode}</option>
                            </select>
                            <div class="adm-search-box lrr-search-box">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword"
                                       value="${fn:escapeXml(keyword)}" placeholder="${msg_lrr_searchPlaceholder}">
                            </div>
                        </div>
                    </div>

                    <div class="lrr-filter-field">
                        <div class="adm-filter-label">${msg_security_admin_common_status}</div>
                        <select class="adm-select" name="status">
                            <option value="">${msg_security_admin_common_all}</option>
                            <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                            <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                            <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                            <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                        </select>
                    </div>

                    <div class="lrr-filter-field">
                        <div class="adm-filter-label">${msg_security_admin_common_severity}</div>
                        <select class="adm-select" name="severity">
                            <option value="">${msg_security_admin_common_all}</option>
                            <option value="CRITICAL" ${severity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                            <option value="HIGH" ${severity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                            <option value="MEDIUM" ${severity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                            <option value="LOW" ${severity == 'LOW' ? 'selected' : ''}>LOW</option>
                        </select>
                    </div>

                    <div class="lrr-filter-field">
                        <div class="adm-filter-label">${msg_security_admin_common_reviewType}</div>
                        <input class="adm-input lrr-filter-input" type="text" name="reviewType"
                               value="${fn:escapeXml(reviewType)}" placeholder="IP_LOGIN_RISK">
                    </div>

                    <div class="lrr-filter-actions">
                        <button class="adm-btn adm-btn-primary" type="submit">🔍 ${msg_admin_common_searchButton}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${msg_admin_common_reset}</a>
                    </div>

                    <input type="hidden" id="lrrPageInput" name="page" value="${currentPage}">
                    <input type="hidden" id="lrrSizeInput" name="size" value="${pageSize}">
                    <input type="hidden" id="lrrModeInput" name="mode" value="${mode}">
                    <input type="hidden" id="lrrSortByInput" name="sortBy" value="${fn:escapeXml(sortBy)}">
                    <input type="hidden" id="lrrSortDirInput" name="sortDir" value="${fn:escapeXml(sortDir)}">
                </div>
            </form>
        </div>
    </div>

    <%-- ══════ 리스트 카드 ══════ --%>
    <div class="adm-card adm-login-review-list-card adm-overflow-visible">
        <div class="adm-card-head lrr-card-head">
            <div class="lrr-card-title-area">
                <div class="adm-card-title">${msg_security_admin_loginReviews_title}</div>
                <span class="lrr-total-label" id="lrrTotalLabel"></span>
            </div>
            <div class="adm-export-control lrr-export-control">
                <select class="adm-select lrr-export-format" id="lrrExportFormat">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-lrr-export-toggle">${msg_admin_common_export} ▾</button>
                <div id="lrrExportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="lrrExport('all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="lrrExport('filtered')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item" id="lrrExportSelectedBtn" disabled onclick="lrrExport('selected')">${msg_admin_common_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <%-- 일괄 처리 바 — 선택 시에만 보임 --%>
        <div id="lrrBulkBar" class="lrr-bulkbar" aria-live="polite" hidden>
            <span class="lrr-bulk-count"><strong id="lrrBulkCount">0</strong>${msg_admin_common_selectedCount}</span>
            <div class="lrr-bulk-actions">
                <select class="adm-select" id="lrrBulkActionSelect">
                    <option value="">${msg_lrr_bulkActionPlaceholder}</option>
                    <option value="approve">${msg_security_admin_common_approve}</option>
                    <option value="hold">${msg_security_admin_common_hold}</option>
                    <option value="reject">${msg_security_admin_common_reject}</option>
                </select>
                <button type="button" class="adm-btn adm-btn-primary" onclick="lrrApplyBulk()">${msg_admin_common_apply}</button>
            </div>
            <button type="button" class="adm-btn adm-btn-ghost lrr-bulk-clear" onclick="lrrClearSelection()">${msg_admin_common_clearSelection}</button>
        </div>

        <%-- 도구바 (정렬초기화 + 모드 + 사이즈 + 결과내검색) --%>
        <div class="lrr-toolbar">
            <div class="lrr-toolbar-left">
                <button type="button" class="adm-btn adm-btn-ghost lrr-sort-reset adm-is-hidden" id="lrrSortReset" onclick="lrrResetSort()">${msg_lrr_sortReset}</button>

                <label class="lrr-tool" title="${msg_lrr_modeTipClient}">
                    <span class="lrr-tool-label">${msg_lrr_modeLabel}</span>
                    <select class="adm-select" id="lrrModeSelect" onchange="lrrChangeMode(this.value)">
                        <option value="CLIENT" ${mode == 'CLIENT' ? 'selected' : ''} title="${msg_lrr_modeTipClient}">${msg_lrr_modeClient}</option>
                        <option value="SERVER" ${mode == 'SERVER' ? 'selected' : ''} title="${msg_lrr_modeTipServer}">${msg_lrr_modeServer}</option>
                    </select>
                </label>

                <label class="lrr-tool">
                    <span class="lrr-tool-label">${msg_admin_common_pageSizeLabel}</span>
                    <select class="adm-select" id="lrrPageSize" onchange="lrrChangeSize(this.value)">
                        <option value="10"  ${pageSize == 10  ? 'selected' : ''}>${msg_admin_common_pageSize_10}</option>
                        <option value="20"  ${pageSize == 20  ? 'selected' : ''}>${msg_admin_common_pageSize_20}</option>
                        <option value="50"  ${pageSize == 50  ? 'selected' : ''}>${msg_admin_common_pageSize_50}</option>
                        <option value="100" ${pageSize == 100 ? 'selected' : ''}>${msg_admin_common_pageSize_100}</option>
                    </select>
                </label>
            </div>

            <div class="lrr-toolbar-right">
                <label class="lrr-page-search-field">
                    <span class="lrr-tool-label">${msg_lrr_inPageSearchLabel}</span>
                    <select class="adm-select lrr-page-search-col" id="lrrPageSearchCol" onchange="lrrSetPageSearchCol(this.value)">
                        <option value="all">${msg_lrr_searchType_all}</option>
                        <option value="status">${msg_security_admin_common_status}</option>
                        <option value="severity">${msg_security_admin_common_severity}</option>
                        <option value="type">${msg_security_admin_common_reviewType}</option>
                        <option value="target">${msg_security_admin_common_target}</option>
                        <option value="summary">${msg_security_admin_common_summary}</option>
                    </select>
                    <div class="adm-search-box lrr-page-search-box">
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input lrr-page-search" id="lrrPageSearch" type="text" placeholder="${msg_lrr_inPageSearchLabel}" oninput="lrrSetPageSearch(this.value)">
                    </div>
                </label>
            </div>
        </div>

        <div class="adm-table-wrap">
            <table id="loginRiskReviewTable"
                   class="adm-table adm-section-table-fixed adm-login-review-table lrr-table"
                   data-section="loginRiskReviews"
                   data-admin-list-ignore="hard">
                <colgroup>
                    <col class="lrr-col-check"/>
                    <col class="lrr-col-status"/>
                    <col class="lrr-col-severity"/>
                    <col class="lrr-col-type"/>
                    <col class="lrr-col-target"/>
                    <col class="lrr-col-summary"/>
                    <col class="lrr-col-date"/>
                    <col class="lrr-col-action"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="lrr-th lrr-th-check"><input type="checkbox" id="lrrCheckAll" onchange="lrrToggleAll(this)" aria-label="select-all"></th>
                    <th class="lrr-th lrr-sortable" data-sort="status" onclick="lrrSortBy('status')"><span class="lrr-th-label">${msg_security_admin_common_status}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th lrr-sortable" data-sort="severity" onclick="lrrSortBy('severity')"><span class="lrr-th-label">${msg_security_admin_common_severity}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th lrr-sortable" data-sort="type" onclick="lrrSortBy('type')"><span class="lrr-th-label">${msg_security_admin_common_reviewType}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th lrr-sortable" data-sort="target" onclick="lrrSortBy('target')"><span class="lrr-th-label">${msg_security_admin_common_target}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th lrr-sortable" data-sort="summary" onclick="lrrSortBy('summary')"><span class="lrr-th-label">${msg_security_admin_common_summary}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th lrr-sortable" data-sort="date" onclick="lrrSortBy('date')"><span class="lrr-th-label">${msg_security_admin_common_createdAt}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th"><span class="lrr-th-label">${msg_security_admin_common_action}</span></th>
                </tr>
                </thead>
                <tbody id="lrrTableBody">
                <c:forEach var="r" items="${reviews}">
                    <tr data-row-id="${r.reviewIdx}"
                        data-sort-status="${fn:escapeXml(r.reviewStatus)}"
                        data-sort-severity="${fn:escapeXml(r.severity)}"
                        data-sort-type="${fn:escapeXml(r.reviewType)}"
                        data-sort-target="${fn:escapeXml(r.subjectType)}:${fn:escapeXml(r.subjectKey)}"
                        data-sort-summary="${fn:escapeXml(r.summary)}"
                        data-sort-date="<fmt:formatDate value='${r.createdAtDate}' pattern='yyyyMMddHHmm'/>">
                        <td class="lrr-cell-check"><input type="checkbox" class="js-lrr-row-check" value="${r.reviewIdx}" onchange="lrrUpdateBulkCount()" aria-label="row-select"></td>
                        <td><span class="adm-badge lrr-status-badge lrr-status-${fn:toLowerCase(r.reviewStatus)}"><c:out value="${r.reviewStatus}"/></span></td>
                        <td><span class="lrr-severity lrr-severity-${fn:toLowerCase(r.severity)}"><c:out value="${r.severity}"/></span></td>
                        <td class="lrr-cell-type">
                            <div class="lrr-cell-primary"><c:out value="${r.reviewType}"/></div>
                            <div class="adm-page-muted"><c:out value="${r.policyCode}"/></div>
                        </td>
                        <td class="lrr-cell-target">
                            <div><c:out value="${r.subjectType}"/>: <c:out value="${r.subjectKey}"/></div>
                            <c:if test="${not empty r.userId}"><div class="adm-page-muted"><c:out value="${r.userId}"/> / <c:out value="${r.nickname}"/></div></c:if>
                        </td>
                        <td class="lrr-cell-summary">
                            <div class="lrr-summary">
                                <strong class="lrr-summary-title"><c:out value="${r.summary}"/></strong>
                                <c:if test="${not empty r.detailMessage}">
                                    <div class="lrr-summary-body" data-clamp="true"><c:out value="${r.detailMessage}"/></div>
                                </c:if>
                                <c:if test="${not empty r.reviewComment}">
                                    <div class="lrr-summary-comment">${msg_security_admin_common_reviewComment}: <c:out value="${r.reviewComment}"/></div>
                                </c:if>
                                <c:if test="${not empty r.detailMessage}">
                                    <button type="button" class="lrr-summary-toggle js-lrr-summary-toggle" data-label-more="${msg_lrr_showMore}" data-label-less="${msg_lrr_showLess}">${msg_lrr_showMore}</button>
                                </c:if>
                            </div>
                        </td>
                        <td class="lrr-cell-date"><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td class="lrr-cell-action">
                            <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                                <div class="lrr-row-actions">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/approve">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_approved}">
                                        <button class="adm-btn adm-btn-primary adm-btn-sm" type="submit">${msg_security_admin_common_approve}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/hold">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_needMoreCheck}">
                                        <button class="adm-btn adm-btn-ghost adm-btn-sm" type="submit">${msg_security_admin_common_hold}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/reject">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_notBlocked}">
                                        <button class="adm-btn adm-btn-danger adm-btn-sm" type="submit">${msg_security_admin_common_reject}</button>
                                    </form>
                                </div>
                            </c:if>
                            <c:if test="${r.reviewStatus != 'PENDING' && r.reviewStatus != 'HOLD'}">
                                <div class="adm-page-muted"><c:out value="${r.reviewedByUserId}"/> / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="lrr-empty adm-is-hidden" id="lrrEmptyState">${msg_security_admin_empty_reviews}</div>
        </div>

        <div class="lrr-pagination" id="lrrPaging">
            <div class="lrr-page-info"><span id="lrrPageInfo"></span></div>
            <div class="lrr-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" id="lrrPrevBtn" onclick="lrrGoPage(window.lrrState.page - 1)">${msg_admin_common_prev}</button>
                <span class="lrr-page-state" id="lrrPageState"></span>
                <button type="button" class="adm-btn adm-btn-ghost" id="lrrNextBtn" onclick="lrrGoPage(window.lrrState.page + 1)">${msg_admin_common_next}</button>
            </div>
        </div>
    </div>
</div>

<script>
(function () {
    'use strict';
    /* ─── 로그인 위험 검토 — 두 가지 로드 방식 ───────────────────────
       CLIENT 모드: 컨트롤러가 size=10000 으로 전체 fetch → 클라이언트에서 페이징·정렬·검색
       SERVER 모드: 컨트롤러가 size 단위로 페이징해서 반환 → page/sortBy 변경 시 form submit (full reload)
       두 모드 모두 동일 GET 핸들러 사용 (mode 파라미터로 분기). */
    var ctx = '${pageContext.request.contextPath}';

    var LRR_MSG = {
        exportSelectedLabel: '${msg_admin_common_exportSelected}',
        pickAction: '${msg_lrr_pickAction}',
        noSelection: '${msg_lrr_noSelection}',
        bulkConfirmTpl: '<spring:message code="security.admin.loginReviews.bulkConfirm" arguments="{0}" javaScriptEscape="true"/>',
        bulkComment: '${msg_lrr_bulkComment}',
        totalLabelTpl: '<spring:message code="admin.common.totalCount" arguments="{0}" javaScriptEscape="true"/>',
        showMore: '${msg_lrr_showMore}',
        showLess: '${msg_lrr_showLess}'
    };
    window.LRR_MSG = LRR_MSG;

    var lrrState = {
        mode: '${mode}',
        page: ${currentPage},
        pageSize: parseInt('${pageSize}', 10) || 20,
        sortBy: '${fn:escapeXml(sortBy)}',
        sortDir: '${fn:escapeXml(sortDir)}' || 'ASC',
        pageSearch: '',
        pageSearchCol: 'all',
        rows: [],
        filtered: [],
        serverTotal: parseInt('${total}', 10) || 0
    };
    window.lrrState = lrrState;

    function cacheRows() {
        var tbody = document.getElementById('lrrTableBody');
        if (!tbody) return;
        lrrState.rows = Array.prototype.slice.call(tbody.querySelectorAll('tr[data-row-id]'));
    }

    /* 결과 내 검색 — 컬럼별 분기 */
    function rowMatches(tr, q) {
        if (!q) return true;
        var col = lrrState.pageSearchCol || 'all';
        var text;
        if (col === 'all') {
            text = (tr.innerText || tr.textContent || '');
        } else {
            var attr = tr.getAttribute('data-sort-' + col) || '';
            text = attr;
        }
        return text.toLowerCase().indexOf(q) !== -1;
    }

    function applyFilter() {
        var q = (lrrState.pageSearch || '').trim().toLowerCase();
        if (!q) { lrrState.filtered = lrrState.rows.slice(); return; }
        lrrState.filtered = lrrState.rows.filter(function (tr) { return rowMatches(tr, q); });
    }

    function applySort() {
        if (!lrrState.sortBy) return;
        var dir = lrrState.sortDir === 'DESC' ? -1 : 1;
        var attr = 'data-sort-' + lrrState.sortBy;
        lrrState.filtered.sort(function (a, b) {
            var av = (a.getAttribute(attr) || '').toLowerCase();
            var bv = (b.getAttribute(attr) || '').toLowerCase();
            return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * dir;
        });
    }

    function render() {
        var tbody = document.getElementById('lrrTableBody');
        if (!tbody) return;

        var displayRows;
        var total;
        var totalPage;

        if (lrrState.mode === 'SERVER') {
            /* SERVER 모드: 서버가 페이지 단위로 보낸 행을 그대로 표시, 정렬·페이지내검색만 적용 */
            displayRows = lrrState.filtered.slice();
            total = lrrState.serverTotal;
            totalPage = Math.max(1, Math.ceil(total / lrrState.pageSize));
        } else {
            /* CLIENT 모드: 캐싱한 전체 행을 클라이언트에서 페이징 */
            total = lrrState.filtered.length;
            var pageSize = lrrState.pageSize > 0 ? lrrState.pageSize : 20;
            totalPage = Math.max(1, Math.ceil(total / pageSize));
            if (lrrState.page > totalPage) lrrState.page = totalPage;
            if (lrrState.page < 1) lrrState.page = 1;
            var start = (lrrState.page - 1) * pageSize;
            displayRows = lrrState.filtered.slice(start, start + pageSize);
        }

        lrrState.rows.forEach(function (tr) { if (tr.parentNode === tbody) tbody.removeChild(tr); });
        Array.prototype.slice.call(tbody.querySelectorAll('.lrr-empty-row')).forEach(function (tr) { tr.remove(); });
        displayRows.forEach(function (tr) { tbody.appendChild(tr); });
        if (displayRows.length === 0) {
            var emptyTpl = document.getElementById('lrrEmptyState');
            var emptyText = emptyTpl ? emptyTpl.textContent : '';
            var emptyTr = document.createElement('tr');
            emptyTr.className = 'lrr-empty-row';
            var td = document.createElement('td');
            td.colSpan = 8; td.className = 'lrr-empty-cell'; td.textContent = emptyText;
            emptyTr.appendChild(td);
            tbody.appendChild(emptyTr);
        }

        /* 총건수 / 페이지네이션 */
        var totalLabel = document.getElementById('lrrTotalLabel');
        if (totalLabel) totalLabel.textContent = (LRR_MSG.totalLabelTpl || '').replace('{0}', String(total));
        var info = document.getElementById('lrrPageInfo');
        if (info) info.textContent = total + ' / ' + lrrState.rows.length;
        var stateEl = document.getElementById('lrrPageState');
        if (stateEl) stateEl.textContent = lrrState.page + ' / ' + totalPage;
        var prev = document.getElementById('lrrPrevBtn');
        var next = document.getElementById('lrrNextBtn');
        if (prev) prev.disabled = lrrState.page <= 1;
        if (next) next.disabled = lrrState.page >= totalPage;

        /* 정렬 인디케이터 */
        Array.prototype.slice.call(document.querySelectorAll('#loginRiskReviewTable thead th.lrr-sortable')).forEach(function (th) {
            var ico = th.querySelector('.lrr-sort-ico');
            if (!ico) return;
            ico.textContent = (th.getAttribute('data-sort') === lrrState.sortBy)
                ? (lrrState.sortDir === 'DESC' ? '▼' : '▲')
                : '';
        });
        var resetBtn = document.getElementById('lrrSortReset');
        if (resetBtn) resetBtn.classList.toggle('adm-is-hidden', !lrrState.sortBy);

        updateBulkCount();
    }

    function applyAll() { applyFilter(); applySort(); render(); }

    function updateBulkCount() {
        var checked = document.querySelectorAll('#lrrTableBody .js-lrr-row-check:checked');
        var n = checked.length;
        var bulkBar = document.getElementById('lrrBulkBar');
        if (bulkBar) {
            /* 선택 시에만 노출 */
            if (n > 0) {
                bulkBar.hidden = false;
                bulkBar.setAttribute('aria-hidden', 'false');
            } else {
                bulkBar.hidden = true;
                bulkBar.setAttribute('aria-hidden', 'true');
            }
        }
        var countEl = document.getElementById('lrrBulkCount');
        if (countEl) countEl.textContent = n;
        var selBtn = document.getElementById('lrrExportSelectedBtn');
        if (selBtn) {
            selBtn.disabled = n === 0;
            selBtn.textContent = LRR_MSG.exportSelectedLabel + ' (' + n + ')';
        }
        var checkAll = document.getElementById('lrrCheckAll');
        if (checkAll) {
            var visible = document.querySelectorAll('#lrrTableBody .js-lrr-row-check');
            checkAll.checked = visible.length > 0 && n === visible.length;
            checkAll.indeterminate = n > 0 && n < visible.length;
        }
    }
    window.lrrUpdateBulkCount = updateBulkCount;

    window.lrrToggleAll = function (cb) {
        document.querySelectorAll('#lrrTableBody .js-lrr-row-check').forEach(function (c) { c.checked = cb.checked; });
        updateBulkCount();
    };
    window.lrrClearSelection = function () {
        document.querySelectorAll('#lrrTableBody .js-lrr-row-check').forEach(function (c) { c.checked = false; });
        var checkAll = document.getElementById('lrrCheckAll');
        if (checkAll) { checkAll.checked = false; checkAll.indeterminate = false; }
        updateBulkCount();
    };

    /* SERVER 모드 헬퍼: hidden field 갱신 후 form submit */
    function submitSearchForm(extra) {
        extra = extra || {};
        var setField = function (id, value) {
            var el = document.getElementById(id);
            if (el) el.value = value;
        };
        if ('page' in extra) setField('lrrPageInput', extra.page);
        if ('size' in extra) setField('lrrSizeInput', extra.size);
        if ('mode' in extra) setField('lrrModeInput', extra.mode);
        if ('sortBy' in extra) setField('lrrSortByInput', extra.sortBy);
        if ('sortDir' in extra) setField('lrrSortDirInput', extra.sortDir);
        document.getElementById('lrrSearchForm').submit();
    }

    window.lrrSortBy = function (field) {
        var nextDir = (lrrState.sortBy === field && lrrState.sortDir === 'ASC') ? 'DESC' : 'ASC';
        lrrState.sortBy = field;
        lrrState.sortDir = nextDir;
        lrrState.page = 1;
        if (lrrState.mode === 'SERVER') {
            submitSearchForm({ sortBy: field, sortDir: nextDir, page: 1 });
        } else {
            applyAll();
        }
    };
    window.lrrResetSort = function () {
        lrrState.sortBy = ''; lrrState.sortDir = 'ASC'; lrrState.page = 1;
        if (lrrState.mode === 'SERVER') {
            submitSearchForm({ sortBy: '', sortDir: 'ASC', page: 1 });
        } else {
            applyAll();
        }
    };
    window.lrrChangeSize = function (size) {
        var n = parseInt(size, 10);
        lrrState.pageSize = (n > 0 ? n : 20);
        lrrState.page = 1;
        if (lrrState.mode === 'SERVER') {
            submitSearchForm({ size: lrrState.pageSize, page: 1 });
        } else {
            render();
        }
    };
    window.lrrGoPage = function (p) {
        var totalPage;
        if (lrrState.mode === 'SERVER') {
            totalPage = Math.max(1, Math.ceil(lrrState.serverTotal / lrrState.pageSize));
        } else {
            totalPage = Math.max(1, Math.ceil(lrrState.filtered.length / lrrState.pageSize));
        }
        var next = Math.min(Math.max(1, parseInt(p, 10) || 1), totalPage);
        if (next === lrrState.page) return;
        lrrState.page = next;
        if (lrrState.mode === 'SERVER') {
            submitSearchForm({ page: next });
        } else {
            render();
        }
    };
    window.lrrChangeMode = function (mode) {
        var normalized = (mode === 'SERVER') ? 'SERVER' : 'CLIENT';
        if (normalized === lrrState.mode) return;
        /* 모드 전환 시 페이지 리로드. CLIENT→SERVER 면 SERVER size 적용 */
        submitSearchForm({ mode: normalized, page: 1 });
    };
    window.lrrSetPageSearch = function (text) {
        lrrState.pageSearch = text || '';
        lrrState.page = 1;
        applyAll();
    };
    window.lrrSetPageSearchCol = function (col) {
        lrrState.pageSearchCol = col || 'all';
        applyAll();
    };

    window.lrrApplyBulk = function () {
        var action = (document.getElementById('lrrBulkActionSelect') || {}).value || '';
        if (!action) { alert(LRR_MSG.pickAction); return; }
        var checked = Array.prototype.slice.call(document.querySelectorAll('#lrrTableBody .js-lrr-row-check:checked'));
        if (!checked.length) { alert(LRR_MSG.noSelection); return; }
        var confirmMsg = (LRR_MSG.bulkConfirmTpl || '').replace('{0}', String(checked.length));
        if (!window.confirm(confirmMsg)) return;

        var ids = checked.map(function (c) { return c.value; }).join(',');
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = ctx + '/admin/login-risk/reviews/bulk';
        function addInput(name, value) {
            var inp = document.createElement('input');
            inp.type = 'hidden'; inp.name = name; inp.value = value;
            form.appendChild(inp);
        }
        addInput('action', action);
        addInput('ids', ids);
        addInput('comment', LRR_MSG.bulkComment);
        document.body.appendChild(form);
        form.submit();
    };

    window.lrrExport = function (scope) {
        var format = (document.getElementById('lrrExportFormat') || {}).value || 'csv';
        var params = new URLSearchParams();
        params.set('scope', scope);
        params.set('format', format);
        if (scope === 'filtered') {
            var form = document.getElementById('lrrSearchForm');
            if (form) {
                var fd = new FormData(form);
                fd.forEach(function (v, k) {
                    if (v && k !== 'page' && k !== 'size' && k !== 'mode' && k !== 'sortBy' && k !== 'sortDir') {
                        params.set(k, v);
                    }
                });
            }
        }
        if (scope === 'selected') {
            var ids = Array.prototype.slice.call(document.querySelectorAll('#lrrTableBody .js-lrr-row-check:checked')).map(function (c) { return c.value; });
            if (!ids.length) { alert(LRR_MSG.noSelection); return; }
            params.set('selectedIds', ids.join(','));
        }
        var dropdown = document.getElementById('lrrExportDropdown');
        if (dropdown) dropdown.classList.remove('open');
        window.location.href = ctx + '/admin/login-risk/reviews/export?' + params.toString();
    };

    function initExportDropdown() {
        var toggle = document.querySelector('.js-lrr-export-toggle');
        var dropdown = document.getElementById('lrrExportDropdown');
        if (!toggle || !dropdown) return;
        toggle.addEventListener('click', function (e) {
            e.stopPropagation();
            dropdown.classList.toggle('open');
        });
        document.addEventListener('click', function (e) {
            if (!toggle.contains(e.target) && !dropdown.contains(e.target)) dropdown.classList.remove('open');
        });
    }

    function initSummaryToggles() {
        document.addEventListener('click', function (e) {
            var btn = e.target.closest('.js-lrr-summary-toggle');
            if (!btn) return;
            var card = btn.closest('.lrr-summary');
            if (!card) return;
            var expanded = card.classList.toggle('is-expanded');
            btn.textContent = expanded ? (btn.getAttribute('data-label-less') || LRR_MSG.showLess)
                                       : (btn.getAttribute('data-label-more') || LRR_MSG.showMore);
        });
    }

    function init() {
        cacheRows();
        initExportDropdown();
        initSummaryToggles();
        applyAll();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
</script>

<style>
/* ══════════════════════════════════════════════════════════════
   로그인 위험 검토 — 자체 스타일 (lrr-)
   ══════════════════════════════════════════════════════════════ */

/* 검색 / 필터 바 — 회원관리 .adm-filter-bar 패턴 차용 */
.adm-login-review-page .lrr-filter-bar {
    display: flex; flex-wrap: wrap; gap: 12px; align-items: flex-end;
}
.adm-login-review-page .lrr-keyword-field { flex: 1 1 360px; min-width: 280px; }
.adm-login-review-page .lrr-filter-field  { flex: 0 0 auto; min-width: 140px; }
.adm-login-review-page .lrr-search-row    { display: flex; gap: 6px; }
.adm-login-review-page .lrr-search-type   { min-width: 110px; flex: 0 0 auto; }
.adm-login-review-page .lrr-search-box    { position: relative; flex: 1 1 auto; }
.adm-login-review-page .lrr-search-box .adm-search-ico {
    position: absolute; left: 10px; top: 50%; transform: translateY(-50%);
    font-size: 13px; pointer-events: none;
}
.adm-login-review-page .lrr-search-box input.adm-input { padding-left: 30px; width: 100%; }
.adm-login-review-page .lrr-filter-input  { min-width: 140px; }
.adm-login-review-page .lrr-filter-actions {
    display: inline-flex; gap: 8px; align-items: center; margin-left: auto;
}

/* 카드 head — 다운로드 한 줄 정리 */
.adm-login-review-page .lrr-card-head {
    display: flex; align-items: center; justify-content: space-between;
    gap: 12px; padding: 12px 16px;
}
.adm-login-review-page .lrr-card-title-area {
    display: inline-flex; align-items: center; gap: 10px; flex-wrap: nowrap;
    min-width: 0;
}
.adm-login-review-page .lrr-total-label {
    font-size: 12px; color: #94a3b8; font-weight: normal; white-space: nowrap;
}

/* 다운로드 — 한 줄 강제, 드롭다운 CSS 강화 */
.adm-login-review-page .lrr-export-control {
    position: relative; display: inline-flex; gap: 6px; align-items: center;
    flex-wrap: nowrap; white-space: nowrap;
}
.adm-login-review-page .lrr-export-control .lrr-export-format { min-width: 84px; }
.adm-login-review-page .lrr-export-control .js-lrr-export-toggle { white-space: nowrap; }
.adm-login-review-page .lrr-export-control .adm-export-dropdown {
    display: none;
    position: absolute; top: calc(100% + 4px); right: 0; z-index: 50;
    background: var(--adm-card-bg, #1e293b);
    border: 1px solid var(--adm-border, #334155);
    border-radius: 6px; padding: 4px; min-width: 220px;
    box-shadow: 0 12px 28px rgba(0,0,0,0.35);
}
body.sa-light .adm-login-review-page .lrr-export-control .adm-export-dropdown {
    background: #ffffff; border-color: #cbd5e1;
    box-shadow: 0 12px 28px rgba(15,23,42,0.18);
}
.adm-login-review-page .lrr-export-control .adm-export-dropdown.open { display: block; }
.adm-login-review-page .lrr-export-control .adm-export-item {
    display: block; width: 100%; text-align: left; padding: 8px 12px;
    background: transparent; color: inherit; border: 0; border-radius: 4px;
    cursor: pointer; font-size: 13px;
}
.adm-login-review-page .lrr-export-control .adm-export-item:hover:not(:disabled) {
    background: rgba(148,163,184,0.18);
}
.adm-login-review-page .lrr-export-control .adm-export-item:disabled {
    opacity: 0.45; cursor: not-allowed;
}

/* 일괄처리 바 — 선택 시에만 보임 (hidden 속성 사용) */
.adm-login-review-page .lrr-bulkbar[hidden] { display: none !important; }
.adm-login-review-page .lrr-bulkbar {
    display: flex; align-items: center; gap: 12px;
    margin: 0 16px 8px; padding: 10px 14px;
    background: rgba(251,191,36,0.10);
    border: 1px solid rgba(251,191,36,0.30);
    border-radius: 8px;
    flex-wrap: wrap;
}
.adm-login-review-page .lrr-bulk-count { font-size: 13px; }
.adm-login-review-page .lrr-bulk-count strong { font-size: 15px; margin-right: 2px; color: #fbbf24; }
.adm-login-review-page .lrr-bulk-actions { display: inline-flex; gap: 6px; align-items: center; }
.adm-login-review-page .lrr-bulk-clear { margin-left: auto; }

/* 도구바 — 좌측(정렬리셋·모드·사이즈) + 우측(결과내 검색) */
.adm-login-review-page .lrr-toolbar {
    display: flex; align-items: center; justify-content: space-between;
    gap: 12px; padding: 8px 16px; flex-wrap: wrap;
}
.adm-login-review-page .lrr-toolbar-left,
.adm-login-review-page .lrr-toolbar-right {
    display: inline-flex; gap: 8px; align-items: center; flex-wrap: wrap;
}
.adm-login-review-page .lrr-toolbar-right { flex: 1 1 auto; justify-content: flex-end; }
.adm-login-review-page .lrr-tool { display: inline-flex; gap: 6px; align-items: center; }
.adm-login-review-page .lrr-tool-label { font-size: 12px; color: #94a3b8; white-space: nowrap; }
.adm-login-review-page .lrr-sort-reset { font-size: 12px; }

/* 결과 내 검색 — 길게 + 컬럼 select */
.adm-login-review-page .lrr-page-search-field {
    display: inline-flex; gap: 6px; align-items: center;
    flex: 1 1 320px; max-width: 560px; min-width: 280px;
}
.adm-login-review-page .lrr-page-search-col { min-width: 110px; flex: 0 0 auto; }
.adm-login-review-page .lrr-page-search-box {
    position: relative; flex: 1 1 auto; min-width: 0;
}
.adm-login-review-page .lrr-page-search-box .adm-search-ico {
    position: absolute; left: 10px; top: 50%; transform: translateY(-50%);
    font-size: 13px; pointer-events: none;
}
.adm-login-review-page .lrr-page-search { padding-left: 30px; width: 100%; min-width: 0; }

/* ──────── 테이블 ──────── */
.adm-login-review-page .lrr-table { width: 100%; min-width: 1120px; table-layout: fixed; }
.adm-login-review-page .lrr-col-check    { width: 42px; }
.adm-login-review-page .lrr-col-status   { width: 100px; }
.adm-login-review-page .lrr-col-severity { width: 84px; }
.adm-login-review-page .lrr-col-type     { width: 170px; }
.adm-login-review-page .lrr-col-target   { width: 200px; }
.adm-login-review-page .lrr-col-summary  { width: auto; min-width: 240px; }
.adm-login-review-page .lrr-col-date     { width: 130px; }
.adm-login-review-page .lrr-col-action   { width: 230px; }

.adm-login-review-page .lrr-th-check,
.adm-login-review-page .lrr-cell-check { text-align: center; padding: 8px 4px; }

.adm-login-review-page .lrr-th {
    white-space: nowrap; overflow: hidden;
    user-select: none; padding-right: 18px;
    position: relative; box-sizing: border-box;
}
.adm-login-review-page .lrr-th.lrr-sortable { cursor: pointer; }
.adm-login-review-page .lrr-th .lrr-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.adm-login-review-page .lrr-th .lrr-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .adm-login-review-page .lrr-th .lrr-sort-ico { color: #2563eb; }

.adm-login-review-page .lrr-table td {
    vertical-align: top; overflow: hidden;
    word-break: break-word;
}
.adm-login-review-page .lrr-cell-primary { font-weight: 600; }

/* 상태/심각도 색상 뱃지 */
.adm-login-review-page .lrr-status-badge { font-size: 11px; padding: 2px 6px; }
.adm-login-review-page .lrr-status-pending  { background: rgba(251,191,36,0.20); color: #fbbf24; }
.adm-login-review-page .lrr-status-hold     { background: rgba(148,163,184,0.20); color: #94a3b8; }
.adm-login-review-page .lrr-status-approved { background: rgba(34,197,94,0.20);  color: #22c55e; }
.adm-login-review-page .lrr-status-rejected { background: rgba(239,68,68,0.20);  color: #ef4444; }
.adm-login-review-page .lrr-severity { font-size: 12px; font-weight: 600; }
.adm-login-review-page .lrr-severity-critical { color: #ef4444; }
.adm-login-review-page .lrr-severity-high     { color: #fb923c; }
.adm-login-review-page .lrr-severity-medium   { color: #fbbf24; }
.adm-login-review-page .lrr-severity-low      { color: #94a3b8; }

/* 요약 컬럼 UX — 제목은 진하게, 본문은 clamp:2 + 더보기 */
.adm-login-review-page .lrr-summary {
    display: flex; flex-direction: column; gap: 4px;
    white-space: normal; line-height: 1.45;
}
.adm-login-review-page .lrr-summary-title { font-size: 13px; font-weight: 600; }
.adm-login-review-page .lrr-summary-body {
    font-size: 12px; color: #cbd5e1;
    display: -webkit-box; -webkit-box-orient: vertical;
    -webkit-line-clamp: 2; line-clamp: 2;
    overflow: hidden; text-overflow: ellipsis;
}
.adm-login-review-page .lrr-summary.is-expanded .lrr-summary-body {
    -webkit-line-clamp: unset; line-clamp: unset; display: block;
}
.adm-login-review-page .lrr-summary-comment {
    font-size: 12px; color: #94a3b8;
    border-left: 2px solid rgba(148,163,184,0.4); padding-left: 6px;
}
.adm-login-review-page .lrr-summary-toggle {
    align-self: flex-start; font-size: 11px;
    background: transparent; border: 0; padding: 2px 4px;
    color: #93c5fd; cursor: pointer;
}
body.sa-light .adm-login-review-page .lrr-summary-toggle { color: #2563eb; }

/* 행 액션 — 작은 버튼들 */
.adm-login-review-page .lrr-row-actions { display: flex; flex-wrap: wrap; gap: 4px; }
.adm-login-review-page .lrr-row-actions form { display: inline-flex; }
.adm-login-review-page .adm-btn-sm { padding: 4px 10px; font-size: 12px; }

/* 페이지네이션 */
.adm-login-review-page .lrr-pagination {
    display: flex; align-items: center; justify-content: space-between;
    padding: 10px 16px; gap: 10px; flex-wrap: wrap;
}
.adm-login-review-page .lrr-page-info { font-size: 12px; color: #94a3b8; }
.adm-login-review-page .lrr-page-actions { display: inline-flex; gap: 8px; align-items: center; }
.adm-login-review-page .lrr-page-state { font-size: 13px; min-width: 60px; text-align: center; }

/* 빈 상태 */
.adm-login-review-page .lrr-empty,
.adm-login-review-page .lrr-empty-cell { padding: 16px; text-align: center; color: #94a3b8; }
.adm-login-review-page .adm-is-hidden { display: none !important; }


/* ══════ 미디어 쿼리 ══════ */

/* 1280px↓ — 필터바·도구바 wrap 강화 */
@media (max-width: 1280px) {
    .adm-login-review-page .lrr-filter-bar { gap: 10px; }
    .adm-login-review-page .lrr-filter-actions { margin-left: 0; }
    .adm-login-review-page .lrr-toolbar { gap: 10px; }
}

/* 1080px↓ — 컨트롤바 stack */
@media (max-width: 1080px) {
    .adm-login-review-page .lrr-toolbar { flex-direction: column; align-items: stretch; }
    .adm-login-review-page .lrr-toolbar-left,
    .adm-login-review-page .lrr-toolbar-right { width: 100%; justify-content: flex-start; }
    .adm-login-review-page .lrr-page-search-field { max-width: none; flex: 1 1 auto; }
}

/* 768px↓ — 모바일 친화, 키워드 필드 풀너비 */
@media (max-width: 768px) {
    .adm-login-review-page .lrr-keyword-field,
    .adm-login-review-page .lrr-filter-field { flex: 1 1 100%; min-width: 0; }
    .adm-login-review-page .lrr-search-row { flex-wrap: wrap; }
    .adm-login-review-page .lrr-search-type { flex: 0 0 100%; }
    .adm-login-review-page .lrr-search-box { flex: 1 1 100%; }
    .adm-login-review-page .lrr-card-head { flex-direction: column; align-items: flex-start; }
    .adm-login-review-page .lrr-export-control { width: 100%; flex-wrap: wrap; }
    .adm-login-review-page .lrr-export-control .adm-export-dropdown { left: 0; right: auto; }
    .adm-login-review-page .lrr-bulkbar { gap: 8px; }
    .adm-login-review-page .lrr-bulk-clear { margin-left: 0; }
    .adm-login-review-page .lrr-page-search-field { flex-wrap: wrap; }
    .adm-login-review-page .lrr-page-search-col { flex: 0 0 100%; }
    .adm-login-review-page .lrr-page-search-box { flex: 1 1 100%; }
}

/* 520px↓ — 좁은 모바일, 행 액션 stack */
@media (max-width: 520px) {
    .adm-login-review-page .lrr-table { min-width: 720px; /* 가로 스크롤 허용 */ }
    .adm-login-review-page .lrr-row-actions { flex-direction: column; align-items: stretch; }
    .adm-login-review-page .lrr-row-actions .adm-btn-sm { width: 100%; }
    .adm-login-review-page .lrr-filter-actions { flex-direction: column; align-items: stretch; }
    .adm-login-review-page .lrr-filter-actions .adm-btn { width: 100%; }
    .adm-login-review-page .lrr-pagination { flex-direction: column; align-items: stretch; }
    .adm-login-review-page .lrr-page-actions { justify-content: center; }
}
</style>

<%@ include file="../layout-close.jsp" %>
