<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  =============================================
  신고 상세 페이지
  URL: GET /report/{reportId}
  =============================================
  [model 필요]
  - report  : ReportDto - 신고 내용
  - isAdmin : boolean   - 운영진 여부

  [페이지 구성]
  1. 신고 내용 카드 (대상 유형, 사유, 상세 내용)
  2. 처리 결과 영역 (처리완료/반려/검토중)
  3. 하단 액션 버튼
  =============================================
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="report/report.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<div class="rpt-detail-wrap">
  <div class="rpt-detail-inner">

    <%-- 뒤로가기 버튼 --%>
    <button class="rpt-back-btn"
            onclick="location.href='${pageContext.request.contextPath}/report/list'">
      &#8592; 목록으로
    </button>

    <%-- =============================================
         1. 신고 내용 카드
         ============================================= --%>
    <div class="rpt-detail-card">

      <%-- 카드 헤더 --%>
      <div class="rpt-detail-head">
        <div class="rpt-detail-meta">
          <%-- 대상 유형 태그 --%>
          <span class="rpt-type-tag">
            <c:choose>
              <c:when test="${report.targetType eq 'post'}">게시글</c:when>
              <c:when test="${report.targetType eq 'comment'}">댓글</c:when>
              <c:when test="${report.targetType eq 'user'}">유저</c:when>
              <c:otherwise>${report.targetType}</c:otherwise>
            </c:choose>
            #${report.targetId}
          </span>

          <%-- 처리 상태 뱃지 --%>
          <span class="rpt-status-badge ${report.status}">
            <c:choose>
              <c:when test="${report.status eq 'IN_REVIEW'}">검토중</c:when>
              <c:when test="${report.status eq 'RESOLVED'}">처리완료</c:when>
              <c:when test="${report.status eq 'DISMISSED'}">반려</c:when>
              <c:otherwise>${report.status}</c:otherwise>
            </c:choose>
          </span>
        </div>

        <%-- 제목 --%>
        <h1 class="rpt-detail-title">
          <c:choose>
            <c:when test="${report.targetType eq 'post'}">게시글 신고</c:when>
            <c:when test="${report.targetType eq 'comment'}">댓글 신고</c:when>
            <c:when test="${report.targetType eq 'user'}">유저 신고</c:when>
            <c:otherwise>신고</c:otherwise>
          </c:choose>
        </h1>

        <%-- 신고일 --%>
        <div class="rpt-detail-info">
          신고일: <fmt:formatDate value="${report.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
        </div>
      </div>

      <%-- 카드 본문 --%>
      <div class="rpt-detail-body">

        <%-- 게시글/댓글 신고: 사유 코드 표시 --%>
        <c:if test="${report.targetType ne 'user'}">
          <div class="rpt-detail-row">
            <span class="rpt-detail-label">신고 사유</span>
            <span class="rpt-detail-value">
              <c:choose>
                <c:when test="${report.reason eq 'spam'}">스팸/광고</c:when>
                <c:when test="${report.reason eq 'abuse'}">욕설/비방</c:when>
                <c:when test="${report.reason eq 'privacy'}">개인정보 노출</c:when>
                <c:when test="${report.reason eq 'adult'}">음란물</c:when>
                <c:when test="${report.reason eq 'illegal'}">불법 정보</c:when>
                <c:when test="${report.reason eq 'other'}">기타</c:when>
                <c:otherwise>
                  <c:choose>
                    <c:when test="${not empty report.reason}">${report.reason}</c:when>
                    <c:otherwise>—</c:otherwise>
                  </c:choose>
                </c:otherwise>
              </c:choose>
            </span>
          </div>
        </c:if>

        <%-- 상세 사유 (post/comment) 또는 신고 내용 (user) --%>
        <c:if test="${not empty report.description}">
          <div class="rpt-detail-row">
            <span class="rpt-detail-label">
              <c:choose>
                <c:when test="${report.targetType eq 'user'}">신고 내용</c:when>
                <c:otherwise>상세 사유</c:otherwise>
              </c:choose>
            </span>
            <span class="rpt-detail-value rpt-detail-desc">${report.description}</span>
          </div>
        </c:if>

        <%-- 신고 대상 정보 --%>
        <div class="rpt-detail-row">
          <span class="rpt-detail-label">신고 대상</span>
          <span class="rpt-detail-value">
            <c:choose>

              <%-- 게시글 신고 --%>
              <c:when test="${report.targetType eq 'post'}">
                <c:choose>
                  <c:when test="${targetDeleted}">
                    <span style="color:var(--gray-400)">(삭제된 게시글)</span>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/community/${targetPostId}"
                       style="color:#3b82f6;text-decoration:underline;">
                      ${targetTitle}
                    </a>
                    <c:if test="${not empty targetNickname}">
                      <span style="color:var(--gray-500);font-size:13px;"> — 작성자: ${targetNickname}</span>
                    </c:if>
                  </c:otherwise>
                </c:choose>
              </c:when>

              <%-- 댓글 신고 --%>
              <c:when test="${report.targetType eq 'comment'}">
                <c:choose>
                  <c:when test="${targetDeleted}">
                    <span style="color:var(--gray-400)">(삭제된 댓글)</span>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/community/${targetPostId}"
                       style="color:#3b82f6;text-decoration:underline;">
                      게시글 #${targetPostId}
                    </a>
                    <span style="color:var(--gray-500);font-size:13px;">의 댓글</span>
                    <c:if test="${not empty targetNickname}">
                      <span style="color:var(--gray-500);font-size:13px;"> — 작성자: ${targetNickname}</span>
                    </c:if>
                    <div style="margin-top:4px;font-size:13px;color:var(--gray-600);background:var(--gray-50);padding:6px 10px;border-radius:6px;border-left:3px solid var(--gray-200);">"${targetContent}"</div>
                  </c:otherwise>
                </c:choose>
              </c:when>

              <%-- 유저 신고 --%>
              <c:when test="${report.targetType eq 'user'}">
                <c:choose>
                  <c:when test="${not empty targetNickname}">
                    <span>${targetNickname}</span>
                  </c:when>
                  <c:otherwise>
                    <span style="color:var(--gray-400)">(알 수 없는 유저)</span>
                  </c:otherwise>
                </c:choose>
                <%-- 신고 출처 (어떤 게시글/댓글에서 신고했는지) --%>
                <c:if test="${not empty report.sourceType}">
                  <div style="margin-top:6px;font-size:13px;color:var(--gray-500);">
                    신고 출처:
                    <c:choose>
                      <c:when test="${report.sourceType eq 'post'}">
                        <c:choose>
                          <c:when test="${sourceDeleted}">
                            <span style="color:var(--gray-400)">(삭제된 게시글)</span>
                          </c:when>
                          <c:otherwise>
                            <a href="${pageContext.request.contextPath}/community/${sourcePostId}"
                               style="color:#3b82f6;text-decoration:underline;">${sourceTitle}</a>
                          </c:otherwise>
                        </c:choose>
                      </c:when>
                      <c:when test="${report.sourceType eq 'comment'}">
                        <c:choose>
                          <c:when test="${sourceDeleted}">
                            <span style="color:var(--gray-400)">(삭제된 댓글)</span>
                          </c:when>
                          <c:otherwise>
                            <a href="${pageContext.request.contextPath}/community/${sourcePostId}"
                               style="color:#3b82f6;text-decoration:underline;">
                              게시글 #${sourcePostId}
                            </a>
                            <span>의 댓글</span>
                            <div style="margin-top:4px;background:var(--gray-50);padding:6px 10px;border-radius:6px;border-left:3px solid var(--gray-200);">"${sourceContent}"</div>
                          </c:otherwise>
                        </c:choose>
                      </c:when>
                    </c:choose>
                  </div>
                </c:if>
              </c:when>

            </c:choose>
          </span>
        </div>

        <%-- 어드민 전용: 신고자 정보 --%>
        <c:if test="${isAdmin}">
          <div class="rpt-detail-row">
            <span class="rpt-detail-label">신고자</span>
            <span class="rpt-detail-value">${report.nickname} (#${report.userIdx})</span>
          </div>
        </c:if>

      </div>
    </div><%-- /rpt-detail-card --%>

    <%-- =============================================
         2. 처리 결과 영역
         ============================================= --%>
    <c:choose>
      <c:when test="${report.status eq 'RESOLVED'}">
        <div class="rpt-result-card RESOLVED">
          <div class="rpt-result-head">
            <span class="rpt-result-icon">&#9989;</span>
            <div>
              <div class="rpt-result-title">처리 완료</div>
              <c:if test="${not empty report.resolvedAt}">
                <div class="rpt-result-meta"><fmt:formatDate value="${report.resolvedAt}" pattern="yyyy-MM-dd HH:mm"/></div>
              </c:if>
            </div>
          </div>
          <div class="rpt-result-body">
            신고가 검토되어 처리되었습니다.<c:if test="${not empty report.resolveAction}"> (${report.resolveAction})</c:if>
          </div>
        </div>
      </c:when>

      <c:when test="${report.status eq 'DISMISSED'}">
        <div class="rpt-result-card DISMISSED">
          <div class="rpt-result-head">
            <span class="rpt-result-icon">&#10060;</span>
            <div>
              <div class="rpt-result-title">반려</div>
              <c:if test="${not empty report.resolvedAt}">
                <div class="rpt-result-meta"><fmt:formatDate value="${report.resolvedAt}" pattern="yyyy-MM-dd HH:mm"/></div>
              </c:if>
            </div>
          </div>
          <div class="rpt-result-body">신고 내용이 검토되었으나 처리 기준에 해당하지 않아 반려되었습니다.</div>
        </div>
      </c:when>

      <c:when test="${report.status eq 'CANCELLED'}">
        <div class="rpt-result-card CANCELLED">
          <div class="rpt-result-head">
            <span class="rpt-result-icon">✖</span>
            <div>
              <div class="rpt-result-title">신고 취소</div>
              <c:if test="${not empty report.updatedAt}">
                <div class="rpt-result-meta"><fmt:formatDate value="${report.updatedAt}" pattern="yyyy-MM-dd HH:mm"/></div>
              </c:if>
            </div>
          </div>
          <div class="rpt-result-body">신고가 취소되었습니다.</div>
        </div>
      </c:when>

      <c:otherwise>
        <div class="rpt-no-result">
          <div class="rpt-no-result-icon">🔍</div>
          <div class="rpt-no-result-msg">검토 진행 중</div>
          <div class="rpt-no-result-sub">담당자가 신고 내용을 검토하고 있습니다</div>
        </div>
      </c:otherwise>
    </c:choose>

    <%-- =============================================
         3. 관리자 패널 (isAdmin일 때만)
         ============================================= --%>
    <c:if test="${isAdmin}">
      <div class="rpt-admin-form">
        <div class="rpt-admin-form-title">🛡️ 관리자 패널</div>

        <c:choose>

          <%-- IN_REVIEW: 처리 버튼 표시 --%>
          <c:when test="${report.status eq 'IN_REVIEW'}">

            <%-- 게시글 신고 --%>
            <c:if test="${report.targetType eq 'post'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnDeleteAndBlock">🗑️🚫 게시글 삭제 + 작성자 차단 후 처리완료</button>
                <button class="rpt-btn-danger" id="btnDeleteContent">🗑️ 게시글 삭제 후 처리완료</button>
                <button class="rpt-btn-warn"   id="btnBlockAuthor">🚫 작성자 차단 후 처리완료</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">✖ 유지 (반려)</button>
              </div>
            </c:if>

            <%-- 댓글 신고 --%>
            <c:if test="${report.targetType eq 'comment'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnDeleteAndBlock">🗑️🚫 댓글 삭제 + 작성자 차단 후 처리완료</button>
                <button class="rpt-btn-danger" id="btnDeleteContent">🗑️ 댓글 삭제 후 처리완료</button>
                <button class="rpt-btn-warn"   id="btnBlockAuthor">🚫 작성자 차단 후 처리완료</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">✖ 유지 (반려)</button>
              </div>
            </c:if>

            <%-- 유저 신고 --%>
            <c:if test="${report.targetType eq 'user'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnBlockUser">🚫 유저 계정 차단 후 처리완료</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">✖ 유지 (반려)</button>
              </div>
            </c:if>

          </c:when>

          <%-- 처리완료/반려 → 반려취소 버튼 --%>
          <c:otherwise>
            <div class="rpt-admin-action-bar">
              <button class="rpt-btn-warn" id="btnRevertToPending">↩ 검토중으로 변경</button>
            </div>
          </c:otherwise>

        </c:choose>
      </div>
    </c:if>

    <%-- =============================================
         4. 수정 폼 (IN_REVIEW + isOwner만 표시)
         ============================================= --%>
    <c:if test="${isOwner and report.status eq 'IN_REVIEW'}">
      <div class="rpt-edit-form" id="editForm" style="display:none;">
        <div class="rpt-write-card">
          <%-- post/comment 신고: 사유 선택 --%>
          <c:if test="${report.targetType ne 'user'}">
            <div class="rpt-form-group">
              <label class="rpt-form-label">신고 사유</label>
              <select class="rpt-form-select" id="editReason">
                <option value="spam"    ${report.reason eq 'spam'    ? 'selected' : ''}>스팸/광고</option>
                <option value="abuse"   ${report.reason eq 'abuse'   ? 'selected' : ''}>욕설/비방</option>
                <option value="privacy" ${report.reason eq 'privacy' ? 'selected' : ''}>개인정보 노출</option>
                <option value="adult"   ${report.reason eq 'adult'   ? 'selected' : ''}>음란물</option>
                <option value="illegal" ${report.reason eq 'illegal' ? 'selected' : ''}>불법 정보</option>
                <option value="other"   ${report.reason eq 'other'   ? 'selected' : ''}>기타</option>
              </select>
            </div>
          </c:if>
          <%-- 상세 내용 --%>
          <div class="rpt-form-group">
            <label class="rpt-form-label">
              <c:choose>
                <c:when test="${report.targetType eq 'user'}">신고 내용</c:when>
                <c:otherwise>상세 사유</c:otherwise>
              </c:choose>
            </label>
            <textarea class="rpt-form-textarea" id="editDescription" rows="6">${report.description}</textarea>
          </div>
          <div class="rpt-write-actions">
            <button class="rpt-btn-cancel" id="editCancelBtn">취소</button>
            <button class="rpt-btn-submit" id="editSaveBtn">저장</button>
          </div>
        </div>
      </div>
    </c:if>

    <%-- 수정 불가 안내 --%>
    <c:if test="${isOwner and (report.status eq 'RESOLVED' or report.status eq 'DISMISSED')}">
      <div style="font-size:13px; color:var(--gray-400); margin-bottom:8px;">
        ⚠️ 처리된 신고는 수정할 수 없습니다.
      </div>
    </c:if>

    <%-- =============================================
         5. 하단 액션 버튼
         ============================================= --%>
    <div class="rpt-detail-actions">
      <button class="rpt-btn-cancel"
              onclick="location.href='${pageContext.request.contextPath}/report/list'">
        목록으로
      </button>

      <%-- IN_REVIEW: 수정 + 삭제 + 신고 취소 --%>
      <c:if test="${isOwner and report.status eq 'IN_REVIEW'}">
        <button class="rpt-btn-cancel" id="editBtn">✏️ 수정</button>
        <button class="rpt-btn-submit" id="deleteBtn"
                style="background:#ef4444;">🗑️ 삭제</button>
        <button class="rpt-btn-submit" id="cancelReportBtn"
                style="background:#f59e0b;">✖ 신고 취소</button>
      </c:if>

      <%-- CANCELLED: 삭제만 --%>
      <c:if test="${isOwner and report.status eq 'CANCELLED'}">
        <button class="rpt-btn-submit" id="deleteBtn"
                style="background:#ef4444;">🗑️ 삭제</button>
      </c:if>

      <%-- 어드민: 삭제 (상태 무관) --%>
      <c:if test="${isAdmin}">
        <button class="rpt-btn-submit" id="deleteBtn"
                style="background:#ef4444;">🗑️ 삭제</button>
      </c:if>
    </div>

  </div><%-- /rpt-detail-inner --%>
</div><%-- /rpt-detail-wrap --%>

<%-- =============================================
     스크립트 (관리자 패널 액션)
     ============================================= --%>
<c:if test="${isAdmin}">
<script>
(function () {
  var ctx      = '${pageContext.request.contextPath}';
  var reportId = ${report.reportId};

  function resolveReport(action, confirmMsg) {
    if (!confirm(confirmMsg)) return;
    fetch(ctx + '/admin/report/' + reportId + '/resolve', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'action=' + encodeURIComponent(action)
    })
    .then(function (res) { return res.json(); })
    .then(function (data) {
      if (data.success) { location.reload(); }
      else { alert(data.message || '처리 중 오류가 발생했습니다.'); }
    })
    .catch(function () { alert('네트워크 오류가 발생했습니다.'); });
  }

  var btnDeleteContent = document.getElementById('btnDeleteContent');
  if (btnDeleteContent) {
    btnDeleteContent.addEventListener('click', function () {
      resolveReport('DELETE_CONTENT', '게시물을 삭제하고 신고를 처리완료 하시겠습니까?');
    });
  }

  var btnBlockAuthor = document.getElementById('btnBlockAuthor');
  if (btnBlockAuthor) {
    btnBlockAuthor.addEventListener('click', function () {
      resolveReport('BLOCK_AUTHOR', '작성자 계정을 차단하고 신고를 처리완료 하시겠습니까?');
    });
  }

  var btnDeleteAndBlock = document.getElementById('btnDeleteAndBlock');
  if (btnDeleteAndBlock) {
    btnDeleteAndBlock.addEventListener('click', function () {
      resolveReport('DELETE_AND_BLOCK', '게시물을 삭제하고 작성자 계정을 차단한 후 처리완료 하시겠습니까?');
    });
  }

  var btnBlockUser = document.getElementById('btnBlockUser');
  if (btnBlockUser) {
    btnBlockUser.addEventListener('click', function () {
      resolveReport('BLOCK_USER', '해당 유저 계정을 차단하고 신고를 처리완료 하시겠습니까?');
    });
  }

  var btnDismiss = document.getElementById('btnDismiss');
  if (btnDismiss) {
    btnDismiss.addEventListener('click', function () {
      resolveReport('REJECTED', '신고를 반려 처리하시겠습니까?');
    });
  }

  var btnRevertToPending = document.getElementById('btnRevertToPending');
  if (btnRevertToPending) {
    btnRevertToPending.addEventListener('click', function () {
      resolveReport('REVERT_TO_PENDING', '처리를 취소하고 검토중으로 되돌리시겠습니까?');
    });
  }
}());
</script>
</c:if>

