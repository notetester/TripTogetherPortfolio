<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="course.confirm.delete" var="courseDeleteConfirm"/>
<spring:message code="course.filter.placeholder" var="courseFilterPlaceholder"/>
<spring:message code="course.common.yearSuffix" javaScriptEscape="true" var="courseYearSuffixJs"/>

<%@ include file="../common/header.jsp" %>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        background: #f5f7fb;
        color: #0f172a;
        font-family: "Pretendard", "Noto Sans KR", sans-serif;
    }

    .courses-page {
        max-width: 1180px;
        margin: 0 auto;
        padding: 48px 20px 80px;
    }

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 20px;
        margin-bottom: 28px;
        flex-wrap: wrap;
    }

    .page-title {
        margin: 0 0 10px;
        font-size: 42px;
        font-weight: 800;
        line-height: 1.2;
        color: #111827;
    }

    .page-desc {
        margin: 0;
        font-size: 16px;
        color: #6b7280;
        line-height: 1.6;
    }

    .create-action-wrap {
        position: relative;
    }

    .create-action-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        border: none;
        border-radius: 16px;
        background: linear-gradient(135deg, #2f6df6 0%, #1e5be0 100%);
        color: #fff;
        font-size: 15px;
        font-weight: 700;
        padding: 14px 20px;
        cursor: pointer;
        box-shadow: 0 10px 24px rgba(47, 109, 246, 0.25);
    }

    .create-action-btn:hover {
        filter: brightness(0.97);
    }

    .create-menu {
        position: absolute;
        top: calc(100% + 10px);
        right: 0;
        min-width: 190px;
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 16px;
        box-shadow: 0 18px 40px rgba(15, 23, 42, 0.12);
        padding: 8px;
        display: none;
        z-index: 20;
    }

    .create-menu.show {
        display: block;
    }

    .create-menu a {
        display: block;
        text-decoration: none;
        color: #111827;
        font-size: 14px;
        font-weight: 600;
        padding: 12px 14px;
        border-radius: 12px;
    }

    .create-menu a:hover {
        background: #f3f4f6;
    }

    .message-box {
        margin-bottom: 18px;
        border-radius: 14px;
        padding: 14px 16px;
        font-size: 14px;
        font-weight: 600;
    }

    .message-box.success {
        background: #ecfdf5;
        color: #065f46;
        border: 1px solid #a7f3d0;
    }

    .message-box.error {
        background: #fef2f2;
        color: #b91c1c;
        border: 1px solid #fecaca;
    }

    .filter-panel {
        background: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 24px;
        padding: 18px 18px 16px;
        box-shadow: 0 10px 28px rgba(15, 23, 42, 0.05);
        margin-bottom: 24px;
    }

    .filter-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 16px;
        margin-bottom: 14px;
        flex-wrap: wrap;
    }

    .source-tabs {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .tab-btn {
        border: 1px solid #e5e7eb;
        background: #f8fafc;
        color: #475569;
        font-size: 14px;
        font-weight: 700;
        border-radius: 999px;
        padding: 10px 16px;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .tab-btn:hover {
        background: #eef2ff;
        color: #1e293b;
    }

    .tab-btn.active {
        background: #0f172a;
        border-color: #0f172a;
        color: #fff;
    }

    .plan-count {
        font-size: 15px;
        color: #374151;
        font-weight: 700;
    }

    .filter-bottom {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 14px;
        flex-wrap: nowrap;
    }

    .filter-select-group {
        display: flex;
        gap: 10px;
        flex-wrap: nowrap;
        flex: 0 0 auto;
    }

    .filter-select {
        width: 170px;
        flex: 0 0 170px;
        height: 42px;
        border: 1px solid #d1d5db;
        border-radius: 12px;
        padding: 0 14px;
        font-size: 14px;
        color: #111827;
        background: #fff;
        outline: none;
    }

    .search-box {
        width: 360px;
        flex: 0 0 360px;
        max-width: 360px;
    }

    .filter-select:focus,
    .search-input:focus {
        border-color: #3b82f6;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
    }


    .search-input {
        width: 100%;
        height: 42px;
        border: 1px solid #d1d5db;
        border-radius: 12px;
        padding: 0 14px;
        font-size: 14px;
        color: #111827;
        background: #fff;
        outline: none;
    }

    .plan-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 20px;
    }

    .plan-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 24px;
        padding: 18px 18px 16px;
        box-shadow: 0 10px 26px rgba(15, 23, 42, 0.04);
        min-height: 220px;
        display: flex;
        flex-direction: column;
    }

    .plan-card.hidden {
        display: none !important;
    }

    .card-top {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 14px;
        margin-bottom: 14px;
    }

    .plan-title {
        margin: 0;
        font-size: 18px;
        font-weight: 800;
        color: #111827;
        line-height: 1.4;
        word-break: keep-all;
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
        background: #f3f4f6;
        color: #6b7280;
        font-size: 20px;
        font-weight: 700;
        line-height: 1;
        cursor: pointer;
    }

    .quick-action-btn:hover {
        background: #e5e7eb;
    }

    .quick-menu {
        position: absolute;
        top: calc(100% + 8px);
        right: 0;
        min-width: 140px;
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        box-shadow: 0 18px 40px rgba(15, 23, 42, 0.12);
        padding: 8px;
        display: none;
        z-index: 15;
    }

    .quick-menu.show {
        display: block;
    }

    .quick-menu a,
    .quick-menu button {
        display: block;
        width: 100%;
        text-align: left;
        border: none;
        background: transparent;
        color: #111827;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        padding: 10px 12px;
        border-radius: 10px;
        cursor: pointer;
    }

    .quick-menu a:hover,
    .quick-menu button:hover {
        background: #f3f4f6;
    }

    .quick-menu button.delete-btn {
        color: #dc2626;
    }

    .quick-menu form {
        margin: 0;
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
        justify-content: center;
        padding: 7px 10px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 700;
        line-height: 1;
    }

    .badge.destination {
        background: #f3f4f6;
        color: #374151;
    }

    .badge.ai {
        background: #ede9fe;
        color: #7c3aed;
    }

    .badge.manual {
        background: #dbeafe;
        color: #2563eb;
    }

    .badge.public {
        background: #dcfce7;
        color: #15803d;
    }

    .badge.private {
        background: #f3f4f6;
        color: #6b7280;
    }

    .plan-date {
        font-size: 16px;
        font-weight: 700;
        color: #1f2937;
        margin-bottom: 10px;
    }

    .plan-summary {
        font-size: 14px;
        color: #6b7280;
        line-height: 1.6;
        margin-bottom: 18px;
    }

    .card-bottom {
        margin-top: auto;
        display: flex;
        justify-content: flex-end;
    }

    .detail-link {
        text-decoration: none;
        color: #2563eb;
        font-size: 15px;
        font-weight: 800;
    }

    .detail-link:hover {
        text-decoration: underline;
    }

    .no-result-box,
    .empty-state {
        background: #fff;
        border: 1px dashed #d1d5db;
        border-radius: 24px;
        text-align: center;
        padding: 56px 20px;
        color: #6b7280;
    }

    .no-result-box {
        display: none;
        margin-top: 10px;
    }

    .empty-state h2,
    .no-result-box h3 {
        margin: 0 0 12px;
        color: #111827;
        font-size: 24px;
        font-weight: 800;
    }

    .empty-state p,
    .no-result-box p {
        margin: 0 0 22px;
        font-size: 15px;
        line-height: 1.7;
    }

    .empty-btn-group {
        display: flex;
        justify-content: center;
        gap: 12px;
        flex-wrap: wrap;
    }

    .empty-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 160px;
        padding: 13px 18px;
        border-radius: 14px;
        text-decoration: none;
        font-size: 14px;
        font-weight: 700;
    }

    .empty-btn.primary {
        background: #2563eb;
        color: #fff;
    }

    .empty-btn.secondary {
        background: #fff;
        color: #2563eb;
        border: 1px solid #bfdbfe;
    }

    @media (max-width: 1024px) {
        .plan-grid {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }
    }
