<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_emailRequests_searchPlaceholder" code="admin.emailRequests.searchPlaceholder"/>
<spring:message var="msg_admin_emailRequests_historyTitle" code="admin.emailRequests.historyTitle"/>
<spring:message var="msg_admin_emailRequests_pageTitle" code="admin.emailRequests.pageTitle"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_emailRequests_purpose" code="admin.emailRequests.purpose"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_emailRequests_purpose_profileEmail" code="admin.emailRequests.purpose.profileEmail"/>
<spring:message var="msg_admin_emailRequests_purpose_findId" code="admin.emailRequests.purpose.findId"/>
<spring:message var="msg_admin_emailRequests_purpose_resetPw" code="admin.emailRequests.purpose.resetPw"/>
<spring:message var="msg_admin_emailRequests_purpose_verify" code="admin.emailRequests.purpose.verify"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_emailRequests_status_requested" code="admin.emailRequests.status.requested"/>
<spring:message var="msg_admin_emailRequests_status_verified" code="admin.emailRequests.status.verified"/>
<spring:message var="msg_admin_emailRequests_status_applied" code="admin.emailRequests.status.applied"/>
<spring:message var="msg_admin_emailRequests_status_expired" code="admin.emailRequests.status.expired"/>
<spring:message var="msg_admin_emailRequests_status_cancelled" code="admin.emailRequests.status.cancelled"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${total}"/>
<spring:message var="msg_admin_common_export" code="admin.common.export"/>
<spring:message var="msg_admin_common_exportAll" code="admin.common.exportAll"/>
<spring:message var="msg_admin_common_exportFiltered" code="admin.common.exportFiltered"/>
<spring:message var="msg_admin_blocks_mode_label" code="admin.blocks.mode.label"/>
<spring:message var="msg_admin_blocks_mode_tipClient" code="admin.blocks.mode.tipClient"/>
<spring:message var="msg_admin_blocks_mode_tipServer" code="admin.blocks.mode.tipServer"/>
<spring:message var="msg_admin_blocks_mode_client" code="admin.blocks.mode.client"/>
<spring:message var="msg_admin_blocks_mode_server" code="admin.blocks.mode.server"/>
<spring:message var="msg_admin_blocks_js_dashSortReset_js" code="admin.blocks.js.dashSortReset" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_pageSizeLabel" code="admin.common.pageSizeLabel"/>
<spring:message var="msg_admin_common_pageSize_15" code="admin.common.pageSize" arguments="15"/>
<spring:message var="msg_admin_common_pageSize_30" code="admin.common.pageSize" arguments="30"/>
<spring:message var="msg_admin_common_pageSize_50" code="admin.common.pageSize" arguments="50"/>
<spring:message var="msg_admin_common_pageSize_100" code="admin.common.pageSize" arguments="100"/>
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_emailRequests_requestedAt" code="admin.emailRequests.requestedAt"/>
<spring:message var="msg_admin_common_member" code="admin.common.member"/>
<spring:message var="msg_admin_context_requestEmail" code="admin.context.requestEmail"/>
<spring:message var="msg_admin_emailRequests_verifiedAt" code="admin.emailRequests.verifiedAt"/>
<spring:message var="msg_admin_emailRequests_appliedAt" code="admin.emailRequests.appliedAt"/>
<spring:message var="msg_admin_context_expiresAt" code="admin.context.expiresAt"/>
<spring:message var="msg_admin_common_ip" code="admin.common.ip"/>
<spring:message var="msg_admin_context_requestId" code="admin.context.requestId"/>
<spring:message var="msg_admin_common_sameDate" code="admin.common.sameDate"/>
<spring:message var="msg_admin_emailRequests_unknownRequest" code="admin.emailRequests.unknownRequest"/>
<spring:message var="msg_admin_common_sameValue" code="admin.common.sameValue"/>
<spring:message var="msg_admin_common_sameEmail" code="admin.common.sameEmail"/>
<spring:message var="msg_admin_common_sameIp" code="admin.common.sameIp"/>
<spring:message var="msg_admin_common_trace" code="admin.common.trace"/>
<spring:message var="msg_admin_common_viewDetail" code="admin.common.viewDetail"/>
<spring:message var="msg_admin_common_noResults" code="admin.common.noResults"/>
<spring:message var="msg_admin_common_pageStatus" code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/>
<c:set var="activeMenu" value="emailVerifications"/>


