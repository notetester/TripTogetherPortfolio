<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_community_search_placeholder" code="community.search.placeholder"/>
<spring:message var="msg_community_today_close_js" code="community.today.close" javaScriptEscape="true"/>
<spring:message var="msg_community_today_open_js" code="community.today.open" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_delete_confirm_js" code="community.admin.delete.confirm" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_delete_fail_js" code="community.admin.delete.fail" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_clearBlur_confirm_js" code="community.admin.clearBlur.confirm" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_clearBlur_fail_js" code="community.admin.clearBlur.fail" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_selected_js" code="community.admin.selected" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_noneSelected_js" code="community.admin.noneSelected" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_delete_js" code="community.admin.delete" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_block_user_js" code="community.admin.block.user" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_block_ip_js" code="community.admin.block.ip" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_block_both_js" code="community.admin.block.both" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_blockDelete_user_js" code="community.admin.blockDelete.user" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_blockDelete_ip_js" code="community.admin.blockDelete.ip" javaScriptEscape="true"/>
<spring:message var="msg_community_admin_blockDelete_both_js" code="community.admin.blockDelete.both" javaScriptEscape="true"/>
<spring:message var="msg_community_detail_bulk_posts_confirm_js" code="community.detail.bulk.posts.confirm" javaScriptEscape="true"/>
<spring:message var="msg_community_detail_bulk_done_js" code="community.detail.bulk.done" javaScriptEscape="true"/>
<spring:message var="msg_community_detail_bulk_fail_js" code="community.detail.bulk.fail" javaScriptEscape="true"/>
<spring:message var="msg_community_detail_request_fail_js" code="community.detail.request.fail" javaScriptEscape="true"/>
<spring:message var="msg_community_title" code="community.title"/>
<spring:message var="msg_community_subtitle" code="community.subtitle"/>
<spring:message var="msg_community_today_title" code="community.today.title"/>
<spring:message var="msg_community_today_close" code="community.today.close"/>
<spring:message var="msg_community_type_review" code="community.type.review"/>
<spring:message var="msg_community_type_photo" code="community.type.photo"/>
<spring:message var="msg_community_type_tip" code="community.type.tip"/>
<spring:message var="msg_community_type_question" code="community.type.question"/>
<spring:message var="msg_community_tip_transport" code="community.tip.transport"/>
<spring:message var="msg_community_tip_accom" code="community.tip.accom"/>
<spring:message var="msg_community_tip_food" code="community.tip.food"/>
<spring:message var="msg_community_tip_money" code="community.tip.money"/>
<spring:message var="msg_community_tip_safety" code="community.tip.safety"/>
<spring:message var="msg_community_tip_etc" code="community.tip.etc"/>
<spring:message var="msg_community_question_solved" code="community.question.solved"/>
<spring:message var="msg_community_question_unsolved" code="community.question.unsolved"/>
<spring:message var="msg_community_blocked_ai" code="community.blocked.ai"/>
<spring:message var="msg_community_blocked_report" code="community.blocked.report"/>
<spring:message var="msg_community_region_all" code="community.region.all"/>
<spring:message var="msg_community_region_asia" code="community.region.asia"/>
<spring:message var="msg_community_region_europe" code="community.region.europe"/>
<spring:message var="msg_community_region_africa" code="community.region.africa"/>
<spring:message var="msg_community_region_northAmerica" code="community.region.northAmerica"/>
<spring:message var="msg_community_region_southAmerica" code="community.region.southAmerica"/>
<spring:message var="msg_community_region_oceania" code="community.region.oceania"/>
<spring:message var="msg_community_region_etc" code="community.region.etc"/>
<spring:message var="msg_community_search_all" code="community.search.all"/>
<spring:message var="msg_community_search_title" code="community.search.title"/>
<spring:message var="msg_community_search_content" code="community.search.content"/>
<spring:message var="msg_community_search_tag" code="community.search.tag"/>
<spring:message var="msg_community_search_author" code="community.search.author"/>
<spring:message var="msg_community_search_comment" code="community.search.comment"/>
<spring:message var="msg_community_write" code="community.write"/>
<spring:message var="msg_community_sort_latest" code="community.sort.latest"/>
<spring:message var="msg_community_sort_popular" code="community.sort.popular"/>
<spring:message var="msg_community_sort_views" code="community.sort.views"/>
<spring:message var="msg_community_total" code="community.total"/>
<spring:message var="msg_community_search_result" code="community.search.result"/>
<spring:message var="msg_community_search_clear" code="community.search.clear"/>
<spring:message var="msg_community_latest_title" code="community.latest.title"/>
<spring:message var="msg_community_admin_selectAll" code="community.admin.selectAll"/>
<spring:message var="msg_community_admin_selected" code="community.admin.selected"/>
<spring:message var="msg_community_admin_delete" code="community.admin.delete"/>
<spring:message var="msg_community_admin_block" code="community.admin.block"/>
<spring:message var="msg_community_admin_block_user" code="community.admin.block.user"/>
<spring:message var="msg_community_admin_block_ip" code="community.admin.block.ip"/>
<spring:message var="msg_community_admin_block_both" code="community.admin.block.both"/>
<spring:message var="msg_community_admin_blockDelete" code="community.admin.blockDelete"/>
<spring:message var="msg_community_admin_blockDelete_user" code="community.admin.blockDelete.user"/>
<spring:message var="msg_community_admin_blockDelete_ip" code="community.admin.blockDelete.ip"/>
<spring:message var="msg_community_admin_blockDelete_both" code="community.admin.blockDelete.both"/>
<spring:message var="msg_community_empty_search" code="community.empty.search"/>
<spring:message var="msg_community_empty_default" code="community.empty.default"/>
<spring:message var="msg_community_badge_ai" code="community.badge.ai"/>
<spring:message var="msg_community_badge_report" code="community.badge.report"/>
<spring:message var="msg_community_badge_post" code="community.badge.post"/>
<spring:message var="msg_community_badge_user" code="community.badge.user"/>
<spring:message var="msg_community_admin_clearBlur" code="community.admin.clearBlur"/>
<%--
  커뮤니티 목록 페이지
  Controller: GET /community/list
  model 필요:
    - postList    : List<CommunityPostDto>
    - totalCount  : int
    - currentPage : int
    - totalPage   : int
  파라미터:
    - region  : all/asia/europe/africa/north_america/south_america/oceania/etc (기본값: all)
    - type    : all/review/photo/tip/question (기본값: all)
    - sort    : latest/popular/views (기본값: latest)
    - keyword : 검색어 - 태그+제목+본문 동시 검색 (기본값: 없음)
    - page    : 페이지 번호 (기본값: 1)
