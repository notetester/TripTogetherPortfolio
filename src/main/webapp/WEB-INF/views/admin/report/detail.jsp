<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="reports"/>
<c:set var="pageTitle" value="신고 상세"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="javascript:goBackToList()" style="color:#64748b;text-decoration:none;font-size:13px;">← 목록으로</a>
    </div>

    <div style="display:grid;grid-template-columns:2fr 1fr;gap:20px;align-items:start;">

        <%-- ── 왼쪽: 신고 내용 ── --%>
        <div>
            <div class="adm-card">
                <div class="adm-card-head">
                    <div class="adm-card-title">신고 #${report.reportId}</div>
                    <div style="display:flex;gap:8px;align-items:center;">
                        <span class="status-badge ${report.status}">
                            <c:choose>
                                <c:when test="${report.status eq 'IN_REVIEW'}">검토중</c:when>
                                <c:when test="${report.status eq 'RESOLVED'}">처리완료</c:when>
                                <c:when test="${report.status eq 'DISMISSED'}">반려</c:when>
                                <c:otherwise>${report.status}</c:otherwise>
                            </c:choose>
                        </span>
                        <%-- post: 해당 게시글로 이동 / comment: sourceId(게시글 ID)로 원글 이동 --%>
                        <c:if test="${report.targetType eq 'post'}">
                            <a href="${pageContext.request.contextPath}/community/${report.targetId}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost"
                               style="font-size:12px;text-decoration:none;">원글 보기</a>
                        </c:if>
                        <c:if test="${report.targetType eq 'comment'}">
                            <a href="${pageContext.request.contextPath}/community/${report.sourceId}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost"
                               style="font-size:12px;text-decoration:none;">원글 보기</a>
                        </c:if>
                    </div>
                </div>
                <div class="adm-card-body">

                    <%-- 대상 정보 --%>
                    <div style="display:flex;flex-direction:column;gap:14px;">
                        <div style="display:flex;gap:12px;">
                            <div style="min-width:90px;font-size:12px;color:#64748b;">신고 대상</div>
                            <div class="adm-detail-value">
                                <c:choose>
                                    <c:when test="${report.targetType eq 'post'}">게시글</c:when>
                                    <c:when test="${report.targetType eq 'comment'}">댓글</c:when>
                                    <c:when test="${report.targetType eq 'user'}">유저</c:when>
                                    <c:otherwise>${report.targetType}</c:otherwise>
                                </c:choose>
                                <span style="color:#64748b;margin-left:4px;">#${report.targetId}</span>
                            </div>
                        </div>

                        <div style="display:flex;gap:12px;">
                            <div style="min-width:90px;font-size:12px;color:#64748b;">신고 사유</div>
                            <div class="adm-detail-value">
                                <c:choose>
                                    <c:when test="${report.reason eq 'spam'}">스팸/광고</c:when>
                                    <c:when test="${report.reason eq 'abuse'}">욕설/비방</c:when>
                                    <c:when test="${report.reason eq 'privacy'}">개인정보 노출</c:when>
                                    <c:when test="${report.reason eq 'adult'}">음란물</c:when>
                                    <c:when test="${report.reason eq 'illegal'}">불법 정보</c:when>
                                    <c:when test="${report.reason eq 'other'}">기타</c:when>
                                    <c:when test="${report.reason eq 'user'}">유저 신고</c:when>
                                    <c:when test="${not empty report.reason}">${report.reason}</c:when>
                                    <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <c:if test="${not empty report.description}">
                            <div style="display:flex;gap:12px;">
                                <div style="min-width:90px;font-size:12px;color:#64748b;">상세 설명</div>
                                <div class="adm-report-desc">${report.description}</div>
                            </div>
                        </c:if>

                        <div style="display:flex;gap:12px;">
                            <div style="min-width:90px;font-size:12px;color:#64748b;">동일 대상 신고</div>
                            <div style="font-size:13px;">
                                <c:choose>
                                    <c:when test="${report.targetReportCount >= 3}">
                                        <span style="color:#f87171;font-weight:700;">🔴 ${report.targetReportCount}건</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color:#94a3b8;">${report.targetReportCount}건</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div style="border-top:1px solid #1e2736;padding-top:12px;
                                    display:flex;gap:20px;font-size:12px;color:#64748b;">
                            <span>신고일 <fmt:formatDate value="${report.createdAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                            <c:if test="${not empty report.resolvedAt}">
                                <span>처리일 <fmt:formatDate value="${report.resolvedAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                            </c:if>
                            <c:if test="${not empty report.resolveAction}">
                                <span>처리 내용: ${report.resolveAction}</span>
                            </c:if>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <%-- ── 오른쪽: 신고자 정보 + 처리 버튼 ── --%>
        <div>
            <div class="adm-card" style="position:sticky;top:80px;">
                <div class="adm-card-head">
                    <div class="adm-card-title">신고자 정보</div>
                </div>
                <div class="adm-card-body">
                    <div style="display:flex;flex-direction:column;gap:12px;">

                        <div>
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;">아이디</div>
                            <div style="font-size:14px;font-weight:600;">${report.userId}</div>
                        </div>
                        <div>
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;">닉네임</div>
                            <div style="font-size:14px;font-weight:600;">${report.nickname}</div>
                        </div>

                        <div style="border-top:1px solid #1e2736;padding-top:12px;">
                            <a href="${pageContext.request.contextPath}/admin/members?searchType=userId&keyword=${report.userId}"
                               class="adm-btn adm-btn-ghost"
                               style="text-align:center;font-size:12px;text-decoration:none;display:block;">
                                회원 정보 보기
                            </a>
                        </div>

                        <%-- 처리 버튼: targetType에 따라 조건부 --%>
                        <div style="border-top:1px solid #1e2736;padding-top:12px;">
                            <div style="font-size:11px;color:#64748b;margin-bottom:8px;">처리</div>
                            <div style="display:flex;flex-direction:column;gap:6px;">

                                <%-- post / comment 공통 버튼 --%>
                                <c:if test="${report.targetType eq 'post' or report.targetType eq 'comment'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;color:#94a3b8;border-color:#94a3b8;"
                                            onclick="resolve('REJECTED')">반려 (콘텐츠 유지)</button>
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;color:#fb923c;border-color:#fb923c;"
                                            onclick="resolve('DELETE_CONTENT')">콘텐츠 삭제</button>
                                    <c:if test="${report.targetUserRole ne 'SYSTEM'}">
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;color:#f87171;border-color:#f87171;"
                                                onclick="resolve('BLOCK_AUTHOR')">작성자 차단</button>
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;color:#dc2626;border-color:#dc2626;"
                                                onclick="resolve('DELETE_AND_BLOCK')">삭제 + 작성자 차단</button>
                                    </c:if>
                                </c:if>

                                <%-- user 대상 버튼 --%>
                                <c:if test="${report.targetType eq 'user'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;color:#94a3b8;border-color:#94a3b8;"
                                            onclick="resolve('REJECTED')">반려 (계정 유지)</button>
                                    <c:if test="${report.targetUserRole ne 'SYSTEM'}">
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;color:#f87171;border-color:#f87171;"
                                                onclick="resolve('BLOCK_USER')">유저 차단</button>
                                    </c:if>
                                </c:if>

                                <%-- 처리된 신고: 검토중 복원 버튼 --%>
                                <c:if test="${report.status eq 'RESOLVED' or report.status eq 'DISMISSED'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;color:#7dd3fc;border-color:#7dd3fc;margin-top:4px;"
                                            onclick="resolve('REVERT_TO_PENDING')">검토중으로 복원</button>
                                </c:if>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
