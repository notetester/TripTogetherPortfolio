<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="community"/>
<c:set var="pageTitle" value="게시글 상세 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="${pageContext.request.contextPath}/admin/community"
           style="color:#64748b;text-decoration:none;font-size:13px;">← 목록으로</a>
    </div>

    <c:if test="${empty post}">
        <div class="adm-card" style="padding:40px;text-align:center;color:#64748b;">
            게시글을 찾을 수 없습니다.
        </div>
    </c:if>

    <c:if test="${not empty post}">

        <%-- ── 30일 경고 배너 ── --%>
        <c:if test="${post.authorResolveCount30d > 0}">
            <div style="background:#422006;border:1px solid #92400e;border-radius:8px;padding:14px 20px;
                        margin-bottom:16px;display:flex;align-items:center;gap:10px;">
                <span style="font-size:18px;">⚠️</span>
                <span style="color:#fed7aa;font-size:14px;">
                    이 게시글 작성자는 <strong>최근 30일 내 ${post.authorResolveCount30d}건</strong>의 신고가 처리된 이력이 있습니다.
                </span>
            </div>
        </c:if>

        <div style="display:grid;grid-template-columns:2fr 1fr;gap:20px;align-items:start;">

            <%-- ── 왼쪽: 게시글 내용 + 신고 목록 + 댓글 ── --%>
            <div>

                <%-- 게시글 카드 --%>
                <div class="adm-card" style="margin-bottom:20px;">
                    <div class="adm-card-head">
                        <div class="adm-card-title">게시글 #${post.postId}</div>
                        <div style="display:flex;gap:8px;align-items:center;">
                            <span class="status-badge ${post.postStatus}">
                                <c:choose>
                                    <c:when test="${post.postStatus == 'ACTIVE'}">활성</c:when>
                                    <c:when test="${post.postStatus == 'BLOCKED'}">차단됨</c:when>
                                    <c:when test="${post.postStatus == 'DELETED'}">삭제됨</c:when>
                                    <c:otherwise>${post.postStatus}</c:otherwise>
                                </c:choose>
                            </span>
                            <c:if test="${post.postStatus != 'DELETED'}">
                                <a href="${pageContext.request.contextPath}/community/${post.postId}"
                                   target="_blank"
                                   class="adm-btn adm-btn-ghost"
                                   style="font-size:12px;text-decoration:none;">원글 보기</a>
                            </c:if>
                            <c:if test="${post.postStatus != 'BLOCKED'}">
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:12px;color:#f87171;border-color:#f87171;"
                                        data-id="${post.postId}"
                                        onclick="actionPost(this.getAttribute('data-id'), 'block')">차단</button>
                            </c:if>
                            <c:if test="${post.postStatus != 'DELETED'}">
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:12px;color:#64748b;"
                                        data-id="${post.postId}"
                                        onclick="actionPost(this.getAttribute('data-id'), 'delete')">삭제</button>
                            </c:if>
                        </div>
                    </div>
                    <div class="adm-card-body">
                        <div style="margin-bottom:8px;">
                            <span class="adm-post-type-badge">
                                <c:choose>
                                    <c:when test="${post.postType == 'review'}">여행이야기</c:when>
                                    <c:when test="${post.postType == 'photo'}">사진</c:when>
                                    <c:when test="${post.postType == 'tip'}">여행팁</c:when>
                                    <c:when test="${post.postType == 'question'}">질문</c:when>
                                    <c:otherwise>${post.postType}</c:otherwise>
                                </c:choose>
                            </span>
                            <span style="font-size:11px;color:#64748b;">${post.region}</span>
                        </div>
                        <h3 class="adm-detail-title">${post.title}</h3>
                        <div class="adm-detail-body">${post.content}</div>
                        <div style="margin-top:16px;padding-top:12px;border-top:1px solid #1e2736;
                                    display:flex;gap:20px;font-size:12px;color:#64748b;">
                            <span>👁 ${post.viewCount}</span>
                            <span>❤ ${post.likeCount}</span>
                            <span>💬 ${post.commentCount}</span>
                            <c:if test="${post.reportCount > 0}">
                                <span style="color:#f87171;">🚨 신고 ${post.reportCount}건</span>
                            </c:if>
                            <span>
                                <fmt:formatDate value="${post.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
                            </span>
                        </div>
                    </div>
                </div>

                <%-- 신고 내역 카드 --%>
                <div class="adm-card" style="margin-bottom:20px;">
                    <div class="adm-card-head">
                        <div class="adm-card-title">신고 내역</div>
                        <div style="font-size:12px;color:#64748b;">${fn:length(reports)}건</div>
                    </div>
                    <c:choose>
                        <c:when test="${empty reports}">
                            <div style="padding:24px;text-align:center;color:#475569;font-size:13px;">신고 내역이 없습니다.</div>
                        </c:when>
                        <c:otherwise>
                            <div class="adm-table-wrap">
                                <table class="adm-table">
                                    <thead>
                                    <tr>
                                        <th>신고ID</th>
                                        <th>신고자</th>
                                        <th>사유</th>
                                        <th>신고일</th>
                                        <th>상태</th>
                                        <th>처리일</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${reports}" var="r">
                                        <tr>
                                            <td style="color:#64748b;font-size:12px;">#${r.reportId}</td>
                                            <td>
                                                <div style="font-size:13px;">${r.reporterNickname}</div>
                                                <div style="font-size:11px;color:#64748b;">${r.reporterUserId}</div>
                                            </td>
                                            <td style="font-size:12px;">
                                                <c:choose>
                                                    <c:when test="${r.reason == 'spam'}">스팸/광고</c:when>
                                                    <c:when test="${r.reason == 'abuse'}">욕설/비방</c:when>
                                                    <c:when test="${r.reason == 'privacy'}">개인정보</c:when>
                                                    <c:when test="${r.reason == 'adult'}">음란물</c:when>
                                                    <c:when test="${r.reason == 'illegal'}">불법 정보</c:when>
                                                    <c:otherwise>${r.reason}</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="font-size:11px;color:#64748b;">
                                                <fmt:formatDate value="${r.createdAt}" pattern="yyyy.MM.dd"/>
                                            </td>
                                            <td>
                                                <span class="status-badge ${r.status}" style="font-size:11px;">
                                                    <c:choose>
                                                        <c:when test="${r.status == 'RESOLVED'}">처리완료</c:when>
                                                        <c:when test="${r.status == 'DISMISSED'}">반려</c:when>
                                                        <c:otherwise>미처리</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td style="font-size:11px;color:#64748b;">
                                                <c:choose>
                                                    <c:when test="${not empty r.resolvedAt}">
                                                        <fmt:formatDate value="${r.resolvedAt}" pattern="yyyy.MM.dd"/>
                                                        <c:if test="${not empty r.resolveAction}">
                                                            <div style="color:#475569;">${r.resolveAction}</div>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>—</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- 댓글 목록 카드 --%>
                <div class="adm-card">
                    <div class="adm-card-head">
                        <div class="adm-card-title">댓글 목록</div>
                        <div style="font-size:12px;color:#64748b;">${fn:length(comments)}건</div>
                    </div>
                    <c:choose>
                        <c:when test="${empty comments}">
                            <div style="padding:24px;text-align:center;color:#475569;font-size:13px;">댓글이 없습니다.</div>
                        </c:when>
                        <c:otherwise>
                            <div style="padding:0 16px 16px;">
                                <c:forEach items="${comments}" var="comment">
                                    <div style="border-bottom:1px solid #1e2736;padding:12px 0;
                                                ${not empty comment.parentCommentId ? 'margin-left:24px;border-left:2px solid #1e2736;padding-left:12px;' : ''}">
                                        <%-- 댓글 헤더 --%>
                                        <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:6px;">
                                            <div style="display:flex;gap:12px;align-items:center;flex-wrap:wrap;">
                                                <div>
                                                    <span style="font-weight:600;font-size:13px;">${comment.nickname}</span>
                                                    <span style="font-size:11px;color:#64748b;margin-left:6px;">${comment.userId}</span>
                                                </div>
                                                <span style="font-size:10px;color:#94a3b8;font-family:monospace;">
                                                    <c:choose>
                                                        <c:when test="${not empty comment.lastIp}">${comment.lastIp}</c:when>
                                                        <c:otherwise>IP 없음</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <c:if test="${comment.accountStatus == 'BLOCKED'}">
                                                    <span style="font-size:10px;background:#7f1d1d;color:#fca5a5;padding:1px 5px;border-radius:3px;">계정차단</span>
                                                </c:if>
                                                <c:if test="${comment.authorResolveCount30d > 0}">
                                                    <span style="font-size:10px;background:#422006;color:#fb923c;padding:1px 5px;border-radius:3px;">
                                                        ⚠ 30일 ${comment.authorResolveCount30d}건
                                                    </span>
                                                </c:if>
                                                <span class="status-badge ${comment.commentStatus}" style="font-size:10px;">
                                                    <c:choose>
                                                        <c:when test="${comment.commentStatus == 'ACTIVE'}">활성</c:when>
                                                        <c:when test="${comment.commentStatus == 'BLOCKED'}">차단</c:when>
                                                        <c:otherwise>${comment.commentStatus}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <c:if test="${comment.reportCount > 0}">
                                                    <span style="font-size:10px;color:#f87171;">🚨 ${comment.reportCount}</span>
                                                </c:if>
                                            </div>
                                            <%-- 댓글 액션 --%>
                                            <div style="display:flex;gap:4px;flex-shrink:0;">
                                                <c:if test="${comment.commentStatus != 'BLOCKED'}">
                                                    <button class="adm-btn adm-btn-ghost"
                                                            style="font-size:11px;padding:2px 8px;color:#f87171;border-color:#f87171;"
                                                            data-id="${comment.commentId}"
                                                            onclick="actionComment(this.getAttribute('data-id'), 'block')">차단</button>
                                                </c:if>
                                                <button class="adm-btn adm-btn-ghost"
                                                        style="font-size:11px;padding:2px 8px;color:#64748b;"
                                                        data-id="${comment.commentId}"
                                                        onclick="actionComment(this.getAttribute('data-id'), 'delete')">삭제</button>
                                            </div>
                                        </div>
                                        <%-- 댓글 내용 --%>
                                        <div style="font-size:13px;color:#cbd5e1;line-height:1.6;">${comment.content}</div>
                                        <div style="font-size:11px;color:#475569;margin-top:4px;">
                                            <fmt:formatDate value="${comment.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
                                            <c:if test="${not empty comment.parentCommentId}">
                                                <span style="margin-left:8px;color:#334155;">↩ 대댓글</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <%-- ── 오른쪽: 작성자 정보 ── --%>
            <div>
                <div class="adm-card" style="position:sticky;top:80px;">
                    <div class="adm-card-head">
                        <div class="adm-card-title">작성자 정보</div>
                    </div>
                    <div class="adm-card-body">
                        <div style="display:flex;flex-direction:column;gap:12px;">

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;">아이디</div>
                                <div style="font-size:14px;font-weight:600;">${post.userId}</div>
                            </div>

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;">닉네임</div>
                                <div style="font-size:14px;font-weight:600;">${post.nickname}</div>
                            </div>

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;">최근 접속 IP</div>
                                <div style="font-size:13px;font-family:monospace;color:#94a3b8;">
                                    <c:choose>
                                        <c:when test="${not empty post.lastIp}">${post.lastIp}</c:when>
                                        <c:otherwise><span style="color:#475569;">기록 없음</span></c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;">계정 상태</div>
                                <span class="status-badge ${post.accountStatus}">
                                    <c:choose>
                                        <c:when test="${post.accountStatus == 'ACTIVE'}">정상</c:when>
                                        <c:when test="${post.accountStatus == 'BLOCKED'}">차단됨</c:when>
                                        <c:when test="${post.accountStatus == 'DORMANT'}">휴면</c:when>
                                        <c:when test="${post.accountStatus == 'DELETED'}">탈퇴</c:when>
                                        <c:otherwise>${post.accountStatus}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <c:if test="${post.authorResolveCount30d > 0}">
                                <div style="background:#422006;border-radius:6px;padding:10px;">
                                    <div style="font-size:11px;color:#fb923c;font-weight:600;margin-bottom:4px;">⚠ 30일 신고 처리 이력</div>
                                    <div style="font-size:13px;color:#fed7aa;">${post.authorResolveCount30d}건 처리됨</div>
                                </div>
                            </c:if>

                            <div style="border-top:1px solid #1e2736;padding-top:12px;display:flex;flex-direction:column;gap:6px;">
                                <a href="${pageContext.request.contextPath}/admin/members?searchType=userId&keyword=${post.userId}"
                                   class="adm-btn adm-btn-ghost" style="text-align:center;font-size:12px;">
                                    회원 정보 보기
                                </a>
                                <c:if test="${post.accountStatus != 'BLOCKED'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:12px;color:#f87171;border-color:#f87171;"
                                            data-useridx="${post.userIdx}"
                                            onclick="blockUser(this.getAttribute('data-useridx'))">
                                        작성자 계정 차단
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </c:if>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';

function actionPost(postId, action) {
    var label = action === 'block' ? '차단' : '삭제';
    if (!confirm('게시글을 ' + label + '하시겠습니까?')) return;
    fetch(ctx + '/admin/community/posts/' + postId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 실패'); }
    });
}

function actionComment(commentId, action) {
    var label = action === 'block' ? '차단' : '삭제';
    if (!confirm('댓글을 ' + label + '하시겠습니까?')) return;
    fetch(ctx + '/admin/community/comments/' + commentId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 실패'); }
    });
}

function blockUser(userIdx) {
    if (!confirm('작성자 계정을 차단하시겠습니까?\n이 작업은 해당 사용자의 모든 활동을 중단시킵니다.')) return;
    fetch(ctx + '/admin/community/users/' + userIdx + '/block', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 실패'); }
    });
}
</script>

<%@ include file="../layout-close.jsp" %>
