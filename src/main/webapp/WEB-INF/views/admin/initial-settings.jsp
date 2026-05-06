<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_4df522bc85" code="admin.initialSettings.title"/>
<spring:message var="autoMsg_0de13cd682" code="admin.initialSettings.desc"/>
<spring:message var="autoMsg_319d6dba06" code="admin.layout.menu.runtimeSettings"/>
<spring:message var="autoMsg_fa3938c977" code="admin.layout.menu.policyHistory"/>
<spring:message var="autoMsg_f640a090b5" code="admin.initialSettings.exportTitle"/>
<spring:message var="autoMsg_e862f4fe02" code="admin.initialSettings.exportDesc"/>
<spring:message var="autoMsg_76bbb50eed" code="admin.initialSettings.importTitle"/>
<spring:message var="autoMsg_90e0f4c576" code="admin.initialSettings.importDesc"/>
<spring:message var="autoMsg_f53f4fb09e" code="admin.initialSettings.importFile"/>
<spring:message var="autoMsg_1a3c427c5a" code="admin.initialSettings.importButton"/>
<c:set var="activeMenu" value="initialSettings"/>
<spring:message var="pageTitle" code="admin.initialSettings.title"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_4df522bc85}</h1>
            <p class="adm-page-desc">${autoMsg_0de13cd682}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/runtime-settings">${autoMsg_319d6dba06}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history">${autoMsg_fa3938c977}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>
    <c:if test="${not empty warning}">
        <div class="adm-alert warning"><c:out value="${warning}"/></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="adm-alert danger"><c:out value="${error}"/></div>
    </c:if>

    <div class="adm-card" style="margin-bottom:16px;">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${autoMsg_f640a090b5}</div>
                <div class="adm-muted">${autoMsg_e862f4fe02}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <a class="adm-btn primary" href="${pageContext.request.contextPath}/admin/initial-settings/export">
                <spring:message code="admin.initialSettings.exportButton"/>
            </a>
            <div class="adm-muted" style="margin-top:10px;line-height:1.7;">
                <spring:message code="admin.initialSettings.exportScope"/>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${autoMsg_76bbb50eed}</div>
                <div class="adm-muted">${autoMsg_90e0f4c576}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/admin/initial-settings/import">
                <label>${autoMsg_f53f4fb09e}
                    <input class="adm-input" type="file" name="file" accept="application/json,.json" required>
                </label>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit">${autoMsg_1a3c427c5a}</button>
                </div>
            </form>
            <div class="adm-muted" style="margin-top:10px;line-height:1.7;">
                <spring:message code="admin.initialSettings.importNotice"/>
            </div>
        </div>
    </div>
</div>
