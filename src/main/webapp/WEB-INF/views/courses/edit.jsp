<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_courses_common_spotIndexed_js" code="courses.common.spotIndexed" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_filter_allSpots_js" code="courses.common.filter.allSpots" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_filter_result_js" code="courses.common.filter.result" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_value_emptyInput_js" code="courses.common.value.emptyInput" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_visibility_public_js" code="courses.common.visibility.public" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_visibility_private_js" code="courses.common.visibility.private" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_delete_js" code="courses.common.delete" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_field_placeName_js" code="courses.common.field.placeName" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_placeholder_placeExample_js" code="courses.common.placeholder.placeExample" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_help_placeStored_js" code="courses.common.help.placeStored" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_field_visitDate_js" code="courses.common.field.visitDate" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_field_visitOrder_js" code="courses.common.field.visitOrder" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_countWithUnit_js" code="courses.common.countWithUnit" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_confirm_deleteSpot_js" code="courses.common.confirm.deleteSpot" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_minSpot_js" code="courses.common.alert.minSpot" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_placeRequired_js" code="courses.common.alert.placeRequired" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_visitDateRequired_js" code="courses.common.alert.visitDateRequired" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_orderRequired_js" code="courses.common.alert.orderRequired" javaScriptEscape="true"/>
<spring:message var="msg_courses_common_alert_duplicateOrder_js" code="courses.common.alert.duplicateOrder" javaScriptEscape="true"/>
<spring:message var="msg_course_write_dateFormatHint_js" code="course.write.dateFormatHint" javaScriptEscape="true"/>
<spring:message var="msg_course_write_notEntered_js" code="course.write.notEntered" javaScriptEscape="true"/>
<spring:message var="msg_course_write_countSuffix_js" code="course.write.countSuffix" javaScriptEscape="true"/>
<spring:message var="msg_course_badge_public_js" code="course.badge.public" javaScriptEscape="true"/>
<spring:message var="msg_course_badge_private_js" code="course.badge.private" javaScriptEscape="true"/>
<spring:message var="msg_course_form_spotLabel_js" code="course.form.spotLabel" javaScriptEscape="true"/>
<spring:message var="msg_course_action_delete_js" code="course.action.delete" javaScriptEscape="true"/>
<spring:message var="msg_course_form_placeName_js" code="course.form.placeName" javaScriptEscape="true"/>
<spring:message var="msg_course_form_visitDate_js" code="course.form.visitDate" javaScriptEscape="true"/>
<spring:message var="msg_course_form_visitOrder_js" code="course.form.visitOrder" javaScriptEscape="true"/>
<spring:message var="msg_course_edit_placePlaceholder_js" code="course.edit.placePlaceholder" javaScriptEscape="true"/>
<spring:message var="msg_course_write_placeFieldMsg_js" code="course.write.placeFieldMsg" javaScriptEscape="true"/>
<spring:message var="msg_course_edit_filterAllVisible_js" code="course.edit.filterAllVisible" javaScriptEscape="true"/>
<spring:message var="msg_course_edit_filterVisiblePrefix_js" code="course.edit.filterVisiblePrefix" javaScriptEscape="true"/>
<spring:message var="msg_course_edit_filterVisibleSuffix_js" code="course.edit.filterVisibleSuffix" javaScriptEscape="true"/>
<spring:message var="msg_course_edit_confirmRemoveSpot_js" code="course.edit.confirmRemoveSpot" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_spotRequired_js" code="course.validation.spotRequired" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_placeRequired_js" code="course.validation.placeRequired" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_visitDateRequired_js" code="course.validation.visitDateRequired" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_visitOrderRequired_js" code="course.validation.visitOrderRequired" javaScriptEscape="true"/>
<spring:message var="msg_course_validation_duplicateVisitOrder_js" code="course.validation.duplicateVisitOrder" javaScriptEscape="true"/>
<spring:message var="msg_course_edit_backToDetail" code="course.edit.backToDetail"/>
<spring:message var="msg_course_detail_edit_title" code="course.detail.edit.title"/>
<spring:message var="msg_course_detail_edit_desc" code="course.detail.edit.desc"/>
<spring:message var="msg_course_edit_statusEditing" code="course.edit.statusEditing"/>
<spring:message var="msg_course_write_basicInfo" code="course.write.basicInfo"/>
<spring:message var="msg_course_edit_basicInfoDesc" code="course.edit.basicInfoDesc"/>
<spring:message var="msg_course_form_title" code="course.form.title"/>
<spring:message var="msg_course_form_destination" code="course.form.destination"/>
<spring:message var="msg_course_write_destinationFieldMsg" code="course.write.destinationFieldMsg"/>
<spring:message var="msg_course_form_startDate" code="course.form.startDate"/>
<spring:message var="msg_course_write_dateFormatHint" code="course.write.dateFormatHint"/>
<spring:message var="msg_course_form_endDate" code="course.form.endDate"/>
<spring:message var="msg_course_write_visitSpots" code="course.write.visitSpots"/>
<spring:message var="msg_course_edit_visitSpotsDesc" code="course.edit.visitSpotsDesc"/>
<spring:message var="msg_course_edit_spotHelper" code="course.edit.spotHelper"/>
<spring:message var="msg_course_detail_filterGuide" code="course.detail.filterGuide"/>
<spring:message var="msg_course_action_resetFilter" code="course.action.resetFilter"/>
<spring:message var="msg_course_edit_filterAllVisible" code="course.edit.filterAllVisible"/>
<spring:message var="msg_course_form_spotLabel" code="course.form.spotLabel"/>
<spring:message var="msg_course_action_delete" code="course.action.delete"/>
<spring:message var="msg_course_form_placeName" code="course.form.placeName"/>
<spring:message var="msg_course_write_placeFieldMsg" code="course.write.placeFieldMsg"/>
<spring:message var="msg_course_form_visitDate" code="course.form.visitDate"/>
<spring:message var="msg_course_form_visitOrder" code="course.form.visitOrder"/>
<spring:message var="msg_course_action_addSpot" code="course.action.addSpot"/>
<spring:message var="msg_course_write_publicSetting" code="course.write.publicSetting"/>
<spring:message var="msg_course_edit_publicSettingDesc" code="course.edit.publicSettingDesc"/>
<spring:message var="msg_course_write_publicToggle" code="course.write.publicToggle"/>
<spring:message var="msg_course_edit_publicToggleDesc" code="course.edit.publicToggleDesc"/>
<spring:message var="msg_course_write_summary" code="course.write.summary"/>
<spring:message var="msg_course_edit_summaryDesc" code="course.edit.summaryDesc"/>
<spring:message var="msg_course_common_travelPeriod" code="course.common.travelPeriod"/>
<spring:message var="msg_course_form_spotCount" code="course.form.spotCount"/>
<spring:message var="msg_course_write_countSuffix" code="course.write.countSuffix"/>
<spring:message var="msg_course_form_publicStatus" code="course.form.publicStatus"/>
<spring:message var="msg_course_badge_public" code="course.badge.public"/>
<spring:message var="msg_course_badge_private" code="course.badge.private"/>
<spring:message var="msg_course_action_cancel" code="course.action.cancel"/>
<spring:message var="msg_course_edit_completeEdit" code="course.edit.completeEdit"/>
<%@ include file="../common/header.jsp" %>

