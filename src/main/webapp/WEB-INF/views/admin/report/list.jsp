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
                            <option value=""          ${empty search.status        ?'selected':''}>전체</option>
                            <option value="PENDING"   ${search.status=='PENDING'   ?'selected':''}>대기중</option>
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
                    <th>수정일</th>
                    <th>처리 어드민</th>
                    <th>상태</th>
                    <th>검토</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${reportList}" var="r">
                    <tr>
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

                        <%-- 사유: user 신고면 [사유 보기] 버튼 → 모달, 그 외 직접 표시 --%>
                        <td>
                            <c:choose>
                                <c:when test="${r.targetType eq 'user'}">
                                    <c:choose>
                                        <c:when test="${not empty r.reason}">
                                            <button class="adm-btn adm-btn-ghost rpt-reason-btn"
                                                    style="font-size:11px;padding:3px 8px;"
                                                    data-reason="${r.reason}">사유 보기</button>
                                        </c:when>
                                        <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <span style="font-size:12px;">${r.reason}</span>
                                </c:otherwise>
                            </c:choose>
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

                        <%-- 수정일 --%>
                        <td>
                            <fmt:formatDate value="${r.updatedAt}" pattern="yyyy.MM.dd"/>
                            <div class="mem-uid"><fmt:formatDate value="${r.updatedAt}" pattern="HH:mm"/></div>
                        </td>

                        <%-- 처리 어드민 --%>
                        <td>
                            <c:choose>
                                <c:when test="${not empty r.resolverIdx}">
                                    <span class="mem-uid">#${r.resolverIdx}</span>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 상태 배지 --%>
                        <td>
                            <span class="status-badge ${r.status}">
                                <c:choose>
                                    <c:when test="${r.status eq 'PENDING'}">대기중</c:when>
                                    <c:when test="${r.status eq 'RESOLVED'}">처리완료</c:when>
                                    <c:when test="${r.status eq 'DISMISSED'}">반려</c:when>
                                    <c:otherwise>${r.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>

                        <%-- 검토 버튼 --%>
                        <td>
                            <c:if test="${r.status eq 'PENDING'}">
                                <button class="adm-btn adm-btn-ghost rpt-review-btn"
                                        style="font-size:11px;padding:3px 10px;"
                                        data-id="${r.reportId}"
                                        data-target-type="${r.targetType}">검토</button>
                            </c:if>
                            <c:if test="${r.status ne 'PENDING'}">
                                <span style="color:#64748b;font-size:11px;">처리됨</span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reportList}">
                    <tr><td colspan="11" style="text-align:center;padding:40px;color:#475569;">조회 결과가 없습니다.</td></tr>
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

<%-- ── 사유 보기 모달 ── --%>
<div id="rpt-reason-modal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:9999;align-items:center;justify-content:center;">
    <div style="background:#1e2330;border-radius:12px;padding:28px 32px;min-width:320px;max-width:480px;box-shadow:0 8px 32px rgba(0,0,0,.4);">
        <div style="font-size:15px;font-weight:700;color:#f1f5f9;margin-bottom:12px;">신고 사유</div>
        <p id="rpt-reason-text" style="font-size:13px;color:#94a3b8;line-height:1.7;white-space:pre-wrap;"></p>
        <div style="text-align:right;margin-top:20px;">
            <button class="adm-btn adm-btn-ghost" id="rpt-reason-close" style="font-size:12px;">닫기</button>
        </div>
    </div>
</div>

