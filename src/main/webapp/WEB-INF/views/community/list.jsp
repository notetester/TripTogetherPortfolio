<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                       style="color:inherit;text-decoration:none;cursor:pointer;">트립 모먼트</a></h1>
                <p class="comm-sub">전 세계 여행자들의 생생한 여행 이야기</p>
            </div>
        </div>

        <%-- 오늘 인기 여행 이야기 섹션 --%>
        <c:if test="${not empty todayPopularList}">
            <div class="comm-section-title comm-section-title-today">
                &#128293; 오늘 인기 여행 이야기
                <button class="comm-section-toggle" id="todayToggleBtn" onclick="toggleTodaySection()">목록 닫기</button>
            </div>
            <div id="todayPopularGrid">
                <div class="comm-carousel-outer">
                    <button class="comm-carousel-btn comm-carousel-prev" id="todayCarouselPrev">&#8249;</button>
                    <div class="comm-carousel-vp">
                        <div class="comm-carousel-track" id="todayCarouselTrack">
                            <c:forEach var="post" items="${todayPopularList}">
                                <div class="comm-today-card" data-id="${post.postId}">
                                    <div class="comm-today-card-iw">
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
                                                <c:when test="${post.postType eq 'review'}">여행후기</c:when>
                                                <c:when test="${post.postType eq 'photo'}">사진</c:when>
                                                <c:when test="${post.postType eq 'tip'}">여행팁</c:when>
                                                <c:when test="${post.postType eq 'question'}">질문</c:when>
                                            </c:choose>
                                        </span>
                                        <c:if test="${post.postType eq 'tip' and not empty post.tipCategory}">
                                            <span class="post-type-badge type-tip-sub ${post.tipCategory}">
                                                <c:choose>
                                                    <c:when test="${post.tipCategory eq 'transport'}">교통</c:when>
                                                    <c:when test="${post.tipCategory eq 'accom'}">숙소</c:when>
                                                    <c:when test="${post.tipCategory eq 'food'}">맛집</c:when>
                                                    <c:when test="${post.tipCategory eq 'money'}">환전</c:when>
                                                    <c:when test="${post.tipCategory eq 'safety'}">안전</c:when>
                                                    <c:otherwise>기타</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:if>
                                        <c:if test="${post.postType eq 'question'}">
                                            <c:choose>
                                                <c:when test="${post.isSolved}">
                                                    <span class="post-type-badge type-question-sub solved">해결됨</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="post-type-badge type-question-sub unsolved">해결중</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </div>
                                    <div class="comm-today-card-body">
                                        <div class="comm-today-card-title">${post.title}</div>
                                        <div class="comm-today-card-footer">
                                            <span class="comm-today-card-author">${post.nickname}</span>
                                            <span class="comm-today-card-stats">
                                                &#10084; ${post.likeCount} &nbsp; &#128172; ${post.commentCount}
                                            </span>
                                        </div>
                                    </div>
                                </div>
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
                전체
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=asia&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'asia' ? 'active' : ''}">
                아시아
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=europe&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'europe' ? 'active' : ''}">
                유럽
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=africa&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'africa' ? 'active' : ''}">
                아프리카
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=north_america&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'north_america' ? 'active' : ''}">
                북아메리카
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=south_america&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'south_america' ? 'active' : ''}">
                남아메리카
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=oceania&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'oceania' ? 'active' : ''}">
                오세아니아
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=etc&type=${param.type}&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'etc' ? 'active' : ''}">
                기타
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
                            <option value="all"    ${empty param.searchType or param.searchType eq 'all'     ? 'selected' : ''}>제목+내용+해시태그</option>
                            <option value="title"   ${param.searchType eq 'title'   ? 'selected' : ''}>제목</option>
                            <option value="content" ${param.searchType eq 'content' ? 'selected' : ''}>내용</option>
                            <option value="tag"     ${param.searchType eq 'tag'     ? 'selected' : ''}>해시태그</option>
                            <option value="author"  ${param.searchType eq 'author'  ? 'selected' : ''}>글쓴이</option>
                            <option value="comment" ${param.searchType eq 'comment' ? 'selected' : ''}>댓글</option>
                        </select>
                        <span class="comm-search-divider"></span>
                        <input type="text" name="keyword" class="comm-search-input"
                               value="${param.keyword}"
                               placeholder="여행 이야기를 검색해보세요">
                        <button type="submit" class="comm-search-btn">&#128269;</button>
                    </div>
                </form>
                <button class="btn-write"
                        onclick="location.href='${pageContext.request.contextPath}/community/write'">
                    &#43; 글쓰기
                </button>
            </div>
        </div>

    </div>
