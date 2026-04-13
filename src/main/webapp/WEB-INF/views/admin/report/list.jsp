<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="reports"/>
<c:set var="pageTitle" value="신고 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/reports">
                <div class="adm-filter-bar">

                    <div>
                        <div class="adm-filter-label">상태</div>
                        <select class="adm-select" name="status">
                            <option value=""           ${empty search.status         ?'selected':''}>전체</option>
                            <option value="IN_REVIEW" ${search.status=='IN_REVIEW' ?'selected':''}>검토중</option>
                            <option value="RESOLVED"  ${search.status=='RESOLVED'  ?'selected':''}>처리완료</option>
                            <option value="DISMISSED" ${search.status=='DISMISSED' ?'selected':''}>반려</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">대상 유형</div>
                        <select class="adm-select" name="targetType">
                            <option value=""        ${empty search.targetType       ?'selected':''}>전체</option>
                            <option value="post"    ${search.targetType=='post'    ?'selected':''}>게시글</option>
                            <option value="comment" ${search.targetType=='comment' ?'selected':''}>댓글</option>
                            <option value="user"    ${search.targetType=='user'    ?'selected':''}>유저</option>
                        </select>
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
                        <td>
                            <div class="mem-name">${r.nickname}</div>
                            <div class="mem-uid">#${r.userIdx}</div>
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
</div>

<script>
// 행 클릭 시 신고 상세 페이지 이동
document.querySelectorAll('.rpt-admin-row[data-id]').forEach(function (tr) {
    tr.addEventListener('click', function () {
        location.href = '${pageContext.request.contextPath}/report/' + this.getAttribute('data-id');
    });
});

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/reports?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
