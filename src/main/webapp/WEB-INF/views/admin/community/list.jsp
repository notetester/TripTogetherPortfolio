<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="community"/>
<c:set var="pageTitle" value="커뮤니티 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 탭 바 ── --%>
    <div class="adm-tabs" style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;">
        <a class="adm-tab active" href="${pageContext.request.contextPath}/admin/community"
           style="text-decoration:none;text-align:center;padding:12px 14px;">📝 게시글 관리</a>
        <a class="adm-tab" href="${pageContext.request.contextPath}/admin/community/comments"
           style="text-decoration:none;text-align:center;padding:12px 14px;">💬 댓글 관리</a>
    </div>

    <%-- ── 통계 카드 ── --%>
    <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:20px;">
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">활성 게시글</div>
            <div style="font-size:24px;font-weight:700;color:#38bdf8;">${stats.activePosts}</div>
            <div style="font-size:11px;color:#475569;margin-top:4px;">전체 ${stats.totalPosts}건</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">차단된 게시글</div>
            <div style="font-size:24px;font-weight:700;color:#f87171;">${stats.blockedPosts}</div>
            <div style="font-size:11px;color:#475569;margin-top:4px;">삭제 ${stats.deletedPosts}건</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">활성 댓글</div>
            <div style="font-size:24px;font-weight:700;color:#34d399;">${stats.activeComments}</div>
            <div style="font-size:11px;color:#475569;margin-top:4px;">차단 ${stats.blockedComments}건</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">미처리 신고</div>
            <div style="font-size:24px;font-weight:700;color:#fbbf24;">${stats.pendingReports}</div>
            <div style="font-size:11px;color:#475569;margin-top:4px;">30일 처리완료 ${stats.resolvedReports30d}건</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/community" id="searchForm">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label">상태</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ?'selected':''}>전체</option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ?'selected':''}>활성</option>
                            <option value="BLOCKED" ${search.status=='BLOCKED' ?'selected':''}>차단</option>
                            <option value="DELETED" ${search.status=='DELETED' ?'selected':''}>삭제</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">유형</div>
                        <select class="adm-select" name="postType">
                            <option value="ALL"      ${search.postType=='ALL'      ?'selected':''}>전체</option>
                            <option value="review"   ${search.postType=='review'   ?'selected':''}>여행 이야기</option>
                            <option value="photo"    ${search.postType=='photo'    ?'selected':''}>사진</option>
                            <option value="tip"      ${search.postType=='tip'      ?'selected':''}>여행 팁</option>
                            <option value="question" ${search.postType=='question' ?'selected':''}>질문</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">정렬</div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt"   ${search.sortBy=='createdAt'   ?'selected':''}>최신순</option>
                            <option value="reportCount" ${search.sortBy=='reportCount' ?'selected':''}>신고 많은 순</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">신고 이력</div>
                        <select class="adm-select" name="flagged">
                            <option value="ALL"     ${search.flagged=='ALL'     ?'selected':''}>전체</option>
                            <option value="FLAGGED" ${search.flagged=='FLAGGED' ?'selected':''}>30일 이력 있음</option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:200px;">
                        <div class="adm-filter-label">검색</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:110px;">
                                <option value="all"      ${search.searchType=='all'      ?'selected':''}>전체</option>
                                <option value="title"    ${search.searchType=='title'    ?'selected':''}>제목</option>
                                <option value="content"  ${search.searchType=='content'  ?'selected':''}>내용</option>
                                <option value="nickname" ${search.searchType=='nickname' ?'selected':''}>닉네임</option>
                                <option value="userId"   ${search.searchType=='userId'   ?'selected':''}>아이디</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}"
                                   placeholder="검색어" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">조회</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/community">초기화</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">게시글 목록</div>
                <div style="font-size:12px;color:#64748b;">총 ${total}건</div>
            </div>
            <%-- 일괄 처리 버튼 --%>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;"
                        onclick="bulkAction('block')">선택 차단</button>
                <button class="adm-btn adm-btn-ghost" style="color:#64748b;"
                        onclick="bulkAction('delete')">선택 삭제</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:60px;">ID</th>
                    <th>작성자</th>
                    <th>IP</th>
                    <th>제목</th>
                    <th style="width:80px;">유형</th>
                    <th style="width:60px;">신고</th>
                    <th style="width:80px;">상태</th>
                    <th style="width:90px;">등록일</th>
                    <th style="width:100px;">액션</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="p">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${p.postId}"></td>
                        <td style="color:#64748b;font-size:12px;">#${p.postId}</td>

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
                                <span style="font-size:10px;background:#7f1d1d;color:#fca5a5;padding:1px 5px;border-radius:3px;">계정차단</span>
                            </c:if>
                        </td>

                        <%-- IP --%>
                        <td style="font-size:11px;color:#94a3b8;font-family:monospace;">
                            <c:choose>
                                <c:when test="${not empty p.lastIp}">${p.lastIp}</c:when>
                                <c:otherwise><span style="color:#475569;">—</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 제목 + 30일 배지 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/community/posts/${p.postId}"
                               style="color:#e2e8f0;text-decoration:none;font-size:13px;"
                               title="${p.title}">
                                    <c:choose>
                                    <c:when test="${fn:length(p.title) > 30}">${fn:substring(p.title, 0, 30)}…</c:when>
                                    <c:otherwise>${p.title}</c:otherwise>
                                </c:choose>
                            </a>
                            <c:if test="${p.authorResolveCount30d > 0}">
                                <span style="margin-left:6px;font-size:10px;background:#422006;color:#fb923c;padding:1px 5px;border-radius:3px;">
                                    ⚠ 30일 ${p.authorResolveCount30d}건
                                </span>
                            </c:if>
                        </td>

                        <%-- 유형 --%>
                        <td style="font-size:12px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${p.postType == 'review'}">여행이야기</c:when>
                                <c:when test="${p.postType == 'photo'}">사진</c:when>
                                <c:when test="${p.postType == 'tip'}">여행팁</c:when>
                                <c:when test="${p.postType == 'question'}">질문</c:when>
                                <c:otherwise>${p.postType}</c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 신고 수 --%>
                        <td>
                            <c:choose>
                                <c:when test="${p.reportCount >= 3}">
                                    <span style="color:#f87171;font-weight:700;">🔴 ${p.reportCount}</span>
                                </c:when>
                                <c:when test="${p.reportCount > 0}">
                                    <span style="color:#fbbf24;">${p.reportCount}</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#475569;">0</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <span class="status-badge ${p.postStatus}">
                                <c:choose>
                                    <c:when test="${p.postStatus == 'ACTIVE'}">활성</c:when>
                                    <c:when test="${p.postStatus == 'BLOCKED'}">차단</c:when>
                                    <c:when test="${p.postStatus == 'DELETED'}">삭제</c:when>
                                    <c:otherwise>${p.postStatus}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>

                        <%-- 등록일 --%>
                        <td style="font-size:11px;color:#64748b;">
                            <fmt:formatDate value="${p.createdAt}" pattern="yyyy.MM.dd"/>
                            <div><fmt:formatDate value="${p.createdAt}" pattern="HH:mm"/></div>
                        </td>

                        <%-- 액션 --%>
                        <td>
                            <div style="display:flex;gap:4px;">
                                <c:if test="${p.postStatus != 'BLOCKED'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;padding:3px 8px;color:#f87171;border-color:#f87171;"
                                            data-id="${p.postId}"
                                            onclick="actionPost(this.getAttribute('data-id'), 'block')">차단</button>
                                </c:if>
                                <c:if test="${p.postStatus != 'DELETED'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;padding:3px 8px;color:#64748b;"
                                            data-id="${p.postId}"
                                            onclick="actionPost(this.getAttribute('data-id'), 'delete')">삭제</button>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="10" style="text-align:center;padding:40px;color:#475569;">조회 결과가 없습니다.</td></tr>
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
                <span class="adm-page-info">${paging.currentPage} / ${paging.totalPage} 페이지</span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/community/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> 커뮤니티 게시판 사이트 보기
        </a>
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
function actionPost(postId, action) {
    var label = action === 'block' ? '차단' : '삭제';
    if (!confirm('게시글 #' + postId + '을(를) ' + label + '하시겠습니까?')) return;
    fetch(ctx + '/admin/community/posts/' + postId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 실패'); }
    });
}

