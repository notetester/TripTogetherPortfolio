<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="ads"/>
<c:set var="isEdit" value="${mode eq 'edit'}"/>
<c:set var="pageTitle" value="${isEdit ? '광고 수정' : '광고 등록'}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content" style="max-width:760px;">

    <c:set var="formAction"
           value="${isEdit
                ? pageContext.request.contextPath.concat('/admin/ads/').concat(ad.adId).concat('/update')
                : pageContext.request.contextPath.concat('/admin/ads')}"/>

    <form method="post" action="${formAction}" id="adForm">
        <div class="adm-card" style="padding:24px;">

            <div style="margin-bottom:16px;">
                <label style="display:block;font-size:13px;font-weight:600;color:#334155;margin-bottom:6px;">제목 <span style="color:#dc2626;">*</span></label>
                <input type="text" name="title" class="adm-input" style="width:100%;padding:10px 12px;font-size:14px;"
                       value="${ad.title}" required/>
                <div style="font-size:11px;color:#94a3b8;margin-top:4px;">관리자 목록 라벨 — 사용자에게 노출되지 않음</div>
            </div>

            <div style="margin-bottom:16px;">
                <label style="display:block;font-size:13px;font-weight:600;color:#334155;margin-bottom:6px;">슬롯 <span style="color:#dc2626;">*</span></label>
                <select name="slotCode" class="adm-input" style="width:100%;padding:10px 12px;font-size:14px;" required>
                    <option value="community_list_top"      ${ad.slotCode eq 'community_list_top'      ? 'selected' : ''}>커뮤니티 목록 상단</option>
                    <option value="community_detail_bottom" ${ad.slotCode eq 'community_detail_bottom' ? 'selected' : ''}>커뮤니티 상세 하단</option>
                </select>
            </div>

            <div style="margin-bottom:16px;">
                <label style="display:block;font-size:13px;font-weight:600;color:#334155;margin-bottom:6px;">배너 이미지 <span style="color:#dc2626;">*</span></label>
                <input type="hidden" name="imageUrl" id="imageUrl" value="${ad.imageUrl}" required/>
                <div style="display:flex;gap:12px;align-items:flex-start;">
                    <div id="imagePreviewBox" style="width:194px;min-height:60px;border:1px dashed #cbd5e1;border-radius:8px;display:flex;align-items:center;justify-content:center;overflow:hidden;background:#f8fafc;">
                        <c:choose>
                            <c:when test="${not empty ad.imageUrl}">
                                <img id="imagePreview" src="${ad.imageUrl}" alt="" style="max-width:100%;max-height:120px;display:block;"/>
                            </c:when>
                            <c:otherwise>
                                <span style="font-size:12px;color:#94a3b8;">미리보기</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div style="flex:1;">
                        <input type="file" id="imageFile" accept=".jpg,.jpeg,.png,.gif,.webp" style="font-size:13px;"/>
                        <div style="font-size:11px;color:#94a3b8;margin-top:6px;">권장 크기 970×90 (데스크톱 리더보드).<br>JPG/PNG/GIF/WEBP 지원.</div>
                        <div id="uploadStatus" style="font-size:12px;color:#2563eb;margin-top:6px;"></div>
                    </div>
                </div>
            </div>

            <div style="margin-bottom:16px;">
                <label style="display:block;font-size:13px;font-weight:600;color:#334155;margin-bottom:6px;">링크 URL</label>
                <input type="url" name="linkUrl" class="adm-input" style="width:100%;padding:10px 12px;font-size:14px;"
                       value="${ad.linkUrl}" placeholder="https://..."/>
                <div style="font-size:11px;color:#94a3b8;margin-top:4px;">비워두면 클릭해도 이동하지 않음</div>
            </div>

            <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:16px;">
                <div>
                    <label style="display:block;font-size:13px;font-weight:600;color:#334155;margin-bottom:6px;">노출 시작</label>
                    <input type="datetime-local" name="startAtInput" class="adm-input" style="width:100%;padding:10px 12px;font-size:14px;"
                           value="<c:if test='${not empty ad.startAt}'><fmt:formatDate value='${ad.startAt}' pattern=\"yyyy-MM-dd'T'HH:mm\"/></c:if>"/>
                    <div style="font-size:11px;color:#94a3b8;margin-top:4px;">비워두면 즉시 노출</div>
                </div>
                <div>
                    <label style="display:block;font-size:13px;font-weight:600;color:#334155;margin-bottom:6px;">노출 종료</label>
                    <input type="datetime-local" name="endAtInput" class="adm-input" style="width:100%;padding:10px 12px;font-size:14px;"
                           value="<c:if test='${not empty ad.endAt}'><fmt:formatDate value='${ad.endAt}' pattern=\"yyyy-MM-dd'T'HH:mm\"/></c:if>"/>
                    <div style="font-size:11px;color:#94a3b8;margin-top:4px;">비워두면 무기한</div>
                </div>
            </div>

            <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:16px;">
                <div>
                    <label style="display:block;font-size:13px;font-weight:600;color:#334155;margin-bottom:6px;">정렬 가중치</label>
                    <input type="number" name="sortOrder" class="adm-input" style="width:100%;padding:10px 12px;font-size:14px;"
                           value="${empty ad.sortOrder ? 0 : ad.sortOrder}"/>
                    <div style="font-size:11px;color:#94a3b8;margin-top:4px;">작을수록 우선. 동일 값 다수면 랜덤 선택</div>
                </div>
                <div style="display:flex;align-items:flex-end;">
                    <label style="display:inline-flex;align-items:center;gap:8px;font-size:14px;color:#334155;padding-bottom:10px;">
                        <input type="checkbox" name="isActive" value="true" ${empty ad.isActive or ad.isActive ? 'checked' : ''}/> 활성
                    </label>
                </div>
            </div>

            <div style="display:flex;justify-content:flex-end;gap:8px;margin-top:20px;">
                <a href="${pageContext.request.contextPath}/admin/ads" class="adm-btn adm-btn-ghost">취소</a>
                <button type="submit" class="adm-btn adm-btn-primary">${isEdit ? '수정 저장' : '등록'}</button>
            </div>
        </div>
    </form>