--%>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<c:set var="pageCSS" value="community/community.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<%-- 페이지 헤더 --%>
<div class="comm-ph">
    <div class="si">
        <div class="comm-ph-top">
            <div>
                <h1><a href="${pageContext.request.contextPath}/community/list"
                       onclick="sessionStorage.removeItem('todayPopularClosed')"
                       style="color:inherit;text-decoration:none;cursor:pointer;">${msg_community_title}</a></h1>
                <p class="comm-sub">${msg_community_subtitle}</p>
            </div>
        </div>

        <%-- 오늘 인기 여행 이야기 섹션 --%>
        <c:if test="${not empty popularList}">
            <div class="comm-section-title comm-section-title-today">
                ${msg_community_today_title}
                <button class="comm-section-toggle" id="todayToggleBtn" onclick="toggleTodaySection()">${msg_community_today_close}</button>
            </div>
            <div id="todayPopularGrid">
                <div class="comm-carousel-outer">
                    <button class="comm-carousel-btn comm-carousel-prev" id="todayCarouselPrev">&#8249;</button>
                    <div class="comm-carousel-vp">
                        <div class="comm-carousel-track" id="todayCarouselTrack">
                            <c:forEach var="post" items="${popularList}">
                                <c:set var="isBlocked"    value="${post.postStatus eq 'BLOCKED' or post.accountStatus eq 'BLOCKED'}"/>
                                <c:set var="isReportOrAi" value="${post.reportCount >= reportThreshold or post.aiFlagged}"/>
                                <c:if test="${(not isBlocked) or isReportOrAi or isAdminMode}">
                                <c:set var="isBlurred" value="${isReportOrAi and !isAdminMode}"/>
                                <div class="comm-today-card ${isBlurred ? 'report-blurred-wrap' : ''}" data-id="${post.postId}">
                                    <div class="comm-today-card-iw ${isBlurred ? 'report-blurred' : ''}">
                                        <c:choose>
                                            <c:when test="${not empty post.thumbUrl}">
                                                <c:choose>
                                                    <c:when test="${fn:startsWith(post.thumbUrl, 'http')}">
                                                        <img class="comm-today-card-img" src="${post.thumbUrl}" alt="${post.title}" loading="lazy">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img class="comm-today-card-img" src="${pageContext.request.contextPath}${post.thumbUrl}" alt="${post.title}" loading="lazy">
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="comm-today-card-img comm-today-card-noimg">✈️</div>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="post-type-badge type-${post.postType}">
                                            <c:choose>
                                                <c:when test="${post.postType eq 'review'}">${msg_community_type_review}</c:when>
                                                <c:when test="${post.postType eq 'photo'}">${msg_community_type_photo}</c:when>
                                                <c:when test="${post.postType eq 'tip'}">${msg_community_type_tip}</c:when>
                                                <c:when test="${post.postType eq 'question'}">${msg_community_type_question}</c:when>
                                            </c:choose>
                                        </span>
                                        <c:if test="${post.postType eq 'tip' and not empty post.tipCategory}">
                                            <span class="post-type-badge type-tip-sub ${post.tipCategory}">
                                                <c:choose>
                                                    <c:when test="${post.tipCategory eq 'transport'}">${msg_community_tip_transport}</c:when>
                                                    <c:when test="${post.tipCategory eq 'accom'}">${msg_community_tip_accom}</c:when>
                                                    <c:when test="${post.tipCategory eq 'food'}">${msg_community_tip_food}</c:when>
                                                    <c:when test="${post.tipCategory eq 'money'}">${msg_community_tip_money}</c:when>
                                                    <c:when test="${post.tipCategory eq 'safety'}">${msg_community_tip_safety}</c:when>
                                                    <c:otherwise>${msg_community_tip_etc}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:if>
                                        <c:if test="${post.postType eq 'question'}">
                                            <c:choose>
                                                <c:when test="${post.isSolved}">
                                                    <span class="post-type-badge type-question-sub solved">${msg_community_question_solved}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="post-type-badge type-question-sub unsolved">${msg_community_question_unsolved}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </div>
                                    <div class="comm-today-card-body ${isBlurred ? 'report-blurred' : ''}">
                                        <div class="comm-today-card-title">${post.title}</div>
                                        <div class="comm-today-card-footer">
                                            <span class="comm-today-card-author tt-nickname ${post.nicknameColorClass} ${post.nicknameEffectClass}">${post.nickname}</span>
                                            <c:if test="${not empty post.profileBadgeLabel}">
                                                <span class="tt-profile-badge ${post.profileBadgeClass}">${post.profileBadgeLabel}</span>
                                            </c:if>
                                            <span class="comm-today-card-stats">
                                                &#10084; ${post.likeCount} &nbsp; &#128172; ${post.commentCount}
                                            </span>
                                        </div>
                                    </div>
                                    <c:if test="${isBlurred}">
                                        <div class="report-blurred-overlay">
                                            <c:choose>
                                                <c:when test="${post.aiFlagged}">${msg_community_blocked_ai}</c:when>
                                                <c:otherwise>${msg_community_blocked_report}</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:if>
                                </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <button class="comm-carousel-btn comm-carousel-next" id="todayCarouselNext">&#8250;</button>
                </div>
            </div>
        </c:if>

        <%-- 지역 탭 --%>
        <div class="region-tabs">
            <a href="${pageContext.request.contextPath}/community/list?region=all&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${empty param.region or param.region eq 'all' ? 'active' : ''}">
                ${msg_community_region_all}
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=asia&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'asia' ? 'active' : ''}">
                ${msg_community_region_asia}
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=europe&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'europe' ? 'active' : ''}">
                ${msg_community_region_europe}
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=africa&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'africa' ? 'active' : ''}">
                ${msg_community_region_africa}
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=north_america&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'north_america' ? 'active' : ''}">
                ${msg_community_region_northAmerica}
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=south_america&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'south_america' ? 'active' : ''}">
                ${msg_community_region_southAmerica}
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=oceania&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'oceania' ? 'active' : ''}">
                ${msg_community_region_oceania}
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=etc&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'etc' ? 'active' : ''}">
                ${msg_community_region_etc}
            </a>
        </div>

        <%-- 검색창 + 글쓰기 버튼 --%>
        <div class="comm-search-wrap">
            <div class="comm-search-row">
                <form action="${pageContext.request.contextPath}/community/list" method="get">
                    <input type="hidden" name="region" value="${param.region}">
                    <input type="hidden" name="type" value="${param.type}">
                    <input type="hidden" name="sort" value="${param.sort}">
                    <div class="comm-search-box">
                        <select name="searchType" class="comm-search-select">
                            <option value="all"    ${empty param.searchType or param.searchType eq 'all'     ? 'selected' : ''}>${msg_community_search_all}</option>
                            <option value="title"   ${param.searchType eq 'title'   ? 'selected' : ''}>${msg_community_search_title}</option>
                            <option value="content" ${param.searchType eq 'content' ? 'selected' : ''}>${msg_community_search_content}</option>
                            <option value="tag"     ${param.searchType eq 'tag'     ? 'selected' : ''}>${msg_community_search_tag}</option>
                            <option value="author"  ${param.searchType eq 'author'  ? 'selected' : ''}>${msg_community_search_author}</option>
                            <option value="comment" ${param.searchType eq 'comment' ? 'selected' : ''}>${msg_community_search_comment}</option>
                        </select>
                        <span class="comm-search-divider"></span>
                        <input type="text" name="keyword" class="comm-search-input"
                               value="${param.keyword}"
                               placeholder="${msg_community_search_placeholder}">
                        <button type="submit" class="comm-search-btn">&#128269;</button>
                    </div>
                </form>
                <button class="btn-write"
                        onclick="location.href='${pageContext.request.contextPath}/community/write'">
                    &#43; ${msg_community_write}
                </button>
            </div>
        </div>

    </div>
