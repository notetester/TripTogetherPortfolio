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
                                    <td style="text-align:right;font-weight:600;">
                                        <button type="button" class="adm-btn adm-btn-ghost" style="font-size:12px;padding:3px 10px;"
                                                data-url="${row.url}" onclick="viewClickersByUrl(this.dataset.url)">
                                            ${row.clickCount}
                                        </button>
                                    </td>
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
                        <th>작성자</th>
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
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty m.authorUserIdx}">
                                                <a href="javascript:void(0);"
                                                   onclick="openDetail('${m.authorUserIdx}'); return false;"
                                                   style="color:#1d4ed8;text-decoration:none;font-weight:500;cursor:pointer;"
                                                   title="회원 상세 보기">
                                                    <c:choose>
                                                        <c:when test="${not empty m.authorNickname}">${m.authorNickname}</c:when>
                                                        <c:otherwise>#${m.authorUserIdx}</c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </c:when>
                                            <c:otherwise><span style="color:#94a3b8;">게스트</span></c:otherwise>
                                        </c:choose>
                                    </td>
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
        <style>
            tr[data-quota-id].is-dirty td:first-child { box-shadow: inset 3px 0 0 0 #2563eb; }
            tr[data-quota-id].is-dirty td { background: rgba(37, 99, 235, .04); }
        </style>
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
                        <th>주기당 메시지 한도</th>
                        <th>AI 컨텍스트 길이</th>
                        <th title="리셋 주기">주기(일)</th>
                        <th title="주기 시작(리셋) 시각 HH:MM">리셋 시각</th>
                        <th title="대화 삭제 시 그 대화에서 쓴 현재 주기 내 메시지 수만큼 한도 환급">환급 허용</th>
                        <th>마지막 수정자</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="q" items="${quotas}">
                        <tr data-quota-id="${q.quotaId}">
                            <td><strong>${q.grade}</strong></td>
                            <td><input type="number" class="adm-input q-conv" value="${q.maxConversations}" data-original="${q.maxConversations}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                            <td><input type="number" class="adm-input q-msg" value="${q.maxMessagesPerPeriod}" data-original="${q.maxMessagesPerPeriod}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                            <td><input type="number" class="adm-input q-ctx" value="${q.maxContextMessages}" data-original="${q.maxContextMessages}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
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
                                        <a class="quota-updater"
                                           href="javascript:void(0);"
                                           onclick="openDetail('${q.updatedBy}'); return false;"
                                           style="color:#1d4ed8;text-decoration:none;font-weight:500;cursor:pointer;"
                                           title="회원 상세 보기">
                                            <c:choose>
                                                <c:when test="${not empty q.updaterNickname}">${q.updaterNickname}</c:when>
                                                <c:otherwise>#${q.updatedBy}</c:otherwise>
                                            </c:choose>
                                        </a>
                                    </c:when>
                                    <c:otherwise><span style="color:#94a3b8;">-</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <%-- 전체 저장 / 기본값 복원 (원본으로 되돌리기) --%>
        <div style="margin-top:16px;display:flex;justify-content:flex-end;gap:8px;align-items:center;">
            <span id="quotaDirtyHint" style="font-size:12px;color:#64748b;"></span>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="resetQuotasToOriginal()"
                    title="불러온 DB 값으로 모두 되돌립니다">기본값 복원</button>
            <button type="button" class="adm-btn adm-btn-primary" onclick="saveAllQuotas()">전체 저장</button>
        </div>
    </c:if>

</div>

<%-- URL 별 클릭자 목록 모달 --%>
<div id="clickersModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:9999;align-items:center;justify-content:center;">
    <div style="background:#fff;width:780px;max-width:92vw;max-height:82vh;border-radius:12px;overflow:hidden;display:flex;flex-direction:column;">
        <div style="padding:16px;border-bottom:1px solid #e5e7eb;display:flex;justify-content:space-between;align-items:center;gap:12px;">
            <h3 id="clickersModalTitle" style="margin:0;font-size:15px;flex:1;word-break:break-all;">URL 클릭자 목록</h3>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="document.getElementById('clickersModal').style.display='none'">닫기</button>
        </div>
        <div id="clickersModalBody" style="padding:16px;overflow-y:auto;flex:1;"></div>
    </div>
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

            // messageId → [click, ...] 매핑
            const clicksByMsg = {};
            (data.linkClicks || []).forEach(function (c) {
                const key = String(c.messageId);
                if (!clicksByMsg[key]) clicksByMsg[key] = [];
                clicksByMsg[key].push(c);
            });
            const totalClicks = (data.linkClicks || []).length;

            const msgHtml = (data.messages || []).map(function (m) {
                const role = m.role === 'user' ? '유저' : 'AI';
                const color = m.role === 'user' ? '#1d4ed8' : '#0f766e';
                const flag = m.isInappropriate ? ' ⚠️' : '';
                const body = m.role === 'assistant'
                    ? renderAssistantContent(m.content)
                    : '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + escHtml(m.content || '') + '</div>';
                const clicks = m.role === 'assistant' ? (clicksByMsg[String(m.messageId)] || []) : [];
                const badge = clicks.length > 0
                    ? '<span style="margin-left:6px;display:inline-block;font-size:10px;font-weight:700;color:#1d4ed8;background:#dbeafe;padding:1px 7px;border-radius:10px;">👆 ' + clicks.length + '</span>'
                    : '';
                let perMsgDetail = '';
                if (clicks.length > 0) {
                    perMsgDetail = '<div style="margin-top:8px;padding:6px 8px;background:#eff6ff;border-radius:6px;">' +
                                   '<div style="font-size:10px;color:#1d4ed8;font-weight:700;margin-bottom:4px;">이 메시지의 클릭 이력</div>';
                    clicks.forEach(function (c) {
                        perMsgDetail += '<div style="font-size:11px;color:#334155;">• ' +
                                        escHtml(c.label || '-') +
                                        ' <span style="color:#64748b;font-family:monospace;">' + escHtml(c.url || '') + '</span>' +
                                        ' <span style="color:#94a3b8;">(' + escHtml(formatClickTime(c.clickedAt)) + ')</span>' +
                                        '</div>';
                    });
                    perMsgDetail += '</div>';
                }
                return '<div style="margin-bottom:12px;padding:10px;border-left:3px solid ' + color + ';background:#f8fafc;">' +
                       '<div style="font-size:11px;color:' + color + ';font-weight:600;">' + role + flag + badge + '</div>' +
                       body +
                       perMsgDetail +
                       '</div>';
            }).join('');

            const summary = '<div style="margin-bottom:12px;font-size:12px;color:#64748b;">' +
                            '총 메시지 <strong style="color:#1e293b;">' + (data.messages || []).length + '</strong>건 · ' +
                            '링크 클릭 <strong style="color:#1d4ed8;">' + totalClicks + '</strong>건' +
                            '</div>';

            document.getElementById('msgModalBody').innerHTML = summary + (msgHtml || '<div>메시지가 없습니다.</div>');
            document.getElementById('msgModal').style.display = 'flex';
        } catch (e) { alert('조회 중 오류'); }
    };

    function formatClickTime(s) {
        if (!s) return '';
        const str = String(s);
        return str.length >= 16 ? str.substring(0, 16).replace('T', ' ') : str;
    }

    // URL 별 클릭자 목록 모달
    window.viewClickersByUrl = async function (url) {
        try {
            const res = await fetch(ctx + '/admin/ai-helper/chatbot/clicks/by-url?url=' + encodeURIComponent(url));
            const data = await res.json();
            if (!data.success) { alert('조회 실패'); return; }
            document.getElementById('clickersModalTitle').textContent = 'URL 클릭자 — ' + url;
            const rows = (data.clickers || []);
            if (rows.length === 0) {
                document.getElementById('clickersModalBody').innerHTML =
                    '<div style="padding:40px;text-align:center;color:#94a3b8;">클릭 이력이 없습니다.</div>';
            } else {
                let html = '<table class="adm-table" style="width:100%;font-size:12px;">' +
                           '<thead><tr>' +
                           '<th>시각</th><th>유저</th><th>세션</th><th>IP</th><th>대화</th><th>메시지</th>' +
                           '</tr></thead><tbody>';
                rows.forEach(function (r) {
                    const userText = r.userIdx
                        ? (escHtml(r.nickname || '') + ' <span style="color:#94a3b8;font-size:10px;">#' + r.userIdx + '</span>')
                        : '<span style="color:#94a3b8;">게스트</span>';
                    const anon = r.anonSessionId ? ('<span style="color:#64748b;font-family:monospace;font-size:10px;">' + escHtml(String(r.anonSessionId).substring(0, 12)) + '…</span>') : '-';
                    html += '<tr>' +
                            '<td style="white-space:nowrap;">' + escHtml(formatClickTime(r.clickedAt)) + '</td>' +
                            '<td>' + userText + '</td>' +
                            '<td>' + anon + '</td>' +
                            '<td style="font-family:monospace;">' + escHtml(r.ipAddress || '-') + '</td>' +
                            '<td>#' + escHtml(r.conversationId) + '</td>' +
                            '<td>#' + escHtml(r.messageId) + '</td>' +
                            '</tr>';
                });
                html += '</tbody></table>';
                html = '<div style="font-size:12px;color:#64748b;margin-bottom:10px;">총 <strong style="color:#1d4ed8;">' + rows.length + '</strong>건 (최대 100)</div>' + html;
                document.getElementById('clickersModalBody').innerHTML = html;
            }
            document.getElementById('clickersModal').style.display = 'flex';
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

    // 행별 dirty 여부 계산 (input + select 모두)
    function isRowDirty(row) {
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

    function updateDirtyHint() {
        const hint = document.getElementById('quotaDirtyHint');
        if (!hint) return;
        const dirtyRows = document.querySelectorAll('tr[data-quota-id]');
        let count = 0;
        dirtyRows.forEach(function (row) {
            if (isRowDirty(row)) {
                row.classList.add('is-dirty');
                count++;
            } else {
                row.classList.remove('is-dirty');
            }
        });
        hint.textContent = count > 0 ? ('변경된 행 ' + count + '개') : '';
    }

    // 입력 변경 감지 바인딩 (input + select)
    document.querySelectorAll('tr[data-quota-id] input[data-original], tr[data-quota-id] select[data-original]').forEach(function (el) {
        el.addEventListener('input', updateDirtyHint);
        el.addEventListener('change', updateDirtyHint);
    });

    // 기본값 복원 — 모든 필드를 최초 로드 값으로 되돌림
    window.resetQuotasToOriginal = function () {
        let reverted = 0;
        document.querySelectorAll('tr[data-quota-id] input[data-original], tr[data-quota-id] select[data-original]').forEach(function (el) {
            if (el.type === 'checkbox') {
                const target = el.dataset.original === 'true';
                if (el.checked !== target) { el.checked = target; reverted++; }
            } else {
                if (String(el.value) !== String(el.dataset.original)) { el.value = el.dataset.original; reverted++; }
            }
        });
        updateDirtyHint();
        if (reverted === 0) alert('되돌릴 변경 사항이 없습니다.');
    };

    // 전체 저장 — 변경된 행만 순차 저장
    window.saveAllQuotas = async function () {
        const rows = Array.from(document.querySelectorAll('tr[data-quota-id]'));
        const dirtyRows = rows.filter(isRowDirty);
        if (dirtyRows.length === 0) {
            alert('변경 사항이 없습니다.');
            return;
        }
        const tasks = dirtyRows.map(function (row) {
            const quotaId = row.dataset.quotaId;
            const payload = {
                maxConversations:     parseInt(row.querySelector('.q-conv').value, 10),
                maxMessagesPerPeriod: parseInt(row.querySelector('.q-msg').value, 10),
                maxContextMessages:   parseInt(row.querySelector('.q-ctx').value, 10),
                periodDays:           parseInt(row.querySelector('.q-period').value, 10),
                resetHour:            parseInt(row.querySelector('.q-reset-h').value, 10),
                resetMinute:          parseInt(row.querySelector('.q-reset-m').value, 10),
                quotaRefundEnabled:   row.querySelector('.q-refund').checked
            };
            return fetch(ctx + '/admin/ai-helper/quotas/' + quotaId, {
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

<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="modalTitle"><spring:message code="admin.context.memberTitle"/></div>
            <button class="adm-modal-close" onclick="closeDetail()">✕</button>
        </div>
        <div class="adm-modal-body" id="modalBody">
            <div style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.loading"/></div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeDetail()"><spring:message code="admin.common.close"/></button>
        </div>
    </div>
</div>


<div class="adm-modal-overlay" id="blockModal">
    <div class="adm-modal" style="max-width:520px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockModalTitle"><spring:message code="admin.members.blockModalTitle"/></div>
            <button class="adm-modal-close" onclick="closeBlockModal()">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="blockUserIdx">
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label"><spring:message code="admin.context.action.blockType"/></label>
                <select id="blockType" class="adm-select" style="width:100%;" onchange="handleBlockTypeChange()">
                    <option value="USER_ONLY"><spring:message code="admin.context.blockType.userOnly"/></option>
                    <option value="IP_ONLY"><spring:message code="admin.context.blockType.ipOnly"/></option>
                    <option value="USER_IP"><spring:message code="admin.context.blockType.userIp"/></option>
                </select>
            </div>
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label"><spring:message code="admin.members.blockedIpLabel"/></label>
                <input id="blockedIp" class="adm-input" type="text" placeholder="<spring:message code='admin.context.action.blockIpPlaceholder'/>">
            </div>
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label"><spring:message code="admin.members.blockExpiresLabel"/></label>
                <input id="blockedUntil" class="adm-input" type="datetime-local">
            </div>
            <div class="form-group">
                <label class="form-label"><spring:message code="admin.members.blockReasonLabel"/></label>
                <textarea id="blockedReason" class="adm-input" style="min-height:90px;resize:vertical;" placeholder="<spring:message code='admin.context.action.reasonPlaceholder'/>"></textarea>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeBlockModal()"><spring:message code="admin.common.close"/></button>
            <button id="blockSubmitBtn" class="adm-btn adm-btn-primary" type="button" onclick="submitBlock()"><spring:message code="admin.context.action.applyBlock"/></button>
        </div>
    </div>
</div>

<script>
const ctx = '${pageContext.request.contextPath}';
const ADMIN_MEMBER_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const ADMIN_MEMBER_MSG = {
    loading: '<spring:message code="admin.common.loading" javaScriptEscape="true"/>',
    close: '<spring:message code="admin.common.close" javaScriptEscape="true"/>',
    error: '<spring:message code="admin.common.error" javaScriptEscape="true"/>',
    yes: '<spring:message code="admin.common.yes" javaScriptEscape="true"/>',
    no: '<spring:message code="admin.common.no" javaScriptEscape="true"/>',
    none: '<spring:message code="admin.members.none" javaScriptEscape="true"/>',
    noLinkedProvider: '<spring:message code="admin.members.noLinkedProvider" javaScriptEscape="true"/>',
    verifiedMember: '<spring:message code="admin.members.verifiedMember" javaScriptEscape="true"/>',
    unverifiedMember: '<spring:message code="admin.members.unverifiedMember" javaScriptEscape="true"/>',
    statusActive: '<spring:message code="admin.status.ACTIVE" javaScriptEscape="true"/>',
    statusDormant: '<spring:message code="admin.status.DORMANT" javaScriptEscape="true"/>',
    statusBlocked: '<spring:message code="admin.status.BLOCKED" javaScriptEscape="true"/>',
    statusDeleted: '<spring:message code="admin.status.DELETED" javaScriptEscape="true"/>',
    blockModalTitleSuffix: '<spring:message code="admin.members.blockModalTitleSuffix" javaScriptEscape="true"/>',
    parsingBlockResponse: '<spring:message code="admin.members.blockResponseParseError" javaScriptEscape="true"/>',
    parsingStatusResponse: '<spring:message code="admin.members.statusResponseParseError" javaScriptEscape="true"/>',
    parsingRoleResponse: '<spring:message code="admin.members.roleResponseParseError" javaScriptEscape="true"/>',
    missingBlockTarget: '<spring:message code="admin.members.blockTargetMissing" javaScriptEscape="true"/>',
    applying: '<spring:message code="admin.common.applying" javaScriptEscape="true"/>',
    blockApplied: '<spring:message code="admin.context.toast.saveBlockSuccess" javaScriptEscape="true"/>',
    memberDetailsTitle: '<spring:message code="admin.context.memberTitle" javaScriptEscape="true"/>',
    memberDetailsSuffix: '<spring:message code="admin.members.detailTitleSuffix" javaScriptEscape="true"/>',
    infoTab: '<spring:message code="admin.context.tab.info" javaScriptEscape="true"/>',
    loginTab: '<spring:message code="admin.context.tab.logins" javaScriptEscape="true"/>',
    securityTab: '<spring:message code="admin.context.tab.security" javaScriptEscape="true"/>',
    emailHistoryTab: '<spring:message code="admin.members.emailHistoryTab" javaScriptEscape="true"/>',
    activityTab: '<spring:message code="admin.context.tab.activity" javaScriptEscape="true"/>',
    blockTab: '<spring:message code="admin.context.tab.blocks" javaScriptEscape="true"/>',
    actionsTab: '<spring:message code="admin.context.tab.actions" javaScriptEscape="true"/>'
};

function escapeHtml(value) {
    if (value == null) return '';
    return String(value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

function formatNullable(value) {
    return value ? escapeHtml(value) : '<span style="color:#475569">—</span>';
}

function formatDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString(ADMIN_MEMBER_LOCALE || undefined, {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatHistoryDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString(ADMIN_MEMBER_LOCALE || undefined, {
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatBooleanBadge(value) {
    return value
        ? '<span style="color:#4ade80">✓ ' + escapeHtml(ADMIN_MEMBER_MSG.yes) + '</span>'
        : '<span style="color:#475569">✗ ' + escapeHtml(ADMIN_MEMBER_MSG.no) + '</span>';
}

function buildStatusBadge(status) {
    const safe = escapeHtml(status || '');
    return '<span class="status-badge ' + safe + '">' + (safe || '—') + '</span>';
}

function buildRoleBadge(role) {
    const safe = escapeHtml(role || '');
    return '<span class="role-badge ' + safe + '">' + roleLabel(safe) + '</span>';
}

function roleLabel(role) {
    const labels = {
        USER: '<spring:message code="admin.role.USER" javaScriptEscape="true"/>',
        BUSINESS: '<spring:message code="admin.role.BUSINESS" javaScriptEscape="true"/>',
        PARTNER: '<spring:message code="admin.role.PARTNER" javaScriptEscape="true"/>',
        BOT: '<spring:message code="admin.role.BOT" javaScriptEscape="true"/>',
        ADMIN: '<spring:message code="admin.role.ADMIN" javaScriptEscape="true"/>',
        SUPERADMIN: '<spring:message code="admin.role.SUPERADMIN" javaScriptEscape="true"/>',
        SYSTEM: '<spring:message code="admin.role.SYSTEM" javaScriptEscape="true"/>'
    };
    return labels[role] || role || '—';
}

function buildSocialHtml(linkedProviders) {
    if (!linkedProviders) {
        return '<span class="adm-social-empty">' + escapeHtml(ADMIN_MEMBER_MSG.noLinkedProvider) + '</span>';
    }

    const providerMap = {
        KAKAO: {
            label: '<spring:message code="admin.social.kakao" javaScriptEscape="true"/>',
            className: 'kakao',
            icon: '<span class="adm-social-icon kakao-mark">k</span>'
        },
        NAVER: {
            label: '<spring:message code="admin.social.naver" javaScriptEscape="true"/>',
            className: 'naver',
            icon: '<span class="adm-social-icon naver-mark">N</span>'
        },
        GOOGLE: {
            label: '<spring:message code="admin.social.google" javaScriptEscape="true"/>',
            className: 'google',
            icon: '<span class="adm-social-icon google-mark"><svg viewBox="0 0 48 48" aria-hidden="true" focusable="false"><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/><path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/></svg></span>'
        }
    };

    const items = linkedProviders
        .split(',')
        .map(provider => provider.trim())
        .filter(provider => provider.length > 0)
        .map(function(provider) {
            const info = providerMap[provider];
            if (!info) {
                return '<span class="adm-social-pill"><span class="adm-social-label">' + escapeHtml(provider) + '</span></span>';
            }
            return '<span class="adm-social-pill ' + info.className + '">' + info.icon + '<span class="adm-social-label">' + escapeHtml(info.label) + '</span></span>';
        });

    if (!items.length) {
        return '<span class="adm-social-empty">' + escapeHtml(ADMIN_MEMBER_MSG.noLinkedProvider) + '</span>';
    }

    return '<div class="adm-social-list">' + items.join('') + '</div>';
}

/* ── 페이지 이동 ── */
function goPage(p) {
    const form = document.getElementById('searchForm');
    form.querySelector('[name=page]').value = p;
    form.submit();
}

function changeSize(size) {
    const form = document.getElementById('searchForm');
    form.querySelector('[name=size]').value = size;
    form.querySelector('[name=page]').value = 1;
    form.submit();
}

/* ── 액션 메뉴 토글 ── */
function toggleMenu(btn) {
    const menu = btn.nextElementSibling;
    document.querySelectorAll('.action-menu.open').forEach(m => {
        if (m !== menu) m.classList.remove('open');
    });
    menu.classList.toggle('open');
}

function openBlockModal(triggerOrUserIdx, nickname) {
    const trigger = typeof triggerOrUserIdx === 'object' ? triggerOrUserIdx : null;
    const userIdx = trigger ? trigger.dataset.userIdx : triggerOrUserIdx;
    const resolvedNickname = trigger ? (trigger.dataset.nickname || '') : (nickname || '');

    document.getElementById('blockUserIdx').value = userIdx;
    document.getElementById('blockModalTitle').textContent = (resolvedNickname || '') + ' ' + ADMIN_MEMBER_MSG.blockModalTitleSuffix;
    document.getElementById('blockType').value = 'USER_ONLY';
    document.getElementById('blockedIp').value = '';
    document.getElementById('blockedIp').disabled = true;
    document.getElementById('blockedUntil').value = '';
    document.getElementById('blockedReason').value = '';
    document.getElementById('blockSubmitBtn').disabled = false;

    const menu = trigger ? trigger.closest('.action-menu') : null;
    if (menu) menu.classList.remove('open');

    document.getElementById('blockModal').classList.add('open');
}

function closeBlockModal() {
    document.getElementById('blockModal').classList.remove('open');
}

function handleBlockTypeChange() {
    const blockType = document.getElementById('blockType').value;
    const ipInput = document.getElementById('blockedIp');
    const requiresIp = blockType === 'IP_ONLY' || blockType === 'USER_IP';

    ipInput.disabled = !requiresIp;
    if (!requiresIp) ipInput.value = '';
}

async function submitBlock() {
    const submitBtn = document.getElementById('blockSubmitBtn');
    const userIdx = document.getElementById('blockUserIdx').value;
    const blockType = document.getElementById('blockType').value;
    const blockedIp = document.getElementById('blockedIp').value.trim();
    const blockedUntil = document.getElementById('blockedUntil').value;
    const reason = document.getElementById('blockedReason').value.trim();

    if (!userIdx) {
        adm_toast(ADMIN_MEMBER_MSG.missingBlockTarget, 'error');
        return;
    }
    if ((blockType === 'IP_ONLY' || blockType === 'USER_IP') && !blockedIp) {
        adm_toast('<spring:message code="admin.context.requireBlockedIp" javaScriptEscape="true"/>', 'error');
        document.getElementById('blockedIp').focus();
        return;
    }

    submitBtn.disabled = true;
    const originalText = submitBtn.textContent;
    submitBtn.textContent = ADMIN_MEMBER_MSG.applying;

    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/block', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ blockType, blockedIp, expiresAt: blockedUntil, reason })
        });

        let data = null;
        const contentType = res.headers.get('content-type') || '';
        if (contentType.includes('application/json')) {
            data = await res.json();
        } else {
            const text = await res.text();
            throw new Error(text || ADMIN_MEMBER_MSG.parsingBlockResponse);
        }

        if (res.ok && data && data.success) {
            closeBlockModal();
            adm_toast(ADMIN_MEMBER_MSG.blockApplied || '<spring:message code="admin.context.toast.saveBlockSuccess" javaScriptEscape="true"/>');
            setTimeout(() => location.reload(), 800);
        } else {
            adm_toast((data && data.message) || '<spring:message code="admin.context.toast.saveBlockFail" javaScriptEscape="true"/>', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast(e.message || '<spring:message code="admin.context.toast.saveBlockError" javaScriptEscape="true"/>', 'error');
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = originalText;
    }
}

/* ── 상태 변경 ── */
async function changeStatus(userIdx, status, el) {
    const labels = {
        ACTIVE: ADMIN_MEMBER_MSG.statusActive,
        DORMANT: ADMIN_MEMBER_MSG.statusDormant,
        BLOCKED: ADMIN_MEMBER_MSG.statusBlocked,
        DELETED: ADMIN_MEMBER_MSG.statusDeleted
    };
    if (!confirm('<spring:message code="admin.members.confirmStatusChangePrefix" javaScriptEscape="true"/>' + ' "' + (labels[status] || status) + '" ' + '<spring:message code="admin.members.confirmStatusChangeSuffix" javaScriptEscape="true"/>')) return;

    const menu = el.closest('.action-menu');
    if (menu) menu.classList.remove('open');

    const res = await fetch(ctx + '/admin/members/' + userIdx + '/status', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ status })
    });

    let data;
    try {
        data = await res.json();
    } catch (e) {
        adm_toast(ADMIN_MEMBER_MSG.parsingStatusResponse, 'error');
        return;
    }

    if (res.ok && data.success) {
        adm_toast(data.message || '<spring:message code="admin.context.toast.saveStatusSuccess" javaScriptEscape="true"/>');
        setTimeout(() => location.reload(), 800);
    } else {
        adm_toast(data.message || '<spring:message code="admin.context.toast.saveStatusFail" javaScriptEscape="true"/>', 'error');
    }
}

/* ── 권한 변경 ── */
function changeRoleFromMenu(button) {
    const box = button.closest('.role-change-box');
    if (!box) return;

    const select = box.querySelector('.role-change-select');
    const reasonInput = box.querySelector('.role-change-reason');
    const userIdx = button.dataset.userIdx;
    const role = select ? select.value : '';
    const currentRole = select ? select.dataset.currentRole : '';
    const reason = reasonInput ? reasonInput.value.trim() : '';

    if (!role || !userIdx) {
        adm_toast('<spring:message code="admin.members.roleContextMissing" javaScriptEscape="true"/>', 'error');
        return;
    }
    if (role === currentRole) {
        adm_toast('<spring:message code="admin.members.roleAlreadySelected" javaScriptEscape="true"/>', 'error');
        return;
    }
    if (!reason) {
        adm_toast('<spring:message code="admin.context.requireRoleReason" javaScriptEscape="true"/>', 'error');
        if (reasonInput) reasonInput.focus();
        return;
    }

    changeRole(userIdx, role, reason, button);
}

async function changeRole(userIdx, role, reason, el) {
    if (!confirm('"' + roleLabel(role) + '" ' + '<spring:message code="admin.members.confirmRoleChangeSuffix" javaScriptEscape="true"/>')) return;

    const menu = el.closest('.action-menu');
    if (menu) menu.classList.remove('open');

    const res = await fetch(ctx + '/admin/members/' + userIdx + '/role', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ role, reason })
    });

    let data;
    try {
        data = await res.json();
    } catch (e) {
        adm_toast(ADMIN_MEMBER_MSG.parsingRoleResponse, 'error');
        return;
    }

    if (res.ok && data.success) {
        adm_toast(data.message || '<spring:message code="admin.context.toast.saveRoleSuccess" javaScriptEscape="true"/>');
        setTimeout(() => location.reload(), 800);
    } else {
        adm_toast(data.message || '<spring:message code="admin.context.toast.saveRoleFail" javaScriptEscape="true"/>', 'error');
    }
}

function buildContextRows(items, renderer, emptyMessage) {
    if (!Array.isArray(items) || !items.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;">' + emptyMessage + '</div>';
    }
    return '<div style="display:flex;flex-direction:column;gap:10px;">' + items.map(renderer).join('') + '</div>';
}

function buildSecurityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.eventType || '-') + '</strong> / ' + escapeHtml(item.eventStage || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.occurredAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;"><spring:message code="admin.context.inputValue" javaScriptEscape="true"/>: ' + escapeHtml(item.inputIdentifier || '-') + '</div>'
            + '<div style="margin-top:4px;font-size:12px;color:#94a3b8;"><spring:message code="admin.context.targetEmail" javaScriptEscape="true"/>: ' + escapeHtml(item.targetEmail || '-') + '</div>'
            + '</div>';
    }, '<spring:message code="admin.context.empty.security" javaScriptEscape="true"/>');
}

function buildEmailRequestRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.status || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.requestedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;"><spring:message code="admin.context.requestEmail" javaScriptEscape="true"/>: ' + escapeHtml(item.pendingEmail || '-') + '</div>'
            + '</div>';
    }, '<spring:message code="admin.context.empty.emailRequests" javaScriptEscape="true"/>');
}

function buildEmailTokenRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.used ? '<spring:message code="admin.context.used" javaScriptEscape="true"/>' : '<spring:message code="admin.context.unused" javaScriptEscape="true"/>') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.createdAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;"><spring:message code="admin.context.targetEmail" javaScriptEscape="true"/>: ' + escapeHtml(item.email || '-') + '</div>'
            + '</div>';
    }, '<spring:message code="admin.context.empty.emailTokens" javaScriptEscape="true"/>');
}

function buildActivityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.activityCode || '-') + '</strong> / ' + escapeHtml(item.activityDomain || item.activityType || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.createdAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;"><spring:message code="admin.context.uri" javaScriptEscape="true"/>: ' + escapeHtml(item.requestUri || '-') + '</div>'
            + '</div>';
    }, '<spring:message code="admin.context.empty.activity" javaScriptEscape="true"/>');
}

function buildBlockRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.blockType || '-') + '</strong> / ' + escapeHtml(item.active ? 'ACTIVE' : 'INACTIVE') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.blockedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;"><spring:message code="admin.common.reason" javaScriptEscape="true"/>: ' + escapeHtml(item.reason || '-') + '</div>'
            + '<div style="margin-top:4px;font-size:12px;color:#94a3b8;">IP: ' + escapeHtml(item.blockedIp || '-') + '</div>'
            + '</div>';
    }, '<spring:message code="admin.context.empty.blocks" javaScriptEscape="true"/>');
}

function buildChatbotLinkClickRows(items) {
    return buildContextRows(items, function(item) {
        const url = item.url || '';
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div style="font-size:13px;"><strong>' + escapeHtml(item.label || '-') + '</strong></div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.clickedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;"><a href="' + ctx + escapeHtml(url) + '" target="_blank" style="color:#60a5fa;font-family:monospace;text-decoration:none;">' + escapeHtml(url) + '</a></div>'
            + '<div style="margin-top:4px;font-size:11px;color:#94a3b8;">'
            + 'conv #' + escapeHtml(item.conversationId || '-')
            + ' · msg #' + escapeHtml(item.messageId || '-')
            + ' · IP: ' + escapeHtml(item.ipAddress || '-')
            + '</div>'
            + '</div>';
    }, '기록된 챗봇 링크 클릭이 없습니다.');
}