</div>

<script>
(function () {
    var CTX = '${pageContext.request.contextPath}';
    var fileInput = document.getElementById('imageFile');
    var urlInput  = document.getElementById('imageUrl');
    var previewBox = document.getElementById('imagePreviewBox');
    var statusEl   = document.getElementById('uploadStatus');

    fileInput.addEventListener('change', function () {
        var f = fileInput.files && fileInput.files[0];
        if (!f) return;
        var form = new FormData();
        form.append('file', f);
        statusEl.textContent = '업로드 중...';
        statusEl.style.color = '#2563eb';
        fetch(CTX + '/admin/ads/upload-image', {
            method: 'POST',
            body: form,
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(function (r) { return r.json(); })
        .then(function (data) {
            if (data && data.success && data.url) {
                urlInput.value = data.url;
                previewBox.innerHTML = '<img src="' + data.url + '" alt="" style="max-width:100%;max-height:120px;display:block;"/>';
                statusEl.textContent = '업로드 완료';
                statusEl.style.color = '#15803d';
            } else {
                statusEl.textContent = (data && data.message) || '업로드 실패';
                statusEl.style.color = '#dc2626';
            }
        })
        .catch(function () {
            statusEl.textContent = '업로드 중 오류';
            statusEl.style.color = '#dc2626';
        });
    });

    document.getElementById('adForm').addEventListener('submit', function (e) {
        if (!urlInput.value) {
            e.preventDefault();
            alert('배너 이미지를 업로드해주세요.');
        }
    });
})();
</script>

<%@ include file="../layout-close.jsp" %>
