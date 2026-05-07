<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_emailTokens_searchPlaceholder" code="admin.emailTokens.searchPlaceholder"/>
<spring:message var="msg_admin_emailTokens_historyTitle" code="admin.emailTokens.historyTitle"/>
<spring:message var="msg_admin_emailTokens_pageTitle" code="admin.emailTokens.pageTitle"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_emailRequests_purpose" code="admin.emailRequests.purpose"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_emailRequests_purpose_profileEmail" code="admin.emailRequests.purpose.profileEmail"/>
<spring:message var="msg_admin_emailRequests_purpose_findId" code="admin.emailRequests.purpose.findId"/>
<spring:message var="msg_admin_emailRequests_purpose_resetPw" code="admin.emailRequests.purpose.resetPw"/>
<spring:message var="msg_admin_emailRequests_purpose_verify" code="admin.emailRequests.purpose.verify"/>
<spring:message var="msg_admin_emailTokens_used" code="admin.emailTokens.used"/>
<spring:message var="msg_admin_context_used" code="admin.context.used"/>
<spring:message var="msg_admin_context_unused" code="admin.context.unused"/>
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
<spring:message var="msg_admin_emailTokens_createdAt" code="admin.emailTokens.createdAt"/>
<spring:message var="msg_admin_common_member" code="admin.common.member"/>
<spring:message var="msg_admin_context_targetEmail" code="admin.context.targetEmail"/>
<spring:message var="msg_admin_emailTokens_usedAt" code="admin.emailTokens.usedAt"/>
<spring:message var="msg_admin_context_expiresAt" code="admin.context.expiresAt"/>
<spring:message var="msg_admin_context_requestId" code="admin.context.requestId"/>
<spring:message var="msg_admin_common_sameDate" code="admin.common.sameDate"/>
<spring:message var="msg_admin_emailRequests_unknownRequest" code="admin.emailRequests.unknownRequest"/>
<spring:message var="msg_admin_common_sameValue" code="admin.common.sameValue"/>
<spring:message var="msg_admin_common_sameEmail" code="admin.common.sameEmail"/>
<spring:message var="msg_admin_common_trace" code="admin.common.trace"/>
<spring:message var="msg_admin_common_viewDetail" code="admin.common.viewDetail"/>
<spring:message var="msg_admin_common_noResults" code="admin.common.noResults"/>
<spring:message var="msg_admin_common_pageStatus" code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/>
<c:set var="activeMenu" value="emailTokens"/>