</div>

<%-- 상단 배너 광고 --%>
<c:choose>
    <c:when test="${not empty currentAd}">
        <div class="comm-ad-banner" data-ad-id="${currentAd.adId}">
            <c:choose>
                <c:when test="${empty currentAd.linkType or currentAd.linkType ne 'NONE'}">
                    <a href="${pageContext.request.contextPath}/ad/${currentAd.adId}/click" class="comm-ad-link" target="_blank" rel="noopener sponsored">
                        <img src="${currentAd.imageUrl}" alt="${currentAd.title}" class="comm-ad-image"/>
                    </a>
                </c:when>
                <c:otherwise>
                    <img src="${currentAd.imageUrl}" alt="${currentAd.title}" class="comm-ad-image"/>
                </c:otherwise>
            </c:choose>
        </div>
    </c:when>
    <c:otherwise>
        <div class="comm-ad-banner">
            <div class="comm-ad-banner-inner">
                <span class="comm-ad-label">AD</span>
                <span class="comm-ad-size">970 × 90</span>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%-- 본문 --%>
<div class="comm-body-wrap">

    <%-- 유형 필터 + 정렬 바 --%>
    <div class="comm-filter-bar">
        <div class="type-filters">
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=all&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${empty param.type or param.type eq 'all' ? 'active' : ''}">${msg_community_region_all}</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=review&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'review' ? 'active' : ''}">&#128172; ${msg_community_type_review}</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=photo&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'photo' ? 'active' : ''}">&#128247; ${msg_community_type_photo}</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=tip&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'tip' ? 'active' : ''}">&#128161; ${msg_community_type_tip}</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=question&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'question' ? 'active' : ''}">&#10067; ${msg_community_type_question}</a>
        </div>
        <div class="sort-area">
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=latest&searchType=${param.searchType}&keyword=${param.keyword}"
               class="sort-btn ${empty param.sort or param.sort eq 'latest' ? 'active' : ''}">${msg_community_sort_latest}</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=popular&searchType=${param.searchType}&keyword=${param.keyword}"
               class="sort-btn ${param.sort eq 'popular' ? 'active' : ''}">${msg_community_sort_popular}</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=views&searchType=${param.searchType}&keyword=${param.keyword}"
               class="sort-btn ${param.sort eq 'views' ? 'active' : ''}">${msg_community_sort_views}</a>
            <span class="total-count">${msg_community_total}</span>
        </div>
    </div>

    <%-- 검색 결과 표시 --%>
    <c:if test="${not empty param.keyword}">
        <div class="search-result-bar">
            <span>${msg_community_search_result}</span>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=${param.sort}"
               class="search-clear-btn">&#10005; ${msg_community_search_clear}</a>
        </div>
    </c:if>

    <%-- 최신 여행 이야기 섹션 타이틀 --%>
    <div class="comm-section-title">${msg_community_latest_title}</div>

    <%-- 어드민 일괄 처리 툴바 --%>
    <c:if test="${isAdminMode}">
        <div class="comm-admin-toolbar" id="adminToolbar">
            <label class="comm-admin-chk-all">
                <input type="checkbox" id="chkAll"> ${msg_community_admin_selectAll}
            </label>
            <span class="comm-admin-selected-count" id="selectedCount">${msg_community_admin_selected}</span>
            <div class="comm-admin-actions">
                <button class="comm-admin-btn btn-delete" onclick="doBulkAction('delete')">${msg_community_admin_delete}</button>
                <div class="comm-admin-dropdown">
                    <button class="comm-admin-btn btn-block-user">${msg_community_admin_block} ▾</button>
                    <div class="comm-admin-dropdown-menu">
                        <button onclick="doBulkAction('blockUser')">${msg_community_admin_block_user}</button>
                        <button onclick="doBulkAction('blockIp')">${msg_community_admin_block_ip}</button>
                        <button onclick="doBulkAction('blockBoth')">${msg_community_admin_block_both}</button>
                    </div>
                </div>
                <div class="comm-admin-dropdown">
                    <button class="comm-admin-btn btn-block-delete">${msg_community_admin_blockDelete} ▾</button>
                    <div class="comm-admin-dropdown-menu">
                        <button onclick="doBulkAction('blockUserAndDelete')">${msg_community_admin_blockDelete_user}</button>
                        <button onclick="doBulkAction('blockIpAndDelete')">${msg_community_admin_blockDelete_ip}</button>
                        <button onclick="doBulkAction('blockAndDelete')">${msg_community_admin_blockDelete_both}</button>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <%--
      게시글 목록
      CommunityPostDto 필드:
        postId, userIdx, nickname, title, content,
        region, postType, postStatus,
        viewCount, likeCount, commentCount,
        createdAt, thumbUrl
    --%>
    <div class="comm-grid">
        <c:choose>
            <c:when test="${empty postList}">
                <div class="empty-state">
                    <div class="empty-icon">&#9992;</div>
                    <c:choose>
                        <c:when test="${not empty param.keyword}">
                            <p>${msg_community_empty_search}</p>
                        </c:when>
                        <c:otherwise>
                            <p>${msg_community_empty_default}</p>
                        </c:otherwise>
                    </c:choose>
                    <button class="btn-write"
                            onclick="location.href='${pageContext.request.contextPath}/community/write'">
                        ${msg_community_write}
                    </button>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="post" items="${postList}">
                    <c:if test="${!(post.accountStatus eq 'BLOCKED' or post.postStatus eq 'BLOCKED') or isAdminMode}">
                        <c:set var="isBlurred" value="${(post.reportCount >= reportThreshold or post.aiFlagged) and !isAdminMode}"/>
                        <div class="post-card-wrap ${isBlurred ? 'report-blurred-wrap' : ''}"
                             data-id="${post.postId}">
                            <c:if test="${isAdminMode}">
                                <input type="checkbox" class="comm-admin-chk" data-id="${post.postId}"
                                       onclick="event.stopPropagation()">
                                <button class="post-admin-delete-btn" onclick="adminDeletePost(event, ${post.postId})">
                                    ✕
                                </button>
                            </c:if>
                            <div class="post-card ${isBlurred ? 'report-blurred' : ''}">
                                <%-- 이미지 경로 보정 (http* 이면 그대로, 아니면 contextPath prefix) --%>
                                <c:set var="thumb1" value="${fn:startsWith(post.thumbUrl,  'http') ? post.thumbUrl  : (empty post.thumbUrl  ? '' : pageContext.request.contextPath.concat(post.thumbUrl))}"/>
                                <c:set var="thumb2" value="${fn:startsWith(post.thumbUrl2, 'http') ? post.thumbUrl2 : (empty post.thumbUrl2 ? '' : pageContext.request.contextPath.concat(post.thumbUrl2))}"/>
                                <c:set var="thumb3" value="${fn:startsWith(post.thumbUrl3, 'http') ? post.thumbUrl3 : (empty post.thumbUrl3 ? '' : pageContext.request.contextPath.concat(post.thumbUrl3))}"/>
                                <c:set var="isPhotoGallery" value="${post.postType eq 'photo' and not empty post.thumbUrl2 and not empty post.thumbUrl3}"/>

                                <div class="post-card-img-wrap ${isPhotoGallery ? 'post-card-img-gallery' : ''}">
                                    <c:choose>
                                        <c:when test="${isPhotoGallery}">
                                            <%-- photo 유형 3장 갤러리: 좌측 크게 1장 + 우측 상/하 2장 --%>
                                            <img class="post-card-img gallery-main" src="${thumb1}" alt="${post.title}" loading="lazy">
                                            <img class="post-card-img gallery-sub gallery-sub-top"    src="${thumb2}" alt="" loading="lazy">
                                            <img class="post-card-img gallery-sub gallery-sub-bottom" src="${thumb3}" alt="" loading="lazy">
                                        </c:when>
                                        <c:when test="${not empty post.thumbUrl}">
                                            <img class="post-card-img" src="${thumb1}" alt="${post.title}" loading="lazy">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="post-card-img"
                                                 style="background:var(--gray-100);display:flex;align-items:center;justify-content:center;font-size:48px;">
                                                ✈️
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="post-type-badge type-${post.postType}">
    <c:choose>
        <c:when test="${post.postType eq 'review'}">${msg_community_type_review}</c:when>
        <c:when test="${post.postType eq 'photo'}">${msg_community_type_photo}</c:when>
        <c:when test="${post.postType eq 'tip'}">${msg_community_type_tip}</c:when>
        <c:when test="${post.postType eq 'question'}">${msg_community_type_question}</c:when>
    </c:choose>
