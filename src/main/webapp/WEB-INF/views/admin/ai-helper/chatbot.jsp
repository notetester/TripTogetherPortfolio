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

    <%-- ── 챗봇 내부 sub-tab ── --%>
    <div class="aih-tabs" style="display:flex;gap:4px;border-bottom:1px solid #e5e7eb;margin:20px 0;">
        <c:set var="tabs" value="dashboard,conversations,inappropriate,blocks,quotas"/>
        <c:set var="labels" value="대시보드,대화 세션,부적절 메시지,차단 관리,정책"/>
        <c:forTokens items="${tabs}" delims="," var="t" varStatus="st">
            <c:set var="label" value="${fn:split(labels, ',')[st.index]}"/>
            <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=${t}"
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
        <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-bottom:20px;">
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">💬 전체 대화 수</div>
                <div style="font-size:24px;font-weight:700;color:#38bdf8;">${totalConversations}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">⚠️ 부적절 메시지</div>
                <div style="font-size:24px;font-weight:700;color:#fb923c;">${inappropriateCount}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">⛔ 활성 차단</div>
                <div style="font-size:24px;font-weight:700;color:#ef4444;">${activeBlockCount}</div>
            </div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:14px;font-weight:600;margin-bottom:8px;">ℹ️ 안내</div>
            <div style="font-size:13px;color:#475569;line-height:1.6;">
                좌측 상단 탭에서 대화 세션/부적절 메시지/차단/정책을 관리할 수 있습니다.<br>
                챗봇 모델: Gemini 2.5 Flash.
            </div>
        </div>
    </c:if>

    <%-- ══════════════════════════════════════════
         대화 세션 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'conversations'}">
        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <form method="get" action="${pageContext.request.contextPath}/admin/ai-helper/chatbot" style="display:flex;gap:8px;">
                <input type="hidden" name="tab" value="conversations"/>
                <input type="text" name="keyword" value="${keyword}" placeholder="유저ID / IP / 제목 / 세션ID" class="adm-input" style="flex:1;"/>
                <button type="submit" class="adm-btn">검색</button>
            </form>
        </div>

        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>제목</th>
                        <th>유저</th>
                        <th>IP</th>
                        <th>메시지 수</th>
                        <th>최근 활동</th>
                        <th>상태</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty conversations}">
                            <tr><td colspan="8" style="text-align:center;padding:40px;color:#94a3b8;">대화가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="c" items="${conversations}">
                                <tr>
                                    <td>${c.conversationId}</td>
                                    <td>${c.title}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.userIdx != null}">유저 #${c.userIdx}</c:when>
                                            <c:otherwise><span style="color:#94a3b8;">비로그인</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${c.ipAddress}</td>
                                    <td>${c.messageCount}</td>
                                    <td><fmt:formatDate value="${c.lastActive}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.isDeleted}"><span style="color:#ef4444;">삭제됨</span></c:when>
                                            <c:otherwise><span style="color:#10b981;">활성</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button" class="adm-btn adm-btn-ghost" data-conv-id="${c.conversationId}" onclick="viewMessages(this.dataset.convId)">보기</button>
                                        <c:if test="${c.userIdx != null}">
                                            <button type="button" class="adm-btn adm-btn-ghost" data-block-value="${c.userIdx}" onclick="blockUser(this.dataset.blockValue)">유저 차단</button>
                                        </c:if>
                                        <button type="button" class="adm-btn adm-btn-ghost" data-block-value="${c.ipAddress}" onclick="blockIp(this.dataset.blockValue)">IP 차단</button>
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
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=conversations&page=${p}&keyword=${keyword}" class="adm-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}" style="min-width:32px;">${p}</a>
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
                        <th>ID</th>
                        <th>대화 ID</th>
                        <th>내용</th>
                        <th>작성 시각</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty messages}">
                            <tr><td colspan="5" style="text-align:center;padding:40px;color:#94a3b8;">부적절 메시지가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${messages}">
                                <tr>
                                    <td>${m.messageId}</td>
                                    <td>${m.conversationId}</td>
                                    <td style="max-width:600px;word-break:break-all;">${m.content}</td>
                                    <td><fmt:formatDate value="${m.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>
                                        <button type="button" class="adm-btn adm-btn-ghost" data-conv-id="${m.conversationId}" onclick="viewMessages(this.dataset.convId)">대화 보기</button>
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
                    <label style="font-size:12px;font-weight:600;display:block;margin-bottom:4px;">타입</label>
                    <select id="newBlockType" class="adm-input">
                        <option value="IP">IP</option>
                        <option value="USER">USER (user_idx)</option>
                    </select>
                </div>
                <div style="flex:2;">
                    <label style="font-size:12px;font-weight:600;display:block;margin-bottom:4px;">값</label>
                    <input type="text" id="newBlockValue" class="adm-input" placeholder="IP 주소 또는 user_idx"/>
                </div>
                <div style="flex:2;">
                    <label style="font-size:12px;font-weight:600;display:block;margin-bottom:4px;">사유</label>
                    <input type="text" id="newBlockReason" class="adm-input" placeholder="차단 사유"/>
                </div>
                <button type="button" class="adm-btn adm-btn-primary" onclick="createBlock()">차단 등록</button>
            </div>
        </div>

        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>타입</th>
                        <th>값</th>
                        <th>사유</th>
                        <th>차단자</th>
                        <th>차단 시각</th>
                        <th>만료</th>
                        <th>상태</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty blocks}">
                            <tr><td colspan="9" style="text-align:center;padding:40px;color:#94a3b8;">등록된 차단이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${blocks}">
                                <tr>
                                    <td>${b.blockId}</td>
                                    <td>${b.blockType}</td>
                                    <td>${b.blockValue}</td>
                                    <td>${b.reason}</td>
                                    <td>${b.blockedBy}</td>
                                    <td><fmt:formatDate value="${b.blockedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.expiresAt != null}"><fmt:formatDate value="${b.expiresAt}" pattern="yyyy-MM-dd HH:mm"/></c:when>
                                            <c:otherwise>영구</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.isActive}"><span style="color:#ef4444;">활성</span></c:when>
                                            <c:otherwise><span style="color:#94a3b8;">해제됨</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${b.isActive}">
                                            <button type="button" class="adm-btn adm-btn-ghost" data-block-id="${b.blockId}" onclick="deactivateBlock(this.dataset.blockId)">해제</button>
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
                등급별 챗봇 이용 한도를 설정합니다. GUEST는 비로그인 유저용이며 가장 제한적입니다.<br>
                ADMIN/SUPERADMIN은 한도 체크에서 자동 제외됩니다.
            </div>
        </div>

        <div class="adm-card" style="padding:0;overflow:hidden;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>등급</th>
                        <th>동시 대화 수</th>
                        <th>일일 메시지 한도</th>
                        <th>AI 컨텍스트 길이</th>
                        <th>마지막 수정자</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="q" items="${quotas}">
                        <tr data-quota-id="${q.quotaId}">
                            <td><strong>${q.grade}</strong></td>
                            <td><input type="number" class="adm-input q-conv" value="${q.maxConversations}" style="width:100px;"/></td>
                            <td><input type="number" class="adm-input q-msg" value="${q.maxMessagesPerDay}" style="width:100px;"/></td>
                            <td><input type="number" class="adm-input q-ctx" value="${q.maxContextMessages}" style="width:100px;"/></td>
                            <td>${q.updatedBy}</td>
                            <td>
                                <button type="button" class="adm-btn adm-btn-primary" data-quota-id="${q.quotaId}" onclick="updateQuota(this.dataset.quotaId)">저장</button>
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
            <h3 id="msgModalTitle" style="margin:0;font-size:16px;">대화 내용</h3>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="document.getElementById('msgModal').style.display='none'">닫기</button>
        </div>
        <div id="msgModalBody" style="padding:16px;overflow-y:auto;flex:1;"></div>
    </div>