<c:set var="pageTitle" value="${msg_admin_emailTokens_pageTitle}"/>
<%@ include file="../layout.jsp" %>
<div class="adm-content">
  <div class="adm-card adm-email-filter-card">
    <div class="adm-card-body">
      <form id="emailTokenSearchForm" method="get" action="${pageContext.request.contextPath}/admin/email-tokens">
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
            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${msg_admin_emailTokens_searchPlaceholder}">
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
            <div class="adm-filter-label">${msg_admin_emailTokens_used}</div>
            <select class="adm-select" name="used">
              <option value="ALL" ${search.used=='ALL'?'selected':''}>${msg_admin_common_all}</option>
              <option value="USED" ${search.used=='USED'?'selected':''}>${msg_admin_context_used}</option>
              <option value="UNUSED" ${search.used=='UNUSED'?'selected':''}>${msg_admin_context_unused}</option>
            </select>
          </div>
          <div class="adm-email-filter-actions">
            <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_searchButton}</button>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/email-tokens">${msg_admin_common_reset}</a>
          </div>
        </div>
      </form>
    </div>
  </div>
  <div class="adm-card js-email-token-section-card adm-managed-section-card adm-overflow-visible" data-section="emailVerificationTokens" data-enhanced="true">
    <div class="adm-card-head adm-email-list-head">
      <div class="adm-card-title">${msg_admin_emailTokens_historyTitle}</div>
      <div class="adm-email-export-control adm-export-control">
        <span id="emailTokenTotalLabel" class="adm-email-total-label">${msg_admin_common_totalCount}</span>
        <select class="adm-select adm-email-export-format" id="emailTokenExportFormat">
          <option value="csv">CSV</option>
          <option value="excel">Excel</option>
        </select>
        <button type="button" class="adm-btn adm-btn-ghost js-email-token-export-toggle">${msg_admin_common_export} ▾</button>
        <div id="emailTokenExportDropdown" class="adm-export-dropdown">
          <button type="button" class="adm-export-item" onclick="exportEmailTokens('all')">${msg_admin_common_exportAll}</button>
          <button type="button" class="adm-export-item" onclick="exportEmailTokens('search')">${msg_admin_common_exportFiltered}</button>
          <button type="button" class="adm-export-item" onclick="exportEmailTokens('page')">현재 화면 내보내기</button>
          <button type="button" class="adm-export-item js-email-token-selected-export" onclick="exportEmailTokens('selected')" disabled>선택 내보내기 (0)</button>
        </div>
      </div>
    </div>

    <div class="adm-email-controlbar">
      <div class="adm-email-selection-bar" id="emailTokenSelectionBar" aria-live="polite">
        <span class="adm-email-selected-count" id="emailTokenSelectedCount">0건 선택</span>
        <button type="button" class="adm-btn adm-btn-ghost" onclick="clearEmailTokenSelection()">선택 해제</button>
        <button type="button" class="adm-btn adm-btn-primary js-email-token-selected-export" onclick="exportEmailTokens('selected')" disabled>선택 내보내기</button>
      </div>
      <div class="adm-email-view-tools">
        <div id="emailTokenPrimaryTools" class="adm-email-primary-tools">
          <button type="button" class="adm-dash-sort-reset js-email-token-sort-reset adm-email-tool-item adm-email-sort-reset ${empty search.sortField ? 'adm-is-hidden' : ''}" onclick="resetEmailTokenSort()"></button>
          <label class="adm-email-tool-item adm-email-tool adm-email-mode-tool">
            <span class="adm-email-tool-label">${msg_admin_blocks_mode_label}</span>
            <select class="adm-select" id="emailTokenModeSelect" title="${msg_admin_blocks_mode_label}" onchange="changeEmailTokenMode(this.value)">
              <option value="CLIENT" title="${msg_admin_blocks_mode_tipClient}" ${search.mode=='CLIENT' ? 'selected' : ''}>${msg_admin_blocks_mode_client}</option>
              <option value="SERVER" title="${msg_admin_blocks_mode_tipServer}" ${search.mode!='CLIENT' ? 'selected' : ''}>${msg_admin_blocks_mode_server}</option>
            </select>
          </label>
          <label class="adm-email-tool-item adm-email-tool adm-email-size-tool">
            <span class="adm-email-tool-label">${msg_admin_common_pageSizeLabel}</span>
            <select class="adm-select" id="emailTokenSizeSelect" onchange="changeEmailTokenSize(this.value)">
              <option value="15"  ${search.size==15  ? 'selected' : ''}>${msg_admin_common_pageSize_15}</option>
              <option value="30"  ${search.size==30  ? 'selected' : ''}>${msg_admin_common_pageSize_30}</option>
              <option value="50"  ${search.size==50  ? 'selected' : ''}>${msg_admin_common_pageSize_50}</option>
              <option value="100" ${search.size==100 ? 'selected' : ''}>${msg_admin_common_pageSize_100}</option>
            </select>
          </label>
        </div>
        <div class="adm-email-overflow-menu" id="emailTokenOverflowMenu">
          <button type="button" class="adm-btn adm-btn-ghost adm-email-overflow-toggle" aria-expanded="false" aria-controls="emailTokenOverflowPanel">옵션 ▾</button>
          <div id="emailTokenOverflowPanel" class="adm-email-overflow-panel"></div>
        </div>
      </div>
    </div>

    <div class="adm-table-wrap adm-overflow-visible">
      <table id="emailVerificationTokenTable"
             class="adm-table adm-section-table-fixed adm-email-token-table adm-email-section-table"
             data-admin-list-ignore="hard"
             data-section="emailVerificationTokens">
        <thead><tr>
          <th class="adm-email-check-cell">
            <input type="checkbox" class="adm-check" id="emailTokenCheckAll" aria-label="현재 화면 전체 선택">
          </th>
          <th class="js-email-token-sort" data-sort="time" onclick="sortBy('time')">${msg_admin_emailTokens_createdAt}</th>
          <th class="js-email-token-sort" data-sort="member" onclick="sortBy('member')">${msg_admin_common_member}</th>
          <th class="js-email-token-sort" data-sort="purpose" onclick="sortBy('purpose')">${msg_admin_emailRequests_purpose}</th>
          <th class="js-email-token-sort" data-sort="targetEmail" onclick="sortBy('targetEmail')">${msg_admin_context_targetEmail}</th>
          <th class="js-email-token-sort" data-sort="used" onclick="sortBy('used')">${msg_admin_emailTokens_used}</th>
          <th class="js-email-token-sort" data-sort="usedAt" onclick="sortBy('usedAt')">${msg_admin_emailTokens_usedAt}</th>
          <th class="js-email-token-sort" data-sort="expiresAt" onclick="sortBy('expiresAt')">${msg_admin_context_expiresAt}</th>
          <th class="js-email-token-sort" data-sort="requestId" onclick="sortBy('requestId')">${msg_admin_context_requestId}</th>
          <th></th>
        </tr></thead>
        <tbody id="emailTokenRowsBody">
        <c:forEach items="${list}" var="item" varStatus="st">
          <fmt:formatDate var="itemDateFilter" value="${item.createdAtDate}" pattern="yyyy-MM-dd"/>
          <fmt:formatDate var="itemTimeDisplay" value="${item.createdAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
          <fmt:formatDate var="itemUsedAtDisplay" value="${item.usedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
          <fmt:formatDate var="itemUsedAtDateFilter" value="${item.usedAtDate}" pattern="yyyy-MM-dd"/>
          <fmt:formatDate var="itemExpiredAtDisplay" value="${item.expiredAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
          <fmt:formatDate var="itemExpiredAtDateFilter" value="${item.expiredAtDate}" pattern="yyyy-MM-dd"/>
          <tr class="js-email-token-row"
              data-row-id="${item.verifyIdx}"
              data-created-at="${item.createdAt}"
              data-member="${fn:escapeXml(item.nickname)} ${fn:escapeXml(item.userId)}"
              data-purpose="${fn:escapeXml(item.purpose)}"
              data-target-email="${fn:escapeXml(item.email)}"
              data-used="${item.used ? 'USED' : 'UNUSED'}"
              data-used-at="${item.usedAt}"
              data-expires-at="${item.expiredAt}"
              data-request-id="${fn:escapeXml(item.requestId)}"
              data-original-index="${st.index}">
            <td class="adm-email-check-cell">
              <input type="checkbox" class="adm-check js-email-token-row-check" value="${item.verifyIdx}" aria-label="행 선택">
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
                  <button type="button" class="adm-inline-link js-open-member-context adm-email-member-link" data-user-idx="${item.userIdx}" data-default-tab="emailTokens"><c:out value="${item.nickname}"/></button>
                  <div class="mem-uid"><button type="button" class="adm-inline-link js-open-member-context adm-email-muted-link" data-user-idx="${item.userIdx}" data-default-tab="emailTokens">@${item.userId}</button></div>
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
              <button type="button" class="adm-cell-link" data-keyword="${item.email}" onclick="applyKeywordFilter(this)">
                <span><c:out value="${item.email}"/></span>
                <span class="adm-cell-link-note">${msg_admin_common_sameEmail}</span>
              </button>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-param-name="used" data-param-value="${item.used ? 'USED' : 'UNUSED'}" onclick="applySelectFilter(this)">
                <span><c:choose>
                  <c:when test="${item.used}">${msg_admin_context_used}</c:when>
                  <c:otherwise>${msg_admin_context_unused}</c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
              </button>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty item.usedAtDate}">
                  <button type="button" class="adm-cell-link"
                          data-date="${itemUsedAtDateFilter}"
                          onclick="filterByDate(this.dataset.date)">
                    <span>${itemUsedAtDisplay}</span>
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
                          data-date="${itemExpiredAtDateFilter}"
                          onclick="filterByDate(this.dataset.date)">
                    <span>${itemExpiredAtDisplay}</span>
                    <span class="adm-cell-link-note">${msg_admin_common_sameDate}</span>
                  </button>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td>
              <button type="button" class="adm-cell-link"
                      data-keyword="${empty item.flowTraceId ? item.requestId : item.flowTraceId}"
                      onclick="openRelatedHistory('email-verifications', this)">
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
                      data-email="${fn:escapeXml(item.email)}"
                      data-used="${item.used ? 'USED' : 'UNUSED'}"
                      data-used-at="${itemUsedAtDisplay}"
                      data-expires-at="${itemExpiredAtDisplay}"
                      data-request-id="${fn:escapeXml(item.requestId)}"
                      data-flow-trace="${fn:escapeXml(item.flowTraceId)}"
                      onclick="openTokenDetail(this)">
                ${msg_admin_common_viewDetail}
              </button>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty list}"><tr class="adm-local-empty"><td colspan="10" class="adm-local-empty-cell">${msg_admin_common_noResults}</td></tr></c:if>
      </tbody></table>
    </div>
    <div class="adm-local-pagination adm-email-pagination" data-section="emailVerificationTokens" id="emailTokenPaging">
      <div class="adm-local-page-info js-email-token-page-info" data-section="emailVerificationTokens">총 ${total}건 / 현재 ${fn:length(list)}건</div>
      <div class="adm-local-page-actions">
        <button type="button" class="adm-btn adm-btn-ghost js-email-token-prev" onclick="goEmailTokenPage(emailTokenState.page - 1)">${msg_admin_common_prev}</button>
        <span class="js-email-token-page-state" data-section="emailVerificationTokens">${paging.currentPage} / ${paging.totalPage}</span>
        <button type="button" class="adm-btn adm-btn-ghost js-email-token-next" onclick="goEmailTokenPage(emailTokenState.page + 1)">${msg_admin_common_next}</button>
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
var BASE_URL = '${pageContext.request.contextPath}/admin/email-tokens';
var EMAIL_TOKEN_MSG = {
  sortReset: '${msg_admin_blocks_js_dashSortReset_js}',
  noResults: '${msg_admin_common_noResults}'
};
var emailTokenState = {
  mode: '${search.mode}' === 'CLIENT' ? 'CLIENT' : 'SERVER',
  page: Number('${paging.currentPage}' || 1) || 1,
  pageSize: Number('${search.size}' || 30) || 30,
  sortField: '${fn:escapeXml(search.sortField)}',
  sortDir: '${fn:escapeXml(search.sortDir)}' || 'DESC'
};

