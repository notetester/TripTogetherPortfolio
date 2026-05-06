<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_community_region_africa" code="community.region.africa"/>
<spring:message var="msg_community_region_asia" code="community.region.asia"/>
<spring:message var="msg_community_region_etc" code="community.region.etc"/>
<spring:message var="msg_community_region_europe" code="community.region.europe"/>
<spring:message var="msg_community_region_northAmerica" code="community.region.northAmerica"/>
<spring:message var="msg_community_region_oceania" code="community.region.oceania"/>
<spring:message var="msg_community_region_southAmerica" code="community.region.southAmerica"/>
<spring:message var="msg_community_type_photo" code="community.type.photo"/>
<spring:message var="msg_community_type_question" code="community.type.question"/>
<spring:message var="msg_community_type_review" code="community.type.review"/>
<spring:message var="msg_community_type_tip" code="community.type.tip"/>
<spring:message var="msg_community_write_content_placeholder" code="community.write.content.placeholder"/>
<spring:message var="msg_community_write_tag_hint" code="community.write.tag.hint"/>
<spring:message var="msg_community_write_tag_placeholder" code="community.write.tag.placeholder"/>
<spring:message var="msg_community_write_title_placeholder" code="community.write.title.placeholder"/>
<spring:message var="msg_community_write_back" code="community.write.back"/>
<spring:message var="msg_community_write_title_edit" code="community.write.title.edit"/>
<spring:message var="msg_community_write_title_reset" code="community.write.title.reset"/>
<spring:message var="msg_community_write_title_label" code="community.write.title.label"/>
<spring:message var="msg_community_write_tag_label" code="community.write.tag.label"/>
<spring:message var="msg_community_write_tag_autoRegion" code="community.write.tag.autoRegion"/>
<spring:message var="msg_community_write_content_label" code="community.write.content.label"/>
<spring:message var="msg_community_write_cancel" code="community.write.cancel"/>
<spring:message var="msg_community_write_submit_edit" code="community.write.submit.edit"/>
<spring:message var="msg_community_write_submit_create" code="community.write.submit.create"/>
<spring:message var="msg_community_write_type_label" code="community.write.type.label"/>
<spring:message var="msg_community_write_region_label" code="community.write.region.label"/>
<spring:message var="msg_community_write_guide_label" code="community.write.guide.label"/>
<spring:message var="msg_community_write_guide_default_1" code="community.write.guide.default.1"/>
<spring:message var="msg_community_write_guide_default_2" code="community.write.guide.default.2"/>
<spring:message var="msg_community_write_guide_default_3" code="community.write.guide.default.3"/>
<spring:message var="msg_community_write_guide_default_4" code="community.write.guide.default.4"/>
<spring:message var="msg_community_region_africa_js" code="community.region.africa" javaScriptEscape="true"/>
<spring:message var="msg_community_region_asia_js" code="community.region.asia" javaScriptEscape="true"/>
<spring:message var="msg_community_region_etc_js" code="community.region.etc" javaScriptEscape="true"/>
<spring:message var="msg_community_region_europe_js" code="community.region.europe" javaScriptEscape="true"/>
<spring:message var="msg_community_region_northAmerica_js" code="community.region.northAmerica" javaScriptEscape="true"/>
<spring:message var="msg_community_region_oceania_js" code="community.region.oceania" javaScriptEscape="true"/>
<spring:message var="msg_community_region_southAmerica_js" code="community.region.southAmerica" javaScriptEscape="true"/>
<spring:message var="msg_community_write_content_photoOnly_js" code="community.write.content.photoOnly" javaScriptEscape="true"/>
<spring:message var="msg_community_write_content_placeholder_js" code="community.write.content.placeholder" javaScriptEscape="true"/>
<spring:message var="msg_community_write_error_contentRequired_js" code="community.write.error.contentRequired" javaScriptEscape="true"/>
<spring:message var="msg_community_write_error_generic_js" code="community.write.error.generic" javaScriptEscape="true"/>
<spring:message var="msg_community_write_error_photoRequired_js" code="community.write.error.photoRequired" javaScriptEscape="true"/>
<spring:message var="msg_community_write_error_regionTagLocked_js" code="community.write.error.regionTagLocked" javaScriptEscape="true"/>
<spring:message var="msg_community_write_error_titleRequired_js" code="community.write.error.titleRequired" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_photo_1_js" code="community.write.guide.photo.1" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_photo_2_js" code="community.write.guide.photo.2" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_photo_3_js" code="community.write.guide.photo.3" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_photo_requirement_js" code="community.write.guide.photo.requirement" javaScriptEscape="true"/>
<spring:message var="msg_community_write_photoCount_label_js" code="community.write.photoCount.label" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_question_1_js" code="community.write.guide.question.1" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_question_2_js" code="community.write.guide.question.2" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_review_1_js" code="community.write.guide.review.1" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_review_2_js" code="community.write.guide.review.2" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_review_3_js" code="community.write.guide.review.3" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_tip_1_js" code="community.write.guide.tip.1" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_tip_2_js" code="community.write.guide.tip.2" javaScriptEscape="true"/>
<spring:message var="msg_community_write_guide_tip_3_js" code="community.write.guide.tip.3" javaScriptEscape="true"/>
<spring:message var="msg_community_write_resetConfirm_js" code="community.write.resetConfirm" javaScriptEscape="true"/>
<spring:message var="msg_community_write_tipCategory_food_js" code="community.write.tipCategory.food" javaScriptEscape="true"/>
<spring:message var="msg_community_write_tipCategory_label_js" code="community.write.tipCategory.label" javaScriptEscape="true"/>
<spring:message var="msg_community_write_tipCategory_money_js" code="community.write.tipCategory.money" javaScriptEscape="true"/>
<spring:message var="msg_community_write_tipCategory_other_js" code="community.write.tipCategory.other" javaScriptEscape="true"/>
<spring:message var="msg_community_write_tipCategory_safety_js" code="community.write.tipCategory.safety" javaScriptEscape="true"/>
<spring:message var="msg_community_write_tipCategory_stay_js" code="community.write.tipCategory.stay" javaScriptEscape="true"/>
<spring:message var="msg_community_write_tipCategory_transport_js" code="community.write.tipCategory.transport" javaScriptEscape="true"/>
<spring:message var="msg_community_write_title_photo_create_js" code="community.write.title.photo.create" javaScriptEscape="true"/>
<spring:message var="msg_community_write_title_photo_edit_js" code="community.write.title.photo.edit" javaScriptEscape="true"/>
<spring:message var="msg_community_write_title_question_create_js" code="community.write.title.question.create" javaScriptEscape="true"/>
<spring:message var="msg_community_write_title_question_edit_js" code="community.write.title.question.edit" javaScriptEscape="true"/>
<spring:message var="msg_community_write_title_review_create_js" code="community.write.title.review.create" javaScriptEscape="true"/>
<spring:message var="msg_community_write_title_review_edit_js" code="community.write.title.review.edit" javaScriptEscape="true"/>
<spring:message var="msg_community_write_title_tip_create_js" code="community.write.title.tip.create" javaScriptEscape="true"/>
<spring:message var="msg_community_write_title_tip_edit_js" code="community.write.title.tip.edit" javaScriptEscape="true"/>
<spring:message var="msg_community_write_cancelConfirm_js" code="community.write.cancelConfirm" javaScriptEscape="true"/>
<%--
  커뮤니티 글쓰기/수정 페이지
  글쓰기: GET /community/write      → model에 post 없음
  수정:   GET /community/edit/{id}  → model에 post, imageList, tagList, tipCategory 있음
