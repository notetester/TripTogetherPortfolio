<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="explore"/>
<c:set var="pageTitle" value="여행지 상세 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">여행지 기본 정보</div>
            <div style="display:flex;gap:8px;">
                <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/detail/${spot.spotIdx}" target="_blank">사용자 상세 보기</a>
                <button type="button" class="adm-btn" onclick="toggleEditForm()">수정</button>
                <c:if test="${spot.displayStatus != 'DELETED'}">
                    <button class="adm-btn adm-btn-ghost" style="color:#64748b;" onclick="deleteSpot(${spot.spotIdx})">삭제 처리</button>
                </c:if>
            </div>
        </div>
        <div class="adm-card-body" style="display:grid;grid-template-columns:280px 1fr;gap:24px;">
            <div>
                <c:choose>
                    <c:when test="${not empty spot.thumbUrl}">
                        <img src="${spot.thumbUrl}" alt="${fn:escapeXml(spot.name)}" style="width:100%;height:220px;object-fit:cover;border-radius:14px;border:1px solid #1e293b;">
                    </c:when>
                    <c:otherwise>
                        <div class="adm-image-placeholder" style="width:100%;height:220px;border-radius:14px;display:flex;align-items:center;justify-content:center;">등록된 대표 이미지가 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div style="display:grid;gap:12px;">
                <div style="display:flex;justify-content:space-between;gap:16px;">
                    <div>
                        <div style="font-size:12px;color:#64748b;">여행지명</div>
                        <div class="adm-field-value" style="font-size:22px;font-weight:700;">${fn:escapeXml(spot.name)}</div>
                    </div>
                    <span class="status-badge ${spot.displayStatus}">
                        <c:choose>
                            <c:when test="${spot.displayStatus == 'ACTIVE'}">노출</c:when>
                            <c:otherwise>삭제 처리</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div style="display:grid;grid-template-columns:repeat(2,1fr);gap:14px;">
                    <div class="adm-card" style="padding:14px;">
                        <div style="font-size:12px;color:#64748b;">작성자</div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${fn:escapeXml(spot.nickname)}</div>
                        <div style="font-size:11px;color:#64748b;margin-top:2px;">${fn:escapeXml(spot.userId)}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div style="font-size:12px;color:#64748b;">지역</div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${fn:escapeXml(spot.region)}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div style="font-size:12px;color:#64748b;">spot_id</div>
                        <div class="adm-field-value-sub" style="font-size:13px;margin-top:4px;">${fn:escapeXml(spot.spotId)}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div style="font-size:12px;color:#64748b;">평점 / 리뷰</div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;"><fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/> / ${spot.reviewCount}건</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div style="font-size:12px;color:#64748b;">좋아요 / 태그</div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${spot.likeCount} / ${spot.tagCount}</div>
                    </div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div style="font-size:12px;color:#64748b;">주소</div>
                    <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${fn:escapeXml(spot.address)}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div style="font-size:12px;color:#64748b;">좌표</div>
                    <div class="adm-field-value-sub" style="font-size:13px;margin-top:4px;">lat: ${spot.latitude}, lng: ${spot.longitude}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div style="font-size:12px;color:#64748b;">설명</div>
                    <div class="adm-field-value" style="font-size:14px;margin-top:4px;line-height:1.7;">${fn:escapeXml(spot.description)}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div style="font-size:12px;color:#64748b;margin-bottom:8px;">태그</div>
                    <div style="display:flex;gap:8px;flex-wrap:wrap;">
                        <c:forEach items="${tags}" var="tag">
                            <span class="adm-nav-badge adm-tag-badge">${fn:escapeXml(tag)}</span>
                        </c:forEach>
                        <c:if test="${empty tags}">
                            <span style="font-size:12px;color:#64748b;">등록된 태그가 없습니다.</span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">여행지 수정</div>
            <div style="font-size:12px;color:#64748b;">수정 버튼을 누르면 아래 폼이 열립니다. 저장 시 공개 상세와 같은 기준으로 검증합니다.</div>
        </div>
        <div class="adm-card-body">
            <c:if test="${not empty adminEditError}">
                <div style="margin-bottom:16px;padding:12px 14px;border-radius:10px;background:#451a1a;border:1px solid #7f1d1d;color:#fecaca;">
                    ${fn:escapeXml(adminEditError)}
                </div>
            </c:if>
            <c:if test="${not empty adminEditSuccess}">
                <div style="margin-bottom:16px;padding:12px 14px;border-radius:10px;background:#052e16;border:1px solid #166534;color:#bbf7d0;">
                    ${fn:escapeXml(adminEditSuccess)}
                </div>
            </c:if>

            <form id="spotEditForm"
                  method="post"
                  action="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}/update"
                  enctype="multipart/form-data"
                  style="display:none;">
                <div style="display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:16px;">
                    <div>
                        <label for="spotName" style="display:block;margin-bottom:6px;font-size:12px;color:#94a3b8;">여행지 이름</label>
                        <input type="text" id="spotName" name="name" maxlength="100" value="${fn:escapeXml(adminEditForm.name)}" required
                               style="width:100%;padding:10px 12px;border-radius:10px;border:1px solid #334155;background:#0f172a;color:#e2e8f0;">
                    </div>
                    <div>
                        <label for="spotRegion" style="display:block;margin-bottom:6px;font-size:12px;color:#94a3b8;">지역</label>
                        <input type="text" id="spotRegion" name="region" maxlength="100" value="${fn:escapeXml(adminEditForm.region)}" required
                               style="width:100%;padding:10px 12px;border-radius:10px;border:1px solid #334155;background:#0f172a;color:#e2e8f0;">
                    </div>
                    <div style="grid-column:1 / -1;">
                        <label for="spotAddress" style="display:block;margin-bottom:6px;font-size:12px;color:#94a3b8;">주소</label>
                        <input type="text" id="spotAddress" name="address" maxlength="255" value="${fn:escapeXml(adminEditForm.address)}" required
                               style="width:100%;padding:10px 12px;border-radius:10px;border:1px solid #334155;background:#0f172a;color:#e2e8f0;">
                    </div>
                    <div>
                        <label for="spotLatitude" style="display:block;margin-bottom:6px;font-size:12px;color:#94a3b8;">위도</label>
                        <input type="number" id="spotLatitude" name="latitude" step="0.000001" value="${adminEditForm.latitude}" required
                               style="width:100%;padding:10px 12px;border-radius:10px;border:1px solid #334155;background:#0f172a;color:#e2e8f0;">
                    </div>
                    <div>
                        <label for="spotLongitude" style="display:block;margin-bottom:6px;font-size:12px;color:#94a3b8;">경도</label>
                        <input type="number" id="spotLongitude" name="longitude" step="0.000001" value="${adminEditForm.longitude}" required
                               style="width:100%;padding:10px 12px;border-radius:10px;border:1px solid #334155;background:#0f172a;color:#e2e8f0;">
                    </div>
                    <div style="grid-column:1 / -1;">
                        <label for="spotDescription" style="display:block;margin-bottom:6px;font-size:12px;color:#94a3b8;">설명</label>
                        <textarea id="spotDescription" name="description" maxlength="2000" required
                                  style="width:100%;min-height:140px;padding:10px 12px;border-radius:10px;border:1px solid #334155;background:#0f172a;color:#e2e8f0;resize:vertical;">${fn:escapeXml(adminEditForm.description)}</textarea>
                    </div>
                    <div style="grid-column:1 / -1;">
                        <label for="spotImage" style="display:block;margin-bottom:6px;font-size:12px;color:#94a3b8;">대표 이미지 교체</label>
                        <input type="file" id="spotImage" name="image" accept=".jpg,.jpeg,.png,.gif,.webp"
                               style="width:100%;padding:10px 12px;border-radius:10px;border:1px dashed #334155;background:#0f172a;color:#cbd5e1;">
                        <div style="margin-top:6px;font-size:11px;color:#64748b;">새 이미지 업로드 시 기존 대표 이미지는 새 이미지 1장으로 교체됩니다.</div>
                    </div>
                    <div style="grid-column:1 / -1;">
                        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
                            <label style="font-size:12px;color:#94a3b8;">태그 선택</label>
                            <span style="font-size:11px;color:#64748b;">최대 4개</span>
                        </div>
                        <div style="display:flex;gap:10px;flex-wrap:wrap;">
                            <c:forEach var="tag" items="${writeTagList}">
                                <label style="display:inline-flex;align-items:center;gap:6px;padding:8px 10px;border-radius:999px;border:1px solid #334155;background:#0f172a;color:#cbd5e1;">
                                    <input type="checkbox" name="tags" value="${fn:escapeXml(tag)}"
                                           <c:forEach var="selectedTag" items="${adminEditForm.tags}"><c:if test="${selectedTag == tag}">checked</c:if></c:forEach>>
                                    <span>${fn:escapeXml(tag)}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div style="display:flex;justify-content:flex-end;gap:8px;margin-top:20px;">
                    <button type="button" class="adm-btn adm-btn-ghost" onclick="closeEditForm()">취소</button>
                    <button type="submit" class="adm-btn">수정 저장</button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">리뷰 목록</div>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore/reviews?searchType=name&keyword=${spot.name}">리뷰 관리 전체 화면</a>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:70px;">리뷰 ID</th>
                    <th style="width:120px;">작성자</th>
                    <th style="width:90px;">평점</th>
                    <th>내용</th>
                    <th style="width:90px;">상태</th>
                    <th style="width:90px;">등록일</th>
                    <th style="width:90px;">액션</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${reviews}" var="review">
                    <tr>
                        <td style="color:#64748b;font-size:12px;">#${review.reviewIdx}</td>
                        <td>
                            <div style="font-size:13px;color:#7dd3fc;font-weight:600;">${fn:escapeXml(review.nickname)}</div>
                            <div style="font-size:11px;color:#64748b;">${fn:escapeXml(review.userId)}</div>
                        </td>
                        <td style="font-size:12px;color:#fbbf24;">${review.rating}/5</td>
                        <td style="font-size:13px;color:#e2e8f0;line-height:1.6;">${fn:escapeXml(review.content)}</td>
                        <td>
                            <span class="status-badge ${review.displayStatus}">
                                <c:choose>
                                    <c:when test="${review.displayStatus == 'ACTIVE'}">정상</c:when>
                                    <c:otherwise>차단</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td style="font-size:11px;color:#64748b;"><fmt:formatDate value="${review.createdAt}" pattern="yyyy.MM.dd"/></td>
                        <td>
                            <c:if test="${review.displayStatus != 'BLOCKED'}">
                                <button class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;color:#f87171;border-color:#f87171;" onclick="blockReview(${review.reviewIdx})">차단</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <tr>
                        <td colspan="7" style="text-align:center;padding:40px;color:#475569;">등록된 리뷰가 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var spotEditForm = document.getElementById('spotEditForm');