<%-- ── 검토 모달 ── --%>
<div id="rpt-review-modal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:9999;align-items:center;justify-content:center;">
    <div style="background:#1e2330;border-radius:12px;padding:28px 32px;min-width:340px;box-shadow:0 8px 32px rgba(0,0,0,.4);">
        <div style="font-size:15px;font-weight:700;color:#f1f5f9;margin-bottom:6px;">신고 처리</div>
        <div id="rpt-review-desc" style="font-size:12px;color:#64748b;margin-bottom:20px;"></div>
        <input type="hidden" id="review-report-id" value="">
        <input type="hidden" id="review-target-type" value="">

        <%-- POST / COMMENT 전용 버튼 그룹 --%>
        <div id="rpt-btn-content" style="display:none;flex-direction:column;gap:8px;margin-bottom:12px;">
            <button class="adm-btn rpt-action-btn" data-action="DELETE_CONTENT"
                    style="font-size:12px;background:rgba(239,68,68,.15);color:#f87171;border:1px solid rgba(239,68,68,.3);width:100%;justify-content:center;">
                게시물 삭제 후 처리완료
            </button>
            <button class="adm-btn rpt-action-btn" data-action="BLOCK_AUTHOR"
                    style="font-size:12px;background:rgba(234,179,8,.15);color:#fbbf24;border:1px solid rgba(234,179,8,.3);width:100%;justify-content:center;">
                작성자 계정 차단 후 처리완료
            </button>
        </div>

        <%-- USER 전용 버튼 그룹 --%>
        <div id="rpt-btn-user" style="display:none;flex-direction:column;gap:8px;margin-bottom:12px;">
            <button class="adm-btn rpt-action-btn" data-action="BLOCK_USER"
                    style="font-size:12px;background:rgba(239,68,68,.15);color:#f87171;border:1px solid rgba(239,68,68,.3);width:100%;justify-content:center;">
                계정 차단 후 처리완료
            </button>
        </div>

        <%-- 공통 하단 버튼 --%>
        <div style="display:flex;gap:8px;justify-content:flex-end;border-top:1px solid rgba(255,255,255,.07);padding-top:12px;">
            <button class="adm-btn adm-btn-ghost" id="rpt-review-close" style="font-size:12px;">취소</button>
            <button class="adm-btn rpt-action-btn" data-action="REJECTED"
                    style="font-size:12px;background:rgba(100,116,139,.2);color:#94a3b8;border:1px solid rgba(100,116,139,.3);">
                유지 (반려)
            </button>
        </div>
    </div>
</div>

<script>
(function () {
    // ── 사유 보기 모달 ──
    var reasonModal = document.getElementById('rpt-reason-modal');
    var reasonText  = document.getElementById('rpt-reason-text');

    document.querySelectorAll('.rpt-reason-btn').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            e.stopPropagation();
            reasonText.textContent = this.getAttribute('data-reason') || '(사유 없음)';
            reasonModal.style.display = 'flex';
        });
    });
    document.getElementById('rpt-reason-close').addEventListener('click', function () {
        reasonModal.style.display = 'none';
    });
    reasonModal.addEventListener('click', function (e) {
        if (e.target === reasonModal) reasonModal.style.display = 'none';
    });

    // ── 검토 모달 ──
    var reviewModal      = document.getElementById('rpt-review-modal');
    var reviewReportId   = document.getElementById('review-report-id');
    var reviewTargetType = document.getElementById('review-target-type');
    var reviewDesc       = document.getElementById('rpt-review-desc');
    var btnContent       = document.getElementById('rpt-btn-content');
    var btnUser          = document.getElementById('rpt-btn-user');

    var typeLabel = { post: '게시글', comment: '댓글', user: '유저' };

    document.querySelectorAll('.rpt-review-btn').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            e.stopPropagation();
            var id   = this.getAttribute('data-id');
            var type = this.getAttribute('data-target-type');
            reviewReportId.value   = id;
            reviewTargetType.value = type;
            reviewDesc.textContent = '신고 대상: ' + (typeLabel[type] || type) + ' #' + id;
            // 버튼 그룹 전환
            btnContent.style.display = (type === 'post' || type === 'comment') ? 'flex' : 'none';
            btnUser.style.display    = (type === 'user') ? 'flex' : 'none';
            reviewModal.style.display = 'flex';
        });
    });
    document.getElementById('rpt-review-close').addEventListener('click', function () {
        reviewModal.style.display = 'none';
    });
    reviewModal.addEventListener('click', function (e) {
        if (e.target === reviewModal) reviewModal.style.display = 'none';
    });

    function resolveReport(action) {
        var reportId = reviewReportId.value;
        if (!reportId) return;
        fetch('${pageContext.request.contextPath}/admin/report/' + reportId + '/resolve', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'action=' + encodeURIComponent(action)
        })
        .then(function (res) { return res.json(); })
        .then(function (data) {
            if (data.success) {
                reviewModal.style.display = 'none';
                location.reload();
            } else {
                alert(data.message || '처리 중 오류가 발생했습니다.');
            }
        })
        .catch(function () { alert('네트워크 오류가 발생했습니다.'); });
    }

    document.querySelectorAll('.rpt-action-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            resolveReport(this.getAttribute('data-action'));
        });
    });
}());

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/reports?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
