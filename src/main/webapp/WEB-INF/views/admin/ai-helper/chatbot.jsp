<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="aiHelper"/>
<spring:message code="admin.aiHelper.chatbot.pageTitle" var="pageTitle"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 챗봇 내부 sub-tab ── --%>
    <div class="aih-tabs" style="display:flex;gap:4px;border-bottom:1px solid #e5e7eb;margin:20px 0;">
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=dashboard"
           class="aih-tab ${tab == 'dashboard' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'dashboard' ? '700' : '500'};color:${tab == 'dashboard' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'dashboard' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            <spring:message code="admin.aiHelper.chatbot.tab.dashboard"/>
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=inappropriate"
           class="aih-tab ${tab == 'inappropriate' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'inappropriate' ? '700' : '500'};color:${tab == 'inappropriate' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'inappropriate' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            <spring:message code="admin.aiHelper.chatbot.tab.inappropriate"/>
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=blocks"
           class="aih-tab ${tab == 'blocks' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'blocks' ? '700' : '500'};color:${tab == 'blocks' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'blocks' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            <spring:message code="admin.aiHelper.chatbot.tab.blocks"/>
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=quotas"
           class="aih-tab ${tab == 'quotas' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'quotas' ? '700' : '500'};color:${tab == 'quotas' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'quotas' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            <spring:message code="admin.aiHelper.chatbot.tab.quotas"/>
        </a>
    </div>

    <%-- ══════════════════════════════════════════
         대시보드 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'dashboard'}">
        <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:20px;">
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">💬 <spring:message code="admin.aiHelper.chatbot.kpi.totalConversations"/></div>
                <div style="font-size:24px;font-weight:700;color:#38bdf8;">${totalConversations}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">📅 <spring:message code="admin.aiHelper.chatbot.kpi.todayConversations"/></div>
                <div style="font-size:24px;font-weight:700;color:#10b981;">${todayConversations}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">⚠️ <spring:message code="admin.aiHelper.chatbot.kpi.inappropriate"/></div>
                <div style="font-size:24px;font-weight:700;color:#fb923c;">${inappropriateCount}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">⛔ <spring:message code="admin.aiHelper.chatbot.kpi.activeBlocks"/></div>
                <div style="font-size:24px;font-weight:700;color:#ef4444;">${activeBlockCount}</div>
            </div>
        </div>

        <%-- ── 대화 세션 목록 (대시보드 내 통합) ── --%>
        <div style="font-size:14px;font-weight:700;margin:8px 0 12px;"><spring:message code="admin.aiHelper.assistant.section.sessions"/></div>

        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <form method="get" action="${pageContext.request.contextPath}/admin/ai-helper/chatbot" style="display:flex;gap:8px;">
                <input type="hidden" name="tab" value="dashboard"/>
                <input type="text" name="keyword" value="${keyword}" placeholder="<spring:message code='admin.aiHelper.chatbot.searchPlaceholder'/>" class="adm-input" style="flex:1;"/>
                <button type="submit" class="adm-btn"><spring:message code="admin.common.search"/></button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot" class="adm-btn adm-btn-ghost"><spring:message code="admin.common.reset"/></a>
                </c:if>
            </form>
            <div style="font-size:12px;color:#64748b;margin-top:8px;"><spring:message code="admin.common.totalCountFormat" arguments="${total}"/></div>
        </div>

        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th><spring:message code="admin.aiHelper.chatbot.table.id"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.title"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.user"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.ip"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.messageCount"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.lastActive"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.status"/></th>
                        <th style="width:200px;">
                            <div style="display:flex;gap:4px;justify-content:flex-end;">
                                <span style="font-size:11px;padding:3px 8px;"><spring:message code="admin.aiHelper.chatbot.table.actions"/></span>
                                <span style="font-size:11px;padding:3px 8px;visibility:hidden;"><spring:message code="admin.aiHelper.chatbot.action.blockUser"/></span>
                                <span style="font-size:11px;padding:3px 8px;visibility:hidden;"><spring:message code="admin.aiHelper.chatbot.action.blockIp"/></span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty conversations}">
                            <tr><td colspan="8" style="text-align:center;padding:40px;color:#94a3b8;"><spring:message code="admin.aiHelper.chatbot.empty.conversations"/></td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="c" items="${conversations}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">#${c.conversationId}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${c.title}</button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.userIdx != null}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${c.userIdx}">
                                                    <spring:message code="admin.aiHelper.assistant.userPrefix"/> #${c.userIdx}
                                                </button>
                                            </c:when>
                                            <c:otherwise><span style="color:#94a3b8;"><spring:message code="admin.aiHelper.chatbot.guest"/></span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-inline-link js-open-ip-context"
                                                data-ip-address="${c.ipAddress}"
                                                data-default-tab="blocks">${c.ipAddress}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${c.messageCount}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${fn:replace(fn:substring(c.lastActive, 0, 16), 'T', ' ')}</button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.isDeleted}">
                                                <button type="button"
                                                        class="adm-cell-link adm-cell-link--inline"
                                                        data-conv-id="${c.conversationId}"
                                                        onclick="viewMessages(this.dataset.convId)"
                                                        style="color:#ef4444;"><spring:message code="admin.aiHelper.chatbot.status.deleted"/></button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button"
                                                        class="adm-cell-link adm-cell-link--inline"
                                                        data-conv-id="${c.conversationId}"
                                                        onclick="viewMessages(this.dataset.convId)"
                                                        style="color:#10b981;"><spring:message code="admin.aiHelper.chatbot.status.active"/></button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align:right;">
                                        <div class="adm-row-actions">
                                            <button type="button"
                                                    class="adm-row-btn detail"
                                                    data-conv-id="${c.conversationId}"
                                                    onclick="viewMessages(this.dataset.convId)"><spring:message code="admin.aiHelper.chatbot.action.view"/></button>
                                            <div class="action-menu-wrap">
                                                <button type="button"
                                                        class="adm-row-btn detail adm-row-btn-more"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu">
                                                    <c:if test="${c.userIdx != null}">
                                                        <button type="button"
                                                                class="action-menu-item"
                                                                data-block-value="${c.userIdx}"
                                                                onclick="blockUser(this.dataset.blockValue)"><spring:message code="admin.aiHelper.chatbot.action.blockUser"/></button>
                                                    </c:if>
                                                    <button type="button"
                                                            class="action-menu-item"
                                                            data-block-value="${c.ipAddress}"
                                                            onclick="blockIp(this.dataset.blockValue)"><spring:message code="admin.aiHelper.chatbot.action.blockIp"/></button>
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

        <%-- 페이징 --%>
        <c:if test="${totalPages > 1}">
            <div style="display:flex;justify-content:center;gap:4px;margin-top:16px;">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=dashboard&page=${p}&keyword=${keyword}" class="adm-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}" style="min-width:32px;">${p}</a>
                </c:forEach>
            </div>
        </c:if>

    </c:if>

    <%-- ══════════════════════════════════════════
         부적절 메시지 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'inappropriate'}">
        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th><spring:message code="admin.aiHelper.chatbot.table.id"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.conversationId"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.content"/></th>
                        <th><spring:message code="admin.common.time"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.actions"/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty messages}">
                            <tr><td colspan="5" style="text-align:center;padding:40px;color:#94a3b8;"><spring:message code="admin.aiHelper.chatbot.empty.inappropriate"/></td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${messages}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${m.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">#${m.messageId}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${m.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">#${m.conversationId}</button>
                                    </td>
                                    <td style="max-width:600px;word-break:break-all;">
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${m.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${m.content}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${m.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${fn:replace(fn:substring(m.createdAt, 0, 16), 'T', ' ')}</button>
                                    </td>
                                    <td>
                                        <div class="adm-row-actions is-single">
                                            <button type="button"
                                                    class="adm-row-btn detail"
                                                    data-conv-id="${m.conversationId}"
                                                    onclick="viewMessages(this.dataset.convId)"><spring:message code="admin.aiHelper.chatbot.action.viewConversation"/></button>
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
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=inappropriate&page=${p}" class="adm-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}" style="min-width:32px;">${p}</a>
                </c:forEach>
            </div>
        </c:if>
    </c:if>

    <%-- ══════════════════════════════════════════
         차단 관리 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'blocks'}">
        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <div style="display:flex;gap:8px;align-items:end;">
                <div style="flex:1;">
                    <label style="font-size:12px;font-weight:600;display:block;margin-bottom:4px;"><spring:message code="admin.aiHelper.chatbot.table.type"/></label>
                    <select id="newBlockType" class="adm-input">
                        <option value="IP"><spring:message code="admin.aiHelper.chatbot.type.ip"/></option>
                        <option value="USER"><spring:message code="admin.aiHelper.chatbot.type.user"/></option>
                    </select>
                </div>
                <div style="flex:2;">
                    <label style="font-size:12px;font-weight:600;display:block;margin-bottom:4px;"><spring:message code="admin.aiHelper.chatbot.table.value"/></label>
                    <input type="text" id="newBlockValue" class="adm-input" placeholder="<spring:message code='admin.aiHelper.chatbot.valuePlaceholder'/>"/>
                </div>
                <div style="flex:2;">
                    <label style="font-size:12px;font-weight:600;display:block;margin-bottom:4px;"><spring:message code="admin.aiHelper.chatbot.table.reason"/></label>
                    <input type="text" id="newBlockReason" class="adm-input" placeholder="<spring:message code='admin.aiHelper.chatbot.reasonPlaceholder'/>"/>
                </div>
                <button type="button" class="adm-btn adm-btn-primary" onclick="createBlock()"><spring:message code="admin.aiHelper.chatbot.action.createBlock"/></button>
            </div>
        </div>

        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th><spring:message code="admin.aiHelper.chatbot.table.id"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.type"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.value"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.reason"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.blockedBy"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.blockedAt"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.expiresAt"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.status"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.actions"/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty blocks}">
                            <tr><td colspan="9" style="text-align:center;padding:40px;color:#94a3b8;"><spring:message code="admin.aiHelper.chatbot.empty.blocks"/></td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${blocks}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-block-id="${b.blockId}"
                                                onclick="deactivateBlock(this.dataset.blockId)">#${b.blockId}</button>
                                    </td>
                                    <td>${b.blockType}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.blockType eq 'IP'}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-ip-context"
                                                        data-ip-address="${b.blockValue}"
                                                        data-default-tab="blocks">${b.blockValue}</button>
                                            </c:when>
                                            <c:when test="${b.blockType eq 'USER'}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${b.blockValue}">${b.blockValue}</button>
                                            </c:when>
                                            <c:otherwise>${b.blockValue}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-block-id="${b.blockId}"
                                                onclick="deactivateBlock(this.dataset.blockId)">${b.reason}</button>
                                    </td>
                                    <td>${b.blockedBy}</td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-block-id="${b.blockId}"
                                                onclick="deactivateBlock(this.dataset.blockId)">${fn:replace(fn:substring(b.blockedAt, 0, 16), 'T', ' ')}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-block-id="${b.blockId}"
                                                onclick="deactivateBlock(this.dataset.blockId)">
                                        <c:choose>
                                            <c:when test="${b.expiresAt != null}">${fn:replace(fn:substring(b.expiresAt, 0, 16), 'T', ' ')}</c:when>
                                            <c:otherwise><spring:message code="admin.aiHelper.chatbot.value.permanent"/></c:otherwise>
                                        </c:choose>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-block-id="${b.blockId}"
                                                onclick="deactivateBlock(this.dataset.blockId)">
                                        <c:choose>
                                            <c:when test="${b.isActive}"><span style="color:#ef4444;"><spring:message code="admin.aiHelper.chatbot.status.active"/></span></c:when>
                                            <c:otherwise><span style="color:#94a3b8;"><spring:message code="admin.aiHelper.chatbot.status.released"/></span></c:otherwise>
                                        </c:choose>
                                        </button>
                                    </td>
                                    <td>
                                        <c:if test="${b.isActive}">
                                            <div class="adm-row-actions is-single">
                                                <button type="button"
                                                        class="adm-row-btn danger"
                                                        data-block-id="${b.blockId}"
                                                        onclick="deactivateBlock(this.dataset.blockId)"><spring:message code="admin.aiHelper.chatbot.action.release"/></button>
                                            </div>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </c:if>

    <%-- ══════════════════════════════════════════
         정책 (등급별 한도) 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'quotas'}">
        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <div style="font-size:13px;color:#475569;line-height:1.6;">
                <spring:message code="admin.aiHelper.chatbot.description.quota"/><br>
                <spring:message code="admin.aiHelper.chatbot.description.quotaSub"/>
            </div>
        </div>

        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th><spring:message code="admin.aiHelper.chatbot.table.grade"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.maxConversations"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.maxMessages"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.maxContext"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.updatedBy"/></th>
                        <th><spring:message code="admin.aiHelper.chatbot.table.actions"/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="q" items="${quotas}">
                        <tr data-quota-id="${q.quotaId}">
                            <td><strong>${q.grade}</strong></td>
                            <td><input type="number" class="adm-input q-conv" value="${q.maxConversations}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                            <td><input type="number" class="adm-input q-msg" value="${q.maxMessagesPerDay}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                            <td><input type="number" class="adm-input q-ctx" value="${q.maxContextMessages}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                            <td>${q.updatedBy}</td>
                            <td>
                                <button type="button" class="adm-btn adm-btn-primary" data-quota-id="${q.quotaId}" onclick="updateQuota(this.dataset.quotaId)"><spring:message code="admin.common.save"/></button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

