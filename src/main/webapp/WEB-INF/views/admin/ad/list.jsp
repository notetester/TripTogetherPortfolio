<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="ads"/>
<c:set var="pageTitle" value="광고 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <c:if test="${not empty adMessage}">
        <div class="adm-card" style="padding:12px 16px;margin-bottom:16px;background:#dcfce7;color:#15803d;border:1px solid #86efac;">
            ${adMessage}
        </div>
    </c:if>
    <c:if test="${not empty adError}">
        <div class="adm-card" style="padding:12px 16px;margin-bottom:16px;background:#fee2e2;color:#b91c1c;border:1px solid #fca5a5;">
            ${adError}
        </div>
    </c:if>

    <%-- 상단 액션 바 --%>
    <div class="adm-card" style="padding:16px;margin-bottom:16px;display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;">
        <form method="get" action="${pageContext.request.contextPath}/admin/ads" style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
            <select name="slotCode" class="adm-input" style="padding:8px 12px;font-size:13px;">
                <option value="">전체 슬롯</option>
                <option value="community_list_top"      ${slotCodeFilter eq 'community_list_top'      ? 'selected' : ''}>커뮤니티 목록 상단</option>
                <option value="community_detail_bottom" ${slotCodeFilter eq 'community_detail_bottom' ? 'selected' : ''}>커뮤니티 상세 하단</option>
            </select>
            <label style="display:inline-flex;align-items:center;gap:6px;font-size:13px;color:#475569;">
                <input type="checkbox" name="activeOnly" value="true" ${activeOnly ? 'checked' : ''}/> 활성만 보기
            </label>
            <button type="submit" class="adm-btn adm-btn-ghost">적용</button>
        </form>
        <a href="${pageContext.request.contextPath}/admin/ads/new" class="adm-btn adm-btn-primary">＋ 광고 등록</a>
    </div>

    <%-- 목록 테이블 --%>
    <div class="adm-card" style="padding:0;overflow-x:auto;">
        <table class="adm-table" style="width:100%;">
            <thead>
                <tr>
                    <th style="width:88px;">이미지</th>
                    <th>제목</th>
                    <th style="width:140px;">슬롯</th>
                    <th>링크</th>
                    <th>기간</th>
                    <th>노출 / 클릭</th>
                    <th>활성</th>
                    <th style="width:180px;">액션</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty adList}">
                        <tr><td colspan="8" style="text-align:center;padding:48px;color:#94a3b8;">등록된 광고가 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="ad" items="${adList}">
                            <tr data-ad-id="${ad.adId}">
                                <td>
                                    <c:if test="${not empty ad.imageUrl}">
                                        <img src="${ad.imageUrl}" alt="" style="width:80px;height:40px;object-fit:cover;border-radius:4px;"/>
                                    </c:if>
                                </td>
                                <td>
                                    <div style="font-weight:600;">${ad.title}</div>
                                    <c:if test="${not empty ad.creatorNickname}">
                                        <div style="font-size:11px;color:#94a3b8;margin-top:2px;">by ${ad.creatorNickname}</div>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${ad.slotCode eq 'community_list_top'}">
                                            <span style="font-size:11px;color:#1d4ed8;background:#dbeafe;padding:2px 8px;border-radius:999px;white-space:nowrap;">커뮤니티 목록 상단</span>
                                        </c:when>
                                        <c:when test="${ad.slotCode eq 'community_detail_bottom'}">
                                            <span style="font-size:11px;color:#6d28d9;background:#ede9fe;padding:2px 8px;border-radius:999px;white-space:nowrap;">커뮤니티 상세 하단</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="font-size:11px;color:#64748b;background:#f1f5f9;padding:2px 8px;border-radius:999px;white-space:nowrap;">${ad.slotCode}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-size:12px;color:#475569;">
                                    <c:choose>
                                        <c:when test="${ad.linkType eq 'INTERNAL'}">
                                            <span style="color:#0d9488;">(내부) ${ad.linkTargetType}<c:if test="${not empty ad.linkTargetId}"> #${ad.linkTargetId}</c:if></span>
                                        </c:when>
                                        <c:when test="${ad.linkType eq 'NONE'}">
                                            <span style="color:#94a3b8;">(액션 없음)</span>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${not empty ad.linkUrl}">
                                                <a href="${ad.linkUrl}" target="_blank" rel="noopener" style="color:#2563eb;">${ad.linkUrl}</a>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="font-size:12px;color:#475569;">
                                    <c:choose>
                                        <c:when test="${empty ad.startAt and empty ad.endAt}">상시</c:when>
                                        <c:otherwise>
                                            <c:if test="${not empty ad.startAt}"><fmt:formatDate value="${ad.startAt}" pattern="yyyy-MM-dd HH:mm"/></c:if>
                                            ~
                                            <c:if test="${not empty ad.endAt}"><fmt:formatDate value="${ad.endAt}" pattern="yyyy-MM-dd HH:mm"/></c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="font-size:12px;color:#475569;">
                                    👁 ${ad.viewCount} · 👆 ${ad.clickCount}
                                </td>
                                <td style="text-align:center;">
                                    <label class="adm-switch" style="cursor:pointer;">
                                        <input type="checkbox" class="ad-active-toggle" data-ad-id="${ad.adId}" ${ad.isActive ? 'checked' : ''}/>
                                        <span>${ad.isActive ? 'ON' : 'OFF'}</span>
                                    </label>
                                </td>
                                <td>
                                    <div style="display:flex;gap:6px;">
                                        <a href="${pageContext.request.contextPath}/admin/ads/${ad.adId}/edit" class="adm-btn adm-btn-ghost" style="padding:4px 10px;font-size:12px;">수정</a>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/ads/${ad.adId}/delete"
                                              onsubmit="return confirm('이 광고를 삭제할까요?');" style="display:inline;">
                                            <button type="submit" class="adm-btn adm-btn-ghost" style="padding:4px 10px;font-size:12px;color:#dc2626;">삭제</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<script>
(function () {
    var CTX = '${pageContext.request.contextPath}';
    document.querySelectorAll('.ad-active-toggle').forEach(function (cb) {
        cb.addEventListener('change', function () {
            var adId = cb.dataset.adId;
            var isActive = cb.checked;
            fetch(CTX + '/admin/ads/' + adId + '/toggle-active', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
                body: new URLSearchParams({ isActive: isActive })
            })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (!data.success) {
                    alert('상태 변경 실패');
                    cb.checked = !isActive;
                } else {
                    var label = cb.nextElementSibling;
                    if (label) label.textContent = isActive ? 'ON' : 'OFF';
                }
            })
            .catch(function () {
                alert('상태 변경 중 오류');
                cb.checked = !isActive;
            });
        });
    });
})();
</script>

<%@ include file="../layout-close.jsp" %>
