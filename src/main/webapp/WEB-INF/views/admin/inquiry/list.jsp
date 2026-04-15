<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="inquiries"/>
<c:set var="pageTitle" value="문의 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:20px;">
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">전체 문의</div>
            <div style="font-size:24px;font-weight:700;color:#38bdf8;">${stats.totalInquiries}</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">대기중</div>
            <div style="font-size:24px;font-weight:700;color:#fbbf24;">${stats.pendingInquiries}</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">처리중</div>
            <div style="font-size:24px;font-weight:700;color:#fb923c;">${stats.inProgressInquiries}</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;">답변완료</div>
            <div style="font-size:24px;font-weight:700;color:#34d399;">${stats.completedInquiries}</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/inquiries">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label">상태</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"              ${search.status=='ALL'?'selected':''}>전체</option>
                            <option value="PENDING"          ${search.status=='PENDING'?'selected':''}>대기중</option>
                            <option value="IN_PROGRESS"      ${search.status=='IN_PROGRESS'?'selected':''}>처리중</option>
                            <option value="COMPLETED"        ${search.status=='COMPLETED'?'selected':''}>답변완료</option>
                            <option value="USER_COMPLETED"   ${search.status=='USER_COMPLETED'?'selected':''}>해결됨</option>
                            <option value="CANCELLED"        ${search.status=='CANCELLED'?'selected':''}>취소됨</option>
                            <option value="DELETE_REQUESTED" ${search.status=='DELETE_REQUESTED'?'selected':''}>삭제요청</option>
                            <option value="PRIVATE_REQUESTED"${search.status=='PRIVATE_REQUESTED'?'selected':''}>비공개요청</option>
                            <option value="PUBLIC_REQUESTED" ${search.status=='PUBLIC_REQUESTED'?'selected':''}>공개요청</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">카테고리</div>
                        <select class="adm-select" name="category">
                            <option value="ALL" ${search.category=='ALL'?'selected':''}>전체</option>
                            <option value="service" ${search.category=='service'?'selected':''}>서비스</option>
                            <option value="payment" ${search.category=='payment'?'selected':''}>결제</option>
                            <option value="account" ${search.category=='account'?'selected':''}>계정</option>
                            <option value="bug" ${search.category=='bug'?'selected':''}>버그</option>
                            <option value="etc" ${search.category=='etc'?'selected':''}>기타</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">답변 여부</div>
                        <select class="adm-select" name="answered">
                            <option value="ALL" ${search.answered=='ALL'?'selected':''}>전체</option>
                            <option value="ANSWERED" ${search.answered=='ANSWERED'?'selected':''}>답변 완료</option>
                            <option value="UNANSWERED" ${search.answered=='UNANSWERED'?'selected':''}>미답변</option>
                        </select>
                    </div>

                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">검색</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:110px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}>전체</option>
                                <option value="title" ${search.searchType=='title'?'selected':''}>제목</option>
                                <option value="content" ${search.searchType=='content'?'selected':''}>내용</option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}>작성자</option>
                            </select>
                            <div class="adm-search-box" style="flex:1;">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="검색어 입력...">
                            </div>
                        </div>
                    </div>

                    <button class="adm-btn adm-btn-primary" type="submit">조회</button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">문의 목록</div>
            <div style="font-size:12px;color:#64748b;">총 ${total}건</div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>작성자</th>
                    <th>제목</th>
                    <th>카테고리</th>
                    <th>상태</th>
                    <th>답변</th>
                    <th>등록일</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr class="adm-inq-row" data-id="${item.inquiryId}" style="cursor:pointer;">
                        <td>#${item.inquiryId}</td>
                        <%-- 작성자 --%>
                        <td style="cursor:pointer;"
                            data-useridx="${item.userIdx}"
                            data-userid="${item.userId}"
                            data-nickname="${item.nickname}"
                            data-status="${item.accountStatus}"
                            onclick="openAuthorModal(this)">
                            <div style="font-weight:600;font-size:13px;color:#7dd3fc;">${item.nickname}</div>
                            <div style="font-size:11px;color:#64748b;">${item.userId}</div>
                            <c:if test="${item.accountStatus == 'BLOCKED'}">
                                <span style="font-size:10px;background:#7f1d1d;color:#fca5a5;padding:1px 5px;border-radius:3px;">계정차단</span>
                            </c:if>
                        </td>
                        <td>
                            <div class="mem-name">${item.title}</div>
                            <div class="mem-uid">
                                <c:if test="${item.privateFlag}">🔒 비공개 · </c:if>
                                조회 ${item.viewCount}
                            </div>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.category eq 'service'}">서비스</c:when>
                                <c:when test="${item.category eq 'payment'}">결제</c:when>
                                <c:when test="${item.category eq 'account'}">계정</c:when>
                                <c:when test="${item.category eq 'bug'}">오류신고</c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="status-badge ${item.status}">
                                <c:choose>
                                    <c:when test="${item.status eq 'PENDING'}">대기중</c:when>
                                    <c:when test="${item.status eq 'IN_PROGRESS'}">처리중</c:when>
                                    <c:when test="${item.status eq 'COMPLETED'}">답변완료</c:when>
                                    <c:when test="${item.status eq 'USER_COMPLETED'}">해결됨</c:when>
                                    <c:when test="${item.status eq 'CANCELLED'}">취소됨</c:when>
                                    <c:when test="${item.status eq 'DELETE_REQUESTED'}">삭제요청</c:when>
                                    <c:when test="${item.status eq 'PRIVATE_REQUESTED'}">비공개요청</c:when>
                                    <c:when test="${item.status eq 'PUBLIC_REQUESTED'}">공개요청</c:when>
                                    <c:otherwise>${item.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.answerId}">
                                    <div class="mem-name">답변 완료</div>
                                    <div class="mem-uid">${item.answerAdminNickname}</div>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">미답변</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${item.createdAt}" pattern="yyyy.MM.dd HH:mm"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="7" style="text-align:center;padding:40px;color:#475569;">조회 결과가 없습니다.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                    <button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button>
                </c:forEach>
                <c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if>
                <span class="adm-page-info">${paging.currentPage} / ${paging.totalPage} 페이지</span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item" href="${pageContext.request.contextPath}/inquiry/list" target="_blank"
           style="background:#1e2330;color:#64748b;">
            <span class="adm-nav-icon">↗️</span> 문의 게시판 사이트 보기
        </a>
    </div>
</div>

<script>
function goPage(page) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/inquiries?' + params.toString();
}

var ctx = '${pageContext.request.contextPath}';

// 행 클릭 시 어드민 문의 상세 페이지 이동
var listParams = 'page=${search.page}&status=${search.status}&category=${search.category}&answered=${search.answered}&searchType=${search.searchType}&keyword=' + encodeURIComponent('${search.keyword}');
document.querySelectorAll('.adm-inq-row[data-id]').forEach(function (tr) {
    tr.addEventListener('click', function (e) {
        if (e.target.closest('td[data-useridx]')) return; // 작성자 셀 클릭은 모달로 처리
        location.href = '${pageContext.request.contextPath}/admin/inquiries/' + this.getAttribute('data-id') + '?' + listParams;
    });
});

// ── 작성자 모달 ──
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
