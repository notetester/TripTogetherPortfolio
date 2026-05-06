<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_courses_common_spotIndexed_js" code="courses.common.spotIndexed" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_delete_js" code="courses.common.delete" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_field_placeName_js" code="courses.common.field.placeName" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_placeholder_placeExample_js" code="courses.common.placeholder.placeExample" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_help_placeStored_js" code="courses.common.help.placeStored" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_field_visitDate_js" code="courses.common.field.visitDate" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_field_visitOrder_js" code="courses.common.field.visitOrder" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_value_emptyInput_js" code="courses.common.value.emptyInput" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_value_emptySelection_js" code="courses.common.value.emptySelection" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_visibility_public_js" code="courses.common.visibility.public" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_visibility_private_js" code="courses.common.visibility.private" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_countWithUnit_js" code="courses.common.countWithUnit" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_invalidEndDate_js" code="courses.common.alert.invalidEndDate" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_minSpot_js" code="courses.common.alert.minSpot" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_placeRequired_js" code="courses.common.alert.placeRequired" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_visitDateRequired_js" code="courses.common.alert.visitDateRequired" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_orderRequired_js" code="courses.common.alert.orderRequired" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_duplicateOrder_js" code="courses.common.alert.duplicateOrder" javaScriptEscape="true"/>
<spring:message var="msg_course_write_titlePlaceholder" code="course.write.titlePlaceholder"/>
<spring:message var="msg_course_write_destinationPlaceholder" code="course.write.destinationPlaceholder"/>
<spring:message var="msg_course_write_placePlaceholder" code="course.write.placePlaceholder"/>
<spring:message var="msg_course_write_placePlaceholder_js" code="course.write.placePlaceholder" javaScriptEscape="true"/>
<spring:message var="msg_course_write_placeFieldMsg_js" code="course.write.placeFieldMsg" javaScriptEscape="true"/>
<spring:message var="msg_course_write_dateFormatHint_js" code="course.write.dateFormatHint" javaScriptEscape="true"/>
<spring:message var="msg_course_write_dateInputPlaceholder" code="course.write.dateInputPlaceholder"/>
<spring:message var="msg_course_write_dateInputPlaceholder_js" code="course.write.dateInputPlaceholder" javaScriptEscape="true"/>
<spring:message var="msg_course_write_notSelected_js" code="course.write.notSelected" javaScriptEscape="true"/>
<spring:message var="msg_course_write_notEntered_js" code="course.write.notEntered" javaScriptEscape="true"/>
<spring:message var="msg_course_write_countSuffix_js" code="course.write.countSuffix" javaScriptEscape="true"/>
<spring:message var="msg_course_badge_public_js" code="course.badge.public" javaScriptEscape="true"/>
<spring:message var="msg_course_badge_private_js" code="course.badge.private" javaScriptEscape="true"/>
<spring:message var="msg_course_form_spotLabel_js" code="course.form.spotLabel" javaScriptEscape="true"/>
<spring:message var="msg_course_action_delete_js" code="course.action.delete" javaScriptEscape="true"/>
<spring:message var="msg_course_form_placeName_js" code="course.form.placeName" javaScriptEscape="true"/>
<spring:message var="msg_course_write_visitDate_js" code="course.write.visitDate" javaScriptEscape="true"/>
<spring:message var="msg_course_form_visitOrder_js" code="course.form.visitOrder" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_endBeforeStart_js" code="course.validation.endBeforeStart" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_spotRequired_js" code="course.validation.spotRequired" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_placeRequired_js" code="course.validation.placeRequired" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_visitDateRequired_js" code="course.validation.visitDateRequired" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_visitOrderRequired_js" code="course.validation.visitOrderRequired" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_duplicateVisitOrder_js" code="course.validation.duplicateVisitOrder" javaScriptEscape="true"/>
<spring:message var="msg_course_write_windowTitle" code="course.write.windowTitle"/>
<spring:message var="msg_course_write_backToList" code="course.write.backToList"/>
<spring:message var="msg_course_write_title" code="course.write.title"/>
<spring:message var="msg_course_write_desc" code="course.write.desc"/>
<spring:message var="msg_course_write_statusWriting" code="course.write.statusWriting"/>
<spring:message var="msg_course_write_basicInfo" code="course.write.basicInfo"/>
<spring:message var="msg_course_write_basicInfoDesc" code="course.write.basicInfoDesc"/>
<spring:message var="msg_course_form_title" code="course.form.title"/>
<spring:message var="msg_course_write_titleFieldMsg" code="course.write.titleFieldMsg"/>
<spring:message var="msg_course_form_destination" code="course.form.destination"/>
<spring:message var="msg_course_write_destinationFieldMsg" code="course.write.destinationFieldMsg"/>
<spring:message var="msg_course_write_startDate" code="course.write.startDate"/>
<spring:message var="msg_course_write_dateFormatHint" code="course.write.dateFormatHint"/>
<spring:message var="msg_course_write_endDate" code="course.write.endDate"/>
<spring:message var="msg_course_write_visitSpots" code="course.write.visitSpots"/>
<spring:message var="msg_course_write_visitSpotsDesc" code="course.write.visitSpotsDesc"/>
<spring:message var="msg_course_write_spotHelper" code="course.write.spotHelper"/>
<spring:message var="msg_course_action_addSpot" code="course.action.addSpot"/>
<spring:message var="msg_course_write_publicSetting" code="course.write.publicSetting"/>
<spring:message var="msg_course_write_publicSettingDesc" code="course.write.publicSettingDesc"/>
<spring:message var="msg_course_write_publicToggle" code="course.write.publicToggle"/>
<spring:message var="msg_course_write_publicToggleDesc" code="course.write.publicToggleDesc"/>
<spring:message var="msg_course_write_summary" code="course.write.summary"/>
<spring:message var="msg_course_write_summaryDesc" code="course.write.summaryDesc"/>
<spring:message var="msg_course_write_summaryCurrent" code="course.write.summaryCurrent"/>
<spring:message var="msg_course_write_notEntered" code="course.write.notEntered"/>
<spring:message var="msg_course_write_notSelected" code="course.write.notSelected"/>
<spring:message var="msg_course_common_travelPeriod" code="course.common.travelPeriod"/>
<spring:message var="msg_course_form_spotCount" code="course.form.spotCount"/>
<spring:message var="msg_course_write_countSuffix" code="course.write.countSuffix"/>
<spring:message var="msg_course_form_publicStatus" code="course.form.publicStatus"/>
<spring:message var="msg_course_badge_private" code="course.badge.private"/>
<spring:message var="msg_course_action_cancel" code="course.action.cancel"/>
<spring:message var="msg_course_action_savePlan" code="course.action.savePlan"/>
<%@ include file="../common/header.jsp" %>
<fmt:setLocale value="${pageContext.response.locale}" />

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title>${msg_course_write_windowTitle}</title>

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
                ${msg_course_write_backToList}
            </a>

            <div class="header-row">
                <div class="header-title">
                    <h1>${msg_course_write_title}</h1>
                    <p>
                        ${msg_course_write_desc}
                    </p>
                </div>

                <div class="status-chip">${msg_course_write_statusWriting}</div>
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
                                <div class="card-title">${msg_course_write_basicInfo}</div>
                                <div class="card-sub">${msg_course_write_basicInfoDesc}</div>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="form-group">
                                <label class="form-label" for="title">${msg_course_form_title}</label>
                                <input type="text"
                                       id="title"
                                       name="title"
                                       class="form-input"
                                       placeholder="${msg_course_write_titlePlaceholder}"
                                       required>
                                <div class="field-msg">${msg_course_write_titleFieldMsg}</div>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="destination">${msg_course_form_destination}</label>
                                <input type="text"
                                       id="destination"
                                       name="destination"
                                       class="form-input"
                                       placeholder="${msg_course_write_destinationPlaceholder}"
                                       required>
                                <div class="field-msg">${msg_course_write_destinationFieldMsg}</div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label" for="startDate">${msg_course_write_startDate}</label>
                                    <div class="date-input-wrap" data-placeholder="${msg_course_write_dateInputPlaceholder}">
                                        <input type="date"
                                               id="startDate"
                                               name="start_date"
                                               class="form-input localized-date-input"
                                               aria-describedby="startDateFormatHint"
                                               required>
                                    </div>
                                    <div class="field-msg" id="startDateFormatHint">${msg_course_write_dateFormatHint}</div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="endDate">${msg_course_write_endDate}</label>
                                    <div class="date-input-wrap" data-placeholder="${msg_course_write_dateInputPlaceholder}">
                                        <input type="date"
                                               id="endDate"
                                               name="end_date"
                                               class="form-input localized-date-input"
                                               aria-describedby="endDateFormatHint"
                                               required>
                                    </div>
                                    <div class="field-msg" id="endDateFormatHint">${msg_course_write_dateFormatHint}</div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="card">
                        <div class="card-head">
                            <div class="card-icon">📍</div>
                            <div>
                                <div class="card-title">${msg_course_write_visitSpots}</div>
                                <div class="card-sub">${msg_course_write_visitSpotsDesc}</div>
                            </div>
                        </div>

                        <div class="card-body">
                            <p class="helper-text">
                                ${msg_course_write_spotHelper}
                            </p>

                            <div id="spotList" class="spot-list"></div>

                            <div class="spot-actions">
                                <button type="button" class="btn-outline" id="addSpotBtn">+ ${msg_course_action_addSpot}</button>
                            </div>
                        </div>
                    </section>
                </div>

                <div>
                    <section class="card">
                        <div class="card-head">
                            <div class="card-icon">🌍</div>
                            <div>
                                <div class="card-title">${msg_course_write_publicSetting}</div>
                                <div class="card-sub">${msg_course_write_publicSettingDesc}</div>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="public-toggle-wrap">
                                <div>
                                    <div class="public-toggle-label">${msg_course_write_publicToggle}</div>
                                    <div class="public-toggle-sub">
                                        ${msg_course_write_publicToggleDesc}
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
                                <div class="card-title">${msg_course_write_summary}</div>
                                <div class="card-sub">${msg_course_write_summaryDesc}</div>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="summary-box">
                                <div class="summary-title">${msg_course_write_summaryCurrent}</div>
                                <div class="summary-list">
                                    <div class="summary-item">
                                        <span>${msg_course_form_title}</span>
                                        <span id="summaryTitle">${msg_course_write_notEntered}</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>${msg_course_form_destination}</span>
                                        <span id="summaryDestination">${msg_course_write_notSelected}</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>${msg_course_common_travelPeriod}</span>
                                        <span id="summaryDate">${msg_course_write_notSelected}</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>${msg_course_form_spotCount}</span>
                                        <span id="summarySpotCount">0${msg_course_write_countSuffix}</span>
                                    </div>
                                    <div class="summary-item">
                                        <span>${msg_course_form_publicStatus}</span>
                                        <span id="summaryPublic">${msg_course_badge_private}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="submit-area">
                                <div class="submit-right">
                                    <a href="${pageContext.request.contextPath}/courses/list" class="btn-cancel-link">
                                        ${msg_course_action_cancel}
                                    </a>
                                    <button type="submit" class="btn-save">
                                        ${msg_course_action_savePlan}
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
    const courseWriteMessages = {
        spotIndexed: "${msg_courses_common_spotIndexed_js}",
        deleteLabel: "${msg_courses_common_delete_js}",
        placeNameLabel: "${msg_courses_common_field_placeName_js}",
        placePlaceholder: "${msg_courses_common_placeholder_placeExample_js}",
        placeHelp: "${msg_courses_common_help_placeStored_js}",
        visitDateLabel: "${msg_courses_common_field_visitDate_js}",
        visitOrderLabel: "${msg_courses_common_field_visitOrder_js}",
        emptyInput: "${msg_courses_common_value_emptyInput_js}",
        emptySelection: "${msg_courses_common_value_emptySelection_js}",
        publicLabel: "${msg_courses_common_visibility_public_js}",
        privateLabel: "${msg_courses_common_visibility_private_js}",
        countWithUnit: "${msg_courses_common_countWithUnit_js}",
        invalidEndDate: "${msg_courses_common_alert_invalidEndDate_js}",
        minSpot: "${msg_courses_common_alert_minSpot_js}",
        placeRequired: "${msg_courses_common_alert_placeRequired_js}",
        visitDateRequired: "${msg_courses_common_alert_visitDateRequired_js}",
        orderRequired: "${msg_courses_common_alert_orderRequired_js}",
        duplicateOrder: "${msg_courses_common_alert_duplicateOrder_js}"
    };

    function formatCourseMessage(template, ...values) {
        return template.replace(/\u007B(\d+)\u007D/g, function (_, index) {
            return values[index] ?? "";
        });
    }

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
        spotLabel: "${msg_course_form_spotLabel_js}",
        deleteLabel: "${msg_course_action_delete_js}",
        placeNameLabel: "${msg_course_form_placeName_js}",
        visitDateLabel: "${msg_course_write_visitDate_js}",
        visitOrderLabel: "${msg_course_form_visitOrder_js}",
        placePlaceholder: "${msg_course_write_placePlaceholder_js}",
        placeFieldMsg: "${msg_course_write_placeFieldMsg_js}",
        dateFormatHint: "${msg_course_write_dateFormatHint_js}",
        dateInputPlaceholder: "${msg_course_write_dateInputPlaceholder_js}",
        notSelected: "${msg_course_write_notSelected_js}",
        notEntered: "${msg_course_write_notEntered_js}",
        countSuffix: "${msg_course_write_countSuffix_js}",
        publicLabel: "${msg_course_badge_public_js}",
        privateLabel: "${msg_course_badge_private_js}",
        validationEndBeforeStart: "${msg_course_validation_endBeforeStart_js}",
        validationSpotRequired: "${msg_course_validation_spotRequired_js}",
        validationPlaceRequired: "${msg_course_validation_placeRequired_js}",
        validationVisitDateRequired: "${msg_course_validation_visitDateRequired_js}",
        validationVisitOrderRequired: "${msg_course_validation_visitOrderRequired_js}",
        validationDuplicateVisitOrder: "${msg_course_validation_duplicateVisitOrder_js}"
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
