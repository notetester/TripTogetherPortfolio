<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="aiHelper"/>
<spring:message code="admin.aiHelper.assistant.pageTitle" var="pageTitle"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 도우미 내부 sub-tab ── --%>
    <div class="aih-tabs" style="display:flex;gap:4px;border-bottom:1px solid #e5e7eb;margin:20px 0;">
        <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=dashboard"
           class="aih-tab ${tab == 'dashboard' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'dashboard' ? '700' : '500'};color:${tab == 'dashboard' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'dashboard' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            <spring:message code="admin.aiHelper.assistant.tab.dashboard"/>
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=messages"
           class="aih-tab ${tab == 'messages' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'messages' ? '700' : '500'};color:${tab == 'messages' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'messages' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            <spring:message code="admin.aiHelper.assistant.tab.messages"/>
        </a>
    </div>

    <%-- ══════════════════════════════════════════
         대시보드 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'dashboard'}">
        <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:16px;">
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">🧭 <spring:message code="admin.aiHelper.assistant.kpi.totalSessions"/></div>
                <div style="font-size:24px;font-weight:700;color:#38bdf8;">${stats.totalSessions}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">💬 <spring:message code="admin.aiHelper.assistant.kpi.totalMessages"/></div>
                <div style="font-size:24px;font-weight:700;color:#0ea5e9;">${stats.totalMessages}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">📅 <spring:message code="admin.aiHelper.assistant.kpi.todaySessions"/></div>
                <div style="font-size:24px;font-weight:700;color:#10b981;">${stats.todaySessions}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">👤 <spring:message code="admin.aiHelper.assistant.kpi.uniqueUsers"/></div>
                <div style="font-size:24px;font-weight:700;color:#8b5cf6;">${stats.uniqueUsers}</div>
            </div>
        </div>

        <%-- ── 대화 세션 목록 (대시보드 내 통합) ── --%>
        <div style="font-size:14px;font-weight:700;margin:8px 0 12px;"><spring:message code="admin.aiHelper.assistant.section.sessions"/></div>

        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <form method="get" action="${pageContext.request.contextPath}/admin/ai-helper" style="display:flex;gap:8px;">
                <input type="hidden" name="tab" value="dashboard"/>
                <input type="text" name="keyword" value="${keyword}" placeholder="<spring:message code='admin.aiHelper.assistant.searchPlaceholder'/>" class="adm-input" style="flex:1;"/>
                <button type="submit" class="adm-btn"><spring:message code="admin.common.search"/></button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper" class="adm-btn adm-btn-ghost"><spring:message code="admin.common.reset"/></a>
                </c:if>
            </form>
            <div style="font-size:12px;color:#64748b;margin-top:8px;"><spring:message code="admin.common.totalCountFormat" arguments="${total}"/></div>
        </div>

        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th><spring:message code="admin.aiHelper.assistant.table.sessionId"/></th>
                        <th><spring:message code="admin.aiHelper.assistant.table.title"/></th>
                        <th><spring:message code="admin.aiHelper.assistant.table.user"/></th>
                        <th><spring:message code="admin.aiHelper.assistant.table.messageCount"/></th>
                        <th><spring:message code="admin.aiHelper.assistant.table.createdAt"/></th>
                        <th><spring:message code="admin.aiHelper.assistant.table.lastActive"/></th>
                        <th style="width:130px;">
                            <div style="display:flex;gap:4px;justify-content:flex-end;">
                                <span style="font-size:11px;padding:3px 8px;"><spring:message code="admin.aiHelper.assistant.table.actions"/></span>
                                <span style="font-size:11px;padding:3px 8px;visibility:hidden;"><spring:message code="admin.aiHelper.assistant.action.delete"/></span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty sessions}">
                            <tr><td colspan="7" style="text-align:center;padding:40px;color:#94a3b8;"><spring:message code="admin.aiHelper.assistant.empty.sessions"/></td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="s" items="${sessions}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${s.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">#${s.chatPostIdx}</button>
                                    </td>
                                    <td style="max-width:300px;word-break:break-all;">
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${s.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">${s.title}</button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.nickname != null}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${s.userIdx}">
                                                    ${s.nickname} <span style="color:#94a3b8;">(#${s.userIdx})</span>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color:#94a3b8;"><spring:message code="admin.aiHelper.assistant.userPrefix"/> #${s.userIdx} (<spring:message code="admin.aiHelper.assistant.userDeleted"/>)</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${s.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">${s.messageCount}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${s.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)"><fmt:formatDate value="${s.createdAt}" pattern="yyyy-MM-dd HH:mm"/></button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.lastMessageAt != null}">
                                                <button type="button"
                                                        class="adm-cell-link adm-cell-link--inline"
                                                        data-session-id="${s.chatPostIdx}"
                                                        onclick="viewAssistantMessages(this.dataset.sessionId)"><fmt:formatDate value="${s.lastMessageAt}" pattern="yyyy-MM-dd HH:mm"/></button>
                                            </c:when>
                                            <c:otherwise><span style="color:#94a3b8;">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align:right;">
                                        <div class="adm-row-actions">
                                            <button type="button"
                                                    class="adm-row-btn detail"
                                                    data-session-id="${s.chatPostIdx}"
                                                    onclick="viewAssistantMessages(this.dataset.sessionId)"><spring:message code="admin.aiHelper.assistant.action.view"/></button>
                                            <div class="action-menu-wrap">
                                                <button type="button"
                                                        class="adm-row-btn detail adm-row-btn-more"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu">
                                                    <button type="button"
                                                            class="action-menu-item danger"
                                                            data-session-id="${s.chatPostIdx}"
                                                            onclick="deleteAssistantSession(this.dataset.sessionId)"><spring:message code="admin.aiHelper.assistant.action.delete"/></button>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <c:if test="${totalPages > 1}">
            <div style="display:flex;justify-content:center;gap:4px;margin-top:16px;">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=dashboard&page=${p}&keyword=${keyword}"
                       class="adm-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}" style="min-width:32px;">${p}</a>
                </c:forEach>
            </div>
        </c:if>

    </c:if>

    <%-- ══════════════════════════════════════════
         메시지 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'messages'}">
        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <div style="font-size:13px;color:#475569;line-height:1.6;">
                <spring:message code="admin.aiHelper.assistant.messagesDescription"/>
            </div>
            <div style="font-size:12px;color:#64748b;margin-top:8px;"><spring:message code="admin.common.totalCountFormat" arguments="${total}"/></div>
        </div>

        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th><spring:message code="admin.aiHelper.assistant.table.id"/></th>
                        <th><spring:message code="admin.aiHelper.assistant.table.session"/></th>
                        <th><spring:message code="admin.aiHelper.assistant.table.role"/></th>
                        <th><spring:message code="admin.aiHelper.assistant.table.user"/></th>
                        <th><spring:message code="admin.aiHelper.assistant.table.content"/></th>
                        <th><spring:message code="admin.common.time"/></th>
                        <th style="width:100px;">
                            <div style="display:flex;gap:4px;justify-content:flex-end;">
                                <span style="font-size:11px;padding:3px 8px;"><spring:message code="admin.aiHelper.assistant.table.actions"/></span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty messages}">
                            <tr><td colspan="7" style="text-align:center;padding:40px;color:#94a3b8;"><spring:message code="admin.aiHelper.assistant.empty.messages"/></td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${messages}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${m.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">#${m.chatCommentIdx}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link"
                                                data-session-id="${m.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">
                                            <span>#${m.chatPostIdx}</span>
                                            <span style="font-size:11px;color:#94a3b8;">${fn:escapeXml(m.sessionTitle)}</span>
                                        </button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.commentRole == 'USER'}">
                                                <span style="padding:2px 8px;border-radius:4px;background:#dbeafe;color:#1d4ed8;font-size:11px;font-weight:600;"><spring:message code="admin.aiHelper.assistant.role.user"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="padding:2px 8px;border-radius:4px;background:#ccfbf1;color:#0f766e;font-size:11px;font-weight:600;"><spring:message code="admin.aiHelper.assistant.role.ai"/></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.nickname != null}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${m.userIdx}">
                                                    ${m.nickname}
                                                </button>
                                            </c:when>
                                            <c:otherwise><span style="color:#94a3b8;"><spring:message code="admin.aiHelper.assistant.userPrefix"/> #${m.userIdx}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="max-width:500px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:12px;">
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${m.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)">
                                        <c:choose>
                                            <c:when test="${fn:length(m.content) > 200}">
                                                ${fn:escapeXml(fn:substring(m.content, 0, 200))}…
                                            </c:when>
                                            <c:otherwise>${fn:escapeXml(m.content)}</c:otherwise>
                                        </c:choose>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-session-id="${m.chatPostIdx}"
                                                onclick="viewAssistantMessages(this.dataset.sessionId)"><fmt:formatDate value="${m.createdAt}" pattern="yyyy-MM-dd HH:mm"/></button>
                                    </td>
                                    <td style="text-align:right;">
                                        <div class="adm-row-actions is-single">
                                            <button type="button"
                                                    class="adm-row-btn detail"
                                                    data-session-id="${m.chatPostIdx}"
                                                    onclick="viewAssistantMessages(this.dataset.sessionId)"><spring:message code="admin.aiHelper.assistant.action.viewSession"/></button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <c:if test="${totalPages > 1}">
            <div style="display:flex;justify-content:center;gap:4px;margin-top:16px;">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=messages&page=${p}"
                       class="adm-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}" style="min-width:32px;">${p}</a>
                </c:forEach>
            </div>
        </c:if>
    </c:if>

