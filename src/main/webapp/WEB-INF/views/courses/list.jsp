<%--
  Created by IntelliJ IDEA.
  User: seojin
  Date: 26. 4. 6.
  Time: 오후 5:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 여행일정 목록</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: "Pretendard", "Noto Sans KR", Arial, sans-serif;
            background-color: #f6f8fb;
            color: #222;
        }

        .container {
            width: 1100px;
            max-width: 92%;
            margin: 50px auto;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }

        .page-title {
            margin: 0;
            font-size: 30px;
            font-weight: 700;
            color: #1f2937;
        }

        .page-desc {
            margin-top: 8px;
            color: #6b7280;
            font-size: 15px;
        }

        .write-btn {
            display: inline-block;
            padding: 12px 20px;
            border-radius: 10px;
            background-color: #2563eb;
            color: white;
            text-decoration: none;
            font-size: 15px;
            font-weight: 600;
            transition: 0.2s;
        }

        .write-btn:hover {
            background-color: #1d4ed8;
        }

        .empty-box {
            background: white;
            border-radius: 18px;
            padding: 60px 20px;
            text-align: center;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
        }

        .empty-box h3 {
            margin: 0 0 10px;
            font-size: 22px;
            color: #1f2937;
        }

        .empty-box p {
            margin: 0;
            color: #6b7280;
            font-size: 15px;
        }

        .plan-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .plan-card {
            background: white;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .plan-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 28px rgba(0, 0, 0, 0.10);
        }

        .plan-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 14px;
        }

        .plan-title {
            margin: 0;
            font-size: 20px;
            font-weight: 700;
            line-height: 1.4;
        }

        .plan-title a {
            color: #1f2937;
            text-decoration: none;
        }

        .plan-title a:hover {
            color: #2563eb;
        }

        .badge {
            flex-shrink: 0;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
        }

        .badge.public {
            background-color: #dbeafe;
            color: #1d4ed8;
        }

        .badge.private {
            background-color: #e5e7eb;
            color: #374151;
        }

        .info-list {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .info-list li {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
        }

        .info-list li:last-child {
            border-bottom: none;
        }

        .label {
            color: #6b7280;
            font-weight: 600;
        }

        .value {
            color: #111827;
            text-align: right;
        }

        .bottom-link {
            margin-top: 18px;
            text-align: right;
        }

        .detail-link {
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
            font-weight: 700;
        }

        .detail-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 960px) {
            .plan-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }

            .plan-grid {
                grid-template-columns: 1fr;
            }
        }
        .top-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-bottom: 24px;
        }

        .create-btn,
        .ai-create-btn {
            display: inline-block;
            padding: 14px 22px;
            border-radius: 14px;
            text-decoration: none;
            font-weight: 700;
        }

        .create-btn {
            background-color: #2563eb;
            color: white;
        }

        .ai-create-btn {
            background-color: #0f172a;
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <div>
            <h1 class="page-title">내 여행일정</h1>
            <div class="page-desc">내가 만든 여행일정을 한눈에 확인할 수 있어요.</div>
        </div>

        <%-- 작성 페이지 엔드포인트 만들면 연결 --%>
        <a href="${pageContext.request.contextPath}/courses/write" class="write-btn">
            + 새 일정 만들기
        </a>
        <a href="${pageContext.request.contextPath}/courses/ai/form" class="ai-create-btn">
            AI로 일정 생성하기
        </a>

    </div>

    <c:choose>
        <c:when test="${empty travelPlanList}">
            <div class="empty-box">
                <h3>등록된 여행일정이 없습니다.</h3>
                <p>첫 여행일정을 만들어보세요.</p>
            </div>
        </c:when>

        <c:otherwise>
            <div class="plan-grid">
                <c:forEach var="plan" items="${travelPlanList}">
                    <div class="plan-card">
                        <div class="plan-top">
                            <h2 class="plan-title">
                                <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}">
                                        ${plan.title}
                                </a>
                            </h2>

                            <c:choose>
                                <c:when test="${plan.is_public == 1}">
                                    <span class="badge public">공개</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge private">비공개</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <ul class="info-list">
                            <li>
                                <span class="label">목적지</span>
                                <span class="value">
                                    <c:choose>
                                        <c:when test="${empty plan.destination}">
                                            미정
                                        </c:when>
                                        <c:otherwise>
                                            ${plan.destination}
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </li>

                            <li>
                                <span class="label">출발일</span>
                                <span class="value">
                                    <fmt:formatDate value="${plan.start_date}" pattern="yyyy-MM-dd"/>
                                </span>
                            </li>

                            <li>
                                <span class="label">종료일</span>
                                <span class="value">
                                    <fmt:formatDate value="${plan.end_date}" pattern="yyyy-MM-dd"/>
                                </span>
                            </li>

                            <li>
                                <span class="label">일정 번호</span>
                                <span class="value">${plan.plan_id}</span>
                            </li>
                        </ul>

                        <div class="bottom-link">
                            <a class="detail-link"
                               href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}">
                                상세보기 →
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
