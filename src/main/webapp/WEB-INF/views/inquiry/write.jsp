<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_aabadf521f" code="inquiry.write.back"/>
<spring:message var="autoMsg_359579dc32" code="inquiry.write.title"/>
<spring:message var="autoMsg_9219163926" code="inquiry.write.subtitle"/>
<spring:message var="autoMsg_b278c3a55c" code="inquiry.write.type"/>
<spring:message var="autoMsg_fdaedfc189" code="inquiry.write.type.placeholder"/>
<spring:message var="autoMsg_1619b9a8fb" code="inquiry.write.type.service"/>
<spring:message var="autoMsg_e95a797c85" code="inquiry.write.type.payment"/>
<spring:message var="autoMsg_e08ced083d" code="inquiry.write.type.account"/>
<spring:message var="autoMsg_4673bb90d0" code="inquiry.write.type.bug"/>
<spring:message var="autoMsg_93a82e67b6" code="inquiry.write.type.etc"/>
<spring:message var="autoMsg_106b493be2" code="inquiry.write.subject"/>
<spring:message var="autoMsg_9de3bd82ea" code="inquiry.write.subject.placeholder"/>
<spring:message var="autoMsg_74767cf17c" code="inquiry.write.content"/>
<spring:message var="autoMsg_cea4ae59ac" code="inquiry.write.content.placeholder"/>
<spring:message var="autoMsg_298a7111ee" code="inquiry.write.attach"/>
<spring:message var="autoMsg_5c8511811e" code="inquiry.write.attach.help"/>
<spring:message var="autoMsg_8591605faf" code="inquiry.write.private"/>
<spring:message var="autoMsg_cace258834" code="inquiry.write.private.help"/>
<spring:message var="autoMsg_e9cda1afe6" code="inquiry.write.error.category" javaScriptEscape="true"/>
<spring:message var="autoMsg_68aee64efd" code="inquiry.write.error.title" javaScriptEscape="true"/>
<spring:message var="autoMsg_3038a04aaa" code="inquiry.write.error.title.length" javaScriptEscape="true"/>
<spring:message var="autoMsg_71a9b4b3c1" code="inquiry.write.error.content" javaScriptEscape="true"/>
<spring:message var="autoMsg_e9d37d7a87" code="inquiry.write.error.content.length" javaScriptEscape="true"/>
<spring:message var="autoMsg_3f048b03f0" code="inquiry.write.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_f51fc3f17f" code="inquiry.write.server" javaScriptEscape="true"/>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="inquiry/inquiry.css"/>
<%@ include file="../common/header.jsp" %>
<body>
<div class="inq-write-wrap">
  <div class="inq-write-inner">
    <div class="inq-write-header">
      <button class="inq-back-btn" onclick="location.href='${pageContext.request.contextPath}/inquiry/list'">
        &#8592; ${autoMsg_aabadf521f}
      </button>
      <h1>${autoMsg_359579dc32}</h1>
      <p>${autoMsg_9219163926}</p>
    </div>

    <div class="inq-write-card">
      <div class="inq-form-group">
        <label class="inq-form-label" for="category">
          ${autoMsg_b278c3a55c} <span class="inq-required">*</span>
        </label>
        <select class="inq-form-select" id="category" name="category">
          <option value="">${autoMsg_fdaedfc189}</option>
          <option value="service">${autoMsg_1619b9a8fb}</option>
          <option value="payment">${autoMsg_e95a797c85}</option>
          <option value="account">${autoMsg_e08ced083d}</option>
          <option value="bug">${autoMsg_4673bb90d0}</option>
          <option value="etc">${autoMsg_93a82e67b6}</option>
        </select>
        <div class="inq-field-msg" id="categoryMsg"></div>
      </div>

      <div class="inq-form-group">
        <label class="inq-form-label" for="title">
          ${autoMsg_106b493be2} <span class="inq-required">*</span>
        </label>
        <input class="inq-form-input" type="text" id="title" name="title"
               placeholder="${autoMsg_9de3bd82ea}" maxlength="200">
        <div class="inq-field-msg" id="titleMsg"></div>
      </div>

      <div class="inq-form-group">
        <label class="inq-form-label" for="content">
          ${autoMsg_74767cf17c} <span class="inq-required">*</span>
        </label>
        <textarea class="inq-form-textarea" id="content" name="content"
                  placeholder="${autoMsg_cea4ae59ac}"
                  rows="10" maxlength="5000"></textarea>
        <div class="inq-textarea-footer">
          <div class="inq-field-msg" id="contentMsg"></div>
          <span class="inq-char-count"><span id="contentCount">0</span> / 5000</span>
        </div>
      </div>

      <div class="inq-form-group">
        <label class="inq-form-label">${autoMsg_298a7111ee} <span style="font-size:12px;color:var(--gray-400);">${autoMsg_5c8511811e}</span></label>
        <input type="file" class="inq-form-input" id="images" name="images" multiple accept=".jpg,.jpeg,.png,.gif,.webp">
        <div class="inq-attach-preview" id="attachPreview"></div>
      </div>

      <div class="inq-form-group">
        <label class="inq-private-toggle">
          <input type="checkbox" id="isPrivate">
          <span class="inq-toggle-slider"></span>
          <span class="inq-toggle-label">${autoMsg_8591605faf}</span>
        </label>
        <div class="inq-private-hint">${autoMsg_cace258834}</div>
      </div>

      <div class="inq-write-actions">
        <button class="inq-btn-cancel" onclick="location.href='${pageContext.request.contextPath}/inquiry/list'">
          <spring:message code="inquiry.write.cancel"/>
        </button>
        <button class="inq-btn-submit" id="submitBtn">
          <spring:message code="inquiry.write.submit"/>
        </button>
      </div>
    </div>
  </div>
