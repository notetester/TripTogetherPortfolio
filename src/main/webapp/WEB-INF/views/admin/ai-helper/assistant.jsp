<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="aiHelper"/>
<c:set var="pageTitle" value="AI 도우미 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 도우미 내부 sub-tab ── --%>
    <div class="aih-tabs" style="display:flex;gap:4px;border-bottom:1px solid #e5e7eb;margin:20px 0;">
        <c:set var="tabs" value="dashboard,messages,inappropriate,blocks,quotas"/>
        <c:set var="labels" value="대시보드,메시지,부적절 메시지,차단 관리,한도 정책"/>
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

        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>세션 ID</th>
                        <th>제목</th>
                        <th>유저</th>
                        <th>메시지 수</th>
                        <th>생성일</th>
                        <th>마지막 활동</th>
                        <th style="width:130px;">
                            <div style="display:flex;gap:4px;justify-content:flex-end;">
                                <span style="font-size:11px;padding:3px 8px;">액션</span>
                                <span style="font-size:11px;padding:3px 8px;visibility:hidden;">삭제</span>
                            </div>
                        </th>
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
                                    <td style="text-align:right;">
                                        <div style="display:flex;gap:4px;flex-wrap:wrap;justify-content:flex-end;">
                                            <button type="button" class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;" data-session-id="${s.chatPostIdx}" onclick="viewAssistantMessages(this.dataset.sessionId)">보기</button>
                                            <button type="button" class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;color:#ef4444;" data-session-id="${s.chatPostIdx}" onclick="deleteAssistantSession(this.dataset.sessionId)">삭제</button>
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
                전체 메시지를 최신순으로 표시합니다. 특정 세션의 대화 맥락을 이어서 보려면 "세션 보기"를 클릭하세요.
            </div>
            <div style="font-size:12px;color:#64748b;margin-top:8px;">총 ${total}건</div>
        </div>

        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>세션</th>
                        <th>역할</th>
                        <th>유저</th>
                        <th>내용</th>
                        <th>시각</th>
                        <th style="width:100px;">
                            <div style="display:flex;gap:4px;justify-content:flex-end;">
                                <span style="font-size:11px;padding:3px 8px;">액션</span>
                            </div>
                        </th>
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
                                    <td style="max-width:500px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:12px;">
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
                                    <td style="text-align:right;">
                                        <div style="display:flex;gap:4px;justify-content:flex-end;">
                                            <button type="button" class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;" data-session-id="${m.chatPostIdx}" onclick="viewAssistantMessages(this.dataset.sessionId)">세션 보기</button>
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

    <%-- ══════════════════════════════════════════
         부적절 메시지 탭
         스케줄러가 5분 주기로 Perspective API 호출하여 저장한 결과를 표시
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'inappropriate'}">
        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>판정 ID</th>
                        <th>세션</th>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>점수</th>
                        <th>판정시각</th>
                        <th style="width:100px;">
                            <div style="display:flex;gap:4px;justify-content:flex-end;">
                                <span style="font-size:11px;padding:3px 8px;">액션</span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty messages}">
                            <tr><td colspan="7" style="text-align:center;padding:40px;color:#94a3b8;">부적절 판정된 메시지가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${messages}">
                                <tr>
                                    <td>${m.moderationId}</td>
                                    <td>#${m.chatPostIdx}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.nickname != null}">${m.nickname} <span style="color:#94a3b8;">(#${m.userIdx})</span></c:when>
                                            <c:otherwise><span style="color:#94a3b8;">#${m.userIdx}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="max-width:500px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-size:12px;">
                                        <c:choose>
                                            <c:when test="${fn:length(m.content) > 200}">${fn:escapeXml(fn:substring(m.content, 0, 200))}…</c:when>
                                            <c:otherwise>${fn:escapeXml(m.content)}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${m.toxicityScore != null}">
                                                <span style="color:#dc2626;font-weight:600;">${m.toxicityScore}</span>
                                            </c:when>
                                            <c:otherwise><span style="color:#94a3b8;">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatDate value="${m.checkedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td style="text-align:right;">
                                        <div style="display:flex;gap:4px;justify-content:flex-end;">
                                            <button type="button" class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;" data-session-id="${m.chatPostIdx}" onclick="viewAssistantMessages(this.dataset.sessionId)">세션 보기</button>
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
                    <a href="${pageContext.request.contextPath}/admin/ai-helper?tab=inappropriate&page=${p}"
                       class="adm-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}" style="min-width:32px;">${p}</a>
                </c:forEach>
            </div>
        </c:if>
    </c:if>

    <%-- ══════════════════════════════════════════
         차단 관리 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'blocks'}">
        <%-- 차단 등록 폼 --%>
        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <div style="font-size:14px;font-weight:700;margin-bottom:10px;">차단 등록</div>
            <div style="display:flex;gap:8px;flex-wrap:wrap;align-items:flex-end;">
                <div>
                    <label style="font-size:11px;color:#64748b;display:block;">유형</label>
                    <select id="blkType" class="adm-input" style="width:90px;">
                        <option value="USER">USER</option>
                        <option value="IP">IP</option>
                    </select>
                </div>
                <div style="flex:1;min-width:160px;">
                    <label style="font-size:11px;color:#64748b;display:block;">값 (user_idx 또는 IP)</label>
                    <input type="text" id="blkValue" class="adm-input" placeholder="예: 6 / 192.168.0.1">
                </div>
                <div style="flex:2;min-width:200px;">
                    <label style="font-size:11px;color:#64748b;display:block;">사유</label>
                    <input type="text" id="blkReason" class="adm-input" placeholder="선택">
                </div>
                <div>
                    <label style="font-size:11px;color:#64748b;display:block;">만료(선택, YYYY-MM-DD HH:mm)</label>
                    <input type="text" id="blkExpires" class="adm-input" placeholder="비우면 영구" style="width:180px;">
                </div>
                <button type="button" class="adm-btn adm-btn-primary" onclick="createAssistantBlock()">등록</button>
            </div>
        </div>

        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>유형</th>
                        <th>값</th>
                        <th>대상 닉네임</th>
                        <th>사유</th>
                        <th>차단일</th>
                        <th>만료</th>
                        <th>상태</th>
                        <th>처리자</th>
                        <th style="width:80px;">
                            <div style="display:flex;gap:4px;justify-content:flex-end;">
                                <span style="font-size:11px;padding:3px 8px;">액션</span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty blocks}">
                            <tr><td colspan="10" style="text-align:center;padding:40px;color:#94a3b8;">차단 기록이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${blocks}">
                                <tr>
                                    <td>${b.blockId}</td>
                                    <td>
                                        <span style="padding:2px 8px;border-radius:4px;background:${b.blockType == 'USER' ? '#dbeafe' : '#fee2e2'};color:${b.blockType == 'USER' ? '#1d4ed8' : '#b91c1c'};font-size:11px;font-weight:600;">${b.blockType}</span>
                                    </td>
                                    <td>${b.blockValue}</td>
                                    <td><c:if test="${b.targetNickname != null}">${b.targetNickname}</c:if></td>
                                    <td style="max-width:260px;word-break:break-all;font-size:12px;">${fn:escapeXml(b.reason)}</td>
                                    <td><fmt:formatDate value="${b.blockedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.expiresAt != null}"><fmt:formatDate value="${b.expiresAt}" pattern="yyyy-MM-dd HH:mm"/></c:when>
                                            <c:otherwise><span style="color:#94a3b8;">영구</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.isActive}"><span style="color:#16a34a;font-weight:600;">활성</span></c:when>
                                            <c:otherwise><span style="color:#94a3b8;">해제</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><c:if test="${b.blockedByNickname != null}">${b.blockedByNickname}</c:if></td>
                                    <td style="text-align:right;">
                                        <c:if test="${b.isActive}">
                                            <button type="button" class="adm-btn adm-btn-ghost" style="font-size:11px;padding:3px 8px;color:#ef4444;" data-block-id="${b.blockId}" onclick="deactivateAssistantBlock(this.dataset.blockId)">해제</button>
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
         한도 정책 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'quotas'}">
        <style>
            tr[data-quota-id].is-dirty td:first-child { box-shadow: inset 3px 0 0 0 #2563eb; }
            tr[data-quota-id].is-dirty td { background: rgba(37, 99, 235, .04); }
        </style>
        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <div style="font-size:13px;color:#475569;line-height:1.6;">
                등급별 AI 도우미 이용 한도를 설정합니다. GUEST는 비로그인 유저용이며 가장 제한적입니다.<br>
                ADMIN/SUPERADMIN은 한도 체크에서 자동 제외됩니다.
            </div>
        </div>

        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>등급</th>
                        <th title="해당 유저의 CHAT_POST(세션) 총 보유 수 한도">세션 수</th>
                        <th>주기당 메시지 한도</th>
                        <th title="리셋 주기">주기(일)</th>
                        <th title="주기 시작(리셋) 시각 HH:MM">리셋 시각</th>
                        <th title="세션 삭제 시 그 세션의 현재 주기 내 유저 메시지 수만큼 한도 환급">환급 허용</th>
                        <th>마지막 수정자</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty quotas}">
                            <tr><td colspan="7" style="text-align:center;padding:40px;color:#94a3b8;">등급이 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="q" items="${quotas}">
                                <tr data-quota-id="${q.quotaId}" data-grade="${q.grade}">
                                    <td><strong>${q.grade}</strong></td>
                                    <td><input type="number" class="adm-input q-sessions" value="${q.maxSessions}" data-original="${q.maxSessions}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                                    <td><input type="number" class="adm-input q-msg" value="${q.maxMessagesPerPeriod}" data-original="${q.maxMessagesPerPeriod}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                                    <td>
                                        <select class="adm-input q-period" data-original="${q.periodDays}" style="width:72px;padding:6px 10px;font-size:13px;">
                                            <c:forEach var="d" items="1,2,3,4,5,7,14,30">
                                                <option value="${d}" ${q.periodDays == d ? 'selected' : ''}>${d}일</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td>
                                        <select class="adm-input q-reset-h" data-original="${q.resetHour}" style="width:64px;padding:6px 8px;font-size:13px;">
                                            <c:forEach var="h" begin="0" end="23">
                                                <option value="${h}" ${q.resetHour == h ? 'selected' : ''}>
                                                    <fmt:formatNumber value="${h}" minIntegerDigits="2"/>
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <span style="padding:0 2px;">:</span>
                                        <select class="adm-input q-reset-m" data-original="${q.resetMinute}" style="width:64px;padding:6px 8px;font-size:13px;">
                                            <c:forEach var="m" begin="0" end="59">
                                                <option value="${m}" ${q.resetMinute == m ? 'selected' : ''}>
                                                    <fmt:formatNumber value="${m}" minIntegerDigits="2"/>
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td style="text-align:center;">
                                        <input type="checkbox" class="q-refund" ${q.quotaRefundEnabled ? 'checked' : ''} data-original="${q.quotaRefundEnabled ? 'true' : 'false'}" style="width:18px;height:18px;cursor:pointer;"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty q.updatedBy}">
                                                <span style="color:#1d4ed8;font-weight:500;">
                                                    <c:choose>
                                                        <c:when test="${not empty q.updaterNickname}">${q.updaterNickname}</c:when>
                                                        <c:otherwise>#${q.updatedBy}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </c:when>
                                            <c:otherwise><span style="color:#94a3b8;">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <%-- 전체 저장 / 기본값 복원 (원본으로 되돌리기) --%>
        <div style="margin-top:16px;display:flex;justify-content:flex-end;gap:8px;align-items:center;">
            <span id="quotaDirtyHint" style="font-size:12px;color:#64748b;"></span>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="resetAssistantQuotasToOriginal()"
                    title="불러온 DB 값으로 모두 되돌립니다">기본값 복원</button>
            <button type="button" class="adm-btn adm-btn-primary" onclick="saveAllAssistantQuotas()">전체 저장</button>
        </div>
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

    // ─── 차단 등록 ───
    window.createAssistantBlock = async function () {
        const blockType  = document.getElementById('blkType').value;
        const blockValue = document.getElementById('blkValue').value.trim();
        const reason     = document.getElementById('blkReason').value.trim();
        const expiresStr = document.getElementById('blkExpires').value.trim();
        if (!blockValue) { alert('값을 입력해주세요.'); return; }
        const body = { blockType: blockType, blockValue: blockValue };
        if (reason) body.reason = reason;
        if (expiresStr) {
            // 입력 포맷 "YYYY-MM-DD HH:mm" → ISO "YYYY-MM-DDTHH:mm:00"
            const m = expiresStr.match(/^(\d{4}-\d{2}-\d{2})[ T](\d{2}:\d{2})$/);
            if (!m) { alert('만료 형식은 YYYY-MM-DD HH:mm 입니다.'); return; }
            body.expiresAt = m[1] + 'T' + m[2] + ':00';
        }
        try {
            const res = await fetch(ctx + '/admin/ai-helper/assistant/blocks', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(body)
            });
            const data = await res.json();
            if (data.success) {
                alert('차단 등록 완료');
                location.reload();
            } else {
                alert('등록 실패: ' + (data.message || ''));
            }
        } catch (e) {
            alert('등록 중 오류');
        }
    };

    // ─── 차단 해제 ───
    window.deactivateAssistantBlock = async function (blockId) {
        if (!confirm('차단을 해제합니다. 계속하시겠습니까?')) return;
        try {
            const res = await fetch(ctx + '/admin/ai-helper/assistant/blocks/' + blockId + '/deactivate', {
                method: 'POST'
            });
            const data = await res.json();
            if (data.success) {
                alert('해제 완료');
                location.reload();
            } else {
                alert('해제 실패');
            }
        } catch (e) {
            alert('해제 중 오류');
        }
    };

    // ─── 등급별 한도 — 변경 감지 / 기본값 복원 / 전체 저장 ───
    function isAssistantRowDirty(row) {
        const els = row.querySelectorAll('input[data-original], select[data-original]');
        for (const el of els) {
            if (el.type === 'checkbox') {
                const original = el.dataset.original === 'true';
                if (el.checked !== original) return true;
            } else {
                if (String(el.value) !== String(el.dataset.original)) return true;
            }
        }
        return false;
    }

    function updateAssistantDirtyHint() {
        const hint = document.getElementById('quotaDirtyHint');
        if (!hint) return;
        const rows = document.querySelectorAll('tr[data-quota-id]');
        let count = 0;
        rows.forEach(function (row) {
            if (isAssistantRowDirty(row)) {
                row.classList.add('is-dirty');
                count++;
            } else {
                row.classList.remove('is-dirty');
            }
        });
        hint.textContent = count > 0 ? ('변경된 행 ' + count + '개') : '';
    }

    document.querySelectorAll('tr[data-quota-id] input[data-original], tr[data-quota-id] select[data-original]').forEach(function (el) {
        el.addEventListener('input', updateAssistantDirtyHint);
        el.addEventListener('change', updateAssistantDirtyHint);
    });

    window.resetAssistantQuotasToOriginal = function () {
        let reverted = 0;
        document.querySelectorAll('tr[data-quota-id] input[data-original], tr[data-quota-id] select[data-original]').forEach(function (el) {
            if (el.type === 'checkbox') {
                const target = el.dataset.original === 'true';
                if (el.checked !== target) { el.checked = target; reverted++; }
            } else {
                if (String(el.value) !== String(el.dataset.original)) { el.value = el.dataset.original; reverted++; }
            }
        });
        updateAssistantDirtyHint();
        if (reverted === 0) alert('되돌릴 변경 사항이 없습니다.');
    };

    window.saveAllAssistantQuotas = async function () {
        const rows = Array.from(document.querySelectorAll('tr[data-quota-id]'));
        const dirtyRows = rows.filter(isAssistantRowDirty);
        if (dirtyRows.length === 0) {
            alert('변경 사항이 없습니다.');
            return;
        }
        const tasks = dirtyRows.map(function (row) {
            const quotaId = row.dataset.quotaId;
            const payload = {
                grade:                row.dataset.grade,
                maxSessions:          parseInt(row.querySelector('.q-sessions').value, 10),
                maxMessagesPerPeriod: parseInt(row.querySelector('.q-msg').value, 10),
                periodDays:           parseInt(row.querySelector('.q-period').value, 10),
                resetHour:            parseInt(row.querySelector('.q-reset-h').value, 10),
                resetMinute:          parseInt(row.querySelector('.q-reset-m').value, 10),
                quotaRefundEnabled:   row.querySelector('.q-refund').checked
            };
            return fetch(ctx + '/admin/ai-helper/assistant/quotas/' + quotaId, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            }).then(function (res) { return res.json(); });
        });

        try {
            const results = await Promise.all(tasks);
            const failed = results.filter(function (r) { return !r.success; }).length;
            if (failed === 0) {
                alert('전체 ' + results.length + '건 저장 완료');
                location.reload();
            } else {
                alert('일부 저장 실패 (' + failed + '/' + results.length + '). 새로고침 후 재시도해 주세요.');
            }
        } catch (e) {
            alert('저장 중 오류가 발생했습니다.');
        }
    };
})();
</script>

<%@ include file="../layout-close.jsp" %>