<c:set var="pageTitle" value="${msg_admin_emailRequests_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card adm-email-filter-card">
        <div class="adm-card-body">
            <form id="emailRequestSearchForm" method="get" action="${pageContext.request.contextPath}/admin/email-verifications">
                <input type="hidden" name="page" value="${paging.currentPage}">
                <input type="hidden" name="size" value="${search.size}">
                <input type="hidden" name="mode" value="${search.mode}">
                <input type="hidden" name="sortField" value="${search.sortField}">
                <input type="hidden" name="sortDir" value="${search.sortDir}">
                <input type="hidden" name="dateFilter" value="${search.dateFilter}">
                <div class="adm-filter-bar">
                    <div class="adm-search-box adm-email-search-field">
                        <div class="adm-filter-label">${msg_admin_common_search}</div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${msg_admin_emailRequests_searchPlaceholder}">
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_emailRequests_purpose}</div>
                        <select class="adm-select" name="purpose">
                            <option value="ALL" ${search.purpose=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="PROFILE_EMAIL" ${search.purpose=='PROFILE_EMAIL'?'selected':''}>${msg_admin_emailRequests_purpose_profileEmail}</option>
                            <option value="FIND_ID" ${search.purpose=='FIND_ID'?'selected':''}>${msg_admin_emailRequests_purpose_findId}</option>
                            <option value="RESET_PW" ${search.purpose=='RESET_PW'?'selected':''}>${msg_admin_emailRequests_purpose_resetPw}</option>
                            <option value="VERIFY" ${search.purpose=='VERIFY'?'selected':''}>${msg_admin_emailRequests_purpose_verify}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_common_status}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="REQUESTED" ${search.status=='REQUESTED'?'selected':''}>${msg_admin_emailRequests_status_requested}</option>
                            <option value="VERIFIED" ${search.status=='VERIFIED'?'selected':''}>${msg_admin_emailRequests_status_verified}</option>
                            <option value="APPLIED" ${search.status=='APPLIED'?'selected':''}>${msg_admin_emailRequests_status_applied}</option>
                            <option value="EXPIRED" ${search.status=='EXPIRED'?'selected':''}>${msg_admin_emailRequests_status_expired}</option>
                            <option value="CANCELLED" ${search.status=='CANCELLED'?'selected':''}>${msg_admin_emailRequests_status_cancelled}</option>
                        </select>
                    </div>
                    <div class="adm-email-filter-actions">
                        <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_searchButton}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/email-verifications">${msg_admin_common_reset}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card js-email-request-section-card adm-managed-section-card adm-overflow-visible" data-section="emailVerificationRequests" data-enhanced="true">
        <div class="adm-card-head adm-email-list-head">
            <div class="adm-card-title">${msg_admin_emailRequests_historyTitle}</div>
            <div class="adm-email-export-control adm-export-control">
                <span id="emailTotalLabel" class="adm-email-total-label">${msg_admin_common_totalCount}</span>
                <select class="adm-select adm-email-export-format" id="emailExportFormat">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-email-export-toggle">${msg_admin_common_export} ▾</button>
                <div id="emailExportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="exportEmailRequests('all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="exportEmailRequests('search')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item" onclick="exportEmailRequests('page')">현재 화면 내보내기</button>
                    <button type="button" class="adm-export-item js-email-selected-export" onclick="exportEmailRequests('selected')" disabled>선택 내보내기 (0)</button>
                </div>
            </div>
        </div>

        <div class="adm-email-controlbar">
            <div class="adm-email-selection-bar" id="emailRequestSelectionBar" aria-live="polite">
                <span class="adm-email-selected-count" id="emailRequestSelectedCount">0건 선택</span>
                <button type="button" class="adm-btn adm-btn-ghost" onclick="clearEmailSelection()">선택 해제</button>
                <button type="button" class="adm-btn adm-btn-primary js-email-selected-export" onclick="exportEmailRequests('selected')" disabled>선택 내보내기</button>
            </div>
            <div class="adm-email-view-tools">
                <div id="emailPrimaryTools" class="adm-email-primary-tools">
                    <button type="button" class="adm-dash-sort-reset js-email-sort-reset adm-email-tool-item adm-email-sort-reset ${empty search.sortField ? 'adm-is-hidden' : ''}" onclick="resetEmailSort()"></button>
                    <label class="adm-email-tool-item adm-email-tool adm-email-mode-tool">
                        <span class="adm-email-tool-label">${msg_admin_blocks_mode_label}</span>
                        <select class="adm-select" id="emailModeSelect" title="${msg_admin_blocks_mode_label}" onchange="changeEmailMode(this.value)">
                            <option value="CLIENT" title="${msg_admin_blocks_mode_tipClient}" ${search.mode=='CLIENT' ? 'selected' : ''}>${msg_admin_blocks_mode_client}</option>
                            <option value="SERVER" title="${msg_admin_blocks_mode_tipServer}" ${search.mode!='CLIENT' ? 'selected' : ''}>${msg_admin_blocks_mode_server}</option>
                        </select>
                    </label>
                    <label class="adm-email-tool-item adm-email-tool adm-email-size-tool">
                        <span class="adm-email-tool-label">${msg_admin_common_pageSizeLabel}</span>
                        <select class="adm-select" id="emailSizeSelect" onchange="changeEmailSize(this.value)">
                            <option value="15"  ${search.size==15  ? 'selected' : ''}>${msg_admin_common_pageSize_15}</option>
                            <option value="30"  ${search.size==30  ? 'selected' : ''}>${msg_admin_common_pageSize_30}</option>
                            <option value="50"  ${search.size==50  ? 'selected' : ''}>${msg_admin_common_pageSize_50}</option>
                            <option value="100" ${search.size==100 ? 'selected' : ''}>${msg_admin_common_pageSize_100}</option>
                        </select>
                    </label>
                </div>
                <div class="adm-email-overflow-menu" id="emailOverflowMenu">
                    <button type="button" class="adm-btn adm-btn-ghost adm-email-overflow-toggle" aria-expanded="false" aria-controls="emailOverflowPanel">옵션 ▾</button>
                    <div id="emailOverflowPanel" class="adm-email-overflow-panel"></div>
                </div>
            </div>
        </div>

        <div class="adm-table-wrap adm-overflow-visible">
            <table id="emailVerificationRequestTable"
                   class="adm-table adm-section-table-fixed adm-email-request-table adm-email-section-table"
                   data-admin-list-ignore="hard"
                   data-section="emailVerificationRequests">
                <thead>
                <tr>
                    <th class="adm-email-check-cell">
                        <input type="checkbox" class="adm-check" id="emailRequestCheckAll" aria-label="현재 화면 전체 선택">
                    </th>
                    <th class="js-email-sort" data-sort="time" onclick="sortBy('time')">${msg_admin_emailRequests_requestedAt}</th>
                    <th class="js-email-sort" data-sort="member" onclick="sortBy('member')">${msg_admin_common_member}</th>
                    <th class="js-email-sort" data-sort="purpose" onclick="sortBy('purpose')">${msg_admin_emailRequests_purpose}</th>
                    <th class="js-email-sort" data-sort="requestEmail" onclick="sortBy('requestEmail')">${msg_admin_context_requestEmail}</th>
                    <th class="js-email-sort" data-sort="status" onclick="sortBy('status')">${msg_admin_common_status}</th>
                    <th class="js-email-sort" data-sort="verifiedAt" onclick="sortBy('verifiedAt')">${msg_admin_emailRequests_verifiedAt}</th>
                    <th class="js-email-sort" data-sort="appliedAt" onclick="sortBy('appliedAt')">${msg_admin_emailRequests_appliedAt}</th>
                    <th class="js-email-sort" data-sort="expiresAt" onclick="sortBy('expiresAt')">${msg_admin_context_expiresAt}</th>
                    <th class="js-email-sort" data-sort="ip" onclick="sortBy('ip')">${msg_admin_common_ip}</th>
                    <th class="js-email-sort" data-sort="requestId" onclick="sortBy('requestId')">${msg_admin_context_requestId}</th>
                    <th></th>
                </tr>
                </thead>
                <tbody id="emailRequestRowsBody">
                <c:forEach items="${list}" var="item" varStatus="st">
                    <fmt:formatDate var="itemDateFilter" value="${item.requestedAtDate}" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate var="itemTimeDisplay" value="${item.requestedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    <fmt:formatDate var="itemVerifiedAtDisplay" value="${item.verifiedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    <fmt:formatDate var="itemVerifiedAtFilter" value="${item.verifiedAtDate}" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate var="itemAppliedAtDisplay" value="${item.appliedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    <fmt:formatDate var="itemAppliedAtFilter" value="${item.appliedAtDate}" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate var="itemExpiredAtDisplay" value="${item.expiredAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    <fmt:formatDate var="itemExpiredAtFilter" value="${item.expiredAtDate}" pattern="yyyy-MM-dd"/>
                    <tr class="js-email-row"
                        data-row-id="${item.emailVerificationRequestIdx}"
                        data-requested-at="${item.requestedAt}"
                        data-member="${fn:escapeXml(item.nickname)} ${fn:escapeXml(item.userId)}"
                        data-purpose="${fn:escapeXml(item.purpose)}"
                        data-request-email="${fn:escapeXml(item.pendingEmail)}"
                        data-status="${fn:escapeXml(item.status)}"
                        data-verified-at="${item.verifiedAt}"
                        data-applied-at="${item.appliedAt}"
                        data-expires-at="${item.expiredAt}"
                        data-ip="${fn:escapeXml(item.ipAddress)}"
                        data-request-id="${fn:escapeXml(item.requestId)}"
                        data-original-index="${st.index}">
                        <td class="adm-email-check-cell">
                            <input type="checkbox" class="adm-check js-email-row-check" value="${item.emailVerificationRequestIdx}" aria-label="행 선택">
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link"
                                    data-date="${itemDateFilter}"
                                    onclick="filterByDate(this.dataset.date)">
                                <span>${itemTimeDisplay}</span>
                                <span class="adm-cell-link-note">${msg_admin_common_sameDate}</span>
                            </button>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.userIdx}">
                                    <button type="button"
                                            class="adm-inline-link js-open-member-context adm-email-member-link"
                                            data-user-idx="${item.userIdx}"
                                            data-default-tab="emailRequests"><c:out value="${item.nickname}"/></button>
                                    <div class="mem-uid">
                                        <button type="button"
                                                class="adm-inline-link js-open-member-context adm-email-muted-link"
                                                data-user-idx="${item.userIdx}"
                                                data-default-tab="emailRequests">@${item.userId}</button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="mem-name">${msg_admin_emailRequests_unknownRequest}</div>
                                    <div class="mem-uid">-</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="purpose" data-param-value="${item.purpose}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${item.purpose == 'PROFILE_EMAIL'}">${msg_admin_emailRequests_purpose_profileEmail}</c:when>
                                    <c:when test="${item.purpose == 'FIND_ID'}">${msg_admin_emailRequests_purpose_findId}</c:when>
                                    <c:when test="${item.purpose == 'RESET_PW'}">${msg_admin_emailRequests_purpose_resetPw}</c:when>
                                    <c:when test="${item.purpose == 'VERIFY'}">${msg_admin_emailRequests_purpose_verify}</c:when>
                                    <c:otherwise><c:out value="${item.purpose}"/></c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-keyword="${item.pendingEmail}" onclick="applyKeywordFilter(this)">
                                <span><c:out value="${item.pendingEmail}"/></span>
                                <span class="adm-cell-link-note">${msg_admin_common_sameEmail}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="status" data-param-value="${item.status}" onclick="applySelectFilter(this)">
                                <span class="status-badge ${item.status}">
                                    <c:choose>
                                        <c:when test="${item.status == 'REQUESTED'}">${msg_admin_emailRequests_status_requested}</c:when>
                                        <c:when test="${item.status == 'VERIFIED'}">${msg_admin_emailRequests_status_verified}</c:when>
                                        <c:when test="${item.status == 'APPLIED'}">${msg_admin_emailRequests_status_applied}</c:when>
                                        <c:when test="${item.status == 'EXPIRED'}">${msg_admin_emailRequests_status_expired}</c:when>
                                        <c:when test="${item.status == 'CANCELLED'}">${msg_admin_emailRequests_status_cancelled}</c:when>
                                        <c:otherwise><c:out value="${item.status}"/></c:otherwise>
                                    </c:choose>
                                </span>
                            </button>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.verifiedAtDate}">
                                    <button type="button" class="adm-cell-link"
                                            data-date="${itemVerifiedAtFilter}"
                                            onclick="filterByDate(this.dataset.date)">
                                        <span>${itemVerifiedAtDisplay}</span>
                                        <span class="adm-cell-link-note">${msg_admin_common_sameDate}</span>
                                    </button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.appliedAtDate}">
                                    <button type="button" class="adm-cell-link"
                                            data-date="${itemAppliedAtFilter}"
                                            onclick="filterByDate(this.dataset.date)">
                                        <span>${itemAppliedAtDisplay}</span>
                                        <span class="adm-cell-link-note">${msg_admin_common_sameDate}</span>
                                    </button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.expiredAtDate}">
                                    <button type="button" class="adm-cell-link"
                                            data-date="${itemExpiredAtFilter}"
                                            onclick="filterByDate(this.dataset.date)">
                                        <span>${itemExpiredAtDisplay}</span>
                                        <span class="adm-cell-link-note">${msg_admin_common_sameDate}</span>
                                    </button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.ipAddress}">
                                    <button type="button"
                                            class="adm-cell-link js-open-ip-context"
                                            data-ip-address="${item.ipAddress}"
                                            data-default-tab="emailRequests">
                                        <span class="adm-email-ip-text"><c:out value="${item.ipAddress}"/></span>
                                        <span class="adm-cell-link-note">${msg_admin_common_sameIp}</span>
                                    </button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link"
                                    data-keyword="${empty item.flowTraceId ? item.requestId : item.flowTraceId}"
                                    onclick="openRelatedHistory('email-tokens', this)">
                                <span class="adm-email-request-id"><c:out value="${item.requestId}"/></span>
                                <c:if test="${not empty item.flowTraceId}">
                                    <span class="adm-cell-link-note">${msg_admin_common_trace}: <c:out value="${item.flowTraceId}"/></span>
                                </c:if>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-row-btn detail"
                                    data-time="${itemTimeDisplay}"
                                    data-user="${fn:escapeXml(item.nickname)} (@${fn:escapeXml(item.userId)})"
                                    data-purpose="${fn:escapeXml(item.purpose)}"
                                    data-email="${fn:escapeXml(item.pendingEmail)}"
                                    data-status="${fn:escapeXml(item.status)}"
                                    data-verified-at="${itemVerifiedAtDisplay}"
                                    data-applied-at="${itemAppliedAtDisplay}"
                                    data-expires-at="${itemExpiredAtDisplay}"
                                    data-ip="${fn:escapeXml(item.ipAddress)}"
                                    data-request-id="${fn:escapeXml(item.requestId)}"
                                    data-flow-trace="${fn:escapeXml(item.flowTraceId)}"
                                    onclick="openVerificationDetail(this)">
                                ${msg_admin_common_viewDetail}
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr class="adm-local-empty"><td colspan="12" class="adm-local-empty-cell">${msg_admin_common_noResults}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <div class="adm-local-pagination adm-email-pagination" data-section="emailVerificationRequests" id="emailRequestPaging">
            <div class="adm-local-page-info js-email-page-info" data-section="emailVerificationRequests">총 ${total}건 / 현재 ${fn:length(list)}건</div>
            <div class="adm-local-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost js-email-prev" onclick="goEmailPage(emailRequestState.page - 1)">${msg_admin_common_prev}</button>
                <span class="js-email-page-state" data-section="emailVerificationRequests">${paging.currentPage} / ${paging.totalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost js-email-next" onclick="goEmailPage(emailRequestState.page + 1)">${msg_admin_common_next}</button>
            </div>
        </div>
    </div>
</div>

<div id="rowDetailModal" class="adm-modal-overlay" onclick="this.classList.remove('open')">
    <div class="adm-modal adm-row-detail-modal" onclick="event.stopPropagation()">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="rowDetailModalTitle"></div>
            <button class="adm-modal-close" onclick="document.getElementById('rowDetailModal').classList.remove('open')">✕</button>
        </div>
        <div class="adm-modal-body adm-row-detail-body">
            <dl id="rowDetailModalContent" class="adm-row-detail-list"></dl>
        </div>
    </div>
</div>

<script>
var BASE_URL = '${pageContext.request.contextPath}/admin/email-verifications';
var EMAIL_MSG = {
    sortReset: '${msg_admin_blocks_js_dashSortReset_js}',
    noResults: '${msg_admin_common_noResults}'
};
var emailRequestState = {
    mode: '${search.mode}' === 'CLIENT' ? 'CLIENT' : 'SERVER',
    page: Number('${paging.currentPage}' || 1) || 1,
    pageSize: Number('${search.size}' || 30) || 30,
    sortField: '${fn:escapeXml(search.sortField)}',
    sortDir: '${fn:escapeXml(search.sortDir)}' || 'DESC'
};

function getEmailForm() { return document.getElementById('emailRequestSearchForm'); }
function getEmailTbody() { return document.getElementById('emailRequestRowsBody'); }
function emailRows() { return Array.from(document.querySelectorAll('#emailRequestRowsBody .js-email-row')); }
function emailVisibleRows() {
    return emailRows().filter(function(row) { return !row.classList.contains('adm-is-hidden'); });
}
function emailSelectedRows() {
    return emailRows().filter(function(row) {
        var check = row.querySelector('.js-email-row-check');
        return check && check.checked;
    });
}
function updateEmailSelection() {
    var selected = emailSelectedRows();
    var visible = emailVisibleRows();
    var visibleChecks = visible.map(function(row) { return row.querySelector('.js-email-row-check'); }).filter(Boolean);
    var checkAll = document.getElementById('emailRequestCheckAll');
    if (checkAll) {
        checkAll.checked = visibleChecks.length > 0 && visibleChecks.every(function(check) { return check.checked; });
        checkAll.indeterminate = visibleChecks.some(function(check) { return check.checked; }) && !checkAll.checked;
    }
    var countText = selected.length + '건 선택';
    var count = document.getElementById('emailRequestSelectedCount');
    if (count) count.textContent = countText;
    var bar = document.getElementById('emailRequestSelectionBar');
    if (bar) bar.classList.toggle('is-active', selected.length > 0);
    document.querySelectorAll('.js-email-selected-export').forEach(function(button) {
        button.disabled = selected.length === 0;
        if (button.classList.contains('adm-export-item')) {
            button.textContent = '선택 내보내기 (' + selected.length + ')';
        }
    });
}
function clearEmailSelection() {
    emailRows().forEach(function(row) {
        var check = row.querySelector('.js-email-row-check');
        if (check) check.checked = false;
    });
    updateEmailSelection();
}
function toggleEmailVisibleSelection(checked) {
    emailVisibleRows().forEach(function(row) {
        var check = row.querySelector('.js-email-row-check');
        if (check) check.checked = checked;
    });
    updateEmailSelection();
}
function syncEmailHiddenInputs() {
    var form = getEmailForm();
    if (!form) return;
    var page = form.querySelector('[name=page]');
    var size = form.querySelector('[name=size]');
    var mode = form.querySelector('[name=mode]');
    var sortField = form.querySelector('[name=sortField]');
    var sortDir = form.querySelector('[name=sortDir]');
    if (page) page.value = emailRequestState.page;
    if (size) size.value = emailRequestState.pageSize;
    if (mode) mode.value = emailRequestState.mode;
    if (sortField) sortField.value = emailRequestState.sortField || '';
    if (sortDir) sortDir.value = emailRequestState.sortDir || 'DESC';
}
function buildEmailParams(pageOverride) {
    var form = getEmailForm();
    var params = new URLSearchParams(form ? new FormData(form) : window.location.search);
    params.set('page', String(pageOverride || emailRequestState.page || 1));
    params.set('size', String(emailRequestState.pageSize || 30));
    params.set('mode', emailRequestState.mode || 'SERVER');
    if (emailRequestState.sortField) {
        params.set('sortField', emailRequestState.sortField);
        params.set('sortDir', emailRequestState.sortDir || 'DESC');
    } else {
        params.delete('sortField');
        params.delete('sortDir');
    }
    return params;
}
function replaceEmailUrl() {
    var params = buildEmailParams(emailRequestState.page);
    window.history.replaceState(null, '', BASE_URL + '?' + params.toString());
}
function navigateEmail(pageOverride) {
    syncEmailHiddenInputs();
    var params = buildEmailParams(pageOverride || emailRequestState.page || 1);
    location.href = BASE_URL + '?' + params.toString();
}
function updateEmailSortIndicators() {
    document.querySelectorAll('.js-email-sort').forEach(function(th) {
        th.classList.remove('sorted');
        var old = th.querySelector('.sort-ico');
        if (old) old.remove();
        if (emailRequestState.sortField && th.dataset.sort === emailRequestState.sortField) {
            th.classList.add('sorted');
            var asc = emailRequestState.sortDir === 'ASC';
            var ico = document.createElement('span');
            ico.className = 'sort-ico ' + (asc ? 'asc' : 'desc');
            ico.textContent = asc ? '▲' : '▼';
            th.appendChild(ico);
        }
    });
    var reset = document.querySelector('.js-email-sort-reset');
    if (reset) {
        reset.textContent = EMAIL_MSG.sortReset || '↺ 초기화';
        reset.classList.toggle('adm-is-hidden', !emailRequestState.sortField);
    }
    syncEmailHiddenInputs();
    syncEmailControlOverflow();
}
function updateEmailPaginationMeta(page, pages, total, current) {
    var safePage = Math.max(1, Number(page || 1));
    var safePages = Math.max(1, Number(pages || 1));
    emailRequestState.page = Math.min(safePage, safePages);
    var info = document.querySelector('.js-email-page-info');
    if (info) info.textContent = '총 ' + Number(total || 0) + '건 / 현재 ' + Number(current || 0) + '건';
    var label = document.getElementById('emailTotalLabel');
    if (label) label.textContent = '총 ' + Number(total || 0) + '건';
    var state = document.querySelector('.js-email-page-state');
    if (state) state.textContent = emailRequestState.page + ' / ' + safePages;
    var prev = document.querySelector('.js-email-prev');
    var next = document.querySelector('.js-email-next');
    if (prev) prev.disabled = emailRequestState.page <= 1;
    if (next) next.disabled = emailRequestState.page >= safePages;
    syncEmailHiddenInputs();
}
function emailSortValue(row, field) {
    if (!row || !field) return '';
    if (field === 'time') return row.dataset.requestedAt || '';
    if (field === 'member') return row.dataset.member || '';
    if (field === 'purpose') return row.dataset.purpose || '';
    if (field === 'requestEmail') return row.dataset.requestEmail || '';
    if (field === 'status') return row.dataset.status || '';
    if (field === 'verifiedAt') return row.dataset.verifiedAt || '';
    if (field === 'appliedAt') return row.dataset.appliedAt || '';
    if (field === 'expiresAt') return row.dataset.expiresAt || '';
    if (field === 'ip') return row.dataset.ip || '';
    return row.dataset.requestId || '';
}
function compareEmailRows(a, b) {
    var field = emailRequestState.sortField;
    if (!field) return Number(a.dataset.originalIndex || 0) - Number(b.dataset.originalIndex || 0);
    var av = emailSortValue(a, field);
    var bv = emailSortValue(b, field);
    var cmp = String(av).localeCompare(String(bv), undefined, {numeric:true, sensitivity:'base'});
    return cmp * (emailRequestState.sortDir === 'DESC' ? -1 : 1);
}
function renderEmailClientPage(pageOverride) {
    var tbody = getEmailTbody();
    if (!tbody) return;
    var rows = emailRows();
    if (!rows.length) {
        updateEmailPaginationMeta(1, 1, 0, 0);
        return;
    }
    rows.sort(compareEmailRows).forEach(function(row) { tbody.appendChild(row); });
    var pageSize = Number(emailRequestState.pageSize || 30);
    var total = rows.length;
    var pages = Math.max(1, Math.ceil(total / pageSize));
    var page = Math.min(Math.max(1, Number(pageOverride || emailRequestState.page || 1)), pages);
    var start = (page - 1) * pageSize;
    rows.forEach(function(row, idx) {
        row.classList.toggle('adm-is-hidden', idx < start || idx >= start + pageSize);
    });
    updateEmailPaginationMeta(page, pages, total, Math.min(pageSize, Math.max(0, total - start)));
    updateEmailSortIndicators();
    updateEmailSelection();
    replaceEmailUrl();
}

function sortBy(field) {
    emailRequestState.sortDir = (emailRequestState.sortField === field && emailRequestState.sortDir !== 'ASC') ? 'ASC' : 'DESC';
    emailRequestState.sortField = field;
    emailRequestState.page = 1;
    if (emailRequestState.mode === 'CLIENT') {
        renderEmailClientPage(1);
    } else {
        navigateEmail(1);
    }
}
function resetEmailSort() {
    emailRequestState.sortField = '';
    emailRequestState.sortDir = 'DESC';
    emailRequestState.page = 1;
    if (emailRequestState.mode === 'CLIENT') {
        renderEmailClientPage(1);
    } else {
        navigateEmail(1);
    }
}
function changeEmailMode(value) {
    emailRequestState.mode = value === 'CLIENT' ? 'CLIENT' : 'SERVER';
    emailRequestState.page = 1;
    localStorage.setItem('admin.emailRequests.mode', emailRequestState.mode);
    navigateEmail(1);
}
function changeEmailSize(value) {
    emailRequestState.pageSize = Number(value || 30) || 30;
    emailRequestState.page = 1;
    if (emailRequestState.mode === 'CLIENT') {
        renderEmailClientPage(1);
    } else {
        navigateEmail(1);
    }
}
function filterByDate(dateStr) {
    var params = new URLSearchParams(window.location.search);
    params.set('dateFilter', dateStr); params.set('page', '1'); params.set('size', emailRequestState.pageSize); params.set('mode', emailRequestState.mode);
    location.href = BASE_URL + '?' + params.toString();
}
function applyKeywordFilter(button) {
    var keyword = button.getAttribute('data-keyword');
    if (!keyword) return;
    var params = new URLSearchParams(window.location.search);
    params.set('keyword', keyword); params.set('page', '1'); params.set('size', emailRequestState.pageSize); params.set('mode', emailRequestState.mode);
    location.href = BASE_URL + '?' + params.toString();
}
function applySelectFilter(button) {
    var paramName = button.getAttribute('data-param-name');
    var paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    var params = new URLSearchParams(window.location.search);
    params.set(paramName, paramValue); params.set('page', '1'); params.set('size', emailRequestState.pageSize); params.set('mode', emailRequestState.mode);
    location.href = BASE_URL + '?' + params.toString();
}
function goEmailPage(page) {
    if (emailRequestState.mode === 'CLIENT') {
        renderEmailClientPage(page);
    } else {
        navigateEmail(page);
    }
}
function openRelatedHistory(path, button) {
    var params = new URLSearchParams();
    if (button.dataset.keyword) params.set('keyword', button.dataset.keyword);
    params.set('page', '1');
    location.href = '${pageContext.request.contextPath}/admin/' + path + '?' + params.toString();
}
function exportEmailRequests(scope) {
    if (scope === 'selected') {
        exportSelectedEmailRequests();
        return;
    }
    var format = document.getElementById('emailExportFormat').value;
    var params = buildEmailParams(emailRequestState.page);
    params.set('scope', scope);
    params.set('format', format);
    if (scope !== 'page') params.delete('page');
    var dropdown = document.getElementById('emailExportDropdown');
    if (dropdown) dropdown.classList.remove('open');
    window.location.href = BASE_URL + '/export?' + params.toString();
}
function emailCleanExportText(cell) {
    var clone = cell.cloneNode(true);
    clone.querySelectorAll('.adm-cell-link-note, input, .adm-row-btn').forEach(function(node) { node.remove(); });
    return (clone.textContent || '').replace(/\s+/g, ' ').trim();
}
function emailCsvEscape(value) {
    return '"' + String(value == null ? '' : value).replace(/"/g, '""') + '"';
}
function emailXmlEscape(value) {
    return String(value == null ? '' : value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
}
function downloadEmailExport(content, filename, type) {
    var blob = new Blob([content], { type: type });
    var url = URL.createObjectURL(blob);
    var link = document.createElement('a');
    link.href = url;
    link.download = filename;
    document.body.appendChild(link);
    link.click();
    link.remove();
    setTimeout(function() { URL.revokeObjectURL(url); }, 1000);
}
function exportSelectedEmailRequests() {
    var selected = emailSelectedRows();
    if (!selected.length) {
        if (window.adm_toast) adm_toast('선택된 항목이 없습니다.', 'error');
        else alert('선택된 항목이 없습니다.');
        return;
    }
    var table = document.getElementById('emailVerificationRequestTable');
    var headers = Array.from(table.querySelectorAll('thead th')).slice(1, -1)
        .map(function(th) { return (th.textContent || '').replace(/[▲▼]/g, '').replace(/\s+/g, ' ').trim(); });
    var rows = selected.map(function(row) {
        return Array.from(row.children).slice(1, -1).map(emailCleanExportText);
    });
    var format = document.getElementById('emailExportFormat').value;
    if (format === 'excel') {
        var xmlRows = [headers].concat(rows).map(function(row, index) {
            return '<Row>' + row.map(function(value) {
                var style = index === 0 ? ' ss:StyleID="header"' : '';
                return '<Cell' + style + '><Data ss:Type="String">' + emailXmlEscape(value) + '</Data></Cell>';
            }).join('') + '</Row>';
        }).join('');
        var xls = '<?xml version="1.0" encoding="UTF-8"?><?mso-application progid="Excel.Sheet"?>'
            + '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">'
            + '<Styles><Style ss:ID="header"><Font ss:Bold="1"/><Interior ss:Color="#D9EAF7" ss:Pattern="Solid"/></Style></Styles>'
            + '<Worksheet ss:Name="selected_requests"><Table>' + xmlRows + '</Table></Worksheet></Workbook>';
        downloadEmailExport('\ufeff' + xls, 'email-verification-requests-selected.xls', 'application/vnd.ms-excel;charset=utf-8');
    } else {
        var csv = [headers].concat(rows).map(function(row) { return row.map(emailCsvEscape).join(','); }).join('\n');
        downloadEmailExport('\ufeff' + csv, 'email-verification-requests-selected.csv', 'text/csv;charset=utf-8');
    }
    var dropdown = document.getElementById('emailExportDropdown');
    if (dropdown) dropdown.classList.remove('open');
}
function openVerificationDetail(btn) {
    var d = btn.dataset;
    showRowDetail('${msg_admin_emailRequests_historyTitle}', [
        ['요청 시각', d.time],
        ['회원', d.user],
        ['목적', d.purpose],
        ['요청 이메일', d.email],
        ['상태', d.status],
        ['인증 시각', d.verifiedAt],
        ['반영 시각', d.appliedAt],
        ['만료 시각', d.expiresAt],
        ['IP', d.ip],
        ['요청 ID', d.requestId],
        ['흐름 추적 ID', d.flowTrace]
    ]);
}
function showRowDetail(title, fields) {
    var modal = document.getElementById('rowDetailModal');
    document.getElementById('rowDetailModalTitle').textContent = title;
    var content = document.getElementById('rowDetailModalContent');
    content.innerHTML = '';
    fields.forEach(function(pair) {
        var label = pair[0], value = pair[1];
        if (!value || value === '' || value === '-') return;
        var dt = document.createElement('dt');
        dt.className = 'adm-row-detail-label';
        dt.textContent = label;
        var dd = document.createElement('dd');
        dd.className = 'adm-row-detail-value';
        dd.textContent = value;
        content.appendChild(dt);
        content.appendChild(dd);
    });
    modal.classList.add('open');
}
let emailControlOverflowSync = null;
function isVisibleEmailTool(tool) {
    if (!tool) return false;
    return !tool.classList.contains('js-email-sort-reset') || !tool.classList.contains('adm-is-hidden');
}
function syncEmailControlOverflow() {
    if (typeof emailControlOverflowSync === 'function') emailControlOverflowSync();
}
function initEmailControlOverflow() {
    var primary = document.getElementById('emailPrimaryTools');
    var menu = document.getElementById('emailOverflowMenu');
    var panel = document.getElementById('emailOverflowPanel');
    var toggle = menu ? menu.querySelector('.adm-email-overflow-toggle') : null;
    if (!primary || !menu || !panel || !toggle) return;
    var tools = [
        { node: document.querySelector('.adm-email-sort-reset'), breakpoint: 1380 },
        { node: document.querySelector('.adm-email-mode-tool'), breakpoint: 1180 },
        { node: document.querySelector('.adm-email-size-tool'), breakpoint: 980 }
    ].filter(function(item) { return !!item.node; });
    emailControlOverflowSync = function() {
        var width = window.innerWidth || document.documentElement.clientWidth || 1600;
        tools.forEach(function(item) {
            var target = width <= item.breakpoint ? panel : primary;
            if (item.node.parentElement !== target) target.appendChild(item.node);
        });
        var hasItems = Array.from(panel.children).some(isVisibleEmailTool);
        menu.classList.toggle('has-items', hasItems);
        if (!hasItems) {
            menu.classList.remove('open');
            toggle.setAttribute('aria-expanded', 'false');
        }
    };
    toggle.addEventListener('click', function() {
        var willOpen = !menu.classList.contains('open');
        menu.classList.toggle('open', willOpen);
        toggle.setAttribute('aria-expanded', willOpen ? 'true' : 'false');
    });
    document.addEventListener('click', function(e) {
        if (!menu.contains(e.target)) {
            menu.classList.remove('open');
            toggle.setAttribute('aria-expanded', 'false');
        }
    });
    window.addEventListener('resize', syncEmailControlOverflow, { passive: true });
    syncEmailControlOverflow();
}
function initEmailRequestSection() {
    var storedMode = localStorage.getItem('admin.emailRequests.mode');
    if (!new URLSearchParams(window.location.search).has('mode') && storedMode && storedMode !== emailRequestState.mode) {
        emailRequestState.mode = storedMode === 'CLIENT' ? 'CLIENT' : 'SERVER';
        navigateEmail(1);
        return;
    }
    var modeSelect = document.getElementById('emailModeSelect');
    if (modeSelect) modeSelect.value = emailRequestState.mode;
    var form = getEmailForm();
    if (form) form.addEventListener('submit', function() { emailRequestState.page = 1; syncEmailHiddenInputs(); });
    var checkAll = document.getElementById('emailRequestCheckAll');
    if (checkAll) checkAll.addEventListener('change', function() { toggleEmailVisibleSelection(checkAll.checked); });
    emailRows().forEach(function(row) {
        var check = row.querySelector('.js-email-row-check');
        if (check) check.addEventListener('change', updateEmailSelection);
    });
    var exportToggle = document.querySelector('.js-email-export-toggle');
    var exportDropdown = document.getElementById('emailExportDropdown');
    if (exportToggle && exportDropdown) {
        exportToggle.addEventListener('click', function() { exportDropdown.classList.toggle('open'); });
        document.addEventListener('click', function(e) {
            if (!exportToggle.contains(e.target) && !exportDropdown.contains(e.target)) exportDropdown.classList.remove('open');
        });
    }
    initEmailControlOverflow();
    if (emailRequestState.mode === 'CLIENT') {
        renderEmailClientPage(emailRequestState.page);
    } else {
        updateEmailSortIndicators();
        updateEmailPaginationMeta(emailRequestState.page, Number('${paging.totalPage}' || 1), Number('${total}' || 0), emailRows().length);
        updateEmailSelection();
    }
}
document.addEventListener('DOMContentLoaded', initEmailRequestSection);
</script>
<%@ include file="../layout-close.jsp" %>