var ctx      = '${pageContext.request.contextPath}';
var reportId = ${report.reportId};

function goBackToList() {
    var params = new URLSearchParams(window.location.search);
    var page       = params.get('page')       || '1';
    var status     = params.get('status')     || '';
    var targetType = params.get('targetType') || '';
    var reason     = params.get('reason')     || '';
    var keyword    = params.get('keyword')    || '';
    var url = ctx + '/admin/reports?page=' + page;
    if (status)     url += '&status='     + encodeURIComponent(status);
    if (targetType) url += '&targetType=' + encodeURIComponent(targetType);
    if (reason)     url += '&reason='     + encodeURIComponent(reason);
    if (keyword)    url += '&keyword='    + encodeURIComponent(keyword);
    location.href = url;
}

var actionLabels = {
    REJECTED:         '반려 처리하시겠습니까?',
    DELETE_CONTENT:   '콘텐츠를 삭제하시겠습니까?',
    BLOCK_AUTHOR:     '작성자를 차단하시겠습니까?',
    BLOCK_USER:       '해당 유저를 차단하시겠습니까?',
    DELETE_AND_BLOCK: '콘텐츠를 삭제하고 작성자를 차단하시겠습니까?',
    REVERT_TO_PENDING:'검토중 상태로 복원하시겠습니까?'
};

function resolve(action) {
    if (!confirm(actionLabels[action] || '처리하시겠습니까?')) return;
    fetch(ctx + '/admin/report/' + reportId + '/resolve', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: 'action=' + encodeURIComponent(action)
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 실패'); }
    });
}
</script>

<%@ include file="../layout-close.jsp" %>