</div>

<script>
(function () {
    const ctx = '${pageContext.request.contextPath}';

    window.viewMessages = async function (convId) {
        try {
            const res = await fetch(ctx + '/admin/ai-helper/conversations/' + convId + '/messages');
            const data = await res.json();
            if (!data.success) { alert('조회 실패'); return; }
            document.getElementById('msgModalTitle').textContent =
                '대화 #' + convId + ' — ' + (data.conversation.title || '');
            const html = (data.messages || []).map(function (m) {
                const role = m.role === 'user' ? '유저' : 'AI';
                const color = m.role === 'user' ? '#1d4ed8' : '#0f766e';
                const flag = m.isInappropriate ? ' ⚠️' : '';
                const content = (m.content || '').replace(/</g, '&lt;').replace(/>/g, '&gt;');
                return '<div style="margin-bottom:12px;padding:10px;border-left:3px solid ' + color + ';background:#f8fafc;">' +
                       '<div style="font-size:11px;color:' + color + ';font-weight:600;">' + role + flag + '</div>' +
                       '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + content + '</div>' +
                       '</div>';
            }).join('');
            document.getElementById('msgModalBody').innerHTML = html || '<div>메시지가 없습니다.</div>';
            document.getElementById('msgModal').style.display = 'flex';
        } catch (e) { alert('조회 중 오류'); }
    };

    window.createBlock = async function () {
        const type   = document.getElementById('newBlockType').value;
        const value  = document.getElementById('newBlockValue').value.trim();
        const reason = document.getElementById('newBlockReason').value.trim();
        if (!value) { alert('값을 입력하세요'); return; }
        const res = await fetch(ctx + '/admin/ai-helper/blocks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ blockType: type, blockValue: value, reason: reason })
        });
        const data = await res.json();
        if (data.success) { alert('차단 등록 완료'); location.reload(); }
        else alert('차단 등록 실패: ' + (data.message || ''));
    };

    window.deactivateBlock = async function (blockId) {
        if (!confirm('차단을 해제하시겠습니까?')) return;
        const res = await fetch(ctx + '/admin/ai-helper/blocks/' + blockId + '/deactivate', { method: 'POST' });
        const data = await res.json();
        if (data.success) location.reload();
        else alert('해제 실패');
    };

    window.blockUser = function (userIdx) {
        if (!confirm('이 유저를 챗봇에서 차단하시겠습니까?')) return;
        doQuickBlock('USER', String(userIdx));
    };
    window.blockIp = function (ip) {
        if (!confirm('이 IP(' + ip + ')를 차단하시겠습니까?')) return;
        doQuickBlock('IP', ip);
    };
    async function doQuickBlock(type, value) {
        const res = await fetch(ctx + '/admin/ai-helper/blocks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ blockType: type, blockValue: value, reason: '관리자 수동 차단' })
        });
        const data = await res.json();
        alert(data.success ? '차단 완료' : '차단 실패');
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
        alert(data.success ? '저장 완료' : '저장 실패');
    };
})();
</script>

<%@ include file="../layout-close.jsp" %>
