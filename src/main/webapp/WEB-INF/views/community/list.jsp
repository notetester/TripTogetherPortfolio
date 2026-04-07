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
                <h1>트립 모먼트</h1>
                <p class="comm-sub">전 세계 여행자들의 생생한 여행 이야기</p>
            </div>
            <button class="btn-write"
                    onclick="location.href='${pageContext.request.contextPath}/community/write'">
                &#43; 글쓰기
            </button>
        </div>

        <%-- 지역 탭 --%>
        <div class="region-tabs">
            <a href="${pageContext.request.contextPath}/community/list?region=all&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}"
               class="region-tab ${empty param.region or param.region eq 'all' ? 'active' : ''}">
                &#127758; 전체
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=asia&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'asia' ? 'active' : ''}">
                &#127759; 아시아
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=europe&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'europe' ? 'active' : ''}">
                &#127957; 유럽
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=africa&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'africa' ? 'active' : ''}">
                &#127758; 아프리카
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=north_america&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'north_america' ? 'active' : ''}">
                &#127482;&#127480; 북아메리카
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=south_america&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'south_america' ? 'active' : ''}">
                &#127475;&#127480; 남아메리카
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=oceania&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'oceania' ? 'active' : ''}">
                &#127944; 오세아니아
            </a>
            <a href="${pageContext.request.contextPath}/community/list?region=etc&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}"
               class="region-tab ${param.region eq 'etc' ? 'active' : ''}">
                &#127760; 기타
            </a>
        </div>

        <%-- 검색창 --%>
        <div class="comm-search-wrap">
            <form action="${pageContext.request.contextPath}/community/list" method="get">
                <input type="hidden" name="region" value="${param.region}">
                <input type="hidden" name="type" value="${param.type}">
                <input type="hidden" name="sort" value="${param.sort}">
                <div class="comm-search-box">
                    <input type="text" name="keyword" class="comm-search-input"
                           value="${param.keyword}"
                           placeholder="국가, 도시, 태그로 검색하세요">
                    <button type="submit" class="comm-search-btn">&#128269;</button>
                </div>
            </form>
        </div>

    </div>
</div>

<%-- 본문 --%>
<div class="comm-body-wrap">

    <%-- 유형 필터 + 정렬 바 --%>
    <div class="comm-filter-bar">
        <div class="type-filters">
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=all&sort=${param.sort}&keyword=${param.keyword}"
               class="type-btn ${empty param.type or param.type eq 'all' ? 'active' : ''}">전체</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=review&sort=${param.sort}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'review' ? 'active' : ''}">&#128172; 여행후기</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=photo&sort=${param.sort}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'photo' ? 'active' : ''}">&#128247; 사진</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=tip&sort=${param.sort}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'tip' ? 'active' : ''}">&#128161; 여행팁</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=question&sort=${param.sort}&keyword=${param.keyword}"
               class="type-btn ${param.type eq 'question' ? 'active' : ''}">&#10067; 질문</a>
        </div>
        <div class="sort-area">
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=latest&keyword=${param.keyword}"
               class="sort-btn ${empty param.sort or param.sort eq 'latest' ? 'active' : ''}">최신순</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=popular&keyword=${param.keyword}"
               class="sort-btn ${param.sort eq 'popular' ? 'active' : ''}">인기순</a>
            <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=views&keyword=${param.keyword}"
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
                    <c:if test="${!(post.accountStatus eq 'BLOCKED' or post.postStatus eq 'DORMANT') or isAdminMode}">
                        <div class="post-card-wrap" data-id="${post.postId}">
                            <c:if test="${isAdminMode}">
                                <button class="post-admin-delete-btn" onclick="adminDeletePost(event, ${post.postId})">
                                    ✕
                                </button>
                            </c:if>
                            <div class="post-card">
                                <div class="post-card-img-wrap">
                                    <c:choose>
                                        <c:when test="${not empty post.thumbUrl}">
                                            <img class="post-card-img"
                                                 src="${pageContext.request.contextPath}${post.thumbUrl}"
                                                 alt="${post.title}" loading="lazy">
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
                                        <c:if test="${post.postType eq 'question'}">
                                            <c:choose>
                                                <c:when test="${post.isSolved}">
                                                    <span class="post-stat" style="color:#16a34a; font-weight:700;">&#10003; 해결됨</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="post-stat" style="color:#ea580c; font-weight:700;">&#8987; 미해결</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${isAdminMode}">
                                <c:choose>
                                    <c:when test="${post.postStatus eq 'DORMANT' and post.reportCount >= 3}">
                                        <span class="blocked-badge">🚨 신고에 의해 차단됨</span>
                                    </c:when>
                                    <c:when test="${post.postStatus eq 'DORMANT'}">
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
                <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}&page=${currentPage - 1}"
                   class="page-btn">&#8249;</a>
            </c:if>
            <c:forEach begin="1" end="${totalPage}" var="p">
                <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}&page=${p}"
                   class="page-btn ${p eq currentPage ? 'active' : ''}">${p}</a>
            </c:forEach>
            <c:if test="${currentPage < totalPage}">
                <a href="${pageContext.request.contextPath}/community/list?region=${param.region}&type=${param.type}&sort=${param.sort}&keyword=${param.keyword}&page=${currentPage + 1}"
                   class="page-btn">&#8250;</a>
            </c:if>
        </div>
    </c:if>

</div>

<script>
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
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
