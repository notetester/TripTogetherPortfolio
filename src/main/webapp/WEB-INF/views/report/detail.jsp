<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_report_common_backToList" code="report.common.backToList"/>
<spring:message var="msg_report_common_cancel" code="report.common.cancel"/>
<spring:message var="msg_report_common_keepDismiss" code="report.common.keepDismiss"/>
<spring:message var="msg_report_common_none" code="report.common.none"/>
<spring:message var="msg_report_common_save" code="report.common.save"/>
<spring:message var="msg_report_detail_action_cancelEdit_js" code="report.detail.action.cancelEdit" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_action_edit_js" code="report.detail.action.edit" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_alert_cancelFail_js" code="report.detail.alert.cancelFail" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_alert_deleteFail_js" code="report.detail.alert.deleteFail" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_alert_error_js" code="report.detail.alert.error" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_alert_network_js" code="report.detail.alert.network" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_alert_processing_js" code="report.detail.alert.processing" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_alert_updateFail_js" code="report.detail.alert.updateFail" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_blockAuthor_js" code="report.detail.confirm.blockAuthor" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_blockUser_js" code="report.detail.confirm.blockUser" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_deleteAndBlock_comment_js" code="report.detail.confirm.deleteAndBlock.comment" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_deleteAndBlock_post_js" code="report.detail.confirm.deleteAndBlock.post" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_deleteAndBlock_review_js" code="report.detail.confirm.deleteAndBlock.review" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_deleteContent_comment_js" code="report.detail.confirm.deleteContent.comment" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_deleteContent_post_js" code="report.detail.confirm.deleteContent.post" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_deleteContent_review_js" code="report.detail.confirm.deleteContent.review" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_deleteReport_js" code="report.detail.confirm.deleteReport" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_dismiss_js" code="report.detail.confirm.dismiss" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_revert_js" code="report.detail.confirm.revert" javaScriptEscape="true"/>
<spring:message var="msg_report_detail_confirm_userCancel_js" code="report.detail.confirm.userCancel" javaScriptEscape="true"/>
<spring:message var="msg_report_common_target_post" code="report.common.target.post"/>
<spring:message var="msg_report_common_target_comment" code="report.common.target.comment"/>
<spring:message var="msg_report_common_target_review" code="report.common.target.review"/>
<spring:message var="msg_report_common_target_user" code="report.common.target.user"/>
<spring:message var="msg_report_common_status_inReview" code="report.common.status.inReview"/>
<spring:message var="msg_report_common_status_resolved" code="report.common.status.resolved"/>
<spring:message var="msg_report_common_status_dismissed" code="report.common.status.dismissed"/>
<spring:message var="msg_report_detail_title_post" code="report.detail.title.post"/>
<spring:message var="msg_report_detail_title_comment" code="report.detail.title.comment"/>
<spring:message var="msg_report_detail_title_review" code="report.detail.title.review"/>
<spring:message var="msg_report_detail_title_user" code="report.detail.title.user"/>
<spring:message var="msg_report_detail_title_default" code="report.detail.title.default"/>
<spring:message var="msg_report_detail_info_reportedAt" code="report.detail.info.reportedAt"/>
<spring:message var="msg_report_detail_label_reason" code="report.detail.label.reason"/>
<spring:message var="msg_report_common_reason_spam" code="report.common.reason.spam"/>
<spring:message var="msg_report_common_reason_abuse" code="report.common.reason.abuse"/>
<spring:message var="msg_report_common_reason_privacy" code="report.common.reason.privacy"/>
<spring:message var="msg_report_common_reason_adult" code="report.common.reason.adult"/>
<spring:message var="msg_report_common_reason_illegal" code="report.common.reason.illegal"/>
<spring:message var="msg_report_common_reason_other" code="report.common.reason.other"/>
<spring:message var="msg_report_detail_label_userDescription" code="report.detail.label.userDescription"/>
<spring:message var="msg_report_detail_label_description" code="report.detail.label.description"/>
<spring:message var="msg_report_detail_label_target" code="report.detail.label.target"/>
<spring:message var="msg_report_common_deletedPost" code="report.common.deletedPost"/>
<spring:message var="msg_report_detail_info_authorPrefix" code="report.detail.info.authorPrefix"/>
<spring:message var="msg_report_common_deletedComment" code="report.common.deletedComment"/>
<spring:message var="msg_report_common_post" code="report.common.post"/>
<spring:message var="msg_report_detail_info_commentSuffix" code="report.detail.info.commentSuffix"/>
<spring:message var="msg_report_common_deletedReview" code="report.common.deletedReview"/>
<spring:message var="msg_report_common_spot" code="report.common.spot"/>
<spring:message var="msg_report_detail_info_reviewSuffix" code="report.detail.info.reviewSuffix"/>
<spring:message var="msg_report_common_unknownUser" code="report.common.unknownUser"/>
<spring:message var="msg_report_detail_info_source" code="report.detail.info.source"/>
<spring:message var="msg_report_detail_info_reporter" code="report.detail.info.reporter"/>
<spring:message var="msg_report_detail_result_resolved_title" code="report.detail.result.resolved.title"/>
<spring:message var="msg_report_detail_result_resolved_body" code="report.detail.result.resolved.body"/>
<spring:message var="msg_report_detail_result_dismissed_title" code="report.detail.result.dismissed.title"/>
<spring:message var="msg_report_detail_result_dismissed_body" code="report.detail.result.dismissed.body"/>
<spring:message var="msg_report_detail_result_cancelled_title" code="report.detail.result.cancelled.title"/>
<spring:message var="msg_report_detail_result_cancelled_body" code="report.detail.result.cancelled.body"/>
<spring:message var="msg_report_detail_result_pending_title" code="report.detail.result.pending.title"/>
<spring:message var="msg_report_detail_result_pending_subtitle" code="report.detail.result.pending.subtitle"/>
<spring:message var="msg_report_detail_admin_title" code="report.detail.admin.title"/>
<spring:message var="msg_report_detail_admin_action_deleteAndBlock_post" code="report.detail.admin.action.deleteAndBlock.post"/>
<spring:message var="msg_report_detail_admin_action_deleteContent_post" code="report.detail.admin.action.deleteContent.post"/>
<spring:message var="msg_report_detail_admin_action_blockAuthor" code="report.detail.admin.action.blockAuthor"/>
<spring:message var="msg_report_detail_admin_action_deleteAndBlock_comment" code="report.detail.admin.action.deleteAndBlock.comment"/>
<spring:message var="msg_report_detail_admin_action_deleteContent_comment" code="report.detail.admin.action.deleteContent.comment"/>
<spring:message var="msg_report_detail_admin_action_deleteAndBlock_review" code="report.detail.admin.action.deleteAndBlock.review"/>
<spring:message var="msg_report_detail_admin_action_deleteContent_review" code="report.detail.admin.action.deleteContent.review"/>
<spring:message var="msg_report_detail_admin_action_blockUser" code="report.detail.admin.action.blockUser"/>
<spring:message var="msg_report_detail_admin_action_revert" code="report.detail.admin.action.revert"/>
<spring:message var="msg_report_detail_edit_cannotAfterProcessed" code="report.detail.edit.cannotAfterProcessed"/>
<spring:message var="msg_report_detail_action_edit" code="report.detail.action.edit"/>
<spring:message var="msg_report_detail_action_delete" code="report.detail.action.delete"/>
<spring:message var="msg_report_detail_action_cancelReport" code="report.detail.action.cancelReport"/>
<%--
  =============================================
  신고 상세 페이지
  URL: GET /report/{reportId}
  =============================================
  [model 필요]
  - report      : ReportDto - 신고 내용
  - isAdmin     : boolean   - 운영진 여부
  - isAdminMode : boolean   - 관리자모드 여부 (AdminModeInterceptor 자동 주입)
                              false(유저경험모드)이면 관리자 패널 숨김

  [페이지 구성]
  1. 신고 내용 카드 (대상 유형, 사유, 상세 내용)
  2. 처리 결과 영역 (처리완료/반려/검토중)
  3. 관리자 패널 (관리자모드일 때만 표시)
  4. 수정 폼 (IN_REVIEW + isOwner만 표시)
  5. 하단 액션 버튼
  6. 스크립트 (관리자 액션 / 본인 액션)
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
    <button class="rpt-back-btn" onclick="goBackToList()">
      &#8592; ${msg_report_common_backToList}
    </button>

    <%-- =============================================
         1. 신고 내용 카드
         ============================================= --%>
    <div class="rpt-detail-card">

      <%-- 카드 헤더 --%>
      <div class="rpt-detail-head">
        <div class="rpt-detail-meta">
          <%-- 대상 유형 태그 --%>
          <c:choose>
            <c:when test="${report.targetType eq 'post'}">
              <span class="rpt-type-tag type-post">${msg_report_common_target_post} #${report.targetId}</span>
            </c:when>
            <c:when test="${report.targetType eq 'comment'}">
              <span class="rpt-type-tag type-comment">${msg_report_common_target_comment} #${report.targetId}</span>
            </c:when>
            <c:when test="${report.targetType eq 'review'}">
              <span class="rpt-type-tag type-review">${msg_report_common_target_review} #${report.targetId}</span>
            </c:when>
            <c:when test="${report.targetType eq 'user'}">
              <span class="rpt-type-tag type-user">${msg_report_common_target_user} #${report.targetId}</span>
            </c:when>
            <c:otherwise>
              <span class="rpt-type-tag">${report.targetType} #${report.targetId}</span>
            </c:otherwise>
          </c:choose>

          <%-- 처리 상태 뱃지 --%>
          <span class="rpt-status-badge ${report.status}">
            <c:choose>
              <c:when test="${report.status eq 'IN_REVIEW'}">${msg_report_common_status_inReview}</c:when>
              <c:when test="${report.status eq 'RESOLVED'}">${msg_report_common_status_resolved}</c:when>
              <c:when test="${report.status eq 'DISMISSED'}">${msg_report_common_status_dismissed}</c:when>
              <c:otherwise>${report.status}</c:otherwise>
            </c:choose>
          </span>
        </div>

        <%-- 제목 --%>
        <h1 class="rpt-detail-title">
          <c:choose>
            <c:when test="${report.targetType eq 'post'}">${msg_report_detail_title_post}</c:when>
            <c:when test="${report.targetType eq 'comment'}">${msg_report_detail_title_comment}</c:when>
            <c:when test="${report.targetType eq 'review'}">${msg_report_detail_title_review}</c:when>
            <c:when test="${report.targetType eq 'user'}">${msg_report_detail_title_user}</c:when>
            <c:otherwise>${msg_report_detail_title_default}</c:otherwise>
          </c:choose>
        </h1>

        <%-- 신고일 --%>
        <div class="rpt-detail-info">
          ${msg_report_detail_info_reportedAt}: <fmt:formatDate value="${report.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/>
        </div>
      </div>

      <%-- 카드 본문 --%>
      <div class="rpt-detail-body">

        <%-- 게시글/댓글 신고: 사유 코드 표시 --%>
        <c:if test="${report.targetType ne 'user'}">
          <div class="rpt-detail-row">
            <span class="rpt-detail-label">${msg_report_detail_label_reason}</span>
            <span class="rpt-detail-value">
              <c:choose>
                <c:when test="${report.reason eq 'spam'}">${msg_report_common_reason_spam}</c:when>
                <c:when test="${report.reason eq 'abuse'}">${msg_report_common_reason_abuse}</c:when>
                <c:when test="${report.reason eq 'privacy'}">${msg_report_common_reason_privacy}</c:when>
                <c:when test="${report.reason eq 'adult'}">${msg_report_common_reason_adult}</c:when>
                <c:when test="${report.reason eq 'illegal'}">${msg_report_common_reason_illegal}</c:when>
                <c:when test="${report.reason eq 'other'}">${msg_report_common_reason_other}</c:when>
                <c:otherwise>
                  <c:choose>
                    <c:when test="${not empty report.reason}">${report.reason}</c:when>
                    <c:otherwise>${msg_report_common_none}</c:otherwise>
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
                <c:when test="${report.targetType eq 'user'}">${msg_report_detail_label_userDescription}</c:when>
                <c:otherwise>${msg_report_detail_label_description}</c:otherwise>
              </c:choose>
            </span>
            <span class="rpt-detail-value rpt-detail-desc">${report.description}</span>
          </div>
        </c:if>

        <%-- 신고 대상 정보 --%>
        <div class="rpt-detail-row">
          <span class="rpt-detail-label">${msg_report_detail_label_target}</span>
          <span class="rpt-detail-value">
            <c:choose>

              <%-- 게시글 신고 --%>
              <c:when test="${report.targetType eq 'post'}">
                <c:choose>
                  <c:when test="${targetDeleted}">
                    <span style="color:var(--gray-400);">${msg_report_common_deletedPost}</span>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/community/${targetPostId}"
                       style="color:#3b82f6;text-decoration:underline;">
                      ${targetTitle}
                    </a>
                    <c:if test="${not empty targetNickname}">
                      <span style="color:var(--gray-500);font-size:13px;"> — ${msg_report_detail_info_authorPrefix} ${targetNickname}</span>
                    </c:if>
                  </c:otherwise>
                </c:choose>
              </c:when>

              <%-- 댓글 신고 --%>
              <c:when test="${report.targetType eq 'comment'}">
                <c:choose>
                  <c:when test="${targetDeleted}">
                    <span style="color:var(--gray-400);">${msg_report_common_deletedComment}</span>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/community/${targetPostId}"
                       style="color:#3b82f6;text-decoration:underline;">
                      ${msg_report_common_post} #${targetPostId}
                    </a>
                    <span style="color:var(--gray-500);font-size:13px;">${msg_report_detail_info_commentSuffix}</span>
                    <c:if test="${not empty targetNickname}">
                      <span style="color:var(--gray-500);font-size:13px;"> — ${msg_report_detail_info_authorPrefix} ${targetNickname}</span>
                    </c:if>
                    <div style="margin-top:4px;font-size:13px;color:var(--gray-600);background:var(--gray-50);padding:6px 10px;border-radius:6px;border-left:3px solid var(--gray-200);">"${targetContent}"</div>
                  </c:otherwise>
                </c:choose>
              </c:when>

              <%-- 여행지 리뷰 신고 --%>
              <c:when test="${report.targetType eq 'review'}">
                <c:choose>
                  <c:when test="${targetDeleted}">
                    <span style="color:var(--gray-400);">${msg_report_common_deletedReview}</span>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/detail/${targetSpotId}"
                       style="color:#3b82f6;text-decoration:underline;">
                      ${msg_report_common_spot} #${targetSpotId}
                    </a>
                    <span style="color:var(--gray-500);font-size:13px;">${msg_report_detail_info_reviewSuffix}</span>
                    <c:if test="${not empty targetNickname}">
                      <span style="color:var(--gray-500);font-size:13px;"> — ${msg_report_detail_info_authorPrefix} ${targetNickname}</span>
                    </c:if>
                    <c:if test="${not empty targetContent}">
                      <div style="margin-top:4px;font-size:13px;color:var(--gray-600);background:var(--gray-50);padding:6px 10px;border-radius:6px;border-left:3px solid var(--gray-200);">"${targetContent}"</div>
                    </c:if>
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
                    <span style="color:var(--gray-400);">${msg_report_common_unknownUser}</span>
                  </c:otherwise>
                </c:choose>
                <%-- 신고 출처 (어떤 게시글/댓글에서 신고했는지) --%>
                <c:if test="${not empty report.sourceType}">
                  <div style="margin-top:6px;font-size:13px;color:var(--gray-500);">
                    ${msg_report_detail_info_source}:
                    <c:choose>
                      <c:when test="${report.sourceType eq 'post'}">
                        <c:choose>
                          <c:when test="${sourceDeleted}">
                            <span style="color:var(--gray-400);">${msg_report_common_deletedPost}</span>
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
                            <span style="color:var(--gray-400);">${msg_report_common_deletedComment}</span>
                          </c:when>
                          <c:otherwise>
                            <a href="${pageContext.request.contextPath}/community/${sourcePostId}"
                               style="color:#3b82f6;text-decoration:underline;">
                              ${msg_report_common_post} #${sourcePostId}
                            </a>
                            <span>${msg_report_detail_info_commentSuffix}</span>
                            <div style="margin-top:4px;background:var(--gray-50);padding:6px 10px;border-radius:6px;border-left:3px solid var(--gray-200);">"${sourceContent}"</div>
                          </c:otherwise>
                        </c:choose>
                      </c:when>
                      <c:when test="${report.sourceType eq 'review'}">
                        <c:choose>
                          <c:when test="${sourceDeleted}">
                            <span style="color:var(--gray-400);">${msg_report_common_deletedReview}</span>
                          </c:when>
                          <c:otherwise>
                            <a href="${pageContext.request.contextPath}/detail/${sourceSpotId}"
                               style="color:#3b82f6;text-decoration:underline;">
                              ${msg_report_common_spot} #${sourceSpotId}
                            </a>
                            <span>${msg_report_detail_info_reviewSuffix}</span>
                            <c:if test="${not empty sourceContent}">
                              <div style="margin-top:4px;background:var(--gray-50);padding:6px 10px;border-radius:6px;border-left:3px solid var(--gray-200);">"${sourceContent}"</div>
                            </c:if>
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

        <%-- 어드민 전용: 신고자 정보 (관리자모드일 때만 표시) --%>
        <c:if test="${isAdmin and isAdminMode}">
          <div class="rpt-detail-row">
            <span class="rpt-detail-label">${msg_report_detail_info_reporter}</span>
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
              <div class="rpt-result-title">${msg_report_detail_result_resolved_title}</div>
              <c:if test="${not empty report.resolvedAt}">
                <div class="rpt-result-meta"><fmt:formatDate value="${report.resolvedAt}" pattern="yyyy-MM-dd HH:mm"/></div>
              </c:if>
            </div>
          </div>
          <div class="rpt-result-body">
            ${msg_report_detail_result_resolved_body}<c:if test="${not empty report.resolveAction}"> (${report.resolveAction})</c:if>
          </div>
        </div>
      </c:when>

      <c:when test="${report.status eq 'DISMISSED'}">
        <div class="rpt-result-card DISMISSED">
          <div class="rpt-result-head">
            <span class="rpt-result-icon">&#10060;</span>
            <div>
              <div class="rpt-result-title">${msg_report_detail_result_dismissed_title}</div>
              <c:if test="${not empty report.resolvedAt}">
                <div class="rpt-result-meta"><fmt:formatDate value="${report.resolvedAt}" pattern="yyyy-MM-dd HH:mm"/></div>
              </c:if>
            </div>
          </div>
          <div class="rpt-result-body">${msg_report_detail_result_dismissed_body}</div>
        </div>
      </c:when>

      <c:when test="${report.status eq 'CANCELLED'}">
        <div class="rpt-result-card CANCELLED">
          <div class="rpt-result-head">
            <span class="rpt-result-icon">✖</span>
            <div>
              <div class="rpt-result-title">${msg_report_detail_result_cancelled_title}</div>
              <c:if test="${not empty report.updatedAt}">
                <div class="rpt-result-meta"><fmt:formatDate value="${report.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
              </c:if>
            </div>
          </div>
          <div class="rpt-result-body">${msg_report_detail_result_cancelled_body}</div>
        </div>
      </c:when>

      <c:otherwise>
        <div class="rpt-no-result">
          <div class="rpt-no-result-icon">🔍</div>
          <div class="rpt-no-result-msg">${msg_report_detail_result_pending_title}</div>
          <div class="rpt-no-result-sub">${msg_report_detail_result_pending_subtitle}</div>
        </div>
      </c:otherwise>
    </c:choose>

    <%-- =============================================
         3. 관리자 패널
         - 관리자이고 관리자모드일 때만 표시 (유저경험모드 시 숨김)
         ============================================= --%>
    <c:if test="${isAdmin and isAdminMode}">
      <div class="rpt-admin-form">
        <div class="rpt-admin-form-title">${msg_report_detail_admin_title}</div>

        <c:choose>

          <%-- IN_REVIEW: 처리 버튼 표시 --%>
          <c:when test="${report.status eq 'IN_REVIEW'}">

            <%-- 게시글 신고 --%>
            <c:if test="${report.targetType eq 'post'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnDeleteAndBlock">${msg_report_detail_admin_action_deleteAndBlock_post}</button>
                <button class="rpt-btn-danger" id="btnDeleteContent">${msg_report_detail_admin_action_deleteContent_post}</button>
                <button class="rpt-btn-danger" id="btnBlockAuthor">${msg_report_detail_admin_action_blockAuthor}</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">${msg_report_common_keepDismiss}</button>
              </div>
            </c:if>

            <%-- 댓글 신고 --%>
            <c:if test="${report.targetType eq 'comment'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnDeleteAndBlock">${msg_report_detail_admin_action_deleteAndBlock_comment}</button>
                <button class="rpt-btn-danger" id="btnDeleteContent">${msg_report_detail_admin_action_deleteContent_comment}</button>
                <button class="rpt-btn-danger" id="btnBlockAuthor">${msg_report_detail_admin_action_blockAuthor}</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">${msg_report_common_keepDismiss}</button>
              </div>
            </c:if>

            <%-- 여행지 리뷰 신고 --%>
            <c:if test="${report.targetType eq 'review'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnDeleteAndBlock">${msg_report_detail_admin_action_deleteAndBlock_review}</button>
                <button class="rpt-btn-danger" id="btnDeleteContent">${msg_report_detail_admin_action_deleteContent_review}</button>
                <button class="rpt-btn-danger" id="btnBlockAuthor">${msg_report_detail_admin_action_blockAuthor}</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">${msg_report_common_keepDismiss}</button>
              </div>
            </c:if>

            <%-- 유저 신고 --%>
            <c:if test="${report.targetType eq 'user'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnBlockUser">${msg_report_detail_admin_action_blockUser}</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">${msg_report_common_keepDismiss}</button>
              </div>
            </c:if>

          </c:when>

          <%-- 처리완료/반려 → 반려취소 버튼 --%>
          <c:otherwise>
            <div class="rpt-admin-action-bar">
              <button class="rpt-btn-warn" id="btnRevertToPending">${msg_report_detail_admin_action_revert}</button>
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
              <label class="rpt-form-label">${msg_report_detail_label_reason}</label>
              <select class="rpt-form-select" id="editReason">
                <option value="spam"    ${report.reason eq 'spam'    ? 'selected' : ''}>${msg_report_common_reason_spam}</option>
                <option value="abuse"   ${report.reason eq 'abuse'   ? 'selected' : ''}>${msg_report_common_reason_abuse}</option>
                <option value="privacy" ${report.reason eq 'privacy' ? 'selected' : ''}>${msg_report_common_reason_privacy}</option>
                <option value="adult"   ${report.reason eq 'adult'   ? 'selected' : ''}>${msg_report_common_reason_adult}</option>
                <option value="illegal" ${report.reason eq 'illegal' ? 'selected' : ''}>${msg_report_common_reason_illegal}</option>
                <option value="other"   ${report.reason eq 'other'   ? 'selected' : ''}>${msg_report_common_reason_other}</option>
              </select>
            </div>
          </c:if>
          <%-- 상세 내용 --%>
          <div class="rpt-form-group">
            <label class="rpt-form-label">
              <c:choose>
                <c:when test="${report.targetType eq 'user'}">${msg_report_detail_label_userDescription}</c:when>
                <c:otherwise>${msg_report_detail_label_description}</c:otherwise>
              </c:choose>
            </label>
            <textarea class="rpt-form-textarea" id="editDescription" rows="6">${report.description}</textarea>
          </div>
          <div class="rpt-write-actions">
            <button class="rpt-btn-cancel" id="editCancelBtn">${msg_report_common_cancel}</button>
            <button class="rpt-btn-submit" id="editSaveBtn">${msg_report_common_save}</button>
          </div>
        </div>
      </div>
    </c:if>

    <%-- 수정 불가 안내 --%>
    <c:if test="${isOwner and (report.status eq 'RESOLVED' or report.status eq 'DISMISSED')}">
      <div style="font-size:13px; color:var(--gray-400); margin-bottom:8px;">
        ${msg_report_detail_edit_cannotAfterProcessed}
      </div>
    </c:if>

    <%-- =============================================
         5. 하단 액션 버튼
         ============================================= --%>
    <div class="rpt-detail-actions">
      <button class="rpt-btn-cancel" onclick="goBackToList()">
        ${msg_report_common_backToList}
      </button>

      <%-- IN_REVIEW: 수정 + 삭제 + 신고 취소 --%>
      <c:if test="${isOwner and report.status eq 'IN_REVIEW'}">
        <button class="rpt-btn-cancel" id="editBtn">${msg_report_detail_action_edit}</button>
        <button class="rpt-btn-submit" id="deleteBtn"
                style="background:#ef4444;">${msg_report_detail_action_delete}</button>
        <button class="rpt-btn-submit" id="cancelReportBtn"
                style="background:#f59e0b;">${msg_report_detail_action_cancelReport}</button>
      </c:if>

      <%-- CANCELLED: 삭제만 --%>
      <c:if test="${isOwner and report.status eq 'CANCELLED'}">
        <button class="rpt-btn-submit" id="deleteBtn"
                style="background:#ef4444;">${msg_report_detail_action_delete}</button>
      </c:if>

      <%-- 어드민: 삭제 (상태 무관, 관리자모드 + 소유자가 아닐 때만)
           소유자이면 위 소유자 블록에 삭제 버튼이 이미 있으므로 중복 방지 --%>
      <c:if test="${isAdmin and isAdminMode and not isOwner}">
        <button class="rpt-btn-submit" id="deleteBtn"
                style="background:#ef4444;">${msg_report_detail_action_delete}</button>
      </c:if>
    </div>

  </div><%-- /rpt-detail-inner --%>