function getEmailTokenForm() { return document.getElementById('emailTokenSearchForm'); }
function getEmailTokenTbody() { return document.getElementById('emailTokenRowsBody'); }
function emailTokenRows() { return Array.from(document.querySelectorAll('#emailTokenRowsBody .js-email-token-row')); }
function emailTokenVisibleRows() {
  return emailTokenRows().filter(function(row) { return !row.classList.contains('adm-is-hidden'); });
}
function emailTokenSelectedRows() {
  return emailTokenRows().filter(function(row) {
    var check = row.querySelector('.js-email-token-row-check');
    return check && check.checked;
  });
}
function updateEmailTokenSelection() {
  var selected = emailTokenSelectedRows();
  var visible = emailTokenVisibleRows();
  var visibleChecks = visible.map(function(row) { return row.querySelector('.js-email-token-row-check'); }).filter(Boolean);
  var checkAll = document.getElementById('emailTokenCheckAll');
  if (checkAll) {
    checkAll.checked = visibleChecks.length > 0 && visibleChecks.every(function(check) { return check.checked; });
    checkAll.indeterminate = visibleChecks.some(function(check) { return check.checked; }) && !checkAll.checked;
  }
  var count = document.getElementById('emailTokenSelectedCount');
  if (count) count.textContent = selected.length + '건 선택';
  var bar = document.getElementById('emailTokenSelectionBar');
  if (bar) bar.classList.toggle('is-active', selected.length > 0);
  document.querySelectorAll('.js-email-token-selected-export').forEach(function(button) {
    button.disabled = selected.length === 0;
    if (button.classList.contains('adm-export-item')) {
      button.textContent = '선택 내보내기 (' + selected.length + ')';
    }
  });
}
function clearEmailTokenSelection() {
  emailTokenRows().forEach(function(row) {
    var check = row.querySelector('.js-email-token-row-check');
    if (check) check.checked = false;
  });
  updateEmailTokenSelection();
}
function toggleEmailTokenVisibleSelection(checked) {
  emailTokenVisibleRows().forEach(function(row) {
    var check = row.querySelector('.js-email-token-row-check');
    if (check) check.checked = checked;
  });
  updateEmailTokenSelection();
}
function syncEmailTokenHiddenInputs() {
  var form = getEmailTokenForm();
  if (!form) return;
  var page = form.querySelector('[name=page]');
  var size = form.querySelector('[name=size]');
  var mode = form.querySelector('[name=mode]');
  var sortField = form.querySelector('[name=sortField]');
  var sortDir = form.querySelector('[name=sortDir]');
  if (page) page.value = emailTokenState.page;
  if (size) size.value = emailTokenState.pageSize;
  if (mode) mode.value = emailTokenState.mode;
  if (sortField) sortField.value = emailTokenState.sortField || '';
  if (sortDir) sortDir.value = emailTokenState.sortDir || 'DESC';
}
function buildEmailTokenParams(pageOverride) {
  var form = getEmailTokenForm();
  var params = new URLSearchParams(form ? new FormData(form) : window.location.search);
  params.set('page', String(pageOverride || emailTokenState.page || 1));
  params.set('size', String(emailTokenState.pageSize || 30));
  params.set('mode', emailTokenState.mode || 'SERVER');
  if (emailTokenState.sortField) {
    params.set('sortField', emailTokenState.sortField);
    params.set('sortDir', emailTokenState.sortDir || 'DESC');
  } else {
    params.delete('sortField');
    params.delete('sortDir');
  }
  return params;
}
function replaceEmailTokenUrl() {
  var params = buildEmailTokenParams(emailTokenState.page);
  window.history.replaceState(null, '', BASE_URL + '?' + params.toString());
}
function navigateEmailToken(pageOverride) {
  syncEmailTokenHiddenInputs();
  var params = buildEmailTokenParams(pageOverride || emailTokenState.page || 1);
  location.href = BASE_URL + '?' + params.toString();
}
function updateEmailTokenSortIndicators() {
  document.querySelectorAll('.js-email-token-sort').forEach(function(th) {
    th.classList.remove('sorted');
    var old = th.querySelector('.sort-ico');
    if (old) old.remove();
    if (emailTokenState.sortField && th.dataset.sort === emailTokenState.sortField) {
      th.classList.add('sorted');
      var asc = emailTokenState.sortDir === 'ASC';
      var ico = document.createElement('span');
      ico.className = 'sort-ico ' + (asc ? 'asc' : 'desc');
      ico.textContent = asc ? '▲' : '▼';
      th.appendChild(ico);
    }
  });
  var reset = document.querySelector('.js-email-token-sort-reset');
  if (reset) {
    reset.textContent = EMAIL_TOKEN_MSG.sortReset || '↺ 초기화';
    reset.classList.toggle('adm-is-hidden', !emailTokenState.sortField);
  }
  syncEmailTokenHiddenInputs();
  syncEmailTokenControlOverflow();
}
function updateEmailTokenPaginationMeta(page, pages, total, current) {
  var safePage = Math.max(1, Number(page || 1));
  var safePages = Math.max(1, Number(pages || 1));
  emailTokenState.page = Math.min(safePage, safePages);
  var info = document.querySelector('.js-email-token-page-info');
  if (info) info.textContent = '총 ' + Number(total || 0) + '건 / 현재 ' + Number(current || 0) + '건';
  var label = document.getElementById('emailTokenTotalLabel');
  if (label) label.textContent = '총 ' + Number(total || 0) + '건';
  var state = document.querySelector('.js-email-token-page-state');
  if (state) state.textContent = emailTokenState.page + ' / ' + safePages;
  var prev = document.querySelector('.js-email-token-prev');
  var next = document.querySelector('.js-email-token-next');
  if (prev) prev.disabled = emailTokenState.page <= 1;
  if (next) next.disabled = emailTokenState.page >= safePages;
  syncEmailTokenHiddenInputs();
}
function emailTokenSortValue(row, field) {
  if (!row || !field) return '';
  if (field === 'time') return row.dataset.createdAt || '';
  if (field === 'member') return row.dataset.member || '';
  if (field === 'purpose') return row.dataset.purpose || '';
  if (field === 'targetEmail') return row.dataset.targetEmail || '';
  if (field === 'used') return row.dataset.used || '';
  if (field === 'usedAt') return row.dataset.usedAt || '';
  if (field === 'expiresAt') return row.dataset.expiresAt || '';
  return row.dataset.requestId || '';
}
function compareEmailTokenRows(a, b) {
  var field = emailTokenState.sortField;
  if (!field) return Number(a.dataset.originalIndex || 0) - Number(b.dataset.originalIndex || 0);
  var av = emailTokenSortValue(a, field);
  var bv = emailTokenSortValue(b, field);
  var cmp = String(av).localeCompare(String(bv), undefined, {numeric:true, sensitivity:'base'});
  return cmp * (emailTokenState.sortDir === 'DESC' ? -1 : 1);
}
function renderEmailTokenClientPage(pageOverride) {
  var tbody = getEmailTokenTbody();
  if (!tbody) return;
  var rows = emailTokenRows();
  if (!rows.length) {
    updateEmailTokenPaginationMeta(1, 1, 0, 0);
    return;
  }
  rows.sort(compareEmailTokenRows).forEach(function(row) { tbody.appendChild(row); });
  var pageSize = Number(emailTokenState.pageSize || 30);
  var total = rows.length;
  var pages = Math.max(1, Math.ceil(total / pageSize));
  var page = Math.min(Math.max(1, Number(pageOverride || emailTokenState.page || 1)), pages);
  var start = (page - 1) * pageSize;
  rows.forEach(function(row, idx) {
    row.classList.toggle('adm-is-hidden', idx < start || idx >= start + pageSize);
  });
  updateEmailTokenPaginationMeta(page, pages, total, Math.min(pageSize, Math.max(0, total - start)));
  updateEmailTokenSortIndicators();
  updateEmailTokenSelection();
  replaceEmailTokenUrl();
}

