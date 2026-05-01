<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="securityProviderConfigs"/>
<c:set var="pageTitle" value="보안 판단 Provider 설정"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>보안 판단 Provider 설정</h1>
            <p class="adm-page-desc">실제 AI/정책기관 API 키와 엔드포인트를 런칭 시점에 넣고 토글만 켜면 연결될 수 있도록 준비합니다.</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">보안 위험 판단</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">일반 검토 큐</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <c:forEach var="p" items="${providers}">
        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/provider-configs/${p.providerIdx}" class="adm-card" style="margin-bottom:16px;">
            <div class="adm-card-header">
                <div>
                    <div class="adm-card-title">${p.providerName}</div>
                    <div class="adm-muted">${p.providerKind} · ${p.providerCode} · 상태 ${p.status}</div>
                </div>
                <label class="adm-check">
                    <input type="checkbox" name="enabled" ${p.enabled ? 'checked' : ''}>
                    사용
                </label>
            </div>
            <div class="adm-card-body">
                <input type="hidden" name="providerCode" value="${p.providerCode}">
                <input type="hidden" name="providerKind" value="${p.providerKind}">
                <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr));gap:12px;">
                    <label>표시 이름
                        <input class="adm-input" type="text" name="providerName" value="${p.providerName}">
                    </label>
                    <label>Endpoint URL
                        <input class="adm-input" type="text" name="endpointUrl" value="${p.endpointUrl}" placeholder="https://api.example.com/risk">
                    </label>
                    <label>API Key Ref
                        <input class="adm-input" type="text" name="apiKeyRef" value="${p.apiKeyRef}" placeholder="ENV:TRIPTOGETHER_AI_KEY">
                    </label>
                    <label>모델/정책명
                        <input class="adm-input" type="text" name="modelName" value="${p.modelName}">
                    </label>
                    <label>Timeout(ms)
                        <input class="adm-input" type="number" name="timeoutMillis" value="${p.timeoutMillis}">
                    </label>
                    <label>실패 정책
                        <select class="adm-input" name="failOpen">
                            <option value="1" ${p.failOpen == 1 ? 'selected' : ''}>Fail-open: API 실패 시 운영 차단하지 않음</option>
                            <option value="0" ${p.failOpen == 0 ? 'selected' : ''}>Fail-closed: API 실패 시 보수적으로 검토 큐</option>
                        </select>
                    </label>
                </div>
                <label style="display:block;margin-top:12px;">설명
                    <textarea class="adm-input" name="description" rows="2">${p.description}</textarea>
                </label>
                <div class="adm-muted" style="margin-top:8px;">
                    실제 API 호출은 아직 비활성입니다. 런칭 시 Provider 구현체를 연결하면 이 설정을 읽어 동작하도록 확장할 수 있습니다.
                </div>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit">저장</button>
                </div>
            </div>
        </form>
    </c:forEach>
</div>