var hasEditMessage = ${not empty adminEditError or not empty adminEditSuccess ? 'true' : 'false'};
var shouldOpenEditForm = ${openEditForm ? 'true' : 'false'};

if (spotEditForm && (hasEditMessage || shouldOpenEditForm)) {
    spotEditForm.style.display = 'block';
}

function toggleEditForm() {
    if (!spotEditForm) return;
    spotEditForm.style.display = spotEditForm.style.display === 'none' ? 'block' : 'none';
}

function closeEditForm() {
    if (!spotEditForm) return;
    spotEditForm.style.display = 'none';
}

if (spotEditForm) {
    spotEditForm.querySelectorAll('input[name="tags"]').forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            var checked = spotEditForm.querySelectorAll('input[name="tags"]:checked');
            if (checked.length > 4) {
                this.checked = false;
                alert('태그는 최대 4개까지 선택할 수 있습니다.');
            }
        });
    });
}

function deleteSpot(spotIdx) {
    if (!confirm('이 여행지를 삭제 처리하시겠습니까?')) return;
    fetch(ctx + '/admin/explore/spots/' + spotIdx + '/delete', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) {
        return r.json();
    }).then(function (d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || '처리에 실패했습니다.');
        }
    });
}

function blockReview(reviewIdx) {
    if (!confirm('이 리뷰를 차단하시겠습니까?')) return;
    fetch(ctx + '/admin/explore/reviews/' + reviewIdx + '/block', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) {
        return r.json();
    }).then(function (d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || '처리에 실패했습니다.');
        }
    });
}
</script>

<%@ include file="../layout-close.jsp" %>