</div>

<%-- 대화 메시지 조회 모달 --%>
<div id="msgModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:9999;align-items:center;justify-content:center;">
    <div style="background:#fff;width:700px;max-width:90vw;max-height:80vh;border-radius:12px;overflow:hidden;display:flex;flex-direction:column;">
        <div style="padding:16px;border-bottom:1px solid #e5e7eb;display:flex;justify-content:space-between;align-items:center;">
            <h3 id="msgModalTitle" style="margin:0;font-size:16px;"><spring:message code="admin.aiHelper.chatbot.modal.title"/></h3>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="document.getElementById('msgModal').style.display='none'"><spring:message code="admin.common.close"/></button>
        </div>
        <div id="msgModalBody" style="padding:16px;overflow-y:auto;flex:1;"></div>
    </div>
</div>

<script>
(function () {
    const ctx = '${pageContext.request.contextPath}';
    const chatbotMessages = {
        modalTitle: '<spring:message code="admin.aiHelper.chatbot.modal.title" javaScriptEscape="true"/>',
        roleUser: '<spring:message code="admin.aiHelper.assistant.role.user" javaScriptEscape="true"/>',
        roleAi: '<spring:message code="admin.aiHelper.assistant.role.ai" javaScriptEscape="true"/>',
        emptyMessages: '<spring:message code="admin.aiHelper.chatbot.empty.messages" javaScriptEscape="true"/>',
        viewFailed: '<spring:message code="admin.aiHelper.chatbot.message.viewFailed" javaScriptEscape="true"/>',
        viewError: '<spring:message code="admin.aiHelper.chatbot.message.viewError" javaScriptEscape="true"/>',
        valueRequired: '<spring:message code="admin.aiHelper.chatbot.message.valueRequired" javaScriptEscape="true"/>',
        createBlockSuccess: '<spring:message code="admin.aiHelper.chatbot.message.createBlockSuccess" javaScriptEscape="true"/>',
        createBlockFailed: '<spring:message code="admin.aiHelper.chatbot.message.createBlockFailed" javaScriptEscape="true"/>',
        deactivateConfirm: '<spring:message code="admin.aiHelper.chatbot.message.deactivateConfirm" javaScriptEscape="true"/>',
        deactivateFailed: '<spring:message code="admin.aiHelper.chatbot.message.deactivateFailed" javaScriptEscape="true"/>',
        blockUserConfirm: '<spring:message code="admin.aiHelper.chatbot.message.blockUserConfirm" javaScriptEscape="true"/>',
        blockIpConfirm: '<spring:message code="admin.aiHelper.chatbot.message.blockIpConfirm" javaScriptEscape="true"/>',
        quickBlockReason: '<spring:message code="admin.aiHelper.chatbot.message.quickBlockReason" javaScriptEscape="true"/>',
        quotaSaved: '<spring:message code="admin.aiHelper.chatbot.message.quotaSaved" javaScriptEscape="true"/>',
        quotaSaveFailed: '<spring:message code="admin.aiHelper.chatbot.message.quotaSaveFailed" javaScriptEscape="true"/>',
        conversationLabel: '<spring:message code="admin.aiHelper.chatbot.table.conversationId" javaScriptEscape="true"/>'
    };

    window.viewMessages = async function (convId) {
        try {
            const res = await fetch(ctx + '/admin/ai-helper/conversations/' + convId + '/messages');
            const data = await res.json();
            if (!data.success) { alert(chatbotMessages.viewFailed); return; }
            document.getElementById('msgModalTitle').textContent =
                chatbotMessages.conversationLabel + ' #' + convId + ' — ' + (data.conversation.title || '');
            const html = (data.messages || []).map(function (m) {
                const role = m.role === 'user' ? chatbotMessages.roleUser : chatbotMessages.roleAi;
                const color = m.role === 'user' ? '#1d4ed8' : '#0f766e';
                const flag = m.isInappropriate ? ' ⚠️' : '';
                const content = (m.content || '').replace(/</g, '&lt;').replace(/>/g, '&gt;');
                return '<div style="margin-bottom:12px;padding:10px;border-left:3px solid ' + color + ';background:#f8fafc;">' +
                       '<div style="font-size:11px;color:' + color + ';font-weight:600;">' + role + flag + '</div>' +
                       '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + content + '</div>' +
                       '</div>';
            }).join('');
            document.getElementById('msgModalBody').innerHTML = html || '<div>' + chatbotMessages.emptyMessages + '</div>';
            document.getElementById('msgModal').style.display = 'flex';
        } catch (e) { alert(chatbotMessages.viewError); }
    };

    window.createBlock = async function () {
        const type   = document.getElementById('newBlockType').value;
        const value  = document.getElementById('newBlockValue').value.trim();
        const reason = document.getElementById('newBlockReason').value.trim();
        if (!value) { alert(chatbotMessages.valueRequired); return; }
        const res = await fetch(ctx + '/admin/ai-helper/blocks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ blockType: type, blockValue: value, reason: reason })
        });
        const data = await res.json();
        if (data.success) { alert(chatbotMessages.createBlockSuccess); location.reload(); }
        else alert(chatbotMessages.createBlockFailed + ': ' + (data.message || ''));
    };

    window.deactivateBlock = async function (blockId) {
        if (!confirm(chatbotMessages.deactivateConfirm)) return;
        const res = await fetch(ctx + '/admin/ai-helper/blocks/' + blockId + '/deactivate', { method: 'POST' });
        const data = await res.json();
        if (data.success) location.reload();
        else alert(chatbotMessages.deactivateFailed);
    };

    window.blockUser = function (userIdx) {
        if (!confirm(chatbotMessages.blockUserConfirm)) return;
        doQuickBlock('USER', String(userIdx));
    };
    window.blockIp = function (ip) {
        if (!confirm(chatbotMessages.blockIpConfirm.replace('{0}', ip))) return;
        doQuickBlock('IP', ip);
    };
    async function doQuickBlock(type, value) {
        const res = await fetch(ctx + '/admin/ai-helper/blocks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ blockType: type, blockValue: value, reason: chatbotMessages.quickBlockReason })
        });
        const data = await res.json();
        alert(data.success ? chatbotMessages.createBlockSuccess : chatbotMessages.createBlockFailed);
    }

    window.updateQuota = async function (quotaId) {
        const row = document.querySelector('tr[data-quota-id="' + quotaId + '"]');
        if (!row) return;
        const payload = {
            maxConversations:   parseInt(row.querySelector('.q-conv').value, 10),
            maxMessagesPerDay:  parseInt(row.querySelector('.q-msg').value, 10),
            maxContextMessages: parseInt(row.querySelector('.q-ctx').value, 10)
        };
        const res = await fetch(ctx + '/admin/ai-helper/quotas/' + quotaId, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        const data = await res.json();
        alert(data.success ? chatbotMessages.quotaSaved : chatbotMessages.quotaSaveFailed);
    };
})();
</script>

<%@ include file="../layout-close.jsp" %>