.filter-bottom {
    display: grid;
    grid-template-columns: 530px 360px;
    justify-content: space-between;
    align-items: center;
    gap: 14px;
}

.filter-select-group {
    display: grid;
    grid-template-columns: repeat(3, 170px);
    gap: 10px;
}

.filter-select {
    width: 170px !important;
    min-width: 170px !important;
    max-width: 170px !important;
    height: 42px;
    border: 1px solid #d1d5db;
    border-radius: 12px;
    padding: 0 14px;
    font-size: 14px;
    color: #111827;
    background: #fff;
    outline: none;
    box-sizing: border-box;
    appearance: auto;
    -webkit-appearance: auto;
    -moz-appearance: auto;
}

.search-box {
    width: 360px;
    min-width: 360px;
    max-width: 360px;
}

.search-input {
    width: 100%;
    height: 42px;
    border: 1px solid #d1d5db;
    border-radius: 12px;
    padding: 0 14px;
    font-size: 14px;
    color: #111827;
    background: #fff;
    outline: none;
    box-sizing: border-box;
}

    @media (max-width: 768px) {
        .filter-bottom {
            display: flex;
            flex-direction: column;
            align-items: stretch;
            gap: 14px;
        }

        .filter-select-group {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            width: 100%;
        }

        .filter-select {
            width: 100% !important;
            min-width: 0 !important;
            max-width: none !important;
        }

        .search-box {
            width: 100%;
            min-width: 0;
            max-width: none;
        }
    }

    @media (max-width: 560px) {
        .filter-select-group {
            grid-template-columns: 1fr;
        }

        .create-action-btn {
            width: 100%;
            justify-content: center;
        }
    }

