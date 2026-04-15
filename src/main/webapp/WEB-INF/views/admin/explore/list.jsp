<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="explore"/>
<c:set var="pageTitle" value="여행지 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-tabs" style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;">
        <a class="adm-tab active" href="${pageContext.request.contextPath}/admin/explore" style="text-decoration:none;text-align:center;padding:12px 14px;">여행지 관리</a>
        <a class="adm-tab" href="${pageContext.request.contextPath}/admin/explore/reviews" style="text-decoration:none;text-align:center;padding:12px 14px;">리뷰 관리</a>
    </div>

    <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:20px;">
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">전체 여행지</div>
            <div style="font-size:24px;font-weight:700;color:#38bdf8;">${stats.totalSpots}</div>
            <div style="font-size:11px;color:#475569;margin-top:4px;">노출 ${stats.activeSpots}건</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">삭제 처리 여행지</div>
            <div style="font-size:24px;font-weight:700;color:#f87171;">${stats.deletedSpots}</div>
            <div style="font-size:11px;color:#475569;margin-top:4px;">soft delete 기준</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">전체 리뷰</div>
            <div style="font-size:24px;font-weight:700;color:#34d399;">${stats.totalReviews}</div>
            <div style="font-size:11px;color:#475569;margin-top:4px;">정상 ${stats.activeReviews}건</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">차단 리뷰</div>
            <div style="font-size:24px;font-weight:700;color:#fbbf24;">${stats.blockedReviews}</div>
            <div style="font-size:11px;color:#475569;margin-top:4px;">리뷰 관리에서 확인</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/explore">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label">상태</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}>전체</option>
                            <option value="ACTIVE" ${search.status=='ACTIVE'?'selected':''}>노출</option>
                            <option value="DELETED" ${search.status=='DELETED'?'selected':''}>삭제 처리</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">정렬</div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt" ${search.sortBy=='createdAt'?'selected':''}>최신순</option>
                            <option value="reviewCount" ${search.sortBy=='reviewCount'?'selected':''}>리뷰 많은 순</option>
                            <option value="likeCount" ${search.sortBy=='likeCount'?'selected':''}>좋아요 많은 순</option>
                            <option value="ratingAvg" ${search.sortBy=='ratingAvg'?'selected':''}>평점 높은 순</option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">검색</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}>전체</option>
                                <option value="name" ${search.searchType=='name'?'selected':''}>이름</option>
                                <option value="region" ${search.searchType=='region'?'selected':''}>지역</option>
                                <option value="address" ${search.searchType=='address'?'selected':''}>주소</option>
                                <option value="description" ${search.searchType=='description'?'selected':''}>설명</option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}>닉네임</option>
                                <option value="userId" ${search.searchType=='userId'?'selected':''}>아이디</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="검색어" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">조회</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore">초기화</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">여행지 목록</div>
                <div style="font-size:12px;color:#64748b;">총 ${total}건</div>
            </div>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#64748b;" onclick="bulkAction('delete')">선택 삭제 처리</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:70px;">ID</th>
                    <th style="width:84px;">이미지</th>
                    <th>여행지</th>
                    <th style="width:120px;">작성자</th>
                    <th style="width:130px;">지역</th>
                    <th style="width:80px;">평점</th>
                    <th style="width:70px;">리뷰</th>
                    <th style="width:70px;">좋아요</th>
                    <th style="width:80px;">상태</th>
                    <th style="width:140px;">액션</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="spot">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${spot.spotIdx}"></td>
                        <td style="color:#64748b;font-size:12px;">#${spot.spotIdx}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty spot.thumbUrl}">
                                    <img src="${spot.thumbUrl}" alt="${fn:escapeXml(spot.name)}" style="width:56px;height:56px;object-fit:cover;border-radius:8px;border:1px solid #1e293b;">
                                </c:when>
                                <c:otherwise>
                                    <div style="width:56px;height:56px;border-radius:8px;background:#1e293b;color:#64748b;display:flex;align-items:center;justify-content:center;">없음</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}" style="color:#e2e8f0;text-decoration:none;font-size:13px;font-weight:600;">${fn:escapeXml(spot.name)}</a>
                            <div style="font-size:11px;color:#64748b;margin-top:4px;">${fn:escapeXml(spot.address)}</div>
                        </td>
                        <td>
                            <div style="font-size:13px;color:#7dd3fc;font-weight:600;">${fn:escapeXml(spot.nickname)}</div>
                            <div style="font-size:11px;color:#64748b;">${fn:escapeXml(spot.userId)}</div>
                        </td>
                        <td style="font-size:12px;color:#94a3b8;">${fn:escapeXml(spot.region)}</td>
                        <td style="font-size:12px;color:#fbbf24;font-weight:700;"><fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/></td>
                        <td style="font-size:12px;color:#94a3b8;">${spot.reviewCount}</td>
                        <td style="font-size:12px;color:#94a3b8;">${spot.likeCount}</td>
                        <td>
                            <span class="status-badge ${spot.displayStatus}">
                                <c:choose>
                                    <c:when test="${spot.displayStatus == 'ACTIVE'}">노출</c:when>
                                    <c:otherwise>삭제 처리</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <div style="display:flex;gap:4px;flex-wrap:wrap;">
                                <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}?edit=true" style="font-size:11px;padding:3px 8px;text-decoration:none;color:#38bdf8;border-color:#38bdf8;">수정</a>
                                <c:if test="${spot.displayStatus != 'DELETED'}">
                                    <button class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;color:#64748b;" data-id="${spot.spotIdx}" onclick="actionSpot(this.getAttribute('data-id'), 'delete')">삭제</button>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="11" style="text-align:center;padding:40px;color:#475569;">조회 결과가 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}">
                    <button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">이전</button>
                </c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg">
                    <button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" onclick="goPage(${pg})">${pg}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">다음</button>
                </c:if>
                <span class="adm-page-info">${paging.currentPage} / ${paging.totalPage} 페이지</span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';

document.getElementById('checkAll').addEventListener('change', function () {
    document.querySelectorAll('.row-check').forEach(function (cb) {
        cb.checked = this.checked;
    }, this);
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
        document.getElementById('bulkCount').textContent = checked.length + '건 선택됨';
    } else {
        bar.style.display = 'none';
    }
}

function actionSpot(spotIdx, action) {
    if (!confirm('여행지 #' + spotIdx + '를 삭제 처리하시겠습니까?')) return;
    fetch(ctx + '/admin/explore/spots/' + spotIdx + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) {
        return r.json();
    }).then(function (d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || '처리에 실패했습니다.');
        }
    });
}

function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked')).map(function (cb) {
        return cb.getAttribute('data-id');
    });
    if (ids.length === 0) {
        alert('선택된 항목이 없습니다.');
        return;
    }
    if (!confirm(ids.length + '건을 일괄 삭제 처리하시겠습니까?')) return;

    var body = 'action=' + action + '&' + ids.map(function (id) {
        return 'ids=' + id;
    }).join('&');

    fetch(ctx + '/admin/explore/spots/bulk-action', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body
    }).then(function (r) {
        return r.json();
    }).then(function (d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || '처리에 실패했습니다.');
        }
    });
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/explore?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
