<%--
  Created by IntelliJ IDEA.
  User: seojin
  Date: 26. 4. 6.
  Time: 오후 5:55
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="../common/header.jsp" %>

<!DOCTYPE html>
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

        .course-list-wrap {
            flex: 1;
            min-width: 0;
        }

        .container {
            width: 1180px;
            max-width: 92%;
            margin: 44px auto 70px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 24px;
        }

        .page-title {
            margin: 0;
            font-size: 34px;
            font-weight: 800;
            color: #111827;
            letter-spacing: -0.4px;
        }

        .page-desc {
            margin-top: 10px;
            color: #6b7280;
            font-size: 15px;
        }

        .create-dropdown {
            position: relative;
            flex-shrink: 0;
        }

        .create-btn {
            border: none;
            background: #2563eb;
            color: #fff;
            font-size: 15px;
            font-weight: 700;
            padding: 14px 18px;
            border-radius: 14px;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.18);
            transition: 0.2s ease;
        }

        .create-btn:hover {
            background: #1d4ed8;
        }

        .create-menu {
            position: absolute;
            top: calc(100% + 10px);
            right: 0;
            width: 190px;
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            box-shadow: 0 18px 32px rgba(15, 23, 42, 0.10);
            overflow: hidden;
            display: none;
            z-index: 100;
        }

        .create-menu.show {
            display: block;
        }

        .create-menu a {
            display: block;
            padding: 14px 16px;
            text-decoration: none;
            color: #1f2937;
            font-size: 14px;
            font-weight: 600;
        }

        .create-menu a:hover {
            background: #f8fafc;
        }

        .filter-panel {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 10px 28px rgba(15, 23, 42, 0.05);
            margin-bottom: 22px;
        }

        .filter-top,
        .filter-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 14px;
            flex-wrap: wrap;
        }

        .filter-top {
            margin-bottom: 16px;
        }

        .tab-group {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .tab-btn {
            border: 1px solid #dbe2ea;
            background: #f8fafc;
            color: #475569;
            padding: 10px 14px;
            border-radius: 999px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s ease;
        }

        .tab-btn.active {
            background: #111827;
            color: #fff;
            border-color: #111827;
        }

        .filter-controls {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            align-items: center;
        }

        .filter-select,
        .search-input {
            height: 42px;
            border: 1px solid #dbe2ea;
            border-radius: 12px;
            background: #fff;
            color: #111827;
            font-size: 14px;
            padding: 0 14px;
            outline: none;
        }

        .filter-select:focus,
        .search-input:focus {
            border-color: #93c5fd;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.12);
        }

        .search-input {
            width: 280px;
        }

        .plan-count {
            color: #475569;
            font-size: 14px;
            font-weight: 700;
            white-space: nowrap;
        }

        .plan-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 18px;
        }

        .plan-card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-height: 190px;
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 20px;
            padding: 18px 18px 16px;
            box-shadow: 0 10px 24px rgba(15, 23, 42, 0.05);
            transition: transform 0.18s ease, box-shadow 0.18s ease, border-color 0.18s ease;
        }

        .plan-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 16px 30px rgba(15, 23, 42, 0.10);
            border-color: #dbeafe;
        }

        .plan-card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 12px;
        }

        .plan-title-link {
            flex: 1;
            min-width: 0;
            text-decoration: none;
        }

        .plan-title {
            margin: 0;
            font-size: 20px;
            font-weight: 800;
            line-height: 1.35;
            color: #111827;
            letter-spacing: -0.2px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .plan-title-link:hover .plan-title {
            color: #2563eb;
        }

        .quick-action-wrap {
            position: relative;
            flex-shrink: 0;
        }

        .quick-action-btn {
            width: 34px;
            height: 34px;
            border: none;
            border-radius: 10px;
            background: #f8fafc;
            color: #475569;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
        }

        .quick-action-btn:hover {
            background: #eef2ff;
            color: #1d4ed8;
        }

        .quick-menu {
            position: absolute;
            top: 40px;
            right: 0;
            width: 140px;
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            box-shadow: 0 18px 28px rgba(15, 23, 42, 0.12);
            display: none;
            z-index: 50;
            overflow: hidden;
        }

        .quick-menu.show {
            display: block;
        }

        .quick-menu a,
        .quick-menu button {
            width: 100%;
            display: block;
            border: none;
            background: #fff;
            text-align: left;
            padding: 12px 14px;
            font-size: 13px;
            font-weight: 600;
            color: #1f2937;
            cursor: pointer;
            text-decoration: none;
        }

        .quick-menu a:hover,
        .quick-menu button:hover {
            background: #f8fafc;
        }

        .badge-row {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-bottom: 14px;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            height: 28px;
            padding: 0 11px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: -0.1px;
        }

        .badge.destination {
            background: #f3f4f6;
            color: #374151;
        }

        .badge.source-ai {
            background: #ede9fe;
            color: #6d28d9;
        }

        .badge.source-manual {
            background: #eff6ff;
            color: #1d4ed8;
        }

        .badge.public {
            background: #dcfce7;
            color: #166534;
        }

        .badge.private {
            background: #f1f5f9;
            color: #475569;
        }

        .plan-date {
            margin-top: 2px;
            font-size: 14px;
            font-weight: 700;
            color: #374151;
        }

        .plan-meta {
            margin-top: 8px;
            font-size: 13px;
            color: #6b7280;
        }

        .plan-bottom {
            margin-top: auto;
            padding-top: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .detail-link {
            color: #2563eb;
            text-decoration: none;
            font-size: 14px;
            font-weight: 800;
        }

        .detail-link:hover {
            text-decoration: underline;
        }

        .empty-box {
            background: #fff;
            border-radius: 20px;
            padding: 72px 24px;
            text-align: center;
            border: 1px solid #e5e7eb;
            box-shadow: 0 10px 24px rgba(15, 23, 42, 0.05);
        }

        .empty-box h3 {
            margin: 0 0 10px;
            font-size: 24px;
            font-weight: 800;
            color: #111827;
        }

        .empty-box p {
            margin: 0;
            color: #6b7280;
            font-size: 15px;
            line-height: 1.6;
        }

        .empty-box .empty-action {
            margin-top: 22px;
            display: inline-block;
            padding: 12px 18px;
            border-radius: 12px;
            background: #2563eb;
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            font-weight: 700;
        }

        .no-result {
            display: none;
            margin-top: 18px;
        }

        .hidden {
            display: none !important;
        }

        @media (max-width: 1100px) {
            .plan-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .filter-top,
            .filter-bottom {
                flex-direction: column;
                align-items: stretch;
            }

            .filter-controls {
                width: 100%;
            }

            .filter-select,
            .search-input {
                width: 100%;
            }

            .plan-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="course-list-wrap">
    <div class="container">
        <div class="page-header">
            <div>
                <h1 class="page-title">내 여행일정</h1>
                <div class="page-desc">내가 만든 여행일정을 한눈에 확인하고 관리할 수 있어요.</div>
            </div>

            <div class="create-dropdown">
                <button type="button" class="create-btn" id="createMenuButton">+ 일정 만들기 ▾</button>
                <div class="create-menu" id="createMenu">
                    <a href="${pageContext.request.contextPath}/courses/write">직접 만들기</a>
                    <a href="${pageContext.request.contextPath}/courses/ai/form">AI로 생성하기</a>
                </div>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty travelPlanList}">
                <div class="empty-box">
                    <h3>아직 만든 여행일정이 없어요.</h3>
                    <p>직접 일정을 만들거나 AI 추천 일정을 생성해보세요.</p>
                    <a href="${pageContext.request.contextPath}/courses/write" class="empty-action">+ 일정 만들기</a>
                </div>
            </c:when>

            <c:otherwise>
                <div class="filter-panel">
                    <div class="filter-top">
                        <div class="tab-group" id="sourceTabs">
                            <button type="button" class="tab-btn active" data-source="all">전체</button>
                            <button type="button" class="tab-btn" data-source="MANUAL">직접 작성</button>
                            <button type="button" class="tab-btn" data-source="AI">AI 추천</button>
                        </div>

                        <div class="plan-count">
                            총 <span id="visiblePlanCount">0</span>개 일정
                        </div>
                    </div>

                    <div class="filter-bottom">
                        <div class="filter-controls">
                            <select id="tripStatusFilter" class="filter-select">
                                <option value="all">전체 기간</option>
                                <option value="upcoming">예정된 여행</option>
                                <option value="now">진행중인 여행</option>
                                <option value="past">지난 여행</option>
                            </select>

                            <select id="yearFilter" class="filter-select">
                                <option value="all">전체 연도</option>
                            </select>

                            <select id="visibilityFilter" class="filter-select">
                                <option value="all">공개상태</option>
                                <option value="public">공개</option>
                                <option value="private">비공개</option>
                            </select>
                        </div>

                        <div class="filter-controls">
                            <input type="text" id="searchInput" class="search-input" placeholder="제목 또는 목적지 검색"/>
                        </div>
                    </div>
                </div>

                <div class="plan-grid" id="planGrid">
                    <c:forEach var="plan" items="${travelPlanList}">
                        <fmt:formatDate value="${plan.start_date}" pattern="yyyy-MM-dd" var="startDateText"/>
                        <fmt:formatDate value="${plan.end_date}" pattern="yyyy-MM-dd" var="endDateText"/>
                        <fmt:formatDate value="${plan.start_date}" pattern="yyyy" var="startYear"/>
                        <fmt:formatDate value="${plan.start_date}" pattern="yyyyMMdd" var="startDateNumber"/>
                        <fmt:formatDate value="${plan.end_date}" pattern="yyyyMMdd" var="endDateNumber"/>

                        <c:set var="sourceValue" value="${empty plan.plan_source ? 'manual' : plan.plan_source}"/>
                        <c:set var="destinationValue" value="${empty plan.destination ? '미정' : plan.destination}"/>
                        <c:set var="publicValue" value="${plan.is_public == 1 ? 'public' : 'private'}"/>

                        <div class="plan-card plan-item"
                             data-source="${sourceValue}"
                             data-year="${startYear}"
                             data-visibility="${publicValue}"
                             data-title="${fn:toLowerCase(plan.title)}"
                             data-destination="${fn:toLowerCase(destinationValue)}"
                             data-start="${startDateNumber}"
                             data-end="${endDateNumber}">

                            <div class="plan-card-top">
                                <a class="plan-title-link"
                                   href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}">
                                    <h2 class="plan-title">${plan.title}</h2>
                                </a>

                                <div class="quick-action-wrap">
                                    <button type="button" class="quick-action-btn">⋯</button>
                                    <div class="quick-menu">
                                        <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}">상세보기</a>
                                        <a href="${pageContext.request.contextPath}/courses/edit?planId=${plan.plan_id}">수정하기</a>
                                        <button type="button">삭제하기</button>
                                    </div>
                                </div>
                            </div>

                            <div class="badge-row">
                                <span class="badge destination">${destinationValue}</span>

                                <c:choose>
                                    <c:when test="${sourceValue eq 'AI'}">
                                        <span class="badge source-ai">AI 추천</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge source-manual">직접 작성</span>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${plan.is_public == 1}">
                                        <span class="badge public">공개</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge private">비공개</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="plan-date">${startDateText} - ${endDateText}</div>
                            <div class="plan-meta">
                                <c:choose>
                                    <c:when test="${sourceValue eq 'AI'}">
                                        AI 추천으로 생성된 일정
                                    </c:when>
                                    <c:otherwise>
                                        직접 작성한 일정
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="plan-bottom">
                                <span></span>
                                <a class="detail-link"
                                   href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}">
                                    상세보기 →
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="empty-box no-result" id="noResultBox">
                    <h3>조건에 맞는 일정이 없습니다.</h3>
                    <p>필터를 바꾸거나 새로운 여행 일정을 만들어보세요.</p>
                    <a href="${pageContext.request.contextPath}/courses/write" class="empty-action">+ 일정 만들기</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    (function () {
        const createMenuButton = document.getElementById('createMenuButton');
        const createMenu = document.getElementById('createMenu');

        if (createMenuButton && createMenu) {
            createMenuButton.addEventListener('click', function (e) {
                e.stopPropagation();
                createMenu.classList.toggle('show');
            });
        }

        document.addEventListener('click', function () {
            if (createMenu) {
                createMenu.classList.remove('show');
            }

            document.querySelectorAll('.quick-menu').forEach(function (menu) {
                menu.classList.remove('show');
            });
        });

        document.querySelectorAll('.quick-action-btn').forEach(function (button) {
            button.addEventListener('click', function (e) {
                e.stopPropagation();
                const menu = this.nextElementSibling;
                const isOpen = menu.classList.contains('show');

                document.querySelectorAll('.quick-menu').forEach(function (menu) {
                    document.addEventListener('click', function (e) {
                        if (!e.target.closest('.quick-action-wrap')) {
                            document.querySelectorAll('.quick-menu').forEach(function (menu) {
                                menu.classList.remove('show');
                            });
                        }

                        if (createMenu && !e.target.closest('.create-dropdown')) {
                            createMenu.classList.remove('show');
                        }
                    });
                });

                document.querySelectorAll('.quick-menu').forEach(function (m) {
                    m.classList.remove('show');
                });

                if (!isOpen) {
                    menu.classList.add('show');
                }
            });
        });

        const tabButtons = document.querySelectorAll('#sourceTabs .tab-btn');
        const tripStatusFilter = document.getElementById('tripStatusFilter');
        const yearFilter = document.getElementById('yearFilter');
        const visibilityFilter = document.getElementById('visibilityFilter');
        const searchInput = document.getElementById('searchInput');
        const planItems = document.querySelectorAll('.plan-item');
        const visiblePlanCount = document.getElementById('visiblePlanCount');
        const noResultBox = document.getElementById('noResultBox');
        const planGrid = document.getElementById('planGrid');

        let selectedSource = 'all';

        function fillYearOptions() {
            const years = new Set();

            planItems.forEach(function (item) {
                years.add(item.dataset.year);
            });

            const sortedYears = Array.from(years).sort(function (a, b) {
                return Number(b) - Number(a);
            });

            sortedYears.forEach(function (year) {
                const option = document.createElement('option');
                option.value = year;
                option.textContent = year + '년';
                yearFilter.appendChild(option);
            });
        }

        function getTodayNumber() {
            const now = new Date();
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0');
            const date = String(now.getDate()).padStart(2, '0');
            return Number('' + year + month + date);
        }

        function applyFilters() {
            const selectedYear = yearFilter.value;
            const selectedVisibility = visibilityFilter.value;
            const selectedTripStatus = tripStatusFilter.value;
            const keyword = searchInput.value.trim().toLowerCase();
            const todayNumber = getTodayNumber();

            let visibleCount = 0;

            planItems.forEach(function (item) {
                const itemSource = item.dataset.source || 'MANUAL';
                const itemYear = item.dataset.year;
                const itemVisibility = item.dataset.visibility;
                const itemTitle = item.dataset.title || '';
                const itemDestination = item.dataset.destination || '';
                const itemStart = Number(item.dataset.start);
                const itemEnd = Number(item.dataset.end);

                let matched = true;

                if (selectedSource !== 'all' && itemSource !== selectedSource) {
                    matched = false;
                }

                if (selectedYear !== 'all' && itemYear !== selectedYear) {
                    matched = false;
                }

                if (selectedVisibility !== 'all' && itemVisibility !== selectedVisibility) {
                    matched = false;
                }

                if (selectedTripStatus === 'upcoming' && itemStart <= todayNumber) {
                    matched = false;
                }

                if (selectedTripStatus === 'now' && !(itemStart <= todayNumber && itemEnd >= todayNumber)) {
                    matched = false;
                }

                if (selectedTripStatus === 'past' && itemEnd >= todayNumber) {
                    matched = false;
                }

                if (keyword && !(itemTitle.includes(keyword) || itemDestination.includes(keyword))) {
                    matched = false;
                }

                if (matched) {
                    item.classList.remove('hidden');
                    visibleCount++;
                } else {
                    item.classList.add('hidden');
                }
            });

            visiblePlanCount.textContent = visibleCount;

            if (visibleCount === 0) {
                noResultBox.style.display = 'block';
                if (planGrid) {
                    planGrid.style.display = 'none';
                }
            } else {
                noResultBox.style.display = 'none';
                if (planGrid) {
                    planGrid.style.display = 'grid';
                }
            }
        }

        tabButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                tabButtons.forEach(function (btn) {
                    btn.classList.remove('active');
                });

                this.classList.add('active');
                selectedSource = this.dataset.source;
                applyFilters();
            });
        });

        [tripStatusFilter, yearFilter, visibilityFilter].forEach(function (element) {
            element.addEventListener('change', applyFilters);
        });

        searchInput.addEventListener('input', applyFilters);

        if (yearFilter) {
            fillYearOptions();
        }

        applyFilters();
    })();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>