</div>

<%-- 본문 --%>
<div class="comm-body-wrap">

    <%-- 유형 필터 + 정렬 바 --%>
    <div class="comm-filter-bar">
        <div class="type-filters">
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=all&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${empty param.type or param.type eq 'all' ? 'active' : ''}">전체</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=review&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'review' ? 'active' : ''}">&#128172; 여행후기</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=photo&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'photo' ? 'active' : ''}">&#128247; 사진</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=tip&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'tip' ? 'active' : ''}">&#128161; 여행팁</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=question&sort=${param.sort}&searchType=${param.searchType}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'question' ? 'active' : ''}">&#10067; 질문</a>
        </div>
        <div class="sort-area">
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=latest&searchType=${param.searchType}&keyword=${param.keyword}"
               class="sort-btn ${empty param.sort or param.sort eq 'latest' ? 'active' : ''}">최신순</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=popular&searchType=${param.searchType}&keyword=${param.keyword}"
               class="sort-btn ${param.sort eq 'popular' ? 'active' : ''}">인기순</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=views&searchType=${param.searchType}&keyword=${param.keyword}"
               class="sort-btn ${param.sort eq 'views' ? 'active' : ''}">조회순</a>
            <span class="total-count">총 <strong>${totalCount}</strong>개</span>
        </div>
    </div>

    <%-- 검색 결과 표시 --%>
    <c:if test="${not empty param.keyword}">
        <div class="search-result-bar">
            <span>'<strong>${param.keyword}</strong>' 검색 결과</span>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=${param.sort}"
               class="search-clear-btn">&#10005; 검색 초기화</a>
        </div>
    </c:if>

    <%-- 최신 여행 이야기 섹션 타이틀 --%>
    <div class="comm-section-title">&#128336; 최신 여행 이야기</div>

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
                            <p>'${param.keyword}' 검색 결과가 없어요.</p>
                        </c:when>
                        <c:otherwise>
                            <p>아직 게시글이 없어요. 첫 번째 여행 이야기를 들려주세요!</p>
                        </c:otherwise>
                    </c:choose>
                    <button class="btn-write"
                            onclick="location.href='${pageContext.request.contextPath}/community/write'">
                        글쓰기
                    </button>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="post" items="${postList}">
                    <c:if test="${!(post.accountStatus eq 'BLOCKED' or (post.postStatus eq 'BLOCKED' and post.reportCount < 3)) or isAdminMode}">
                        <div class="post-card-wrap ${post.reportCount >= 3 and post.postStatus eq 'BLOCKED' and !isAdminMode ? 'report-blurred-wrap' : ''}"
                             data-id="${post.postId}">
                            <c:if test="${isAdminMode}">
                                <button class="post-admin-delete-btn" onclick="adminDeletePost(event, ${post.postId})">
                                    ✕
                                </button>
                            </c:if>
                            <div class="post-card ${post.reportCount >= 3 and post.postStatus eq 'BLOCKED' and !isAdminMode ? 'report-blurred' : ''}">
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
        <c:when test="${post.postType eq 'review'}">여행후기</c:when>
        <c:when test="${post.postType eq 'photo'}">사진</c:when>
        <c:when test="${post.postType eq 'tip'}">여행팁</c:when>
        <c:when test="${post.postType eq 'question'}">질문</c:when>
    </c:choose>
