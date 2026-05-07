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
        <div class="adm-actions adm-initial-page-actions">
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

    <section class="adm-card adm-initial-dashboard-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">현재 적용 설정 현황</div>
                <div class="adm-muted">내보내기 가능한 운영 설정 묶음을 한 화면에서 확인합니다.</div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-initial-summary-grid">
                <div class="adm-initial-summary-item">
                    <span class="adm-initial-summary-label">런타임 설정</span>
                    <strong>${initialSettingsSummary['runtimeSettings']}</strong>
                    <span class="adm-muted">환경별 즉시 적용 값</span>
                </div>
                <div class="adm-initial-summary-item">
                    <span class="adm-initial-summary-label">Provider 설정</span>
                    <strong>${initialSettingsSummary['providerConfigs']}</strong>
                    <span class="adm-muted">위험 판단 연동 설정</span>
                </div>
                <div class="adm-initial-summary-item">
                    <span class="adm-initial-summary-label">로그인 위험 정책</span>
                    <strong>${initialSettingsSummary['loginRiskPolicies']}</strong>
                    <span class="adm-muted">검토/차단 기준</span>
                </div>
                <div class="adm-initial-summary-item">
                    <span class="adm-initial-summary-label">이의제기 정책</span>
                    <strong>${initialSettingsSummary['securityAppealPolicy']}</strong>
                    <span class="adm-muted">접수/처리 정책</span>
                </div>
                <div class="adm-initial-summary-item">
                    <span class="adm-initial-summary-label">통합 정책</span>
                    <strong>${initialSettingsSummary['systemPolicies']}</strong>
                    <span class="adm-muted">스케줄 정책</span>
                </div>
            </div>
        </div>
    </section>

    <div class="adm-initial-grid">
        <section class="adm-card adm-initial-card">
            <div class="adm-card-header">
                <div>
                    <div class="adm-card-title">${msg_admin_initialSettings_exportTitle}</div>
                    <div class="adm-muted">${msg_admin_initialSettings_exportDesc}</div>
                </div>
            </div>
            <div class="adm-card-body adm-initial-card-body">
                <form class="adm-initial-export-form" method="get" action="${pageContext.request.contextPath}/admin/initial-settings/export">
                    <div class="adm-initial-scope-grid">
                        <label class="adm-initial-scope-option">
                            <input type="checkbox" name="sections" value="runtimeSettings" checked>
                            <span>런타임 설정</span>
                            <em>${initialSettingsSummary['runtimeSettings']}건</em>
                        </label>
                        <label class="adm-initial-scope-option">
                            <input type="checkbox" name="sections" value="providerConfigs" checked>
                            <span>Provider 설정</span>
                            <em>${initialSettingsSummary['providerConfigs']}건</em>
                        </label>
                        <label class="adm-initial-scope-option">
                            <input type="checkbox" name="sections" value="loginRiskPolicies" checked>
                            <span>로그인 위험 정책</span>
                            <em>${initialSettingsSummary['loginRiskPolicies']}건</em>
                        </label>
                        <label class="adm-initial-scope-option">
                            <input type="checkbox" name="sections" value="securityAppealPolicy" checked>
                            <span>이의제기 정책</span>
                            <em>${initialSettingsSummary['securityAppealPolicy']}건</em>
                        </label>
                        <label class="adm-initial-scope-option">
                            <input type="checkbox" name="sections" value="systemPolicies" checked>
                            <span>통합 정책</span>
                            <em>${initialSettingsSummary['systemPolicies']}건</em>
                        </label>
                    </div>
                    <div class="adm-initial-main-action adm-initial-export-action">
                        <button class="adm-btn adm-btn-primary" type="submit">
                            ${msg_admin_initialSettings_exportButton}
                        </button>
                    </div>
                </form>
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
                    <div class="adm-initial-main-action adm-initial-import-action">
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

<%@ include file="layout-close.jsp" %>
