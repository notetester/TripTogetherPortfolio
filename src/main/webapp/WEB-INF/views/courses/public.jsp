<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<fmt:setLocale value="${pageContext.response.locale}"/>

<%@ include file="../common/header.jsp" %>

<spring:message code="courses.public.pageTitle" var="coursesPublicPageTitle"/>
<spring:message code="courses.public.pageDesc" var="coursesPublicPageDesc"/>
<spring:message code="courses.public.top.my" var="coursesPublicTopMy"/>
<spring:message code="courses.common.directCreate" var="coursesDirectCreate"/>
<spring:message code="courses.common.destinationMissing" var="coursesDestinationMissing"/>
<spring:message code="courses.common.visibility.public" var="coursesVisibilityPublic"/>
<spring:message code="courses.common.source.ai" var="coursesSourceAi"/>
<spring:message code="courses.common.source.manual" var="coursesSourceManual"/>
<spring:message code="courses.common.detail" var="coursesDetailLabel"/>
<spring:message code="courses.public.action.manageMine" var="coursesManageMine"/>
<spring:message code="courses.public.writer.default" var="coursesPublicWriterDefault"/>
<spring:message code="courses.public.empty.title" var="coursesPublicEmptyTitle"/>
<spring:message code="courses.public.empty.desc" var="coursesPublicEmptyDesc"/>
<spring:message code="courses.public.empty.action" var="coursesPublicEmptyAction"/>
<spring:message code="courses.public.filter.keyword.placeholder" var="coursesPublicFilterKeywordPlaceholder"/>
<spring:message code="courses.public.filter.source.all" var="coursesPublicFilterSourceAll"/>
<spring:message code="courses.public.filter.mine.all" var="coursesPublicFilterMineAll"/>
<spring:message code="courses.public.filter.mine.only" var="coursesPublicFilterMineOnly"/>
<spring:message code="courses.public.filter.search" var="coursesPublicFilterSearch"/>
<spring:message code="courses.public.filter.reset" var="coursesPublicFilterReset"/>
<spring:message code="courses.public.filter.noResult" var="coursesPublicFilterNoResult"/>
<spring:message code="courses.common.field.travelPeriod" var="coursesTravelPeriodLabel"/>
<spring:message code="courses.common.year.all" var="coursesYearAll"/>
<spring:message code="courses.common.year.suffix" var="coursesYearSuffix"/>

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

    .public-filter {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
        align-items: center;
        margin-bottom: 24px;
        padding: 16px;
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        box-shadow: 0 4px 12px rgba(15, 23, 42, 0.04);
    }

    .filter-input,
    .filter-select {
        height: 44px;
        padding: 0 14px;
        border: 1px solid #cbd5e1;
        border-radius: 10px;
        font-size: 14px;
        color: #0f172a;
        background: #fff;
    }

    .filter-input {
        flex: 1;
        min-width: 220px;
    }

    .filter-select {
        min-width: 140px;
    }

    .filter-btn {
        height: 44px;
        padding: 0 16px;
        border: none;
        border-radius: 10px;
        background: #2563eb;
        color: #fff;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
    }

    .filter-btn.reset {
        background: #e2e8f0;
        color: #334155;
    }

    .no-result-box {
        display: none;
        margin-top: 20px;
        padding: 32px 20px;
        border-radius: 16px;
        background: #fff;
        border: 1px dashed #cbd5e1;
        text-align: center;
        color: #64748b;
        font-weight: 600;
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

        .public-filter {
            flex-direction: column;
            align-items: stretch;
        }

        .filter-input,
        .filter-select,
        .filter-btn {
            width: 100%;
        }
    }
</style>

