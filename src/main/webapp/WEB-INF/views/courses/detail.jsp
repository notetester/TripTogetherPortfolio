<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행일정 상세</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Pretendard", "Noto Sans KR", Arial, sans-serif;
            background: #f3f5f9;
            color: #1f2937;
        }

        .page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 56px 32px 80px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 30px;
        }

        .title-wrap h1 {
            margin: 0;
            font-size: 42px;
            font-weight: 800;
            letter-spacing: -0.8px;
            color: #1f2937;
        }

        .title-wrap p {
            margin: 10px 0 0;
            font-size: 16px;
            color: #6b7280;
        }

        .top-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            height: 44px;
            padding: 0 18px;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s ease;
        }

        .btn-primary {
            background: #3366ff;
            color: #fff;
            box-shadow: 0 8px 20px rgba(51, 102, 255, 0.18);
        }

        .btn-primary:hover {
            background: #2557f5;
        }

        .btn-light {
            background: #fff;
            color: #1f2937;
            border: 1px solid #dbe2ea;
        }

        .btn-light:hover {
            background: #f8fafc;
        }

        .btn-danger {
            background: #fff;
            color: #ef4444;
            border: 1px solid #fecaca;
        }

        .btn-danger:hover {
            background: #fff5f5;
        }

        .layout {
            display: grid;
            grid-template-columns: 360px minmax(0, 1fr);
            gap: 24px;
            align-items: start;
        }

        .card {
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.06);
        }

        .summary-card {
            padding: 28px 26px;
            position: sticky;
            top: 24px;
        }

        .summary-head {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 20px;
        }

        .summary-title {
            margin: 0;
            font-size: 32px;
            font-weight: 800;
            line-height: 1.25;
            letter-spacing: -0.6px;
            color: #111827;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 52px;
            height: 30px;
            padding: 0 12px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 700;
            flex-shrink: 0;
        }

        .badge-public {
            background: #dbeafe;
            color: #2563eb;
        }

        .badge-private {
            background: #f3f4f6;
            color: #6b7280;
        }

        .info-list {
            margin-top: 12px;
            border-top: 1px solid #edf1f5;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            padding: 14px 0;
            border-bottom: 1px solid #edf1f5;
            font-size: 15px;
        }

        .info-label {
            color: #6b7280;
            flex-shrink: 0;
        }

        .info-value {
            color: #111827;
            font-weight: 600;
            text-align: right;
            word-break: keep-all;
        }

        .content-card {
            padding: 26px;
        }

        .section-title {
            margin: 0 0 6px;
            font-size: 24px;
            font-weight: 800;
            color: #111827;
            letter-spacing: -0.4px;
        }

        .section-desc {
            margin: 0 0 22px;
            color: #6b7280;
            font-size: 14px;
        }

        .spot-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .spot-item {
            border: 1px solid #e8edf3;
            border-radius: 18px;
            padding: 20px 22px;
            background: #fcfdff;
        }

        .spot-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 14px;
            margin-bottom: 12px;
        }

        .spot-order {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: #eff4ff;
            color: #3366ff;
            font-size: 14px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .spot-title-wrap {
            display: flex;
            gap: 12px;
            align-items: flex-start;
            min-width: 0;
        }

        .spot-name {
            margin: 1px 0 4px;
            font-size: 19px;
            font-weight: 800;
            color: #111827;
            letter-spacing: -0.2px;
        }

        .spot-region {
            font-size: 13px;
            color: #5b7fff;
            font-weight: 700;
        }

        .spot-date {
            flex-shrink: 0;
            display: inline-flex;
            align-items: center;
            height: 32px;
            padding: 0 12px;
            border-radius: 999px;
            background: #f3f6fb;
            color: #475569;
            font-size: 13px;
            font-weight: 700;
        }

        .spot-meta {
            display: grid;
            grid-template-columns: 120px 1fr;
            row-gap: 10px;
            column-gap: 12px;
            margin-top: 10px;
            font-size: 14px;
        }

        .spot-meta-label {
            color: #6b7280;
        }

        .spot-meta-value {
            color: #1f2937;
            font-weight: 600;
        }

        .empty-box {
            border: 1px dashed #d7e0ea;
            border-radius: 18px;
            background: #fafcff;
            padding: 48px 24px;
            text-align: center;
            color: #6b7280;
        }

        .bottom-actions {
            margin-top: 26px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .inline-form {
            margin: 0;
        }

        @media (max-width: 980px) {
            .layout {
                grid-template-columns: 1fr;
            }

            .summary-card {
                position: static;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
            }

            .title-wrap h1 {
                font-size: 34px;
            }
        }

        @media (max-width: 640px) {
            .page {
                padding: 32px 18px 56px;
            }

            .content-card,
            .summary-card {
                padding: 22px 18px;
                border-radius: 20px;
            }

            .summary-title {
                font-size: 26px;
            }

            .spot-top {
                flex-direction: column;
                align-items: flex-start;
            }

            .spot-meta {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="page">

    <div class="top-bar">
        <div class="title-wrap">
            <h1>여행일정 상세</h1>
            <p>선택한 여행일정의 기본 정보와 일정에 포함된 여행지를 확인할 수 있어요.</p>
        </div>

        <div class="top-actions">
            <a href="${pageContext.request.contextPath}/courses/list" class="btn btn-light">목록으로</a>
        </div>
    </div>

    <div class="layout">
        <!-- 왼쪽 요약 카드 -->
        <div class="card summary-card">
            <div class="summary-head">
                <h2 class="summary-title">
                    <c:out value="${travelPlan.title}" />
                </h2>

                <c:choose>
                    <c:when test="${travelPlan.is_public == 1}">
                        <span class="badge badge-public">공개</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-private">비공개</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="info-list">
                <div class="info-row">
                    <div class="info-label">목적지</div>
                    <div class="info-value">
                        <c:out value="${travelPlan.destination}" />
                    </div>
                </div>

                <div class="info-row">
                    <div class="info-label">출발일</div>
                    <div class="info-value">
                        <fmt:formatDate value="${travelPlan.start_date}" pattern="yyyy-MM-dd"/>
                    </div>
                </div>

                <div class="info-row">
                    <div class="info-label">종료일</div>
                    <div class="info-value">
                        <fmt:formatDate value="${travelPlan.end_date}" pattern="yyyy-MM-dd"/>
                    </div>
                </div>

                <div class="info-row">
                    <div class="info-label">일정 번호</div>
                    <div class="info-value">
                        <c:out value="${travelPlan.plan_id}" />
                    </div>
                </div>

                <div class="info-row">
                    <div class="info-label">여행지 개수</div>
                    <div class="info-value">
                        <c:out value="${travelPlan.spotList.size()}" />
                    </div>
                </div>
            </div>

            <div class="bottom-actions">
                <form class="inline-form" method="post"
                      action="${pageContext.request.contextPath}/courses/delete"
                      onsubmit="return confirm('이 일정을 삭제할까요?');">
                    <input type="hidden" name="planId" value="${travelPlan.plan_id}">
                    <button type="submit" class="btn btn-danger">삭제하기</button>
                </form>
            </div>
        </div>

        <!-- 오른쪽 여행지 목록 -->
        <div class="card content-card">
            <h3 class="section-title">일정에 포함된 여행지</h3>
            <p class="section-desc">등록된 여행지를 순서대로 확인할 수 있어요.</p>

            <c:choose>
                <c:when test="${empty travelPlan.spotList}">
                    <div class="empty-box">
                        아직 등록된 여행지가 없어요.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="spot-list">
                        <c:forEach var="spot" items="${travelPlan.spotList}" varStatus="status">
                            <div class="spot-item">
                                <div class="spot-top">
                                    <div class="spot-title-wrap">
                                        <div class="spot-order">
                                            <c:out value="${spot.visit_order}" />
                                        </div>
                                        <div>
                                            <div class="spot-name">
                                                <c:out value="${spot.name}" />
                                            </div>
                                            <div class="spot-region">
                                                <c:out value="${spot.region}" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="spot-date">
                                        <c:choose>
                                            <c:when test="${not empty spot.visit_date}">
                                                <fmt:formatDate value="${spot.visit_date}" pattern="yyyy-MM-dd"/>
                                            </c:when>
                                            <c:otherwise>
                                                날짜 미지정
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="spot-meta">
                                    <div class="spot-meta-label">주소</div>
                                    <div class="spot-meta-value">
                                        <c:out value="${spot.address}" />
                                    </div>

                                    <div class="spot-meta-label">스팟 ID</div>
                                    <div class="spot-meta-value">
                                        <c:out value="${spot.spot_id}" />
                                    </div>

                                    <div class="spot-meta-label">순서</div>
                                    <div class="spot-meta-value">
                                        <c:out value="${spot.visit_order}" />번째
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>
