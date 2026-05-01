<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activeMenu" value="loginRiskPolicies"/>
<c:set var="pageTitle" value="로그인 위험 정책"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>로그인 위험 정책</h1>
            <p class="adm-page-desc">로그인 실패, IP 기반 실패 패턴, 관리자 검토 대상 정책을 조정합니다.</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews">검토 큐</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">알림 설정</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <c:forEach var="p" items="${policies}">
        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/policies/${p.policyIdx}" class="adm-card" style="margin-bottom:16px;">
            <div class="adm-card-header">
                <div>
                    <div class="adm-card-title">${p.policyName}</div>
                    <div class="adm-muted">${p.policyCode} · ${p.policyType} · ${p.actionType}</div>
                </div>
                <label class="adm-check">
                    <input type="checkbox" name="active" ${p.active ? 'checked' : ''}>
                    사용
                </label>
            </div>
            <div class="adm-card-body">
                <input type="hidden" name="policyCode" value="${p.policyCode}">
                <input type="hidden" name="policyType" value="${p.policyType}">
                <input type="hidden" name="actionType" value="${p.actionType}">

                <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr)); gap:12px;">
                    <label>관찰 시간(분)
                        <input class="adm-input" type="number" name="observationMinutes" value="${p.observationMinutes}">
                    </label>
                    <label>임계 횟수
                        <input class="adm-input" type="number" name="thresholdCount" value="${p.thresholdCount}">
                    </label>
                    <label>서로 다른 계정 수
                        <input class="adm-input" type="number" name="distinctAccountThreshold" value="${p.distinctAccountThreshold}">
                    </label>
                    <label>제한 시간(분)
                        <input class="adm-input" type="number" name="lockDurationMinutes" value="${p.lockDurationMinutes}">
                    </label>
                    <label>경고 시작 잔여 횟수
                        <input class="adm-input" type="number" name="warningBeforeCount" value="${p.warningBeforeCount}">
                    </label>
                    <label>심각도
                        <select class="adm-input" name="reviewSeverity">
                            <option value="LOW" ${p.reviewSeverity == 'LOW' ? 'selected' : ''}>LOW</option>
                            <option value="MEDIUM" ${p.reviewSeverity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                            <option value="HIGH" ${p.reviewSeverity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                            <option value="CRITICAL" ${p.reviewSeverity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                        </select>
                    </label>
                    <label>알림 분류
                        <input class="adm-input" type="text" name="notificationCategory" value="${p.notificationCategory}">
                    </label>
                    <label>AI 위험 점수 기준
                        <input class="adm-input" type="number" name="aiRiskScoreThreshold" value="${p.aiRiskScoreThreshold}">
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="resetOnSuccess" ${p.resetOnSuccess ? 'checked' : ''}>
                        로그인 성공 시 초기화
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="requireAdminReview" ${p.requireAdminReview ? 'checked' : ''}>
                        관리자 검토 큐 생성
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="aiAssistEnabled" ${p.aiAssistEnabled ? 'checked' : ''}>
                        AI 판단 보조
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="wafSyncEnabled" ${p.wafSyncEnabled ? 'checked' : ''}>
                        WAF 동기화 후보 생성
                    </label>
                </div>

                <label style="display:block;margin-top:12px;">설명
                    <textarea class="adm-input" name="description" rows="2">${p.description}</textarea>
                </label>

                <div class="adm-actions" style="margin-top:12px;">
                    <button type="submit" class="adm-btn primary">저장</button>
                </div>
            </div>
        </form>
    </c:forEach>
</div>
