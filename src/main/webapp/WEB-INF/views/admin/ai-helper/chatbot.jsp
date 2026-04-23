<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="aiHelper"/>
<c:set var="pageTitle" value="AI 챗봇 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 챗봇 내부 sub-tab ── --%>
    <div class="aih-tabs" style="display:flex;gap:4px;border-bottom:1px solid #e5e7eb;margin:20px 0;">
        <c:set var="tabs" value="dashboard,links,inappropriate,blocks,quotas"/>
        <c:set var="labels" value="대시보드,링크 클릭,부적절 메시지,차단 관리,정책"/>
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
        <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:20px;">
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">💬 전체 대화 수</div>
                <div style="font-size:24px;font-weight:700;color:#38bdf8;">${totalConversations}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">📅 오늘 대화</div>
                <div style="font-size:24px;font-weight:700;color:#10b981;">${todayConversations}</div>
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

        <%-- ── 대화 세션 목록 (대시보드 내 통합) ── --%>
        <div style="font-size:14px;font-weight:700;margin:8px 0 12px;">대화 세션</div>

        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <form method="get" action="${pageContext.request.contextPath}/admin/ai-helper/chatbot" style="display:flex;gap:8px;">
                <input type="hidden" name="tab" value="dashboard"/>
                <input type="text" name="keyword" value="${keyword}" placeholder="유저ID / IP / 제목 / 세션ID" class="adm-input" style="flex:1;"/>
                <button type="submit" class="adm-btn">검색</button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot" class="adm-btn adm-btn-ghost">초기화</a>
                </c:if>
            </form>
            <div style="font-size:12px;color:#64748b;margin-top:8px;">총 ${total}건</div>
        </div>

        <div class="adm-card" style="padding:0;overflow-x:auto;">
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
                        <th style="width:200px;">
                            <div style="display:flex;gap:4px;justify-content:flex-end;">
                                <span style="font-size:11px;padding:3px 8px;">액션</span>
                                <span style="font-size:11px;padding:3px 8px;visibility:hidden;">유저 차단</span>
                                <span style="font-size:11px;padding:3px 8px;visibility:hidden;">IP 차단</span>
                            </div>
                        </th>
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
                                    <td>${fn:replace(fn:substring(c.lastActive, 0, 16), 'T', ' ')}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.isDeleted}"><span style="color:#ef4444;">삭제됨</span></c:when>
                                            <c:otherwise><span style="color:#10b981;">활성</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align:right;">
                                        <div style="display:flex;gap:4px;flex-wrap:wrap;justify-content:flex-end;">
                                            <button type="button" class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;" data-conv-id="${c.conversationId}" onclick="viewMessages(this.dataset.convId)">보기</button>
                                            <c:if test="${c.userIdx != null}">
                                                <button type="button" class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;" data-block-value="${c.userIdx}" onclick="blockUser(this.dataset.blockValue)">유저 차단</button>
                                            </c:if>
                                            <button type="button" class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;" data-block-value="${c.ipAddress}" onclick="blockIp(this.dataset.blockValue)">IP 차단</button>
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
         링크 클릭 분석 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'links'}">
        <%-- 기간 필터 --%>
        <div class="adm-card" style="padding:14px 16px;margin-bottom:16px;display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
            <div style="font-size:13px;color:#475569;font-weight:600;">기간</div>
            <c:forEach var="d" items="7,30,90,365">
                <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=links&days=${d}"
                   class="adm-btn ${rangeDays == d ? 'adm-btn-primary' : 'adm-btn-ghost'}"
                   style="font-size:12px;padding:4px 12px;">
                    최근 ${d}일
                </a>
            </c:forEach>
            <div style="margin-left:auto;font-size:12px;color:#64748b;">
                총 <strong style="color:#1d4ed8;">${totalClicks}</strong> 건
            </div>
        </div>

        <%-- 일별 추이 (CSS 막대) --%>
        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <div style="font-size:13px;font-weight:700;color:#1e293b;margin-bottom:12px;">📈 일별 클릭 추이</div>
            <c:choose>
                <c:when test="${empty dailyTrend}">
                    <div style="padding:24px;text-align:center;color:#94a3b8;font-size:13px;">데이터가 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <c:set var="maxCount" value="0"/>
                    <c:forEach var="row" items="${dailyTrend}">
                        <c:if test="${row.clickCount > maxCount}">
                            <c:set var="maxCount" value="${row.clickCount}"/>
                        </c:if>
                    </c:forEach>
                    <div style="display:flex;align-items:flex-end;gap:3px;height:140px;overflow-x:auto;padding-bottom:4px;">
                        <c:forEach var="row" items="${dailyTrend}">
                            <c:set var="pct" value="${maxCount > 0 ? (row.clickCount * 100 / maxCount) : 0}"/>
                            <div style="flex:0 0 32px;display:flex;flex-direction:column;align-items:center;gap:4px;" title="${row.clickDate}: ${row.clickCount}">
                                <div style="font-size:10px;color:#64748b;">${row.clickCount}</div>
                                <div style="width:22px;height:${pct}%;min-height:2px;background:linear-gradient(180deg,#60a5fa,#2563eb);border-radius:3px 3px 0 0;"></div>
                                <div style="font-size:9px;color:#94a3b8;font-family:monospace;transform:rotate(-45deg);transform-origin:center;white-space:nowrap;margin-top:6px;">
                                    ${fn:substring(row.clickDate, 5, 10)}
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- 상위 URL 랭킹 --%>
        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <div style="padding:14px 16px;border-bottom:1px solid #e5e7eb;font-size:13px;font-weight:700;color:#1e293b;">
                🔝 상위 클릭 URL (최대 20개)
            </div>
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th style="width:48px;">순위</th>
                        <th>URL</th>
                        <th style="width:120px;text-align:right;">클릭 수</th>
                        <th style="width:240px;">분포</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty topUrls}">
                            <tr><td colspan="4" style="text-align:center;padding:40px;color:#94a3b8;">데이터가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:set var="rankTopCount" value="${topUrls[0].clickCount}"/>
                            <c:forEach var="row" items="${topUrls}" varStatus="st">
                                <c:set var="pct" value="${rankTopCount > 0 ? (row.clickCount * 100 / rankTopCount) : 0}"/>
                                <tr>
                                    <td><strong>${st.index + 1}</strong></td>
                                    <td style="font-family:monospace;font-size:12px;word-break:break-all;">
                                        <a href="${pageContext.request.contextPath}${row.url}" target="_blank" style="color:#1d4ed8;text-decoration:none;">${row.url}</a>
                                    </td>
                                    <td style="text-align:right;font-weight:600;">${row.clickCount}</td>
                                    <td>
                                        <div style="width:100%;height:8px;background:#e5e7eb;border-radius:4px;overflow:hidden;">
                                            <div style="width:${pct}%;height:100%;background:linear-gradient(90deg,#60a5fa,#2563eb);"></div>
                                        </div>
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
         부적절 메시지 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'inappropriate'}">
        <div class="adm-card" style="padding:0;overflow-x:auto;">
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
                                    <td>${fn:replace(fn:substring(m.createdAt, 0, 16), 'T', ' ')}</td>
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

        <div class="adm-card" style="padding:0;overflow-x:auto;">
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
                                    <td>${fn:replace(fn:substring(b.blockedAt, 0, 16), 'T', ' ')}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.expiresAt != null}">${fn:replace(fn:substring(b.expiresAt, 0, 16), 'T', ' ')}</c:when>
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

        <div class="adm-card" style="padding:0;overflow-x:auto;">
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
                            <td><input type="number" class="adm-input q-conv" value="${q.maxConversations}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                            <td><input type="number" class="adm-input q-msg" value="${q.maxMessagesPerDay}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                            <td><input type="number" class="adm-input q-ctx" value="${q.maxContextMessages}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
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
                const body = m.role === 'assistant'
                    ? renderAssistantContent(m.content)
                    : '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + escHtml(m.content || '') + '</div>';
                return '<div style="margin-bottom:12px;padding:10px;border-left:3px solid ' + color + ';background:#f8fafc;">' +
                       '<div style="font-size:11px;color:' + color + ';font-weight:600;">' + role + flag + '</div>' +
                       body +
                       '</div>';
            }).join('');
            document.getElementById('msgModalBody').innerHTML = html || '<div>메시지가 없습니다.</div>';
            document.getElementById('msgModal').style.display = 'flex';
        } catch (e) { alert('조회 중 오류'); }
    };

    // assistant 메시지 content 렌더링
    //   - JSON 파싱 성공: message 텍스트 + links + quickReplies + inappropriate 를 블록으로 분리 표시
    //   - 파싱 실패 (구버전 단순 텍스트): 원문 그대로
    function renderAssistantContent(raw) {
        if (raw == null) return '';
        let parsed = null;
        try {
            const maybe = JSON.parse(raw);
            if (maybe && typeof maybe === 'object' && typeof maybe.message === 'string') parsed = maybe;
        } catch (e) {}

        if (!parsed) {
            return '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + escHtml(raw) + '</div>';
        }

        let out = '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + escHtml(parsed.message) + '</div>';

        if (parsed.inappropriate === true) {
            out += '<div style="margin-top:6px;display:inline-block;font-size:11px;font-weight:700;color:#b91c1c;background:#fee2e2;border:1px solid #fecaca;padding:2px 8px;border-radius:10px;">⚠️ inappropriate</div>';
        }

        if (Array.isArray(parsed.links) && parsed.links.length > 0) {
            out += '<div style="margin-top:8px;font-size:11px;color:#64748b;font-weight:600;">🔗 제시된 링크</div>';
            out += '<div style="margin-top:4px;display:flex;flex-direction:column;gap:3px;">';
            parsed.links.forEach(function (l) {
                const label = escHtml(l.label || '');
                const url = escHtml(l.url || '');
                const icon = escHtml(l.icon || '→');
                out += '<div style="font-size:12px;">' +
                       '<span style="margin-right:4px;">' + icon + '</span>' +
                       '<span style="color:#1e293b;font-weight:500;">' + label + '</span>' +
                       '<span style="margin-left:6px;color:#94a3b8;font-family:monospace;font-size:11px;">' + url + '</span>' +
                       '</div>';
            });
            out += '</div>';
        }

        if (Array.isArray(parsed.quickReplies) && parsed.quickReplies.length > 0) {
            out += '<div style="margin-top:8px;font-size:11px;color:#64748b;font-weight:600;">💬 빠른 답변</div>';
            out += '<div style="margin-top:4px;display:flex;flex-wrap:wrap;gap:4px;">';
            parsed.quickReplies.forEach(function (q) {
                out += '<span style="font-size:11px;background:#eff6ff;color:#1d4ed8;border:1px solid #dbeafe;padding:2px 8px;border-radius:10px;">' +
                       escHtml(q) + '</span>';
            });
            out += '</div>';
        }

        return out;
    }

    function escHtml(s) {
        return String(s == null ? '' : s)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;');
    }

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
