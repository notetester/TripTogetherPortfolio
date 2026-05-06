<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%--
  커뮤니티 글쓰기/수정 페이지
  글쓰기: GET /community/write      → model에 post 없음
  수정:   GET /community/edit/{id}  → model에 post, imageList, tagList, tipCategory 있음
--%>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<c:set var="pageCSS" value="community/community_write.css"/>
<%@ include file="../common/header.jsp" %>

<spring:message code="community.region.africa" var="communityRegionAfricaLabel"/>
<spring:message code="community.region.asia" var="communityRegionAsiaLabel"/>
<spring:message code="community.region.etc" var="communityRegionEtcLabel"/>
<spring:message code="community.region.europe" var="communityRegionEuropeLabel"/>
<spring:message code="community.region.northAmerica" var="communityRegionNorthAmericaLabel"/>
<spring:message code="community.region.oceania" var="communityRegionOceaniaLabel"/>
<spring:message code="community.region.southAmerica" var="communityRegionSouthAmericaLabel"/>
<spring:message code="community.type.photo" var="communityTypePhotoLabel"/>
<spring:message code="community.type.question" var="communityTypeQuestionLabel"/>
<spring:message code="community.type.review" var="communityTypeReviewLabel"/>
<spring:message code="community.type.tip" var="communityTypeTipLabel"/>
<spring:message code="community.write.content.placeholder" var="communityWriteContentPlaceholder"/>
<spring:message code="community.write.tag.hint" var="communityWriteTagHintLabel"/>
<spring:message code="community.write.tag.placeholder" var="communityWriteTagPlaceholder"/>
<spring:message code="community.write.title.placeholder" var="communityWriteTitlePlaceholder"/>

<%-- Summernote CDN (WYSIWYG 에디터) --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-lite.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/lang/summernote-ko-KR.min.js"></script>

<%-- Summernote 모달 여백 강제 override (CSS 파일 로드 순서/캐시 회피) --%>
<style>
.note-modal .note-modal-header { padding: 18px 32px !important; }
.note-modal .note-modal-body   { padding: 32px 32px !important; }
.note-modal .note-modal-body .note-form-group { padding-bottom: 28px !important; }
.note-modal .note-modal-body .note-form-group:last-child { padding-bottom: 0 !important; }
/* footer를 flex로 전환: Summernote 기본 float:right 가 height:auto 일 때 컨테이너 밖으로 밀려나는 문제 방지 */
.note-modal .note-modal-footer {
    height: auto !important;
    padding: 16px 32px !important;
    display: flex !important;
    justify-content: flex-end !important;
    align-items: center !important;
    gap: 10px !important;
    text-align: right !important;
}
.note-modal .note-modal-footer .note-btn { float: none !important; }
.note-modal .note-form-label { margin-bottom: 12px !important; }
</style>

<%-- 비로그인 체크 --%>
<c:if test="${empty sessionScope.loginUser}">
  <c:redirect url="/auth/login"/>
</c:if>

<%-- 수정 모드 여부 --%>
<c:set var="isEdit" value="${not empty post}"/>

<%-- 태그 목록을 쉼표 구분 문자열로 변환 --%>
<c:set var="tagListStr" value=""/>
<c:forEach var="tag" items="${tagList}" varStatus="status">
    <c:set var="tagListStr" value="${tagListStr}${tag}${!status.last ? ',' : ''}"/>
</c:forEach>


<body>

