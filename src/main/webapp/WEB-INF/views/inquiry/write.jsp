<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="inquiry/inquiry.css"/>
<%@ include file="../common/header.jsp" %>
<body>
<div class="inq-write-wrap">
  <div class="inq-write-inner">
    <div class="inq-write-header">
      <button class="inq-back-btn" onclick="location.href='${pageContext.request.contextPath}/inquiry/list'">
        &#8592; <spring:message code="inquiry.write.back"/>
      </button>
      <h1><spring:message code="inquiry.write.title"/></h1>
      <p><spring:message code="inquiry.write.subtitle"/></p>
    </div>

    <div class="inq-write-card">
      <div class="inq-form-group">
        <label class="inq-form-label" for="category">
          <spring:message code="inquiry.write.type"/> <span class="inq-required">*</span>
        </label>
        <select class="inq-form-select" id="category" name="category">
          <option value=""><spring:message code="inquiry.write.type.placeholder"/></option>
          <option value="service"><spring:message code="inquiry.write.type.service"/></option>
          <option value="payment"><spring:message code="inquiry.write.type.payment"/></option>
          <option value="account"><spring:message code="inquiry.write.type.account"/></option>
          <option value="bug"><spring:message code="inquiry.write.type.bug"/></option>
          <option value="etc"><spring:message code="inquiry.write.type.etc"/></option>
        </select>
        <div class="inq-field-msg" id="categoryMsg"></div>
      </div>

      <div class="inq-form-group">
        <label class="inq-form-label" for="title">
          <spring:message code="inquiry.write.subject"/> <span class="inq-required">*</span>
        </label>
        <input class="inq-form-input" type="text" id="title" name="title"
               placeholder="<spring:message code='inquiry.write.subject.placeholder'/>" maxlength="200">
        <div class="inq-field-msg" id="titleMsg"></div>
      </div>

      <div class="inq-form-group">
        <label class="inq-form-label" for="content">
          <spring:message code="inquiry.write.content"/> <span class="inq-required">*</span>
        </label>
        <textarea class="inq-form-textarea" id="content" name="content"
                  placeholder="<spring:message code='inquiry.write.content.placeholder'/>"
                  rows="10" maxlength="5000"></textarea>
        <div class="inq-textarea-footer">
          <div class="inq-field-msg" id="contentMsg"></div>
          <span class="inq-char-count"><span id="contentCount">0</span> / 5000</span>
        </div>
      </div>

      <div class="inq-form-group">
        <label class="inq-form-label"><spring:message code="inquiry.write.attach"/> <span style="font-size:12px;color:var(--gray-400);"><spring:message code="inquiry.write.attach.help"/></span></label>
        <input type="file" class="inq-form-input" id="images" name="images" multiple accept=".jpg,.jpeg,.png,.gif,.webp">
        <div class="inq-attach-preview" id="attachPreview"></div>
      </div>

      <div class="inq-form-group">
        <label class="inq-private-toggle">
          <input type="checkbox" id="isPrivate">
          <span class="inq-toggle-slider"></span>
          <span class="inq-toggle-label"><spring:message code="inquiry.write.private"/></span>
        </label>
        <div class="inq-private-hint"><spring:message code="inquiry.write.private.help"/></div>
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
      setMsg('categoryMsg', '<spring:message code="inquiry.write.error.category" javaScriptEscape="true"/>', 'error');
      valid = false;
    } else { clearMsg('categoryMsg'); }

    if (!title) {
      setMsg('titleMsg', '<spring:message code="inquiry.write.error.title" javaScriptEscape="true"/>', 'error');
      valid = false;
    } else if (title.length < 5) {
      setMsg('titleMsg', '<spring:message code="inquiry.write.error.title.length" javaScriptEscape="true"/>', 'error');
      valid = false;
    } else { clearMsg('titleMsg'); }

    if (!content) {
      setMsg('contentMsg', '<spring:message code="inquiry.write.error.content" javaScriptEscape="true"/>', 'error');
      valid = false;
    } else if (content.length < 10) {
      setMsg('contentMsg', '<spring:message code="inquiry.write.error.content.length" javaScriptEscape="true"/>', 'error');
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
        alert('<spring:message code="inquiry.write.fail" javaScriptEscape="true"/>');
        btn.disabled = false;
        btn.classList.remove('loading');
      }
    } catch (e) {
      alert('<spring:message code="inquiry.write.server" javaScriptEscape="true"/>');
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