</span>
<c:if test="${post.postType eq 'tip' and not empty post.tipCategory}">
    <span class="post-type-badge type-tip-sub ${post.tipCategory}">
        <c:choose>
            <c:when test="${post.tipCategory eq 'transport'}">${msg_community_tip_transport}</c:when>
            <c:when test="${post.tipCategory eq 'accom'}">${msg_community_tip_accom}</c:when>
            <c:when test="${post.tipCategory eq 'food'}">${msg_community_tip_food}</c:when>
            <c:when test="${post.tipCategory eq 'money'}">${msg_community_tip_money}</c:when>
            <c:when test="${post.tipCategory eq 'safety'}">${msg_community_tip_safety}</c:when>
            <c:otherwise>${msg_community_tip_etc}</c:otherwise>
        </c:choose>
    </span>
</c:if>
<c:if test="${post.postType eq 'question'}">
    <c:choose>
        <c:when test="${post.isSolved}">
            <span class="post-type-badge type-question-sub solved">${msg_community_question_solved}</span>
        </c:when>
        <c:otherwise>
            <span class="post-type-badge type-question-sub unsolved">${msg_community_question_unsolved}</span>
        </c:otherwise>
    </c:choose>
</c:if>
                                </div>
                                <div class="post-card-body">
                                    <div class="post-card-author">
                                        <div class="post-av">
                                            <c:choose>
                                                <c:when test="${not empty post.nickname}">${fn:substring(post.nickname, 0, 1)}</c:when>
                                                <c:otherwise>ME</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <span class="post-author-name tt-nickname ${post.nicknameColorClass} ${post.nicknameEffectClass}">${post.nickname}</span>
                                        <c:if test="${not empty post.profileBadgeLabel}">
                                            <span class="tt-profile-badge ${post.profileBadgeClass}">${post.profileBadgeLabel}</span>
                                        </c:if>
                                        <span class="post-date">
              <fmt:formatDate value="${post.createdAtDate}" pattern="yyyy-MM-dd"/>
            </span>
                                    </div>
                                    <div class="post-card-title">${post.title}</div>
                                    <div class="post-card-content">${post.content}</div>
                                    <div class="post-card-footer">
                                        <span class="post-stat like-stat">&#10084; ${post.likeCount}</span>
                                        <span class="post-stat">&#128172; ${post.commentCount}</span>
                                        <span class="post-stat">&#128065; ${post.viewCount}</span>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${isBlurred}">
                                <div class="report-blurred-overlay" onclick="removeReportBlur(this)">
                                    <c:choose>
                                        <c:when test="${post.aiFlagged}">${msg_community_blocked_ai}</c:when>
                                        <c:otherwise>${msg_community_blocked_report}</c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                            <c:if test="${isAdminMode}">
                                <c:choose>
                                    <c:when test="${post.aiFlagged}">
                                        <span class="blocked-badge">${msg_community_badge_ai}</span>
                                    </c:when>
                                    <c:when test="${post.postStatus eq 'ACTIVE' and post.reportCount >= reportThreshold}">
                                        <span class="blocked-badge">${msg_community_badge_report}</span>
                                    </c:when>
                                    <c:when test="${post.postStatus eq 'BLOCKED'}">
                                        <span class="blocked-badge">${msg_community_badge_post}</span>
                                    </c:when>
                                    <c:when test="${post.accountStatus eq 'BLOCKED'}">
                                        <span class="blocked-badge">${msg_community_badge_user}</span>
                                    </c:when>
                                </c:choose>
                                <c:if test="${post.aiFlagged or post.reportCount >= reportThreshold}">
                                    <button class="post-admin-clear-blur-btn" data-id="${post.postId}"
                                            onclick="adminClearPostBlur(event, ${post.postId})">
                                        ${msg_community_admin_clearBlur}
                                    </button>
                                </c:if>
                            </c:if>
                        </div>
                    </c:if>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 페이지네이션 --%>
    <c:if test="${totalPage > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}&page=${currentPage - 1}"
                   class="page-btn">&#8249;</a>
            </c:if>
            <c:forEach begin="1" end="${totalPage}" var="p">
                <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}&page=${p}"
                   class="page-btn ${p eq currentPage ? 'active' : ''}">${p}</a>
            </c:forEach>
            <c:if test="${currentPage < totalPage}">
                <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}&page=${currentPage + 1}"
                   class="page-btn">&#8250;</a>
            </c:if>
        </div>
    </c:if>

    <%-- 하단 검색바 + 글쓰기 버튼 --%>
    <div class="comm-bottom-search">
        <div class="comm-search-row">
            <form action="${pageContext.request.contextPath}/community/list" method="get">
                <input type="hidden" name="region" value="${param.region}">
                <input type="hidden" name="type" value="${param.type}">
                <input type="hidden" name="sort" value="${param.sort}">
                <div class="comm-search-box">
                    <select name="searchType" class="comm-search-select">
                        <option value="all"    ${empty param.searchType or param.searchType eq 'all'     ? 'selected' : ''}>${msg_community_search_all}</option>
                        <option value="title"   ${param.searchType eq 'title'   ? 'selected' : ''}>${msg_community_search_title}</option>
                        <option value="content" ${param.searchType eq 'content' ? 'selected' : ''}>${msg_community_search_content}</option>
                        <option value="tag"     ${param.searchType eq 'tag'     ? 'selected' : ''}>${msg_community_search_tag}</option>
                        <option value="author"  ${param.searchType eq 'author'  ? 'selected' : ''}>${msg_community_search_author}</option>
                        <option value="comment" ${param.searchType eq 'comment' ? 'selected' : ''}>${msg_community_search_comment}</option>
                    </select>
                    <span class="comm-search-divider"></span>
                    <input type="text" name="keyword" class="comm-search-input"
                           value="${param.keyword}"
                           placeholder="${msg_community_search_placeholder}">
                    <button type="submit" class="comm-search-btn">&#128269;</button>
                </div>
            </form>
            <button class="btn-write"
                    onclick="location.href='${pageContext.request.contextPath}/community/write'">
                &#43; ${msg_community_write}
            </button>
        </div>
    </div>

