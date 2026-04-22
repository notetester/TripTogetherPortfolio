<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="ko_KR"/>

<%@ include file="../common/header.jsp" %>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        background: #f8fafc;
        color: #1e293b;
        margin: 0;
        font-family: "Pretendard", "Noto Sans KR", sans-serif;
    }

    .page-wrap {
        max-width: 1200px;
        margin: 0 auto;
        padding: 48px 20px 80px;
    }

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        gap: 20px;
        margin-bottom: 28px;
        flex-wrap: wrap;
    }

    .page-title {
        font-size: 34px;
        font-weight: 800;
        margin: 0 0 10px;
        color: #0f172a;
    }

    .page-desc {
        font-size: 15px;
        color: #64748b;
        margin: 0;
        line-height: 1.6;
    }

    .top-btn-group {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .top-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 13px 20px;
        border-radius: 12px;
        text-decoration: none;
        font-size: 14px;
        font-weight: 700;
        transition: all 0.2s ease;
    }

    .top-btn.primary {
        background: #2563eb;
        color: #fff;
    }

    .top-btn.primary:hover {
        background: #1d4ed8;
    }

    .top-btn.secondary {
        background: #fff;
        color: #2563eb;
        border: 1px solid #bfdbfe;
    }

    .top-btn.secondary:hover {
        background: #eff6ff;
    }

    .message {
        padding: 14px 16px;
        border-radius: 12px;
        margin-bottom: 18px;
        font-size: 14px;
        font-weight: 600;
    }

    .message.success {
        background: #ecfdf5;
        color: #065f46;
        border: 1px solid #a7f3d0;
    }

    .message.error {
        background: #fef2f2;
        color: #b91c1c;
        border: 1px solid #fecaca;
    }

    .plan-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 20px;
    }

    .plan-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 22px;
        padding: 24px;
        box-shadow: 0 8px 24px rgba(15, 23, 42, 0.06);
    }

    .plan-top {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 12px;
        margin-bottom: 16px;
    }

    .plan-name {
        font-size: 22px;
        font-weight: 800;
        margin: 0 0 8px;
        color: #0f172a;
        line-height: 1.4;
    }

    .plan-destination {
        font-size: 14px;
        color: #475569;
        margin: 0;
    }

    .badge-group {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
        justify-content: flex-end;
    }

    .badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 6px 10px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 700;
        white-space: nowrap;
    }

    .badge.public {
        background: #eff6ff;
        color: #1d4ed8;
    }

    .badge.ai {
        background: #ede9fe;
        color: #6d28d9;
    }

    .badge.manual {
        background: #ecfeff;
        color: #0f766e;
    }

    .badge.mine {
        background: #fef3c7;
        color: #92400e;
    }

    .plan-info {
        display: grid;
        gap: 10px;
        margin-bottom: 20px;
    }

    .info-row {
        display: flex;
        justify-content: space-between;
        gap: 12px;
        padding: 12px 14px;
        background: #f8fafc;
        border-radius: 12px;
        font-size: 14px;
    }

    .info-label {
        color: #64748b;
        font-weight: 600;
    }

    .info-value {
        color: #0f172a;
        font-weight: 700;
        text-align: right;
    }

    .card-btn-group {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .card-btn {
        flex: 1;
        min-width: 120px;
        text-align: center;
        padding: 12px 14px;
        border-radius: 12px;
        text-decoration: none;
        font-size: 14px;
        font-weight: 700;
        border: none;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .card-btn.detail {
        background: #2563eb;
        color: #fff;
    }

    .card-btn.detail:hover {
        background: #1d4ed8;
    }

    .card-btn.my {
        background: #fff;
        color: #2563eb;
        border: 1px solid #bfdbfe;
    }

    .card-btn.my:hover {
        background: #eff6ff;
    }

    .empty-box {
        background: #fff;
        border: 1px dashed #cbd5e1;
        border-radius: 22px;
        padding: 56px 24px;
        text-align: center;
    }

    .empty-title {
        font-size: 24px;
        font-weight: 800;
        margin: 0 0 12px;
        color: #0f172a;
    }

    .empty-desc {
        font-size: 15px;
        color: #64748b;
        margin: 0 0 24px;
        line-height: 1.7;
    }

    .empty-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 14px 20px;
        border-radius: 12px;
        background: #2563eb;
        color: #fff;
        text-decoration: none;
        font-size: 14px;
        font-weight: 700;
    }

    .empty-btn:hover {
        background: #1d4ed8;
    }

    .plan-writer {
        font-size: 13px;
        color: #64748b;
        margin: 6px 0 0;
        font-weight: 600;
    }

    .writer-name {
        color: #2563eb;
        font-weight: 800;
    }

    @media (max-width: 900px) {
        .plan-grid {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 600px) {
        .page-wrap {
            padding: 32px 16px 60px;
        }

        .page-title {
            font-size: 28px;
        }

        .plan-card {
            padding: 20px;
        }

        .plan-top {
            flex-direction: column;
        }

        .badge-group {
            justify-content: flex-start;
        }

        .info-row {
            flex-direction: column;
            align-items: flex-start;
        }

        .info-value {
            text-align: left;
        }

        .card-btn-group {
            flex-direction: column;
        }

        .top-btn {
            width: 100%;
        }
    }
</style>

<div class="page-wrap">
    <div class="page-header">
        <div>
            <h1 class="page-title">공개 일정</h1>
            <p class="page-desc">다른 사용자가 공개한 여행일정을 둘러보고 여행 코스를 참고할 수 있어요.</p>
        </div>

        <div class="top-btn-group">
            <a href="${pageContext.request.contextPath}/courses/my" class="top-btn secondary">내 여행일정</a>
            <a href="${pageContext.request.contextPath}/courses/write" class="top-btn primary">직접 일정 생성</a>
        </div>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="message success">${successMessage}</div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="message error">${errorMessage}</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty travelPlanList}">
            <div class="plan-grid">
                <c:forEach var="plan" items="${travelPlanList}">
                    <div class="plan-card">
                        <div class="plan-top">
                            <div>
                                <h2 class="plan-name">${plan.title}</h2>
                                <p class="plan-destination">${empty plan.destination ? '여행지 미입력' : plan.destination}</p>
                                <p class="plan-writer">
                                    <c:choose>
                                        <c:when test="${not empty plan.nickname}">
                                            <span class="writer-name">${plan.nickname}</span>님의 여행 코스
                                        </c:when>
                                        <c:otherwise>
                                            공개 여행 코스
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <div class="badge-group">
                                <span class="badge public">공개</span>

                                <c:choose>
                                    <c:when test="${plan.plan_source eq 'AI'}">
                                        <span class="badge ai">AI</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge manual">직접작성</span>
                                    </c:otherwise>
                                </c:choose>

                                <c:if test="${loginUserIdx eq plan.user_idx}">
                                    <span class="badge mine">내 일정</span>
                                </c:if>
                            </div>
                        </div>

                        <div class="plan-info">
                            <div class="info-row">
                                <span class="info-label">여행 기간</span>
                                <span class="info-value">
                                    <fmt:formatDate value="${plan.start_date}" pattern="yyyy년 M월 d일"/>
                                    ~
                                    <fmt:formatDate value="${plan.end_date}" pattern="yyyy년 M월 d일"/>
                                </span>
                            </div>
                        </div>

                        <div class="card-btn-group">
                            <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}" class="card-btn my">
                                상세보기
                            </a>

                            <c:if test="${loginUserIdx eq plan.user_idx}">
                                <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}" class="card-btn detail">
                                    내 일정 관리
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-box">
                <h2 class="empty-title">아직 공개된 여행일정이 없어요</h2>
                <p class="empty-desc">
                    나중에 다른 사용자의 공개 일정이 등록되면<br>
                    이곳에서 여행 코스를 둘러볼 수 있어요.
                </p>
                <a href="${pageContext.request.contextPath}/courses" class="empty-btn">여행 코스 홈으로</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../common/footer.jsp" %>