<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="reports"/>
<c:set var="pageTitle" value="신고 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:20px;">
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">전체 신고</div>
            <div style="font-size:24px;font-weight:700;color:#38bdf8;">${stats.totalReports}</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">검토중</div>
            <div style="font-size:24px;font-weight:700;color:#fbbf24;">${stats.inReviewReports}</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">처리완료</div>
            <div style="font-size:24px;font-weight:700;color:#34d399;">${stats.resolvedReports}</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">반려</div>
            <div style="font-size:24px;font-weight:700;color:#94a3b8;">${stats.dismissedReports}</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/reports">
                <div class="adm-filter-bar">

                    <div>
                        <div class="adm-filter-label">상태</div>
                        <select class="adm-select" name="status">
                            <option value=""           ${empty search.status         ? 'selected':''}>전체</option>
                            <option value="IN_REVIEW"  ${search.status=='IN_REVIEW'  ? 'selected':''}>검토중</option>
                            <option value="RESOLVED"   ${search.status=='RESOLVED'   ? 'selected':''}>처리완료</option>
                            <option value="DISMISSED"  ${search.status=='DISMISSED'  ? 'selected':''}>반려</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">대상 유형</div>
                        <select class="adm-select" name="targetType">
                            <option value=""        ${empty search.targetType      ? 'selected':''}>전체</option>
                            <option value="post"    ${search.targetType=='post'    ? 'selected':''}>게시글</option>
                            <option value="comment" ${search.targetType=='comment' ? 'selected':''}>댓글</option>
                            <option value="user"    ${search.targetType=='user'    ? 'selected':''}>유저</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">신고 사유</div>
                        <select class="adm-select" name="reason">
                            <option value=""        ${empty search.reason          ? 'selected':''}>전체</option>
                            <option value="spam"    ${search.reason=='spam'    ? 'selected':''}>스팸/광고</option>
                            <option value="abuse"   ${search.reason=='abuse'   ? 'selected':''}>욕설/비방</option>
                            <option value="privacy" ${search.reason=='privacy' ? 'selected':''}>개인정보 노출</option>
                            <option value="adult"   ${search.reason=='adult'   ? 'selected':''}>음란물</option>
                            <option value="illegal" ${search.reason=='illegal' ? 'selected':''}>불법 정보</option>
                            <option value="user"    ${search.reason=='user'    ? 'selected':''}>유저 신고</option>
                            <option value="other"   ${search.reason=='other'   ? 'selected':''}>기타</option>
                        </select>
                    </div>

                    <div style="flex:1;min-width:200px;">
                        <div class="adm-filter-label">검색 (신고자 닉네임)</div>
                        <div class="adm-search-box">
                            <span class="adm-search-ico">🔍</span>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="닉네임 입력...">
                        </div>
                    </div>

                    <button class="adm-btn adm-btn-primary" type="submit">조회</button>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">신고 목록</div>
            <div style="font-size:12px;color:#64748b;">총 ${totalCount}건</div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>신고수</th>
                    <th>대상</th>
                    <th>신고자</th>
                    <th>사유</th>
                    <th>신고일</th>
                    <th>처리일</th>
                    <th>상태</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${reportList}" var="r">
                    <tr class="rpt-admin-row" data-id="${r.reportId}" style="cursor:pointer;"
                        onmouseenter="this.style.background='rgba(255,255,255,.04)'"
                        onmouseleave="this.style.background=''"
                    >
                        <td>#${r.reportId}</td>

                        <%-- 신고수: 3건 이상이면 빨간 강조 --%>
                        <td>
                            <c:choose>
                                <c:when test="${r.targetReportCount >= 3}">
                                    <span style="color:#f87171;font-weight:700;">🔴 ${r.targetReportCount}건</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#94a3b8;">${r.targetReportCount}건</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 대상 --%>
                        <td>
                            <div class="mem-name">
                                <c:choose>
                                    <c:when test="${r.targetType eq 'post'}">게시글</c:when>
                                    <c:when test="${r.targetType eq 'comment'}">댓글</c:when>
                                    <c:when test="${r.targetType eq 'user'}">유저</c:when>
                                    <c:otherwise>${r.targetType}</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="mem-uid">#${r.targetId}</div>
                        </td>

                        <%-- 신고자 닉네임 --%>
                        <td style="cursor:pointer;"
                            data-useridx="${r.userIdx}"
                            data-userid="${r.userId}"
                            data-nickname="${r.nickname}"
                            data-status="${r.accountStatus}"
                            onclick="openAuthorModal(this)">
                            <div style="font-weight:600;font-size:13px;color:#7dd3fc;">${r.nickname}</div>
                            <div style="font-size:11px;color:#64748b;">${r.userId}</div>
                            <c:if test="${r.accountStatus == 'BLOCKED'}">
                                <span style="font-size:10px;background:#7f1d1d;color:#fca5a5;padding:1px 5px;border-radius:3px;">계정차단</span>
                            </c:if>
                        </td>

                        <%-- 사유 --%>
                        <td>
                            <span style="font-size:12px;">
                                <c:choose>
                                    <c:when test="${r.reason eq 'spam'}">스팸/광고</c:when>
                                    <c:when test="${r.reason eq 'abuse'}">욕설/비방</c:when>
                                    <c:when test="${r.reason eq 'privacy'}">개인정보 노출</c:when>
                                    <c:when test="${r.reason eq 'adult'}">음란물</c:when>
                                    <c:when test="${r.reason eq 'illegal'}">불법 정보</c:when>
                                    <c:when test="${r.reason eq 'other'}">기타</c:when>
                                    <c:when test="${r.reason eq 'user'}">유저 신고</c:when>
                                    <c:when test="${not empty r.reason}">${r.reason}</c:when>
                                    <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                                </c:choose>
                            </span>
                        </td>

                        <%-- 신고일 --%>
                        <td>
                            <fmt:formatDate value="${r.createdAt}" pattern="yyyy.MM.dd"/>
                            <div class="mem-uid"><fmt:formatDate value="${r.createdAt}" pattern="HH:mm"/></div>
                        </td>

                        <%-- 처리일 --%>
                        <td>
                            <c:choose>
                                <c:when test="${not empty r.resolvedAt}">
                                    <fmt:formatDate value="${r.resolvedAt}" pattern="yyyy.MM.dd"/>
                                    <div class="mem-uid"><fmt:formatDate value="${r.resolvedAt}" pattern="HH:mm"/></div>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 상태 배지 --%>
                        <td>
                            <span class="status-badge ${r.status}">
                                <c:choose>
                                    <c:when test="${r.status eq 'IN_REVIEW'}">검토중</c:when>
                                    <c:when test="${r.status eq 'RESOLVED'}">처리완료</c:when>
                                    <c:when test="${r.status eq 'DISMISSED'}">반려</c:when>
                                    <c:otherwise>${r.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>

                    </tr>
                </c:forEach>
                <c:if test="${empty reportList}">
                    <tr><td colspan="8" style="text-align:center;padding:40px;color:#475569;">조회 결과가 없습니다.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <%-- 페이지네이션 --%>
        <c:if test="${totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${search.page > 1}">
                    <button class="adm-page-btn" onclick="goPage(${search.page - 1})">‹</button>
                </c:if>
                <c:forEach begin="1" end="${totalPage}" var="p">
                    <button class="adm-page-btn ${p == search.page ? 'active' : ''}" onclick="goPage(${p})">${p}</button>
                </c:forEach>
                <c:if test="${search.page < totalPage}">
                    <button class="adm-page-btn" onclick="goPage(${search.page + 1})">›</button>
                </c:if>
                <span class="adm-page-info">${search.page} / ${totalPage} 페이지</span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item" href="${pageContext.request.contextPath}/report/list" target="_blank"
           style="background:#1e2330;color:#64748b;">
            <span class="adm-nav-icon">↗️</span> 신고 게시판 사이트 보기
        </a>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var listParams = 'page=${search.page}&status=${search.status}&targetType=${search.targetType}&reason=${search.reason}&keyword=' + encodeURIComponent('${search.keyword}');

// 행 클릭 시 어드민 신고 상세 페이지 이동
document.querySelectorAll('.rpt-admin-row[data-id]').forEach(function (tr) {
    tr.addEventListener('click', function (e) {
        if (e.target.closest('td[data-useridx]')) return;
        location.href = ctx + '/admin/reports/' + this.getAttribute('data-id') + '?' + listParams;
    });
});

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/reports?' + params.toString();
}

// ── 신고자 모달 ──
function openAuthorModal(el) {
    var userIdx  = el.getAttribute('data-useridx');
    var userId   = el.getAttribute('data-userid');
    var nickname = el.getAttribute('data-nickname');
    var status   = el.getAttribute('data-status');

    var statusBadge = status === 'BLOCKED'
        ? '<span class="status-badge BLOCKED" style="font-size:12px;">차단</span>'
        : '<span class="status-badge ACTIVE"  style="font-size:12px;">활성</span>';

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
      + '    <span style="color:#64748b;font-size:12px;">계정 상태</span>'
      + '    ' + statusBadge
      + '  </div>'
      + '</div>'
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
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 실패'); }
    });
}

function escHtml(str) {
    if (!str) return '';
    return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}
</script>

<%-- ── 신고자 정보 모달 ── --%>
<div id="authorModal" class="adm-modal-overlay" style="display:none;"
     onclick="if(event.target===this)closeAuthorModal()">
    <div class="adm-modal" style="width:360px;">
        <div class="adm-modal-head">
            <span class="adm-modal-title">신고자 정보</span>
            <button class="adm-modal-close" onclick="closeAuthorModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="authorModalBody"></div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