function buildActionTab(m) {
    return ''
        + '<div class="adm-context-actions-grid">'
        + '<div class="adm-context-panel">'
        + '<div style="font-weight:700;margin-bottom:10px;">' + '<spring:message code="admin.context.action.profileTitle" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.context.nickname" javaScriptEscape="true"/>' + '</div><input id="memberProfileNickname" class="adm-input" type="text" value="' + escapeHtml(m.nickname || '') + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.nationality" javaScriptEscape="true"/>' + '</div><input id="memberProfileNationality" class="adm-input" type="text" value="' + escapeHtml(m.nationality || '') + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.preferredLanguage" javaScriptEscape="true"/>' + '</div><input id="memberProfileLang" class="adm-input" type="text" value="' + escapeHtml(m.preferredLang || '') + '">'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="saveMemberProfile(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.context.action.saveProfile" javaScriptEscape="true"/>' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel">'
        + '<div style="font-weight:700;margin-bottom:10px;">' + '<spring:message code="admin.context.action.statusRoleTitle" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.members.accountStatus" javaScriptEscape="true"/>' + '</div>'
        + '<div style="display:flex;gap:8px;"><select id="memberStatusSelect" class="adm-select" style="width:100%;"><option value="ACTIVE"><spring:message code="admin.status.ACTIVE" javaScriptEscape="true"/></option><option value="DORMANT"><spring:message code="admin.status.DORMANT" javaScriptEscape="true"/></option><option value="BLOCKED"><spring:message code="admin.status.BLOCKED" javaScriptEscape="true"/></option><option value="DELETED"><spring:message code="admin.status.DELETED" javaScriptEscape="true"/></option></select><button type="button" class="adm-btn adm-btn-ghost" onclick="applyStatusFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.common.apply" javaScriptEscape="true"/>' + '</button></div>'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.common.role" javaScriptEscape="true"/>' + '</div>'
        + '<select id="memberRoleSelect" class="adm-select" style="width:100%;"><option value="USER"><spring:message code="admin.role.USER" javaScriptEscape="true"/></option><option value="BUSINESS"><spring:message code="admin.role.BUSINESS" javaScriptEscape="true"/></option><option value="PARTNER"><spring:message code="admin.role.PARTNER" javaScriptEscape="true"/></option><option value="BOT"><spring:message code="admin.role.BOT" javaScriptEscape="true"/></option><option value="ADMIN"><spring:message code="admin.role.ADMIN" javaScriptEscape="true"/></option></select>'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.action.roleReason" javaScriptEscape="true"/>' + '</div>'
        + '<input id="memberRoleReason" class="adm-input" type="text" maxlength="500" placeholder="' + '<spring:message code="admin.context.action.roleReasonPlaceholder" javaScriptEscape="true"/>' + '">'
        + '<button type="button" class="adm-btn adm-btn-ghost" style="margin-top:12px;" onclick="applyRoleFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.context.action.changeRole" javaScriptEscape="true"/>' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel">'
        + '<div style="font-weight:700;margin-bottom:10px;">' + '<spring:message code="admin.context.action.quickBlockTitle" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.context.action.blockType" javaScriptEscape="true"/>' + '</div><select id="detailBlockType" class="adm-select" style="width:100%;"><option value="USER_ONLY">' + '<spring:message code="admin.context.blockType.userOnly" javaScriptEscape="true"/>' + '</option><option value="IP_ONLY">' + '<spring:message code="admin.context.blockType.ipOnly" javaScriptEscape="true"/>' + '</option><option value="USER_IP">' + '<spring:message code="admin.context.blockType.userIp" javaScriptEscape="true"/>' + '</option></select>'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.blockedIp" javaScriptEscape="true"/>' + '</div><input id="detailBlockedIp" class="adm-input" type="text" placeholder="' + '<spring:message code="admin.context.action.blockIpPlaceholder" javaScriptEscape="true"/>' + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.action.blockExpires" javaScriptEscape="true"/>' + '</div><input id="detailBlockedUntil" class="adm-input" type="datetime-local">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.common.reason" javaScriptEscape="true"/>' + '</div><textarea id="detailBlockedReason" class="adm-input" style="min-height:88px;resize:vertical;"></textarea>'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="submitDetailBlock(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.context.action.applyBlock" javaScriptEscape="true"/>' + '</button>'
        + '</div>'
        + '</div>';
}