</div>

<script>
    /* ===== 오늘 인기 섹션 토글 ===== */
    var STORAGE_KEY = 'todayPopularClosed';

    function toggleTodaySection() {
        var grid = document.getElementById('todayPopularGrid');
        var btn  = document.getElementById('todayToggleBtn');
        if (!grid) return;
        if (grid.style.display === 'none') {
            grid.style.display = '';
            btn.textContent = '${msg_community_today_close_js}';
            sessionStorage.removeItem(STORAGE_KEY);
        } else {
            grid.style.display = 'none';
            btn.textContent = '${msg_community_today_open_js}';
            sessionStorage.setItem(STORAGE_KEY, '1');
        }
    }

    (function () {
        var grid = document.getElementById('todayPopularGrid');
        var btn  = document.getElementById('todayToggleBtn');
        if (sessionStorage.getItem(STORAGE_KEY) === '1') {
            if (grid) grid.style.display = 'none';
            if (btn)  btn.textContent = '${msg_community_today_open_js}';
        }
    })();

    /* ===== 오늘 인기 캐러셀 ===== */
    window.addEventListener('load', function () {
        var track   = document.getElementById('todayCarouselTrack');
        var prevBtn = document.getElementById('todayCarouselPrev');
        var nextBtn = document.getElementById('todayCarouselNext');
        if (!track || !track.children.length) return;

        var cards   = track.children;
        var total   = cards.length;
        var visible = 3;
        var gap     = 16;
        var current = 0;
        var autoTimer;

        function setCardWidths() {
            var vpWidth = track.parentElement.offsetWidth;
            if (!vpWidth) return;
            var w = (vpWidth - gap * (visible - 1)) / visible;
            Array.from(cards).forEach(function (c) { c.style.width = w + 'px'; });
            track.style.gap = gap + 'px';
        }

        function cardStep() {
            return cards[0].getBoundingClientRect().width + gap;
        }

        function goTo(idx) {
            current = Math.max(0, Math.min(idx, total - visible));
            track.style.transform = 'translateX(-' + (current * cardStep()) + 'px)';
        }

        function next() {
            if (current >= total - visible) {
                track.style.transition = 'none';
                current = 0;
                track.style.transform = 'translateX(0)';
                track.getBoundingClientRect();
                track.style.transition = '';
            } else {
                goTo(current + 1);
            }
        }

        function prev() {
            if (current <= 0) {
                track.style.transition = 'none';
                current = total - visible;
                track.style.transform = 'translateX(-' + (current * cardStep()) + 'px)';
                track.getBoundingClientRect();
                track.style.transition = '';
            } else {
                goTo(current - 1);
            }
        }

        function startAuto() { autoTimer = setInterval(next, 2500); }
        function stopAuto()  { clearInterval(autoTimer); }

        nextBtn.addEventListener('click', function () { stopAuto(); next(); startAuto(); });
        prevBtn.addEventListener('click', function () { stopAuto(); prev(); startAuto(); });

        track.querySelectorAll('.comm-today-card').forEach(function (card) {
            card.addEventListener('click', function () {
                if (this.classList.contains('report-blurred-wrap')) {
                    this.classList.remove('report-blurred-wrap');
                    this.querySelectorAll('.report-blurred').forEach(function (el) { el.classList.remove('report-blurred'); });
                    var ov = this.querySelector('.report-blurred-overlay');
                    if (ov) ov.remove();
                    return;
                }
                location.href = '${pageContext.request.contextPath}/community/' + this.getAttribute('data-id');
            });
        });

        window.addEventListener('resize', function () {
            stopAuto(); setCardWidths(); goTo(current); startAuto();
        });

        setCardWidths();
        startAuto();
    });

    document.querySelectorAll('.post-card-wrap[data-id]').forEach(function (wrap) {
        wrap.style.cursor = 'pointer';
        wrap.addEventListener('click', function () {
            location.href = '${pageContext.request.contextPath}/community/' + this.getAttribute('data-id');
        });
    });

    function adminDeletePost(event, postId) {
        event.stopPropagation();
        if (!confirm('${msg_community_admin_delete_confirm_js}')) return;
        fetch('${pageContext.request.contextPath}/community/' + postId, {
            method: 'DELETE',
            headers: {'X-Requested-With': 'XMLHttpRequest'}
        })
            .then(function (res) {
                if (res.ok) location.reload();
                else alert('${msg_community_admin_delete_fail_js}');
            });
    }

    function removeReportBlur(overlay) {
        var wrap = overlay.closest('.report-blurred-wrap');
        wrap.classList.remove('report-blurred-wrap');
        overlay.closest('.post-card').classList.remove('report-blurred');
        overlay.remove();
    }

    function adminClearPostBlur(event, postId) {
        event.stopPropagation();
        if (!confirm('${msg_community_admin_clearBlur_confirm_js}')) return;
        fetch('${pageContext.request.contextPath}/community/' + postId + '/clear-blur', {
            method: 'POST',
            headers: {'X-Requested-With': 'XMLHttpRequest'}
        })
            .then(function (res) {
                if (res.ok) location.reload();
                else alert('${msg_community_admin_clearBlur_fail_js}');
            });
    }

    /* ===== 어드민 일괄 처리 ===== */
    (function () {
        var chkAll      = document.getElementById('chkAll');
        var countLabel  = document.getElementById('selectedCount');
        if (!chkAll) return;

        function getChecked() {
            return Array.from(document.querySelectorAll('.comm-admin-chk:checked'));
        }

        function updateCount() {
            var n = getChecked().length;
            countLabel.textContent = '${msg_community_admin_selected_js}'.replace('__COUNT__', n);
        }

        /* 전체선택 */
        chkAll.addEventListener('change', function () {
            document.querySelectorAll('.comm-admin-chk').forEach(function (c) {
                c.checked = chkAll.checked;
            });
            updateCount();
        });

        /* 개별 체크 */
        document.addEventListener('change', function (e) {
            if (e.target.classList.contains('comm-admin-chk')) {
                if (!e.target.checked) chkAll.checked = false;
                updateCount();
            }
        });

    })();

    window.doBulkAction = function (action) {
        var checked = Array.from(document.querySelectorAll('.comm-admin-chk:checked'));
            if (checked.length === 0) { alert('${msg_community_admin_noneSelected_js}'); return; }

        var labels = {
                'delete':              '${msg_community_admin_delete_js}',
                'blockUser':           '${msg_community_admin_block_user_js}',
                'blockIp':             '${msg_community_admin_block_ip_js}',
                'blockBoth':           '${msg_community_admin_block_both_js}',
                'blockUserAndDelete':  '${msg_community_admin_blockDelete_user_js}',
                'blockIpAndDelete':    '${msg_community_admin_blockDelete_ip_js}',
                'blockAndDelete':      '${msg_community_admin_blockDelete_both_js}'
            };
        var confirmMessage = '${msg_community_detail_bulk_posts_confirm_js}'
            .replace('__COUNT__', checked.length)
            .replace('__ACTION__', labels[action]);
        if (!confirm(confirmMessage)) return;

        var postIds = checked.map(function (c) { return c.getAttribute('data-id'); });
        var params  = new URLSearchParams();
        params.append('action', action);
        postIds.forEach(function (id) { params.append('postIds', id); });

        fetch('${pageContext.request.contextPath}/community/admin/bulk', {
            method:  'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
            body:    params.toString()
        })
        .then(function (res) { return res.json(); })
        .then(function (data) {
            if (data.success) {
                alert('${msg_community_detail_bulk_done_js}');
                location.reload();
            } else {
                alert('${msg_community_detail_bulk_fail_js}'.replace('__MSG__', data.message || ''));
            }
        })
        .catch(function () { alert('${msg_community_detail_request_fail_js}'); });
    };
</script>

<script>window.AD_TRACKER_CTX = '${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/resources/js/common/ad-impression.js" defer></script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
