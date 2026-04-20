<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  커뮤니티 글쓰기/수정 페이지
  글쓰기: GET /community/write      → model에 post 없음
  수정:   GET /community/edit/{id}  → model에 post, imageList, tagList, tipCategory 있음
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="community/community_write.css"/>
<%@ include file="../common/header.jsp" %>

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
    <button class="back-btn" onclick="cancelWrite()">&#8592; 목록으로</button>
    <h2 class="write-page-title" id="writePageTitle">
      <c:choose>
        <c:when test="${isEdit}">게시글 수정</c:when>
        <c:otherwise><span class="write-title-reset" onclick="resetWrite()">여행 이야기 쓰기</span></c:otherwise>
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
            제목 <span class="required">*</span>
          </label>
          <input type="text" id="writeTitle" name="title" class="write-input"
                 placeholder="오른쪽 '게시글유형'과 '지역선택'도 하실 수 있어요" maxlength="100"
                 value="${isEdit ? post.title : ''}"
                 oninput="document.getElementById('titleCount').textContent=this.value.length">
          <div class="input-counter">
            <span id="titleCount">${isEdit ? fn:length(post.title) : 0}</span>/100
          </div>
        </div>

        <%-- 해시태그 --%>
        <div class="write-section">
          <label class="section-label">
            해시태그
            <span class="section-label-sub">(지역 태그는 자동 추가됩니다)</span>
          </label>
          <div class="tag-input-wrap" id="tagInputWrap">
            <div class="tag-list" id="tagList"></div>
            <input type="text" id="tagInput" class="tag-input"
                   placeholder="국가명, 도시명, 여행 키워드 입력 후 Enter (최대 10개)" maxlength="20"
                   onkeydown="addTag(event)">
          </div>
          <input type="hidden" id="tagsHidden" name="tags">
          <p class="input-hint">예: 도쿄, 일본여행, 맛집 (지역 태그는 자동으로 추가돼요) (지역선택 헷갈리면 오른쪽 아래 챗봇이 잘 알려줘요)</p>
        </div>

  <%-- 이미지 업로드 --%>
        <div class="write-section">
          <label class="section-label">
            사진 첨부
            <span class="section-label-sub" id="imgLimitLabel">(최대 5장)</span>
          </label>
          <div class="img-upload-grid" id="imgUploadGrid">
            <div class="img-add-btn"
                 onclick="document.getElementById('imgInput').click()">
              <div class="img-add-icon">&#128247;</div>
              <span class="img-add-text">사진 추가</span>
              <span class="img-add-count">
                <span id="imgCount">0</span>/<span id="imgMax">5</span>
              </span>
            </div>
          </div>
          <input type="file" id="imgInput" accept="image/*" multiple
                 style="display:none;" onchange="addImages(event)">
          <p class="input-hint">JPG, JPEG, GIF, PNG, WEBP · 파일당 최대 10MB · 첫 번째 사진이 대표 이미지</p>
        </div>

          <%-- 유형별 추가 입력 (JS로 동적 렌더링) --%>
        <div id="typeExtraSection"></div>

        <%-- 본문 --%>
        <div class="write-section">
          <label class="section-label" for="writeContent">
            내용 <span class="required">*</span>
          </label>
          <textarea id="writeContent" name="content" class="write-textarea"
                    placeholder="우리는 목적지에 닿아야 행복해지는 것이 아니라 여행하는 과정에서 행복을 느낀다."
                    rows="12" maxlength="3000"
                    oninput="document.getElementById('contentCount').textContent=this.value.length"><c:if test="${isEdit}">${post.content}</c:if></textarea>
          <div class="input-counter">
            <span id="contentCount">${isEdit ? fn:length(post.content) : 0}</span>/3000
          </div>
          <div class="write-bottom-actions">
            <button type="button" class="btn-cancel" onclick="cancelWrite()">취소</button>
            <button type="button" class="btn-submit" onclick="submitWrite()">
              <c:choose>
                <c:when test="${isEdit}">수정하기</c:when>
                <c:otherwise>등록하기</c:otherwise>
              </c:choose>
            </button>
          </div>
        </div>

      </main>

      <%-- 사이드바 --%>
      <aside class="write-aside">

        <%-- 게시글 유형 --%>
        <div class="aside-card">
          <div class="aside-card-title">게시글 유형 <span class="required">*</span></div>
          <input type="hidden" id="postType" name="postType"
                 value="${isEdit ? post.postType : 'review'}">
          <div class="type-select-grid">
            <button type="button" class="type-select-btn ${(!isEdit || post.postType eq 'review') ? 'active' : ''}"
                    data-type="review" onclick="selectType('review', this)">
              <span class="type-btn-icon">&#128172;</span>
              <span class="type-btn-label">여행 후기</span>
            </button>
            <button type="button" class="type-select-btn ${(isEdit && post.postType eq 'photo') ? 'active' : ''}"
                    data-type="photo" onclick="selectType('photo', this)">
              <span class="type-btn-icon">&#128247;</span>
              <span class="type-btn-label">사진</span>
            </button>
            <button type="button" class="type-select-btn ${(isEdit && post.postType eq 'tip') ? 'active' : ''}"
                    data-type="tip" onclick="selectType('tip', this)">
              <span class="type-btn-icon">&#128161;</span>
              <span class="type-btn-label">여행 팁</span>
            </button>
            <button type="button" class="type-select-btn ${(isEdit && post.postType eq 'question') ? 'active' : ''}"
                    data-type="question" onclick="selectType('question', this)">
              <span class="type-btn-icon">&#10067;</span>
              <span class="type-btn-label">질문</span>
            </button>
          </div>
        </div>

        <%-- 지역 선택 --%>
        <div class="aside-card">
          <div class="aside-card-title">지역 선택 <span class="required">*</span></div>
          <input type="hidden" id="regionInput" name="region"
                 value="${isEdit ? post.region : 'asia'}">
          <div class="region-select-list">
            <button type="button" class="region-select-btn ${(!isEdit || post.region eq 'asia') ? 'active' : ''}"
                    data-region="asia" onclick="selectRegion('asia', this)">&#127759; 아시아</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'europe') ? 'active' : ''}"
                    data-region="europe" onclick="selectRegion('europe', this)">&#127957; 유럽</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'africa') ? 'active' : ''}"
                    data-region="africa" onclick="selectRegion('africa', this)">&#127758; 아프리카</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'north_america') ? 'active' : ''}"
                    data-region="north_america" onclick="selectRegion('north_america', this)">&#127482;&#127480; 북아메리카</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'south_america') ? 'active' : ''}"
                    data-region="south_america" onclick="selectRegion('south_america', this)">&#127475;&#127480; 남아메리카</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'oceania') ? 'active' : ''}"
                    data-region="oceania" onclick="selectRegion('oceania', this)">&#127944; 오세아니아</button>
            <button type="button" class="region-select-btn ${(isEdit && post.region eq 'etc') ? 'active' : ''}"
                    data-region="etc" onclick="selectRegion('etc', this)">&#127760; 기타</button>
          </div>
        </div>

        <%-- 작성 가이드 --%>
        <div class="aside-card guide-card">
          <div class="aside-card-title">&#128221; 작성 가이드</div>
          <ul class="guide-list" id="guideList">
            <li>실제 여행 경험을 솔직하게 공유해주세요</li>
            <li>다른 여행자에게 도움이 될 정보를 담아주세요</li>
            <li>타인을 비방하거나 광고성 내용은 삭제될 수 있어요</li>
            <li>저작권이 있는 이미지 사용은 삼가주세요</li>
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
var uploadedFiles = [];
var MAX_IMAGES = 5;

