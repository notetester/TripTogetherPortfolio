<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="courses"/>
<c:set var="pageTitle" value="여행코스 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">활성 코스</div>
            <div class="adm-summary-value is-primary">${stats.activePlans}</div>
            <div class="adm-summary-sub">전체 ${stats.totalPlans}건</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">삭제된 코스</div>
            <div class="adm-summary-value is-danger">${stats.deletedPlans}</div>
            <div class="adm-summary-sub">오늘 등록 ${stats.todayPlans}건</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">AI 코스</div>
            <div class="adm-summary-value is-success">${stats.aiPlans}</div>
            <div class="adm-summary-sub">수동 ${stats.manualPlans}건</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">공개 코스</div>
            <div class="adm-summary-value is-warning">${stats.publicPlans}</div>
            <div class="adm-summary-sub">비공개 ${stats.privatePlans}건</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/courses" id="searchForm">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label">상태</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ?'selected':''}>전체</option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ?'selected':''}>활성</option>
                            <option value="DELETED" ${search.status=='DELETED' ?'selected':''}>삭제됨</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">생성유형</div>
                        <select class="adm-select" name="planSource">
                            <option value="ALL"    ${search.planSource=='ALL'    ?'selected':''}>전체</option>
                            <option value="MANUAL" ${search.planSource=='MANUAL' ?'selected':''}>수동</option>
                            <option value="AI"     ${search.planSource=='AI'     ?'selected':''}>AI</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">공개</div>
                        <select class="adm-select" name="isPublic">
                            <option value="ALL"     ${search.isPublic=='ALL'     ?'selected':''}>전체</option>
                            <option value="PUBLIC"  ${search.isPublic=='PUBLIC'  ?'selected':''}>공개</option>
                            <option value="PRIVATE" ${search.isPublic=='PRIVATE' ?'selected':''}>비공개</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">정렬</div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt" ${search.sortBy=='createdAt' ?'selected':''}>등록일</option>
                            <option value="updatedAt" ${search.sortBy=='updatedAt' ?'selected':''}>수정일</option>
                            <option value="startDate" ${search.sortBy=='startDate' ?'selected':''}>여행 시작일</option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">검색</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all"         ${search.searchType=='all'         ?'selected':''}>전체</option>
                                <option value="title"       ${search.searchType=='title'       ?'selected':''}>제목</option>
                                <option value="destination" ${search.searchType=='destination' ?'selected':''}>여행지</option>
                                <option value="nickname"    ${search.searchType=='nickname'    ?'selected':''}>닉네임</option>
                                <option value="userId"      ${search.searchType=='userId'      ?'selected':''}>아이디</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}"
                                   placeholder="검색어를 입력하세요" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">검색</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/courses">초기화</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">여행코스 목록</div>
                <div class="adm-muted-note">총 ${total}건</div>
            </div>
            <%-- 일괄 처리 버튼 --%>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;"
                        onclick="bulkAction('delete')">일괄 삭제</button>
                <button class="adm-btn adm-btn-ghost" style="color:#34d399;border-color:#34d399;"
                        onclick="bulkAction('restore')">일괄 복구</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:60px;">ID</th>
                    <th>작성자</th>
                    <th>제목</th>
                    <th>여행지</th>
                    <th style="width:120px;">일정</th>
                    <th style="width:50px;">스팟</th>
                    <th style="width:60px;">유형</th>
                    <th style="width:60px;">공개</th>
                    <th style="width:70px;">상태</th>
                    <th style="width:90px;">등록일</th>
                    <th style="width:120px;">액션</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="p">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${p.planId}"></td>
                        <td style="color:#64748b;font-size:12px;">#${p.planId}</td>

                        <%-- 작성자 --%>
                        <td>
                            <div style="font-weight:600;font-size:13px;color:#7dd3fc;">${p.nickname}</div>
                            <div style="font-size:11px;color:#64748b;">${p.userId}</div>
                            <c:if test="${p.accountStatus == 'BLOCKED'}">
                                <span class="adm-inline-danger">계정 차단됨</span>
                            </c:if>
                        </td>

                        <%-- 제목 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/courses/${p.planId}"
                               class="adm-link-title" title="${p.title}">
                                <c:choose>
                                    <c:when test="${fn:length(p.title) > 24}">${fn:substring(p.title, 0, 24)}…</c:when>
                                    <c:otherwise>${p.title}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 여행지 --%>
                        <td style="font-size:12px;color:#cbd5e1;">
                            <c:choose>
                                <c:when test="${not empty p.destination}">${p.destination}</c:when>
                                <c:otherwise><span style="color:#475569;">—</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 일정 --%>
                        <td style="font-size:11px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${not empty p.startDate}">
                                    <fmt:formatDate value="${p.startDate}" pattern="yyyy.MM.dd"/>
                                    <div>~ <fmt:formatDate value="${p.endDate}" pattern="MM.dd"/></div>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">—</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 스팟 수 --%>
                        <td style="text-align:center;">
                            <c:choose>
                                <c:when test="${p.spotCount > 0}">
                                    <span style="color:#7dd3fc;font-weight:600;">${p.spotCount}</span>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">0</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 유형 --%>
                        <td style="font-size:12px;">
                            <c:choose>
                                <c:when test="${p.planSource == 'AI'}">
                                    <span style="color:#a78bfa;font-weight:600;">AI</span>
                                </c:when>
                                <c:when test="${p.planSource == 'MANUAL'}">
                                    <span style="color:#94a3b8;">수동</span>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">${p.planSource}</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 공개 --%>
                        <td style="font-size:12px;">
                            <c:choose>
                                <c:when test="${p.isPublic == 1}">
                                    <span style="color:#34d399;">공개</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;">비공개</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <c:choose>
                                <c:when test="${p.isDeleted == 0}">
                                    <span class="status-badge ACTIVE">활성</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge DELETED">삭제됨</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 등록일 --%>
                        <td style="font-size:11px;color:#64748b;">
                            <fmt:formatDate value="${p.createdAt}" pattern="yyyy.MM.dd"/>
                            <div><fmt:formatDate value="${p.createdAt}" pattern="HH:mm"/></div>
                        </td>

                        <%-- 액션 --%>
                        <td>
                            <div style="display:flex;gap:4px;">
                                <c:choose>
                                    <c:when test="${p.isDeleted == 0}">
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;padding:3px 8px;color:#f87171;border-color:#f87171;"
                                                data-id="${p.planId}"
                                                onclick="actionPlan(this.getAttribute('data-id'), 'delete')">삭제</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;padding:3px 8px;color:#34d399;border-color:#34d399;"
                                                data-id="${p.planId}"
                                                onclick="actionPlan(this.getAttribute('data-id'), 'restore')">복구</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="12" style="text-align:center;padding:40px;color:#475569;">검색 결과가 없습니다.</td></tr>
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
                <span class="adm-page-info">${paging.currentPage} / ${paging.totalPage}</span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';

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
        document.getElementById('bulkCount').textContent = checked.length + '건 선택됨';
    } else {
        bar.style.display = 'none';
    }
}

// ── 단건 액션 ──
function actionPlan(planId, action) {
    var label = action === 'delete' ? '삭제' : '복구';
    if (!confirm('#' + planId + ' 코스를 ' + label + '하시겠습니까?')) return;
    fetch(ctx + '/admin/courses/' + planId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 중 오류가 발생했습니다.'); }
    });
}

// ── 일괄 처리 ──
function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked'))
                   .map(function (cb) { return cb.getAttribute('data-id'); });
    if (ids.length === 0) { alert('선택된 항목이 없습니다.'); return; }
    var label = action === 'delete' ? '삭제' : '복구';
    if (!confirm(ids.length + '건을 ' + label + '하시겠습니까?')) return;

    var body = 'action=' + action + '&' + ids.map(function (id) { return 'ids=' + id; }).join('&');
    fetch(ctx + '/admin/courses/bulk-action', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 중 오류가 발생했습니다.'); }
    });
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/courses?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
