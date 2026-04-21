<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="../common/header.jsp" %>

<c:set var="planSourceValue" value="${empty travelPlan.plan_source ? 'manual' : travelPlan.plan_source}" />
<fmt:formatDate value="${travelPlan.start_date}" pattern="yyyy-MM-dd" var="startDateFormatted"/>
<fmt:formatDate value="${travelPlan.end_date}" pattern="yyyy-MM-dd" var="endDateFormatted"/>

<style>
    .course-edit-page {
        background: #f6f8fc;
        min-height: calc(100vh - 80px);
        padding: 40px 0 80px;
    }

    .page-inner {
        max-width: 1280px;
        margin: 0 auto;
        padding: 0 24px;
    }

    .back-link {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 14px;
        color: #667085;
        text-decoration: none;
        margin-bottom: 20px;
    }

    .back-link:hover {
        color: #3b82f6;
    }

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 20px;
        margin-bottom: 28px;
    }

    .page-title {
        margin: 0 0 8px;
        font-size: 52px;
        line-height: 1.08;
        font-weight: 800;
        color: #14213d;
        letter-spacing: -0.03em;
    }

    .page-desc {
        margin: 0;
        font-size: 18px;
        color: #7a8699;
        line-height: 1.6;
    }

    .status-chip {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 10px 18px;
        border-radius: 999px;
        background: #ffffff;
        border: 1px solid #e6ebf5;
        box-shadow: 0 8px 24px rgba(20, 33, 61, 0.06);
        color: #344054;
        font-size: 15px;
        font-weight: 700;
        white-space: nowrap;
    }

    .edit-layout {
        display: grid;
        grid-template-columns: minmax(0, 1fr) 380px;
        gap: 28px;
        align-items: start;
    }

    .edit-main,
    .edit-side {
        display: flex;
        flex-direction: column;
        gap: 24px;
    }

    .card {
        background: #fff;
        border: 1px solid #e9eef7;
        border-radius: 28px;
        box-shadow: 0 12px 40px rgba(15, 23, 42, 0.06);
        overflow: hidden;
    }

    .content-card .card-head {
        display: flex;
        flex-direction: column;
        gap: 6px;
        padding: 28px 30px;
        border-bottom: 1px solid #eef2f8;
        background: linear-gradient(180deg, #ffffff 0%, #fbfcff 100%);
    }

    .content-card .card-head h2 {
        margin: 0;
        font-size: 20px;
        font-weight: 800;
        color: #1f2a44;
        letter-spacing: -0.02em;
    }

    .content-card .card-head p {
        margin: 0;
        font-size: 15px;
        color: #8b95a7;
        line-height: 1.6;
    }

    .card-body {
        padding: 28px 30px 30px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .form-row {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 18px;
    }

    .form-label {
        font-size: 16px;
        font-weight: 800;
        color: #1f2a44;
        letter-spacing: -0.02em;
    }

    .form-input {
        width: 100%;
        height: 60px;
        padding: 0 18px;
        border-radius: 20px;
        border: 1px solid #dbe3f0;
        background: #fff;
        font-size: 18px;
        color: #1f2a44;
        transition: border-color .2s ease, box-shadow .2s ease, background .2s ease;
        box-sizing: border-box;
    }

    .form-input:focus {
        outline: none;
        border-color: #6c7cff;
        box-shadow: 0 0 0 4px rgba(108, 124, 255, 0.12);
        background: #fff;
    }

    .field-msg {
        font-size: 14px;
        color: #7c8799;
        line-height: 1.7;
    }

    .spot-filter-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 16px;
        margin-bottom: 18px;
        padding: 14px 16px;
        border: 1px solid #e7ecf5;
        border-radius: 18px;
        background: #f9fbff;
    }

    .spot-filter-left {
        display: flex;
        align-items: center;
        gap: 10px;
        flex-wrap: wrap;
    }

    .spot-filter-label {
        font-size: 15px;
        font-weight: 700;
        color: #344054;
    }

    .spot-filter-input {
        height: 42px;
        padding: 0 12px;
        border: 1px solid #dbe3f0;
        border-radius: 14px;
        background: #fff;
        font-size: 15px;
        color: #1f2a44;
    }

    .spot-filter-reset {
        height: 42px;
        padding: 0 16px;
        border: 1px solid #d7dfec;
        border-radius: 14px;
        background: #fff;
        color: #344054;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
        transition: all .2s ease;
    }

    .spot-filter-reset:hover {
        background: #f3f6ff;
        border-color: #c9d5e8;
    }

    .spot-filter-right {
        font-size: 14px;
        color: #667085;
        font-weight: 600;
    }

    .spot-list {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .spot-item {
        border: 1px solid #e7ecf5;
        border-radius: 28px;
        padding: 28px;
        background: #fff;
        box-shadow: inset 0 0 0 1px rgba(255,255,255,0.2);
    }

    .spot-item.is-hidden-by-filter {
        display: none;
    }

    .spot-head {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 24px;
        gap: 20px;
    }

    .spot-head-left {
        display: flex;
        align-items: center;
        gap: 14px;
        font-size: 18px;
        font-weight: 800;
        color: #1f2a44;
    }

    .spot-badge {
        width: 44px;
        height: 44px;
        border-radius: 50%;
        background: linear-gradient(135deg, #5378ff 0%, #6d4bff 100%);
        color: #fff;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-weight: 800;
        box-shadow: 0 10px 20px rgba(83, 120, 255, 0.24);
        flex-shrink: 0;
    }

    .remove-btn {
        height: 54px;
        min-width: 92px;
        padding: 0 24px;
        border-radius: 20px;
        border: 1px solid #ffc7c7;
        background: #fff;
        color: #ff4d4f;
        font-size: 17px;
        font-weight: 800;
        cursor: pointer;
        transition: all .2s ease;
    }

    .remove-btn:hover {
        background: #fff5f5;
        border-color: #ff9e9f;
    }

    .toggle-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
    }

    .switch {
        position: relative;
        display: inline-block;
        width: 64px;
        height: 38px;
        flex-shrink: 0;
    }

    .switch input {
        opacity: 0;
        width: 0;
        height: 0;
    }

    .slider {
        position: absolute;
        inset: 0;
        cursor: pointer;
        background: #cfd8e6;
        border-radius: 999px;
        transition: .2s;
    }

    .slider:before {
        content: "";
        position: absolute;
        width: 30px;
        height: 30px;
        left: 4px;
        top: 4px;
        background: #fff;
        border-radius: 50%;
        transition: .2s;
        box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    }

    .switch input:checked + .slider {
        background: linear-gradient(135deg, #5378ff 0%, #6d4bff 100%);
    }

    .switch input:checked + .slider:before {
        transform: translateX(26px);
    }

    .summary-box {
        background: linear-gradient(180deg, #f7f9ff 0%, #f3f6fd 100%);
        border: 1px solid #e5ebf7;
        border-radius: 24px;
        padding: 22px 22px 18px;
    }

    .summary-row {
        display: flex;
        justify-content: space-between;
        gap: 16px;
        padding: 10px 0;
        border-bottom: 1px solid rgba(160, 174, 197, 0.18);
        font-size: 16px;
        color: #667085;
    }

    .summary-row:last-child {
        border-bottom: none;
    }

    .summary-row strong {
        color: #1f2a44;
        font-weight: 800;
        text-align: right;
    }

    .form-actions {
        display: flex;
        justify-content: flex-end;
        gap: 12px;
        flex-wrap: wrap;
    }

    .primary-btn,
    .secondary-btn {
        height: 58px;
        padding: 0 28px;
        border-radius: 20px;
        font-size: 18px;
        font-weight: 800;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all .2s ease;
        box-sizing: border-box;
    }

    .primary-btn {
        border: none;
        color: #fff;
        background: linear-gradient(135deg, #5378ff 0%, #6d4bff 100%);
        box-shadow: 0 14px 30px rgba(84, 110, 255, 0.22);
    }

    .primary-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 18px 34px rgba(84, 110, 255, 0.26);
    }

    .secondary-btn {
        border: 1px solid #d7dfec;
        color: #344054;
        background: #fff;
    }

    .secondary-btn:hover {
        background: #f8faff;
        border-color: #c9d5e8;
    }

    @media (max-width: 1080px) {
        .edit-layout {
            grid-template-columns: 1fr;
        }

        .page-title {
            font-size: 40px;
        }
    }

    @media (max-width: 768px) {
        .course-edit-page {
            padding: 24px 0 48px;
        }

        .page-inner {
            padding: 0 16px;
        }

        .page-header {
            flex-direction: column;
            align-items: stretch;
        }

        .page-title {
            font-size: 34px;
        }

        .form-row {
            grid-template-columns: 1fr;
        }

        .spot-head {
            flex-direction: column;
            align-items: stretch;
        }

        .remove-btn,
        .primary-btn,
        .secondary-btn {
            width: 100%;
        }

        .toggle-row {
            flex-direction: column;
            align-items: flex-start;
        }

        .spot-filter-bar {
            flex-direction: column;
            align-items: stretch;
        }

        .spot-filter-right {
            text-align: left;
        }
    }
</style>

<main class="course-edit-page">
    <div class="page-inner">
        <a href="${pageContext.request.contextPath}/courses/detail?planId=${travelPlan.plan_id}" class="back-link">
            ← 상세로 돌아가기
        </a>

        <div class="page-header">
            <div>
                <h1 class="page-title">여행 일정 수정</h1>
                <p class="page-desc">기본 정보와 방문 여행지를 수정한 뒤 저장할 수 있어요.</p>
            </div>
            <div class="status-chip">수정 중</div>
        </div>

        <form id="travelPlanForm" action="${pageContext.request.contextPath}/courses/edit" method="post">
            <input type="hidden" name="plan_id" value="${travelPlan.plan_id}">
            <input type="hidden" name="plan_source" value="${planSourceValue}">
            <input type="hidden" id="isPublic" name="is_public" value="${travelPlan.is_public}">

            <div class="edit-layout">
                <div class="edit-main">
                    <section class="card content-card">
                        <div class="card-head">
                            <h2>기본 정보</h2>
                            <p>일정 제목, 대표 목적지, 기간을 수정해 주세요.</p>
                        </div>

                        <div class="card-body">
                            <div class="form-group">
                                <label class="form-label" for="title">일정 제목</label>
                                <input type="text"
                                       id="title"
                                       name="title"
                                       class="form-input"
                                       value="${travelPlan.title}"
                                       required>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="destination">대표 목적지</label>
                                <input type="text"
                                       id="destination"
                                       name="destination"
                                       class="form-input"
                                       value="${travelPlan.destination}"
                                       autocomplete="off"
                                       required>
                                <div class="field-msg">
                                    대표 목적지는 자유롭게 입력할 수 있어요.
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label" for="startDate">시작일</label>
                                    <input type="date"
                                           id="startDate"
                                           name="start_date"
                                           class="form-input"
                                           value="${startDateFormatted}"
                                           required>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="endDate">종료일</label>
                                    <input type="date"
                                           id="endDate"
                                           name="end_date"
                                           class="form-input"
                                           value="${endDateFormatted}"
                                           required>
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="card content-card">
                        <div class="card-head">
                            <h2>방문 여행지</h2>
                            <p>기존 항목을 수정·삭제하고, 새 항목도 추가할 수 있어요.</p>
                        </div>

                        <div class="card-body">
                            <div class="field-msg" style="margin-bottom:16px;">
                                각 여행지는 장소명 + 방문일 + 방문 순서 기준으로 저장돼요.
                            </div>

                            <div class="spot-filter-bar">
                                <div class="spot-filter-left">
                                    <label for="spotDateFilter" class="spot-filter-label">날짜 선택</label>
                                    <input type="date" id="spotDateFilter" class="spot-filter-input">
                                    <button type="button" id="resetSpotFilterBtn" class="spot-filter-reset">전체보기</button>
                                </div>
                                <div class="spot-filter-right" id="spotFilterResultText">전체 여행지 표시 중</div>
                            </div>

                            <div id="spotList" class="spot-list">
                                <c:forEach var="spot" items="${travelPlan.spotList}" varStatus="s">
                                    <fmt:formatDate value="${spot.visit_date}" pattern="yyyy-MM-dd" var="spotVisitDate"/>

                                    <div class="spot-item" data-visit-date="${spotVisitDate}">
                                        <div class="spot-head">
                                            <div class="spot-head-left">
                                                <span class="spot-badge">${s.index + 1}</span>
                                                <span>여행지 ${s.index + 1}</span>
                                            </div>
                                            <button type="button" class="remove-btn">삭제</button>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">장소명</label>
                                            <input type="text"
                                                   class="form-input"
                                                   data-field="place_name"
                                                   name="spotList[${s.index}].place_name"
                                                   value="${spot.place_name}"
                                                   required>
                                            <div class="field-msg">사용자가 직접 입력한 실제 방문 장소명이 저장돼요.</div>
                                        </div>

                                        <div class="form-row" style="margin-top:16px;">
                                            <div class="form-group">
                                                <label class="form-label">방문일</label>
                                                <input type="date"
                                                       class="form-input"
                                                       data-field="visit_date"
                                                       name="spotList[${s.index}].visit_date"
                                                       value="${spotVisitDate}"
                                                       required>
                                            </div>

                                            <div class="form-group">
                                                <label class="form-label">방문 순서</label>
                                                <input type="number"
                                                       class="form-input"
                                                       data-field="visit_order"
                                                       name="spotList[${s.index}].visit_order"
                                                       value="${spot.visit_order}"
                                                       min="1"
                                                       required>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <button type="button" id="addSpotBtn" class="secondary-btn" style="margin-top:16px;">
                                + 여행지 추가
                            </button>
                        </div>
                    </section>
                </div>

                <aside class="edit-side">
                    <section class="card content-card">
                        <div class="card-head">
                            <h2>공개 설정</h2>
                            <p>일정 공개 여부를 설정할 수 있어요.</p>
                        </div>

                        <div class="card-body">
                            <div class="toggle-row">
                                <div>
                                    <div class="form-label" style="margin-bottom:6px;">일정 공개</div>
                                    <div class="field-msg">공개로 설정하면 다른 사용자에게 공유할 수 있어요.</div>
                                </div>

                                <label class="switch">
                                    <input type="checkbox" id="isPublicToggle" ${travelPlan.is_public == 1 ? 'checked' : ''}>
                                    <span class="slider"></span>
                                </label>
                            </div>
                        </div>
                    </section>

                    <section class="card content-card">
                        <div class="card-head">
                            <h2>입력 요약</h2>
                            <p>현재 입력 내용을 간단히 확인할 수 있어요.</p>
                        </div>

                        <div class="card-body">
                            <div class="summary-box">
                                <div class="summary-row">
                                    <span>일정 제목</span>
                                    <strong id="summaryTitle">${travelPlan.title}</strong>
                                </div>
                                <div class="summary-row">
                                    <span>대표 목적지</span>
                                    <strong id="summaryDestination">${travelPlan.destination}</strong>
                                </div>
                                <div class="summary-row">
                                    <span>여행 기간</span>
                                    <strong id="summaryPeriod">${startDateFormatted} ~ ${endDateFormatted}</strong>
                                </div>
                                <div class="summary-row">
                                    <span>여행지 개수</span>
                                    <strong id="summaryCount"><c:out value="${fn:length(travelPlan.spotList)}"/>개</strong>
                                </div>
                                <div class="summary-row">
                                    <span>공개 여부</span>
                                    <strong id="summaryPublic">${travelPlan.is_public == 1 ? '공개' : '비공개'}</strong>
                                </div>
                            </div>

                            <div class="form-actions" style="margin-top:24px;">
                                <a href="${pageContext.request.contextPath}/courses/detail?planId=${travelPlan.plan_id}"
                                   class="secondary-btn">취소</a>
                                <button type="submit" class="primary-btn">수정 완료하기</button>
                            </div>
                        </div>
                    </section>
                </aside>
            </div>
        </form>
    </div>
</main>

<script>
    const formEl = document.getElementById("travelPlanForm");
    const titleEl = document.getElementById("title");
    const destinationEl = document.getElementById("destination");
    const startDateEl = document.getElementById("startDate");
    const endDateEl = document.getElementById("endDate");
    const isPublicEl = document.getElementById("isPublic");
    const isPublicToggleEl = document.getElementById("isPublicToggle");
    const spotListEl = document.getElementById("spotList");
    const addSpotBtn = document.getElementById("addSpotBtn");
    const spotDateFilterEl = document.getElementById("spotDateFilter");
    const resetSpotFilterBtn = document.getElementById("resetSpotFilterBtn");
    const spotFilterResultTextEl = document.getElementById("spotFilterResultText");

    const summaryTitleEl = document.getElementById("summaryTitle");
    const summaryDestinationEl = document.getElementById("summaryDestination");
    const summaryPeriodEl = document.getElementById("summaryPeriod");
    const summaryCountEl = document.getElementById("summaryCount");
    const summaryPublicEl = document.getElementById("summaryPublic");


    function refreshSpotIndexes() {
        const items = spotListEl.querySelectorAll(".spot-item");

        items.forEach(function (item, index) {
            const badge = item.querySelector(".spot-badge");
            const title = item.querySelector(".spot-head-left span:last-child");

            const placeInput = item.querySelector('[data-field="place_name"]');
            const visitDateInput = item.querySelector('[data-field="visit_date"]');
            const visitOrderInput = item.querySelector('[data-field="visit_order"]');

            if (badge) badge.textContent = index + 1;
            if (title) title.textContent = "여행지 " + (index + 1);

            if (placeInput) placeInput.name = "spotList[" + index + "].place_name";
            if (visitDateInput) visitDateInput.name = "spotList[" + index + "].visit_date";
            if (visitOrderInput) visitOrderInput.name = "spotList[" + index + "].visit_order";
        });
    }

    function syncSpotItemDates() {
        const items = spotListEl.querySelectorAll(".spot-item");
        items.forEach(function (item) {
            const visitDateInput = item.querySelector('[data-field="visit_date"]');
            if (visitDateInput) {
                item.setAttribute("data-visit-date", visitDateInput.value || "");
            }
        });
    }

    function updateSpotFilter() {
        if (!spotListEl) return;

        syncSpotItemDates();

        const selectedDate = spotDateFilterEl ? spotDateFilterEl.value : "";
        const items = spotListEl.querySelectorAll(".spot-item");

        let visibleCount = 0;

        items.forEach(function (item) {
            const itemDate = item.getAttribute("data-visit-date") || "";

            if (!selectedDate || selectedDate === itemDate) {
                item.classList.remove("is-hidden-by-filter");
                visibleCount++;
            } else {
                item.classList.add("is-hidden-by-filter");
            }
        });

        if (spotFilterResultTextEl) {
            if (!selectedDate) {
                spotFilterResultTextEl.textContent = "전체 여행지 표시 중";
            } else {
                spotFilterResultTextEl.textContent = selectedDate + " · " + visibleCount + "개 표시 중";
            }
        }
    }

    function updateSummary() {
        if (summaryTitleEl) {
            summaryTitleEl.textContent = titleEl.value.trim() || "미입력";
        }

        if (summaryDestinationEl) {
            summaryDestinationEl.textContent = destinationEl.value.trim() || "미입력";
        }

        if (summaryPeriodEl) {
            if (startDateEl.value && endDateEl.value) {
                summaryPeriodEl.textContent = startDateEl.value + " ~ " + endDateEl.value;
            } else {
                summaryPeriodEl.textContent = "미입력";
            }
        }

        if (summaryCountEl) {
            summaryCountEl.textContent = spotListEl.querySelectorAll(".spot-item").length + "개";
        }

        if (summaryPublicEl) {
            summaryPublicEl.textContent = isPublicEl.value === "1" ? "공개" : "비공개";
        }
    }

    function buildSpotHtml(index) {
        const defaultDate = startDateEl.value || "";
        const nextOrder = spotListEl.querySelectorAll(".spot-item").length + 1;

        return ''
            + '<div class="spot-head">'
            + '    <div class="spot-head-left">'
            + '        <span class="spot-badge">' + (index + 1) + '</span>'
            + '        <span>여행지 ' + (index + 1) + '</span>'
            + '    </div>'
            + '    <button type="button" class="remove-btn">삭제</button>'
            + '</div>'
            + '<div class="form-group">'
            + '    <label class="form-label">장소명</label>'
            + '    <input type="text"'
            + '           class="form-input"'
            + '           data-field="place_name"'
            + '           placeholder="예: 동방명주탑"'
            + '           required>'
            + '    <div class="field-msg">사용자가 직접 입력한 실제 방문 장소명이 저장돼요.</div>'
            + '</div>'
            + '<div class="form-row" style="margin-top:16px;">'
            + '    <div class="form-group">'
            + '        <label class="form-label">방문일</label>'
            + '        <input type="date"'
            + '               class="form-input"'
            + '               data-field="visit_date"'
            + '               value="' + defaultDate + '"'
            + '               required>'
            + '    </div>'
            + '    <div class="form-group">'
            + '        <label class="form-label">방문 순서</label>'
            + '        <input type="number"'
            + '               class="form-input"'
            + '               data-field="visit_order"'
            + '               min="1"'
            + '               value="' + nextOrder + '"'
            + '               required>'
            + '    </div>'
            + '</div>';
    }

    function addSpotItem() {
        const index = spotListEl.querySelectorAll(".spot-item").length;
        const wrapper = document.createElement("div");
        wrapper.className = "spot-item";
        wrapper.setAttribute("data-visit-date", startDateEl.value || "");
        wrapper.innerHTML = buildSpotHtml(index);
        spotListEl.appendChild(wrapper);
        refreshSpotIndexes();
        updateSpotFilter();
        updateSummary();
    }

    if (addSpotBtn) {
        addSpotBtn.addEventListener("click", function () {
            addSpotItem();
        });
    }

    if (spotListEl) {
        spotListEl.addEventListener("click", function (e) {
            const removeBtn = e.target.closest(".remove-btn");
            if (!removeBtn) return;

            const item = removeBtn.closest(".spot-item");
            if (!item) return;

            if (!confirm("이 방문 여행지를 삭제할까요?")) return;

            item.remove();
            refreshSpotIndexes();
            updateSpotFilter();
            updateSummary();
        });

        spotListEl.addEventListener("input", function () {
            updateSpotFilter();
            updateSummary();
        });

        spotListEl.addEventListener("change", function () {
            updateSpotFilter();
            updateSummary();
        });
    }

    if (spotDateFilterEl) {
        spotDateFilterEl.addEventListener("input", function () {
            updateSpotFilter();
        });
        spotDateFilterEl.addEventListener("change", function () {
            updateSpotFilter();
        });
    }

    if (resetSpotFilterBtn) {
        resetSpotFilterBtn.addEventListener("click", function () {
            spotDateFilterEl.value = "";
            updateSpotFilter();
        });
    }

    if (isPublicToggleEl) {
        isPublicToggleEl.addEventListener("change", function () {
            isPublicEl.value = isPublicToggleEl.checked ? "1" : "0";
            updateSummary();
        });
    }

    [titleEl, destinationEl, startDateEl, endDateEl].forEach(function (el) {
        if (!el) return;
        el.addEventListener("input", updateSummary);
        el.addEventListener("change", updateSummary);
    });

    if (formEl) {
    formEl.addEventListener("submit", function (e) {
        refreshSpotIndexes();

        const items = spotListEl.querySelectorAll(".spot-item");
        if (items.length === 0) {
            alert("최소 1개의 방문 여행지를 입력해 주세요.");
            e.preventDefault();
            return;
        }


        const duplicateCheck = new Set();

        for (const item of items) {
            const placeInput = item.querySelector('[data-field="place_name"]');
            const visitDateInput = item.querySelector('[data-field="visit_date"]');
            const visitOrderInput = item.querySelector('[data-field="visit_order"]');

            const placeName = placeInput.value.trim();
            const visitDate = visitDateInput.value;
            const visitOrder = visitOrderInput.value.trim();

            if (!placeName) {
                alert("장소명을 입력해 주세요.");
                placeInput.focus();
                e.preventDefault();
                return;
            }

            if (!visitDate) {
                alert("방문일을 입력해 주세요.");
                visitDateInput.focus();
                e.preventDefault();
                return;
            }

            if (!visitOrder || Number(visitOrder) < 1) {
                alert("방문 순서는 1 이상의 숫자로 입력해 주세요.");
                visitOrderInput.focus();
                e.preventDefault();
                return;
            }

            const duplicateKey = visitDate + "__" + visitOrder;
            if (duplicateCheck.has(duplicateKey)) {
                alert("같은 날짜에는 동일한 방문 순서를 사용할 수 없어요.");
                visitOrderInput.focus();
                e.preventDefault();
                return;
            }
            duplicateCheck.add(duplicateKey);

        }
    });
}


    refreshSpotIndexes();
    updateSpotFilter();
    updateSummary();
</script>

<%@ include file="../common/footer.jsp" %>
