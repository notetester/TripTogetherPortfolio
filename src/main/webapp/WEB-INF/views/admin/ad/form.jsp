<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="ads"/>
<c:set var="isEdit" value="${mode eq 'edit'}"/>
<c:set var="pageTitle" value="${isEdit ? '광고 수정' : '광고 등록'}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content adm-ad-form-page">

    <c:set var="formAction"
           value="${isEdit
                ? pageContext.request.contextPath.concat('/admin/ads/').concat(ad.adId).concat('/update')
                : pageContext.request.contextPath.concat('/admin/ads')}"/>

    <form method="post" action="${formAction}" id="adForm" class="adm-ad-form">
        <div class="adm-card adm-ad-form-card">
            <div class="adm-ad-form-grid">
                <div class="adm-ad-field adm-ad-field-wide">
                    <label class="adm-ad-field-label" for="adTitle">제목 <span class="adm-ad-required">*</span></label>
                    <input type="text" id="adTitle" name="title" class="adm-input adm-ad-input"
                           value="${ad.title}" required/>
                    <div class="adm-ad-field-help">관리자 목록 라벨. 사용자에게 노출되지 않음</div>
                </div>

                <div class="adm-ad-field">
                    <label class="adm-ad-field-label" for="slotCode">슬롯 <span class="adm-ad-required">*</span></label>
                    <select id="slotCode" name="slotCode" class="adm-select adm-ad-input" required>
                        <option value="community_list_top"      ${ad.slotCode eq 'community_list_top'      ? 'selected' : ''}>커뮤니티 목록 상단</option>
                        <option value="community_detail_bottom" ${ad.slotCode eq 'community_detail_bottom' ? 'selected' : ''}>커뮤니티 상세 하단</option>
                    </select>
                </div>

                <div class="adm-ad-field adm-ad-field-wide">
                    <label class="adm-ad-field-label">배너 이미지 <span class="adm-ad-required">*</span></label>
                    <input type="hidden" name="imageUrl" id="imageUrl" value="${ad.imageUrl}" required/>
                    <div class="adm-ad-image-row">
                        <div id="imagePreviewBox" class="adm-ad-preview-box">
                            <c:choose>
                                <c:when test="${not empty ad.imageUrl}">
                                    <img id="imagePreview" src="${ad.imageUrl}" alt="" class="adm-ad-preview-img"/>
                                </c:when>
                                <c:otherwise>
                                    <span class="adm-ad-preview-placeholder">미리보기</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="adm-ad-upload-controls">
                            <input type="file" id="imageFile" class="adm-ad-file-input" accept=".jpg,.jpeg,.png,.gif,.webp"/>
                            <div class="adm-ad-field-help">권장 크기 970×90 (데스크톱 리더보드). JPG/PNG/GIF/WEBP 지원.</div>
                            <div id="uploadStatus" class="adm-ad-upload-status" aria-live="polite"></div>
                        </div>
                    </div>
                </div>

                <div class="adm-ad-field adm-ad-field-wide">
                    <label class="adm-ad-field-label">링크 타입 <span class="adm-ad-required">*</span></label>
                    <div class="adm-ad-radio-group">
                        <label class="adm-ad-radio-option">
                            <input type="radio" name="linkType" value="EXTERNAL" ${empty ad.linkType or ad.linkType eq 'EXTERNAL' ? 'checked' : ''}/>
                            <span>외부 링크</span>
                        </label>
                        <label class="adm-ad-radio-option">
                            <input type="radio" name="linkType" value="INTERNAL" ${ad.linkType eq 'INTERNAL' ? 'checked' : ''}/>
                            <span>내부 컨텐츠</span>
                        </label>
                        <label class="adm-ad-radio-option">
                            <input type="radio" name="linkType" value="NONE" ${ad.linkType eq 'NONE' ? 'checked' : ''}/>
                            <span>액션 없음</span>
                        </label>
                    </div>
                </div>

                <div id="extLinkBox" class="adm-ad-field adm-ad-field-wide adm-ad-dynamic-group"
                     ${ad.linkType eq 'INTERNAL' or ad.linkType eq 'NONE' ? 'hidden' : ''}>
                    <label class="adm-ad-field-label" for="linkUrlInput">링크 URL</label>
                    <input type="url" name="linkUrl" id="linkUrlInput" class="adm-input adm-ad-input"
                           value="${ad.linkUrl}" placeholder="https://..."/>
                    <div class="adm-ad-field-help">외부 사이트 URL. 비우면 클릭 시 홈으로 이동</div>
                </div>

                <div id="intLinkBox" class="adm-ad-field adm-ad-field-wide adm-ad-dynamic-group"
                     ${ad.linkType eq 'INTERNAL' ? '' : 'hidden'}>
                    <label class="adm-ad-field-label" for="linkTargetTypeSelect">컨텐츠 종류</label>
                    <select name="linkTargetType" id="linkTargetTypeSelect" class="adm-select adm-ad-input"
                            ${ad.linkType eq 'INTERNAL' ? '' : 'disabled'}>
                        <option value="">선택...</option>
                        <option value="package"   ${ad.linkTargetType eq 'package'   ? 'selected' : ''}>패키지 상품</option>
                        <option value="explore"   ${ad.linkTargetType eq 'explore'   ? 'selected' : ''}>여행지 (Explore)</option>
                        <option value="community" ${ad.linkTargetType eq 'community' ? 'selected' : ''}>커뮤니티 게시글</option>
                        <option value="courses"   ${ad.linkTargetType eq 'courses'   ? 'selected' : ''}>여행 코스</option>
                        <option value="flight"    ${ad.linkTargetType eq 'flight'    ? 'selected' : ''}>항공권</option>
                        <option value="shop"      ${ad.linkTargetType eq 'shop'      ? 'selected' : ''}>포인트 상점</option>
                        <option value="mypage"    ${ad.linkTargetType eq 'mypage'    ? 'selected' : ''}>마이페이지</option>
                        <option value="inquiry"   ${ad.linkTargetType eq 'inquiry'   ? 'selected' : ''}>문의</option>
                    </select>

                    <div id="packageDropBox" class="adm-ad-target-box" ${ad.linkTargetType eq 'package' ? '' : 'hidden'}>
                        <label class="adm-ad-field-label" for="packageSelect">패키지 선택</label>
                        <select name="linkTargetId" id="packageSelect" class="adm-select adm-ad-input" disabled>
                            <option value="">패키지 선택...</option>
                            <c:forEach var="p" items="${approvedPackages}">
                                <option value="${p.packageIdx}"
                                    ${ad.linkTargetType eq 'package' and ad.linkTargetId eq p.packageIdx ? 'selected' : ''}>
                                    ${p.packageTitle} — ${p.spotName} (#${p.packageIdx})
                                </option>
                            </c:forEach>
                        </select>
                        <div class="adm-ad-field-help">패키지 클릭 시 해당 여행지로 이동하면서 패키지 모달이 자동 오픈됩니다.</div>
                    </div>

                    <div id="communityDropBox" class="adm-ad-target-box" ${ad.linkTargetType eq 'community' ? '' : 'hidden'}>
                        <label class="adm-ad-field-label" for="communitySelect">게시글 선택</label>
                        <select name="linkTargetId" id="communitySelect" class="adm-select adm-ad-input" disabled>
                            <option value="">게시글 선택...</option>
                            <c:forEach var="p" items="${communityPosts}">
                                <option value="${p.postId}"
                                    ${ad.linkTargetType eq 'community' and ad.linkTargetId eq p.postId ? 'selected' : ''}>
                                    ${p.title} — ${p.nickname} (#${p.postId})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div id="exploreDropBox" class="adm-ad-target-box" ${ad.linkTargetType eq 'explore' ? '' : 'hidden'}>
                        <label class="adm-ad-field-label" for="exploreSelect">여행지 선택</label>
                        <select name="linkTargetId" id="exploreSelect" class="adm-select adm-ad-input" disabled>
                            <option value="">여행지 선택...</option>
                            <c:forEach var="s" items="${exploreSpots}">
                                <option value="${s.spotIdx}"
                                    ${ad.linkTargetType eq 'explore' and ad.linkTargetId eq s.spotIdx ? 'selected' : ''}>
                                    ${s.name} — ${s.region} (#${s.spotIdx})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div id="coursesDropBox" class="adm-ad-target-box" ${ad.linkTargetType eq 'courses' ? '' : 'hidden'}>
                        <label class="adm-ad-field-label" for="coursesSelect">여행 코스 선택</label>
                        <select name="linkTargetId" id="coursesSelect" class="adm-select adm-ad-input" disabled>
                            <option value="">공개 여행 코스 선택...</option>
                            <c:forEach var="t" items="${publicTravelPlans}">
                                <option value="${t.plan_id}"
                                    ${ad.linkTargetType eq 'courses' and ad.linkTargetId eq t.plan_id ? 'selected' : ''}>
                                    ${t.title}<c:if test="${not empty t.destination}"> — ${t.destination}</c:if> (#${t.plan_id})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div id="listOnlyBox" class="adm-ad-target-box" ${ad.linkTargetType eq 'flight' or ad.linkTargetType eq 'shop' or ad.linkTargetType eq 'mypage' ? '' : 'hidden'}>
                        <div class="adm-ad-note-box">
                            이 컨텐츠 종류는 해당 모듈의 메인/목록 페이지로 이동합니다. 대상 ID 입력은 필요하지 않습니다.
                        </div>
                    </div>

                    <div id="targetIdBox" class="adm-ad-target-box" ${ad.linkTargetType eq 'inquiry' ? '' : 'hidden'}>
                        <label class="adm-ad-field-label" for="targetIdInput">대상 ID</label>
                        <input type="number" name="linkTargetId" id="targetIdInput" class="adm-input adm-ad-input"
                               value="${ad.linkTargetType eq 'inquiry' ? ad.linkTargetId : ''}" placeholder="비우면 목록 페이지로 이동" disabled/>
                        <div class="adm-ad-field-help">대상 컨텐츠 ID. 비우면 해당 모듈의 목록 페이지로 이동</div>
                    </div>
                </div>

                <c:set var="startAtValue" value=""/>
                <c:set var="endAtValue"   value=""/>
                <c:if test="${not empty ad.startAt}">
                    <fmt:formatDate value="${ad.startAt}" pattern="yyyy-MM-dd'T'HH:mm" var="startAtValue"/>
                </c:if>
                <c:if test="${not empty ad.endAt}">
                    <fmt:formatDate value="${ad.endAt}" pattern="yyyy-MM-dd'T'HH:mm" var="endAtValue"/>
                </c:if>

                <div class="adm-ad-field">
                    <label class="adm-ad-field-label" for="startAtInput">노출 시작</label>
                    <input type="datetime-local" id="startAtInput" name="startAtInput" class="adm-input adm-ad-input"
                           value="${startAtValue}"/>
                    <div class="adm-ad-field-help">비워두면 즉시 노출</div>
                </div>

                <div class="adm-ad-field">
                    <label class="adm-ad-field-label" for="endAtInput">노출 종료</label>
                    <input type="datetime-local" id="endAtInput" name="endAtInput" class="adm-input adm-ad-input"
                           value="${endAtValue}"/>
                    <div class="adm-ad-field-help">비워두면 무기한</div>
                </div>

                <div class="adm-ad-field">
                    <label class="adm-ad-field-label" for="sortOrder">정렬 가중치</label>
                    <input type="number" id="sortOrder" name="sortOrder" class="adm-input adm-ad-input"
                           value="${empty ad.sortOrder ? 0 : ad.sortOrder}"/>
                    <div class="adm-ad-field-help">작을수록 우선. 동일 값 다수면 랜덤 선택</div>
                </div>

                <div class="adm-ad-field adm-ad-active-form-field">
                    <label class="adm-ad-active-check">
                        <input type="checkbox" name="isActive" value="true" ${empty ad.isActive or ad.isActive ? 'checked' : ''}/>
                        <span>활성</span>
                    </label>
                </div>
            </div>

            <div class="adm-ad-form-actions">
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

    function setUploadStatus(text, state) {
        statusEl.textContent = text;
        statusEl.className = 'adm-ad-upload-status';
        if (state) {
            statusEl.classList.add('is-' + state);
        }
    }

    function setPreviewImage(url) {
        var image = document.createElement('img');
        image.id = 'imagePreview';
        image.src = url;
        image.alt = '';
        image.className = 'adm-ad-preview-img';
        previewBox.replaceChildren(image);
    }

    function setVisible(id, visible) {
        var el = document.getElementById(id);
        if (el) {
            el.hidden = !visible;
        }
    }

    fileInput.addEventListener('change', function () {
        var f = fileInput.files && fileInput.files[0];
        if (!f) return;
        var form = new FormData();
        form.append('file', f);
        setUploadStatus('업로드 중...', 'info');
        fetch(CTX + '/admin/ads/upload-image', {
            method: 'POST',
            body: form,
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(function (r) { return r.json(); })
        .then(function (data) {
            if (data && data.success && data.url) {
                urlInput.value = data.url;
                setPreviewImage(data.url);
                setUploadStatus('업로드 완료', 'success');
            } else {
                setUploadStatus((data && data.message) || '업로드 실패', 'error');
            }
        })
        .catch(function () {
            setUploadStatus('업로드 중 오류', 'error');
        });
    });

    document.getElementById('adForm').addEventListener('submit', function (e) {
        if (!urlInput.value) {
            e.preventDefault();
            alert('배너 이미지를 업로드해주세요.');
        }
    });

    function toggleLinkType() {
        var lt = (document.querySelector('input[name="linkType"]:checked') || {}).value;
        setVisible('extLinkBox', lt === 'EXTERNAL');
        setVisible('intLinkBox', lt === 'INTERNAL');
        var linkUrlEl = document.getElementById('linkUrlInput');
        var targetTypeEl = document.getElementById('linkTargetTypeSelect');
        if (linkUrlEl) linkUrlEl.disabled = (lt !== 'EXTERNAL');
        if (targetTypeEl) targetTypeEl.disabled = (lt !== 'INTERNAL');
        if (lt === 'INTERNAL') {
            toggleTargetType();
        } else {
            var ps = document.getElementById('packageSelect');
            var cs = document.getElementById('communitySelect');
            var es = document.getElementById('exploreSelect');
            var ts = document.getElementById('coursesSelect');
            var ti = document.getElementById('targetIdInput');
            if (ps) ps.disabled = true;
            if (cs) cs.disabled = true;
            if (es) es.disabled = true;
            if (ts) ts.disabled = true;
            if (ti) ti.disabled = true;
        }
    }

    function toggleTargetType() {
        var tt = document.getElementById('linkTargetTypeSelect').value;
        var isPackage   = (tt === 'package');
        var isCommunity = (tt === 'community');
        var isExplore   = (tt === 'explore');
        var isCourses   = (tt === 'courses');
        var isListOnly  = (tt === 'flight' || tt === 'shop' || tt === 'mypage');
        var isManualId  = (tt === 'inquiry');

        setVisible('packageDropBox', isPackage);
        setVisible('communityDropBox', isCommunity);
        setVisible('exploreDropBox', isExplore);
        setVisible('coursesDropBox', isCourses);
        setVisible('listOnlyBox', isListOnly);
        setVisible('targetIdBox', isManualId);

        document.getElementById('packageSelect').disabled   = !isPackage;
        document.getElementById('communitySelect').disabled = !isCommunity;
        document.getElementById('exploreSelect').disabled   = !isExplore;
        document.getElementById('coursesSelect').disabled   = !isCourses;
        document.getElementById('targetIdInput').disabled   = !isManualId;
    }

    document.querySelectorAll('input[name="linkType"]').forEach(function (r) {
        r.addEventListener('change', toggleLinkType);
    });
    document.getElementById('linkTargetTypeSelect').addEventListener('change', toggleTargetType);
    toggleLinkType();
})();
</script>

<%@ include file="../layout-close.jsp" %>
