<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="aiHelper"/>
<c:set var="pageTitle" value="AI 도우미 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 최상위 섹션 탭 (AI 도우미 / AI 챗봇) ── --%>
    <%@ include file="_section-tabs.jsp" %>

    <%-- ── 도우미 내부 sub-tab ── --%>
    <div class="aih-tabs" style="display:flex;gap:4px;border-bottom:1px solid #e5e7eb;margin:20px 0;">
        <c:set var="tabs" value="dashboard,messages"/>
        <c:set var="labels" value="대시보드,메시지"/>
        <c:forTokens items="${tabs}" delims="," var="t" varStatus="st">
            <c:set var="label" value="${fn:split(labels, ',')[st.index]}"/>
            <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=${t}"
               class="aih-tab ${tab == t ? 'active' : ''}"
               style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == t ? '700' : '500'};color:${tab == t ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == t ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
                ${label}
            </a>
        </c:forTokens>
    </div>

    <%-- ══════════════════════════════════════════
         대시보드 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'dashboard'}">
        <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:16px;">
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">🧭 전체 세션 수</div>
                <div style="font-size:24px;font-weight:700;color:#38bdf8;">${stats.totalSessions}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">💬 전체 메시지 수</div>
                <div style="font-size:24px;font-weight:700;color:#0ea5e9;">${stats.totalMessages}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">📅 오늘 생성 세션</div>
                <div style="font-size:24px;font-weight:700;color:#10b981;">${stats.todaySessions}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">👤 이용 유저 수</div>
                <div style="font-size:24px;font-weight:700;color:#8b5cf6;">${stats.uniqueUsers}</div>
            </div>
        </div>

        <%-- ── 대화 세션 목록 (대시보드 내 통합) ── --%>
        <div style="font-size:14px;font-weight:700;margin:8px 0 12px;">대화 세션</div>

        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <form method="get" action="${pageContext.request.contextPath}/admin/ai-helper" style="display:flex;gap:8px;">
                <input type="hidden" name="tab" value="dashboard"/>
                <input type="text" name="keyword" value="${keyword}" placeholder="유저ID / 닉네임 / 제목 / 세션ID / user_idx" class="adm-input" style="flex:1;"/>
                <button type="submit" class="adm-btn">검색</button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper" class="adm-btn adm-btn-ghost">초기화</a>
                </c:if>
            </form>
            <div style="font-size:12px;color:#64748b;margin-top:8px;">총 ${total}건</div>
        </div>

        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>세션 ID</th>
                        <th>제목</th>
                        <th>유저</th>
                        <th>메시지 수</th>
                        <th>생성일</th>
                        <th>마지막 활동</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty sessions}">
                            <tr><td colspan="7" style="text-align:center;padding:40px;color:#94a3b8;">세션이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="s" items="${sessions}">
                                <tr>
                                    <td>${s.chatPostIdx}</td>
                                    <td style="max-width:300px;word-break:break-all;">${s.title}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.nickname != null}">
                                                ${s.nickname} <span style="color:#94a3b8;">(#${s.userIdx})</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color:#94a3b8;">유저 #${s.userIdx} (삭제됨)</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${s.messageCount}</td>
                                    <td><fmt:formatDate value="${s.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.lastMessageAt != null}">
                                                <fmt:formatDate value="${s.lastMessageAt}" pattern="yyyy-MM-dd HH:mm"/>
                                            </c:when>
                                            <c:otherwise><span style="color:#94a3b8;">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button" class="adm-btn adm-btn-ghost" data-session-id="${s.chatPostIdx}" onclick="viewAssistantMessages(this.dataset.sessionId)">보기</button>
                                        <button type="button" class="adm-btn adm-btn-ghost" data-session-id="${s.chatPostIdx}" onclick="deleteAssistantSession(this.dataset.sessionId)" style="color:#ef4444;">삭제</button>
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
                전체 메시지를 최신순으로 표시합니다. 특정 세션의 대화 맥락을 이어서 보려면 "세션 보기"를 클릭하세요.
            </div>
            <div style="font-size:12px;color:#64748b;margin-top:8px;">총 ${total}건</div>
        </div>

        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>세션</th>
                        <th>역할</th>
                        <th>유저</th>
                        <th>내용</th>
                        <th>시각</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty messages}">
                            <tr><td colspan="7" style="text-align:center;padding:40px;color:#94a3b8;">메시지가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${messages}">
                                <tr>
                                    <td>${m.chatCommentIdx}</td>
                                    <td>#${m.chatPostIdx}<br><span style="font-size:11px;color:#94a3b8;">${fn:escapeXml(m.sessionTitle)}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.commentRole == 'USER'}">
                                                <span style="padding:2px 8px;border-radius:4px;background:#dbeafe;color:#1d4ed8;font-size:11px;font-weight:600;">유저</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="padding:2px 8px;border-radius:4px;background:#ccfbf1;color:#0f766e;font-size:11px;font-weight:600;">AI</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.nickname != null}">
                                                ${m.nickname}
                                            </c:when>
                                            <c:otherwise><span style="color:#94a3b8;">#${m.userIdx}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="max-width:500px;word-break:break-all;white-space:pre-wrap;font-size:12px;">
                                        <c:choose>
                                            <c:when test="${fn:length(m.content) > 200}">
                                                ${fn:escapeXml(fn:substring(m.content, 0, 200))}…
                                            </c:when>
                                            <c:otherwise>${fn:escapeXml(m.content)}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${m.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                                    </td>
                                    <td>
                                        <button type="button" class="adm-btn adm-btn-ghost" data-session-id="${m.chatPostIdx}" onclick="viewAssistantMessages(this.dataset.sessionId)">세션 보기</button>
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
            <h3 id="asstMsgModalTitle" style="margin:0;font-size:16px;">세션 내용</h3>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="document.getElementById('asstMsgModal').style.display='none'">닫기</button>
        </div>
        <div id="asstMsgModalBody" style="padding:16px;overflow-y:auto;flex:1;"></div>
    </div>
</div>

<script>
(function () {
    const ctx = '${pageContext.request.contextPath}';

    window.viewAssistantMessages = async function (sessionId) {
        try {
            const res = await fetch(ctx + '/admin/ai-helper/assistant/sessions/' + sessionId + '/messages');
            const data = await res.json();
            if (!data.success) { alert('조회 실패'); return; }
            const title = '세션 #' + sessionId + ' — ' + (data.session.title || '');
            document.getElementById('asstMsgModalTitle').textContent = title;
            const html = (data.messages || []).map(function (m) {
                const isUser = m.commentRole === 'USER';
                const roleLabel = isUser ? '유저' : 'AI';
                const color    = isUser ? '#1d4ed8' : '#0f766e';
                const bg       = isUser ? '#eff6ff' : '#f0fdfa';
                const content  = (m.content || '').replace(/</g, '&lt;').replace(/>/g, '&gt;');
                return '<div style="margin-bottom:12px;padding:10px;border-left:3px solid ' + color + ';background:' + bg + ';">' +
                       '<div style="font-size:11px;color:' + color + ';font-weight:600;">#' + m.commentOrder + ' ' + roleLabel + '</div>' +
                       '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + content + '</div>' +
                       '</div>';
            }).join('');
            document.getElementById('asstMsgModalBody').innerHTML = html || '<div style="color:#94a3b8;text-align:center;padding:40px;">메시지가 없습니다.</div>';
            document.getElementById('asstMsgModal').style.display = 'flex';
        } catch (e) {
            alert('조회 중 오류');
        }
    };

    window.deleteAssistantSession = async function (sessionId) {
        if (!confirm('세션 #' + sessionId + '과(와) 포함된 모든 메시지를 삭제합니다. 계속하시겠습니까?')) return;
        try {
            const res = await fetch(ctx + '/admin/ai-helper/assistant/sessions/' + sessionId + '/delete', {
                method: 'POST'
            });
            const data = await res.json();
            if (data.success) {
                alert('삭제 완료');
                location.reload();
            } else {
                alert('삭제 실패: ' + (data.message || ''));
            }
        } catch (e) {
            alert('삭제 중 오류');
        }
    };
})();
</script>

<%@ include file="../layout-close.jsp" %>
