
<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_inquiry_write_subject_placeholder" code="inquiry.write.subject.placeholder"/>
<spring:message var="msg_inquiry_write_content_placeholder" code="inquiry.write.content.placeholder"/>
<spring:message var="msg_inquiry_write_error_category_js" code="inquiry.write.error.category" javaScriptEscape="true"/>
<spring:message var="msg_inquiry_write_error_title_js" code="inquiry.write.error.title" javaScriptEscape="true"/>
<spring:message var="msg_inquiry_write_error_title_length_js" code="inquiry.write.error.title.length" javaScriptEscape="true"/>
<spring:message var="msg_inquiry_write_error_content_js" code="inquiry.write.error.content" javaScriptEscape="true"/>
<spring:message var="msg_inquiry_write_error_content_length_js" code="inquiry.write.error.content.length" javaScriptEscape="true"/>
<spring:message var="msg_inquiry_write_fail_js" code="inquiry.write.fail" javaScriptEscape="true"/>
<spring:message var="msg_inquiry_write_server_js" code="inquiry.write.server" javaScriptEscape="true"/>
<spring:message var="msg_inquiry_write_back" code="inquiry.write.back"/>
<spring:message var="msg_inquiry_write_title" code="inquiry.write.title"/>
<spring:message var="msg_inquiry_write_subtitle" code="inquiry.write.subtitle"/>
<spring:message var="msg_inquiry_write_type" code="inquiry.write.type"/>
<spring:message var="msg_inquiry_write_type_placeholder" code="inquiry.write.type.placeholder"/>
<spring:message var="msg_inquiry_write_type_service" code="inquiry.write.type.service"/>
<spring:message var="msg_inquiry_write_type_payment" code="inquiry.write.type.payment"/>
<spring:message var="msg_inquiry_write_type_account" code="inquiry.write.type.account"/>
<spring:message var="msg_inquiry_write_type_bug" code="inquiry.write.type.bug"/>
<spring:message var="msg_inquiry_write_type_etc" code="inquiry.write.type.etc"/>
<spring:message var="msg_inquiry_write_subject" code="inquiry.write.subject"/>
<spring:message var="msg_inquiry_write_content" code="inquiry.write.content"/>
<spring:message var="msg_inquiry_write_attach" code="inquiry.write.attach"/>
<spring:message var="msg_inquiry_write_attach_help" code="inquiry.write.attach.help"/>
<spring:message var="msg_inquiry_write_private" code="inquiry.write.private"/>
<spring:message var="msg_inquiry_write_private_help" code="inquiry.write.private.help"/>
<spring:message var="msg_inquiry_write_cancel" code="inquiry.write.cancel"/>
<spring:message var="msg_inquiry_write_submit" code="inquiry.write.submit"/>


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
        &#8592; ${msg_inquiry_write_back}
      </button>
      <h1>${msg_inquiry_write_title}</h1>
      <p>${msg_inquiry_write_subtitle}</p>
    </div>

    <div class="inq-write-card">
      <div class="inq-form-group">
        <label class="inq-form-label" for="category">
          ${msg_inquiry_write_type} <span class="inq-required">*</span>
        </label>
        <select class="inq-form-select" id="category" name="category">
          <option value="">${msg_inquiry_write_type_placeholder}</option>
          <option value="service">${msg_inquiry_write_type_service}</option>
          <option value="payment">${msg_inquiry_write_type_payment}</option>
          <option value="account">${msg_inquiry_write_type_account}</option>
          <option value="bug">${msg_inquiry_write_type_bug}</option>
          <option value="etc">${msg_inquiry_write_type_etc}</option>
        </select>
        <div class="inq-field-msg" id="categoryMsg"></div>
      </div>

      <div class="inq-form-group">
        <label class="inq-form-label" for="title">
          ${msg_inquiry_write_subject} <span class="inq-required">*</span>
        </label>
        <input class="inq-form-input" type="text" id="title" name="title"
               placeholder="${msg_inquiry_write_subject_placeholder}" maxlength="200">
        <div class="inq-field-msg" id="titleMsg"></div>
      </div>

      <div class="inq-form-group">
        <label class="inq-form-label" for="content">
          ${msg_inquiry_write_content} <span class="inq-required">*</span>
        </label>
        <textarea class="inq-form-textarea" id="content" name="content"
                  placeholder="${msg_inquiry_write_content_placeholder}"
                  rows="10" maxlength="5000"></textarea>
        <div class="inq-textarea-footer">
          <div class="inq-field-msg" id="contentMsg"></div>
          <span class="inq-char-count"><span id="contentCount">0</span> / 5000</span>
        </div>
      </div>

      <div class="inq-form-group">
        <label class="inq-form-label">${msg_inquiry_write_attach} <span style="font-size:12px;color:var(--gray-400);">${msg_inquiry_write_attach_help}</span></label>
        <input type="file" class="inq-form-input" id="images" name="images" multiple accept=".jpg,.jpeg,.png,.gif,.webp">
        <div class="inq-attach-preview" id="attachPreview"></div>
      </div>

      <div class="inq-form-group">
        <label class="inq-private-toggle">
          <input type="checkbox" id="isPrivate">
          <span class="inq-toggle-slider"></span>
          <span class="inq-toggle-label">${msg_inquiry_write_private}</span>
        </label>
        <div class="inq-private-hint">${msg_inquiry_write_private_help}</div>
      </div>

      <div class="inq-write-actions">
        <button class="inq-btn-cancel" onclick="location.href='${pageContext.request.contextPath}/inquiry/list'">
          ${msg_inquiry_write_cancel}
        </button>
        <button class="inq-btn-submit" id="submitBtn">
          ${msg_inquiry_write_submit}
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
      setMsg('categoryMsg', '${msg_inquiry_write_error_category_js}', 'error');
      valid = false;
    } else { clearMsg('categoryMsg'); }

    if (!title) {
      setMsg('titleMsg', '${msg_inquiry_write_error_title_js}', 'error');
      valid = false;
    } else if (title.length < 5) {
      setMsg('titleMsg', '${msg_inquiry_write_error_title_length_js}', 'error');
      valid = false;
    } else { clearMsg('titleMsg'); }

    if (!content) {
      setMsg('contentMsg', '${msg_inquiry_write_error_content_js}', 'error');
      valid = false;
    } else if (content.length < 10) {
      setMsg('contentMsg', '${msg_inquiry_write_error_content_length_js}', 'error');
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
        alert('${msg_inquiry_write_fail_js}');
        btn.disabled = false;
        btn.classList.remove('loading');
      }
    } catch (e) {
      alert('${msg_inquiry_write_server_js}');
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
