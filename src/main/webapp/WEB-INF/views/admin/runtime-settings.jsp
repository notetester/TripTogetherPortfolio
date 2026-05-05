<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="runtimeSettings"/>
<spring:message var="pageTitle" code="admin.runtimeSettings.title"/>
<spring:message var="keywordPlaceholder" code="admin.runtimeSettings.placeholder.keyword"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="admin.runtimeSettings.title"/></h1>
            <p class="adm-page-desc"><spring:message code="admin.runtimeSettings.desc"/></p>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label><spring:message code="admin.runtimeSettings.group"/>
                <input class="adm-input" type="text" name="settingGroup" value="${fn:escapeXml(settingGroup)}" placeholder="AUTH, OAUTH, MAIL">
            </label>
            <label><spring:message code="admin.runtimeSettings.keyword"/>
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${keywordPlaceholder}">
            </label>
            <label><spring:message code="admin.runtimeSettings.historyKey"/>
                <input class="adm-input" type="text" name="historyKey" value="${fn:escapeXml(historyKey)}" placeholder="oauth.kakao.client-id">
            </label>
            <label class="adm-check" style="align-self:end;">
                <input type="checkbox" name="includeInactive" ${includeInactive ? 'checked' : ''}>
                <spring:message code="admin.runtimeSettings.includeInactive"/>
            </label>
        </div>
        <div class="adm-actions" style="margin-top:12px;">
            <button class="adm-btn primary" type="submit"><spring:message code="admin.common.search"/></button>
        </div>
    </form>

    <div class="adm-card" style="margin-bottom:16px;">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title"><spring:message code="admin.runtimeSettings.createTitle"/></div>
                <div class="adm-muted"><spring:message code="admin.runtimeSettings.createDesc"/></div>
            </div>
        </div>
        <div class="adm-card-body">
            <form method="post" action="${pageContext.request.contextPath}/admin/runtime-settings">
                <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
                    <label><spring:message code="admin.runtimeSettings.key"/>
                        <input class="adm-input" type="text" name="settingKey" required>
                    </label>
                    <label><spring:message code="admin.runtimeSettings.group"/>
                        <input class="adm-input" type="text" name="settingGroup" value="GENERAL">
                    </label>
                    <label><spring:message code="admin.runtimeSettings.displayName"/>
                        <input class="adm-input" type="text" name="displayName">
                    </label>
                    <label><spring:message code="admin.runtimeSettings.valueType"/>
                        <select class="adm-input" name="valueType">
                            <option value="STRING">STRING</option>
                            <option value="NUMBER">NUMBER</option>
                            <option value="BOOLEAN">BOOLEAN</option>
                            <option value="URL">URL</option>
                            <option value="SECRET">SECRET</option>
                        </select>
                    </label>
                    <label><spring:message code="admin.runtimeSettings.value"/>
                        <input class="adm-input" type="text" name="settingValue">
                    </label>
                    <label><spring:message code="admin.runtimeSettings.fallbackValue"/>
                        <input class="adm-input" type="text" name="fallbackValue">
                    </label>
                    <label style="grid-column:span 2;"><spring:message code="admin.common.description"/>
                        <input class="adm-input" type="text" name="description">
                    </label>
                    <label class="adm-check"><input type="checkbox" name="secret"> <spring:message code="admin.runtimeSettings.secret"/></label>
                    <label class="adm-check"><input type="checkbox" name="editable" checked> <spring:message code="admin.runtimeSettings.editable"/></label>
                    <label class="adm-check"><input type="checkbox" name="active" checked> <spring:message code="admin.runtimeSettings.active"/></label>
                </div>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit"><spring:message code="admin.common.save"/></button>
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
                    <label class="adm-check"><input type="checkbox" name="secret" ${s.secret ? 'checked' : ''}> <spring:message code="admin.runtimeSettings.secret"/></label>
                    <label class="adm-check"><input type="checkbox" name="editable" ${s.editable ? 'checked' : ''}> <spring:message code="admin.runtimeSettings.editable"/></label>
                    <label class="adm-check"><input type="checkbox" name="active" ${s.active ? 'checked' : ''}> <spring:message code="admin.runtimeSettings.active"/></label>
                </div>
            </div>
            <div class="adm-card-body">
                <input type="hidden" name="settingKey" value="${fn:escapeXml(s.settingKey)}">
                <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
                    <label><spring:message code="admin.runtimeSettings.group"/>
                        <input class="adm-input" type="text" name="settingGroup" value="${fn:escapeXml(s.settingGroup)}">
                    </label>
                    <label><spring:message code="admin.runtimeSettings.displayName"/>
                        <input class="adm-input" type="text" name="displayName" value="${fn:escapeXml(s.displayName)}">
                    </label>
                    <label><spring:message code="admin.runtimeSettings.valueType"/>
                        <input class="adm-input" type="text" name="valueType" value="${fn:escapeXml(s.valueType)}">
                    </label>
                    <label><spring:message code="admin.runtimeSettings.updatedAt"/>
                        <span class="adm-input" style="display:block;min-height:38px;"><fmt:formatDate value="${s.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </label>
                    <label style="grid-column:span 2;"><spring:message code="admin.runtimeSettings.value"/>
                        <input class="adm-input" type="${s.secret ? 'password' : 'text'}" name="settingValue" value="${fn:escapeXml(s.settingValue)}">
                    </label>
                    <label style="grid-column:span 2;"><spring:message code="admin.runtimeSettings.fallbackValue"/>
                        <input class="adm-input" type="${s.secret ? 'password' : 'text'}" name="fallbackValue" value="${fn:escapeXml(s.fallbackValue)}">
                    </label>
                    <label style="grid-column:span 4;"><spring:message code="admin.common.description"/>
                        <textarea class="adm-input" name="description" rows="2"><c:out value="${s.description}"/></textarea>
                    </label>
                </div>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit"><spring:message code="admin.common.save"/></button>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/runtime-settings?historyKey=${fn:escapeXml(s.settingKey)}"><spring:message code="admin.runtimeSettings.viewHistory"/></a>
                </div>
            </div>
        </form>
    </c:forEach>

    <div class="adm-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title"><spring:message code="admin.runtimeSettings.historyTitle"/></div>
                <div class="adm-muted"><spring:message code="admin.runtimeSettings.historyDesc"/></div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr>
                        <th><spring:message code="admin.runtimeSettings.version"/></th>
                        <th><spring:message code="admin.runtimeSettings.key"/></th>
                        <th><spring:message code="admin.runtimeSettings.changeType"/></th>
                        <th><spring:message code="admin.runtimeSettings.actor"/></th>
                        <th><spring:message code="admin.runtimeSettings.changedAt"/></th>
                        <th><spring:message code="admin.runtimeSettings.snapshot"/></th>
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
                                    <summary><spring:message code="admin.runtimeSettings.showSnapshot"/></summary>
                                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-top:8px;">
                                        <div>
                                            <div class="adm-muted"><spring:message code="admin.runtimeSettings.before"/></div>
                                            <pre style="white-space:pre-wrap;max-height:180px;overflow:auto;"><c:out value="${h.beforeConfigJson}"/></pre>
                                        </div>
                                        <div>
                                            <div class="adm-muted"><spring:message code="admin.runtimeSettings.after"/></div>
                                            <pre style="white-space:pre-wrap;max-height:180px;overflow:auto;"><c:out value="${h.afterConfigJson}"/></pre>
                                        </div>
                                    </div>
                                </details>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}">
                        <tr><td colspan="6" class="adm-empty"><spring:message code="admin.runtimeSettings.historyEmpty"/></td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