<%-- =============================================
     스크립트 (본인 액션: 수정 / 삭제 / 신고 취소)
     ============================================= --%>
<script>
(function () {
  var ctx      = '${pageContext.request.contextPath}';
  var reportId = ${report.reportId};

  async function postJson(url, params) {
    var res = await fetch(ctx + url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams(params)
    });
    return res.json();
  }

  var editBtn         = document.getElementById('editBtn');
  var deleteBtn       = document.getElementById('deleteBtn');
  var cancelReportBtn = document.getElementById('cancelReportBtn');
  var editForm        = document.getElementById('editForm');

  /* 수정 폼 토글 */
  if (editBtn) {
    var editCancelBtn = document.getElementById('editCancelBtn');
    var editSaveBtn   = document.getElementById('editSaveBtn');

    editBtn.addEventListener('click', function () {
      var isShown = editForm.style.display !== 'none';
      editForm.style.display = isShown ? 'none' : 'block';
      editBtn.textContent    = isShown ? '✏️ 수정' : '✏️ 취소';
    });

    editCancelBtn.addEventListener('click', function () {
      editForm.style.display = 'none';
      editBtn.textContent    = '✏️ 수정';
    });

    editSaveBtn.addEventListener('click', async function () {
      var description = document.getElementById('editDescription').value.trim();
      var reasonEl    = document.getElementById('editReason');
      var params      = { description: description };
      if (reasonEl) params.reason = reasonEl.value;
      this.disabled = true;
      try {
        var data = await postJson('/report/' + reportId + '/edit', params);
        if (data.success) { location.reload(); }
        else { alert(data.message || '수정에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

  /* 삭제 */
  if (deleteBtn) {
    deleteBtn.addEventListener('click', async function () {
      if (!confirm('신고를 삭제하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/report/' + reportId + '/delete', {});
        if (data.success) { location.href = ctx + '/report/list'; }
        else { alert(data.message || '삭제에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

  /* 신고 취소 */
  if (cancelReportBtn) {
    cancelReportBtn.addEventListener('click', async function () {
      if (!confirm('신고를 취소하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/report/' + reportId + '/cancel', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || '취소에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }
}());
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
