<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_e986d30bcd" code="admin.community.tab.posts"/>
<spring:message var="autoMsg_519bfc7905" code="admin.community.tab.comments"/>
<spring:message var="autoMsg_b03318e978" code="admin.community.kpi.activePosts"/>
<spring:message var="autoMsg_ee4cbbc833" code="admin.community.kpi.totalPosts"/>
<spring:message var="autoMsg_15ef06b762" code="admin.community.kpi.blockedPosts"/>
<spring:message var="autoMsg_a4c0d74ded" code="admin.community.kpi.deletedPosts"/>
<spring:message var="autoMsg_31b94cbad0" code="admin.community.kpi.activeComments"/>
<spring:message var="autoMsg_68cbfa37f0" code="admin.community.kpi.blockedComments"/>
<spring:message var="autoMsg_60c7903c78" code="admin.community.kpi.pendingReports"/>
<spring:message var="autoMsg_9747193897" code="admin.community.kpi.resolvedReports30d"/>
<spring:message var="autoMsg_784962e950" code="admin.community.filter.status"/>
<spring:message var="autoMsg_091d56acc9" code="admin.common.all"/>
<spring:message var="autoMsg_a3bcb29a0c" code="admin.community.status.active"/>
<spring:message var="autoMsg_81b8994d7e" code="admin.community.status.blocked"/>
<spring:message var="autoMsg_2d5c6767f8" code="admin.community.status.deleted"/>
<spring:message var="autoMsg_5467147e32" code="admin.community.filter.type"/>
<spring:message var="autoMsg_eac82ebab4" code="admin.community.postType.review"/>
<spring:message var="autoMsg_7973be7817" code="admin.community.postType.photo"/>
<spring:message var="autoMsg_4e4bc634e1" code="admin.community.postType.tip"/>
<spring:message var="autoMsg_01fca1a4ed" code="admin.community.postType.question"/>
<spring:message var="autoMsg_4470083b06" code="admin.community.filter.sort"/>
<spring:message var="autoMsg_9eea6940ae" code="admin.community.sort.createdAt"/>
<spring:message var="autoMsg_7954a9725c" code="admin.community.sort.reportCount"/>
<spring:message var="autoMsg_1859a5b778" code="admin.community.filter.flagged"/>
<spring:message var="autoMsg_e40dd36b65" code="admin.community.flagged.flagged"/>
<spring:message var="autoMsg_937a07f78f" code="admin.common.search"/>
<spring:message var="autoMsg_d82c7aa047" code="admin.community.searchType.title"/>
<spring:message var="autoMsg_8b2ef02b58" code="admin.community.searchType.content"/>
<spring:message var="autoMsg_0bb651f55c" code="admin.community.searchType.nickname"/>
<spring:message var="autoMsg_6959a41bb9" code="admin.community.searchType.userId"/>
<spring:message var="autoMsg_401b717497" code="admin.community.filter.searchPlaceholder"/>
<spring:message var="autoMsg_62120563c4" code="admin.common.searchButton"/>
<spring:message var="autoMsg_4ed053a375" code="admin.common.reset"/>
<spring:message var="autoMsg_79ee78af33" code="admin.community.list.postsTitle"/>
<spring:message var="autoMsg_b65a795373" code="admin.common.totalCount"/>
<spring:message var="autoMsg_50c330202a" code="admin.community.action.bulkBlock"/>
<spring:message var="autoMsg_efcdd3f829" code="admin.community.action.bulkDelete"/>
<spring:message var="autoMsg_28e018d8fd" code="admin.community.column.id"/>
<spring:message var="autoMsg_e9f2e860b8" code="admin.community.column.author"/>
<spring:message var="autoMsg_ed9e29b7c1" code="admin.community.column.ip"/>
<spring:message var="autoMsg_8bd69b96da" code="admin.community.column.title"/>
<spring:message var="autoMsg_9b6994bcdd" code="admin.community.column.type"/>
<spring:message var="autoMsg_df71264448" code="admin.community.column.reportCount"/>
<spring:message var="autoMsg_531053a642" code="admin.common.status"/>
<spring:message var="autoMsg_d7acd014e2" code="admin.community.column.createdAt"/>
<spring:message var="autoMsg_40157ac017" code="admin.common.action"/>
<spring:message var="autoMsg_855fdf4b6a" code="admin.community.accountBlocked"/>
<spring:message var="autoMsg_ad5de23893" code="admin.community.rowResolved30d"/>
<spring:message var="autoMsg_c2de3079ea" code="admin.common.sameValue"/>
<spring:message var="autoMsg_3398e8bd8b" code="admin.community.action.block"/>
<spring:message var="autoMsg_0c3c7ba108" code="admin.community.action.delete"/>
<spring:message var="autoMsg_ce0fe32fcf" code="admin.common.noResults"/>
<spring:message var="autoMsg_67b5a87e64" code="admin.common.pageStatus"/>
<spring:message var="autoMsg_4782142ecc" code="admin.community.viewSite"/>
<spring:message var="autoMsg_cbba8877c3" code="admin.community.confirm.postAction" javaScriptEscape="true"/>
<spring:message var="autoMsg_a4213d693f" code="admin.community.confirm.bulkAction" javaScriptEscape="true"/>
<spring:message var="autoMsg_b4348ffa3f" code="admin.community.bulk.selectedCount" javaScriptEscape="true"/>
<spring:message var="autoMsg_9335fa9cbb" code="admin.community.action.block" javaScriptEscape="true"/>
<spring:message var="autoMsg_c4f82a7ae9" code="admin.community.action.delete" javaScriptEscape="true"/>
<spring:message var="autoMsg_4a3f3c8e04" code="admin.community.label.lastIp" javaScriptEscape="true"/>
<spring:message var="autoMsg_310f901f6f" code="admin.community.authorModal.recentResolved" javaScriptEscape="true"/>
<c:set var="activeMenu" value="community"/>
<spring:message code="admin.community.pageTitle" var="adminCommunityPageTitle"/>
<spring:message code="admin.common.nickname" var="adminCommonNickname"/>
<spring:message code="admin.common.userId" var="adminCommonUserId"/>
<spring:message code="admin.common.accountStatus" var="adminCommonAccountStatus"/>
<spring:message code="admin.common.memberInfoView" var="adminCommonMemberInfoView"/>
<spring:message code="admin.common.blockAccount" var="adminCommonBlockAccount"/>
<spring:message code="admin.common.activeLabel" var="adminCommonActiveLabel"/>
<spring:message code="admin.common.blockedLabel" var="adminCommonBlockedLabel"/>
<spring:message code="admin.community.authorModal.title" var="adminCommunityAuthorModalTitle"/>
<spring:message code="admin.community.confirmBlockUser" var="adminCommunityConfirmBlockUser"/>
<spring:message code="admin.community.message.actionFailed" var="adminCommunityActionFailed"/>
<spring:message code="admin.community.message.noSelection" var="adminCommunityNoSelection"/>
<spring:message code="admin.community.confirm.postAction" var="adminCommunityConfirmPostAction"/>
<spring:message code="admin.community.confirm.bulkAction" var="adminCommunityConfirmBulkAction"/>
<spring:message code="admin.community.bulk.selectedCount" var="adminCommunitySelectedCount"/>
<spring:message code="admin.community.authorModal.recentResolved" var="adminCommunityRecentResolved"/>
<c:set var="pageTitle" value="${adminCommunityPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 탭 바 ── --%>
    <div class="adm-tabs adm-admin-tabs">
        <a class="adm-tab adm-tab-link active" href="${pageContext.request.contextPath}/admin/community">📝 ${autoMsg_e986d30bcd}</a>
        <a class="adm-tab adm-tab-link" href="${pageContext.request.contextPath}/admin/community/comments">💬 ${autoMsg_519bfc7905}</a>
    </div>

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_b03318e978}</div>
            <div class="adm-summary-value is-primary">${stats.activePosts}</div>
            <div class="adm-summary-sub">${autoMsg_ee4cbbc833}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_15ef06b762}</div>
            <div class="adm-summary-value is-danger">${stats.blockedPosts}</div>
            <div class="adm-summary-sub">${autoMsg_a4c0d74ded}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_31b94cbad0}</div>
            <div class="adm-summary-value is-success">${stats.activeComments}</div>
            <div class="adm-summary-sub">${autoMsg_68cbfa37f0}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_60c7903c78}</div>
            <div class="adm-summary-value is-warning">${stats.pendingReports}</div>
            <div class="adm-summary-sub">${autoMsg_9747193897}</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/community" id="searchForm">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label">${autoMsg_784962e950}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ?'selected':''}>${autoMsg_091d56acc9}</option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ?'selected':''}>${autoMsg_a3bcb29a0c}</option>
                            <option value="BLOCKED" ${search.status=='BLOCKED' ?'selected':''}>${autoMsg_81b8994d7e}</option>
                            <option value="DELETED" ${search.status=='DELETED' ?'selected':''}>${autoMsg_2d5c6767f8}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_5467147e32}</div>
                        <select class="adm-select" name="postType">
                            <option value="ALL"      ${search.postType=='ALL'      ?'selected':''}>${autoMsg_091d56acc9}</option>
                            <option value="review"   ${search.postType=='review'   ?'selected':''}>${autoMsg_eac82ebab4}</option>
                            <option value="photo"    ${search.postType=='photo'    ?'selected':''}>${autoMsg_7973be7817}</option>
                            <option value="tip"      ${search.postType=='tip'      ?'selected':''}>${autoMsg_4e4bc634e1}</option>
                            <option value="question" ${search.postType=='question' ?'selected':''}>${autoMsg_01fca1a4ed}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_4470083b06}</div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt"   ${search.sortBy=='createdAt'   ?'selected':''}>${autoMsg_9eea6940ae}</option>
                            <option value="reportCount" ${search.sortBy=='reportCount' ?'selected':''}>${autoMsg_7954a9725c}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_1859a5b778}</div>
                        <select class="adm-select" name="flagged">
                            <option value="ALL"     ${search.flagged=='ALL'     ?'selected':''}>${autoMsg_091d56acc9}</option>
                            <option value="FLAGGED" ${search.flagged=='FLAGGED' ?'selected':''}>${autoMsg_e40dd36b65}</option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:200px;">
                        <div class="adm-filter-label">${autoMsg_937a07f78f}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:110px;">
                                <option value="all"      ${search.searchType=='all'      ?'selected':''}>${autoMsg_091d56acc9}</option>
                                <option value="title"    ${search.searchType=='title'    ?'selected':''}>${autoMsg_d82c7aa047}</option>
                                <option value="content"  ${search.searchType=='content'  ?'selected':''}>${autoMsg_8b2ef02b58}</option>
                                <option value="nickname" ${search.searchType=='nickname' ?'selected':''}>${autoMsg_0bb651f55c}</option>
                                <option value="userId"   ${search.searchType=='userId'   ?'selected':''}>${autoMsg_6959a41bb9}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}"
                                   placeholder="${autoMsg_401b717497}" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${autoMsg_62120563c4}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/community">${autoMsg_4ed053a375}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">${autoMsg_79ee78af33}</div>
                <div class="adm-muted-note">${autoMsg_b65a795373}</div>
            </div>
            <%-- 일괄 처리 버튼 --%>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;"
                        onclick="bulkAction('block')">${autoMsg_50c330202a}</button>
                <button class="adm-btn adm-btn-ghost" style="color:#64748b;"
                        onclick="bulkAction('delete')">${autoMsg_efcdd3f829}</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:60px;">${autoMsg_28e018d8fd}</th>
                    <th>${autoMsg_e9f2e860b8}</th>
                    <th>${autoMsg_ed9e29b7c1}</th>
                    <th>${autoMsg_8bd69b96da}</th>
                    <th style="width:80px;">${autoMsg_9b6994bcdd}</th>
                    <th style="width:60px;">${autoMsg_df71264448}</th>
                    <th style="width:80px;">${autoMsg_531053a642}</th>
                    <th style="width:130px;">${autoMsg_d7acd014e2}</th>
                    <th style="width:100px;">${autoMsg_40157ac017}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="p">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${p.postId}"></td>
                        <td style="color:#64748b;font-size:12px;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/community/posts/${p.postId}">#${p.postId}</a>
                        </td>

                        <%-- 작성자 --%>
                        <td style="cursor:pointer;"
                            data-useridx="${p.userIdx}"
                            data-userid="${p.userId}"
                            data-nickname="${p.nickname}"
                            data-ip="${p.lastIp}"
                            data-status="${p.accountStatus}"
                            data-resolve="${p.authorResolveCount30d}"
                            onclick="openAuthorModal(this)">
                            <div style="font-weight:600;font-size:13px;color:#7dd3fc;">${p.nickname}</div>
                            <div style="font-size:11px;color:#64748b;">${p.userId}</div>
                            <c:if test="${p.accountStatus == 'BLOCKED'}">
                                <span class="adm-inline-danger">${autoMsg_855fdf4b6a}</span>
                            </c:if>
                        </td>

                        <%-- IP --%>
                        <td style="font-size:11px;color:#94a3b8;font-family:monospace;">
                            <c:choose>
                                <c:when test="${not empty p.lastIp}">
                                    <button type="button"
                                            class="adm-inline-link js-open-ip-context"
                                            data-ip-address="${p.lastIp}"
                                            data-default-tab="blocks"
                                            onclick="event.stopPropagation();">${p.lastIp}</button>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">—</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 제목 + 30일 배지 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/community/posts/${p.postId}"
                               class="adm-link-title"
                               title="${p.title}">
                                    <c:choose>
                                    <c:when test="${fn:length(p.title) > 30}">${fn:substring(p.title, 0, 30)}…</c:when>
                                    <c:otherwise>${p.title}</c:otherwise>
                                </c:choose>
                            </a>
                            <c:if test="${p.authorResolveCount30d > 0}">
                                <span class="adm-inline-warning">
                                    ⚠ ${autoMsg_ad5de23893}
                                </span>
                            </c:if>
                        </td>

                        <%-- 유형 --%>
                        <td style="font-size:12px;color:#94a3b8;white-space:nowrap;">
                            <button type="button" class="adm-cell-link" data-param-name="postType" data-param-value="${p.postType}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${p.postType == 'review'}">${autoMsg_eac82ebab4}</c:when>
                                    <c:when test="${p.postType == 'photo'}">${autoMsg_7973be7817}</c:when>
                                    <c:when test="${p.postType == 'tip'}">${autoMsg_4e4bc634e1}</c:when>
                                    <c:when test="${p.postType == 'question'}">${autoMsg_01fca1a4ed}</c:when>
                                    <c:otherwise>${p.postType}</c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note">${autoMsg_c2de3079ea}</span>
                            </button>
                        </td>

                        <%-- 신고 수 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/reports?targetType=post&keyword=${p.postId}"
                               class="adm-cell-link adm-cell-link--inline"
                               onclick="event.stopPropagation();">
                                <c:choose>
                                    <c:when test="${p.reportCount >= reportThreshold}">
                                        <span style="color:#f87171;font-weight:700;">🔴 ${p.reportCount}</span>
                                    </c:when>
                                    <c:when test="${p.reportCount > 0}">
                                        <span style="color:#fbbf24;">${p.reportCount}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color:#475569;">0</span>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/community/posts/${p.postId}"
                               class="adm-cell-link adm-cell-link--inline status-badge ${p.postStatus}">
                                <c:choose>
                                    <c:when test="${p.postStatus == 'ACTIVE'}">${autoMsg_a3bcb29a0c}</c:when>
                                    <c:when test="${p.postStatus == 'BLOCKED'}">${autoMsg_81b8994d7e}</c:when>
                                    <c:when test="${p.postStatus == 'DELETED'}">${autoMsg_2d5c6767f8}</c:when>
                                    <c:otherwise>${p.postStatus}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 등록일 --%>
                        <td style="font-size:11px;color:#64748b;white-space:nowrap;">
                            <a href="${pageContext.request.contextPath}/admin/community/posts/${p.postId}"
                               class="adm-cell-link adm-cell-link--inline">
                                <fmt:formatDate value="${p.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                            </a>
                        </td>

                        <%-- 액션 --%>
                        <td>
                            <c:choose>
                                <c:when test="${p.postStatus != 'BLOCKED'}">
                                    <div class="adm-row-actions">
                                        <button class="adm-row-btn danger"
                                                type="button"
                                                data-id="${p.postId}"
                                                onclick="actionPost(this.getAttribute('data-id'), 'block')">${autoMsg_3398e8bd8b}</button>
                                        <c:if test="${p.postStatus != 'DELETED'}">
                                            <div class="action-menu-wrap">
                                                <button class="adm-row-btn detail adm-row-btn-more"
                                                        type="button"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu">
                                                    <button class="action-menu-item danger"
                                                            type="button"
                                                            data-id="${p.postId}"
                                                            onclick="actionPost(this.getAttribute('data-id'), 'delete')">${autoMsg_0c3c7ba108}</button>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:when>
                                <c:when test="${p.postStatus != 'DELETED'}">
                                    <div class="adm-row-actions is-single">
                                        <button class="adm-row-btn danger"
                                                type="button"
                                                data-id="${p.postId}"
                                                onclick="actionPost(this.getAttribute('data-id'), 'delete')">${autoMsg_0c3c7ba108}</button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span class="adm-muted-inline">-</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="10" style="text-align:center;padding:40px;color:#475569;">${autoMsg_ce0fe32fcf}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <%-- 페이지네이션 --%>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}">
                    <button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button>
                </c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg">
                    <button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" onclick="goPage(${pg})">${pg}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button>
                </c:if>
                <span class="adm-page-info">${autoMsg_67b5a87e64}</span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/community/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> ${autoMsg_4782142ecc}
        </a>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var COMMUNITY_POST_MSG = {
    noSelection: '${fn:escapeXml(adminCommunityNoSelection)}',
    actionFailed: '${fn:escapeXml(adminCommunityActionFailed)}',
    confirmPostAction: '${autoMsg_cbba8877c3}',
    confirmBulkAction: '${autoMsg_a4213d693f}',
    selectedCount: '${autoMsg_b4348ffa3f}',
    block: '${autoMsg_9335fa9cbb}',
    delete: '${autoMsg_c4f82a7ae9}',
    blocked: '${fn:escapeXml(adminCommonBlockedLabel)}',
    active: '${fn:escapeXml(adminCommonActiveLabel)}',
    nickname: '${fn:escapeXml(adminCommonNickname)}',
    userId: '${fn:escapeXml(adminCommonUserId)}',
    accountStatus: '${fn:escapeXml(adminCommonAccountStatus)}',
    lastIp: '${autoMsg_4a3f3c8e04}',
    memberInfoView: '${fn:escapeXml(adminCommonMemberInfoView)}',
    blockAccount: '${fn:escapeXml(adminCommonBlockAccount)}',
    confirmBlock: '${fn:escapeXml(adminCommunityConfirmBlockUser)}',
    recentResolved: '${autoMsg_310f901f6f}',
    modalTitle: '${fn:escapeXml(adminCommunityAuthorModalTitle)}'
};