--%>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<c:set var="pageCSS" value="community/community_write.css"/>
<%@ include file="../common/header.jsp" %>


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
    <button class="back-btn" onclick="cancelWrite()">&#8592; ${msg_community_write_back}</button>
    <h2 class="write-page-title" id="writePageTitle">
      <c:choose>
        <c:when test="${isEdit}">${msg_community_write_title_edit}</c:when>
        <c:otherwise><span class="write-title-reset" onclick="resetWrite()">${msg_community_write_title_reset}</span></c:otherwise>
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
            ${msg_community_write_title_label} <span class="required">*</span>
          </label>
          <input type="text" id="writeTitle" name="title" class="write-input"
                 placeholder="${msg_community_write_title_placeholder}" maxlength="100"
                 value="${isEdit ? post.title : ''}"
                 oninput="document.getElementById('titleCount').textContent=this.value.length">
          <div class="input-counter">
            <span id="titleCount">${isEdit ? fn:length(post.title) : 0}</span>/100
          </div>
        </div>

        <%-- 해시태그 --%>
        <div class="write-section">
          <label class="section-label">
            ${msg_community_write_tag_label}
            <span class="section-label-sub">(${msg_community_write_tag_autoRegion})</span>
          </label>
          <div class="tag-input-wrap" id="tagInputWrap">
            <div class="tag-list" id="tagList"></div>
            <input type="text" id="tagInput" class="tag-input"
                   placeholder="${msg_community_write_tag_placeholder}" maxlength="20"
                   onkeydown="addTag(event)">
          </div>
          <input type="hidden" id="tagsHidden" name="tags">
          <p class="input-hint">${msg_community_write_tag_hint}</p>
        </div>

          <%-- 유형별 추가 입력 (JS로 동적 렌더링) --%>
        <div id="typeExtraSection"></div>

        <%-- 본문 --%>
        <div class="write-section">
          <label class="section-label" for="writeContent">
            ${msg_community_write_content_label} <span class="required">*</span>
          </label>
          <div id="photoCountBadge" class="photo-count-badge is-short" hidden>
            <span class="photo-count-icon">&#128247;</span>
            <span id="photoCountText"></span>
          </div>
          <textarea id="writeContent" name="content" class="write-textarea"
                    placeholder="${msg_community_write_content_placeholder}"><c:if test="${isEdit}">${fn:escapeXml(post.content)}</c:if></textarea>
          <div class="input-counter">
            <span id="contentCount">0</span>/3000
          </div>
          <div class="write-bottom-actions">
            <button type="button" class="btn-cancel" onclick="cancelWrite()">${msg_community_write_cancel}</button>
            <button type="button" class="btn-submit" onclick="submitWrite()">
              <c:choose>
                <c:when test="${isEdit}">${msg_community_write_submit_edit}</c:when>
                <c:otherwise>${msg_community_write_submit_create}</c:otherwise>
              </c:choose>
            </button>
          </div>
        </div>

      </main>

      <%-- 사이드바 --%>
      <aside class="write-aside">

        <%-- 게시글 유형 --%>
        <div class="aside-card">
          <div class="aside-card-title">${msg_community_write_type_label} <span class="required">*</span></div>
          <input type="hidden" id="postType" name="postType"
                 value="${isEdit ? post.postType : 'review'}">
          <div class="type-select-grid">
            <button type="button" class="type-select-btn ${(!isEdit || post.postType eq 'review') ? 'active' : ''}"
                    data-type="review" onclick="selectType('review', this)">
              <span class="type-btn-icon">&#128172;</span>
              <span class="type-btn-label">${msg_community_type_review}</span>
            </button>
            <button type="button" class="type-select-btn ${(isEdit && post.postType eq 'photo') ? 'active' : ''}"
                    data-type="photo" onclick="selectType('photo', this)">
              <span class="type-btn-icon">&#128247;</span>
              <span class="type-btn-label">${msg_community_type_photo}</span>
            </button>
            <button type="button" class="type-select-btn ${(isEdit && post.postType eq 'tip') ? 'active' : ''}"
                    data-type="tip" onclick="selectType('tip', this)">
              <span class="type-btn-icon">&#128161;</span>
              <span class="type-btn-label">${msg_community_type_tip}</span>
            </button>
            <button type="button" class="type-select-btn ${(isEdit && post.postType eq 'question') ? 'active' : ''}"
                    data-type="question" onclick="selectType('question', this)">
              <span class="type-btn-icon">&#10067;</span>
              <span class="type-btn-label">${msg_community_type_question}</span>
            </button>
          </div>
        </div>

        <%-- 지역 선택 --%>
        <div class="aside-card">
          <div class="aside-card-title">${msg_community_write_region_label} <span class="required">*</span></div>
          <input type="hidden" id="regionInput" name="region"
                 value="${isEdit ? post.region : 'asia'}">
          <div class="region-select-list">
            <button type="button" class="region-select-btn ${(!isEdit || post.region eq 'asia') ? 'active' : ''}"
                    data-region="asia" onclick="selectRegion('asia', this)">&#127759; ${msg_community_region_asia}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'europe') ? 'active' : ''}"
                    data-region="europe" onclick="selectRegion('europe', this)">&#127957; ${msg_community_region_europe}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'africa') ? 'active' : ''}"
                    data-region="africa" onclick="selectRegion('africa', this)">&#127758; ${msg_community_region_africa}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'north_america') ? 'active' : ''}"
                    data-region="north_america" onclick="selectRegion('north_america', this)">&#127482;&#127480; ${msg_community_region_northAmerica}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'south_america') ? 'active' : ''}"
                    data-region="south_america" onclick="selectRegion('south_america', this)">&#127475;&#127480; ${msg_community_region_southAmerica}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'oceania') ? 'active' : ''}"
                    data-region="oceania" onclick="selectRegion('oceania', this)">&#127944; ${msg_community_region_oceania}</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'etc') ? 'active' : ''}"
                    data-region="etc" onclick="selectRegion('etc', this)">&#127760; ${msg_community_region_etc}</button>
          </div>
        </div>

        <%-- 작성 가이드 --%>
        <div class="aside-card guide-card">
          <div class="aside-card-title">&#128221; ${msg_community_write_guide_label}</div>
          <ul class="guide-list" id="guideList">
            <li>${msg_community_write_guide_default_1}</li>
            <li>${msg_community_write_guide_default_2}</li>
            <li>${msg_community_write_guide_default_3}</li>
            <li>${msg_community_write_guide_default_4}</li>
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
  cancelConfirm: '${msg_community_write_cancelConfirm_js}',
  contentPhotoOnly: '${msg_community_write_content_photoOnly_js}',
  contentPlaceholder: '${msg_community_write_content_placeholder_js}',
  photoCountLabel: '${msg_community_write_photoCount_label_js}',
  errors: {
    contentRequired: '${msg_community_write_error_contentRequired_js}',
    generic: '${msg_community_write_error_generic_js}',
    photoRequired: '${msg_community_write_error_photoRequired_js}',
    regionTagLocked: '${msg_community_write_error_regionTagLocked_js}',
    titleRequired: '${msg_community_write_error_titleRequired_js}'
  },
  guides: {
    photo: [
      '${msg_community_write_guide_photo_requirement_js}',
      '${msg_community_write_guide_photo_1_js}',
      '${msg_community_write_guide_photo_2_js}',
      '${msg_community_write_guide_photo_3_js}'
    ],
    question: [
      '${msg_community_write_guide_question_1_js}',
      '${msg_community_write_guide_question_2_js}'
    ],
    review: [
      '${msg_community_write_guide_review_1_js}',
      '${msg_community_write_guide_review_2_js}',
      '${msg_community_write_guide_review_3_js}'
    ],
    tip: [
      '${msg_community_write_guide_tip_1_js}',
      '${msg_community_write_guide_tip_2_js}',
      '${msg_community_write_guide_tip_3_js}'
    ]
  },
  regionLabels: {
    africa: '${msg_community_region_africa_js}',
    asia: '${msg_community_region_asia_js}',
    etc: '${msg_community_region_etc_js}',
    europe: '${msg_community_region_europe_js}',
    north_america: '${msg_community_region_northAmerica_js}',
    oceania: '${msg_community_region_oceania_js}',
    south_america: '${msg_community_region_southAmerica_js}'
  },
  resetConfirm: '${msg_community_write_resetConfirm_js}',
  tipCategories: {
    food: '${msg_community_write_tipCategory_food_js}',
    label: '${msg_community_write_tipCategory_label_js}',
    money: '${msg_community_write_tipCategory_money_js}',
    other: '${msg_community_write_tipCategory_other_js}',
    safety: '${msg_community_write_tipCategory_safety_js}',
    stay: '${msg_community_write_tipCategory_stay_js}',
    transport: '${msg_community_write_tipCategory_transport_js}'
  },
  titles: {
    photo: { create: '${msg_community_write_title_photo_create_js}', edit: '${msg_community_write_title_photo_edit_js}' },
    question: { create: '${msg_community_write_title_question_create_js}', edit: '${msg_community_write_title_question_edit_js}' },
    review: { create: '${msg_community_write_title_review_create_js}', edit: '${msg_community_write_title_review_edit_js}' },
    tip: { create: '${msg_community_write_title_tip_create_js}', edit: '${msg_community_write_title_tip_edit_js}' }
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
