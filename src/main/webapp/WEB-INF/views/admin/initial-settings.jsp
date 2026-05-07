<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_initialSettings_title" code="admin.initialSettings.title"/>
<spring:message var="msg_admin_initialSettings_desc" code="admin.initialSettings.desc"/>
<spring:message var="msg_admin_layout_menu_runtimeSettings" code="admin.layout.menu.runtimeSettings"/>
<spring:message var="msg_admin_layout_menu_policyHistory" code="admin.layout.menu.policyHistory"/>
<spring:message var="msg_admin_initialSettings_exportTitle" code="admin.initialSettings.exportTitle"/>
<spring:message var="msg_admin_initialSettings_exportDesc" code="admin.initialSettings.exportDesc"/>
<spring:message var="msg_admin_initialSettings_exportButton" code="admin.initialSettings.exportButton"/>
<spring:message var="msg_admin_initialSettings_exportScope" code="admin.initialSettings.exportScope"/>
<spring:message var="msg_admin_initialSettings_importTitle" code="admin.initialSettings.importTitle"/>
<spring:message var="msg_admin_initialSettings_importDesc" code="admin.initialSettings.importDesc"/>
<spring:message var="msg_admin_initialSettings_importFile" code="admin.initialSettings.importFile"/>
<spring:message var="msg_admin_initialSettings_importButton" code="admin.initialSettings.importButton"/>
<spring:message var="msg_admin_initialSettings_importNotice" code="admin.initialSettings.importNotice"/>
<c:set var="pageTitle" value="${msg_admin_initialSettings_title}"/>
<c:set var="activeMenu" value="initialSettings"/>

<%@ include file="layout.jsp" %>

<div class="adm-content adm-governance-page adm-initial-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_admin_initialSettings_title}</h1>
            <p class="adm-page-desc">${msg_admin_initialSettings_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/runtime-settings">${msg_admin_layout_menu_runtimeSettings}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history">${msg_admin_layout_menu_policyHistory}</a>
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

    <div class="adm-initial-grid">
        <section class="adm-card adm-initial-card">
            <div class="adm-card-header">
                <div>
                    <div class="adm-card-title">${msg_admin_initialSettings_exportTitle}</div>
                    <div class="adm-muted">${msg_admin_initialSettings_exportDesc}</div>
                </div>
            </div>
            <div class="adm-card-body adm-initial-card-body">
                <div class="adm-initial-main-action">
                    <a class="adm-btn adm-btn-primary" href="${pageContext.request.contextPath}/admin/initial-settings/export">
                        ${msg_admin_initialSettings_exportButton}
                    </a>
                </div>
                <div class="adm-initial-note">
                    ${msg_admin_initialSettings_exportScope}
                </div>
            </div>
        </section>

        <section class="adm-card adm-initial-card">
            <div class="adm-card-header">
                <div>
                    <div class="adm-card-title">${msg_admin_initialSettings_importTitle}</div>
                    <div class="adm-muted">${msg_admin_initialSettings_importDesc}</div>
                </div>
            </div>
            <div class="adm-card-body adm-initial-card-body">
                <form class="adm-initial-import-form"
                      method="post"
                      enctype="multipart/form-data"
                      action="${pageContext.request.contextPath}/admin/initial-settings/import">
                    <label class="adm-initial-file-field">
                        <span>${msg_admin_initialSettings_importFile}</span>
                        <input class="adm-input" type="file" name="file" accept="application/json,.json" required>
                    </label>
                    <div class="adm-initial-main-action">
                        <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_initialSettings_importButton}</button>
                    </div>
                </form>
                <div class="adm-initial-note">
                    ${msg_admin_initialSettings_importNotice}
                </div>
            </div>
        </section>
    </div>
</div>
