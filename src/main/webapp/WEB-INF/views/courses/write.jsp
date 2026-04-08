<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Pretendard", "Noto Sans KR", Arial, sans-serif;
            background: var(--gray-50);
            color: var(--gray-800);
        }

        .course-write-wrap {
            min-height: 100vh;
            background:
                    radial-gradient(circle at top right, rgba(37,99,235,.08), transparent 25%),
                    radial-gradient(circle at bottom left, rgba(124,58,237,.06), transparent 25%),
                    var(--gray-50);
            padding: 40px 24px 80px;
        }

        .course-write-inner {
            max-width: 980px;
            margin: 0 auto;
        }

        .course-write-header {
            margin-bottom: 28px;
        }

        .course-write-back {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 14px;
            color: var(--gray-500);
            text-decoration: none;
            margin-bottom: 16px;
            transition: color .15s;
        }

        .course-write-back:hover {
            color: var(--blue);
        }

        .course-write-title-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            flex-wrap: wrap;
        }

        .course-write-title-wrap h1 {
            font-size: 1.9rem;
            font-weight: 800;
            color: var(--gray-800);
            margin: 0 0 8px;
        }

        .course-write-title-wrap p {
            font-size: 14px;
            color: var(--gray-500);
            margin: 0;
            line-height: 1.6;
        }

        .course-status-chip {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 12px;
            border-radius: 999px;
            background: #fff;
            border: 1px solid var(--gray-200);
            font-size: 12px;
            font-weight: 700;
            color: var(--gray-600);
            box-shadow: 0 2px 8px rgba(0,0,0,.04);
        }

        .course-status-chip::before {
            content: "✈";
            font-size: 12px;
        }

        .write-grid {
            display: grid;
            grid-template-columns: 1.25fr .9fr;
            gap: 20px;
            align-items: start;
        }

        .write-left,
        .write-right {
            min-width: 0;
        }

        .course-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, .06);
            border: 1px solid rgba(226, 232, 240, .9);
            overflow: hidden;
            margin-bottom: 20px;
        }

        .course-card-head {
            padding: 20px 24px;
            border-bottom: 1px solid var(--gray-100);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .course-card-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: linear-gradient(135deg, rgba(37,99,235,.12), rgba(124,58,237,.10));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
        }

        .course-card-title {
            font-size: 16px;
            font-weight: 800;
            color: var(--gray-800);
            margin-bottom: 3px;
        }

        .course-card-sub {
            font-size: 12px;
            color: var(--gray-400);
        }

        .course-card-body {
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
            font-size: 14px;
            font-weight: 700;
            color: var(--gray-700);
            margin-bottom: 8px;
        }

        .form-input {
            width: 100%;
            height: 46px;
            border: 1px solid var(--gray-200);
            border-radius: 12px;
            padding: 0 14px;
            font-size: 14px;
            color: var(--gray-800);
            background: #fff;
            outline: none;
            transition: border-color .15s, box-shadow .15s;
        }

        .form-input:focus {
            border-color: var(--blue);
            box-shadow: 0 0 0 4px rgba(37,99,235,.08);
        }

        select.form-input {
            appearance: none;
            background-image:
                    linear-gradient(45deg, transparent 50%, var(--gray-400) 50%),
                    linear-gradient(135deg, var(--gray-400) 50%, transparent 50%);
            background-position:
                    calc(100% - 18px) calc(50% - 3px),
                    calc(100% - 12px) calc(50% - 3px);
            background-size: 6px 6px, 6px 6px;
            background-repeat: no-repeat;
            padding-right: 40px;
        }

        .field-msg.info {
            margin-top: 8px;
            font-size: 12px;
            color: var(--gray-500);
        }

        .helper-text {
            font-size: 12px;
            color: var(--gray-500);
            line-height: 1.6;
            margin-top: -6px;
            margin-bottom: 16px;
        }

        .travel-spot-list {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .spot-item {
            border: 1px solid var(--gray-200);
            border-radius: 16px;
            padding: 18px;
            background: linear-gradient(180deg, #fff, #fcfdff);
            box-shadow: 0 2px 8px rgba(15,23,42,.03);
        }

        .spot-item-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 14px;
        }

        .spot-item-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
            font-weight: 700;
            color: var(--gray-800);
        }

        .spot-index-badge {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--blue), var(--purple));
            color: #fff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 800;
            flex-shrink: 0;
        }

        .spot-remove-btn {
            padding: 8px 12px;
            border-radius: 10px;
            border: 1px solid #fecaca;
            background: #fff;
            color: #dc2626;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: all .15s;
        }

        .spot-remove-btn:hover {
            background: #fef2f2;
        }

        .spot-actions {
            display: flex;
            gap: 10px;
            margin-top: 14px;
            flex-wrap: wrap;
        }

        .btn-outline {
            padding: 10px 16px;
            border-radius: 10px;
            border: 1px solid var(--gray-200);
            background: #fff;
            color: var(--gray-700);
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            transition: all .15s;
        }

        .btn-outline:hover {
            border-color: var(--blue);
            color: var(--blue);
            background: var(--blue-light);
        }

        .spot-preview {
            margin-top: 10px;
            padding: 12px 14px;
            border-radius: 12px;
            background: var(--gray-50);
            border: 1px solid var(--gray-200);
            font-size: 13px;
            color: var(--gray-600);
            line-height: 1.6;
        }

        .spot-preview strong {
            color: var(--gray-800);
            font-weight: 800;
        }

        .spot-preview.empty {
            color: var(--gray-400);
        }

        .summary-box {
            background: linear-gradient(135deg, #eff6ff, #f5f3ff);
            border: 1px solid #dbeafe;
            border-radius: 16px;
            padding: 18px;
            margin-bottom: 16px;
        }

        .summary-title {
            font-size: 14px;
            font-weight: 800;
            color: var(--gray-800);
            margin-bottom: 10px;
        }

        .summary-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            font-size: 13px;
            color: var(--gray-700);
        }

        .summary-item span:last-child {
            font-weight: 700;
            color: var(--gray-800);
        }

        .public-toggle-wrap {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            padding: 14px 0;
            border-bottom: 1px solid var(--gray-100);
        }

        .public-toggle-wrap:last-child {
            border-bottom: none;
        }

        .public-toggle-label {
            font-size: 14px;
            font-weight: 700;
            color: var(--gray-700);
        }

        .public-toggle-sub {
            font-size: 12px;
            color: var(--gray-400);
            margin-top: 4px;
            line-height: 1.5;
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
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 24px;
        }

        .submit-right {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .btn-cancel-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 18px;
            border-radius: 10px;
            border: 1px solid var(--gray-200);
            background: #fff;
            color: var(--gray-600);
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            transition: all .15s;
        }

        .btn-cancel-link:hover {
            border-color: var(--gray-300);
            background: var(--gray-100);
        }

        .btn-save {
            border: none;
            background: linear-gradient(135deg, var(--blue), var(--purple));
            color: #fff;
            font-weight: 800;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(37,99,235,.18);
        }

        .btn-save.large {
            min-width: 160px;
            font-size: 15px;
            padding: 12px 22px;
            border-radius: 12px;
        }

        .btn-save:hover {
            opacity: .95;
        }

        @media (max-width: 900px) {
            .write-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 640px) {
            .course-write-wrap {
                padding: 24px 16px 56px;
            }

            .course-card-head,
            .course-card-body {
                padding: 18px;
            }

            .spot-item {
                padding: 14px;
            }

            .spot-item-head {
                align-items: flex-start;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .submit-area {
                flex-direction: column;
                align-items: stretch;
            }

            .submit-right {
                width: 100%;
            }

            .btn-cancel-link,
            .btn-save.large {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="course-write-wrap">
    <div class="course-write-inner">

        <div class="course-write-header">
            <a href="${pageContext.request.contextPath}/courses/list" class="course-write-back">
                ← 일정 목록으로 돌아가기
            </a>

            <div class="course-write-title-row">
                <div class="course-write-title-wrap">
                    <h1>새 여행 일정 만들기</h1>
                    <p>
                        여행 제목, 기간, 방문할 장소를 한 번에 입력해 저장할 수 있어요.
                        아래에서 기본 정보와 방문 순서를 차례대로 입력해 주세요.
                    </p>
                </div>

                <div class="course-status-chip">작성 중</div>
            </div>
        </div>

        <form id="travelPlanForm"
              action="${pageContext.request.contextPath}/courses/insert"
              method="post">

            <input type="hidden" id="isPublic" name="is_public" value="0">

            <div class="write-grid">

                <!-- 왼쪽 -->
                <div class="write-left">

                    <section class="course-card">
                        <div class="course-card-head">
                            <div class="course-card-icon">📝</div>
                            <div>
                                <div class="course-card-title">기본 정보</div>
                                <div class="course-card-sub">일정 제목과 여행 기간을 입력해 주세요.</div>
                            </div>
                        </div>

                        <div class="course-card-body">
                            <div class="form-group">
                                <label class="form-label" for="title">일정 제목</label>
                                <input type="text"
                                       id="title"
                                       name="title"
                                       class="form-input"
                                       placeholder="예: 부산 2박 3일 바다 여행"
                                       required>
                                <div class="field-msg info">목록 화면에 표시될 대표 제목이에요.</div>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="destination">대표 목적지</label>
                                <input type="text"
                                       id="destination"
                                       name="destination"
                                       class="form-input"
                                       placeholder="예: 부산, 제주, 도쿄">
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

                    <section class="course-card">
                        <div class="course-card-head">
                            <div class="course-card-icon">📍</div>
                            <div>
                                <div class="course-card-title">방문 여행지</div>
                                <div class="course-card-sub">등록된 여행지 목록에서 선택해 주세요.</div>
                            </div>
                        </div>

                        <div class="course-card-body">
                            <p class="helper-text">
                                현재는 <strong>SPOT_TRAVEL</strong>에 등록된 여행지만 선택할 수 있어요.
                                여행지 선택 시 이름, 지역, 주소를 아래에서 바로 확인할 수 있어요.
                            </p>

                            <!-- 여행지 옵션 원본 -->
                            <select id="masterSpotSelect" style="display:none;">
                                <option value="">여행지를 선택하세요</option>
                                <c:forEach var="spot" items="${spotTravelList}">
                                    <option value="${spot.spot_id}"
                                            data-name="${spot.name}"
                                            data-region="${spot.region}"
                                            data-address="${spot.address}">
                                        <c:out value="${spot.name}" />
                                        <c:if test="${not empty spot.region}">
                                            (<c:out value="${spot.region}" />)
                                        </c:if>
                                    </option>
                                </c:forEach>
                            </select>

                            <div id="spotList" class="travel-spot-list">
                                <!-- JS로 spot-item 추가 -->
                            </div>

                            <div class="spot-actions">
                                <button type="button" class="btn-outline" id="addSpotBtn">+ 여행지 추가</button>
                            </div>
                        </div>
                    </section>

                </div>

                <!-- 오른쪽 -->
                <div class="write-right">

                    <section class="course-card">
                        <div class="course-card-head">
                            <div class="course-card-icon">🌍</div>
                            <div>
                                <div class="course-card-title">공개 설정</div>
                                <div class="course-card-sub">이 일정을 다른 사용자에게 공개할지 정할 수 있어요.</div>
                            </div>
                        </div>

                        <div class="course-card-body">
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

                    <section class="course-card">
                        <div class="course-card-head">
                            <div class="course-card-icon">📌</div>
                            <div>
                                <div class="course-card-title">입력 요약</div>
                                <div class="course-card-sub">현재 작성 내용을 간단히 확인할 수 있어요.</div>
                            </div>
                        </div>

                        <div class="course-card-body">
                            <div class="summary-box">
                                <div class="summary-title">현재 상태</div>
                                <div class="summary-list">
                                    <div class="summary-item">
                                        <span>일정 제목</span>
                                        <span id="summaryTitle">미입력</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>대표 목적지</span>
                                        <span id="summaryDestination">미입력</span>
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
                                    <button type="submit" class="btn-save large">
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
    const masterSpotSelect = document.getElementById("masterSpotSelect");

    const titleEl = document.getElementById("title");
    const destinationEl = document.getElementById("destination");
    const startDateEl = document.getElementById("startDate");
    const endDateEl = document.getElementById("endDate");
    const formEl = document.getElementById("travelPlanForm");

    function updateSpotPreview(wrapper) {
        const select = wrapper.querySelector('[data-field="spot_id"]');
        const preview = wrapper.querySelector(".spot-preview");

        if (!select || !preview) return;

        const selectedOption = select.options[select.selectedIndex];

        if (!selectedOption || !selectedOption.value) {
            preview.classList.add("empty");
            preview.innerHTML = "아직 선택된 여행지가 없어요.";
            return;
        }

        const name = selectedOption.dataset.name || "";
        const region = selectedOption.dataset.region || "";
        const address = selectedOption.dataset.address || "";

        preview.classList.remove("empty");
        preview.innerHTML = `
            <div><strong>장소명</strong> : ${name}</div>
            <div><strong>지역</strong> : ${region || "-"}</div>
            <div><strong>주소</strong> : ${address || "-"}</div>
        `;
    }

    function createSpotItem(index) {
        const wrapper = document.createElement("div");
        wrapper.className = "spot-item";

        wrapper.innerHTML = `
            <div class="spot-item-head">
                <div class="spot-item-title">
                    <span class="spot-index-badge">${index + 1}</span>
                    <span>여행지 ${index + 1}</span>
                </div>
                <button type="button" class="spot-remove-btn">삭제</button>
            </div>

            <div class="form-group">
                <label class="form-label">여행지 선택</label>
                <select class="form-input" data-field="spot_id" required>
                    ${masterSpotSelect.innerHTML}
                </select>
                <div class="spot-preview empty">아직 선택된 여행지가 없어요.</div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">방문일</label>
                    <input type="date"
                           class="form-input"
                           data-field="visit_date"
                           required>
                </div>

                <div class="form-group">
                    <label class="form-label">방문 순서</label>
                    <input type="number"
                           class="form-input"
                           data-field="visit_order"
                           min="1"
                           value="${index + 1}"
                           required>
                </div>
            </div>
        `;

        const removeBtn = wrapper.querySelector(".spot-remove-btn");
        const spotSelect = wrapper.querySelector('[data-field="spot_id"]');
        const visitDateInput = wrapper.querySelector('[data-field="visit_date"]');

        if (startDateEl.value) {
            visitDateInput.value = startDateEl.value;
        }

        removeBtn.addEventListener("click", function () {
            wrapper.remove();
            refreshSpotIndexes();
            updateSummary();
        });

        wrapper.querySelectorAll(".form-input").forEach(input => {
            input.addEventListener("input", updateSummary);
            input.addEventListener("change", updateSummary);
        });

        spotSelect.addEventListener("change", function () {
            updateSpotPreview(wrapper);
            updateSummary();
        });

        updateSpotPreview(wrapper);

        return wrapper;
    }

    function refreshSpotIndexes() {
        const items = spotListEl.querySelectorAll(".spot-item");

        items.forEach((item, index) => {
            const badge = item.querySelector(".spot-index-badge");
            const title = item.querySelector(".spot-item-title span:last-child");

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
            destinationEl.value.trim() || "미입력";

        document.getElementById("summaryDate").textContent =
            formatDateRange(startDateEl.value, endDateEl.value);

        const selectedSpotCount = Array.from(
            spotListEl.querySelectorAll('select[data-field="spot_id"]')
        ).filter(select => select.value && select.value.trim() !== "").length;

        document.getElementById("summarySpotCount").textContent =
            selectedSpotCount + "개";

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
        const selectedSpotCount = Array.from(
            spotListEl.querySelectorAll('select[data-field="spot_id"]')
        ).filter(select => select.value && select.value.trim() !== "").length;

        if (selectedSpotCount === 0) {
            e.preventDefault();
            alert("최소 1개의 여행지를 선택해 주세요.");
            return;
        }
    });

    // 기본 2개 여행지 입력칸 생성
    addSpot();
    addSpot();
</script>

</body>
</html>