</span>
<c:if test="${post.postType eq 'tip' and not empty post.tipCategory}">
    <span class="post-type-badge type-tip-sub ${post.tipCategory}">
        <c:choose>
            <c:when test="${post.tipCategory eq 'transport'}">교통</c:when>
            <c:when test="${post.tipCategory eq 'accom'}">숙소</c:when>
            <c:when test="${post.tipCategory eq 'food'}">맛집</c:when>
            <c:when test="${post.tipCategory eq 'money'}">환전</c:when>
            <c:when test="${post.tipCategory eq 'safety'}">안전</c:when>
            <c:otherwise>기타</c:otherwise>
        </c:choose>
    </span>
</c:if>
<c:if test="${post.postType eq 'question'}">
    <c:choose>
        <c:when test="${post.isSolved}">
            <span class="post-type-badge type-question-sub solved">해결됨</span>
        </c:when>
        <c:otherwise>
            <span class="post-type-badge type-question-sub unsolved">해결중</span>
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
                                        <span class="post-author-name">${post.nickname}</span>
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
                            <c:if test="${post.reportCount >= 3 and post.postStatus eq 'BLOCKED' and !isAdminMode}">
                                <div class="report-blurred-overlay" onclick="removeReportBlur(this)">⚠️ 신고된 콘텐츠입니다. 클릭하여
                                    확인
                                </div>
                            </c:if>
                            <c:if test="${isAdminMode}">
                                <c:choose>
                                    <c:when test="${post.postStatus eq 'BLOCKED' and post.reportCount >= 3}">
                                        <span class="blocked-badge">🚨 신고에 의해 차단됨</span>
                                    </c:when>
                                    <c:when test="${post.postStatus eq 'BLOCKED'}">
                                        <span class="blocked-badge">🚫 차단된 게시글</span>
                                    </c:when>
                                    <c:when test="${post.accountStatus eq 'BLOCKED'}">
                                        <span class="blocked-badge">🚫 차단된 유저</span>
                                    </c:when>
                                </c:choose>
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
                        <option value="all"    ${empty param.searchType or param.searchType eq 'all'     ? 'selected' : ''}>제목+내용+해시태그</option>
                        <option value="title"   ${param.searchType eq 'title'   ? 'selected' : ''}>제목</option>
                        <option value="content" ${param.searchType eq 'content' ? 'selected' : ''}>내용</option>
                        <option value="tag"     ${param.searchType eq 'tag'     ? 'selected' : ''}>해시태그</option>
                        <option value="author"  ${param.searchType eq 'author'  ? 'selected' : ''}>글쓴이</option>
                        <option value="comment" ${param.searchType eq 'comment' ? 'selected' : ''}>댓글</option>
                    </select>
                    <span class="comm-search-divider"></span>
                    <input type="text" name="keyword" class="comm-search-input"
                           value="${param.keyword}"
                           placeholder="여행 이야기를 검색해보세요">
                    <button type="submit" class="comm-search-btn">&#128269;</button>
                </div>
            </form>
            <button class="btn-write"
                    onclick="location.href='${pageContext.request.contextPath}/community/write'">
                &#43; 글쓰기
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
            btn.textContent = '목록 닫기';
            sessionStorage.removeItem(STORAGE_KEY);
        } else {
            grid.style.display = 'none';
            btn.textContent = '목록 열기';
            sessionStorage.setItem(STORAGE_KEY, '1');
        }
    }

    (function () {
        var grid = document.getElementById('todayPopularGrid');
        var btn  = document.getElementById('todayToggleBtn');
        if (sessionStorage.getItem(STORAGE_KEY) === '1') {
            if (grid) grid.style.display = 'none';
            if (btn)  btn.textContent = '목록 열기';
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
        if (!confirm('이 게시글을 삭제하시겠습니까?')) return;
        fetch('${pageContext.request.contextPath}/community/' + postId, {
            method: 'DELETE',
            headers: {'X-Requested-With': 'XMLHttpRequest'}
        })
            .then(function (res) {
                if (res.ok) location.reload();
                else alert('삭제에 실패했습니다.');
            });
    }

    function removeReportBlur(overlay) {
    var wrap = overlay.closest('.report-blurred-wrap');
    wrap.classList.remove('report-blurred-wrap');
    overlay.closest('.post-card').classList.remove('report-blurred');
    overlay.remove();
}
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
