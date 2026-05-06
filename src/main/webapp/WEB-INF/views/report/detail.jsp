<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_bf9ae2c0e3" code="report.common.target.post"/>
<spring:message var="autoMsg_d7a242e91e" code="report.common.target.comment"/>
<spring:message var="autoMsg_b000c6cb0b" code="report.common.target.review"/>
<spring:message var="autoMsg_d6290dafc6" code="report.common.target.user"/>
<spring:message var="autoMsg_cdc6e6c0f3" code="report.common.status.inReview"/>
<spring:message var="autoMsg_607101300d" code="report.common.status.resolved"/>
<spring:message var="autoMsg_35531f0dc7" code="report.common.status.dismissed"/>
<spring:message var="autoMsg_926ebbaa35" code="report.detail.title.post"/>
<spring:message var="autoMsg_2a8fd4df41" code="report.detail.title.comment"/>
<spring:message var="autoMsg_adac598f2b" code="report.detail.title.review"/>
<spring:message var="autoMsg_846e55d10c" code="report.detail.title.user"/>
<spring:message var="autoMsg_f41a380186" code="report.detail.title.default"/>
<spring:message var="autoMsg_3bb807a1e6" code="report.detail.label.reason"/>
<spring:message var="autoMsg_fbf2cc1940" code="report.common.reason.spam"/>
<spring:message var="autoMsg_30ea4b8644" code="report.common.reason.abuse"/>
<spring:message var="autoMsg_7239221909" code="report.common.reason.privacy"/>
<spring:message var="autoMsg_59258cd841" code="report.common.reason.adult"/>
<spring:message var="autoMsg_c33a09d790" code="report.common.reason.illegal"/>
<spring:message var="autoMsg_5e57d8aea5" code="report.common.reason.other"/>
<spring:message var="autoMsg_77d29fa794" code="report.detail.label.userDescription"/>
<spring:message var="autoMsg_b3ff2b9567" code="report.detail.label.description"/>
<spring:message var="autoMsg_51653e8937" code="report.detail.label.target"/>
<spring:message var="autoMsg_0ff5ed546c" code="report.common.deletedPost"/>
<spring:message var="autoMsg_8164f73d61" code="report.detail.info.authorPrefix"/>
<spring:message var="autoMsg_61c9d0d8b9" code="report.common.deletedComment"/>
<spring:message var="autoMsg_3e754ba8bb" code="report.common.post"/>
<spring:message var="autoMsg_8688aa61ee" code="report.detail.info.commentSuffix"/>
<spring:message var="autoMsg_1358075a93" code="report.common.deletedReview"/>
<spring:message var="autoMsg_56d67fd3ae" code="report.common.spot"/>
<spring:message var="autoMsg_2885f3da80" code="report.detail.info.reviewSuffix"/>
<spring:message var="autoMsg_c030ec1e32" code="report.common.unknownUser"/>
<spring:message var="autoMsg_1864b81744" code="report.detail.info.source"/>
<spring:message var="autoMsg_2015361e9a" code="report.detail.info.reporter"/>
<spring:message var="autoMsg_6328ce1c16" code="report.detail.result.resolved.title"/>
<spring:message var="autoMsg_6aa7fe85d9" code="report.detail.result.resolved.body"/>
<spring:message var="autoMsg_949709b9bf" code="report.detail.result.dismissed.title"/>
<spring:message var="autoMsg_7bb652f126" code="report.detail.result.dismissed.body"/>
<spring:message var="autoMsg_81c2b0bf91" code="report.detail.result.cancelled.title"/>
<spring:message var="autoMsg_c908874328" code="report.detail.result.cancelled.body"/>
<spring:message var="autoMsg_befe430e70" code="report.detail.result.pending.title"/>
<spring:message var="autoMsg_86570accd6" code="report.detail.result.pending.subtitle"/>
<spring:message var="autoMsg_71d17bf9b8" code="report.detail.admin.title"/>
<spring:message var="autoMsg_259e8ce92f" code="report.detail.admin.action.deleteAndBlock.post"/>
<spring:message var="autoMsg_3b266ee781" code="report.detail.admin.action.deleteContent.post"/>
<spring:message var="autoMsg_73efb53f03" code="report.detail.admin.action.blockAuthor"/>
<spring:message var="autoMsg_c67002c90c" code="report.detail.admin.action.deleteAndBlock.comment"/>
<spring:message var="autoMsg_c383a7e2ab" code="report.detail.admin.action.deleteContent.comment"/>
<spring:message var="autoMsg_47383177b5" code="report.detail.admin.action.deleteAndBlock.review"/>
<spring:message var="autoMsg_9553fe2a1e" code="report.detail.admin.action.deleteContent.review"/>
<spring:message var="autoMsg_f34eef7b95" code="report.detail.admin.action.blockUser"/>
<spring:message var="autoMsg_387eb05122" code="report.detail.admin.action.revert"/>
<spring:message var="autoMsg_b732fad9e7" code="report.detail.action.edit"/>
<spring:message var="autoMsg_45642e6f1f" code="report.detail.action.delete"/>
<spring:message var="autoMsg_182249a72f" code="report.detail.action.cancelReport"/>
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

