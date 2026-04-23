<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="course.write.titlePlaceholder" var="courseWriteTitlePlaceholder"/>
<spring:message code="course.write.destinationPlaceholder" var="courseWriteDestinationPlaceholder"/>
<spring:message code="course.write.placePlaceholder" var="courseWritePlacePlaceholder"/>
<spring:message code="course.write.placePlaceholder" javaScriptEscape="true" var="courseWritePlacePlaceholderJs"/>
<spring:message code="course.write.placeFieldMsg" javaScriptEscape="true" var="courseWritePlaceFieldMsgJs"/>
<spring:message code="course.write.dateFormatHint" javaScriptEscape="true" var="courseWriteDateFormatHintJs"/>
<spring:message code="course.write.dateInputPlaceholder" var="courseWriteDateInputPlaceholder"/>
<spring:message code="course.write.dateInputPlaceholder" javaScriptEscape="true" var="courseWriteDateInputPlaceholderJs"/>
<spring:message code="course.write.notSelected" javaScriptEscape="true" var="courseWriteNotSelectedJs"/>
<spring:message code="course.write.notEntered" javaScriptEscape="true" var="courseWriteNotEnteredJs"/>
<spring:message code="course.write.countSuffix" javaScriptEscape="true" var="courseWriteCountSuffixJs"/>
<spring:message code="course.badge.public" javaScriptEscape="true" var="coursePublicLabelJs"/>
<spring:message code="course.badge.private" javaScriptEscape="true" var="coursePrivateLabelJs"/>
<spring:message code="course.form.spotLabel" javaScriptEscape="true" var="courseSpotLabelJs"/>
<spring:message code="course.action.delete" javaScriptEscape="true" var="courseDeleteLabelJs"/>
<spring:message code="course.form.placeName" javaScriptEscape="true" var="coursePlaceNameLabelJs"/>
<spring:message code="course.write.visitDate" javaScriptEscape="true" var="courseVisitDateLabelJs"/>
<spring:message code="course.form.visitOrder" javaScriptEscape="true" var="courseVisitOrderLabelJs"/>
<spring:message code="course.validation.endBeforeStart" javaScriptEscape="true" var="courseValidationEndBeforeStartJs"/>
<spring:message code="course.validation.spotRequired" javaScriptEscape="true" var="courseValidationSpotRequiredJs"/>
<spring:message code="course.validation.placeRequired" javaScriptEscape="true" var="courseValidationPlaceRequiredJs"/>
<spring:message code="course.validation.visitDateRequired" javaScriptEscape="true" var="courseValidationVisitDateRequiredJs"/>
<spring:message code="course.validation.visitOrderRequired" javaScriptEscape="true" var="courseValidationVisitOrderRequiredJs"/>
<spring:message code="course.validation.duplicateVisitOrder" javaScriptEscape="true" var="courseValidationDuplicateVisitOrderJs"/>