var TYPE_CONFIG = {
  review: {
    title: IS_EDIT ? '여행 후기 수정' : '여행 후기 쓰기', imgMax: 5,
    guide: ['실제 여행 경험을 솔직하게 공유해주세요',
            '사진과 함께 올리면 더욱 생동감 있어요',
            '여행 일정, 경비, 팁을 함께 적어주세요']
  },
  photo: {
    title: IS_EDIT ? '사진 수정' : '사진 올리기', imgMax: 10,
    guide: ['사진이 주인공이에요! 멋진 사진을 올려주세요',
            '해시태그를 사용하면 더 좋아요',
            '여러 장의 사진으로 여행을 기록해보세요']
  },
  tip: {
    title: IS_EDIT ? '여행 팁 수정' : '여행 팁 공유하기', imgMax: 3,
    guide: ['구체적이고 실용적인 정보를 써주세요',
            '최신 정보인지 확인 후 작성해주세요',
            '출처가 있다면 함께 적어주세요']
  },
  question: {
    title: IS_EDIT ? '질문 수정' : '질문하기', imgMax: 2,
    guide: ['질문을 구체적으로 작성해주세요',
            '여행 일정과 예산을 함께 알려주세요']
  }
};

var REGION_TAG = {
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

    /* 기존 이미지 복원 (URL로 표시, 실제 파일 객체는 없음) */
    <c:forEach var="img" items="${imageList}">
    uploadedFiles.push({ url: '${img.imageUrl}', file: null, existing: true, imageUrl: '${img.imageUrl}' });
    </c:forEach>
    renderImageGrid();

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

  } else {
    /* 글쓰기 모드: 기본 지역 태그(아시아) 자동 추가 */
    var defaultTag = REGION_TAG['asia'];
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

  /* 사진 유형이면 본문 비활성화 */
  var contentArea    = document.getElementById('writeContent');
  var contentSection = contentArea.closest('.write-section');
  if (type === 'photo') {
    contentArea.readOnly = true;
    contentArea.value       = '';
    contentArea.placeholder = '사진 유형은 해시태그만 가능해요';
    contentArea.style.background = '#f3f4f6';
    contentArea.style.color      = '#9ca3af';
    contentSection.style.opacity = '0.5';
  } else {
    contentArea.readOnly    = false;
    contentArea.disabled    = false;
    contentArea.placeholder = '우리는 목적지에 닿아야 행복해지는 것이 아니라 여행하는 과정에서 행복을 느낀다.';
    contentArea.style.background = '';
    contentArea.style.color      = '';
    contentSection.style.opacity = '';
  }
  MAX_IMAGES = cfg.imgMax;
  document.getElementById('imgLimitLabel').textContent = '(최대 ' + cfg.imgMax + '장)';
  document.getElementById('imgMax').textContent = cfg.imgMax;
  document.getElementById('guideList').innerHTML =
      cfg.guide.map(function(g) { return '<li>' + g + '</li>'; }).join('');

  var sec = document.getElementById('typeExtraSection');
  if (type === 'tip') {
    sec.innerHTML = '<div class="write-section">'
      + '<label class="section-label">팁 카테고리 <span class="required">*</span></label>'
      + '<input type="hidden" id="tipCategoryInput" name="tipCategory" value="transport">'
      + '<div class="tip-cat-grid">'
      + '<button type="button" class="tip-cat-btn active" onclick="selTipCat(\'transport\',this)">&#9992; 교통</button>'
      + '<button type="button" class="tip-cat-btn" onclick="selTipCat(\'accom\',this)">&#127968; 숙소</button>'
      + '<button type="button" class="tip-cat-btn" onclick="selTipCat(\'food\',this)">&#127869; 맛집</button>'
      + '<button type="button" class="tip-cat-btn" onclick="selTipCat(\'money\',this)">&#128176; 환전·예산</button>'
      + '<button type="button" class="tip-cat-btn" onclick="selTipCat(\'safety\',this)">&#128737; 안전</button>'
      + '<button type="button" class="tip-cat-btn" onclick="selTipCat(\'other\',this)">&#128161; 기타</button>'
      + '</div></div>';
  } else if (type === 'question') {
    sec.innerHTML = '';
  } else {
    sec.innerHTML = '';
  }

  if (uploadedFiles.length > MAX_IMAGES) {
    uploadedFiles = uploadedFiles.slice(0, MAX_IMAGES);
    renderImageGrid();
  }
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

  var prevTag = REGION_TAG[prev];
  if (prevTag) {
    var idx = tags.indexOf(prevTag);
    if (idx !== -1) tags.splice(idx, 1);
  }
  var newTag = REGION_TAG[region];
  if (newTag && tags.indexOf(newTag) === -1) {
    tags.unshift(newTag);
  }
  renderTags();
}

