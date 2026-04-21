<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
<html lang="ko">
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
                       style="color:inherit;text-decoration:none;cursor:pointer;"><spring:message code="community.title"/></a></h1>
                <p class="comm-sub"><spring:message code="community.subtitle"/></p>
            </div>
        </div>

        <%-- 오늘 인기 여행 이야기 섹션 --%>
        <c:if test="${not empty popularList}">
            <div class="comm-section-title comm-section-title-today">
                <spring:message code="community.today.title"/>
                <button class="comm-section-toggle" id="todayToggleBtn" onclick="toggleTodaySection()"><spring:message code="community.today.close"/></button>
            </div>
            <div id="todayPopularGrid">
                <div class="comm-carousel-outer">
                    <button class="comm-carousel-btn comm-carousel-prev" id="todayCarouselPrev">&#8249;</button>
                    <div class="comm-carousel-vp">
                        <div class="comm-carousel-track" id="todayCarouselTrack">
                            <c:forEach var="post" items="${popularList}">
                                <c:set var="isBlocked"    value="${post.postStatus eq 'BLOCKED' or post.accountStatus eq 'BLOCKED'}"/>
                                <c:set var="isReportOrAi" value="${post.reportCount >= 3 or post.aiFlagged}"/>
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
                                                <c:when test="${post.postType eq 'review'}"><spring:message code="community.type.review"/></c:when>
                                                <c:when test="${post.postType eq 'photo'}"><spring:message code="community.type.photo"/></c:when>
                                                <c:when test="${post.postType eq 'tip'}"><spring:message code="community.type.tip"/></c:when>
                                                <c:when test="${post.postType eq 'question'}"><spring:message code="community.type.question"/></c:when>
                                            </c:choose>
                                        </span>
                                        <c:if test="${post.postType eq 'tip' and not empty post.tipCategory}">
                                            <span class="post-type-badge type-tip-sub ${post.tipCategory}">
                                                <c:choose>
                                                    <c:when test="${post.tipCategory eq 'transport'}"><spring:message code="community.tip.transport"/></c:when>
                                                    <c:when test="${post.tipCategory eq 'accom'}"><spring:message code="community.tip.accom"/></c:when>
                                                    <c:when test="${post.tipCategory eq 'food'}"><spring:message code="community.tip.food"/></c:when>
                                                    <c:when test="${post.tipCategory eq 'money'}"><spring:message code="community.tip.money"/></c:when>
                                                    <c:when test="${post.tipCategory eq 'safety'}"><spring:message code="community.tip.safety"/></c:when>
                                                    <c:otherwise><spring:message code="community.tip.etc"/></c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:if>
                                        <c:if test="${post.postType eq 'question'}">
                                            <c:choose>
                                                <c:when test="${post.isSolved}">
                                                    <span class="post-type-badge type-question-sub solved"><spring:message code="community.question.solved"/></span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="post-type-badge type-question-sub unsolved"><spring:message code="community.question.unsolved"/></span>
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
                                                <c:when test="${post.aiFlagged}"><spring:message code="community.blocked.ai"/></c:when>
                                                <c:otherwise><spring:message code="community.blocked.report"/></c:otherwise>
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
                <spring:message code="community.region.all"/>
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=asia&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'asia' ? 'active' : ''}">
                <spring:message code="community.region.asia"/>
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=europe&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'europe' ? 'active' : ''}">
                <spring:message code="community.region.europe"/>
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=africa&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'africa' ? 'active' : ''}">
                <spring:message code="community.region.africa"/>
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=north_america&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'north_america' ? 'active' : ''}">
                <spring:message code="community.region.northAmerica"/>
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=south_america&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'south_america' ? 'active' : ''}">
                <spring:message code="community.region.southAmerica"/>
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=oceania&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'oceania' ? 'active' : ''}">
                <spring:message code="community.region.oceania"/>
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=etc&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'etc' ? 'active' : ''}">
                <spring:message code="community.region.etc"/>
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
                            <option value="all"    ${empty param.searchType or param.searchType eq 'all'     ? 'selected' : ''}><spring:message code="community.search.all"/></option>
                            <option value="title"   ${param.searchType eq 'title'   ? 'selected' : ''}><spring:message code="community.search.title"/></option>
                            <option value="content" ${param.searchType eq 'content' ? 'selected' : ''}><spring:message code="community.search.content"/></option>
                            <option value="tag"     ${param.searchType eq 'tag'     ? 'selected' : ''}><spring:message code="community.search.tag"/></option>
                            <option value="author"  ${param.searchType eq 'author'  ? 'selected' : ''}><spring:message code="community.search.author"/></option>
                            <option value="comment" ${param.searchType eq 'comment' ? 'selected' : ''}><spring:message code="community.search.comment"/></option>
                        </select>
                        <span class="comm-search-divider"></span>
                        <input type="text" name="keyword" class="comm-search-input"
                               value="${param.keyword}"
                               placeholder="<spring:message code="community.search.placeholder"/>">
                        <button type="submit" class="comm-search-btn">&#128269;</button>
                    </div>
                </form>
                <button class="btn-write"
                        onclick="location.href='${pageContext.request.contextPath}/community/write'">
                    &#43; <spring:message code="community.write"/>
                </button>
            </div>
        </div>

    </div>