<c:set var="planSourceValue" value="${empty travelPlan.plan_source ? 'manual' : travelPlan.plan_source}" />
<fmt:setLocale value="${pageContext.response.locale}" />
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
            ${msg_course_edit_backToDetail}
        </a>

        <div class="page-header">
            <div>
                <h1 class="page-title">${msg_course_detail_edit_title}</h1>
                <p class="page-desc">${msg_course_detail_edit_desc}</p>
            </div>
            <div class="status-chip">${msg_course_edit_statusEditing}</div>
        </div>

        <form id="travelPlanForm" action="${pageContext.request.contextPath}/courses/edit" method="post">
            <input type="hidden" name="plan_id" value="${travelPlan.plan_id}">
            <input type="hidden" name="plan_source" value="${planSourceValue}">
            <input type="hidden" id="isPublic" name="is_public" value="${travelPlan.is_public}">

            <div class="edit-layout">
                <div class="edit-main">
                    <section class="card content-card">
                        <div class="card-head">
                            <h2>${msg_course_write_basicInfo}</h2>
                            <p>${msg_course_edit_basicInfoDesc}</p>
                        </div>

                        <div class="card-body">
                            <div class="form-group">
                                <label class="form-label" for="title">${msg_course_form_title}</label>
                                <input type="text"
                                       id="title"
                                       name="title"
                                       class="form-input"
                                       value="${travelPlan.title}"
                                       required>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="destination">${msg_course_form_destination}</label>
                                <input type="text"
                                       id="destination"
                                       name="destination"
                                       class="form-input"
                                       value="${travelPlan.destination}"
                                       autocomplete="off"
                                       required>
                                <div class="field-msg">
                                    ${msg_course_write_destinationFieldMsg}
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label" for="startDate">${msg_course_form_startDate}</label>
                                    <input type="date"
                                           id="startDate"
                                           name="start_date"
                                           class="form-input"
                                           value="${startDateFormatted}"
                                           aria-describedby="editStartDateFormatHint"
                                           required>
                                    <div class="field-msg" id="editStartDateFormatHint">${msg_course_write_dateFormatHint}</div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="endDate">${msg_course_form_endDate}</label>
                                    <input type="date"
                                           id="endDate"
                                           name="end_date"
                                           class="form-input"
                                           value="${endDateFormatted}"
                                           aria-describedby="editEndDateFormatHint"
                                           required>
                                    <div class="field-msg" id="editEndDateFormatHint">${msg_course_write_dateFormatHint}</div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="card content-card">
                        <div class="card-head">
                            <h2>${msg_course_write_visitSpots}</h2>
                            <p>${msg_course_edit_visitSpotsDesc}</p>
                        </div>

                        <div class="card-body">
                            <div class="field-msg" style="margin-bottom:16px;">
                                ${msg_course_edit_spotHelper}
                            </div>

                            <div class="spot-filter-bar">
                                <div class="spot-filter-left">
                                    <label for="spotDateFilter" class="spot-filter-label">${msg_course_detail_filterGuide}</label>
                                    <input type="date" id="spotDateFilter" class="spot-filter-input">
                                    <div class="field-msg">${msg_course_write_dateFormatHint}</div>
                                    <button type="button" id="resetSpotFilterBtn" class="spot-filter-reset">${msg_course_action_resetFilter}</button>
                                </div>
                                <div class="spot-filter-right" id="spotFilterResultText">${msg_course_edit_filterAllVisible}</div>
                            </div>

                            <div id="spotList" class="spot-list">
                                <c:forEach var="spot" items="${travelPlan.spotList}" varStatus="s">
                                    <fmt:formatDate value="${spot.visit_date}" pattern="yyyy-MM-dd" var="spotVisitDate"/>

                                    <div class="spot-item" data-visit-date="${spotVisitDate}">
                                        <div class="spot-head">
                                            <div class="spot-head-left">
                                                <span class="spot-badge">${s.index + 1}</span>
                                                <span>${msg_course_form_spotLabel} ${s.index + 1}</span>
                                            </div>
                                            <button type="button" class="remove-btn">${msg_course_action_delete}</button>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">${msg_course_form_placeName}</label>
                                            <input type="text"
                                                   class="form-input"
                                                   data-field="place_name"
                                                   name="spotList[${s.index}].place_name"
                                                   value="${spot.place_name}"
                                                   required>
                                            <div class="field-msg">${msg_course_write_placeFieldMsg}</div>
                                        </div>

                                        <div class="form-row" style="margin-top:16px;">
                                            <div class="form-group">
                                                <label class="form-label">${msg_course_form_visitDate}</label>
                                                <input type="date"
                                                       class="form-input"
                                                       data-field="visit_date"
                                                       name="spotList[${s.index}].visit_date"
                                                       value="${spotVisitDate}"
                                                       required>
                                                <div class="field-msg">${msg_course_write_dateFormatHint}</div>
                                            </div>

                                            <div class="form-group">
                                                <label class="form-label">${msg_course_form_visitOrder}</label>
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
                                + ${msg_course_action_addSpot}
                            </button>
                        </div>
                    </section>
                </div>

                <aside class="edit-side">
                    <section class="card content-card">
                        <div class="card-head">
                            <h2>${msg_course_write_publicSetting}</h2>
                            <p>${msg_course_edit_publicSettingDesc}</p>
                        </div>

                        <div class="card-body">
                            <div class="toggle-row">
                                <div>
                                    <div class="form-label" style="margin-bottom:6px;">${msg_course_write_publicToggle}</div>
                                    <div class="field-msg">${msg_course_edit_publicToggleDesc}</div>
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
                            <h2>${msg_course_write_summary}</h2>
                            <p>${msg_course_edit_summaryDesc}</p>
                        </div>

                        <div class="card-body">
                            <div class="summary-box">
                                <div class="summary-row">
                                    <span>${msg_course_form_title}</span>
                                    <strong id="summaryTitle">${travelPlan.title}</strong>
                                </div>
                                <div class="summary-row">
                                    <span>${msg_course_form_destination}</span>
                                    <strong id="summaryDestination">${travelPlan.destination}</strong>
                                </div>
                                <div class="summary-row">
                                    <span>${msg_course_common_travelPeriod}</span>
                                    <strong id="summaryPeriod">${startDateFormatted} ~ ${endDateFormatted}</strong>
                                </div>
                                <div class="summary-row">
                                    <span>${msg_course_form_spotCount}</span>
                                    <strong id="summaryCount"><c:out value="${fn:length(travelPlan.spotList)}"/>${msg_course_write_countSuffix}</strong>
                                </div>
                                <div class="summary-row">
                                    <span>${msg_course_form_publicStatus}</span>
                                    <strong id="summaryPublic">
                                        <c:choose>
                                            <c:when test="${travelPlan.is_public == 1}">${msg_course_badge_public}</c:when>
                                            <c:otherwise>${msg_course_badge_private}</c:otherwise>
                                        </c:choose>
                                    </strong>
                                </div>
                            </div>

                            <div class="form-actions" style="margin-top:24px;">
                                <a href="${pageContext.request.contextPath}/courses/detail?planId=${travelPlan.plan_id}"
                                   class="secondary-btn">${msg_course_action_cancel}</a>
                                <button type="submit" class="primary-btn">${msg_course_edit_completeEdit}</button>
                            </div>
                        </div>
                    </section>
                </aside>
            </div>
        </form>
    </div>