function sortBy(field) {
  emailTokenState.sortDir = (emailTokenState.sortField === field && emailTokenState.sortDir !== 'ASC') ? 'ASC' : 'DESC';
  emailTokenState.sortField = field;
  emailTokenState.page = 1;
  if (emailTokenState.mode === 'CLIENT') renderEmailTokenClientPage(1);
  else navigateEmailToken(1);
}
function resetEmailTokenSort() {
  emailTokenState.sortField = '';
  emailTokenState.sortDir = 'DESC';
  emailTokenState.page = 1;
  if (emailTokenState.mode === 'CLIENT') renderEmailTokenClientPage(1);
  else navigateEmailToken(1);
}
function changeEmailTokenMode(value) {
  emailTokenState.mode = value === 'CLIENT' ? 'CLIENT' : 'SERVER';
  emailTokenState.page = 1;
  localStorage.setItem('admin.emailTokens.mode', emailTokenState.mode);
  navigateEmailToken(1);
}
function changeEmailTokenSize(value) {
  emailTokenState.pageSize = Number(value || 30) || 30;
  emailTokenState.page = 1;
  if (emailTokenState.mode === 'CLIENT') renderEmailTokenClientPage(1);
  else navigateEmailToken(1);
}
function filterByDate(dateStr) {
  var params = new URLSearchParams(window.location.search);
  params.set('dateFilter', dateStr); params.set('page', '1'); params.set('size', emailTokenState.pageSize); params.set('mode', emailTokenState.mode);
  location.href = BASE_URL + '?' + params.toString();
}
function applyKeywordFilter(button) {
  var keyword = button.getAttribute('data-keyword');
  if (!keyword) return;
  var params = new URLSearchParams(window.location.search);
  params.set('keyword', keyword); params.set('page', '1'); params.set('size', emailTokenState.pageSize); params.set('mode', emailTokenState.mode);
  location.href = BASE_URL + '?' + params.toString();
}
function applySelectFilter(button) {
  var paramName = button.getAttribute('data-param-name');
  var paramValue = button.getAttribute('data-param-value');
  if (!paramName || !paramValue) return;
  var params = new URLSearchParams(window.location.search);
  params.set(paramName, paramValue); params.set('page', '1'); params.set('size', emailTokenState.pageSize); params.set('mode', emailTokenState.mode);
  location.href = BASE_URL + '?' + params.toString();
}
function goEmailTokenPage(page) {
  if (emailTokenState.mode === 'CLIENT') renderEmailTokenClientPage(page);
  else navigateEmailToken(page);
}
function openRelatedHistory(path, button) {
  var params = new URLSearchParams();
  if (button.dataset.keyword) params.set('keyword', button.dataset.keyword);
  params.set('page', '1');
  location.href = '${pageContext.request.contextPath}/admin/' + path + '?' + params.toString();
}
function exportEmailTokens(scope) {
  if (scope === 'selected') {
    exportSelectedEmailTokens();
    return;
  }
  var format = document.getElementById('emailTokenExportFormat').value;
  var params = buildEmailTokenParams(emailTokenState.page);
  params.set('scope', scope);
  params.set('format', format);
  if (scope !== 'page') params.delete('page');
  var dropdown = document.getElementById('emailTokenExportDropdown');
  if (dropdown) dropdown.classList.remove('open');
  window.location.href = BASE_URL + '/export?' + params.toString();
}
function emailTokenCleanExportText(cell) {
  var clone = cell.cloneNode(true);
  clone.querySelectorAll('.adm-cell-link-note, input, .adm-row-btn').forEach(function(node) { node.remove(); });
  return (clone.textContent || '').replace(/\s+/g, ' ').trim();
}
function emailTokenCsvEscape(value) {
  return '"' + String(value == null ? '' : value).replace(/"/g, '""') + '"';
}
function emailTokenXmlEscape(value) {
  return String(value == null ? '' : value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}
function downloadEmailTokenExport(content, filename, type) {
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
function exportSelectedEmailTokens() {
  var selected = emailTokenSelectedRows();
  if (!selected.length) {
    if (window.adm_toast) adm_toast('선택된 항목이 없습니다.', 'error');
    else alert('선택된 항목이 없습니다.');
    return;
  }
  var table = document.getElementById('emailVerificationTokenTable');
  var headers = Array.from(table.querySelectorAll('thead th')).slice(1, -1)
    .map(function(th) { return (th.textContent || '').replace(/[▲▼]/g, '').replace(/\s+/g, ' ').trim(); });
  var rows = selected.map(function(row) {
    return Array.from(row.children).slice(1, -1).map(emailTokenCleanExportText);
  });
  var format = document.getElementById('emailTokenExportFormat').value;
  if (format === 'excel') {
    var xmlRows = [headers].concat(rows).map(function(row, index) {
      return '<Row>' + row.map(function(value) {
        var style = index === 0 ? ' ss:StyleID="header"' : '';
        return '<Cell' + style + '><Data ss:Type="String">' + emailTokenXmlEscape(value) + '</Data></Cell>';
      }).join('') + '</Row>';
    }).join('');
    var xls = '<?xml version="1.0" encoding="UTF-8"?><?mso-application progid="Excel.Sheet"?>'
      + '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">'
      + '<Styles><Style ss:ID="header"><Font ss:Bold="1"/><Interior ss:Color="#D9EAF7" ss:Pattern="Solid"/></Style></Styles>'
      + '<Worksheet ss:Name="selected_tokens"><Table>' + xmlRows + '</Table></Worksheet></Workbook>';
    downloadEmailTokenExport('\ufeff' + xls, 'email-verification-tokens-selected.xls', 'application/vnd.ms-excel;charset=utf-8');
  } else {
    var csv = [headers].concat(rows).map(function(row) { return row.map(emailTokenCsvEscape).join(','); }).join('\n');
    downloadEmailTokenExport('\ufeff' + csv, 'email-verification-tokens-selected.csv', 'text/csv;charset=utf-8');
  }
  var dropdown = document.getElementById('emailTokenExportDropdown');
  if (dropdown) dropdown.classList.remove('open');
}
function openTokenDetail(btn) {
  var d = btn.dataset;
  showRowDetail('${msg_admin_emailTokens_historyTitle}', [
    ['발급 시각', d.time],
    ['회원', d.user],
    ['목적', d.purpose],
    ['이메일', d.email],
    ['사용 여부', d.used],
    ['사용 시각', d.usedAt],
    ['만료 시각', d.expiresAt],
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
let emailTokenControlOverflowSync = null;
function isVisibleEmailTokenTool(tool) {
  if (!tool) return false;
  return !tool.classList.contains('js-email-token-sort-reset') || !tool.classList.contains('adm-is-hidden');
}
function syncEmailTokenControlOverflow() {
  if (typeof emailTokenControlOverflowSync === 'function') emailTokenControlOverflowSync();
}
function initEmailTokenControlOverflow() {
  var primary = document.getElementById('emailTokenPrimaryTools');
  var menu = document.getElementById('emailTokenOverflowMenu');
  var panel = document.getElementById('emailTokenOverflowPanel');
  var toggle = menu ? menu.querySelector('.adm-email-overflow-toggle') : null;
  if (!primary || !menu || !panel || !toggle) return;
  var tools = [
    { node: document.querySelector('.js-email-token-sort-reset'), breakpoint: 1380 },
    { node: document.querySelector('.adm-email-mode-tool'), breakpoint: 1180 },
    { node: document.querySelector('.adm-email-size-tool'), breakpoint: 980 }
  ].filter(function(item) { return !!item.node; });
  emailTokenControlOverflowSync = function() {
    var width = window.innerWidth || document.documentElement.clientWidth || 1600;
    tools.forEach(function(item) {
      var target = width <= item.breakpoint ? panel : primary;
      if (item.node.parentElement !== target) target.appendChild(item.node);
    });
    var hasItems = Array.from(panel.children).some(isVisibleEmailTokenTool);
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
  window.addEventListener('resize', syncEmailTokenControlOverflow, { passive: true });
  syncEmailTokenControlOverflow();
}
function initEmailTokenSection() {
  var storedMode = localStorage.getItem('admin.emailTokens.mode');
  if (!new URLSearchParams(window.location.search).has('mode') && storedMode && storedMode !== emailTokenState.mode) {
    emailTokenState.mode = storedMode === 'CLIENT' ? 'CLIENT' : 'SERVER';
    navigateEmailToken(1);
    return;
  }
  var modeSelect = document.getElementById('emailTokenModeSelect');
  if (modeSelect) modeSelect.value = emailTokenState.mode;
  var form = getEmailTokenForm();
  if (form) form.addEventListener('submit', function() { emailTokenState.page = 1; syncEmailTokenHiddenInputs(); });
  var checkAll = document.getElementById('emailTokenCheckAll');
  if (checkAll) checkAll.addEventListener('change', function() { toggleEmailTokenVisibleSelection(checkAll.checked); });
  emailTokenRows().forEach(function(row) {
    var check = row.querySelector('.js-email-token-row-check');
    if (check) check.addEventListener('change', updateEmailTokenSelection);
  });
  var exportToggle = document.querySelector('.js-email-token-export-toggle');
  var exportDropdown = document.getElementById('emailTokenExportDropdown');
  if (exportToggle && exportDropdown) {
    exportToggle.addEventListener('click', function() { exportDropdown.classList.toggle('open'); });
    document.addEventListener('click', function(e) {
      if (!exportToggle.contains(e.target) && !exportDropdown.contains(e.target)) exportDropdown.classList.remove('open');
    });
  }
  initEmailTokenControlOverflow();
  if (emailTokenState.mode === 'CLIENT') {
    renderEmailTokenClientPage(emailTokenState.page);
  } else {
    updateEmailTokenSortIndicators();
    updateEmailTokenPaginationMeta(emailTokenState.page, Number('${paging.totalPage}' || 1), Number('${total}' || 0), emailTokenRows().length);
    updateEmailTokenSelection();
  }
}
document.addEventListener('DOMContentLoaded', initEmailTokenSection);
</script>
<%@ include file="../layout-close.jsp" %>