</style>

<div class="courses-page">
    <div class="page-header">
        <div>
            <h1 class="page-title"><spring:message code="course.my.title"/></h1>
            <p class="page-desc"><spring:message code="course.my.desc"/></p>
        </div>

        <div class="create-action-wrap">
            <button type="button" class="create-action-btn" id="createActionBtn">
                + <spring:message code="course.action.create"/> <span>▾</span>
            </button>
            <div class="create-menu" id="createMenu">
                <a href="${pageContext.request.contextPath}/courses/write"><spring:message code="course.action.manualCreate"/></a>
                <a href="${pageContext.request.contextPath}/courses/ai/form"><spring:message code="course.action.aiCreate"/></a>
            </div>
        </div>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="message-box success">${successMessage}</div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="message-box error">${errorMessage}</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty travelPlanList}">
            <div class="filter-panel">
                <div class="filter-top">
                    <div class="source-tabs" id="sourceTabs">
                        <button type="button" class="tab-btn active" data-source="all"><spring:message code="course.filter.all"/></button>
                        <button type="button" class="tab-btn" data-source="MANUAL"><spring:message code="course.badge.manual"/></button>
                        <button type="button" class="tab-btn" data-source="AI"><spring:message code="course.badge.aiRecommend"/></button>
                    </div>

                    <div class="plan-count">
                        <spring:message code="course.filter.totalPrefix"/>
                        <span id="visiblePlanCount">0</span>
                        <spring:message code="course.filter.totalSuffix"/>
                    </div>
                </div>

                <div class="filter-bottom">
                    <div class="filter-select-group">
                        <select id="tripStatusFilter" class="filter-select">
                            <option value="all"><spring:message code="course.filter.allPeriod"/></option>
                            <option value="upcoming"><spring:message code="course.filter.upcoming"/></option>
                            <option value="now"><spring:message code="course.filter.now"/></option>
                            <option value="past"><spring:message code="course.filter.past"/></option>
                        </select>

                        <select id="yearFilter" class="filter-select">
                            <option value="all"><spring:message code="course.filter.allYear"/></option>
                        </select>

                        <select id="visibilityFilter" class="filter-select">
                            <option value="all"><spring:message code="course.filter.status"/></option>
                            <option value="public"><spring:message code="course.badge.public"/></option>
                            <option value="private"><spring:message code="course.badge.private"/></option>
                        </select>
                    </div>

                    <div class="search-box">
                        <input type="text"
                               id="searchInput"
                               class="search-input"
                               placeholder="${courseFilterPlaceholder}">
                    </div>
                </div>
            </div>

            <div class="no-result-box" id="noResultBox">
                <h3><spring:message code="course.filter.noResult.title"/></h3>
                <p><spring:message code="course.filter.noResult.desc"/></p>
            </div>

            <div class="plan-grid" id="planGrid">
                <c:forEach var="plan" items="${travelPlanList}">
                    <c:set var="titleValue" value="${empty plan.title ? '' : plan.title}" />

                    <c:choose>
                        <c:when test="${empty plan.destination}">
                            <spring:message code="course.common.destinationEmpty" var="destinationValue"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="destinationValue" value="${plan.destination}" />
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${empty plan.plan_source}">
                            <c:set var="sourceValue" value="MANUAL" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="sourceValue" value="${fn:toUpperCase(plan.plan_source)}" />
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${plan.is_public == 1}">
                            <c:set var="visibilityValue" value="public" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="visibilityValue" value="private" />
                        </c:otherwise>
                    </c:choose>

                    <c:set var="titleSearchValue" value="${fn:toLowerCase(titleValue)}" />
                    <c:set var="destinationSearchValue" value="${fn:toLowerCase(destinationValue)}" />

                    <fmt:formatDate value="${plan.start_date}" pattern="yyyy" var="startYear"/>
                    <fmt:formatDate value="${plan.start_date}" pattern="yyyyMMdd" var="startDateNumber"/>
                    <fmt:formatDate value="${plan.end_date}" pattern="yyyyMMdd" var="endDateNumber"/>

                    <div class="plan-card plan-item"
                         data-source="${sourceValue}"
                         data-year="${startYear}"
                         data-visibility="${visibilityValue}"
                         data-title="${titleSearchValue}"
                         data-destination="${destinationSearchValue}"
                         data-start="${startDateNumber}"
                         data-end="${endDateNumber}">
                        <div class="card-top">
                            <h2 class="plan-title">${plan.title}</h2>

                            <div class="quick-action-wrap">
                                <button type="button" class="quick-action-btn">⋯</button>
                                <div class="quick-menu">
                                    <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}"><spring:message code="course.action.detail"/></a>
                                    <a href="${pageContext.request.contextPath}/courses/edit?planId=${plan.plan_id}"><spring:message code="course.action.edit"/></a>
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/courses/delete"
                                          class="js-delete-plan-form"
                                          data-confirm="${courseDeleteConfirm}">
                                        <input type="hidden" name="planId" value="${plan.plan_id}">
                                        <button type="submit" class="delete-btn"><spring:message code="course.action.delete"/></button>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="badge-row">
                            <span class="badge destination">${destinationValue}</span>

                            <c:choose>
                                <c:when test="${sourceValue eq 'AI'}">
                                    <span class="badge ai"><spring:message code="course.badge.aiRecommend"/></span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge manual"><spring:message code="course.badge.manual"/></span>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${visibilityValue eq 'public'}">
                                    <span class="badge public"><spring:message code="course.badge.public"/></span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge private"><spring:message code="course.badge.private"/></span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="plan-date">
                            <fmt:formatDate value="${plan.start_date}" pattern="yyyy-MM-dd"/>
                            ~
                            <fmt:formatDate value="${plan.end_date}" pattern="yyyy-MM-dd"/>
                        </div>

                        <div class="plan-summary">
                            <c:choose>
                                <c:when test="${sourceValue eq 'AI'}">
                                    <spring:message code="course.my.summary.ai"/>
                                </c:when>
                                <c:otherwise>
                                    <spring:message code="course.my.summary.manual"/>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="card-bottom">
                            <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}" class="detail-link">
                                <spring:message code="course.action.detail"/> →
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-state">
                <h2><spring:message code="course.my.empty.title"/></h2>
                <p><spring:message code="course.my.empty.desc"/></p>
                <div class="empty-btn-group">
                    <a href="${pageContext.request.contextPath}/courses/write" class="empty-btn primary"><spring:message code="course.action.manualCreate"/></a>
                    <a href="${pageContext.request.contextPath}/courses/ai/form" class="empty-btn secondary"><spring:message code="course.action.aiCreate"/></a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    (function () {
        const createActionBtn = document.getElementById('createActionBtn');
        const createMenu = document.getElementById('createMenu');

        if (createActionBtn && createMenu) {
            createActionBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                createMenu.classList.toggle('show');
            });
        }

        document.addEventListener('click', function (e) {
            if (createMenu && createActionBtn &&
                !createMenu.contains(e.target) &&
                !createActionBtn.contains(e.target)) {
                createMenu.classList.remove('show');
            }

            if (!e.target.closest('.quick-action-wrap')) {
                document.querySelectorAll('.quick-menu').forEach(function (menu) {
                    menu.classList.remove('show');
                });
            }
        });

        document.querySelectorAll('.quick-action-btn').forEach(function (button) {
            button.addEventListener('click', function (e) {
                e.stopPropagation();

                const menu = this.nextElementSibling;
                const isOpen = menu.classList.contains('show');

                document.querySelectorAll('.quick-menu').forEach(function (m) {
                    m.classList.remove('show');
                });

                if (!isOpen) {
                    menu.classList.add('show');
                }
            });
        });

        document.querySelectorAll('.js-delete-plan-form').forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!confirm(this.dataset.confirm || '')) {
                    event.preventDefault();
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
            if (!yearFilter) return;

            const years = new Set();

            planItems.forEach(function (item) {
                if (item.dataset.year) {
                    years.add(item.dataset.year);
                }
            });

            const sortedYears = Array.from(years).sort(function (a, b) {
                return Number(b) - Number(a);
            });

            sortedYears.forEach(function (year) {
                const option = document.createElement('option');
                option.value = year;
                option.textContent = year + '${courseYearSuffixJs}';
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
            if (!planItems.length) {
                if (visiblePlanCount) {
                    visiblePlanCount.textContent = 0;
                }
                return;
            }

            const selectedYear = yearFilter ? yearFilter.value : 'all';
            const selectedVisibility = visibilityFilter ? visibilityFilter.value : 'all';
            const selectedTripStatus = tripStatusFilter ? tripStatusFilter.value : 'all';
            const keyword = searchInput ? searchInput.value.trim().toLowerCase() : '';
            const todayNumber = getTodayNumber();

            let visibleCount = 0;

            planItems.forEach(function (item) {
                const itemSource = (item.dataset.source || 'MANUAL').toUpperCase();
                const itemYear = item.dataset.year || '';
                const itemVisibility = item.dataset.visibility || '';
                const itemTitle = (item.dataset.title || '').toLowerCase();
                const itemDestination = (item.dataset.destination || '').toLowerCase();
                const itemStart = Number(item.dataset.start || 0);
                const itemEnd = Number(item.dataset.end || 0);

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

                if (selectedTripStatus === 'upcoming' && !(itemStart > todayNumber)) {
                    matched = false;
                }

                if (selectedTripStatus === 'now' && !(itemStart <= todayNumber && itemEnd >= todayNumber)) {
                    matched = false;
                }

                if (selectedTripStatus === 'past' && !(itemEnd < todayNumber)) {
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

            if (visiblePlanCount) {
                visiblePlanCount.textContent = visibleCount;
            }

            if (visibleCount === 0) {
                if (noResultBox) noResultBox.style.display = 'block';
                if (planGrid) planGrid.style.display = 'none';
            } else {
                if (noResultBox) noResultBox.style.display = 'none';
                if (planGrid) planGrid.style.display = 'grid';
            }
        }

        tabButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                tabButtons.forEach(function (btn) {
                    btn.classList.remove('active');
                });

                this.classList.add('active');
                selectedSource = this.dataset.source || 'all';
                if (selectedSource !== 'all') {
                    selectedSource = selectedSource.toUpperCase();
                }

                applyFilters();
            });
        });

        if (tripStatusFilter) tripStatusFilter.addEventListener('change', applyFilters);
        if (yearFilter) yearFilter.addEventListener('change', applyFilters);
        if (visibilityFilter) visibilityFilter.addEventListener('change', applyFilters);
        if (searchInput) searchInput.addEventListener('input', applyFilters);

        fillYearOptions();
        applyFilters();
    })();
</script>

<%@ include file="../common/footer.jsp" %>