</div>

<%-- 세션 메시지 조회 모달 --%>
<div id="asstMsgModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:9999;align-items:center;justify-content:center;">
    <div style="background:#fff;width:720px;max-width:90vw;max-height:80vh;border-radius:12px;overflow:hidden;display:flex;flex-direction:column;">
        <div style="padding:16px;border-bottom:1px solid #e5e7eb;display:flex;justify-content:space-between;align-items:center;">
            <h3 id="asstMsgModalTitle" style="margin:0;font-size:16px;"><spring:message code="admin.aiHelper.assistant.modal.title"/></h3>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="document.getElementById('asstMsgModal').style.display='none'"><spring:message code="admin.common.close"/></button>
        </div>
        <div id="asstMsgModalBody" style="padding:16px;overflow-y:auto;flex:1;"></div>
    </div>
</div>

<script>
(function () {
    const ctx = '${pageContext.request.contextPath}';
    const assistantMessages = {
        modalTitle: '<spring:message code="admin.aiHelper.assistant.modal.title" javaScriptEscape="true"/>',
        roleUser: '<spring:message code="admin.aiHelper.assistant.role.user" javaScriptEscape="true"/>',
        roleAi: '<spring:message code="admin.aiHelper.assistant.role.ai" javaScriptEscape="true"/>',
        empty: '<spring:message code="admin.aiHelper.assistant.empty.messages" javaScriptEscape="true"/>',
        viewFailed: '<spring:message code="admin.aiHelper.assistant.message.viewFailed" javaScriptEscape="true"/>',
        viewError: '<spring:message code="admin.aiHelper.assistant.message.viewError" javaScriptEscape="true"/>',
        deleteConfirm: '<spring:message code="admin.aiHelper.assistant.message.deleteConfirm" javaScriptEscape="true"/>',
        deleteDone: '<spring:message code="admin.aiHelper.assistant.message.deleteDone" javaScriptEscape="true"/>',
        deleteFailed: '<spring:message code="admin.aiHelper.assistant.message.deleteFailed" javaScriptEscape="true"/>',
        deleteError: '<spring:message code="admin.aiHelper.assistant.message.deleteError" javaScriptEscape="true"/>',
        sessionLabel: '<spring:message code="admin.aiHelper.assistant.table.session" javaScriptEscape="true"/>'
    };

    window.viewAssistantMessages = async function (sessionId) {
        try {
            const res = await fetch(ctx + '/admin/ai-helper/assistant/sessions/' + sessionId + '/messages');
            const data = await res.json();
            if (!data.success) { alert(assistantMessages.viewFailed); return; }
            const title = assistantMessages.sessionLabel + ' #' + sessionId + ' — ' + (data.session.title || '');
            document.getElementById('asstMsgModalTitle').textContent = title;
            const html = (data.messages || []).map(function (m) {
                const isUser = m.commentRole === 'USER';
                const roleLabel = isUser ? assistantMessages.roleUser : assistantMessages.roleAi;
                const color    = isUser ? '#1d4ed8' : '#0f766e';
                const bg       = isUser ? '#eff6ff' : '#f0fdfa';
                const content  = (m.content || '').replace(/</g, '&lt;').replace(/>/g, '&gt;');
                return '<div style="margin-bottom:12px;padding:10px;border-left:3px solid ' + color + ';background:' + bg + ';">' +
                       '<div style="font-size:11px;color:' + color + ';font-weight:600;">#' + m.commentOrder + ' ' + roleLabel + '</div>' +
                       '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + content + '</div>' +
                       '</div>';
            }).join('');
            document.getElementById('asstMsgModalBody').innerHTML = html || '<div style="color:#94a3b8;text-align:center;padding:40px;">' + assistantMessages.empty + '</div>';
            document.getElementById('asstMsgModal').style.display = 'flex';
        } catch (e) {
            alert(assistantMessages.viewError);
        }
    };

    window.deleteAssistantSession = async function (sessionId) {
        if (!confirm(assistantMessages.deleteConfirm.replace('{0}', sessionId))) return;
        try {
            const res = await fetch(ctx + '/admin/ai-helper/assistant/sessions/' + sessionId + '/delete', {
                method: 'POST'
            });
            const data = await res.json();
            if (data.success) {
                alert(assistantMessages.deleteDone);
                location.reload();
            } else {
                alert(assistantMessages.deleteFailed + ': ' + (data.message || ''));
            }
        } catch (e) {
            alert(assistantMessages.deleteError);
        }
    };
})();
</script>

<%@ include file="../layout-close.jsp" %>