</div>

<%-- 상단 배너 광고 --%>
<div class="comm-ad-banner">
    <div class="comm-ad-banner-inner">
        <span class="comm-ad-label">AD</span>
        <span class="comm-ad-size">970 × 90</span>
    </div>
</div>

<%-- 본문 --%>
<div class="comm-body-wrap">

    <%-- 유형 필터 + 정렬 바 --%>
    <div class="comm-filter-bar">
        <div class="type-filters">
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=all&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${empty param.type or param.type eq 'all' ? 'active' : ''}"><spring:message code="community.region.all"/></a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=review&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'review' ? 'active' : ''}">&#128172; <spring:message code="community.type.review"/></a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=photo&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'photo' ? 'active' : ''}">&#128247; <spring:message code="community.type.photo"/></a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=tip&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'tip' ? 'active' : ''}">&#128161; <spring:message code="community.type.tip"/></a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=question&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'question' ? 'active' : ''}">&#10067; <spring:message code="community.type.question"/></a>
        </div>
        <div class="sort-area">
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=latest&searchType=${param.searchType}&keyword=${param.keyword}"
               class="sort-btn ${empty param.sort or param.sort eq 'latest' ? 'active' : ''}"><spring:message code="community.sort.latest"/></a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=popular&searchType=${param.searchType}&keyword=${param.keyword}"
               class="sort-btn ${param.sort eq 'popular' ? 'active' : ''}"><spring:message code="community.sort.popular"/></a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=views&searchType=${param.searchType}&keyword=${param.keyword}"
               class="sort-btn ${param.sort eq 'views' ? 'active' : ''}"><spring:message code="community.sort.views"/></a>
            <span class="total-count"><spring:message code="community.total" arguments="${totalCount}"/></span>
        </div>
    </div>

    <%-- 검색 결과 표시 --%>
    <c:if test="${not empty param.keyword}">
        <div class="search-result-bar">
            <span><spring:message code="community.search.result" arguments="${param.keyword}"/></span>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=${param.sort}"
               class="search-clear-btn">&#10005; <spring:message code="community.search.clear"/></a>
        </div>
    </c:if>

    <%-- 최신 여행 이야기 섹션 타이틀 --%>
    <div class="comm-section-title"><spring:message code="community.latest.title"/></div>

    <%-- 어드민 일괄 처리 툴바 --%>
    <c:if test="${isAdminMode}">
        <div class="comm-admin-toolbar" id="adminToolbar">
            <label class="comm-admin-chk-all">
                <input type="checkbox" id="chkAll"> <spring:message code="community.admin.selectAll"/>
            </label>
            <span class="comm-admin-selected-count" id="selectedCount"><spring:message code="community.admin.selected" arguments="0"/></span>
            <div class="comm-admin-actions">
                <button class="comm-admin-btn btn-delete" onclick="doBulkAction('delete')"><spring:message code="community.admin.delete"/></button>
                <div class="comm-admin-dropdown">
                    <button class="comm-admin-btn btn-block-user"><spring:message code="community.admin.block"/> ▾</button>
                    <div class="comm-admin-dropdown-menu">
                        <button onclick="doBulkAction('blockUser')"><spring:message code="community.admin.block.user"/></button>
                        <button onclick="doBulkAction('blockIp')"><spring:message code="community.admin.block.ip"/></button>
                        <button onclick="doBulkAction('blockBoth')"><spring:message code="community.admin.block.both"/></button>
                    </div>
                </div>
                <div class="comm-admin-dropdown">
                    <button class="comm-admin-btn btn-block-delete"><spring:message code="community.admin.blockDelete"/> ▾</button>
                    <div class="comm-admin-dropdown-menu">
                        <button onclick="doBulkAction('blockUserAndDelete')"><spring:message code="community.admin.blockDelete.user"/></button>
                        <button onclick="doBulkAction('blockIpAndDelete')"><spring:message code="community.admin.blockDelete.ip"/></button>
                        <button onclick="doBulkAction('blockAndDelete')"><spring:message code="community.admin.blockDelete.both"/></button>
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
                            <p><spring:message code="community.empty.search" arguments="${param.keyword}"/></p>
                        </c:when>
                        <c:otherwise>
                            <p><spring:message code="community.empty.default"/></p>
                        </c:otherwise>
                    </c:choose>
                    <button class="btn-write"
                            onclick="location.href='${pageContext.request.contextPath}/community/write'">
                        <spring:message code="community.write"/>
                    </button>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="post" items="${postList}">
                    <c:if test="${!(post.accountStatus eq 'BLOCKED' or post.postStatus eq 'BLOCKED') or isAdminMode}">
                        <c:set var="isBlurred" value="${(post.reportCount >= 3 or post.aiFlagged) and !isAdminMode}"/>
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
                                <div class="post-card-img-wrap">
                                    <c:choose>
                                        <c:when test="${not empty post.thumbUrl}">
                                            <c:choose>
                                                <c:when test="${fn:startsWith(post.thumbUrl, 'http')}">
                                                    <img class="post-card-img" src="${post.thumbUrl}" alt="${post.title}" loading="lazy">
                                                </c:when>
                                                <c:otherwise>
                                                    <img class="post-card-img" src="${pageContext.request.contextPath}${post.thumbUrl}" alt="${post.title}" loading="lazy">
                                                </c:otherwise>
                                            </c:choose>
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
        <c:when test="${post.postType eq 'review'}"><spring:message code="community.type.review"/></c:when>
        <c:when test="${post.postType eq 'photo'}"><spring:message code="community.type.photo"/></c:when>
        <c:when test="${post.postType eq 'tip'}"><spring:message code="community.type.tip"/></c:when>
        <c:when test="${post.postType eq 'question'}"><spring:message code="community.type.question"/></c:when>
    </c:choose>
