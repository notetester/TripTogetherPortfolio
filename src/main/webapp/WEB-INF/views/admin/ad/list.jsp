<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="ads"/>
<c:set var="pageTitle" value="광고 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content adm-ad-page">
    <spring:message var="msg_admin_ad_totalCountDisplay" code="admin.common.totalCountFormat" arguments="${fn:length(adList)}"/>
    <c:url var="adCreateUrl" value="/admin/ads/new">
        <c:if test="${not empty slotCodeFilter}">
            <c:param name="returnSlotCode" value="${slotCodeFilter}"/>
        </c:if>
        <c:if test="${activeOnly}">
            <c:param name="returnActiveOnly" value="true"/>
        </c:if>
    </c:url>

    <c:if test="${not empty adMessage}">
        <div class="adm-alert adm-alert-success adm-ad-alert">
            ${adMessage}
        </div>
    </c:if>
    <c:if test="${not empty adError}">
        <div class="adm-alert adm-alert-danger adm-ad-alert">
            ${adError}
        </div>
    </c:if>

    <%-- 상단 액션 바 --%>
    <div class="adm-card adm-ad-filter-card">
        <div class="adm-ad-toolbar">
            <form method="get" action="${pageContext.request.contextPath}/admin/ads" class="adm-ad-filter-form">
                <div class="adm-ad-filter-field">
                    <label class="adm-filter-label" for="slotCode">슬롯</label>
                    <select id="slotCode" name="slotCode" class="adm-select adm-ad-filter-select">
                        <option value="">전체 슬롯</option>
                        <option value="community_list_top"      ${slotCodeFilter eq 'community_list_top'      ? 'selected' : ''}>커뮤니티 목록 상단</option>
                        <option value="community_detail_bottom" ${slotCodeFilter eq 'community_detail_bottom' ? 'selected' : ''}>커뮤니티 상세 하단</option>
                    </select>
                </div>
                <label class="adm-ad-active-filter">
                    <input type="checkbox" name="activeOnly" value="true" ${activeOnly ? 'checked' : ''}/>
                    <span>활성만 보기</span>
                </label>
                <div class="adm-ad-filter-actions">
                    <button type="submit" class="adm-btn adm-btn-primary">적용</button>
                    <a href="${pageContext.request.contextPath}/admin/ads" class="adm-btn adm-btn-ghost">초기화</a>
                </div>
            </form>
            <a href="${adCreateUrl}" class="adm-btn adm-btn-primary adm-ad-create-btn">＋ 광고 등록</a>
        </div>
    </div>

    <%-- 목록 테이블 --%>
    <div class="adm-card adm-ad-list-card">
        <div class="adm-card-head adm-ad-list-head">
            <div class="adm-card-title">
                광고 목록
                <span class="adm-section-total-inline">${msg_admin_ad_totalCountDisplay}</span>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table adm-ad-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-ad-col-image"/>
                    <col class="adm-ad-col-title"/>
                    <col class="adm-ad-col-slot"/>
                    <col class="adm-ad-col-link"/>
                    <col class="adm-ad-col-period"/>
                    <col class="adm-ad-col-count"/>
                    <col class="adm-ad-col-active"/>
                    <col class="adm-ad-col-action"/>
                </colgroup>
                <thead>
                    <tr>
                        <th onclick="adThClick(this)">이미지</th>
                        <th onclick="adThClick(this)">제목</th>
                        <th onclick="adThClick(this)">슬롯</th>
                        <th onclick="adThClick(this)">링크</th>
                        <th onclick="adThClick(this)">기간</th>
                        <th onclick="adThClick(this)">노출 / 클릭</th>
                        <th onclick="adThClick(this)">활성</th>
                        <th onclick="adThClick(this)">액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty adList}">
                            <tr>
                                <td colspan="8" class="adm-local-empty-cell adm-ad-empty">등록된 광고가 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="ad" items="${adList}">
                                <c:url var="adEditUrl" value="/admin/ads/${ad.adId}/edit">
                                    <c:if test="${not empty slotCodeFilter}">
                                        <c:param name="returnSlotCode" value="${slotCodeFilter}"/>
                                    </c:if>
                                    <c:if test="${activeOnly}">
                                        <c:param name="returnActiveOnly" value="true"/>
                                    </c:if>
                                </c:url>
                                <tr data-ad-id="${ad.adId}">
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty ad.imageUrl}">
                                                <img src="${ad.imageUrl}" alt="" class="adm-ad-thumb"/>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="adm-ad-thumb adm-ad-thumb-empty">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="adm-ad-title">${ad.title}</div>
                                        <c:if test="${not empty ad.creatorNickname}">
                                            <div class="adm-ad-creator">by ${ad.creatorNickname}</div>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ad.slotCode eq 'community_list_top'}">
                                                <span class="adm-ad-slot-badge is-community-list">커뮤니티 목록 상단</span>
                                            </c:when>
                                            <c:when test="${ad.slotCode eq 'community_detail_bottom'}">
                                                <span class="adm-ad-slot-badge is-community-detail">커뮤니티 상세 하단</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="adm-ad-slot-badge is-default">${ad.slotCode}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="adm-ad-link-cell">
                                        <c:choose>
                                            <c:when test="${ad.linkType eq 'INTERNAL'}">
                                                <span class="adm-ad-link-internal">(내부) ${ad.linkTargetType}<c:if test="${not empty ad.linkTargetId}"> #${ad.linkTargetId}</c:if></span>
                                            </c:when>
                                            <c:when test="${ad.linkType eq 'NONE'}">
                                                <span class="adm-ad-link-none">(액션 없음)</span>
                                            </c:when>
                                            <c:otherwise>
                                                <c:if test="${not empty ad.linkUrl}">
                                                    <a href="${ad.linkUrl}" target="_blank" rel="noopener" class="adm-ad-link-url">${ad.linkUrl}</a>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="adm-ad-period-cell">
                                        <c:choose>
                                            <c:when test="${empty ad.startAt and empty ad.endAt}">상시</c:when>
                                            <c:otherwise>
                                                <c:if test="${not empty ad.startAt}"><fmt:formatDate value="${ad.startAt}" pattern="yyyy-MM-dd HH:mm"/></c:if>
                                                ~
                                                <c:if test="${not empty ad.endAt}"><fmt:formatDate value="${ad.endAt}" pattern="yyyy-MM-dd HH:mm"/></c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="adm-ad-count-cell">
                                        <span class="adm-ad-count-pill">노출 ${ad.viewCount}</span>
                                        <span class="adm-ad-count-pill">클릭 ${ad.clickCount}</span>
                                    </td>
                                    <td class="adm-ad-active-cell">
                                        <label class="adm-switch adm-ad-switch">
                                            <input type="checkbox" class="ad-active-toggle" data-ad-id="${ad.adId}" ${ad.isActive ? 'checked' : ''}/>
                                            <span>${ad.isActive ? 'ON' : 'OFF'}</span>
                                        </label>
                                    </td>
                                    <td>
                                        <div class="adm-row-actions adm-ad-row-actions">
                                            <a href="${adEditUrl}" class="adm-row-btn detail">수정</a>
                                            <form method="post" action="${pageContext.request.contextPath}/admin/ads/${ad.adId}/delete"
                                                  onsubmit="return confirm('이 광고를 삭제할까요?');" class="adm-ad-inline-form">
                                                <c:if test="${not empty slotCodeFilter}">
                                                    <input type="hidden" name="slotCode" value="${slotCodeFilter}"/>
                                                </c:if>
                                                <input type="hidden" name="activeOnly" value="${activeOnly}"/>
                                                <button type="submit" class="adm-row-btn danger">삭제</button>
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

/* ── 헤더 클릭: 첫 행의 같은 컬럼 셀 액션을 트리거 ── */
function adThClick(th) {
    var table = th.closest('table');
    var firstRow = table && table.querySelector('tbody tr[data-ad-id]');
    if (!firstRow) return;
    var cell = firstRow.children[th.cellIndex];
    if (!cell) return;
    var target = cell.querySelector('input[type="checkbox"], a[href], button');
    if (target) {
        if (target.tagName === 'INPUT' && target.type === 'checkbox') target.click();
        else target.click();
        return;
    }
    var editLink = firstRow.querySelector('a.detail');
    if (editLink) location.href = editLink.getAttribute('href');
}
</script>

<%@ include file="../layout-close.jsp" %>
