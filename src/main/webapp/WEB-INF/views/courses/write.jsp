<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행 일정 만들기</title>

    <style>
        :root {
            --blue: #2563eb;
            --blue-light: #eff6ff;
            --purple: #7c3aed;
            --gray-50: #f8fafc;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --gray-600: #475569;
            --gray-700: #334155;
            --gray-800: #1e293b;
            --red: #dc2626;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Pretendard", "Noto Sans KR", Arial, sans-serif;
            background:
                    radial-gradient(circle at top right, rgba(37,99,235,.08), transparent 25%),
                    radial-gradient(circle at bottom left, rgba(124,58,237,.06), transparent 25%),
                    var(--gray-50);
            color: var(--gray-800);
        }

        .page-wrap {
            min-height: 100vh;
            padding: 40px 24px 80px;
        }

        .page-inner {
            max-width: 1080px;
            margin: 0 auto;
        }

        .page-header {
            margin-bottom: 28px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 14px;
            color: var(--gray-500);
            text-decoration: none;
            margin-bottom: 16px;
        }

        .back-link:hover {
            color: var(--blue);
        }

        .header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            flex-wrap: wrap;
        }

        .header-title h1 {
            margin: 0 0 8px;
            font-size: 48px;
            line-height: 1.1;
            font-weight: 900;
            letter-spacing: -1px;
            color: #1f2a44;
        }

        .header-title p {
            margin: 0;
            font-size: 15px;
            color: var(--gray-500);
            line-height: 1.7;
        }

        .status-chip {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 13px;
            border-radius: 999px;
            background: #fff;
            border: 1px solid var(--gray-200);
            font-size: 12px;
            font-weight: 800;
            color: var(--gray-600);
            box-shadow: 0 2px 8px rgba(0,0,0,.04);
        }

        .status-chip::before {
            content: "✈";
            font-size: 12px;
        }

        .grid {
            display: grid;
            grid-template-columns: 1.25fr .9fr;
            gap: 20px;
            align-items: start;
        }

        .card {
            background: #fff;
            border-radius: 22px;
            box-shadow: 0 10px 28px rgba(15, 23, 42, .06);
            border: 1px solid rgba(226, 232, 240, .95);
            overflow: hidden;
            margin-bottom: 20px;
        }

        .card-head {
            padding: 22px 24px;
            border-bottom: 1px solid var(--gray-100);
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .card-icon {
            width: 46px;
            height: 46px;
            border-radius: 14px;
            background: linear-gradient(135deg, rgba(37,99,235,.12), rgba(124,58,237,.10));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .card-title {
            font-size: 18px;
            font-weight: 900;
            color: var(--gray-800);
            margin-bottom: 4px;
        }

        .card-sub {
            font-size: 13px;
            color: var(--gray-400);
        }

        .card-body {
            padding: 24px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .form-label {
            display: block;
            font-size: 15px;
            font-weight: 800;
            color: var(--gray-700);
            margin-bottom: 9px;
        }

        .form-input {
            width: 100%;
            height: 52px;
            border: 1px solid var(--gray-200);
            border-radius: 16px;
            padding: 0 16px;
            font-size: 15px;
            color: var(--gray-800);
            background: #fff;
            outline: none;
            transition: border-color .15s, box-shadow .15s;
        }

        .form-input:focus {
            border-color: var(--blue);
            box-shadow: 0 0 0 4px rgba(37,99,235,.08);
        }

        .field-msg {
            margin-top: 8px;
            font-size: 12px;
            color: var(--gray-500);
            line-height: 1.6;
        }

        .helper-text {
            font-size: 13px;
            color: var(--gray-500);
            line-height: 1.7;
            margin-top: -2px;
            margin-bottom: 18px;
        }

        .spot-list {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .spot-item {
            border: 1px solid var(--gray-200);
            border-radius: 18px;
            padding: 18px;
            background: linear-gradient(180deg, #fff, #fcfdff);
            box-shadow: 0 2px 8px rgba(15,23,42,.03);
        }

        .spot-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .spot-head-left {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 15px;
            font-weight: 800;
            color: var(--gray-800);
        }

        .spot-badge {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--blue), var(--purple));
            color: #fff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 900;
            flex-shrink: 0;
        }

        .remove-btn {
            padding: 9px 13px;
            border-radius: 12px;
            border: 1px solid #fecaca;
            background: #fff;
            color: var(--red);
            font-size: 12px;
            font-weight: 800;
            cursor: pointer;
        }

        .remove-btn:hover {
            background: #fef2f2;
        }

        .spot-actions {
            display: flex;
            gap: 10px;
            margin-top: 16px;
            flex-wrap: wrap;
        }

        .btn-outline {
            padding: 10px 16px;
            border-radius: 12px;
            border: 1px solid var(--gray-200);
            background: #fff;
            color: var(--gray-700);
            font-size: 13px;
            font-weight: 800;
            cursor: pointer;
        }

        .btn-outline:hover {
            border-color: var(--blue);
            color: var(--blue);
            background: var(--blue-light);
        }

        .summary-box {
            background: linear-gradient(135deg, #eff6ff, #f5f3ff);
            border: 1px solid #dbeafe;
            border-radius: 18px;
            padding: 18px;
            margin-bottom: 16px;
        }

        .summary-title {
            font-size: 14px;
            font-weight: 900;
            color: var(--gray-800);
            margin-bottom: 12px;
        }

        .summary-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            font-size: 14px;
            color: var(--gray-700);
        }

        .summary-item span:last-child {
            font-weight: 800;
            color: var(--gray-800);
            text-align: right;
        }

        .public-toggle-wrap {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            padding: 14px 0;
        }

        .public-toggle-label {
            font-size: 14px;
            font-weight: 800;
            color: var(--gray-700);
        }

        .public-toggle-sub {
            font-size: 12px;
            color: var(--gray-400);
            margin-top: 4px;
            line-height: 1.6;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 54px;
            height: 30px;
            flex-shrink: 0;
        }

        .toggle-switch input {
            display: none;
        }

        .toggle-slider {
            position: absolute;
            inset: 0;
            background: var(--gray-300);
            border-radius: 999px;
            transition: .2s;
            cursor: pointer;
        }

        .toggle-slider::before {
            content: "";
            position: absolute;
            width: 24px;
            height: 24px;
            left: 3px;
            top: 3px;
            background: #fff;
            border-radius: 50%;
            box-shadow: 0 2px 6px rgba(0,0,0,.15);
            transition: .2s;
        }

        .toggle-switch input:checked + .toggle-slider {
            background: var(--blue);
        }

        .toggle-switch input:checked + .toggle-slider::before {
            transform: translateX(24px);
        }

        .submit-area {
            display: flex;
            justify-content: flex-end;
            margin-top: 24px;
        }

        .submit-right {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-cancel-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 18px;
            border-radius: 12px;
            border: 1px solid var(--gray-200);
            background: #fff;
            color: var(--gray-600);
            font-size: 14px;
            font-weight: 800;
            text-decoration: none;
        }

        .btn-cancel-link:hover {
            background: var(--gray-100);
        }

        .btn-save {
            border: none;
            background: linear-gradient(135deg, var(--blue), var(--purple));
            color: #fff;
            font-weight: 900;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(37,99,235,.18);
            min-width: 160px;
            font-size: 16px;
            padding: 12px 22px;
            border-radius: 12px;
        }

        .btn-save:hover {
            opacity: .96;
        }

        .hidden-input {
            display: none;
        }

        @media (max-width: 960px) {
            .grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 640px) {
            .page-wrap {
                padding: 24px 16px 56px;
            }

            .header-title h1 {
                font-size: 38px;
            }

            .card-head,
            .card-body {
                padding: 18px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .submit-right {
                width: 100%;
            }

            .btn-cancel-link,
            .btn-save {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="page-wrap">
    <div class="page-inner">

        <div class="page-header">
            <a href="${pageContext.request.contextPath}/courses/list" class="back-link">
                ← 일정 목록으로 돌아가기
            </a>

            <div class="header-row">
                <div class="header-title">
                    <h1>새 여행 일정 만들기</h1>
                    <p>
                        대표 목적지는 자유롭게 입력하고, 방문 여행지는 장소명·방문일·방문순서를 입력해 주세요.
                    </p>
                </div>

                <div class="status-chip">작성 중</div>
            </div>
        </div>

        <form id="travelPlanForm"
              action="${pageContext.request.contextPath}/courses/insert"
              method="post">

            <input type="hidden" id="isPublic" name="is_public" value="0">

            <div class="grid">

                <div>
                    <section class="card">
                        <div class="card-head">
                            <div class="card-icon">📝</div>
                            <div>
                                <div class="card-title">기본 정보</div>
                                <div class="card-sub">일정 제목과 여행 기간, 대표 목적지를 입력해 주세요.</div>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="form-group">
                                <label class="form-label" for="title">일정 제목</label>
                                <input type="text"
                                       id="title"
                                       name="title"
                                       class="form-input"
                                       placeholder="예: 부산 2박 3일 여행"
                                       required>
                                <div class="field-msg">목록 화면에 표시될 대표 제목이에요.</div>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="destination">대표 목적지</label>
                                <input type="text"
                                       id="destination"
                                       name="destination"
                                       class="form-input"
                                       placeholder="예: 부산, 도쿄, 파리, 제주도"
                                       required>
                                <div class="field-msg">대표 목적지는 자유롭게 입력할 수 있어요.</div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label" for="startDate">시작일</label>
                                    <input type="date"
                                           id="startDate"
                                           name="start_date"
                                           class="form-input"
                                           required>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="endDate">종료일</label>
                                    <input type="date"
                                           id="endDate"
                                           name="end_date"
                                           class="form-input"
                                           required>
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="card">
                        <div class="card-head">
                            <div class="card-icon">📍</div>
                            <div>
                                <div class="card-title">방문 여행지</div>
                                <div class="card-sub">방문 장소명과 방문일, 방문 순서를 입력해 주세요.</div>
                            </div>
                        </div>

                        <div class="card-body">
                            <p class="helper-text">
                                각 방문 여행지는 <strong>장소명 + 방문일 + 방문 순서</strong> 기준으로 저장돼요.
                            </p>

                            <div id="spotList" class="spot-list"></div>

                            <div class="spot-actions">
                                <button type="button" class="btn-outline" id="addSpotBtn">+ 여행지 추가</button>
                            </div>
                        </div>
                    </section>
                </div>

                <div>
                    <section class="card">
                        <div class="card-head">
                            <div class="card-icon">🌍</div>
                            <div>
                                <div class="card-title">공개 설정</div>
                                <div class="card-sub">이 일정을 다른 사용자에게 공개할지 정할 수 있어요.</div>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="public-toggle-wrap">
                                <div>
                                    <div class="public-toggle-label">일정 공개</div>
                                    <div class="public-toggle-sub">
                                        공개로 설정하면 다른 사용자와 공유 가능한 일정으로 활용할 수 있어요.
                                    </div>
                                </div>

                                <label class="toggle-switch">
                                    <input type="checkbox" id="isPublicToggle">
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                        </div>
                    </section>

                    <section class="card">
                        <div class="card-head">
                            <div class="card-icon">📌</div>
                            <div>
                                <div class="card-title">입력 요약</div>
                                <div class="card-sub">현재 작성 내용을 간단히 확인할 수 있어요.</div>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="summary-box">
                                <div class="summary-title">현재 상태</div>
                                <div class="summary-list">
                                    <div class="summary-item">
                                        <span>일정 제목</span>
                                        <span id="summaryTitle">미입력</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>대표 목적지</span>
                                        <span id="summaryDestination">미선택</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>여행 기간</span>
                                        <span id="summaryDate">미선택</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>여행지 개수</span>
                                        <span id="summarySpotCount">0개</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>공개 여부</span>
                                        <span id="summaryPublic">비공개</span>
                                    </div>
                                </div>
                            </div>

                            <div class="submit-area">
                                <div class="submit-right">
                                    <a href="${pageContext.request.contextPath}/courses/list" class="btn-cancel-link">
                                        취소
                                    </a>
                                    <button type="submit" class="btn-save">
                                        일정 저장하기
                                    </button>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

            </div>
        </form>
    </div>
</div>

<script>
    const spotListEl = document.getElementById("spotList");
    const addSpotBtn = document.getElementById("addSpotBtn");
    const isPublicToggle = document.getElementById("isPublicToggle");
    const isPublicHidden = document.getElementById("isPublic");
    const formEl = document.getElementById("travelPlanForm");

    const titleEl = document.getElementById("title");
    const destinationEl = document.getElementById("destination");
    const startDateEl = document.getElementById("startDate");
    const endDateEl = document.getElementById("endDate");


    function createSpotItem(index) {
        const displayIndex = index + 1;
        const wrapper = document.createElement("div");
        wrapper.className = "spot-item";

        wrapper.innerHTML =
            '<div class="spot-head">' +
            '<div class="spot-head-left">' +
            '<span class="spot-badge">' + displayIndex + '</span>' +
            '<span>여행지 ' + displayIndex + '</span>' +
            '</div>' +
            '<button type="button" class="remove-btn">삭제</button>' +
            '</div>' +

            '<div class="form-group">' +
            '<label class="form-label">장소명</label>' +
            '<input type="text" ' +
            'class="form-input" ' +
            'data-field="place_name" ' +
            'placeholder="예: 해운대해수욕장" ' +
            'required>' +
            '<div class="field-msg">사용자가 직접 입력한 실제 방문 장소명이 저장돼요.</div>' +
            '</div>' +

            '<div class="form-row" style="margin-top:16px;">' +
            '<div class="form-group">' +
            '<label class="form-label">방문일</label>' +
            '<input type="date" ' +
            'class="form-input" ' +
            'data-field="visit_date" ' +
            'required>' +
            '</div>' +

            '<div class="form-group">' +
            '<label class="form-label">방문 순서</label>' +
            '<input type="number" ' +
            'class="form-input" ' +
            'data-field="visit_order" ' +
            'min="1" ' +
            'value="' + displayIndex + '" ' +
            'required>' +
            '</div>' +
            '</div>';

        const removeBtn = wrapper.querySelector(".remove-btn");
        const placeInput = wrapper.querySelector('[data-field="place_name"]');
        const visitDateInput = wrapper.querySelector('[data-field="visit_date"]');

        if (startDateEl.value) {
            visitDateInput.value = startDateEl.value;
        }

        removeBtn.addEventListener("click", function () {
            wrapper.remove();
            refreshSpotIndexes();
            updateSummary();
        });

        placeInput.addEventListener("input", updateSummary);

        wrapper.querySelectorAll(".form-input").forEach(input => {
            input.addEventListener("input", updateSummary);
            input.addEventListener("change", updateSummary);
        });

        return wrapper;
    }

    function refreshSpotIndexes() {
        const items = spotListEl.querySelectorAll(".spot-item");

        items.forEach((item, index) => {
            const badge = item.querySelector(".spot-badge");
            const title = item.querySelector(".spot-head-left span:last-child");

            badge.textContent = index + 1;
            title.textContent = "여행지 " + (index + 1);

            const inputs = item.querySelectorAll("[data-field]");
            inputs.forEach(input => {
                const field = input.dataset.field;
                input.name = "spotList[" + index + "]." + field;
            });

            const orderInput = item.querySelector('[data-field="visit_order"]');
            if (!orderInput.value) {
                orderInput.value = index + 1;
            }
        });
    }

    function addSpot() {
        const index = spotListEl.querySelectorAll(".spot-item").length;
        const item = createSpotItem(index);
        spotListEl.appendChild(item);
        refreshSpotIndexes();
        updateSummary();
    }

    function formatDateRange(start, end) {
        if (!start && !end) return "미선택";
        if (start && !end) return start + " ~";
        if (!start && end) return "~ " + end;
        return start + " ~ " + end;
    }

    function updateSummary() {
        document.getElementById("summaryTitle").textContent =
            titleEl.value.trim() || "미입력";

        document.getElementById("summaryDestination").textContent =
            destinationEl.value.trim() || "미선택";

        document.getElementById("summaryDate").textContent =
            formatDateRange(startDateEl.value, endDateEl.value);

        const filledPlaceCount = Array.from(
            spotListEl.querySelectorAll('[data-field="place_name"]')
        ).filter(input => input.value.trim() !== "").length;

        document.getElementById("summarySpotCount").textContent =
            filledPlaceCount + "개";

        document.getElementById("summaryPublic").textContent =
            isPublicToggle.checked ? "공개" : "비공개";
    }

    isPublicToggle.addEventListener("change", function () {
        isPublicHidden.value = this.checked ? "1" : "0";
        updateSummary();
    });

    addSpotBtn.addEventListener("click", addSpot);

    [titleEl, destinationEl, startDateEl, endDateEl].forEach(input => {
        input.addEventListener("input", updateSummary);
        input.addEventListener("change", updateSummary);
    });

    destinationEl.addEventListener("change", function () {
        updateSummary();
    });

    startDateEl.addEventListener("change", function () {
        if (endDateEl.value && endDateEl.value < startDateEl.value) {
            endDateEl.value = startDateEl.value;
        }

        document.querySelectorAll('[data-field="visit_date"]').forEach(input => {
            if (!input.value) {
                input.value = startDateEl.value;
            }
        });

        updateSummary();
    });

    endDateEl.addEventListener("change", function () {
        if (startDateEl.value && endDateEl.value < startDateEl.value) {
            alert("종료일은 시작일보다 빠를 수 없어요.");
            endDateEl.value = startDateEl.value;
        }
        updateSummary();
    });

    formEl.addEventListener("submit", function (e) {
        const spotItems = spotListEl.querySelectorAll(".spot-item");

        if (spotItems.length === 0) {
            e.preventDefault();
            alert("최소 1개의 방문 여행지를 입력해 주세요.");
            return;
        }

        const duplicateCheck = new Set();

        for (const item of spotItems) {
            const placeInput = item.querySelector('[data-field="place_name"]');
            const visitDateInput = item.querySelector('[data-field="visit_date"]');
            const visitOrderInput = item.querySelector('[data-field="visit_order"]');

            const placeName = placeInput.value.trim();
            const visitDate = visitDateInput.value;
            const visitOrder = visitOrderInput.value.trim();

            if (!placeName) {
                e.preventDefault();
                alert("방문 장소명을 입력해 주세요.");
                placeInput.focus();
                return;
            }

            if (!visitDate) {
                e.preventDefault();
                alert("방문일을 입력해 주세요.");
                visitDateInput.focus();
                return;
            }

            if (!visitOrder || Number(visitOrder) < 1) {
                e.preventDefault();
                alert("방문 순서는 1 이상의 숫자로 입력해 주세요.");
                visitOrderInput.focus();
                return;
            }

            const duplicateKey = visitDate + "__" + visitOrder;
            if (duplicateCheck.has(duplicateKey)) {
                e.preventDefault();
                alert("같은 날짜에는 동일한 방문 순서를 사용할 수 없어요.");
                visitOrderInput.focus();
                return;
            }
            duplicateCheck.add(duplicateKey);
        }
    });

    // 기본 2개 생성
    addSpot();
    addSpot();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>