// ── 일괄 처리 ──
function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked'))
                   .map(function (cb) { return cb.getAttribute('data-id'); });
    if (ids.length === 0) { alert('선택된 항목이 없습니다.'); return; }
    var label = action === 'block' ? '차단' : '삭제';
    if (!confirm(ids.length + '건을 일괄 ' + label + '하시겠습니까?')) return;

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
        else { alert(d.message || '처리 실패'); }
    });
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
        ? '<span class="status-badge BLOCKED" style="font-size:12px;">차단</span>'
        : '<span class="status-badge ACTIVE"  style="font-size:12px;">활성</span>';

    var warnBox = resolve > 0
        ? '<div style="margin-top:12px;padding:10px;background:#422006;border-radius:6px;color:#fb923c;font-size:12px;">⚠ 최근 30일 처리된 신고 ' + resolve + '건</div>'
        : '';

    var blockBtn = status !== 'BLOCKED'
        ? '<button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;width:100%;margin-top:4px;" data-idx="' + userIdx + '" onclick="blockUserFromModal(this)">계정 차단</button>'
        : '';

    document.getElementById('authorModalBody').innerHTML =
        '<div style="display:flex;flex-direction:column;gap:10px;">'
      + '  <div style="display:flex;justify-content:space-between;align-items:center;">'
      + '    <span style="color:#64748b;font-size:12px;">닉네임</span>'
      + '    <span style="color:#e2e8f0;font-size:13px;font-weight:600;">' + escHtml(nickname) + '</span>'
      + '  </div>'
      + '  <div style="display:flex;justify-content:space-between;align-items:center;">'
      + '    <span style="color:#64748b;font-size:12px;">아이디</span>'
      + '    <span style="color:#94a3b8;font-size:13px;">' + escHtml(userId) + '</span>'
      + '  </div>'
      + '  <div style="display:flex;justify-content:space-between;align-items:center;">'
      + '    <span style="color:#64748b;font-size:12px;">마지막 IP</span>'
      + '    <span style="color:#94a3b8;font-size:12px;font-family:monospace;">' + escHtml(ip || '—') + '</span>'
      + '  </div>'
      + '  <div style="display:flex;justify-content:space-between;align-items:center;">'
      + '    <span style="color:#64748b;font-size:12px;">계정 상태</span>'
      + '    ' + statusBadge
      + '  </div>'
      + '</div>'
      + warnBox
      + '<div style="margin-top:16px;display:flex;flex-direction:column;gap:6px;">'
      + '  <a href="' + ctx + '/admin/members?searchType=userId&keyword=' + encodeURIComponent(userId) + '" class="adm-btn adm-btn-ghost" style="text-align:center;text-decoration:none;">회원 정보 보기</a>'
      + blockBtn
      + '</div>';

    document.getElementById('authorModal').style.display = 'flex';
}

function closeAuthorModal() {
    document.getElementById('authorModal').style.display = 'none';
}

function blockUserFromModal(btn) {
    var userIdx = btn.getAttribute('data-idx');
    if (!confirm('해당 계정을 차단하시겠습니까?')) return;
    fetch(ctx + '/admin/community/users/' + userIdx + '/block', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 실패'); }
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
            <span class="adm-modal-title">작성자 정보</span>
            <button class="adm-modal-close" onclick="closeAuthorModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="authorModalBody"></div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