</main>

<script>
    const courseEditMessages = {
        spotIndexed: "${msg_courses_common_spotIndexed_js}",
        allSpots: "${msg_courses_common_filter_allSpots_js}",
        filterResult: "${msg_courses_common_filter_result_js}",
        emptyInput: "${msg_courses_common_value_emptyInput_js}",
        publicLabel: "${msg_courses_common_visibility_public_js}",
        privateLabel: "${msg_courses_common_visibility_private_js}",
        deleteLabel: "${msg_courses_common_delete_js}",
        placeNameLabel: "${msg_courses_common_field_placeName_js}",
        placePlaceholder: "${msg_courses_common_placeholder_placeExample_js}",
        placeHelp: "${msg_courses_common_help_placeStored_js}",
        visitDateLabel: "${msg_courses_common_field_visitDate_js}",
        visitOrderLabel: "${msg_courses_common_field_visitOrder_js}",
        countWithUnit: "${msg_courses_common_countWithUnit_js}",
        deleteSpotConfirm: "${msg_courses_common_confirm_deleteSpot_js}",
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

    const COURSE_EDIT_TEXT = {
        spotLabel: "${msg_course_form_spotLabel_js}",
        deleteLabel: "${msg_course_action_delete_js}",
        placeNameLabel: "${msg_course_form_placeName_js}",
        visitDateLabel: "${msg_course_form_visitDate_js}",
        visitOrderLabel: "${msg_course_form_visitOrder_js}",
        placePlaceholder: "${msg_course_edit_placePlaceholder_js}",
        placeFieldMsg: "${msg_course_write_placeFieldMsg_js}",
        dateFormatHint: "${msg_course_write_dateFormatHint_js}",
        notEntered: "${msg_course_write_notEntered_js}",
        countSuffix: "${msg_course_write_countSuffix_js}",
        publicLabel: "${msg_course_badge_public_js}",
        privateLabel: "${msg_course_badge_private_js}",
        filterAllVisible: "${msg_course_edit_filterAllVisible_js}",
        filterVisiblePrefix: "${msg_course_edit_filterVisiblePrefix_js}",
        filterVisibleSuffix: "${msg_course_edit_filterVisibleSuffix_js}",
        confirmRemoveSpot: "${msg_course_edit_confirmRemoveSpot_js}",
        validationSpotRequired: "${msg_course_validation_spotRequired_js}",
        validationPlaceRequired: "${msg_course_validation_placeRequired_js}",
        validationVisitDateRequired: "${msg_course_validation_visitDateRequired_js}",
        validationVisitOrderRequired: "${msg_course_validation_visitOrderRequired_js}",
        validationDuplicateVisitOrder: "${msg_course_validation_duplicateVisitOrder_js}"
    };

    function refreshSpotIndexes() {
        const items = spotListEl.querySelectorAll(".spot-item");

        items.forEach(function (item, index) {
            const badge = item.querySelector(".spot-badge");
            const title = item.querySelector(".spot-head-left span:last-child");

            const placeInput = item.querySelector('[data-field="place_name"]');
            const visitDateInput = item.querySelector('[data-field="visit_date"]');
            const visitOrderInput = item.querySelector('[data-field="visit_order"]');

            if (badge) badge.textContent = index + 1;
            if (title) title.textContent = COURSE_EDIT_TEXT.spotLabel + " " + (index + 1);

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
                spotFilterResultTextEl.textContent = COURSE_EDIT_TEXT.filterAllVisible;
            } else {
                spotFilterResultTextEl.textContent = selectedDate + " · " + COURSE_EDIT_TEXT.filterVisiblePrefix + visibleCount + COURSE_EDIT_TEXT.countSuffix + COURSE_EDIT_TEXT.filterVisibleSuffix;
            }
        }
    }

    function updateSummary() {
        if (summaryTitleEl) {
            summaryTitleEl.textContent = titleEl.value.trim() || COURSE_EDIT_TEXT.notEntered;
        }

        if (summaryDestinationEl) {
            summaryDestinationEl.textContent = destinationEl.value.trim() || COURSE_EDIT_TEXT.notEntered;
        }

        if (summaryPeriodEl) {
            if (startDateEl.value && endDateEl.value) {
                summaryPeriodEl.textContent = startDateEl.value + " ~ " + endDateEl.value;
            } else {
                summaryPeriodEl.textContent = COURSE_EDIT_TEXT.notEntered;
            }
        }

        if (summaryCountEl) {
            summaryCountEl.textContent = spotListEl.querySelectorAll(".spot-item").length + COURSE_EDIT_TEXT.countSuffix;
        }

        if (summaryPublicEl) {
            summaryPublicEl.textContent = isPublicEl.value === "1" ? COURSE_EDIT_TEXT.publicLabel : COURSE_EDIT_TEXT.privateLabel;
        }
    }

    function buildSpotHtml(index) {
        const defaultDate = startDateEl.value || "";
        const nextOrder = spotListEl.querySelectorAll(".spot-item").length + 1;

        return ''
            + '<div class="spot-head">'
            + '    <div class="spot-head-left">'
            + '        <span class="spot-badge">' + (index + 1) + '</span>'
            + '        <span>' + COURSE_EDIT_TEXT.spotLabel + ' ' + (index + 1) + '</span>'
            + '    </div>'
            + '    <button type="button" class="remove-btn">' + COURSE_EDIT_TEXT.deleteLabel + '</button>'
            + '</div>'
            + '<div class="form-group">'
            + '    <label class="form-label">' + COURSE_EDIT_TEXT.placeNameLabel + '</label>'
            + '    <input type="text"'
            + '           class="form-input"'
            + '           data-field="place_name"'
            + '           placeholder="' + COURSE_EDIT_TEXT.placePlaceholder + '"'
            + '           required>'
            + '    <div class="field-msg">' + COURSE_EDIT_TEXT.placeFieldMsg + '</div>'
            + '</div>'
            + '<div class="form-row" style="margin-top:16px;">'
            + '    <div class="form-group">'
            + '        <label class="form-label">' + COURSE_EDIT_TEXT.visitDateLabel + '</label>'
            + '        <input type="date"'
            + '               class="form-input"'
            + '               data-field="visit_date"'
            + '               value="' + defaultDate + '"'
            + '               required>'
            + '        <div class="field-msg">' + COURSE_EDIT_TEXT.dateFormatHint + '</div>'
            + '    </div>'
            + '    <div class="form-group">'
            + '        <label class="form-label">' + COURSE_EDIT_TEXT.visitOrderLabel + '</label>'
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

            if (!confirm(COURSE_EDIT_TEXT.confirmRemoveSpot)) return;

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
            alert(COURSE_EDIT_TEXT.validationSpotRequired);
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
                alert(COURSE_EDIT_TEXT.validationPlaceRequired);
                placeInput.focus();
                e.preventDefault();
                return;
            }

            if (!visitDate) {
                alert(COURSE_EDIT_TEXT.validationVisitDateRequired);
                visitDateInput.focus();
                e.preventDefault();
                return;
            }

            if (!visitOrder || Number(visitOrder) < 1) {
                alert(COURSE_EDIT_TEXT.validationVisitOrderRequired);
                visitOrderInput.focus();
                e.preventDefault();
                return;
            }

            const duplicateKey = visitDate + "__" + visitOrder;
            if (duplicateCheck.has(duplicateKey)) {
                alert(COURSE_EDIT_TEXT.validationDuplicateVisitOrder);
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
