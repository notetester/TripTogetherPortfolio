<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="courses"/>
<c:set var="pageTitle" value="여행코스 상세"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="${pageContext.request.contextPath}/admin/courses" class="adm-back-link">← 목록으로</a>
    </div>

    <c:if test="${empty plan}">
        <div class="adm-card" style="padding:40px;text-align:center;color:#64748b;">
            해당 코스를 찾을 수 없습니다.
        </div>
    </c:if>

    <c:if test="${not empty plan}">

        <%-- ── 코스 헤더 ── --%>
        <div class="adm-card" style="margin-bottom:20px;">
            <div class="adm-card-head">
                <div style="display:flex;align-items:center;gap:12px;">
                    <span class="adm-card-title" style="font-size:16px;">#${plan.planId} · ${plan.title}</span>
                    <c:choose>
                        <c:when test="${plan.isDeleted == 0}">
                            <span class="status-badge ACTIVE">활성</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge DELETED">삭제됨</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="display:flex;gap:6px;">
                    <c:choose>
                        <c:when test="${plan.isDeleted == 0}">
                            <button class="adm-btn adm-btn-ghost"
                                    style="color:#f87171;border-color:#f87171;"
                                    onclick="actionPlan('delete')">삭제</button>
                        </c:when>
                        <c:otherwise>
                            <button class="adm-btn adm-btn-ghost"
                                    style="color:#34d399;border-color:#34d399;"
                                    onclick="actionPlan('restore')">복구</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="adm-card-body">
                <div style="display:grid;grid-template-columns:repeat(4, minmax(0, 1fr));gap:14px;">
                    <div>
                        <div class="adm-filter-label">작성자</div>
                        <div style="font-weight:600;color:#7dd3fc;">${plan.nickname}</div>
                        <div style="font-size:11px;color:#64748b;">${plan.userId}</div>
                        <c:if test="${plan.accountStatus == 'BLOCKED'}">
                            <span class="adm-inline-danger">계정 차단됨</span>
                        </c:if>
                    </div>
                    <div>
                        <div class="adm-filter-label">여행지</div>
                        <div style="font-size:13px;color:#cbd5e1;">
                            <c:choose>
                                <c:when test="${not empty plan.destination}">${plan.destination}</c:when>
                                <c:otherwise><span style="color:#475569;">—</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">일정</div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${not empty plan.startDate}">
                                    <fmt:formatDate value="${plan.startDate}" pattern="yyyy.MM.dd"/>
                                    ~ <fmt:formatDate value="${plan.endDate}" pattern="yyyy.MM.dd"/>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">—</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">스팟 수</div>
                        <div style="color:#7dd3fc;font-weight:600;">${plan.spotCount}개</div>
                    </div>
                    <div>
                        <div class="adm-filter-label">생성유형</div>
                        <div style="font-size:13px;">
                            <c:choose>
                                <c:when test="${plan.planSource == 'AI'}">
                                    <span style="color:#a78bfa;font-weight:600;">AI 생성</span>
                                </c:when>
                                <c:when test="${plan.planSource == 'MANUAL'}">
                                    <span style="color:#94a3b8;">수동 작성</span>
                                </c:when>
                                <c:otherwise>${plan.planSource}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">공개 여부</div>
                        <div style="font-size:13px;">
                            <c:choose>
                                <c:when test="${plan.isPublic == 1}"><span style="color:#34d399;">공개</span></c:when>
                                <c:otherwise><span style="color:#64748b;">비공개</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">등록일</div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <fmt:formatDate value="${plan.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">수정일</div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${not empty plan.updatedAt}">
                                    <fmt:formatDate value="${plan.updatedAt}" pattern="yyyy.MM.dd HH:mm"/>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">—</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- ── 스팟 목록 ── --%>
        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">일정별 스팟</div>
                <div class="adm-muted-note">총 ${fn:length(spots)}개</div>
            </div>

            <c:if test="${empty spots}">
                <div style="padding:40px;text-align:center;color:#475569;">등록된 스팟이 없습니다.</div>
            </c:if>

            <c:if test="${not empty spots}">
                <c:set var="prevDate" value=""/>
                <div style="padding:10px 20px 20px;">
                <c:forEach items="${spots}" var="s">
                    <fmt:formatDate value="${s.visitDate}" pattern="yyyy-MM-dd" var="curDate"/>
                    <c:if test="${curDate != prevDate}">
                        <c:if test="${prevDate != ''}"></div></c:if>
                        <div style="margin-top:16px;padding:8px 12px;background:#1e293b;border-radius:6px;
                                    font-weight:600;font-size:13px;color:#7dd3fc;">
                            <fmt:formatDate value="${s.visitDate}" pattern="yyyy.MM.dd (E)"/>
                        </div>
                        <div style="border-left:2px solid #334155;margin-left:12px;padding-left:14px;margin-top:6px;">
                        <c:set var="prevDate" value="${curDate}"/>
                    </c:if>
                    <div style="padding:10px 0;border-bottom:1px dashed #334155;">
                        <div style="display:flex;align-items:center;gap:10px;">
                            <span style="display:inline-block;min-width:28px;height:28px;line-height:28px;
                                         text-align:center;background:#334155;color:#cbd5e1;border-radius:50%;
                                         font-size:12px;font-weight:600;">${s.visitOrder}</span>
                            <div style="flex:1;">
                                <div style="font-weight:600;font-size:14px;color:#e2e8f0;">
                                    <c:choose>
                                        <c:when test="${not empty s.placeName}">${s.placeName}</c:when>
                                        <c:when test="${not empty s.spotName}">${s.spotName}</c:when>
                                        <c:otherwise><span style="color:#64748b;">이름 없음</span></c:otherwise>
                                    </c:choose>
                                </div>
                                <div style="font-size:11px;color:#64748b;margin-top:2px;">
                                    <c:if test="${not empty s.spotRegion}">${s.spotRegion} · </c:if>
                                    <c:if test="${not empty s.spotId}">spot_id: ${s.spotId}</c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </div>
                </div>
            </c:if>
        </div>
    </c:if>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var PLAN_ID = '${plan.planId}';

function actionPlan(action) {
    var label = action === 'delete' ? '삭제' : '복구';
    if (!confirm('이 코스를 ' + label + '하시겠습니까?')) return;
    fetch(ctx + '/admin/courses/' + PLAN_ID + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 중 오류가 발생했습니다.'); }
    });
}
</script>

<%@ include file="../layout-close.jsp" %>