</div><%-- /rpt-detail-wrap --%>

<%-- =============================================
     스크립트 (관리자 패널 액션)
     ============================================= --%>
<script>
var ctx = '${pageContext.request.contextPath}';
var reportMessages = {
    actionCancelEdit: '${msg_report_detail_action_cancelEdit_js}',
    actionEdit: '${msg_report_detail_action_edit_js}',
    alertCancelFail: '${msg_report_detail_alert_cancelFail_js}',
    alertDeleteFail: '${msg_report_detail_alert_deleteFail_js}',
    alertError: '${msg_report_detail_alert_error_js}',
    alertNetwork: '${msg_report_detail_alert_network_js}',
    alertProcessing: '${msg_report_detail_alert_processing_js}',
    alertUpdateFail: '${msg_report_detail_alert_updateFail_js}',
    confirmBlockAuthor: '${msg_report_detail_confirm_blockAuthor_js}',
    confirmBlockUser: '${msg_report_detail_confirm_blockUser_js}',
    confirmDeleteAndBlockComment: '${msg_report_detail_confirm_deleteAndBlock_comment_js}',
    confirmDeleteAndBlockPost: '${msg_report_detail_confirm_deleteAndBlock_post_js}',
    confirmDeleteAndBlockReview: '${msg_report_detail_confirm_deleteAndBlock_review_js}',
    confirmDeleteContentComment: '${msg_report_detail_confirm_deleteContent_comment_js}',
    confirmDeleteContentPost: '${msg_report_detail_confirm_deleteContent_post_js}',
    confirmDeleteContentReview: '${msg_report_detail_confirm_deleteContent_review_js}',
    confirmDeleteReport: '${msg_report_detail_confirm_deleteReport_js}',
    confirmDismiss: '${msg_report_detail_confirm_dismiss_js}',
    confirmRevert: '${msg_report_detail_confirm_revert_js}',
    confirmUserCancel: '${msg_report_detail_confirm_userCancel_js}'
};
function goBackToList() {
    var params = new URLSearchParams(window.location.search);
    var page       = params.get('page')       || '1';
    var targetType = params.get('targetType') || '';
    location.href = ctx + '/report/list?page=' + page + (targetType ? '&targetType=' + encodeURIComponent(targetType) : '');
}
</script>

