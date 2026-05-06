<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="activeMenu" value="initialSettings"/>
<spring:message var="pageTitle" code="admin.initialSettings.title"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="admin.initialSettings.title"/></h1>
            <p class="adm-page-desc"><spring:message code="admin.initialSettings.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/runtime-settings"><spring:message code="admin.layout.menu.runtimeSettings"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history"><spring:message code="admin.layout.menu.policyHistory"/></a>
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
                <div class="adm-card-title"><spring:message code="admin.initialSettings.exportTitle"/></div>
                <div class="adm-muted"><spring:message code="admin.initialSettings.exportDesc"/></div>
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
                <div class="adm-card-title"><spring:message code="admin.initialSettings.importTitle"/></div>
                <div class="adm-muted"><spring:message code="admin.initialSettings.importDesc"/></div>
            </div>
        </div>
        <div class="adm-card-body">
            <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/admin/initial-settings/import">
                <label><spring:message code="admin.initialSettings.importFile"/>
                    <input class="adm-input" type="file" name="file" accept="application/json,.json" required>
                </label>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit"><spring:message code="admin.initialSettings.importButton"/></button>
                </div>
            </form>
            <div class="adm-muted" style="margin-top:10px;line-height:1.7;">
                <spring:message code="admin.initialSettings.importNotice"/>
            </div>
        </div>
    </div>
</div>