</span>
<c:if test="${post.postType eq 'tip' and not empty post.tipCategory}">
    <span class="post-type-badge type-tip-sub ${post.tipCategory}">
        <c:choose>
            <c:when test="${post.tipCategory eq 'transport'}"><spring:message code="community.tip.transport"/></c:when>
            <c:when test="${post.tipCategory eq 'accom'}"><spring:message code="community.tip.accom"/></c:when>
            <c:when test="${post.tipCategory eq 'food'}"><spring:message code="community.tip.food"/></c:when>
            <c:when test="${post.tipCategory eq 'money'}"><spring:message code="community.tip.money"/></c:when>
            <c:when test="${post.tipCategory eq 'safety'}"><spring:message code="community.tip.safety"/></c:when>
            <c:otherwise><spring:message code="community.tip.etc"/></c:otherwise>
        </c:choose>
    </span>
</c:if>
<c:if test="${post.postType eq 'question'}">
    <c:choose>
        <c:when test="${post.isSolved}">
            <span class="post-type-badge type-question-sub solved"><spring:message code="community.question.solved"/></span>
        </c:when>
        <c:otherwise>
            <span class="post-type-badge type-question-sub unsolved"><spring:message code="community.question.unsolved"/></span>
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
              <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/>
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
                                        <c:when test="${post.aiFlagged}"><spring:message code="community.blocked.ai"/></c:when>
                                        <c:otherwise><spring:message code="community.blocked.report"/></c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                            <c:if test="${isAdminMode}">
                                <c:choose>
                                    <c:when test="${post.aiFlagged}">
                                        <span class="blocked-badge"><spring:message code="community.badge.ai"/></span>
                                    </c:when>
                                    <c:when test="${post.postStatus eq 'ACTIVE' and post.reportCount >= 3}">
                                        <span class="blocked-badge"><spring:message code="community.badge.report"/></span>
                                    </c:when>
                                    <c:when test="${post.postStatus eq 'BLOCKED'}">
                                        <span class="blocked-badge"><spring:message code="community.badge.post"/></span>
                                    </c:when>
                                    <c:when test="${post.accountStatus eq 'BLOCKED'}">
                                        <span class="blocked-badge"><spring:message code="community.badge.user"/></span>
                                    </c:when>
                                </c:choose>
                                <c:if test="${post.aiFlagged or post.reportCount >= 3}">
                                    <button class="post-admin-clear-blur-btn" data-id="${post.postId}"
                                            onclick="adminClearPostBlur(event, ${post.postId})">
                                        <spring:message code="community.admin.clearBlur"/>
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
                        <option value="all"    ${empty param.searchType or param.searchType eq 'all'     ? 'selected' : ''}><spring:message code="community.search.all"/></option>
                        <option value="title"   ${param.searchType eq 'title'   ? 'selected' : ''}><spring:message code="community.search.title"/></option>
                        <option value="content" ${param.searchType eq 'content' ? 'selected' : ''}><spring:message code="community.search.content"/></option>
                        <option value="tag"     ${param.searchType eq 'tag'     ? 'selected' : ''}><spring:message code="community.search.tag"/></option>
                        <option value="author"  ${param.searchType eq 'author'  ? 'selected' : ''}><spring:message code="community.search.author"/></option>
                        <option value="comment" ${param.searchType eq 'comment' ? 'selected' : ''}><spring:message code="community.search.comment"/></option>
                    </select>
                    <span class="comm-search-divider"></span>
                    <input type="text" name="keyword" class="comm-search-input"
                           value="${param.keyword}"
                           placeholder="<spring:message code="community.search.placeholder"/>">
                    <button type="submit" class="comm-search-btn">&#128269;</button>
                </div>
            </form>
            <button class="btn-write"
                    onclick="location.href='${pageContext.request.contextPath}/community/write'">
                &#43; <spring:message code="community.write"/>
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
            btn.textContent = '<spring:message code="community.today.close" javaScriptEscape="true"/>';
            sessionStorage.removeItem(STORAGE_KEY);
        } else {
            grid.style.display = 'none';
            btn.textContent = '<spring:message code="community.today.open" javaScriptEscape="true"/>';
            sessionStorage.setItem(STORAGE_KEY, '1');
        }
    }

    (function () {
        var grid = document.getElementById('todayPopularGrid');
        var btn  = document.getElementById('todayToggleBtn');
        if (sessionStorage.getItem(STORAGE_KEY) === '1') {
            if (grid) grid.style.display = 'none';
            if (btn)  btn.textContent = '<spring:message code="community.today.open" javaScriptEscape="true"/>';
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
        if (!confirm('<spring:message code="community.admin.delete.confirm" javaScriptEscape="true"/>')) return;
        fetch('${pageContext.request.contextPath}/community/' + postId, {
            method: 'DELETE',
            headers: {'X-Requested-With': 'XMLHttpRequest'}
        })
            .then(function (res) {
                if (res.ok) location.reload();
                else alert('<spring:message code="community.admin.delete.fail" javaScriptEscape="true"/>');
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
        if (!confirm('<spring:message code="community.admin.clearBlur.confirm" javaScriptEscape="true"/>')) return;
        fetch('${pageContext.request.contextPath}/community/' + postId + '/clear-blur', {
            method: 'POST',
            headers: {'X-Requested-With': 'XMLHttpRequest'}
        })
            .then(function (res) {
                if (res.ok) location.reload();
                else alert('<spring:message code="community.admin.clearBlur.fail" javaScriptEscape="true"/>');
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
            countLabel.textContent = '<spring:message code="community.admin.selected" arguments="__COUNT__" javaScriptEscape="true"/>'.replace('__COUNT__', n);
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
            if (checked.length === 0) { alert('<spring:message code="community.admin.noneSelected" javaScriptEscape="true"/>'); return; }

        var labels = {
                'delete':              '<spring:message code="community.admin.delete" javaScriptEscape="true"/>',
                'blockUser':           '<spring:message code="community.admin.block.user" javaScriptEscape="true"/>',
                'blockIp':             '<spring:message code="community.admin.block.ip" javaScriptEscape="true"/>',
                'blockBoth':           '<spring:message code="community.admin.block.both" javaScriptEscape="true"/>',
                'blockUserAndDelete':  '<spring:message code="community.admin.blockDelete.user" javaScriptEscape="true"/>',
                'blockIpAndDelete':    '<spring:message code="community.admin.blockDelete.ip" javaScriptEscape="true"/>',
                'blockAndDelete':      '<spring:message code="community.admin.blockDelete.both" javaScriptEscape="true"/>'
            };
        if (!confirm(checked.length + '개 게시글에 대해 [' + labels[action] + '] 을(를) 실행하시겠습니까?')) return;

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
                alert('처리가 완료되었습니다.');
                location.reload();
            } else {
                alert('처리 중 오류가 발생했습니다: ' + (data.message || ''));
            }
        })
        .catch(function () { alert('요청 중 오류가 발생했습니다.'); });
    };
</script>


<%@ include file="../common/footer.jsp" %>
</body>
</html>