/* ── 회원 상세 모달 ── */
async function openDetail(userIdx, defaultTab) {
    document.getElementById('detailModal').classList.add('open');
    document.getElementById('modalBody').innerHTML =
        '<div style="text-align:center;padding:40px;color:#475569;">' + escapeHtml(ADMIN_MEMBER_MSG.loading) + ' ⏳</div>';

    let data;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx);
        data = await res.json();
    } catch (error) {
        document.getElementById('modalBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(ADMIN_MEMBER_MSG.fetchError) + '</div>';
        return;
    }

    if (!data.success) {
        document.getElementById('modalBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(data.message || ADMIN_MEMBER_MSG.error) + '</div>';
        return;
    }

    const m = data.member || {};
    const h = Array.isArray(data.history) ? data.history : [];
    const securityAudits = Array.isArray(data.securityAudits) ? data.securityAudits : [];
    const emailRequests = Array.isArray(data.emailRequests) ? data.emailRequests : [];
    const emailTokens = Array.isArray(data.emailTokens) ? data.emailTokens : [];
    const activityLogs = Array.isArray(data.activityLogs) ? data.activityLogs : [];
    const recentBlocks = Array.isArray(data.recentBlocks) ? data.recentBlocks : [];
    const chatbotLinkClicks = Array.isArray(data.chatbotLinkClicks) ? data.chatbotLinkClicks : [];
    const activeTab = ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'chatbot', 'actions'].includes(defaultTab) ? defaultTab : 'info';

    document.getElementById('modalTitle').textContent = (m.nickname || ADMIN_MEMBER_MSG.memberDetailsTitle) + ' ' + ADMIN_MEMBER_MSG.memberDetailsSuffix;

    document.getElementById('modalBody').innerHTML = ''
        + '<div class="adm-tabs">'
        + '<button class="adm-tab ' + (activeTab === 'info' ? 'active' : '') + '" onclick="switchTab(\'info\', this)">' + ADMIN_MEMBER_MSG.infoTab + '</button>'
        + '<button class="adm-tab ' + (activeTab === 'hist' ? 'active' : '') + '" onclick="switchTab(\'hist\', this)">' + ADMIN_MEMBER_MSG.loginTab + ' (' + h.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'security' ? 'active' : '') + '" onclick="switchTab(\'security\', this)">' + ADMIN_MEMBER_MSG.securityTab + ' (' + securityAudits.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'emails' ? 'active' : '') + '" onclick="switchTab(\'emails\', this)">' + ADMIN_MEMBER_MSG.emailHistoryTab + '</button>'
        + '<button class="adm-tab ' + (activeTab === 'activity' ? 'active' : '') + '" onclick="switchTab(\'activity\', this)">' + ADMIN_MEMBER_MSG.activityTab + ' (' + activityLogs.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'blocks' ? 'active' : '') + '" onclick="switchTab(\'blocks\', this)">' + ADMIN_MEMBER_MSG.blockTab + ' (' + recentBlocks.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'chatbot' ? 'active' : '') + '" onclick="switchTab(\'chatbot\', this)">챗봇 링크 (' + chatbotLinkClicks.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'actions' ? 'active' : '') + '" onclick="switchTab(\'actions\', this)">' + ADMIN_MEMBER_MSG.actionsTab + '</button>'
        + '</div>'
        + '<div id="tab-info" style="display:' + (activeTab === 'info' ? '' : 'none') + ';"></div>'
        + '<div id="tab-hist" style="display:' + (activeTab === 'hist' ? '' : 'none') + ';"></div>'
        + '<div id="tab-security" style="display:' + (activeTab === 'security' ? '' : 'none') + ';"></div>'
        + '<div id="tab-emails" style="display:' + (activeTab === 'emails' ? '' : 'none') + ';"></div>'
        + '<div id="tab-activity" style="display:' + (activeTab === 'activity' ? '' : 'none') + ';"></div>'
        + '<div id="tab-blocks" style="display:' + (activeTab === 'blocks' ? '' : 'none') + ';"></div>'
        + '<div id="tab-chatbot" style="display:' + (activeTab === 'chatbot' ? '' : 'none') + ';"></div>'
        + '<div id="tab-actions" style="display:' + (activeTab === 'actions' ? '' : 'none') + ';"></div>';

    document.getElementById('tab-info').innerHTML = buildInfoTab(m);
    document.getElementById('tab-hist').innerHTML = buildHistTab(h);
    document.getElementById('tab-security').innerHTML = buildSecurityRows(securityAudits);
    document.getElementById('tab-emails').innerHTML = ''
        + '<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:16px;">'
        + '<div><div style="font-weight:700;margin-bottom:10px;">' + '<spring:message code="admin.context.tab.emailRequests" javaScriptEscape="true"/>' + '</div>' + buildEmailRequestRows(emailRequests) + '</div>'
        + '<div><div style="font-weight:700;margin-bottom:10px;">' + '<spring:message code="admin.context.tab.emailTokens" javaScriptEscape="true"/>' + '</div>' + buildEmailTokenRows(emailTokens) + '</div>'
        + '</div>';
    document.getElementById('tab-activity').innerHTML = buildActivityRows(activityLogs);
    document.getElementById('tab-blocks').innerHTML = buildBlockRows(recentBlocks);
    document.getElementById('tab-chatbot').innerHTML = buildChatbotLinkClickRows(chatbotLinkClicks);
    document.getElementById('tab-actions').innerHTML = buildActionTab(m);
    const statusSelect = document.getElementById('memberStatusSelect');
    const roleSelect = document.getElementById('memberRoleSelect');
    if (statusSelect) statusSelect.value = m.accountStatus || 'ACTIVE';
    if (roleSelect) roleSelect.value = m.userRole || 'USER';
}