</div>

<script>
(function () {
  const ctx = '${pageContext.request.contextPath}';
  const contentEl = document.getElementById('content');
  const countEl = document.getElementById('contentCount');
  contentEl.addEventListener('input', function () {
    countEl.textContent = this.value.length;
  });

  document.getElementById('images').addEventListener('change', function () {
    const preview = document.getElementById('attachPreview');
    preview.innerHTML = '';
    Array.from(this.files).forEach(function (file) {
      const item = document.createElement('div');
      item.className = 'inq-attach-preview-item';
      item.textContent = file.name;
      preview.appendChild(item);
    });
  });

  document.getElementById('submitBtn').addEventListener('click', async function () {
    const category = document.getElementById('category').value;
    const title = document.getElementById('title').value.trim();
    const content = contentEl.value.trim();
    const isPrivate = document.getElementById('isPrivate').checked ? 1 : 0;

    let valid = true;
    if (!category) {
      setMsg('categoryMsg', '${autoMsg_e9cda1afe6}', 'error');
      valid = false;
    } else { clearMsg('categoryMsg'); }

    if (!title) {
      setMsg('titleMsg', '${autoMsg_68aee64efd}', 'error');
      valid = false;
    } else if (title.length < 5) {
      setMsg('titleMsg', '${autoMsg_3038a04aaa}', 'error');
      valid = false;
    } else { clearMsg('titleMsg'); }

    if (!content) {
      setMsg('contentMsg', '${autoMsg_71a9b4b3c1}', 'error');
      valid = false;
    } else if (content.length < 10) {
      setMsg('contentMsg', '${autoMsg_e9d37d7a87}', 'error');
      valid = false;
    } else { clearMsg('contentMsg'); }

    if (!valid) return;

    this.disabled = true;
    this.classList.add('loading');
    const btn = this;
    try {
      const formData = new FormData();
      formData.append('category', category);
      formData.append('title', title);
      formData.append('content', content);
      formData.append('isPrivate', isPrivate);
      const imageInput = document.getElementById('images');
      Array.from(imageInput.files).forEach(function (file) {
        formData.append('images', file);
      });

      const res = await fetch(ctx + '/inquiry/write', { method: 'POST', body: formData });
      const data = await res.json();

      if (data.success) {
        location.href = ctx + '/inquiry/' + data.inquiryId;
      } else {
        alert('${autoMsg_3f048b03f0}');
        btn.disabled = false;
        btn.classList.remove('loading');
      }
    } catch (e) {
      alert('${autoMsg_f51fc3f17f}');
      btn.disabled = false;
      btn.classList.remove('loading');
    }
  });

  function setMsg(id, msg, type) {
    const el = document.getElementById(id);
    el.textContent = msg;
    el.className = 'inq-field-msg ' + type;
  }

  function clearMsg(id) {
    const el = document.getElementById(id);
    el.textContent = '';
    el.className = 'inq-field-msg';
  }
})();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