// ── 전체 선택 ──
document.getElementById('checkAll').addEventListener('change', function () {
    document.querySelectorAll('.row-check').forEach(function (cb) { cb.checked = this.checked; }, this);
    updateBulkBar();
});
document.querySelectorAll('.row-check').forEach(function (cb) {
    cb.addEventListener('change', updateBulkBar);
});

function updateBulkBar() {
    var checked = document.querySelectorAll('.row-check:checked');
    var bar = document.getElementById('bulkBar');
    if (checked.length > 0) {
        bar.style.display = 'flex';
        document.getElementById('bulkCount').textContent = COMMUNITY_POST_MSG.selectedCount.replace('__count__', checked.length);
    } else {
        bar.style.display = 'none';
    }
}

// ── 단건 액션 ──
function actionPost(postId, action) {
    var label = action === 'block' ? COMMUNITY_POST_MSG.block : COMMUNITY_POST_MSG.delete;
    var message = COMMUNITY_POST_MSG.confirmPostAction
        .replace('__id__', postId)
        .replace('__action__', label);
    if (!confirm(message)) return;
    fetch(ctx + '/admin/community/posts/' + postId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_POST_MSG.actionFailed); }
    });
}

// ── 일괄 처리 ──
function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked'))
                   .map(function (cb) { return cb.getAttribute('data-id'); });
    if (ids.length === 0) { alert(COMMUNITY_POST_MSG.noSelection); return; }
    var label = action === 'block' ? COMMUNITY_POST_MSG.block : COMMUNITY_POST_MSG.delete;
    var message = COMMUNITY_POST_MSG.confirmBulkAction
        .replace('__count__', ids.length)
        .replace('__action__', label);
    if (!confirm(message)) return;

    var body = 'action=' + action + '&' + ids.map(function (id) { return 'ids=' + id; }).join('&');
    fetch(ctx + '/admin/community/posts/bulk-action', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_POST_MSG.actionFailed); }
    });
}