<spring:message code="report.common.backToList" var="reportBackToList"/>
<spring:message code="report.common.cancel" var="reportCancel"/>
<spring:message code="report.common.keepDismiss" var="reportKeepDismiss"/>
<spring:message code="report.common.none" var="reportNone"/>
<spring:message code="report.common.save" var="reportSave"/>
<spring:message code="report.detail.action.cancelEdit" javaScriptEscape="true" var="reportActionCancelEdit"/>
<spring:message code="report.detail.action.edit" javaScriptEscape="true" var="reportActionEdit"/>
<spring:message code="report.detail.alert.cancelFail" javaScriptEscape="true" var="reportAlertCancelFail"/>
<spring:message code="report.detail.alert.deleteFail" javaScriptEscape="true" var="reportAlertDeleteFail"/>
<spring:message code="report.detail.alert.error" javaScriptEscape="true" var="reportAlertError"/>
<spring:message code="report.detail.alert.network" javaScriptEscape="true" var="reportAlertNetwork"/>
<spring:message code="report.detail.alert.processing" javaScriptEscape="true" var="reportAlertProcessing"/>
<spring:message code="report.detail.alert.updateFail" javaScriptEscape="true" var="reportAlertUpdateFail"/>
<spring:message code="report.detail.confirm.blockAuthor" javaScriptEscape="true" var="reportConfirmBlockAuthor"/>
<spring:message code="report.detail.confirm.blockUser" javaScriptEscape="true" var="reportConfirmBlockUser"/>
<spring:message code="report.detail.confirm.deleteAndBlock.comment" javaScriptEscape="true" var="reportConfirmDeleteAndBlockComment"/>
<spring:message code="report.detail.confirm.deleteAndBlock.post" javaScriptEscape="true" var="reportConfirmDeleteAndBlockPost"/>
<spring:message code="report.detail.confirm.deleteAndBlock.review" javaScriptEscape="true" var="reportConfirmDeleteAndBlockReview"/>
<spring:message code="report.detail.confirm.deleteContent.comment" javaScriptEscape="true" var="reportConfirmDeleteContentComment"/>
<spring:message code="report.detail.confirm.deleteContent.post" javaScriptEscape="true" var="reportConfirmDeleteContentPost"/>
<spring:message code="report.detail.confirm.deleteContent.review" javaScriptEscape="true" var="reportConfirmDeleteContentReview"/>
<spring:message code="report.detail.confirm.deleteReport" javaScriptEscape="true" var="reportConfirmDeleteReport"/>
<spring:message code="report.detail.confirm.dismiss" javaScriptEscape="true" var="reportConfirmDismiss"/>
<spring:message code="report.detail.confirm.revert" javaScriptEscape="true" var="reportConfirmRevert"/>
<spring:message code="report.detail.confirm.userCancel" javaScriptEscape="true" var="reportConfirmUserCancel"/>

