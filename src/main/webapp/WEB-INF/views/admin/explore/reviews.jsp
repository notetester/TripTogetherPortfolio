<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="explore"/>
<c:set var="pageTitle" value="여행지 리뷰 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-tabs" style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;">
        <a class="adm-tab" href="${pageContext.request.contextPath}/admin/explore" style="text-decoration:none;text-align:center;padding:12px 14px;">📍 여행지 관리</a>
        <a class="adm-tab active" href="${pageContext.request.contextPath}/admin/explore/reviews" style="text-decoration:none;text-align:center;padding:12px 14px;">💬 리뷰 관리</a>
    </div>

    <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:20px;">
        <div class="adm-card" style="padding:20px;"><div style="font-size:12px;color:#64748b;margin-bottom:6px;">전체 리뷰</div><div style="font-size:24px;font-weight:700;color:#34d399;">${stats.totalReviews}</div><div style="font-size:11px;color:#475569;margin-top:4px;">정상 ${stats.activeReviews}건</div></div>
        <div class="adm-card" style="padding:20px;"><div style="font-size:12px;color:#64748b;margin-bottom:6px;">차단 리뷰</div><div style="font-size:24px;font-weight:700;color:#fbbf24;">${stats.blockedReviews}</div><div style="font-size:11px;color:#475569;margin-top:4px;">review_block 기준</div></div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/explore/reviews">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div><div class="adm-filter-label">상태</div><select class="adm-select" name="reviewStatus"><option value="ALL" ${search.reviewStatus=='ALL'?'selected':''}>전체</option><option value="ACTIVE" ${search.reviewStatus=='ACTIVE'?'selected':''}>정상</option><option value="BLOCKED" ${search.reviewStatus=='BLOCKED'?'selected':''}>차단</option></select></div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">검색</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;"><option value="all" ${search.searchType=='all'?'selected':''}>전체</option><option value="name" ${search.searchType=='name'?'selected':''}>여행지명</option><option value="nickname" ${search.searchType=='nickname'?'selected':''}>닉네임</option><option value="content" ${search.searchType=='content'?'selected':''}>내용</option></select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="검색어" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;"><button class="adm-btn adm-btn-primary" type="submit">조회</button><a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore/reviews">초기화</a></div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;"><div class="adm-card-title">리뷰 목록</div><div style="font-size:12px;color:#64748b;">총 ${total}건</div></div>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;"><span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span><button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;" onclick="bulkAction('block')">선택 차단</button></div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead><tr><th style="width:36px;"><input type="checkbox" id="checkAll"></th><th style="width:70px;">리뷰 ID</th><th style="width:180px;">여행지</th><th style="width:120px;">작성자</th><th style="width:70px;">평점</th><th>내용</th><th style="width:80px;">상태</th><th style="width:90px;">등록일</th><th style="width:90px;">액션</th></tr></thead>
                <tbody>
                <c:forEach items="${list}" var="review">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${review.reviewIdx}"></td>
                        <td style="color:#64748b;font-size:12px;">#${review.reviewIdx}</td>
                        <td><a href="${pageContext.request.contextPath}/admin/explore/spots/${review.spotIdx}" class="adm-link-title" style="font-weight:600;">${fn:escapeXml(review.spotName)}</a></td>
                        <td><div style="font-size:13px;color:#7dd3fc;font-weight:600;">${fn:escapeXml(review.nickname)}</div><div style="font-size:11px;color:#64748b;">${fn:escapeXml(review.userId)}</div></td>
                        <td style="font-size:12px;color:#fbbf24;">${review.rating}/5</td>
                        <td class="adm-review-content"><c:choose><c:when test="${fn:length(review.content) > 60}">${fn:substring(review.content, 0, 60)}…</c:when><c:otherwise>${fn:escapeXml(review.content)}</c:otherwise></c:choose></td>
                        <td><span class="status-badge ${review.displayStatus}"><c:choose><c:when test="${review.displayStatus == 'ACTIVE'}">정상</c:when><c:otherwise>차단</c:otherwise></c:choose></span></td>
                        <td style="font-size:11px;color:#64748b;"><fmt:formatDate value="${review.createdAt}" pattern="yyyy.MM.dd"/></td>
                        <td><c:if test="${review.displayStatus != 'BLOCKED'}"><button class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;color:#f87171;border-color:#f87171;" data-id="${review.reviewIdx}" onclick="actionReview(this.getAttribute('data-id'), 'block')">차단</button></c:if></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}"><tr><td colspan="9" style="text-align:center;padding:40px;color:#475569;">조회 결과가 없습니다.</td></tr></c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg"><button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" onclick="goPage(${pg})">${pg}</button></c:forEach>
                <c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if>
                <span class="adm-page-info">${paging.currentPage} / ${paging.totalPage} 페이지</span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
document.getElementById('checkAll').addEventListener('change', function () { document.querySelectorAll('.row-check').forEach(function (cb) { cb.checked = this.checked; }, this); updateBulkBar(); });
document.querySelectorAll('.row-check').forEach(function (cb) { cb.addEventListener('change', updateBulkBar); });
function updateBulkBar() { var checked = document.querySelectorAll('.row-check:checked'); var bar = document.getElementById('bulkBar'); if (checked.length > 0) { bar.style.display = 'flex'; document.getElementById('bulkCount').textContent = checked.length + '건 선택됨'; } else { bar.style.display = 'none'; } }
function actionReview(reviewIdx, action) { if (!confirm('리뷰 #' + reviewIdx + '를 차단하시겠습니까?')) return; fetch(ctx + '/admin/explore/reviews/' + reviewIdx + '/' + action, { method: 'POST', headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(function (r) { return r.json(); }).then(function (d) { if (d.success) { location.reload(); } else { alert(d.message || '처리 실패'); } }); }
function bulkAction(action) { var ids = Array.from(document.querySelectorAll('.row-check:checked')).map(function (cb) { return cb.getAttribute('data-id'); }); if (ids.length === 0) { alert('선택된 항목이 없습니다.'); return; } if (!confirm(ids.length + '건을 일괄 차단하시겠습니까?')) return; var body = 'action=' + action + '&' + ids.map(function (id) { return 'ids=' + id; }).join('&'); fetch(ctx + '/admin/explore/reviews/bulk-action', { method: 'POST', headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }, body: body }).then(function (r) { return r.json(); }).then(function (d) { if (d.success) { location.reload(); } else { alert(d.message || '처리 실패'); } }); }
function goPage(page) { var params = new URLSearchParams(window.location.search); params.set('page', page); location.href = ctx + '/admin/explore/reviews?' + params.toString(); }
</script>

<%@ include file="../layout-close.jsp" %>