<div class="write-wrap">

  <div class="write-top-bar">
    <button class="back-btn" onclick="cancelWrite()">&#8592; <spring:message code="community.write.back"/></button>
    <h2 class="write-page-title" id="writePageTitle">
      <c:choose>
        <c:when test="${isEdit}"><spring:message code="community.write.title.edit"/></c:when>
        <c:otherwise><span class="write-title-reset" onclick="resetWrite()"><spring:message code="community.write.title.reset"/></span></c:otherwise>
      </c:choose>
    </h2>
  </div>

  <form id="writeForm" enctype="multipart/form-data">
    <%-- 수정 모드일 때 postId 전달 --%>
    <c:if test="${isEdit}">
      <input type="hidden" name="postId" value="${post.postId}">
    </c:if>

    <div class="write-container">

      <%-- 메인 입력 --%>
      <main class="write-main">

        <%-- 제목 --%>
        <div class="write-section">
          <label class="section-label" for="writeTitle">
            <spring:message code="community.write.title.label"/> <span class="required">*</span>
          </label>
          <input type="text" id="writeTitle" name="title" class="write-input"
                 placeholder="${communityWriteTitlePlaceholder}" maxlength="100"
                 value="${isEdit ? post.title : ''}"
                 oninput="document.getElementById('titleCount').textContent=this.value.length">
          <div class="input-counter">
            <span id="titleCount">${isEdit ? fn:length(post.title) : 0}</span>/100
          </div>
        </div>

        <%-- 해시태그 --%>
        <div class="write-section">
          <label class="section-label">
            <spring:message code="community.write.tag.label"/>
            <span class="section-label-sub">(<spring:message code="community.write.tag.autoRegion"/>)</span>
          </label>
          <div class="tag-input-wrap" id="tagInputWrap">
            <div class="tag-list" id="tagList"></div>
            <input type="text" id="tagInput" class="tag-input"
                   placeholder="${communityWriteTagPlaceholder}" maxlength="20"
                   onkeydown="addTag(event)">
          </div>
          <input type="hidden" id="tagsHidden" name="tags">
          <p class="input-hint">${communityWriteTagHintLabel}</p>
        </div>

          <%-- 유형별 추가 입력 (JS로 동적 렌더링) --%>
        <div id="typeExtraSection"></div>

        <%-- 본문 --%>
        <div class="write-section">
          <label class="section-label" for="writeContent">
            <spring:message code="community.write.content.label"/> <span class="required">*</span>
          </label>
          <div id="photoCountBadge" class="photo-count-badge is-short" hidden>
            <span class="photo-count-icon">&#128247;</span>
            <span id="photoCountText"></span>
          </div>
          <textarea id="writeContent" name="content" class="write-textarea"
                    placeholder="${communityWriteContentPlaceholder}"><c:if test="${isEdit}">${fn:escapeXml(post.content)}</c:if></textarea>
          <div class="input-counter">
            <span id="contentCount">0</span>/3000
          </div>
          <div class="write-bottom-actions">
            <button type="button" class="btn-cancel" onclick="cancelWrite()"><spring:message code="community.write.cancel"/></button>
            <button type="button" class="btn-submit" onclick="submitWrite()">
              <c:choose>
                <c:when test="${isEdit}"><spring:message code="community.write.submit.edit"/></c:when>
                <c:otherwise><spring:message code="community.write.submit.create"/></c:otherwise>
              </c:choose>
            </button>
          </div>
        </div>

      </main>

      <%-- 사이드바 --%>
      <aside class="write-aside">

        <%-- 게시글 유형 --%>
        <div class="aside-card">
          <div class="aside-card-title"><spring:message code="community.write.type.label"/> <span class="required">*</span></div>
          <input type="hidden" id="postType" name="postType"
                 value="${isEdit ? post.postType : 'review'}">
          <div class="type-select-grid">
            <button type="button" class="type-select-btn ${(!isEdit || post.postType eq 'review') ? 'active' : ''}"
                    data-type="review" onclick="selectType('review', this)">
              <span class="type-btn-icon">&#128172;</span>
              <span class="type-btn-label">${communityTypeReviewLabel}</span>
            </button>
            <button type="button" class="type-select-btn ${(isEdit && post.postType eq 'photo') ? 'active' : ''}"
                    data-type="photo" onclick="selectType('photo', this)">
              <span class="type-btn-icon">&#128247;</span>
              <span class="type-btn-label">${communityTypePhotoLabel}</span>
            </button>
            <button type="button" class="type-select-btn ${(isEdit && post.postType eq 'tip') ? 'active' : ''}"
                    data-type="tip" onclick="selectType('tip', this)">
              <span class="type-btn-icon">&#128161;</span>
              <span class="type-btn-label">${communityTypeTipLabel}</span>
            </button>
            <button type="button" class="type-select-btn ${(isEdit && post.postType eq 'question') ? 'active' : ''}"
                    data-type="question" onclick="selectType('question', this)">
              <span class="type-btn-icon">&#10067;</span>
              <span class="type-btn-label">${communityTypeQuestionLabel}</span>
            </button>
          </div>
        </div>

        <%-- 지역 선택 --%>
        <div class="aside-card">
          <div class="aside-card-title"><spring:message code="community.write.region.label"/> <span class="required">*</span></div>
          <input type="hidden" id="regionInput" name="region"
                 value="${isEdit ? post.region : 'asia'}">
          <div class="region-select-list">
            <button type="button" class="region-select-btn ${(!isEdit || post.region eq 'asia') ? 'active' : ''}"
                    data-region="asia" onclick="selectRegion('asia', this)">&#127759; ${communityRegionAsiaLabel}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'europe') ? 'active' : ''}"
                    data-region="europe" onclick="selectRegion('europe', this)">&#127957; ${communityRegionEuropeLabel}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'africa') ? 'active' : ''}"
                    data-region="africa" onclick="selectRegion('africa', this)">&#127758; ${communityRegionAfricaLabel}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'north_america') ? 'active' : ''}"
                    data-region="north_america" onclick="selectRegion('north_america', this)">&#127482;&#127480; ${communityRegionNorthAmericaLabel}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'south_america') ? 'active' : ''}"
                    data-region="south_america" onclick="selectRegion('south_america', this)">&#127475;&#127480; ${communityRegionSouthAmericaLabel}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'oceania') ? 'active' : ''}"
                    data-region="oceania" onclick="selectRegion('oceania', this)">&#127944; ${communityRegionOceaniaLabel}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'etc') ? 'active' : ''}"
                    data-region="etc" onclick="selectRegion('etc', this)">&#127760; ${communityRegionEtcLabel}</button>
          </div>
        </div>

        <%-- 작성 가이드 --%>
        <div class="aside-card guide-card">
          <div class="aside-card-title">&#128221; <spring:message code="community.write.guide.label"/></div>
          <ul class="guide-list" id="guideList">
            <li><spring:message code="community.write.guide.default.1"/></li>
            <li><spring:message code="community.write.guide.default.2"/></li>
            <li><spring:message code="community.write.guide.default.3"/></li>
            <li><spring:message code="community.write.guide.default.4"/></li>
          </ul>
        </div>

      </aside>
    </div>
  </form>
