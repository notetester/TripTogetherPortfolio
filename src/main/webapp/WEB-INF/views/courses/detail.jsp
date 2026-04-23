<%--<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/variables.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css">

<%@ include file="../common/header.jsp" %>
<fmt:setLocale value="${pageContext.response.locale}" />

<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <title><spring:message code="courses.detail.pageTitle" /></title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Pretendard", "Noto Sans KR", Arial, sans-serif;
            background: #f3f5f9;
            color: #1f2937;
        }

        .page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 56px 32px 80px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 30px;
        }

        .title-wrap h1 {
            margin: 0;
            font-size: 42px;
            font-weight: 800;
            letter-spacing: -0.8px;
            color: #1f2937;
        }

        .title-wrap p {
            margin: 10px 0 0;
            font-size: 16px;
            color: #6b7280;
        }

        .top-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            height: 44px;
            padding: 0 18px;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s ease;
        }

        .btn-primary {
            background: #3366ff;
            color: #fff;
            box-shadow: 0 8px 20px rgba(51, 102, 255, 0.18);
        }

        .btn-primary:hover {
            background: #2557f5;
        }

        .btn-light {
            background: #fff;
            color: #1f2937;
            border: 1px solid #dbe2ea;
        }

        .btn-light:hover {
            background: #f8fafc;
        }

        .btn-danger {
            background: #fff;
            color: #ef4444;
            border: 1px solid #fecaca;
        }

        .btn-danger:hover {
            background: #fff5f5;
        }

        .layout {
            display: grid;
            grid-template-columns: 360px minmax(0, 1fr);
            gap: 24px;
            align-items: start;
        }

        .card {
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.06);
        }

        .summary-card {
            padding: 28px 26px;
            position: sticky;
            top: 24px;
        }

        .summary-head {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 20px;
        }

        .summary-title {
            margin: 0;
            font-size: 32px;
            font-weight: 800;
            line-height: 1.25;
            letter-spacing: -0.6px;
            color: #111827;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 52px;
            height: 30px;
            padding: 0 12px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 700;
            flex-shrink: 0;
        }

        .badge-public {
            background: #dbeafe;
            color: #2563eb;
        }

        .badge-private {
            background: #f3f4f6;
            color: #6b7280;
        }

        .info-list {
            margin-top: 12px;
            border-top: 1px solid #edf1f5;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            padding: 14px 0;
            border-bottom: 1px solid #edf1f5;
            font-size: 15px;
        }

        .info-label {
            color: #6b7280;
            flex-shrink: 0;
        }

        .info-value {
            color: #111827;
            font-weight: 600;
            text-align: right;
            word-break: keep-all;
        }

        .content-card {
            padding: 26px;
        }

        .section-title {
            margin: 0 0 6px;
            font-size: 24px;
            font-weight: 800;
            color: #111827;
            letter-spacing: -0.4px;
        }

        .section-desc {
            margin: 0 0 22px;
            color: #6b7280;
            font-size: 14px;
        }

        .spot-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .spot-item {
            border: 1px solid #e8edf3;
            border-radius: 18px;
            padding: 20px 22px;
            background: #fcfdff;
        }

        .spot-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 14px;
            margin-bottom: 12px;
        }

        .spot-order {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: #eff4ff;
            color: #3366ff;
            font-size: 14px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .spot-title-wrap {
            display: flex;
            gap: 12px;
            align-items: flex-start;
            min-width: 0;
        }

        .spot-name {
            margin: 1px 0 4px;
            font-size: 19px;
            font-weight: 800;
            color: #111827;
            letter-spacing: -0.2px;
        }

        .spot-region {
            font-size: 13px;
            color: #5b7fff;
            font-weight: 700;
        }

        .spot-date {
            flex-shrink: 0;
            display: inline-flex;
            align-items: center;
            height: 32px;
            padding: 0 12px;
            border-radius: 999px;
            background: #f3f6fb;
            color: #475569;
            font-size: 13px;
            font-weight: 700;
        }

        .spot-meta {
            display: grid;
            grid-template-columns: 120px 1fr;
            row-gap: 10px;
            column-gap: 12px;
            margin-top: 10px;
            font-size: 14px;
        }

        .spot-meta-label {
            color: #6b7280;
        }

        .spot-meta-value {
            color: #1f2937;
            font-weight: 600;
        }

        .detail-filter-bar {
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

        .spot-filter-input:focus {
            outline: none;
            border-color: #6c7cff;
            box-shadow: 0 0 0 4px rgba(108, 124, 255, 0.12);
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

        .filtered-empty {
            display: none;
            margin-top: 14px;
            border: 1px dashed #d7e0ea;
            border-radius: 18px;
            background: #fafcff;
            padding: 32px 20px;
            text-align: center;
            color: #6b7280;
        }

        .empty-box {
            border: 1px dashed #d7e0ea;
            border-radius: 18px;
            background: #fafcff;
            padding: 48px 24px;
            text-align: center;
            color: #6b7280;
        }

        .bottom-actions {
            margin-top: 26px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .inline-form {
            margin: 0;
        }

        @media (max-width: 980px) {
            .layout {
                grid-template-columns: 1fr;
            }

            .summary-card {
                position: static;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
            }

            .title-wrap h1 {
                font-size: 34px;
            }
        }

        @media (max-width: 640px) {
            .page {
                padding: 32px 18px 56px;
            }

            .content-card,
            .summary-card {
                padding: 22px 18px;
                border-radius: 20px;
            }

            .summary-title {
                font-size: 26px;
            }

            .spot-top {
                flex-direction: column;
                align-items: flex-start;
            }

            .spot-meta {
                grid-template-columns: 1fr;
            }

            .detail-filter-bar {
                display: flex;
                justify-content: space-between;
                align-items: flex-end;
                gap: 16px;
                flex-wrap: wrap;
                margin-bottom: 20px;
            }

            .filter-box {
                display: flex;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .filter-label {
                font-size: 13px;
                font-weight: 700;
                color: #6b7280;
            }

            .date-filter-input {
                height: 40px;
                padding: 0 12px;
                border: 1px solid #dbe2ea;
                border-radius: 10px;
                font-size: 14px;
                background: #fff;
                color: #1f2937;
            }

            .filter-reset-btn {
                height: 40px;
                padding: 0 14px;
                border: 1px solid #dbe2ea;
                border-radius: 10px;
                background: #fff;
                color: #475569;
                font-size: 13px;
                font-weight: 700;
                cursor: pointer;
            }

            .filter-reset-btn:hover {
                background: #f8fafc;
            }

            .filtered-empty {
                display: none;
                margin-top: 14px;
                border: 1px dashed #d7e0ea;
                border-radius: 18px;
                background: #fafcff;
                padding: 32px 20px;
                text-align: center;
                color: #6b7280;
            }
        }
        .form-row-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 16px;
        }

        .form-group2 {
            margin-bottom: 16px;
        }

        .form-label2 {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 800;
            color: #334155;
        }

        .form-sub2 {
            font-size: 12px;
            color: #94a3b8;
        }

        .form-input2 {
            width: 100%;
            height: 46px;
            border: 1px solid #dbe2ea;
            border-radius: 12px;
            padding: 0 14px;
            font-size: 14px;
            color: #111827;
            background: #fff;
            outline: none;
        }

        .form-input2:focus {
            border-color: #3366ff;
            box-shadow: 0 0 0 4px rgba(51, 102, 255, 0.08);
        }

        .toggle-wrap2 {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0 20px;
            border-bottom: 1px solid #edf1f5;
            margin-bottom: 20px;
        }

        .edit-spot-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .edit-spot-head h4 {
            margin: 0;
            font-size: 18px;
            font-weight: 800;
            color: #111827;
        }

        .edit-spot-item {
            border: 1px solid #e8edf3;
            border-radius: 16px;
            padding: 18px;
            background: #fcfdff;
            margin-bottom: 14px;
        }

        .edit-spot-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 14px;
        }

        .remove-mini-btn {
            padding: 8px 12px;
            border-radius: 10px;
            border: 1px solid #fecaca;
            background: #fff;
            color: #ef4444;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
        }

        .edit-submit-row {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>
<div class="page active">

    <div class="top-bar">
        <div class="title-wrap">
            <h1><spring:message code="courses.detail.header.title" /></h1>
            <p><spring:message code="courses.detail.header.desc" /></p>
        </div>

        <div class="top-actions">
            <a href="${pageContext.request.contextPath}/courses/list" class="btn btn-light"><spring:message code="courses.common.backToList" /></a>

            <c:if test="${isOwner}">
                <div class="detail-btn-group">
                    <a href="${pageContext.request.contextPath}/courses/edit?planId=${travelPlan.plan_id}" class="detail-btn edit">
                        <spring:message code="courses.common.action.editPlan" />
                    </a>

                    <form method="post"
                          action="${pageContext.request.contextPath}/courses/delete"
                          onsubmit="return confirm('<spring:message code="courses.common.confirm.deletePlan" javaScriptEscape="true" />');"
                          style="display:inline;">
                        <input type="hidden" name="planId" value="${travelPlan.plan_id}">
                        <button type="submit" class="detail-btn delete"><spring:message code="courses.common.action.deletePlan" /></button>
                    </form>
                </div>
            </c:if>
        </div>
    </div>

    <div class="layout">
        <!-- 왼쪽 요약 카드 -->
        <div class="card summary-card">
            <div class="summary-head">
                <h2 class="summary-title">
                    <c:out value="${travelPlan.title}" />
                </h2>

                <c:choose>
                    <c:when test="${travelPlan.is_public == 1}">
                        <span class="badge badge-public"><spring:message code="courses.common.visibility.public" /></span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-private"><spring:message code="courses.common.visibility.private" /></span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="info-list">
                <div class="info-row">
                    <div class="info-label"><spring:message code="courses.common.field.destination" /></div>
                    <div class="info-value">
                        <c:out value="${travelPlan.destination}" />
                    </div>
                </div>

                <div class="info-row">
                    <div class="info-label"><spring:message code="courses.common.field.startDate" /></div>
                    <div class="info-value">
                        <fmt:formatDate value="${travelPlan.start_date}" type="date" dateStyle="medium"/>
                    </div>
                </div>

                <div class="info-row">
                    <div class="info-label"><spring:message code="courses.common.field.endDate" /></div>
                    <div class="info-value">
                        <fmt:formatDate value="${travelPlan.end_date}" type="date" dateStyle="medium"/>
                    </div>
                </div>

<%--                <div class="info-row">--%>
<%--                    <div class="info-label">일정 번호</div>--%>
<%--                    <div class="info-value">--%>
<%--                        <c:out value="${travelPlan.plan_id}" />--%>
<%--                    </div>--%>
<%--                </div>--%>

                <div class="info-row">
                    <div class="info-label"><spring:message code="courses.common.field.spotCount" /></div>
                    <div class="info-value">
                        <spring:message code="courses.common.countWithUnit" arguments="${travelPlan.spotList.size()}" />
                    </div>
                </div>
            </div>
            <c:if test="${isOwner}">
                <div class="bottom-actions">
                    <a href="${pageContext.request.contextPath}/courses/edit?planId=${travelPlan.plan_id}"
                       class="btn btn-primary">
                        <spring:message code="courses.common.action.editPlan" />
                    </a>

                    <form class="inline-form" method="post"
                          action="${pageContext.request.contextPath}/courses/delete"
                          onsubmit="return confirm('<spring:message code="courses.common.confirm.deletePlanAlt" javaScriptEscape="true" />');">
                        <input type="hidden" name="planId" value="${travelPlan.plan_id}">
                        <button type="submit" class="btn btn-danger"><spring:message code="courses.common.action.deletePlan" /></button>
                    </form>
                </div>
            </c:if>

            <c:if test="${not isOwner}">
                <div class="bottom-actions" style="justify-content:flex-start;">
                    <div style="font-size:14px; color:#6b7280; font-weight:600;">
                        <spring:message code="courses.common.ownerNotice" />
                    </div>
                </div>
            </c:if>
        </div>

        <!-- 오른쪽 여행지 목록 -->
        <div class="card content-card">
            <div>
                <h3 class="section-title"><spring:message code="courses.detail.section.spots.title" /></h3>
                <p class="section-desc"><spring:message code="courses.detail.section.spots.desc" /></p>
            </div>

            <div class="detail-filter-bar">
                <div class="spot-filter-left">
                    <label for="dateFilter" class="spot-filter-label"><spring:message code="courses.common.field.dateFilter" /></label>
                    <input type="date" id="dateFilter" class="spot-filter-input">
                    <button type="button" class="spot-filter-reset" onclick="resetDateFilter()"><spring:message code="courses.common.action.showAll" /></button>
                </div>
                <div class="spot-filter-right">
                    <spring:message code="courses.common.filter.hint" />
                </div>
            </div>

            <c:choose>
                <c:when test="${empty travelPlan.spotList}">
                    <div class="empty-box">
                        <spring:message code="courses.detail.emptySpots" />
                    </div>
                </c:when>
                <c:otherwise>
                    <c:set var="prevDate" value="" />
                    <c:set var="dayOrder" value="0" />

                    <div class="spot-list" id="spotListArea">
                        <c:forEach var="spot" items="${travelPlan.spotList}">
                            <fmt:formatDate value="${spot.visit_date}" pattern="yyyy-MM-dd" var="visitDateStr"/>

                            <c:choose>
                                <c:when test="${prevDate ne visitDateStr}">
                                    <c:set var="prevDate" value="${visitDateStr}" />
                                    <c:set var="dayOrder" value="1" />
                                </c:when>
                                <c:otherwise>
                                    <c:set var="dayOrder" value="${dayOrder + 1}" />
                                </c:otherwise>
                            </c:choose>

                            <div class="spot-item" data-visit-date="${visitDateStr}">
                                <div class="spot-top">
                                    <div class="spot-title-wrap">
                                        <div class="spot-order">
                                            <c:out value="${dayOrder}" />
                                        </div>
                                        <div>
                                            <div class="spot-name">
                                                <c:out value="${spot.place_name}" />
                                            </div>
                                            <div class="spot-region">
                                                <c:out value="${travelPlan.destination}" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="spot-date">
                                        <c:out value="${visitDateStr}" />
                                    </div>
                                </div>

                                <div class="spot-meta">
                                    <div class="spot-meta-label"><spring:message code="courses.common.field.placeName" /></div>
                                    <div class="spot-meta-value">
                                        <c:out value="${spot.place_name}" />
                                    </div>

                                    <div class="spot-meta-label"><spring:message code="courses.common.field.visitDate" /></div>
                                    <div class="spot-meta-value">
                                        <c:out value="${visitDateStr}" />
                                    </div>

<%--                                    <div class="spot-meta-label">날짜 내 순서</div>--%>
<%--                                    <div class="spot-meta-value">--%>
<%--                                        <c:out value="${dayOrder}" />번째--%>
<%--                                    </div>--%>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="filtered-empty" id="filteredEmpty">
                        <spring:message code="courses.common.filter.empty" />
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="card content-card" id="editCard" style="display:none; margin-top:24px;">
            <h3 class="section-title"><spring:message code="courses.detail.section.edit.title" /></h3>
            <p class="section-desc"><spring:message code="courses.detail.section.edit.desc" /></p>

            <form id="editForm"
                  action="${pageContext.request.contextPath}/courses/edit"
                  method="post">

                <input type="hidden" name="plan_id" value="${travelPlan.plan_id}">
                <input type="hidden" id="editIsPublic" name="is_public" value="${travelPlan.is_public}">

                <datalist id="editCityOptionList">
                    <c:forEach var="city" items="${spotTravelList}">
                        <option value="${city.name}"></option>
                    </c:forEach>
                </datalist>

                <div class="form-row-2">
                    <div class="form-group2">
                        <label class="form-label2"><spring:message code="courses.common.field.title" /></label>
                        <input type="text" name="title" class="form-input2"
                               value="${travelPlan.title}" required>
                    </div>

                    <div class="form-group2">
                        <label class="form-label2"><spring:message code="courses.common.field.destination" /></label>
                        <input type="text" name="destination" class="form-input2"
                               list="editCityOptionList"
                               value="${travelPlan.destination}" required>
                    </div>
                </div>

                <div class="form-row-2">
                    <div class="form-group2">
                        <label class="form-label2"><spring:message code="courses.common.field.startDate" /></label>
                        <fmt:formatDate value="${travelPlan.start_date}" pattern="yyyy-MM-dd" var="startDateStr"/>
                        <input type="date" name="start_date" class="form-input2"
                               value="${startDateStr}" required>
                    </div>

                    <div class="form-group2">
                        <label class="form-label2"><spring:message code="courses.common.field.endDate" /></label>
                        <fmt:formatDate value="${travelPlan.end_date}" pattern="yyyy-MM-dd" var="endDateStr"/>
                        <input type="date" name="end_date" class="form-input2"
                               value="${endDateStr}" required>
                    </div>
                </div>

                <div class="toggle-wrap2">
                    <div>
                        <div class="form-label2" style="margin-bottom:4px;"><spring:message code="courses.common.field.publicVisibility" /></div>
                        <div class="form-sub2"><spring:message code="courses.detail.edit.visibility.desc" /></div>
                    </div>

                    <label class="toggle-switch">
                        <input type="checkbox" id="editPublicToggle" <c:if test="${travelPlan.is_public == 1}">checked</c:if>>
                        <span class="toggle-slider"></span>
                    </label>
                </div>

                <div class="edit-spot-head">
                    <h4><spring:message code="courses.detail.edit.spotsTitle" /></h4>
                    <button type="button" class="btn btn-light" onclick="addEditSpot()"><spring:message code="courses.common.action.addSpot" /></button>
                </div>

                <div id="editSpotList">
                    <c:forEach var="spot" items="${travelPlan.spotList}" varStatus="s">
                        <fmt:formatDate value="${spot.visit_date}" pattern="yyyy-MM-dd" var="spotDateStr"/>
                        <div class="edit-spot-item">
                            <input type="hidden" data-field="spot_id" name="spotList[${s.index}].spot_id" value="${spot.spot_id}">

                            <div class="edit-spot-top">
                                <strong><spring:message code="courses.common.spotIndexed" arguments="${s.index + 1}" /></strong>
                                <button type="button" class="remove-mini-btn" onclick="removeEditSpot(this)"><spring:message code="courses.common.delete" /></button>
                            </div>

                            <div class="form-group2">
                                <label class="form-label2"><spring:message code="courses.common.field.citySelect" /></label>
                                <input type="text"
                                       class="form-input2 city-name-input"
                                       list="editCityOptionList"
                                       value="${travelPlan.destination}"
                                       autocomplete="off"
                                       required>
                            </div>

                            <div class="form-row-2">
                                <div class="form-group2">
                                    <label class="form-label2"><spring:message code="courses.common.field.placeName" /></label>
                                    <input type="text"
                                           class="form-input2"
                                           data-field="place_name"
                                           name="spotList[${s.index}].place_name"
                                           value="${spot.place_name}"
                                           required>
                                </div>

                                <div class="form-group2">
                                    <label class="form-label2"><spring:message code="courses.common.field.visitDate" /></label>
                                    <input type="date"
                                           class="form-input2"
                                           data-field="visit_date"
                                           name="spotList[${s.index}].visit_date"
                                           value="${spotDateStr}"
                                           required>
                                </div>
                            </div>

                            <div class="form-group2">
                                <label class="form-label2"><spring:message code="courses.common.field.visitOrder" /></label>
                                <input type="number"
                                       class="form-input2"
                                       data-field="visit_order"
                                       name="spotList[${s.index}].visit_order"
                                       value="${spot.visit_order}"
                                       min="1"
                                       required>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="edit-submit-row">
                    <button type="button" class="btn btn-light" onclick="toggleEditForm()"><spring:message code="courses.common.cancel" /></button>
                    <button type="submit" class="btn btn-primary"><spring:message code="courses.common.action.saveEdit" /></button>
                </div>
            </form>
        </div>

    </div>
</div>

<script>
    const courseDetailMessages = {
        spotIndexed: "<spring:message code='courses.common.spotIndexed' javaScriptEscape='true' />",
        deleteLabel: "<spring:message code='courses.common.delete' javaScriptEscape='true' />",
        citySelectLabel: "<spring:message code='courses.common.field.citySelect' javaScriptEscape='true' />",
        placeNameLabel: "<spring:message code='courses.common.field.placeName' javaScriptEscape='true' />",
        visitDateLabel: "<spring:message code='courses.common.field.visitDate' javaScriptEscape='true' />",
        visitOrderLabel: "<spring:message code='courses.common.field.visitOrder' javaScriptEscape='true' />"
    };

    function formatCourseMessage(template, ...values) {
        return template.replace(/\u007B(\d+)\u007D/g, function (_, index) {
            return values[index] ?? "";
        });
    }

    const dateFilterEl = document.getElementById("dateFilter");
    const filteredEmptyEl = document.getElementById("filteredEmpty");

    function applyDateFilter() {
        const selectedDate = dateFilterEl ? dateFilterEl.value : "";
        const items = document.querySelectorAll("#spotListArea .spot-item");

        let visibleCount = 0;

        items.forEach(item => {
            const itemDate = item.dataset.visitDate;
            const shouldShow = !selectedDate || itemDate === selectedDate;

            item.style.display = shouldShow ? "" : "none";

            if (shouldShow) {
                visibleCount++;
            }
        });

        if (filteredEmptyEl) {
            filteredEmptyEl.style.display = visibleCount === 0 ? "block" : "none";
        }
    }

    function resetDateFilter() {
        if (dateFilterEl) {
            dateFilterEl.value = "";
        }
        applyDateFilter();
    }

    if (dateFilterEl) {
        dateFilterEl.addEventListener("change", applyDateFilter);
    }

    const cityMasterList = [
        <c:forEach var="city" items="${spotTravelList}" varStatus="s">
        {
            spotId: "${city.spot_id}",
            name: "${city.name}"
        }<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];

    function findCityByName(cityName) {
        if (!cityName) return null;
        const trimmed = cityName.trim();
        return cityMasterList.find(city => city.name === trimmed) || null;
    }

    function toggleEditForm() {
        const editCard = document.getElementById("editCard");
        if (!editCard) return;

        editCard.style.display = editCard.style.display === "none" ? "block" : "none";
    }

    const editPublicToggle = document.getElementById("editPublicToggle");
    const editIsPublic = document.getElementById("editIsPublic");

    if (editPublicToggle && editIsPublic) {
        editPublicToggle.addEventListener("change", function () {
            editIsPublic.value = this.checked ? "1" : "0";
        });
    }

    function refreshEditSpotIndexes() {
        const items = document.querySelectorAll("#editSpotList .edit-spot-item");

        items.forEach((item, index) => {
            const title = item.querySelector(".edit-spot-top strong");
            if (title) {
                title.textContent = formatCourseMessage(courseDetailMessages.spotIndexed, index + 1);
            }

            item.querySelectorAll("[data-field]").forEach(input => {
                const field = input.dataset.field;
                input.name = "spotList[" + index + "]." + field;
            });
        });
    }

    function bindCityInput(item) {
        const cityInput = item.querySelector(".city-name-input");
        const hiddenSpotIdInput = item.querySelector('[data-field="spot_id"]');

        function syncCity() {
            const matchedCity = findCityByName(cityInput.value);
            hiddenSpotIdInput.value = matchedCity ? matchedCity.spotId : "";
        }

        cityInput.addEventListener("input", syncCity);
        cityInput.addEventListener("change", syncCity);
        syncCity();
    }

    function addEditSpot() {
        const list = document.getElementById("editSpotList");
        const div = document.createElement("div");
        div.className = "edit-spot-item";

        div.innerHTML = `
            <input type="hidden" data-field="spot_id" value="">

            <div class="edit-spot-top">
                <strong>${formatCourseMessage(courseDetailMessages.spotIndexed, "")}</strong>
                <button type="button" class="remove-mini-btn" onclick="removeEditSpot(this)">${courseDetailMessages.deleteLabel}</button>
            </div>

            <div class="form-group2">
                <label class="form-label2">${courseDetailMessages.citySelectLabel}</label>
                <input type="text"
                       class="form-input2 city-name-input"
                       list="editCityOptionList"
                       autocomplete="off"
                       required>
            </div>

            <div class="form-row-2">
                <div class="form-group2">
                    <label class="form-label2">${courseDetailMessages.placeNameLabel}</label>
                    <input type="text" class="form-input2" data-field="place_name" required>
                </div>

                <div class="form-group2">
                    <label class="form-label2">${courseDetailMessages.visitDateLabel}</label>
                    <input type="date" class="form-input2" data-field="visit_date" required>
                </div>
            </div>

            <div class="form-group2">
                <label class="form-label2">${courseDetailMessages.visitOrderLabel}</label>
                <input type="number" class="form-input2" data-field="visit_order" min="1" required>
            </div>
        `;

        list.appendChild(div);
        bindCityInput(div);
        refreshEditSpotIndexes();
    }

    function removeEditSpot(btn) {
        btn.closest(".edit-spot-item").remove();
        refreshEditSpotIndexes();
    }

    document.querySelectorAll("#editSpotList .edit-spot-item").forEach(bindCityInput);
    refreshEditSpotIndexes();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