<%@ include file="../common/header.jsp" %>

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="course.write.windowTitle"/></title>

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

        .date-input-wrap {
            position: relative;
        }

        .date-input-wrap::after {
            content: attr(data-placeholder);
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-700);
            font-size: 15px;
            pointer-events: none;
            z-index: 2;
        }

        .date-input-wrap.has-value::after {
            display: none;
        }

        .date-input-wrap .localized-date-input {
            position: relative;
            z-index: 1;
        }

        .date-input-wrap:not(.has-value) .localized-date-input,
        .date-input-wrap:not(.has-value) .localized-date-input:focus,
        .date-input-wrap:not(.has-value) .localized-date-input::-webkit-datetime-edit,
        .date-input-wrap:not(.has-value) .localized-date-input::-webkit-datetime-edit-text,
        .date-input-wrap:not(.has-value) .localized-date-input::-webkit-datetime-edit-year-field,
        .date-input-wrap:not(.has-value) .localized-date-input::-webkit-datetime-edit-month-field,
        .date-input-wrap:not(.has-value) .localized-date-input::-webkit-datetime-edit-day-field {
            color: transparent;
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
                <spring:message code="course.write.backToList"/>
            </a>

            <div class="header-row">
                <div class="header-title">
                    <h1><spring:message code="course.write.title"/></h1>
                    <p>
                        <spring:message code="course.write.desc"/>
                    </p>
                </div>

                <div class="status-chip"><spring:message code="course.write.statusWriting"/></div>
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
                                <div class="card-title"><spring:message code="course.write.basicInfo"/></div>
                                <div class="card-sub"><spring:message code="course.write.basicInfoDesc"/></div>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="form-group">
                                <label class="form-label" for="title"><spring:message code="course.form.title"/></label>
                                <input type="text"
                                       id="title"
                                       name="title"
                                       class="form-input"
                                       placeholder="${courseWriteTitlePlaceholder}"
                                       required>
                                <div class="field-msg"><spring:message code="course.write.titleFieldMsg"/></div>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="destination"><spring:message code="course.form.destination"/></label>
                                <input type="text"
                                       id="destination"
                                       name="destination"
                                       class="form-input"
                                       placeholder="${courseWriteDestinationPlaceholder}"
                                       required>
                                <div class="field-msg"><spring:message code="course.write.destinationFieldMsg"/></div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label" for="startDate"><spring:message code="course.write.startDate"/></label>
                                    <div class="date-input-wrap" data-placeholder="${courseWriteDateInputPlaceholder}">
                                        <input type="date"
                                               id="startDate"
                                               name="start_date"
                                               class="form-input localized-date-input"
                                               aria-describedby="startDateFormatHint"
                                               required>
                                    </div>
                                    <div class="field-msg" id="startDateFormatHint"><spring:message code="course.write.dateFormatHint"/></div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="endDate"><spring:message code="course.write.endDate"/></label>
                                    <div class="date-input-wrap" data-placeholder="${courseWriteDateInputPlaceholder}">
                                        <input type="date"
                                               id="endDate"
                                               name="end_date"
                                               class="form-input localized-date-input"
                                               aria-describedby="endDateFormatHint"
                                               required>
                                    </div>
                                    <div class="field-msg" id="endDateFormatHint"><spring:message code="course.write.dateFormatHint"/></div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="card">
                        <div class="card-head">
                            <div class="card-icon">📍</div>
                            <div>
                                <div class="card-title"><spring:message code="course.write.visitSpots"/></div>
                                <div class="card-sub"><spring:message code="course.write.visitSpotsDesc"/></div>
                            </div>
                        </div>

                        <div class="card-body">
                            <p class="helper-text">
                                <spring:message code="course.write.spotHelper"/>
                            </p>

                            <div id="spotList" class="spot-list"></div>

                            <div class="spot-actions">
                                <button type="button" class="btn-outline" id="addSpotBtn">+ <spring:message code="course.action.addSpot"/></button>
                            </div>
                        </div>
                    </section>
                </div>

                <div>
                    <section class="card">
                        <div class="card-head">
                            <div class="card-icon">🌍</div>
                            <div>
                                <div class="card-title"><spring:message code="course.write.publicSetting"/></div>
                                <div class="card-sub"><spring:message code="course.write.publicSettingDesc"/></div>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="public-toggle-wrap">
                                <div>
                                    <div class="public-toggle-label"><spring:message code="course.write.publicToggle"/></div>
                                    <div class="public-toggle-sub">
                                        <spring:message code="course.write.publicToggleDesc"/>
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
                                <div class="card-title"><spring:message code="course.write.summary"/></div>
                                <div class="card-sub"><spring:message code="course.write.summaryDesc"/></div>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="summary-box">
                                <div class="summary-title"><spring:message code="course.write.summaryCurrent"/></div>
                                <div class="summary-list">
                                    <div class="summary-item">
                                        <span><spring:message code="course.form.title"/></span>
                                        <span id="summaryTitle"><spring:message code="course.write.notEntered"/></span>
                                    </div>
                                    <div class="summary-item">
                                        <span><spring:message code="course.form.destination"/></span>
                                        <span id="summaryDestination"><spring:message code="course.write.notSelected"/></span>
                                    </div>
                                    <div class="summary-item">
                                        <span><spring:message code="course.common.travelPeriod"/></span>
                                        <span id="summaryDate"><spring:message code="course.write.notSelected"/></span>
                                    </div>
                                    <div class="summary-item">
                                        <span><spring:message code="course.form.spotCount"/></span>
                                        <span id="summarySpotCount">0<spring:message code="course.write.countSuffix"/></span>
                                    </div>
                                    <div class="summary-item">
                                        <span><spring:message code="course.form.publicStatus"/></span>
                                        <span id="summaryPublic"><spring:message code="course.badge.private"/></span>
                                    </div>
                                </div>
                            </div>

                            <div class="submit-area">
                                <div class="submit-right">
                                    <a href="${pageContext.request.contextPath}/courses/list" class="btn-cancel-link">
                                        <spring:message code="course.action.cancel"/>
                                    </a>
                                    <button type="submit" class="btn-save">
                                        <spring:message code="course.action.savePlan"/>
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

    const COURSE_WRITE_TEXT = {
        spotLabel: "${courseSpotLabelJs}",
        deleteLabel: "${courseDeleteLabelJs}",
        placeNameLabel: "${coursePlaceNameLabelJs}",
        visitDateLabel: "${courseVisitDateLabelJs}",
        visitOrderLabel: "${courseVisitOrderLabelJs}",
        placePlaceholder: "${courseWritePlacePlaceholderJs}",
        placeFieldMsg: "${courseWritePlaceFieldMsgJs}",
        dateFormatHint: "${courseWriteDateFormatHintJs}",
        dateInputPlaceholder: "${courseWriteDateInputPlaceholderJs}",
        notSelected: "${courseWriteNotSelectedJs}",
        notEntered: "${courseWriteNotEnteredJs}",
        countSuffix: "${courseWriteCountSuffixJs}",
        publicLabel: "${coursePublicLabelJs}",
        privateLabel: "${coursePrivateLabelJs}",
        validationEndBeforeStart: "${courseValidationEndBeforeStartJs}",
        validationSpotRequired: "${courseValidationSpotRequiredJs}",
        validationPlaceRequired: "${courseValidationPlaceRequiredJs}",
        validationVisitDateRequired: "${courseValidationVisitDateRequiredJs}",
        validationVisitOrderRequired: "${courseValidationVisitOrderRequiredJs}",
        validationDuplicateVisitOrder: "${courseValidationDuplicateVisitOrderJs}"
    };

    function createSpotItem(index) {
        const displayIndex = index + 1;
        const wrapper = document.createElement("div");
        wrapper.className = "spot-item";

        wrapper.innerHTML =
            '<div class="spot-head">' +
            '<div class="spot-head-left">' +
            '<span class="spot-badge">' + displayIndex + '</span>' +
            '<span>' + COURSE_WRITE_TEXT.spotLabel + ' ' + displayIndex + '</span>' +
            '</div>' +
            '<button type="button" class="remove-btn">' + COURSE_WRITE_TEXT.deleteLabel + '</button>' +
            '</div>' +

            '<div class="form-group">' +
            '<label class="form-label">' + COURSE_WRITE_TEXT.placeNameLabel + '</label>' +
            '<input type="text" ' +
            'class="form-input" ' +
            'data-field="place_name" ' +
            'placeholder="' + COURSE_WRITE_TEXT.placePlaceholder + '" ' +
            'required>' +
            '<div class="field-msg">' + COURSE_WRITE_TEXT.placeFieldMsg + '</div>' +
            '</div>' +

            '<div class="form-row" style="margin-top:16px;">' +
            '<div class="form-group">' +
            '<label class="form-label">' + COURSE_WRITE_TEXT.visitDateLabel + '</label>' +
            '<div class="date-input-wrap" data-placeholder="' + COURSE_WRITE_TEXT.dateInputPlaceholder + '">' +
            '<input type="date" ' +
            'class="form-input localized-date-input" ' +
            'data-field="visit_date" ' +
            'required>' +
            '</div>' +
            '<div class="field-msg">' + COURSE_WRITE_TEXT.dateFormatHint + '</div>' +
            '</div>' +

            '<div class="form-group">' +
            '<label class="form-label">' + COURSE_WRITE_TEXT.visitOrderLabel + '</label>' +
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

        bindLocalizedDateInputs(wrapper);

        return wrapper;
    }

    function syncLocalizedDateInput(input) {
        const wrapper = input.closest(".date-input-wrap");
        if (!wrapper) return;
        wrapper.classList.toggle("has-value", input.value !== "");
    }

    function bindLocalizedDateInputs(root) {
        root.querySelectorAll(".localized-date-input").forEach(input => {
            syncLocalizedDateInput(input);
            input.addEventListener("input", function () {
                syncLocalizedDateInput(input);
            });
            input.addEventListener("change", function () {
                syncLocalizedDateInput(input);
            });
        });
    }

    function refreshSpotIndexes() {
        const items = spotListEl.querySelectorAll(".spot-item");

        items.forEach((item, index) => {
            const badge = item.querySelector(".spot-badge");
            const title = item.querySelector(".spot-head-left span:last-child");

            badge.textContent = index + 1;
            title.textContent = COURSE_WRITE_TEXT.spotLabel + " " + (index + 1);

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
        if (!start && !end) return COURSE_WRITE_TEXT.notSelected;
        if (start && !end) return start + " ~";
        if (!start && end) return "~ " + end;
        return start + " ~ " + end;
    }

    function updateSummary() {
        document.getElementById("summaryTitle").textContent =
            titleEl.value.trim() || COURSE_WRITE_TEXT.notEntered;

        document.getElementById("summaryDestination").textContent =
            destinationEl.value.trim() || COURSE_WRITE_TEXT.notSelected;

        document.getElementById("summaryDate").textContent =
            formatDateRange(startDateEl.value, endDateEl.value);

        const filledPlaceCount = Array.from(
            spotListEl.querySelectorAll('[data-field="place_name"]')
        ).filter(input => input.value.trim() !== "").length;

        document.getElementById("summarySpotCount").textContent =
            filledPlaceCount + COURSE_WRITE_TEXT.countSuffix;

        document.getElementById("summaryPublic").textContent =
            isPublicToggle.checked ? COURSE_WRITE_TEXT.publicLabel : COURSE_WRITE_TEXT.privateLabel;
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
            alert(COURSE_WRITE_TEXT.validationEndBeforeStart);
            endDateEl.value = startDateEl.value;
        }
        updateSummary();
    });

    formEl.addEventListener("submit", function (e) {
        const spotItems = spotListEl.querySelectorAll(".spot-item");

        if (spotItems.length === 0) {
            e.preventDefault();
            alert(COURSE_WRITE_TEXT.validationSpotRequired);
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
                alert(COURSE_WRITE_TEXT.validationPlaceRequired);
                placeInput.focus();
                return;
            }

            if (!visitDate) {
                e.preventDefault();
                alert(COURSE_WRITE_TEXT.validationVisitDateRequired);
                visitDateInput.focus();
                return;
            }

            if (!visitOrder || Number(visitOrder) < 1) {
                e.preventDefault();
                alert(COURSE_WRITE_TEXT.validationVisitOrderRequired);
                visitOrderInput.focus();
                return;
            }

            const duplicateKey = visitDate + "__" + visitOrder;
            if (duplicateCheck.has(duplicateKey)) {
                e.preventDefault();
                alert(COURSE_WRITE_TEXT.validationDuplicateVisitOrder);
                visitOrderInput.focus();
                return;
            }
            duplicateCheck.add(duplicateKey);
        }
    });

    // Create two empty destination rows by default.
    bindLocalizedDateInputs(document);
    addSpot();
    addSpot();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