function addImages(event) {
  var files = Array.from(event.target.files);
  var allowed = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];

  /* 파일 형식 검증 */
  for (var i = 0; i < files.length; i++) {
    var ext = files[i].name.substring(files[i].name.lastIndexOf('.')).toLowerCase();
    if (allowed.indexOf(ext) === -1) {
      alert(files[i].name + ' 은 지원하지 않는 파일 형식이에요.\nJPG, JPEG, PNG, GIF, WEBP만 가능해요.');
      event.target.value = '';
      return;
    }
  }

  var remain = MAX_IMAGES - uploadedFiles.length;
  if (remain <= 0) {
    alert('사진은 최대 ' + MAX_IMAGES + '장까지 첨부할 수 있어요.');
    return;
  }
  files.slice(0, remain).forEach(function(file) {
    var reader = new FileReader();
    reader.onload = function(e) {
      uploadedFiles.push({ url: e.target.result, file: file, existing: false });
      renderImageGrid();
    };
    reader.readAsDataURL(file);
  });
  event.target.value = '';
}

function removeImage(idx) {
  uploadedFiles.splice(idx, 1);
  renderImageGrid();
}

function renderImageGrid() {
  var grid = document.getElementById('imgUploadGrid');
  var html = '';
  uploadedFiles.forEach(function(img, i) {
    html += '<div class="img-preview-item">'
      + '<img src="' + img.url + '" alt="미리보기">'
      + '<button type="button" class="img-remove-btn" onclick="removeImage(' + i + ')">&#10005;</button>'
      + (i === 0 ? '<span class="img-rep-badge">대표</span>' : '')
      + (img.existing ? '<span class="img-rep-badge" style="background:#16a34a;bottom:20px;">기존</span>' : '')
      + '</div>';
  });
  if (uploadedFiles.length < MAX_IMAGES) {
    html += '<div class="img-add-btn" onclick="document.getElementById(\'imgInput\').click()">'
      + '<div class="img-add-icon">&#128247;</div>'
      + '<span class="img-add-text">사진 추가</span>'
      + '<span class="img-add-count"><span id="imgCount">'
      + uploadedFiles.length + '</span>/<span id="imgMax">' + MAX_IMAGES + '</span></span>'
      + '</div>';
  }
  grid.innerHTML = html;
}

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
  var regionTag = REGION_TAG[region];
  if (tags[idx] === regionTag) {
    alert('지역 태그는 삭제할 수 없어요. 지역을 변경하면 자동으로 바뀌어요!');
    return;
  }
  tags.splice(idx, 1);
  renderTags();
}

