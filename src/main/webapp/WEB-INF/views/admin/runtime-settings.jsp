<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_runtimeSettings_title" code="admin.runtimeSettings.title"/>
<spring:message var="msg_admin_runtimeSettings_placeholder_keyword" code="admin.runtimeSettings.placeholder.keyword"/>
<spring:message var="msg_admin_runtimeSettings_desc" code="admin.runtimeSettings.desc"/>
<spring:message var="msg_admin_runtimeSettings_group" code="admin.runtimeSettings.group"/>
<spring:message var="msg_admin_runtimeSettings_keyword" code="admin.runtimeSettings.keyword"/>
<spring:message var="msg_admin_runtimeSettings_historyKey" code="admin.runtimeSettings.historyKey"/>
<spring:message var="msg_admin_runtimeSettings_includeInactive" code="admin.runtimeSettings.includeInactive"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_runtimeSettings_createTitle" code="admin.runtimeSettings.createTitle"/>
<spring:message var="msg_admin_runtimeSettings_createDesc" code="admin.runtimeSettings.createDesc"/>
<spring:message var="msg_admin_runtimeSettings_key" code="admin.runtimeSettings.key"/>
<spring:message var="msg_admin_runtimeSettings_displayName" code="admin.runtimeSettings.displayName"/>
<spring:message var="msg_admin_runtimeSettings_valueType" code="admin.runtimeSettings.valueType"/>
<spring:message var="msg_admin_runtimeSettings_value" code="admin.runtimeSettings.value"/>
<spring:message var="msg_admin_runtimeSettings_fallbackValue" code="admin.runtimeSettings.fallbackValue"/>
<spring:message var="msg_admin_common_description" code="admin.common.description"/>
<spring:message var="msg_admin_runtimeSettings_secret" code="admin.runtimeSettings.secret"/>
<spring:message var="msg_admin_runtimeSettings_editable" code="admin.runtimeSettings.editable"/>
<spring:message var="msg_admin_runtimeSettings_active" code="admin.runtimeSettings.active"/>
<spring:message var="msg_admin_common_save" code="admin.common.save"/>
<spring:message var="msg_admin_runtimeSettings_updatedAt" code="admin.runtimeSettings.updatedAt"/>
<spring:message var="msg_admin_runtimeSettings_viewHistory" code="admin.runtimeSettings.viewHistory"/>
<spring:message var="msg_admin_runtimeSettings_historyTitle" code="admin.runtimeSettings.historyTitle"/>
<spring:message var="msg_admin_runtimeSettings_historyDesc" code="admin.runtimeSettings.historyDesc"/>
<spring:message var="msg_admin_runtimeSettings_version" code="admin.runtimeSettings.version"/>
<spring:message var="msg_admin_runtimeSettings_changeType" code="admin.runtimeSettings.changeType"/>
<spring:message var="msg_admin_runtimeSettings_actor" code="admin.runtimeSettings.actor"/>
<spring:message var="msg_admin_runtimeSettings_changedAt" code="admin.runtimeSettings.changedAt"/>
<spring:message var="msg_admin_runtimeSettings_snapshot" code="admin.runtimeSettings.snapshot"/>
<spring:message var="msg_admin_runtimeSettings_showSnapshot" code="admin.runtimeSettings.showSnapshot"/>
<spring:message var="msg_admin_runtimeSettings_before" code="admin.runtimeSettings.before"/>
<spring:message var="msg_admin_runtimeSettings_after" code="admin.runtimeSettings.after"/>
<spring:message var="msg_admin_runtimeSettings_historyEmpty" code="admin.runtimeSettings.historyEmpty"/>
<c:set var="pageTitle" value="${msg_admin_runtimeSettings_title}"/>
<c:set var="activeMenu" value="runtimeSettings"/>


<%@ include file="layout.jsp" %>

