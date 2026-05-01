<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="loginRiskAssessments"/>
<c:set var="pageTitle" value="로그인 위험 외부 판단"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>로그인 위험 외부 판단</h1>
            <p class="adm-page-desc">AI, 규칙 알고리즘, 상위 보안 정책기관/관제센터의 보조 판단 결과를 확인합니다.</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">정책 설정</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews">검토 큐</a>
        </div>
    </div>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(5,minmax(0,1fr));gap:10px;">
            <label>판단 출처
                <select class="adm-input" name="sourceKind">
                    <option value="">전체</option>
                    <option value="AI_MODEL" ${sourceKind == 'AI_MODEL' ? 'selected' : ''}>AI_MODEL</option>
                    <option value="RULE_ALGORITHM" ${sourceKind == 'RULE_ALGORITHM' ? 'selected' : ''}>RULE_ALGORITHM</option>
                    <option value="POLICY_AUTHORITY" ${sourceKind == 'POLICY_AUTHORITY' ? 'selected' : ''}>POLICY_AUTHORITY</option>
                    <option value="ASSESSMENT_PIPELINE" ${sourceKind == 'ASSESSMENT_PIPELINE' ? 'selected' : ''}>ASSESSMENT_PIPELINE</option>
                </select>
            </label>
            <label>위험도
                <select class="adm-input" name="riskLevel">
                    <option value="">전체</option>
                    <option value="CRITICAL" ${riskLevel == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${riskLevel == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${riskLevel == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${riskLevel == 'LOW' ? 'selected' : ''}>LOW</option>
                    <option value="PENDING" ${riskLevel == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label>결정 상태
                <select class="adm-input" name="decisionStatus">
                    <option value="">전체</option>
                    <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                    <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                    <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                    <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label>검색
                <input class="adm-input" type="text" name="keyword" value="${keyword}" placeholder="IP, 계정, 출처, 사유">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">검색</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>출처</th>
                <th>대상</th>
                <th>위험도</th>
                <th>권고 조치</th>
                <th>판단 근거</th>
                <th>상태</th>
                <th>생성일</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${assessments}">
                <tr>
                    <td>
                        <strong>${a.sourceKind}</strong><br>
                        <small>${a.sourceName}</small><br>
                        <small>${a.sourceCode} ${a.sourceVersion}</small>
                    </td>
                    <td>
                        ${a.subjectType}: ${a.subjectKey}<br>
                        <c:if test="${not empty a.userId}"><small>${a.userId} / ${a.nickname}</small><br></c:if>
                        <c:if test="${not empty a.ipAddress}"><small>IP: ${a.ipAddress}</small></c:if>
                    </td>
                    <td>
                        <strong>${a.riskLevel}</strong>
                        <c:if test="${not empty a.riskScore}"><br><small>score ${a.riskScore}</small></c:if>
                        <c:if test="${not empty a.confidenceScore}"><br><small>confidence ${a.confidenceScore}</small></c:if>
                    </td>
                    <td>
                        <strong>${a.recommendationAction}</strong><br>
                        <small>${a.recommendationReason}</small>
                    </td>
                    <td>${a.evidenceSummary}</td>
                    <td>${a.decisionStatus}</td>
                    <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                </tr>
            </c:forEach>
            <c:if test="${empty assessments}">
                <tr><td colspan="7" class="adm-empty">외부 판단 데이터가 없습니다.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
