<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:message var="autoMsg_fc1641f539" code="admin.runtimeSettings.title"/>
<spring:message var="autoMsg_cf5e7e058c" code="admin.runtimeSettings.desc"/>
<spring:message var="autoMsg_699c5a3d23" code="admin.runtimeSettings.group"/>
<spring:message var="autoMsg_e412deefbf" code="admin.runtimeSettings.keyword"/>
<spring:message var="autoMsg_7488858959" code="admin.runtimeSettings.historyKey"/>
<spring:message var="autoMsg_709da729d7" code="admin.common.search"/>
<spring:message var="autoMsg_ba55320040" code="admin.runtimeSettings.createTitle"/>
<spring:message var="autoMsg_86da3b0d49" code="admin.runtimeSettings.createDesc"/>
<spring:message var="autoMsg_a3cc72892c" code="admin.runtimeSettings.key"/>
<spring:message var="autoMsg_89cd32ad71" code="admin.runtimeSettings.displayName"/>
<spring:message var="autoMsg_58c822bcba" code="admin.runtimeSettings.valueType"/>
<spring:message var="autoMsg_0cc95d66fa" code="admin.runtimeSettings.value"/>
<spring:message var="autoMsg_1935d968a4" code="admin.runtimeSettings.fallbackValue"/>
<spring:message var="autoMsg_a741a1d3bc" code="admin.common.description"/>
<spring:message var="autoMsg_d02a761445" code="admin.runtimeSettings.secret"/>
<spring:message var="autoMsg_297f2f2efa" code="admin.runtimeSettings.editable"/>
<spring:message var="autoMsg_2decb03554" code="admin.runtimeSettings.active"/>
<spring:message var="autoMsg_bfe1c852ba" code="admin.common.save"/>
<spring:message var="autoMsg_31492442ad" code="admin.runtimeSettings.updatedAt"/>
<spring:message var="autoMsg_8dbd271adc" code="admin.runtimeSettings.viewHistory"/>
<spring:message var="autoMsg_08c670c75c" code="admin.runtimeSettings.historyTitle"/>
<spring:message var="autoMsg_988b3646ce" code="admin.runtimeSettings.historyDesc"/>
<spring:message var="autoMsg_61d8860360" code="admin.runtimeSettings.version"/>
<spring:message var="autoMsg_f3f57e9ca0" code="admin.runtimeSettings.changeType"/>
<spring:message var="autoMsg_558e55b7de" code="admin.runtimeSettings.actor"/>
<spring:message var="autoMsg_c7275361d5" code="admin.runtimeSettings.changedAt"/>
<spring:message var="autoMsg_63b3d2a8ea" code="admin.runtimeSettings.snapshot"/>
<spring:message var="autoMsg_c7fb196892" code="admin.runtimeSettings.showSnapshot"/>
<spring:message var="autoMsg_78e8342604" code="admin.runtimeSettings.before"/>
<spring:message var="autoMsg_827e4063eb" code="admin.runtimeSettings.after"/>
<spring:message var="autoMsg_38c3c5c9ba" code="admin.runtimeSettings.historyEmpty"/>
<c:set var="activeMenu" value="runtimeSettings"/>
<spring:message var="pageTitle" code="admin.runtimeSettings.title"/>
<spring:message var="keywordPlaceholder" code="admin.runtimeSettings.placeholder.keyword"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_fc1641f539}</h1>
            <p class="adm-page-desc">${autoMsg_cf5e7e058c}</p>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label>${autoMsg_699c5a3d23}
                <input class="adm-input" type="text" name="settingGroup" value="${fn:escapeXml(settingGroup)}" placeholder="AUTH, OAUTH, MAIL">
            </label>
            <label>${autoMsg_e412deefbf}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${keywordPlaceholder}">
            </label>
            <label>${autoMsg_7488858959}
                <input class="adm-input" type="text" name="historyKey" value="${fn:escapeXml(historyKey)}" placeholder="oauth.kakao.client-id">
            </label>
            <label class="adm-check" style="align-self:end;">
                <input type="checkbox" name="includeInactive" ${includeInactive ? 'checked' : ''}>
                <spring:message code="admin.runtimeSettings.includeInactive"/>
            </label>
        </div>
        <div class="adm-actions" style="margin-top:12px;">
            <button class="adm-btn primary" type="submit">${autoMsg_709da729d7}</button>
        </div>
    </form>

    <div class="adm-card" style="margin-bottom:16px;">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${autoMsg_ba55320040}</div>
                <div class="adm-muted">${autoMsg_86da3b0d49}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <form method="post" action="${pageContext.request.contextPath}/admin/runtime-settings">
                <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
                    <label>${autoMsg_a3cc72892c}
                        <input class="adm-input" type="text" name="settingKey" required>
                    </label>
                    <label>${autoMsg_699c5a3d23}
                        <input class="adm-input" type="text" name="settingGroup" value="GENERAL">
                    </label>
                    <label>${autoMsg_89cd32ad71}
                        <input class="adm-input" type="text" name="displayName">
                    </label>
                    <label>${autoMsg_58c822bcba}
                        <select class="adm-input" name="valueType">
                            <option value="STRING">STRING</option>
                            <option value="NUMBER">NUMBER</option>
                            <option value="BOOLEAN">BOOLEAN</option>
                            <option value="URL">URL</option>
                            <option value="SECRET">SECRET</option>
                        </select>
                    </label>
                    <label>${autoMsg_0cc95d66fa}
                        <input class="adm-input" type="text" name="settingValue">
                    </label>
                    <label>${autoMsg_1935d968a4}
                        <input class="adm-input" type="text" name="fallbackValue">
                    </label>
                    <label style="grid-column:span 2;">${autoMsg_a741a1d3bc}
                        <input class="adm-input" type="text" name="description">
                    </label>
                    <label class="adm-check"><input type="checkbox" name="secret"> ${autoMsg_d02a761445}</label>
                    <label class="adm-check"><input type="checkbox" name="editable" checked> ${autoMsg_297f2f2efa}</label>
                    <label class="adm-check"><input type="checkbox" name="active" checked> ${autoMsg_2decb03554}</label>
                </div>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit">${autoMsg_bfe1c852ba}</button>
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
                    <label class="adm-check"><input type="checkbox" name="secret" ${s.secret ? 'checked' : ''}> ${autoMsg_d02a761445}</label>
                    <label class="adm-check"><input type="checkbox" name="editable" ${s.editable ? 'checked' : ''}> ${autoMsg_297f2f2efa}</label>
                    <label class="adm-check"><input type="checkbox" name="active" ${s.active ? 'checked' : ''}> ${autoMsg_2decb03554}</label>
                </div>
            </div>
            <div class="adm-card-body">
                <input type="hidden" name="settingKey" value="${fn:escapeXml(s.settingKey)}">
                <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
                    <label>${autoMsg_699c5a3d23}
                        <input class="adm-input" type="text" name="settingGroup" value="${fn:escapeXml(s.settingGroup)}">
                    </label>
                    <label>${autoMsg_89cd32ad71}
                        <input class="adm-input" type="text" name="displayName" value="${fn:escapeXml(s.displayName)}">
                    </label>
                    <label>${autoMsg_58c822bcba}
                        <input class="adm-input" type="text" name="valueType" value="${fn:escapeXml(s.valueType)}">
                    </label>
                    <label>${autoMsg_31492442ad}
                        <span class="adm-input" style="display:block;min-height:38px;"><fmt:formatDate value="${s.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </label>
                    <label style="grid-column:span 2;">${autoMsg_0cc95d66fa}
                        <input class="adm-input" type="${s.secret ? 'password' : 'text'}" name="settingValue" value="${fn:escapeXml(s.settingValue)}">
                    </label>
                    <label style="grid-column:span 2;">${autoMsg_1935d968a4}
                        <input class="adm-input" type="${s.secret ? 'password' : 'text'}" name="fallbackValue" value="${fn:escapeXml(s.fallbackValue)}">
                    </label>
                    <label style="grid-column:span 4;">${autoMsg_a741a1d3bc}
                        <textarea class="adm-input" name="description" rows="2"><c:out value="${s.description}"/></textarea>
                    </label>
                </div>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit">${autoMsg_bfe1c852ba}</button>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/runtime-settings?historyKey=${fn:escapeXml(s.settingKey)}">${autoMsg_8dbd271adc}</a>
                </div>
            </div>
        </form>
    </c:forEach>

    <div class="adm-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${autoMsg_08c670c75c}</div>
                <div class="adm-muted">${autoMsg_988b3646ce}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr>
                        <th>${autoMsg_61d8860360}</th>
                        <th>${autoMsg_a3cc72892c}</th>
                        <th>${autoMsg_f3f57e9ca0}</th>
                        <th>${autoMsg_558e55b7de}</th>
                        <th>${autoMsg_c7275361d5}</th>
                        <th>${autoMsg_63b3d2a8ea}</th>
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
                                    <summary>${autoMsg_c7fb196892}</summary>
                                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-top:8px;">
                                        <div>
                                            <div class="adm-muted">${autoMsg_78e8342604}</div>
                                            <pre style="white-space:pre-wrap;max-height:180px;overflow:auto;"><c:out value="${h.beforeConfigJson}"/></pre>
                                        </div>
                                        <div>
                                            <div class="adm-muted">${autoMsg_827e4063eb}</div>
                                            <pre style="white-space:pre-wrap;max-height:180px;overflow:auto;"><c:out value="${h.afterConfigJson}"/></pre>
                                        </div>
                                    </div>
                                </details>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty histories}">
                        <tr><td colspan="6" class="adm-empty">${autoMsg_38c3c5c9ba}</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
