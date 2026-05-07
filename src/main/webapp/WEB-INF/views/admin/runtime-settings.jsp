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
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
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

<div class="adm-content adm-governance-page adm-runtime-page">
    <spring:message var="msg_admin_runtimeSettings_totalCountDisplay" code="admin.common.totalCountFormat" arguments="${fn:length(settings)}"/>
    <spring:message var="msg_admin_runtimeSettings_historyTotalCountDisplay" code="admin.common.totalCountFormat" arguments="${fn:length(histories)}"/>

    <div class="adm-page-head">
        <div>
            <h1>${msg_admin_runtimeSettings_title}</h1>
            <p class="adm-page-desc">${msg_admin_runtimeSettings_desc}</p>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card adm-runtime-filter-card">
        <div class="adm-runtime-filter-grid">
            <label class="adm-runtime-field">${msg_admin_runtimeSettings_group}
                <input class="adm-input" type="text" name="settingGroup" value="${fn:escapeXml(settingGroup)}" placeholder="AUTH, OAUTH, MAIL">
            </label>
            <label class="adm-runtime-field">${msg_admin_runtimeSettings_keyword}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_admin_runtimeSettings_placeholder_keyword}">
            </label>
            <label class="adm-runtime-field">${msg_admin_runtimeSettings_historyKey}
                <input class="adm-input" type="text" name="historyKey" value="${fn:escapeXml(historyKey)}" placeholder="oauth.kakao.client-id">
            </label>
            <label class="adm-check adm-runtime-check-field">
                <input type="checkbox" name="includeInactive" ${includeInactive ? 'checked' : ''}>
                ${msg_admin_runtimeSettings_includeInactive}
            </label>
        </div>
        <div class="adm-actions adm-runtime-actions">
            <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_search}</button>
            <c:if test="${not empty settingGroup or not empty keyword or not empty historyKey or includeInactive}">
                <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/runtime-settings">${msg_admin_common_reset}</a>
            </c:if>
        </div>
    </form>

    <div class="adm-card adm-runtime-create-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${msg_admin_runtimeSettings_createTitle}</div>
                <div class="adm-muted">${msg_admin_runtimeSettings_createDesc}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <form method="post" action="${pageContext.request.contextPath}/admin/runtime-settings">
                <c:if test="${not empty settingGroup}">
                    <input type="hidden" name="returnSettingGroup" value="${fn:escapeXml(settingGroup)}">
                </c:if>
                <c:if test="${not empty keyword}">
                    <input type="hidden" name="returnKeyword" value="${fn:escapeXml(keyword)}">
                </c:if>
                <c:if test="${not empty historyKey}">
                    <input type="hidden" name="returnHistoryKey" value="${fn:escapeXml(historyKey)}">
                </c:if>
                <c:if test="${includeInactive}">
                    <input type="hidden" name="returnIncludeInactive" value="true">
                </c:if>
                <div class="adm-runtime-form-grid">
                    <label class="adm-runtime-field">${msg_admin_runtimeSettings_key}
                        <input class="adm-input" type="text" name="settingKey" required>
                    </label>
                    <label class="adm-runtime-field">${msg_admin_runtimeSettings_group}
                        <input class="adm-input" type="text" name="settingGroup" value="GENERAL">
                    </label>
                    <label class="adm-runtime-field">${msg_admin_runtimeSettings_displayName}
                        <input class="adm-input" type="text" name="displayName">
                    </label>
                    <label class="adm-runtime-field">${msg_admin_runtimeSettings_valueType}
                        <select class="adm-select" name="valueType">
                            <option value="STRING">STRING</option>
                            <option value="NUMBER">NUMBER</option>
                            <option value="BOOLEAN">BOOLEAN</option>
                            <option value="URL">URL</option>
                            <option value="SECRET">SECRET</option>
                        </select>
                    </label>
                    <label class="adm-runtime-field">${msg_admin_runtimeSettings_value}
                        <input class="adm-input" type="text" name="settingValue">
                    </label>
                    <label class="adm-runtime-field">${msg_admin_runtimeSettings_fallbackValue}
                        <input class="adm-input" type="text" name="fallbackValue">
                    </label>
                    <label class="adm-runtime-field adm-runtime-field-wide">${msg_admin_common_description}
                        <input class="adm-input" type="text" name="description">
                    </label>
                    <div class="adm-runtime-check-row">
                        <label class="adm-check"><input type="checkbox" name="secret"> ${msg_admin_runtimeSettings_secret}</label>
                        <label class="adm-check"><input type="checkbox" name="editable" checked> ${msg_admin_runtimeSettings_editable}</label>
                        <label class="adm-check"><input type="checkbox" name="active" checked> ${msg_admin_runtimeSettings_active}</label>
                    </div>
                </div>
                <div class="adm-actions adm-runtime-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_save}</button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card adm-runtime-summary-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">
                    ${msg_admin_runtimeSettings_title}
                    <span class="adm-section-total-inline">${msg_admin_runtimeSettings_totalCountDisplay}</span>
                </div>
                <div class="adm-muted">${msg_admin_runtimeSettings_desc}</div>
            </div>
        </div>
    </div>

    <c:forEach var="s" items="${settings}">
        <c:url var="runtimeSettingHistoryUrl" value="/admin/runtime-settings">
            <c:if test="${not empty settingGroup}">
                <c:param name="settingGroup" value="${settingGroup}"/>
            </c:if>
            <c:if test="${not empty keyword}">
                <c:param name="keyword" value="${keyword}"/>
            </c:if>
            <c:if test="${includeInactive}">
                <c:param name="includeInactive" value="on"/>
            </c:if>
            <c:param name="historyKey" value="${s.settingKey}"/>
        </c:url>
        <form method="post" action="${pageContext.request.contextPath}/admin/runtime-settings/${s.settingIdx}" class="adm-card adm-runtime-setting-card">
            <div class="adm-card-header">
                <div>
                    <div class="adm-card-title"><c:out value="${s.displayName}"/></div>
                    <div class="adm-muted"><c:out value="${s.settingGroup}"/> · <c:out value="${s.settingKey}"/> · <c:out value="${s.valueType}"/></div>
                </div>
                <div class="adm-runtime-flag-row">
                    <label class="adm-check"><input type="checkbox" name="secret" ${s.secret ? 'checked' : ''}> ${msg_admin_runtimeSettings_secret}</label>
                    <label class="adm-check"><input type="checkbox" name="editable" ${s.editable ? 'checked' : ''}> ${msg_admin_runtimeSettings_editable}</label>
                    <label class="adm-check"><input type="checkbox" name="active" ${s.active ? 'checked' : ''}> ${msg_admin_runtimeSettings_active}</label>
                </div>
            </div>
            <div class="adm-card-body">
                <c:if test="${not empty settingGroup}">
                    <input type="hidden" name="returnSettingGroup" value="${fn:escapeXml(settingGroup)}">
                </c:if>
                <c:if test="${not empty keyword}">
                    <input type="hidden" name="returnKeyword" value="${fn:escapeXml(keyword)}">
                </c:if>
                <c:if test="${not empty historyKey}">
                    <input type="hidden" name="returnHistoryKey" value="${fn:escapeXml(historyKey)}">
                </c:if>
                <c:if test="${includeInactive}">
                    <input type="hidden" name="returnIncludeInactive" value="true">
                </c:if>
                <input type="hidden" name="settingKey" value="${fn:escapeXml(s.settingKey)}">
                <div class="adm-runtime-form-grid adm-runtime-setting-grid">
                    <label class="adm-runtime-field">${msg_admin_runtimeSettings_group}
                        <input class="adm-input" type="text" name="settingGroup" value="${fn:escapeXml(s.settingGroup)}">
                    </label>
                    <label class="adm-runtime-field">${msg_admin_runtimeSettings_displayName}
                        <input class="adm-input" type="text" name="displayName" value="${fn:escapeXml(s.displayName)}">
                    </label>
                    <label class="adm-runtime-field">${msg_admin_runtimeSettings_valueType}
                        <input class="adm-input" type="text" name="valueType" value="${fn:escapeXml(s.valueType)}">
                    </label>
                    <label class="adm-runtime-field">${msg_admin_runtimeSettings_updatedAt}
                        <span class="adm-input adm-runtime-static-input"><fmt:formatDate value="${s.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </label>
                    <label class="adm-runtime-field adm-runtime-field-wide">${msg_admin_runtimeSettings_value}
                        <input class="adm-input" type="${s.secret ? 'password' : 'text'}" name="settingValue" value="${fn:escapeXml(s.settingValue)}">
                    </label>
                    <label class="adm-runtime-field adm-runtime-field-wide">${msg_admin_runtimeSettings_fallbackValue}
                        <input class="adm-input" type="${s.secret ? 'password' : 'text'}" name="fallbackValue" value="${fn:escapeXml(s.fallbackValue)}">
                    </label>
                    <label class="adm-runtime-field adm-runtime-field-full">${msg_admin_common_description}
                        <textarea class="adm-input" name="description" rows="2"><c:out value="${s.description}"/></textarea>
                    </label>
                </div>
                <div class="adm-actions adm-runtime-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_save}</button>
                    <a class="adm-btn" href="${runtimeSettingHistoryUrl}">${msg_admin_runtimeSettings_viewHistory}</a>
                </div>
            </div>
        </form>
    </c:forEach>

    <div class="adm-card adm-runtime-history-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">
                    ${msg_admin_runtimeSettings_historyTitle}
                    <span class="adm-section-total-inline">${msg_admin_runtimeSettings_historyTotalCountDisplay}</span>
                </div>
                <div class="adm-muted">${msg_admin_runtimeSettings_historyDesc}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table class="adm-table adm-runtime-history-table" data-admin-list-ignore="true">
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
                                    <div class="adm-runtime-snapshot-grid">
                                        <div>
                                            <div class="adm-muted">${msg_admin_runtimeSettings_before}</div>
                                            <pre class="adm-runtime-snapshot-pre"><c:out value="${h.beforeConfigJson}"/></pre>
                                        </div>
                                        <div>
                                            <div class="adm-muted">${msg_admin_runtimeSettings_after}</div>
                                            <pre class="adm-runtime-snapshot-pre"><c:out value="${h.afterConfigJson}"/></pre>
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