<div class="adm-content adm-governance-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_admin_runtimeSettings_title}</h1>
            <p class="adm-page-desc">${msg_admin_runtimeSettings_desc}</p>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label>${msg_admin_runtimeSettings_group}
                <input class="adm-input" type="text" name="settingGroup" value="${fn:escapeXml(settingGroup)}" placeholder="AUTH, OAUTH, MAIL">
            </label>
            <label>${msg_admin_runtimeSettings_keyword}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_admin_runtimeSettings_placeholder_keyword}">
            </label>
            <label>${msg_admin_runtimeSettings_historyKey}
                <input class="adm-input" type="text" name="historyKey" value="${fn:escapeXml(historyKey)}" placeholder="oauth.kakao.client-id">
            </label>
            <label class="adm-check" style="align-self:end;">
                <input type="checkbox" name="includeInactive" ${includeInactive ? 'checked' : ''}>
                ${msg_admin_runtimeSettings_includeInactive}
            </label>
        </div>
        <div class="adm-actions" style="margin-top:12px;">
            <button class="adm-btn primary" type="submit">${msg_admin_common_search}</button>
        </div>
    </form>

    <div class="adm-card" style="margin-bottom:16px;">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${msg_admin_runtimeSettings_createTitle}</div>
                <div class="adm-muted">${msg_admin_runtimeSettings_createDesc}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <form method="post" action="${pageContext.request.contextPath}/admin/runtime-settings">
                <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
                    <label>${msg_admin_runtimeSettings_key}
                        <input class="adm-input" type="text" name="settingKey" required>
                    </label>
                    <label>${msg_admin_runtimeSettings_group}
                        <input class="adm-input" type="text" name="settingGroup" value="GENERAL">
                    </label>
                    <label>${msg_admin_runtimeSettings_displayName}
                        <input class="adm-input" type="text" name="displayName">
                    </label>
                    <label>${msg_admin_runtimeSettings_valueType}
                        <select class="adm-input" name="valueType">
                            <option value="STRING">STRING</option>
                            <option value="NUMBER">NUMBER</option>
                            <option value="BOOLEAN">BOOLEAN</option>
                            <option value="URL">URL</option>
                            <option value="SECRET">SECRET</option>
                        </select>
                    </label>
                    <label>${msg_admin_runtimeSettings_value}
                        <input class="adm-input" type="text" name="settingValue">
                    </label>
                    <label>${msg_admin_runtimeSettings_fallbackValue}
                        <input class="adm-input" type="text" name="fallbackValue">
                    </label>
                    <label style="grid-column:span 2;">${msg_admin_common_description}
                        <input class="adm-input" type="text" name="description">
                    </label>
                    <label class="adm-check"><input type="checkbox" name="secret"> ${msg_admin_runtimeSettings_secret}</label>
                    <label class="adm-check"><input type="checkbox" name="editable" checked> ${msg_admin_runtimeSettings_editable}</label>
                    <label class="adm-check"><input type="checkbox" name="active" checked> ${msg_admin_runtimeSettings_active}</label>
                </div>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit">${msg_admin_common_save}</button>
                </div>
            </form>
        </div>
    </div>

    <c:forEach var="s" items="${settings}">
        <form method="post" action="${pageContext.request.contextPath}/admin/runtime-settings/${s.settingIdx}" class="adm-card" style="margin-bottom:14px;">
            <div class="adm-card-header">
                <div>
                    <div class="adm-card-title"><c:out value="${s.displayName}"/></div>
                    <div class="adm-muted"><c:out value="${s.settingGroup}"/> · <c:out value="${s.settingKey}"/> · <c:out value="${s.valueType}"/></div>
                </div>
                <div class="adm-actions">
                    <label class="adm-check"><input type="checkbox" name="secret" ${s.secret ? 'checked' : ''}> ${msg_admin_runtimeSettings_secret}</label>
                    <label class="adm-check"><input type="checkbox" name="editable" ${s.editable ? 'checked' : ''}> ${msg_admin_runtimeSettings_editable}</label>
                    <label class="adm-check"><input type="checkbox" name="active" ${s.active ? 'checked' : ''}> ${msg_admin_runtimeSettings_active}</label>
                </div>
            </div>
            <div class="adm-card-body">
                <input type="hidden" name="settingKey" value="${fn:escapeXml(s.settingKey)}">
                <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
                    <label>${msg_admin_runtimeSettings_group}
                        <input class="adm-input" type="text" name="settingGroup" value="${fn:escapeXml(s.settingGroup)}">
                    </label>
                    <label>${msg_admin_runtimeSettings_displayName}
                        <input class="adm-input" type="text" name="displayName" value="${fn:escapeXml(s.displayName)}">
                    </label>
                    <label>${msg_admin_runtimeSettings_valueType}
                        <input class="adm-input" type="text" name="valueType" value="${fn:escapeXml(s.valueType)}">
                    </label>
                    <label>${msg_admin_runtimeSettings_updatedAt}
                        <span class="adm-input" style="display:block;min-height:38px;"><fmt:formatDate value="${s.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </label>
                    <label style="grid-column:span 2;">${msg_admin_runtimeSettings_value}
                        <input class="adm-input" type="${s.secret ? 'password' : 'text'}" name="settingValue" value="${fn:escapeXml(s.settingValue)}">
                    </label>
                    <label style="grid-column:span 2;">${msg_admin_runtimeSettings_fallbackValue}
                        <input class="adm-input" type="${s.secret ? 'password' : 'text'}" name="fallbackValue" value="${fn:escapeXml(s.fallbackValue)}">
                    </label>
                    <label style="grid-column:span 4;">${msg_admin_common_description}
                        <textarea class="adm-input" name="description" rows="2"><c:out value="${s.description}"/></textarea>
                    </label>
                </div>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit">${msg_admin_common_save}</button>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/runtime-settings?historyKey=${fn:escapeXml(s.settingKey)}">${msg_admin_runtimeSettings_viewHistory}</a>
                </div>
            </div>
        </form>
    </c:forEach>

    <div class="adm-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${msg_admin_runtimeSettings_historyTitle}</div>
                <div class="adm-muted">${msg_admin_runtimeSettings_historyDesc}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr>
                        <th>${msg_admin_runtimeSettings_version}</th>
                        <th>${msg_admin_runtimeSettings_key}</th>
                        <th>${msg_admin_runtimeSettings_changeType}</th>
                        <th>${msg_admin_runtimeSettings_actor}</th>
                        <th>${msg_admin_runtimeSettings_changedAt}</th>
                        <th>${msg_admin_runtimeSettings_snapshot}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="h" items="${histories}">
                        <tr>
                            <td><c:out value="${h.versionNo}"/></td>
                            <td><c:out value="${h.settingKey}"/></td>
                            <td><span class="adm-badge"><c:out value="${h.changeType}"/></span></td>
                            <td><c:out value="${h.actorUserIdx}" default="-"/></td>
                            <td><fmt:formatDate value="${h.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <details>
                                    <summary>${msg_admin_runtimeSettings_showSnapshot}</summary>
                                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-top:8px;">
                                        <div>
                                            <div class="adm-muted">${msg_admin_runtimeSettings_before}</div>
                                            <pre style="white-space:pre-wrap;max-height:180px;overflow:auto;"><c:out value="${h.beforeConfigJson}"/></pre>
                                        </div>
                                        <div>
                                            <div class="adm-muted">${msg_admin_runtimeSettings_after}</div>
                                            <pre style="white-space:pre-wrap;max-height:180px;overflow:auto;"><c:out value="${h.afterConfigJson}"/></pre>
                                        </div>
                                    </div>
                                </details>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}">
                        <tr><td colspan="6" class="adm-empty">${msg_admin_runtimeSettings_historyEmpty}</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