<c:if test="${isAdmin and isAdminMode}">
<script>
(function () {
  var ctx        = '${pageContext.request.contextPath}';
  var reportId   = ${report.reportId};
  var targetType = '${report.targetType}';

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
      else { alert(data.message || reportMessages.alertProcessing); }
    })
    .catch(function () { alert(reportMessages.alertNetwork); });
  }

  var btnDeleteContent = document.getElementById('btnDeleteContent');
  if (btnDeleteContent) {
    btnDeleteContent.addEventListener('click', function () {
      var msg = targetType === 'review'
        ? reportMessages.confirmDeleteContentReview
        : (targetType === 'comment'
            ? reportMessages.confirmDeleteContentComment
            : reportMessages.confirmDeleteContentPost);
      resolveReport('DELETE_CONTENT', msg);
    });
  }

  var btnBlockAuthor = document.getElementById('btnBlockAuthor');
  if (btnBlockAuthor) {
    btnBlockAuthor.addEventListener('click', function () {
      resolveReport('BLOCK_AUTHOR', reportMessages.confirmBlockAuthor);
    });
  }

  var btnDeleteAndBlock = document.getElementById('btnDeleteAndBlock');
  if (btnDeleteAndBlock) {
    btnDeleteAndBlock.addEventListener('click', function () {
      var msg = targetType === 'review'
        ? reportMessages.confirmDeleteAndBlockReview
        : (targetType === 'comment'
            ? reportMessages.confirmDeleteAndBlockComment
            : reportMessages.confirmDeleteAndBlockPost);
      resolveReport('DELETE_AND_BLOCK', msg);
    });
  }

  var btnBlockUser = document.getElementById('btnBlockUser');
  if (btnBlockUser) {
    btnBlockUser.addEventListener('click', function () {
      resolveReport('BLOCK_USER', reportMessages.confirmBlockUser);
    });
  }

  var btnDismiss = document.getElementById('btnDismiss');
  if (btnDismiss) {
    btnDismiss.addEventListener('click', function () {
      resolveReport('REJECTED', reportMessages.confirmDismiss);
    });
  }

  var btnRevertToPending = document.getElementById('btnRevertToPending');
  if (btnRevertToPending) {
    btnRevertToPending.addEventListener('click', function () {
      resolveReport('REVERT_TO_PENDING', reportMessages.confirmRevert);
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
      editBtn.textContent    = isShown ? reportMessages.actionEdit : reportMessages.actionCancelEdit;
    });

    editCancelBtn.addEventListener('click', function () {
      editForm.style.display = 'none';
      editBtn.textContent    = reportMessages.actionEdit;
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
        else { alert(data.message || reportMessages.alertUpdateFail); this.disabled = false; }
      } catch (e) { alert(reportMessages.alertError); this.disabled = false; }
    });
  }

  /* 삭제 */
  if (deleteBtn) {
    deleteBtn.addEventListener('click', async function () {
      if (!confirm(reportMessages.confirmDeleteReport)) return;
      this.disabled = true;
      try {
        var data = await postJson('/report/' + reportId + '/delete', {});
        if (data.success) { location.href = ctx + '/report/list'; }
        else { alert(data.message || reportMessages.alertDeleteFail); this.disabled = false; }
      } catch (e) { alert(reportMessages.alertError); this.disabled = false; }
    });
  }

  /* 신고 취소 */
  if (cancelReportBtn) {
    cancelReportBtn.addEventListener('click', async function () {
      if (!confirm(reportMessages.confirmUserCancel)) return;
      this.disabled = true;
      try {
        var data = await postJson('/report/' + reportId + '/cancel', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || reportMessages.alertCancelFail); this.disabled = false; }
      } catch (e) { alert(reportMessages.alertError); this.disabled = false; }
    });
  }
}());
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