<div class="rpt-detail-wrap">
  <div class="rpt-detail-inner">

    <%-- 뒤로가기 버튼 --%>
    <button class="rpt-back-btn" onclick="goBackToList()">
      &#8592; ${reportBackToList}
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
              <span class="rpt-type-tag type-post">${autoMsg_bf9ae2c0e3} #${report.targetId}</span>
            </c:when>
            <c:when test="${report.targetType eq 'comment'}">
              <span class="rpt-type-tag type-comment">${autoMsg_d7a242e91e} #${report.targetId}</span>
            </c:when>
            <c:when test="${report.targetType eq 'review'}">
              <span class="rpt-type-tag type-review">${autoMsg_b000c6cb0b} #${report.targetId}</span>
            </c:when>
            <c:when test="${report.targetType eq 'user'}">
              <span class="rpt-type-tag type-user">${autoMsg_d6290dafc6} #${report.targetId}</span>
            </c:when>
            <c:otherwise>
              <span class="rpt-type-tag">${report.targetType} #${report.targetId}</span>
            </c:otherwise>
          </c:choose>

          <%-- 처리 상태 뱃지 --%>
          <span class="rpt-status-badge ${report.status}">
            <c:choose>
              <c:when test="${report.status eq 'IN_REVIEW'}">${autoMsg_cdc6e6c0f3}</c:when>
              <c:when test="${report.status eq 'RESOLVED'}">${autoMsg_607101300d}</c:when>
              <c:when test="${report.status eq 'DISMISSED'}">${autoMsg_35531f0dc7}</c:when>
              <c:otherwise>${report.status}</c:otherwise>
            </c:choose>
          </span>
        </div>

        <%-- 제목 --%>
        <h1 class="rpt-detail-title">
          <c:choose>
            <c:when test="${report.targetType eq 'post'}">${autoMsg_926ebbaa35}</c:when>
            <c:when test="${report.targetType eq 'comment'}">${autoMsg_2a8fd4df41}</c:when>
            <c:when test="${report.targetType eq 'review'}">${autoMsg_adac598f2b}</c:when>
            <c:when test="${report.targetType eq 'user'}">${autoMsg_846e55d10c}</c:when>
            <c:otherwise>${autoMsg_f41a380186}</c:otherwise>
          </c:choose>
        </h1>

        <%-- 신고일 --%>
        <div class="rpt-detail-info">
          <spring:message code="report.detail.info.reportedAt"/>: <fmt:formatDate value="${report.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/>
        </div>
      </div>

      <%-- 카드 본문 --%>
      <div class="rpt-detail-body">

        <%-- 게시글/댓글 신고: 사유 코드 표시 --%>
        <c:if test="${report.targetType ne 'user'}">
          <div class="rpt-detail-row">
            <span class="rpt-detail-label">${autoMsg_3bb807a1e6}</span>
            <span class="rpt-detail-value">
              <c:choose>
                <c:when test="${report.reason eq 'spam'}">${autoMsg_fbf2cc1940}</c:when>
                <c:when test="${report.reason eq 'abuse'}">${autoMsg_30ea4b8644}</c:when>
                <c:when test="${report.reason eq 'privacy'}">${autoMsg_7239221909}</c:when>
                <c:when test="${report.reason eq 'adult'}">${autoMsg_59258cd841}</c:when>
                <c:when test="${report.reason eq 'illegal'}">${autoMsg_c33a09d790}</c:when>
                <c:when test="${report.reason eq 'other'}">${autoMsg_5e57d8aea5}</c:when>
                <c:otherwise>
                  <c:choose>
                    <c:when test="${not empty report.reason}">${report.reason}</c:when>
                    <c:otherwise>${reportNone}</c:otherwise>
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
                <c:when test="${report.targetType eq 'user'}">${autoMsg_77d29fa794}</c:when>
                <c:otherwise>${autoMsg_b3ff2b9567}</c:otherwise>
              </c:choose>
            </span>
            <span class="rpt-detail-value rpt-detail-desc">${report.description}</span>
          </div>
        </c:if>

        <%-- 신고 대상 정보 --%>
        <div class="rpt-detail-row">
          <span class="rpt-detail-label">${autoMsg_51653e8937}</span>
          <span class="rpt-detail-value">
            <c:choose>

              <%-- 게시글 신고 --%>
              <c:when test="${report.targetType eq 'post'}">
                <c:choose>
                  <c:when test="${targetDeleted}">
                    <span style="color:var(--gray-400);">${autoMsg_0ff5ed546c}</span>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/community/${targetPostId}"
                       style="color:#3b82f6;text-decoration:underline;">
                      ${targetTitle}
                    </a>
                    <c:if test="${not empty targetNickname}">
                      <span style="color:var(--gray-500);font-size:13px;"> — ${autoMsg_8164f73d61} ${targetNickname}</span>
                    </c:if>
                  </c:otherwise>
                </c:choose>
              </c:when>

              <%-- 댓글 신고 --%>
              <c:when test="${report.targetType eq 'comment'}">
                <c:choose>
                  <c:when test="${targetDeleted}">
                    <span style="color:var(--gray-400);">${autoMsg_61c9d0d8b9}</span>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/community/${targetPostId}"
                       style="color:#3b82f6;text-decoration:underline;">
                      ${autoMsg_3e754ba8bb} #${targetPostId}
                    </a>
                    <span style="color:var(--gray-500);font-size:13px;">${autoMsg_8688aa61ee}</span>
                    <c:if test="${not empty targetNickname}">
                      <span style="color:var(--gray-500);font-size:13px;"> — ${autoMsg_8164f73d61} ${targetNickname}</span>
                    </c:if>
                    <div style="margin-top:4px;font-size:13px;color:var(--gray-600);background:var(--gray-50);padding:6px 10px;border-radius:6px;border-left:3px solid var(--gray-200);">"${targetContent}"</div>
                  </c:otherwise>
                </c:choose>
              </c:when>

              <%-- 여행지 리뷰 신고 --%>
              <c:when test="${report.targetType eq 'review'}">
                <c:choose>
                  <c:when test="${targetDeleted}">
                    <span style="color:var(--gray-400);">${autoMsg_1358075a93}</span>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/detail/${targetSpotId}"
                       style="color:#3b82f6;text-decoration:underline;">
                      ${autoMsg_56d67fd3ae} #${targetSpotId}
                    </a>
                    <span style="color:var(--gray-500);font-size:13px;">${autoMsg_2885f3da80}</span>
                    <c:if test="${not empty targetNickname}">
                      <span style="color:var(--gray-500);font-size:13px;"> — ${autoMsg_8164f73d61} ${targetNickname}</span>
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
                    <span style="color:var(--gray-400);">${autoMsg_c030ec1e32}</span>
                  </c:otherwise>
                </c:choose>
                <%-- 신고 출처 (어떤 게시글/댓글에서 신고했는지) --%>
                <c:if test="${not empty report.sourceType}">
                  <div style="margin-top:6px;font-size:13px;color:var(--gray-500);">
                    ${autoMsg_1864b81744}:
                    <c:choose>
                      <c:when test="${report.sourceType eq 'post'}">
                        <c:choose>
                          <c:when test="${sourceDeleted}">
                            <span style="color:var(--gray-400);">${autoMsg_0ff5ed546c}</span>
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
                            <span style="color:var(--gray-400);">${autoMsg_61c9d0d8b9}</span>
                          </c:when>
                          <c:otherwise>
                            <a href="${pageContext.request.contextPath}/community/${sourcePostId}"
                               style="color:#3b82f6;text-decoration:underline;">
                              ${autoMsg_3e754ba8bb} #${sourcePostId}
                            </a>
                            <span>${autoMsg_8688aa61ee}</span>
                            <div style="margin-top:4px;background:var(--gray-50);padding:6px 10px;border-radius:6px;border-left:3px solid var(--gray-200);">"${sourceContent}"</div>
                          </c:otherwise>
                        </c:choose>
                      </c:when>
                      <c:when test="${report.sourceType eq 'review'}">
                        <c:choose>
                          <c:when test="${sourceDeleted}">
                            <span style="color:var(--gray-400);">${autoMsg_1358075a93}</span>
                          </c:when>
                          <c:otherwise>
                            <a href="${pageContext.request.contextPath}/detail/${sourceSpotId}"
                               style="color:#3b82f6;text-decoration:underline;">
                              ${autoMsg_56d67fd3ae} #${sourceSpotId}
                            </a>
                            <span>${autoMsg_2885f3da80}</span>
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
            <span class="rpt-detail-label">${autoMsg_2015361e9a}</span>
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
              <div class="rpt-result-title">${autoMsg_6328ce1c16}</div>
              <c:if test="${not empty report.resolvedAt}">
                <div class="rpt-result-meta"><fmt:formatDate value="${report.resolvedAt}" pattern="yyyy-MM-dd HH:mm"/></div>
              </c:if>
            </div>
          </div>
          <div class="rpt-result-body">
            ${autoMsg_6aa7fe85d9}<c:if test="${not empty report.resolveAction}"> (${report.resolveAction})</c:if>
          </div>
        </div>
      </c:when>

      <c:when test="${report.status eq 'DISMISSED'}">
        <div class="rpt-result-card DISMISSED">
          <div class="rpt-result-head">
            <span class="rpt-result-icon">&#10060;</span>
            <div>
              <div class="rpt-result-title">${autoMsg_949709b9bf}</div>
              <c:if test="${not empty report.resolvedAt}">
                <div class="rpt-result-meta"><fmt:formatDate value="${report.resolvedAt}" pattern="yyyy-MM-dd HH:mm"/></div>
              </c:if>
            </div>
          </div>
          <div class="rpt-result-body">${autoMsg_7bb652f126}</div>
        </div>
      </c:when>

      <c:when test="${report.status eq 'CANCELLED'}">
        <div class="rpt-result-card CANCELLED">
          <div class="rpt-result-head">
            <span class="rpt-result-icon">✖</span>
            <div>
              <div class="rpt-result-title">${autoMsg_81c2b0bf91}</div>
              <c:if test="${not empty report.updatedAt}">
                <div class="rpt-result-meta"><fmt:formatDate value="${report.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
              </c:if>
            </div>
          </div>
          <div class="rpt-result-body">${autoMsg_c908874328}</div>
        </div>
      </c:when>

      <c:otherwise>
        <div class="rpt-no-result">
          <div class="rpt-no-result-icon">🔍</div>
          <div class="rpt-no-result-msg">${autoMsg_befe430e70}</div>
          <div class="rpt-no-result-sub">${autoMsg_86570accd6}</div>
        </div>
      </c:otherwise>
    </c:choose>

    <%-- =============================================
         3. 관리자 패널
         - 관리자이고 관리자모드일 때만 표시 (유저경험모드 시 숨김)
         ============================================= --%>
    <c:if test="${isAdmin and isAdminMode}">
      <div class="rpt-admin-form">
        <div class="rpt-admin-form-title">${autoMsg_71d17bf9b8}</div>

        <c:choose>

          <%-- IN_REVIEW: 처리 버튼 표시 --%>
          <c:when test="${report.status eq 'IN_REVIEW'}">

            <%-- 게시글 신고 --%>
            <c:if test="${report.targetType eq 'post'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnDeleteAndBlock">${autoMsg_259e8ce92f}</button>
                <button class="rpt-btn-danger" id="btnDeleteContent">${autoMsg_3b266ee781}</button>
                <button class="rpt-btn-danger" id="btnBlockAuthor">${autoMsg_73efb53f03}</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">${reportKeepDismiss}</button>
              </div>
            </c:if>

            <%-- 댓글 신고 --%>
            <c:if test="${report.targetType eq 'comment'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnDeleteAndBlock">${autoMsg_c67002c90c}</button>
                <button class="rpt-btn-danger" id="btnDeleteContent">${autoMsg_c383a7e2ab}</button>
                <button class="rpt-btn-danger" id="btnBlockAuthor">${autoMsg_73efb53f03}</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">${reportKeepDismiss}</button>
              </div>
            </c:if>

            <%-- 여행지 리뷰 신고 --%>
            <c:if test="${report.targetType eq 'review'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnDeleteAndBlock">${autoMsg_47383177b5}</button>
                <button class="rpt-btn-danger" id="btnDeleteContent">${autoMsg_9553fe2a1e}</button>
                <button class="rpt-btn-danger" id="btnBlockAuthor">${autoMsg_73efb53f03}</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">${reportKeepDismiss}</button>
              </div>
            </c:if>

            <%-- 유저 신고 --%>
            <c:if test="${report.targetType eq 'user'}">
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-danger" id="btnBlockUser">${autoMsg_f34eef7b95}</button>
              </div>
              <div class="rpt-admin-action-bar">
                <button class="rpt-btn-cancel" id="btnDismiss">${reportKeepDismiss}</button>
              </div>
            </c:if>

          </c:when>

          <%-- 처리완료/반려 → 반려취소 버튼 --%>
          <c:otherwise>
            <div class="rpt-admin-action-bar">
              <button class="rpt-btn-warn" id="btnRevertToPending">${autoMsg_387eb05122}</button>
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
              <label class="rpt-form-label">${autoMsg_3bb807a1e6}</label>
              <select class="rpt-form-select" id="editReason">
                <option value="spam"    ${report.reason eq 'spam'    ? 'selected' : ''}>${autoMsg_fbf2cc1940}</option>
                <option value="abuse"   ${report.reason eq 'abuse'   ? 'selected' : ''}>${autoMsg_30ea4b8644}</option>
                <option value="privacy" ${report.reason eq 'privacy' ? 'selected' : ''}>${autoMsg_7239221909}</option>
                <option value="adult"   ${report.reason eq 'adult'   ? 'selected' : ''}>${autoMsg_59258cd841}</option>
                <option value="illegal" ${report.reason eq 'illegal' ? 'selected' : ''}>${autoMsg_c33a09d790}</option>
                <option value="other"   ${report.reason eq 'other'   ? 'selected' : ''}>${autoMsg_5e57d8aea5}</option>
              </select>
            </div>
          </c:if>
          <%-- 상세 내용 --%>
          <div class="rpt-form-group">
            <label class="rpt-form-label">
              <c:choose>
                <c:when test="${report.targetType eq 'user'}">${autoMsg_77d29fa794}</c:when>
                <c:otherwise>${autoMsg_b3ff2b9567}</c:otherwise>
              </c:choose>
            </label>
            <textarea class="rpt-form-textarea" id="editDescription" rows="6">${report.description}</textarea>
          </div>
          <div class="rpt-write-actions">
            <button class="rpt-btn-cancel" id="editCancelBtn">${reportCancel}</button>
            <button class="rpt-btn-submit" id="editSaveBtn">${reportSave}</button>
          </div>
        </div>
      </div>
    </c:if>

    <%-- 수정 불가 안내 --%>
    <c:if test="${isOwner and (report.status eq 'RESOLVED' or report.status eq 'DISMISSED')}">
      <div style="font-size:13px; color:var(--gray-400); margin-bottom:8px;">
        <spring:message code="report.detail.edit.cannotAfterProcessed"/>
      </div>
    </c:if>

    <%-- =============================================
         5. 하단 액션 버튼
         ============================================= --%>
    <div class="rpt-detail-actions">
      <button class="rpt-btn-cancel" onclick="goBackToList()">
        ${reportBackToList}
      </button>

      <%-- IN_REVIEW: 수정 + 삭제 + 신고 취소 --%>
      <c:if test="${isOwner and report.status eq 'IN_REVIEW'}">
        <button class="rpt-btn-cancel" id="editBtn">${autoMsg_b732fad9e7}</button>
        <button class="rpt-btn-submit" id="deleteBtn"
                style="background:#ef4444;">${autoMsg_45642e6f1f}</button>
        <button class="rpt-btn-submit" id="cancelReportBtn"
                style="background:#f59e0b;">${autoMsg_182249a72f}</button>
      </c:if>

      <%-- CANCELLED: 삭제만 --%>
      <c:if test="${isOwner and report.status eq 'CANCELLED'}">
        <button class="rpt-btn-submit" id="deleteBtn"
                style="background:#ef4444;">${autoMsg_45642e6f1f}</button>
      </c:if>

      <%-- 어드민: 삭제 (상태 무관, 관리자모드 + 소유자가 아닐 때만)
           소유자이면 위 소유자 블록에 삭제 버튼이 이미 있으므로 중복 방지 --%>
      <c:if test="${isAdmin and isAdminMode and not isOwner}">
        <button class="rpt-btn-submit" id="deleteBtn"
                style="background:#ef4444;">${autoMsg_45642e6f1f}</button>
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
    actionCancelEdit: '${reportActionCancelEdit}',
    actionEdit: '${reportActionEdit}',
    alertCancelFail: '${reportAlertCancelFail}',
    alertDeleteFail: '${reportAlertDeleteFail}',
    alertError: '${reportAlertError}',
    alertNetwork: '${reportAlertNetwork}',
    alertProcessing: '${reportAlertProcessing}',
    alertUpdateFail: '${reportAlertUpdateFail}',
    confirmBlockAuthor: '${reportConfirmBlockAuthor}',
    confirmBlockUser: '${reportConfirmBlockUser}',
    confirmDeleteAndBlockComment: '${reportConfirmDeleteAndBlockComment}',
    confirmDeleteAndBlockPost: '${reportConfirmDeleteAndBlockPost}',
    confirmDeleteAndBlockReview: '${reportConfirmDeleteAndBlockReview}',
    confirmDeleteContentComment: '${reportConfirmDeleteContentComment}',
    confirmDeleteContentPost: '${reportConfirmDeleteContentPost}',
    confirmDeleteContentReview: '${reportConfirmDeleteContentReview}',
    confirmDeleteReport: '${reportConfirmDeleteReport}',
    confirmDismiss: '${reportConfirmDismiss}',
    confirmRevert: '${reportConfirmRevert}',
    confirmUserCancel: '${reportConfirmUserCancel}'
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