</div>

<script>
var CTX      = '${pageContext.request.contextPath}';
var IS_EDIT  = ${isEdit ? 'true' : 'false'};
var POST_ID  = ${isEdit ? post.postId : 0};
var tags     = [];
/* 사진 유형 검증용: content 본문에 img 최소 장수 */
var PHOTO_MIN_IMAGES = 3;

<spring:message code="community.region.africa" javaScriptEscape="true" var="communityRegionAfricaJs"/>
<spring:message code="community.region.asia" javaScriptEscape="true" var="communityRegionAsiaJs"/>
<spring:message code="community.region.etc" javaScriptEscape="true" var="communityRegionEtcJs"/>
<spring:message code="community.region.europe" javaScriptEscape="true" var="communityRegionEuropeJs"/>
<spring:message code="community.region.northAmerica" javaScriptEscape="true" var="communityRegionNorthAmericaJs"/>
<spring:message code="community.region.oceania" javaScriptEscape="true" var="communityRegionOceaniaJs"/>
<spring:message code="community.region.southAmerica" javaScriptEscape="true" var="communityRegionSouthAmericaJs"/>
<spring:message code="community.write.content.photoOnly" javaScriptEscape="true" var="communityWriteContentPhotoOnlyJs"/>
<spring:message code="community.write.content.placeholder" javaScriptEscape="true" var="communityWriteContentPlaceholderJs"/>
<spring:message code="community.write.error.contentRequired" javaScriptEscape="true" var="communityWriteErrorContentRequiredJs"/>
<spring:message code="community.write.error.generic" javaScriptEscape="true" var="communityWriteErrorGenericJs"/>
<spring:message code="community.write.error.photoRequired" javaScriptEscape="true" var="communityWriteErrorPhotoRequiredJs"/>
<spring:message code="community.write.error.regionTagLocked" javaScriptEscape="true" var="communityWriteErrorRegionTagLockedJs"/>
<spring:message code="community.write.error.titleRequired" javaScriptEscape="true" var="communityWriteErrorTitleRequiredJs"/>
<spring:message code="community.write.guide.photo.1" javaScriptEscape="true" var="communityWriteGuidePhoto1Js"/>
<spring:message code="community.write.guide.photo.2" javaScriptEscape="true" var="communityWriteGuidePhoto2Js"/>
<spring:message code="community.write.guide.photo.3" javaScriptEscape="true" var="communityWriteGuidePhoto3Js"/>
<spring:message code="community.write.guide.photo.requirement" javaScriptEscape="true" var="communityWriteGuidePhotoRequirementJs"/>
<spring:message code="community.write.photoCount.label" javaScriptEscape="true" var="communityWritePhotoCountLabelJs"/>
<spring:message code="community.write.guide.question.1" javaScriptEscape="true" var="communityWriteGuideQuestion1Js"/>
<spring:message code="community.write.guide.question.2" javaScriptEscape="true" var="communityWriteGuideQuestion2Js"/>
<spring:message code="community.write.guide.review.1" javaScriptEscape="true" var="communityWriteGuideReview1Js"/>
<spring:message code="community.write.guide.review.2" javaScriptEscape="true" var="communityWriteGuideReview2Js"/>
<spring:message code="community.write.guide.review.3" javaScriptEscape="true" var="communityWriteGuideReview3Js"/>
<spring:message code="community.write.guide.tip.1" javaScriptEscape="true" var="communityWriteGuideTip1Js"/>
<spring:message code="community.write.guide.tip.2" javaScriptEscape="true" var="communityWriteGuideTip2Js"/>
<spring:message code="community.write.guide.tip.3" javaScriptEscape="true" var="communityWriteGuideTip3Js"/>
<spring:message code="community.write.resetConfirm" javaScriptEscape="true" var="communityWriteResetConfirmJs"/>
<spring:message code="community.write.tipCategory.food" javaScriptEscape="true" var="communityWriteTipCategoryFoodJs"/>
<spring:message code="community.write.tipCategory.label" javaScriptEscape="true" var="communityWriteTipCategoryLabelJs"/>
<spring:message code="community.write.tipCategory.money" javaScriptEscape="true" var="communityWriteTipCategoryMoneyJs"/>
<spring:message code="community.write.tipCategory.other" javaScriptEscape="true" var="communityWriteTipCategoryOtherJs"/>
<spring:message code="community.write.tipCategory.safety" javaScriptEscape="true" var="communityWriteTipCategorySafetyJs"/>
<spring:message code="community.write.tipCategory.stay" javaScriptEscape="true" var="communityWriteTipCategoryStayJs"/>
<spring:message code="community.write.tipCategory.transport" javaScriptEscape="true" var="communityWriteTipCategoryTransportJs"/>
<spring:message code="community.write.title.photo.create" javaScriptEscape="true" var="communityWriteTitlePhotoCreateJs"/>
<spring:message code="community.write.title.photo.edit" javaScriptEscape="true" var="communityWriteTitlePhotoEditJs"/>
<spring:message code="community.write.title.question.create" javaScriptEscape="true" var="communityWriteTitleQuestionCreateJs"/>
<spring:message code="community.write.title.question.edit" javaScriptEscape="true" var="communityWriteTitleQuestionEditJs"/>
<spring:message code="community.write.title.review.create" javaScriptEscape="true" var="communityWriteTitleReviewCreateJs"/>
<spring:message code="community.write.title.review.edit" javaScriptEscape="true" var="communityWriteTitleReviewEditJs"/>
<spring:message code="community.write.title.tip.create" javaScriptEscape="true" var="communityWriteTitleTipCreateJs"/>
<spring:message code="community.write.title.tip.edit" javaScriptEscape="true" var="communityWriteTitleTipEditJs"/>
<spring:message code="community.write.cancelConfirm" javaScriptEscape="true" var="communityWriteCancelConfirmJs"/>

