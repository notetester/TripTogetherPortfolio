<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_1ad9508f94" code="mypage.history.clearAll"/>
<spring:message var="autoMsg_f273bac016" code="mypage.history.deleted"/>
<spring:message var="autoMsg_8a8c6d8fe5" code="mypage.history.relative.justNow" javaScriptEscape="true"/>
<spring:message var="autoMsg_c37f06beed" code="mypage.history.relative.minutes" javaScriptEscape="true"/>
<spring:message var="autoMsg_340a4363cc" code="mypage.history.relative.hours" javaScriptEscape="true"/>
<spring:message var="autoMsg_1c123bf67e" code="mypage.history.relative.yesterday" javaScriptEscape="true"/>
<spring:message var="autoMsg_db3748532b" code="mypage.history.relative.days" javaScriptEscape="true"/>
<%--
  마이페이지 - 최근 조회 내역 전체 보기
  Controller : GET /mypage/history
  Model:
    - user         : UsersVO
    - historyList  : List<ViewHistoryItemDto>
    - historyCount : int
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<spring:message code="mypage.history.clearAllConfirm"
                javaScriptEscape="true" var="historyClearAllConfirmJs"/>
<spring:message code="mypage.history.deleteConfirm"
                javaScriptEscape="true" var="historyDeleteConfirmJs"/>

<div class="mp-wrap">
    <div class="mp-container">

        <div class="mp-card">
            <div class="mp-history-page-head">
                <div class="mp-history-page-title">
                    <span>🕒</span>
                    <spring:message code="mypage.history.title"/>
                    <span class="mp-card-count">${historyCount}</span>
                </div>
                <c:if test="${not empty historyList}">
                    <button type="button" class="mp-history-clear-btn" id="mpHistoryClearBtn">
                        🗑 ${autoMsg_1ad9508f94}
                    </button>
                </c:if>
            </div>

            <c:choose>
                <c:when test="${empty historyList}">
                    <div class="mp-history-empty">
                        <div class="mp-history-empty-icon">🕒</div>
                        <spring:message code="mypage.empty.history"/>
                    </div>
                </c:when>
                <c:otherwise>
                    <div id="mpHistoryList">
                        <c:forEach var="h" items="${historyList}">
                            <c:set var="typeKey" value="${h.contentType}"/>
                            <c:set var="linkHref" value=""/>
                            <c:choose>
                                <c:when test="${typeKey eq 'community'}">
                                    <c:set var="linkHref" value="${pageContext.request.contextPath}/community/${h.contentId}"/>
                                </c:when>
                                <c:when test="${typeKey eq 'spot'}">
                                    <c:set var="linkHref" value="${pageContext.request.contextPath}/detail/${h.contentId}"/>
                                </c:when>
                                <c:when test="${typeKey eq 'plan'}">
                                    <c:set var="linkHref" value="${pageContext.request.contextPath}/courses/detail?planId=${h.contentId}"/>
                                </c:when>
                            </c:choose>
                            <div class="mp-history-row-wrap" data-history-idx="${h.historyIdx}">
                                <a href="${linkHref}" class="mp-list-item <c:if test='${not h.available}'>is-unavailable</c:if>">
                                    <div class="mp-list-content">
                                        <div class="mp-list-title">
                                            <c:choose>
                                                <c:when test="${h.available and not empty h.title}">${h.title}</c:when>
                                                <c:otherwise>${autoMsg_f273bac016}</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="mp-list-meta">
                                            <c:if test="${not empty h.subtitle}">
                                                <span>${h.subtitle}</span>
                                            </c:if>
                                            <span data-mp-history-ts="${h.viewedAt.time}"></span>
                                        </div>
                                    </div>
                                    <div class="mp-list-badges">
                                        <span class="mp-badge mp-history-type-${typeKey}">
                                            <spring:message code="mypage.history.type.${typeKey}"/>
                                        </span>
                                    </div>
                                </a>
                                <button type="button" class="mp-history-row-delete"
                                        data-history-idx="${h.historyIdx}"
                                        aria-label="delete">✕</button>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div style="text-align:center;margin-top:16px;">
            <a href="${pageContext.request.contextPath}/mypage" class="mp-history-clear-btn" style="text-decoration:none;">
                <spring:message code="mypage.common.backToMypage"/>
            </a>
        </div>
    </div>
</div>

<script>
(function () {
    var CTX = '${pageContext.request.contextPath}';
    var LABELS = {
        justNow:   '${autoMsg_8a8c6d8fe5}',
        minutes:   '${autoMsg_c37f06beed}',
        hours:     '${autoMsg_340a4363cc}',
        yesterday: '${autoMsg_1c123bf67e}',
        days:      '${autoMsg_db3748532b}'
    };
    function relTime(ts) {
        var now = Date.now();
        var diffSec = Math.max(0, Math.floor((now - ts) / 1000));
        if (diffSec < 60)           return LABELS.justNow;
        if (diffSec < 60 * 60)      return LABELS.minutes.replace('{0}', Math.floor(diffSec / 60));
        if (diffSec < 60 * 60 * 24) return LABELS.hours.replace('{0}', Math.floor(diffSec / 3600));
        if (diffSec < 60 * 60 * 48) return LABELS.yesterday;
        return LABELS.days.replace('{0}', Math.floor(diffSec / 86400));
    }
    document.querySelectorAll('[data-mp-history-ts]').forEach(function (el) {
        var ts = parseInt(el.getAttribute('data-mp-history-ts'), 10);
        if (!isNaN(ts)) el.textContent = relTime(ts);
    });

    // 개별 삭제
    document.querySelectorAll('.mp-history-row-delete').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            e.stopPropagation();
            if (!confirm('${historyDeleteConfirmJs}')) return;
            var idx = btn.dataset.historyIdx;
            fetch(CTX + '/mypage/history/' + idx + '/delete', {
                method: 'POST',
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (data && data.success) {
                    var wrap = btn.closest('.mp-history-row-wrap');
                    if (wrap) wrap.remove();
                    var remaining = document.querySelectorAll('.mp-history-row-wrap').length;
                    if (remaining === 0) location.reload();
                }
            })
            .catch(function () {});
        });
    });

    // 전체 삭제
    var clearBtn = document.getElementById('mpHistoryClearBtn');
    if (clearBtn) {
        clearBtn.addEventListener('click', function () {
            if (!confirm('${historyClearAllConfirmJs}')) return;
            fetch(CTX + '/mypage/history/clear', {
                method: 'POST',
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (data && data.success) location.reload();
            })
            .catch(function () {});
        });
    }
})();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