function buildInfoTab(m) {
    const statusBadge = buildStatusBadge(m.accountStatus);
    const roleBadge = buildRoleBadge(m.userRole);
    const socialHtml = buildSocialHtml(m.linkedProviders);
    const lastLoginText = formatDateTime(m.lastLoginAt);

    return ''
        + '<div class="detail-grid">'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.memberNo" javaScriptEscape="true"/>' + '</div><div class="detail-value">#' + escapeHtml(m.userIdx) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.userId" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatNullable(m.userId) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.nickname" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatNullable(m.nickname) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.email" javaScriptEscape="true"/>' + '</div><div class="detail-value" style="font-size:12px;">' + formatNullable(m.userEmail) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.members.accountStatus" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + statusBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.common.role" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + roleBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.nationality" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatNullable(m.nationality) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.preferredLanguage" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatNullable(m.preferredLang) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.members.emailVerified" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatBooleanBadge(m.emailVerified) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.members.emailLoginEnabled" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatBooleanBadge(m.emailLoginEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.members.passwordLoginEnabled" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatBooleanBadge(m.passwordEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.createdAt" javaScriptEscape="true"/>' + '</div><div class="detail-value" style="font-size:12px;">' + formatDateTime(m.createdAt) + '</div></div>'
        + '</div>'
        + '<div class="detail-item" style="margin-top:12px;">'
        + '<div class="detail-label">' + '<spring:message code="admin.members.socialLinked" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-value" style="margin-top:4px;">' + socialHtml + '</div>'
        + '</div>'
        + '<div style="margin-top:12px;display:flex;gap:8px;flex-wrap:wrap;">'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '<spring:message code="admin.members.loginSuccess" javaScriptEscape="true"/>' + '</div>'
        + '<div style="font-size:20px;font-weight:700;color:#4ade80;margin-top:4px;">' + escapeHtml(m.loginSuccessCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '<spring:message code="admin.members.loginFailure" javaScriptEscape="true"/>' + '</div>'
        + '<div style="font-size:20px;font-weight:700;color:#f87171;margin-top:4px;">' + escapeHtml(m.loginFailCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:120px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '<spring:message code="admin.context.lastLogin" javaScriptEscape="true"/>' + '</div>'
        + '<div style="font-size:12px;font-weight:600;color:#94a3b8;margin-top:4px;">' + escapeHtml(lastLoginText) + '</div>'
        + '</div>'
        + '</div>';
}

function buildHistTab(history) {
    if (!history.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;">' + '<spring:message code="admin.context.empty.logins" javaScriptEscape="true"/>' + '</div>';
    }

    const methodMap = {
        ID: '<spring:message code="admin.context.userId" javaScriptEscape="true"/>',
        EMAIL: '<spring:message code="admin.context.email" javaScriptEscape="true"/>',
        KAKAO: '<spring:message code="admin.social.kakao" javaScriptEscape="true"/>',
        NAVER: '<spring:message code="admin.social.naver" javaScriptEscape="true"/>',
        GOOGLE: '<spring:message code="admin.social.google" javaScriptEscape="true"/>'
    };

    let rows = '';
    history.forEach(function(item) {
        const ok = !!item.success;
        rows += ''
            + '<tr>'
            + '<td>' + escapeHtml(formatHistoryDateTime(item.loginAt)) + '</td>'
            + '<td>' + escapeHtml(methodMap[item.loginMethod] || item.loginMethod || '—') + '</td>'
            + '<td class="' + (ok ? 'h-success' : 'h-fail') + '">' + (ok ? '✅ ' + '<spring:message code="admin.logs.success" javaScriptEscape="true"/>' : '❌ ' + '<spring:message code="admin.logs.failure" javaScriptEscape="true"/>') + '</td>'
            + '<td>' + escapeHtml(item.failReason || '—') + '</td>'
            + '<td style="font-size:11px;color:#475569;">' + escapeHtml(item.ipAddress || '—') + '</td>'
            + '</tr>';
    });

    return ''
        + '<div style="overflow-x:auto;max-height:340px;overflow-y:auto;">'
        + '<table class="history-table">'
        + '<thead><tr><th>' + '<spring:message code="admin.common.time" javaScriptEscape="true"/>' + '</th><th>' + '<spring:message code="admin.logs.provider" javaScriptEscape="true"/>' + '</th><th>' + '<spring:message code="admin.logs.success" javaScriptEscape="true"/>' + '</th><th>' + '<spring:message code="admin.logs.failReason" javaScriptEscape="true"/>' + '</th><th><spring:message code="admin.common.ip" javaScriptEscape="true"/></th></tr></thead>'
        + '<tbody>' + rows + '</tbody>'
        + '</table>'
        + '</div>';
}

function switchTab(tab, btn) {
    document.querySelectorAll('#detailModal .adm-tab').forEach(t => t.classList.remove('active'));
    btn.classList.add('active');
    ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'actions'].forEach(function(name) {
        const el = document.getElementById('tab-' + name);
        if (el) el.style.display = tab === name ? '' : 'none';
    });
}

async function saveMemberProfile(userIdx, button) {
    const nickname = document.getElementById('memberProfileNickname').value.trim();
    const nationality = document.getElementById('memberProfileNationality').value.trim();
    const preferredLang = document.getElementById('memberProfileLang').value.trim();

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/profile', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ nickname, nationality, preferredLang })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || '<spring:message code="admin.context.toast.saveProfileSuccess" javaScriptEscape="true"/>');
            setTimeout(() => location.reload(), 700);
        } else {
            adm_toast(data.message || '<spring:message code="admin.context.toast.saveProfileFail" javaScriptEscape="true"/>', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('<spring:message code="admin.context.toast.saveProfileError" javaScriptEscape="true"/>', 'error');
    } finally {
        button.disabled = false;
    }
}

function applyStatusFromDetail(userIdx, button) {
    const status = document.getElementById('memberStatusSelect').value;
    changeStatus(userIdx, status, button);
}

function applyRoleFromDetail(userIdx, button) {
    const role = document.getElementById('memberRoleSelect').value;
    const reason = document.getElementById('memberRoleReason').value.trim();
    if (!reason) {
        adm_toast('<spring:message code="admin.context.requireRoleReason" javaScriptEscape="true"/>', 'error');
        return;
    }
    changeRole(userIdx, role, reason, button);
}

async function submitDetailBlock(userIdx, button) {
    const blockType = document.getElementById('detailBlockType').value;
    const blockedIp = document.getElementById('detailBlockedIp').value.trim();
    const expiresAt = document.getElementById('detailBlockedUntil').value;
    const reason = document.getElementById('detailBlockedReason').value.trim();

    if ((blockType === 'IP_ONLY' || blockType === 'USER_IP') && !blockedIp) {
        adm_toast('<spring:message code="admin.context.requireBlockedIp" javaScriptEscape="true"/>', 'error');
        return;
    }

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/block', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ blockType, blockedIp, expiresAt, reason })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || '<spring:message code="admin.context.toast.saveBlockSuccess" javaScriptEscape="true"/>');
            setTimeout(() => location.reload(), 700);
        } else {
            adm_toast(data.message || '<spring:message code="admin.context.toast.saveBlockFail" javaScriptEscape="true"/>', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('<spring:message code="admin.context.toast.saveBlockError" javaScriptEscape="true"/>', 'error');
    } finally {
        button.disabled = false;
    }
}

function closeDetail() {
    document.getElementById('detailModal').classList.remove('open');
    // 외부에서 ?detailUserIdx=N 으로 들어와 자동 오픈된 경우, 닫힘 후 파라미터 제거 (리프레시 재오픈 방지)
    try {
        const url = new URL(window.location.href);
        if (url.searchParams.has('detailUserIdx')) {
            url.searchParams.delete('detailUserIdx');
            window.history.replaceState(null, '', url.toString());
        }
    } catch (e) {}
}

document.getElementById('detailModal').addEventListener('click', function (e) {
    if (e.target === this) closeDetail();
});

document.getElementById('blockModal').addEventListener('click', function (e) {
    if (e.target === this) closeBlockModal();
});
</script>

<%@ include file="../layout-close.jsp" %>