<div class="page-wrap">
    <div class="page-header">
        <div>
            <h1 class="page-title">${coursesPublicPageTitle}</h1>
            <p class="page-desc">${coursesPublicPageDesc}</p>
        </div>

        <div class="top-btn-group">
            <a href="${pageContext.request.contextPath}/courses/my" class="top-btn secondary">${coursesPublicTopMy}</a>
            <a href="${pageContext.request.contextPath}/courses/write" class="top-btn primary">${coursesDirectCreate}</a>
        </div>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="message success">${successMessage}</div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="message error">${errorMessage}</div>
    </c:if>

    <div class="public-filter">
        <input type="text" id="searchKeyword" class="filter-input"
               placeholder="${coursesPublicFilterKeywordPlaceholder}">

        <select id="sourceFilter" class="filter-select">
            <option value="all">${coursesPublicFilterSourceAll}</option>
            <option value="AI">AI</option>
            <option value="MANUAL">${coursesSourceManual}</option>
        </select>

        <select id="mineFilter" class="filter-select">
            <option value="all">${coursesPublicFilterMineAll}</option>
            <option value="mine">${coursesPublicFilterMineOnly}</option>
        </select>

        <select id="yearFilter" class="filter-select">
            <option value="all">${coursesYearAll}</option>
        </select>

        <button type="button" class="filter-btn" onclick="applyPublicFilter()">${coursesPublicFilterSearch}</button>
        <button type="button" class="filter-btn reset" onclick="resetPublicFilter()">${coursesPublicFilterReset}</button>
    </div>

    <c:choose>
        <c:when test="${not empty travelPlanList}">
            <div class="plan-grid">
                <c:forEach var="plan" items="${travelPlanList}">
                    <div class="plan-card"
                         data-title="${plan.title}"
                         data-destination="${empty plan.destination ? '' : plan.destination}"
                         data-writer="${empty plan.nickname ? '' : plan.nickname}"
                         data-source="${plan.plan_source}"
                         data-mine="${loginUserIdx eq plan.user_idx ? 'Y' : 'N'}"
                         data-start-date="<fmt:formatDate value='${plan.start_date}' pattern='yyyy-MM-dd'/>"
                         data-end-date="<fmt:formatDate value='${plan.end_date}' pattern='yyyy-MM-dd'/>">
                        <div class="plan-top">
                            <div>
                                <h2 class="plan-name">${plan.title}</h2>
                                <p class="plan-destination">${empty plan.destination ? coursesDestinationMissing : plan.destination}</p>
                                <p class="plan-writer">
                                    <c:choose>
                                        <c:when test="${not empty plan.nickname}">
                                            <spring:message code="courses.public.writer.mine" arguments="${plan.nickname}"/>
                                        </c:when>
                                        <c:otherwise>
                                            ${coursesPublicWriterDefault}
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <div class="badge-group">
                                <span class="badge public">${coursesVisibilityPublic}</span>

                                <c:choose>
                                    <c:when test="${plan.plan_source eq 'AI'}">
                                        <span class="badge ai">${coursesSourceAi}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge manual">${coursesSourceManual}</span>
                                    </c:otherwise>
                                </c:choose>

                                <c:if test="${loginUserIdx eq plan.user_idx}">
                                    <span class="badge mine"><spring:message code="courses.common.minePlan"/></span>
                                </c:if>
                            </div>
                        </div>

                        <div class="plan-info">
                            <div class="info-row">
                                <span class="info-label">${coursesTravelPeriodLabel}</span>
                                <span class="info-value">
                                    <fmt:formatDate value="${plan.start_date}" type="date" dateStyle="long"/>
                                    ~
                                    <fmt:formatDate value="${plan.end_date}" type="date" dateStyle="long"/>
                                </span>
                            </div>
                        </div>

                        <div class="card-btn-group">
                            <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}" class="card-btn my">
                                ${coursesDetailLabel}
                            </a>

                            <c:if test="${loginUserIdx eq plan.user_idx}">
                                <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.plan_id}" class="card-btn detail">
                                    ${coursesManageMine}
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div id="noResultBox" class="no-result-box">
                ${coursesPublicFilterNoResult}
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-box">
                <h2 class="empty-title">${coursesPublicEmptyTitle}</h2>
                <p class="empty-desc" style="white-space: pre-line;">${coursesPublicEmptyDesc}</p>
                <a href="${pageContext.request.contextPath}/courses" class="empty-btn">${coursesPublicEmptyAction}</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function populateYearFilter() {
        const yearFilter = document.getElementById('yearFilter');
        const cards = document.querySelectorAll('.plan-card');
        const yearSet = new Set();

        yearFilter.innerHTML = '<option value="all">${coursesYearAll}</option>';

        cards.forEach(card => {
            const startDate = card.dataset.startDate || '';
            const endDate = card.dataset.endDate || '';

            const startYear = startDate ? parseInt(startDate.substring(0, 4), 10) : null;
            const endYear = endDate ? parseInt(endDate.substring(0, 4), 10) : null;

            if (startYear !== null && endYear !== null) {
                for (let year = startYear; year <= endYear; year++) {
                    yearSet.add(year);
                }
            } else if (startYear !== null) {
                yearSet.add(startYear);
            } else if (endYear !== null) {
                yearSet.add(endYear);
            }
        });

        Array.from(yearSet)
            .sort((a, b) => a - b)
            .forEach(year => {
                const option = document.createElement('option');
                option.value = String(year);
                option.textContent = year + '${coursesYearSuffix}';
                yearFilter.appendChild(option);
            });
    }

    function applyPublicFilter() {
        const keyword = document.getElementById('searchKeyword').value.trim().toLowerCase();
        const source = document.getElementById('sourceFilter').value;
        const mine = document.getElementById('mineFilter').value;
        const selectedYear = document.getElementById('yearFilter').value;

        const cards = document.querySelectorAll('.plan-card');
        const noResultBox = document.getElementById('noResultBox');

        let visibleCount = 0;

        cards.forEach(card => {
            const title = (card.dataset.title || '').toLowerCase();
            const destination = (card.dataset.destination || '').toLowerCase();
            const writer = (card.dataset.writer || '').toLowerCase();
            const cardSource = card.dataset.source || '';
            const isMine = card.dataset.mine || 'N';

            const startDate = card.dataset.startDate || '';
            const endDate = card.dataset.endDate || '';
            const cardStartYear = startDate ? parseInt(startDate.substring(0, 4), 10) : null;
            const cardEndYear = endDate ? parseInt(endDate.substring(0, 4), 10) : null;

            let matched = true;

            if (keyword) {
                const keywordMatched =
                    title.includes(keyword) ||
                    destination.includes(keyword) ||
                    writer.includes(keyword);

                if (!keywordMatched) {
                    matched = false;
                }
            }

            if (source !== 'all' && cardSource !== source) {
                matched = false;
            }

            if (mine === 'mine' && isMine !== 'Y') {
                matched = false;
            }

            if (selectedYear !== 'all') {
                const year = parseInt(selectedYear, 10);

                if (cardStartYear !== null && cardEndYear !== null) {
                    if (year < cardStartYear || year > cardEndYear) {
                        matched = false;
                    }
                } else if (cardStartYear !== null) {
                    if (year !== cardStartYear) {
                        matched = false;
                    }
                } else if (cardEndYear !== null) {
                    if (year !== cardEndYear) {
                        matched = false;
                    }
                }
            }

            card.style.display = matched ? '' : 'none';

            if (matched) {
                visibleCount++;
            }
        });

        if (noResultBox) {
            noResultBox.style.display = visibleCount === 0 ? 'block' : 'none';
        }
    }

    function resetPublicFilter() {
        document.getElementById('searchKeyword').value = '';
        document.getElementById('sourceFilter').value = 'all';
        document.getElementById('mineFilter').value = 'all';
        document.getElementById('yearFilter').value = 'all';
        applyPublicFilter();
    }

    document.addEventListener('DOMContentLoaded', function () {
        populateYearFilter();

        const searchInput = document.getElementById('searchKeyword');
        const sourceFilter = document.getElementById('sourceFilter');
        const mineFilter = document.getElementById('mineFilter');
        const yearFilter = document.getElementById('yearFilter');

        if (searchInput) {
            searchInput.addEventListener('keyup', function (e) {
                if (e.key === 'Enter') {
                    applyPublicFilter();
                }
            });
        }

        if (sourceFilter) {
            sourceFilter.addEventListener('change', applyPublicFilter);
        }

        if (mineFilter) {
            mineFilter.addEventListener('change', applyPublicFilter);
        }

        if (yearFilter) {
            yearFilter.addEventListener('change', applyPublicFilter);
        }
    });
</script>

<%@ include file="../common/footer.jsp" %>