function renderTags() {
  var region = document.getElementById('regionInput').value;
  var regionTag = REGION_TAG[region];
  document.getElementById('tagList').innerHTML = tags.map(function(t, i) {
    var isRegionTag = (t === regionTag);
    return '<span class="tag-chip' + (isRegionTag ? ' tag-chip-region' : '') + '">'
      + '#' + t
      + '<button type="button" class="tag-chip-remove" onclick="removeTag(' + i + ')">'
      + (isRegionTag ? '&#128205;' : '&#10005;')
      + '</button></span>';
  }).join('');
  document.getElementById('tagsHidden').value = tags.join(',');
}

function submitWrite(forceSubmit) {
  var title   = document.getElementById('writeTitle').value.trim();
  var content = document.getElementById('writeContent').value.trim();
  var type    = document.getElementById('postType').value;
  var region  = document.getElementById('regionInput').value;

  /* 지역 태그 강제 포함 */
  var regionTag = REGION_TAG[region];
  if (regionTag && tags.indexOf(regionTag) === -1) {
    tags.unshift(regionTag);
    renderTags();
  }

  if (!forceSubmit) {
    if (!title) {
      alert('제목을 입력해주세요.');
      document.getElementById('writeTitle').focus();
      return;
    }
    if (!content && type !== 'photo') {
      alert('내용을 입력해주세요.');
      document.getElementById('writeContent').focus();
      return;
    }
    if (type === 'photo' && uploadedFiles.length === 0) {
      alert('사진 유형은 최소 1장의 사진이 필요해요.');
      return;
    }
  }

  /* 사진 유형이면 content를 빈 문자열로 강제 설정 */
  if (type === 'photo') {
    document.getElementById('writeContent').value = '';
    document.getElementById('writeContent').readOnly = false;
  }

  var formData = new FormData(document.getElementById('writeForm'));
  if (forceSubmit) formData.append('forceSubmit', 'true');

  /* 새로 추가된 이미지만 전송 */
  uploadedFiles.forEach(function(img) {
    if (!img.existing && img.file) {
      formData.append('images', img.file);
    }
  });

  /* 기존 이미지 URL 전송 (수정 시 유지할 이미지) */
  if (IS_EDIT) {
    uploadedFiles.forEach(function(img) {
      if (img.existing) {
        formData.append('existingImages', img.imageUrl);
      }
    });
  }

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
    if (data.toxicityDetected) {
      if (confirm(data.message || '부적절한 표현이 감지되었습니다. 그래도 등록하시겠습니까?')) {
        submitWrite(true);
      }
      return;
    }
    if (data.success) {
      location.href = CTX + '/community/' + data.postId;
    } else {
      alert(data.message || '처리 중 오류가 발생했습니다.');
    }
  });
}

function resetWrite() {
  if (!confirm('작성 중인 내용이 모두 초기화됩니다. 새로 시작하시겠습니까?')) return;
  location.href = CTX + '/community/write';
}

function cancelWrite() {
  var title   = document.getElementById('writeTitle').value;
  var content = document.getElementById('writeContent').value;
  if (title || content) {
    if (!confirm('작성 중인 내용이 있습니다. 취소하시겠습니까?')) return;
  }
  if (IS_EDIT) {
    location.href = CTX + '/community/' + POST_ID;
  } else {
    location.href = CTX + '/community/list';
  }
}
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