function applySelectFilter(button) {
    var paramName = button.getAttribute('data-param-name');
    var paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    var params = new URLSearchParams(window.location.search);
    params.set(paramName, paramValue);
    params.set('page', '1');
    location.href = ctx + '/admin/community?' + params.toString();
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/community?' + params.toString();
}

// ── 작성자 모달 ──
function openAuthorModal(el) {
    var userIdx  = el.getAttribute('data-useridx');
    var userId   = el.getAttribute('data-userid');
    var nickname = el.getAttribute('data-nickname');
    var ip       = el.getAttribute('data-ip');
    var status   = el.getAttribute('data-status');
    var resolve  = parseInt(el.getAttribute('data-resolve') || '0', 10);

    var statusBadge = status === 'BLOCKED'
        ? '<span class="status-badge BLOCKED" style="font-size:12px;">' + COMMUNITY_POST_MSG.blocked + '</span>'
        : '<span class="status-badge ACTIVE"  style="font-size:12px;">' + COMMUNITY_POST_MSG.active + '</span>';

    var warnBox = resolve > 0
        ? '<div class="adm-warning-box">⚠ ' + COMMUNITY_POST_MSG.recentResolved.replace('__count__', resolve) + '</div>'
        : '';

    var blockBtn = status !== 'BLOCKED'
        ? '<button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;width:100%;margin-top:4px;" data-idx="' + userIdx + '" onclick="blockUserFromModal(this)">' + COMMUNITY_POST_MSG.blockAccount + '</button>'
        : '';

    document.getElementById('authorModalBody').innerHTML =
        '<div class="adm-modal-stack">'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_POST_MSG.nickname + '</span>'
      + '    <span class="adm-modal-nickname">' + escHtml(nickname) + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_POST_MSG.userId + '</span>'
      + '    <span class="adm-modal-value">' + escHtml(userId) + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_POST_MSG.lastIp + '</span>'
      + '    <span class="adm-modal-value adm-mono-text">' + escHtml(ip || '—') + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_POST_MSG.accountStatus + '</span>'
      + '    ' + statusBadge
      + '  </div>'
      + '</div>'
      + warnBox
      + '<div class="adm-action-stack">'
      + '  <a href="' + ctx + '/admin/members?searchType=userId&keyword=' + encodeURIComponent(userId) + '" class="adm-btn adm-btn-ghost adm-link-button">' + COMMUNITY_POST_MSG.memberInfoView + '</a>'
      + blockBtn
      + '</div>';

    document.getElementById('authorModal').style.display = 'flex';
}

function closeAuthorModal() {
    document.getElementById('authorModal').style.display = 'none';
}

function blockUserFromModal(btn) {
    var userIdx = btn.getAttribute('data-idx');
    if (!confirm(COMMUNITY_POST_MSG.confirmBlock)) return;
    fetch(ctx + '/admin/community/users/' + userIdx + '/block', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_POST_MSG.actionFailed); }
    });
}

function escHtml(str) {
    if (!str) return '';
    return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}
</script>

<%-- ── 작성자 정보 모달 ── --%>
    <div id="authorModal" class="adm-modal-overlay" style="display:none;"
     onclick="if(event.target===this)closeAuthorModal()">
    <div class="adm-modal" style="width:360px;">
        <div class="adm-modal-head">
            <span class="adm-modal-title">${adminCommunityAuthorModalTitle}</span>
            <button class="adm-modal-close" onclick="closeAuthorModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="authorModalBody"></div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