function formatMessage(template, value) {
  return template.replace('{0}', value);
}

function escapeHtml(value) {
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

/* Summernote HTML → plain text 변환 (글자수 카운트·빈값 검증용) */
function htmlToPlainText(html) {
  var tmp = document.createElement('div');
  tmp.innerHTML = html || '';
  return (tmp.textContent || tmp.innerText || '').trim();
}

var writeMessages = {
  cancelConfirm: '${communityWriteCancelConfirmJs}',
  contentPhotoOnly: '${communityWriteContentPhotoOnlyJs}',
  contentPlaceholder: '${communityWriteContentPlaceholderJs}',
  photoCountLabel: '${communityWritePhotoCountLabelJs}',
  errors: {
    contentRequired: '${communityWriteErrorContentRequiredJs}',
    generic: '${communityWriteErrorGenericJs}',
    photoRequired: '${communityWriteErrorPhotoRequiredJs}',
    regionTagLocked: '${communityWriteErrorRegionTagLockedJs}',
    titleRequired: '${communityWriteErrorTitleRequiredJs}'
  },
  guides: {
    photo: [
      '${communityWriteGuidePhotoRequirementJs}',
      '${communityWriteGuidePhoto1Js}',
      '${communityWriteGuidePhoto2Js}',
      '${communityWriteGuidePhoto3Js}'
    ],
    question: [
      '${communityWriteGuideQuestion1Js}',
      '${communityWriteGuideQuestion2Js}'
    ],
    review: [
      '${communityWriteGuideReview1Js}',
      '${communityWriteGuideReview2Js}',
      '${communityWriteGuideReview3Js}'
    ],
    tip: [
      '${communityWriteGuideTip1Js}',
      '${communityWriteGuideTip2Js}',
      '${communityWriteGuideTip3Js}'
    ]
  },
  regionLabels: {
    africa: '${communityRegionAfricaJs}',
    asia: '${communityRegionAsiaJs}',
    etc: '${communityRegionEtcJs}',
    europe: '${communityRegionEuropeJs}',
    north_america: '${communityRegionNorthAmericaJs}',
    oceania: '${communityRegionOceaniaJs}',
    south_america: '${communityRegionSouthAmericaJs}'
  },
  resetConfirm: '${communityWriteResetConfirmJs}',
  tipCategories: {
    food: '${communityWriteTipCategoryFoodJs}',
    label: '${communityWriteTipCategoryLabelJs}',
    money: '${communityWriteTipCategoryMoneyJs}',
    other: '${communityWriteTipCategoryOtherJs}',
    safety: '${communityWriteTipCategorySafetyJs}',
    stay: '${communityWriteTipCategoryStayJs}',
    transport: '${communityWriteTipCategoryTransportJs}'
  },
  titles: {
    photo: { create: '${communityWriteTitlePhotoCreateJs}', edit: '${communityWriteTitlePhotoEditJs}' },
    question: { create: '${communityWriteTitleQuestionCreateJs}', edit: '${communityWriteTitleQuestionEditJs}' },
    review: { create: '${communityWriteTitleReviewCreateJs}', edit: '${communityWriteTitleReviewEditJs}' },
    tip: { create: '${communityWriteTitleTipCreateJs}', edit: '${communityWriteTitleTipEditJs}' }
  }
};

var TYPE_CONFIG = {
  review: {
    title: IS_EDIT ? writeMessages.titles.review.edit : writeMessages.titles.review.create,
    guide: writeMessages.guides.review
  },
  photo: {
    title: IS_EDIT ? writeMessages.titles.photo.edit : writeMessages.titles.photo.create,
    guide: writeMessages.guides.photo
  },
  tip: {
    title: IS_EDIT ? writeMessages.titles.tip.edit : writeMessages.titles.tip.create,
    guide: writeMessages.guides.tip
  },
  question: {
    title: IS_EDIT ? writeMessages.titles.question.edit : writeMessages.titles.question.create,
    guide: writeMessages.guides.question
  }
};

var REGION_TAG_VALUE = {
  asia:          '아시아',
  europe:        '유럽',
  africa:        '아프리카',
  north_america: '북아메리카',
  south_america: '남아메리카',
  oceania:       '오세아니아',
  etc:           '기타'
};

window.onload = function() {
  if (IS_EDIT) {
    /* 수정 모드: 기존 데이터 복원 */
    var currentType   = document.getElementById('postType').value;
    var currentRegion = document.getElementById('regionInput').value;

    /* 기존 태그 복원 */
    var existingTags = '${tagListStr}';
    if (existingTags) {
      existingTags.split(',').forEach(function(t) {
        t = t.trim();
        if (t && tags.indexOf(t) === -1) tags.push(t);
      });
    }
    renderTags();

    /* 기존 이미지는 content 본문 HTML 안에 이미 포함됨 (별도 복원 불필요) */

    /* tip 카테고리 복원 */
    if (currentType === 'tip') {
      selectType('tip', document.querySelector('[data-type="tip"]'));
      setTimeout(function() {
        var tipCat = '${tipCategory}';
        if (tipCat) {
          document.getElementById('tipCategoryInput').value = tipCat;
          document.querySelectorAll('.tip-cat-btn').forEach(function(b) {
            b.classList.remove('active');
          });
          var activeBtn = document.querySelector('[onclick*="' + tipCat + '"]');
          if (activeBtn) activeBtn.classList.add('active');
        }
      }, 100);
    }

    /* photo 유형 수정 시: 가이드 리스트 및 카운터 배지 갱신 */
    if (currentType === 'photo') {
      selectType('photo', document.querySelector('[data-type="photo"]'));
    }

  } else {
    /* 글쓰기 모드: 기본 지역 태그(아시아) 자동 추가 */
    var defaultTag = REGION_TAG_VALUE['asia'];
    if (defaultTag && tags.indexOf(defaultTag) === -1) {
      tags.unshift(defaultTag);
      renderTags();
    }
  }
};

function selectType(type, btn) {
  document.getElementById('postType').value = type;
  document.querySelectorAll('.type-select-btn').forEach(function(b) {
    b.classList.remove('active');
  });
  if (btn) btn.classList.add('active');

  var cfg = TYPE_CONFIG[type];
  document.getElementById('writePageTitle').textContent = cfg.title;

  /* 모든 유형에서 에디터 활성. photo 유형은 이미지 최소 3장 요구는 submitWrite 에서 검증 */
  var $editor = (window.jQuery && jQuery('#writeContent').data('summernote')) ? jQuery('#writeContent') : null;
  if ($editor) $editor.summernote('enable');
  document.getElementById('guideList').innerHTML =
      cfg.guide.map(function(g) { return '<li>' + escapeHtml(g) + '</li>'; }).join('');

  var sec = document.getElementById('typeExtraSection');
  if (type === 'tip') {
    sec.innerHTML = '<div class="write-section">'
      + '<label class="section-label">' + escapeHtml(writeMessages.tipCategories.label) + ' <span class="required">*</span></label>'
      + '<input type="hidden" id="tipCategoryInput" name="tipCategory" value="transport">'
      + '<div class="tip-cat-grid">'
      + '<button type="button" class="tip-cat-btn active" onclick="selTipCat(\'transport\',this)">&#9992; ' + escapeHtml(writeMessages.tipCategories.transport) + '</button>'
      + '<button type="button" class="tip-cat-btn" onclick="selTipCat(\'accom\',this)">&#127968; ' + escapeHtml(writeMessages.tipCategories.stay) + '</button>'
      + '<button type="button" class="tip-cat-btn" onclick="selTipCat(\'food\',this)">&#127869; ' + escapeHtml(writeMessages.tipCategories.food) + '</button>'
      + '<button type="button" class="tip-cat-btn" onclick="selTipCat(\'money\',this)">&#128176; ' + escapeHtml(writeMessages.tipCategories.money) + '</button>'
      + '<button type="button" class="tip-cat-btn" onclick="selTipCat(\'safety\',this)">&#128737; ' + escapeHtml(writeMessages.tipCategories.safety) + '</button>'
      + '<button type="button" class="tip-cat-btn" onclick="selTipCat(\'other\',this)">&#128161; ' + escapeHtml(writeMessages.tipCategories.other) + '</button>'
      + '</div></div>';
  } else if (type === 'question') {
    sec.innerHTML = '';
  } else {
    sec.innerHTML = '';
  }

  /* 사진 유형: 이미지 카운터 배지 표시 + 현재 카운트 반영 */
  var badge = document.getElementById('photoCountBadge');
  if (badge) {
    if (type === 'photo') {
      badge.hidden = false;
      updatePhotoCount();
    } else {
      badge.hidden = true;
    }
  }
}

function updatePhotoCount() {
  var badge = document.getElementById('photoCountBadge');
  if (!badge || badge.hidden) return;
  var $editor = (window.jQuery && jQuery('#writeContent').data('summernote')) ? jQuery('#writeContent') : null;
  var html = $editor ? $editor.summernote('code') : (document.getElementById('writeContent').value || '');
  var tmp = document.createElement('div');
  tmp.innerHTML = html;
  var count = tmp.querySelectorAll('img').length;
  var textEl = document.getElementById('photoCountText');
  if (textEl) {
    var tpl = writeMessages.photoCountLabel || 'Photos {0}/{1}';
    textEl.textContent = tpl.replace('{0}', count).replace('{1}', PHOTO_MIN_IMAGES);
  }
  badge.classList.toggle('is-short', count < PHOTO_MIN_IMAGES);
  badge.classList.toggle('is-ok', count >= PHOTO_MIN_IMAGES);
}

function selTipCat(cat, btn) {
  document.getElementById('tipCategoryInput').value = cat;
  document.querySelectorAll('.tip-cat-btn').forEach(function(b) {
    b.classList.remove('active');
  });
  btn.classList.add('active');
}

function selectRegion(region, btn) {
  var prev = document.getElementById('regionInput').value;
  document.getElementById('regionInput').value = region;
  document.querySelectorAll('.region-select-btn').forEach(function(b) {
    b.classList.remove('active');
  });
  btn.classList.add('active');

  var prevTag = REGION_TAG_VALUE[prev];
  if (prevTag) {
    var idx = tags.indexOf(prevTag);
    if (idx !== -1) tags.splice(idx, 1);
  }
  var newTag = REGION_TAG_VALUE[region];
  if (newTag && tags.indexOf(newTag) === -1) {
    tags.unshift(newTag);
  }
  renderTags();
}

/* 사이드바 이미지 업로드 관련 함수(addImages/removeImage/renderImageGrid) 제거됨.
   이제 이미지는 Summernote 에디터 본문으로만 삽입됨. */

function addTag(event) {
  if (event.key !== 'Enter') return;
  var input = document.getElementById('tagInput');
  var val = input.value.trim().replace(/^#/, '');
  if (!val || tags.length >= 10 || tags.indexOf(val) !== -1) {
    input.value = '';
    return;
  }
  tags.push(val);
  renderTags();
  input.value = '';
}

function removeTag(idx) {
  var region = document.getElementById('regionInput').value;
  var regionTag = REGION_TAG_VALUE[region];
  if (tags[idx] === regionTag) {
    alert(writeMessages.errors.regionTagLocked);
    return;
  }
  tags.splice(idx, 1);
  renderTags();
}

function renderTags() {
  var region = document.getElementById('regionInput').value;
  var regionTag = REGION_TAG_VALUE[region];
  var regionLabel = writeMessages.regionLabels[region] || regionTag;
  document.getElementById('tagList').innerHTML = tags.map(function(t, i) {
    var isRegionTag = (t === regionTag);
    var tagLabel = isRegionTag ? regionLabel : t;
    return '<span class="tag-chip' + (isRegionTag ? ' tag-chip-region' : '') + '">'
      + '#' + escapeHtml(tagLabel)
      + '<button type="button" class="tag-chip-remove" onclick="removeTag(' + i + ')">'
      + (isRegionTag ? '&#128205;' : '&#10005;')
      + '</button></span>';
  }).join('');
  document.getElementById('tagsHidden').value = tags.join(',');
}

function submitWrite() {
  var title   = document.getElementById('writeTitle').value.trim();
  var type    = document.getElementById('postType').value;
  var region  = document.getElementById('regionInput').value;

  /* Summernote HTML을 textarea에 동기화 (FormData가 최신값을 읽도록) */
  var $editor = (window.jQuery && jQuery('#writeContent').data('summernote')) ? jQuery('#writeContent') : null;
  if ($editor) {
    document.getElementById('writeContent').value = $editor.summernote('code');
  }
  var contentHtml = document.getElementById('writeContent').value;
  var contentText = htmlToPlainText(contentHtml);

  /* 본문에 포함된 <img> 개수 (photo 유형 최소 장수 검증용) */
  var tmpDiv = document.createElement('div');
  tmpDiv.innerHTML = contentHtml || '';
  var imgCount = tmpDiv.querySelectorAll('img').length;

  /* 지역 태그 강제 포함 */
  var regionTag = REGION_TAG_VALUE[region];
  if (regionTag && tags.indexOf(regionTag) === -1) {
    tags.unshift(regionTag);
    renderTags();
  }

  if (!title) {
    alert(writeMessages.errors.titleRequired);
    document.getElementById('writeTitle').focus();
    return;
  }
  /* 본문 필수: 텍스트나 이미지 중 하나는 있어야 함 */
  if (!contentText && imgCount === 0) {
    alert(writeMessages.errors.contentRequired);
    if ($editor) $editor.summernote('focus');
    else document.getElementById('writeContent').focus();
    return;
  }
  /* photo 유형: 본문에 이미지 최소 3장 필수 */
  if (type === 'photo' && imgCount < PHOTO_MIN_IMAGES) {
    alert(writeMessages.errors.photoRequired);
    return;
  }

  var formData = new FormData(document.getElementById('writeForm'));

  var url = IS_EDIT
    ? CTX + '/community/edit/' + POST_ID
    : CTX + '/community/write';

  fetch(url, {
    method: 'POST',
    headers: { 'X-Requested-With': 'XMLHttpRequest' },
    body: formData
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) {
      location.href = CTX + '/community/' + data.postId;
    } else {
      alert(data.message || writeMessages.errors.generic);
    }
  });
}

function resetWrite() {
  if (!confirm(writeMessages.resetConfirm)) return;
  location.href = CTX + '/community/write';
}

function cancelWrite() {
  var title   = document.getElementById('writeTitle').value;
  var $editor = (window.jQuery && jQuery('#writeContent').data('summernote')) ? jQuery('#writeContent') : null;
  var contentHtml = $editor ? $editor.summernote('code') : document.getElementById('writeContent').value;
  var contentText = htmlToPlainText(contentHtml);
  if (title || contentText) {
    if (!confirm(writeMessages.cancelConfirm)) return;
  }
  if (IS_EDIT) {
    location.href = CTX + '/community/' + POST_ID;
  } else {
    location.href = CTX + '/community/list';
  }
}
</script>

<script>
/* =============================================
   Summernote 에디터 초기화
   - textarea 초기값(isEdit 시 기존 post.content)은 자동 반영
   - onChange 콜백에서 plain text 글자수 카운터 갱신
   - onImageUpload: Phase 1 임시 base64 삽입 (Phase 2에서 Cloudinary 업로드로 교체 예정)
   ============================================= */
jQuery(function($) {
  $('#writeContent').summernote({
    lang: 'ko-KR',
    height: 640,
    minHeight: 480,
    placeholder: writeMessages.contentPlaceholder,
    focus: false,
    disableResizeEditor: false,
    toolbar: [
      ['style', ['style']],
      ['font',  ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
      ['fontsize', ['fontsize']],
      ['color', ['color']],
      ['para',  ['ul', 'ol', 'paragraph']],
      ['insert',['link', 'picture']],
      ['view',  ['fullscreen', 'codeview']]
    ],
    callbacks: {
      onChange: function(contents) {
        var plain = htmlToPlainText(contents);
        document.getElementById('contentCount').textContent = plain.length;
        updatePhotoCount();
      },
      onImageUpload: function(files) {
        /* Cloudinary 업로드 → 반환된 secure_url 을 <img>로 삽입 */
        for (var i = 0; i < files.length; i++) {
          (function(file) {
            var form = new FormData();
            form.append('file', file);
            fetch(CTX + '/community/inline-image', {
              method: 'POST',
              headers: { 'X-Requested-With': 'XMLHttpRequest' },
              body: form
            })
            .then(function(r) { return r.json(); })
            .then(function(data) {
              if (data && data.success && data.url) {
                $('#writeContent').summernote('insertImage', data.url);
              } else {
                alert((data && data.message) || '이미지 업로드에 실패했습니다.');
              }
            })
            .catch(function(err) {
              console.error('inline image upload error', err);
              alert('이미지 업로드 중 오류가 발생했습니다.');
            });
          })(files[i]);
        }
      }
    }
  });

  /* 초기 글자수 카운터 (isEdit 시 기존 본문 기준) */
  var initialHtml = document.getElementById('writeContent').value;
  document.getElementById('contentCount').textContent = htmlToPlainText(initialHtml).length;
});
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
