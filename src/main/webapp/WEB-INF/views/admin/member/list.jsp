<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="members"/>
<spring:message code="admin.members.pageTitle" var="adminMembersPageTitle"/>
<spring:message code="admin.status.ACTIVE" var="memberStatusActive"/>
<spring:message code="admin.status.DORMANT" var="memberStatusDormant"/>
<spring:message code="admin.status.BLOCKED" var="memberStatusBlocked"/>
<spring:message code="admin.status.DELETED" var="memberStatusDeleted"/>
<c:set var="pageTitle"  value="${adminMembersPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ══════════════════════════════════════════
         검색 / 필터 바
    ══════════════════════════════════════════ --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form id="searchForm" method="get" action="${pageContext.request.contextPath}/admin/members">
                <div class="adm-filter-bar">

                    <%-- 키워드 검색 --%>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:100px;">
                                <option value="all"      ${search.searchType=='all'      ? 'selected' : ''}><spring:message code="admin.common.all"/></option>
                                <option value="userId"   ${search.searchType=='userId'   ? 'selected' : ''}><spring:message code="admin.context.userId"/></option>
                                <option value="nickname" ${search.searchType=='nickname' ? 'selected' : ''}><spring:message code="admin.context.nickname"/></option>
                                <option value="email"    ${search.searchType=='email'    ? 'selected' : ''}><spring:message code="admin.context.email"/></option>
                            </select>
                            <div class="adm-search-box" style="flex:1;">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword"
                                       value="${search.keyword}" placeholder="<spring:message code='admin.members.searchPlaceholder'/>">
                            </div>
                        </div>
                    </div>

                    <%-- 상태 필터 --%>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.members.accountStatus"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ? 'selected' : ''}><spring:message code="admin.common.all"/></option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ? 'selected' : ''}><spring:message code="admin.status.ACTIVE"/></option>
                            <option value="DORMANT" ${search.status=='DORMANT' ? 'selected' : ''}><spring:message code="admin.status.DORMANT"/></option>
                            <option value="DELETED" ${search.status=='DELETED' ? 'selected' : ''}><spring:message code="admin.status.DELETED"/></option>
                            <option value="BLOCKED" ${search.status=='BLOCKED' ? 'selected' : ''}><spring:message code="admin.status.BLOCKED"/></option>
                        </select>
                    </div>

                    <%-- 권한 필터 --%>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.common.role"/></div>
                        <select class="adm-select" name="role">
                            <option value="ALL"   ${search.role=='ALL'   ? 'selected' : ''}><spring:message code="admin.common.all"/></option>
                            <option value="USER"  ${search.role=='USER'  ? 'selected' : ''}><spring:message code="admin.role.USER"/></option>
                            <option value="BUSINESS" ${search.role=='BUSINESS' ? 'selected' : ''}><spring:message code="admin.role.BUSINESS"/></option>
                            <option value="PARTNER"  ${search.role=='PARTNER'  ? 'selected' : ''}><spring:message code="admin.role.PARTNER"/></option>
                            <option value="BOT"      ${search.role=='BOT'      ? 'selected' : ''}><spring:message code="admin.role.BOT"/></option>
                            <option value="ADMIN" ${search.role=='ADMIN' ? 'selected' : ''}><spring:message code="admin.role.ADMIN"/></option>
                        </select>
                    </div>

                    <%-- 소셜 필터 --%>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.members.socialLinked"/></div>
                        <select class="adm-select" name="provider">
                            <option value="ALL"    ${search.provider=='ALL'    ? 'selected' : ''}><spring:message code="admin.common.all"/></option>
                            <option value="KAKAO"  ${search.provider=='KAKAO'  ? 'selected' : ''}><spring:message code="admin.social.kakao"/></option>
                            <option value="NAVER"  ${search.provider=='NAVER'  ? 'selected' : ''}><spring:message code="admin.social.naver"/></option>
                            <option value="GOOGLE" ${search.provider=='GOOGLE' ? 'selected' : ''}><spring:message code="admin.social.google"/></option>
                            <option value="NONE"   ${search.provider=='NONE'   ? 'selected' : ''}><spring:message code="admin.members.noLinkedProvider"/></option>
                        </select>
                    </div>

                    <%-- 가입일 범위 --%>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.context.createdAt"/></div>
                        <div style="display:flex;gap:4px;align-items:center;">
                            <input class="adm-input" type="date" name="dateFrom"
                                   value="${search.dateFrom}" style="width:130px;">
                            <span style="color:#475569;font-size:12px;">~</span>
                            <input class="adm-input" type="date" name="dateTo"
                                   value="${search.dateTo}" style="width:130px;">
                        </div>
                    </div>

                    <%-- 버튼 --%>
                    <div style="display:flex;gap:6px;align-items:flex-end;">
                        <button type="submit" class="adm-btn adm-btn-primary">🔍 <spring:message code="admin.common.searchButton"/></button>
                        <a href="${pageContext.request.contextPath}/admin/members"
                           class="adm-btn adm-btn-ghost"><spring:message code="admin.members.reset"/></a>
                    </div>

                    <input type="hidden" name="page" value="1">
                    <input type="hidden" name="size" value="${search.size}">
                    <input type="hidden" id="sortByInput" name="sortBy" value="${search.sortBy}">
                    <input type="hidden" id="sortDirInput" name="sortDir" value="${search.sortDir}">
                </div>
            </form>
        </div>
    </div>

    <%-- ══════════════════════════════════════════
         회원 목록 테이블
    ══════════════════════════════════════════ --%>
    <div class="adm-card" style="overflow:visible;">
        <div class="adm-card-head">
            <div class="adm-card-title">
                👥 <spring:message code="admin.members.listTitle"/>
                <span style="font-size:12px;font-weight:400;color:#475569;">
                    <spring:message code="admin.members.totalMembers" arguments="${total}"/>
                </span>
            </div>
            <div style="display:flex;align-items:center;gap:8px;">
                <%-- 내보내기 --%>
                <select class="adm-select" id="exportFormat" style="width:85px;">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <div style="position:relative;">
                    <button type="button" class="adm-btn adm-btn-ghost" style="font-size:12px;"
                            onclick="document.getElementById('exportDropdown').style.display=document.getElementById('exportDropdown').style.display==='block'?'none':'block'">
                        ⬇ 내보내기 ▾
                    </button>
                    <div id="exportDropdown" style="display:none;position:absolute;right:0;top:calc(100% + 4px);background:#1e2535;border:1px solid #334155;border-radius:6px;z-index:200;min-width:170px;box-shadow:0 4px 12px rgba(0,0,0,.4);">
                        <button type="button" style="display:block;width:100%;text-align:left;padding:9px 14px;background:none;border:none;color:#e2e8f0;cursor:pointer;font-size:13px;border-bottom:1px solid #334155;" onmouseover="this.style.background='#2d3748'" onmouseout="this.style.background='none'" onclick="exportData('all')">📋 전체 내보내기</button>
                        <button type="button" style="display:block;width:100%;text-align:left;padding:9px 14px;background:none;border:none;color:#e2e8f0;cursor:pointer;font-size:13px;border-bottom:1px solid #334155;" onmouseover="this.style.background='#2d3748'" onmouseout="this.style.background='none'" onclick="exportData('search')">🔍 검색결과 내보내기</button>
                        <button type="button" id="exportSelectedBtn" style="display:block;width:100%;text-align:left;padding:9px 14px;background:none;border:none;color:#94a3b8;cursor:pointer;font-size:13px;" disabled onclick="exportData('selected')">☑ 선택 내보내기 (0)</button>
                    </div>
                </div>
                <%-- 페이지 크기 --%>
                <select class="adm-select" style="width:80px;" id="sizeSelect"
                        onchange="changeSize(this.value)">
                    <option value="10"  ${search.size==10  ? 'selected' : ''}>10</option>
                    <option value="20"  ${search.size==20  ? 'selected' : ''}>20</option>
                    <option value="50"  ${search.size==50  ? 'selected' : ''}>50</option>
                    <option value="100" ${search.size==100 ? 'selected' : ''}>100</option>
                </select>
            </div>
        </div>

        <%-- 일괄 처리 바 --%>
        <div id="bulkBar" style="display:none;background:#1a3354;border:1px solid #2d6a9f;border-radius:8px;padding:10px 16px;margin:0 0 12px;align-items:center;gap:12px;flex-wrap:wrap;">
            <span style="color:#93c5fd;font-size:13px;font-weight:600;"><span id="bulkCount">0</span>명 선택됨</span>
            <div style="display:flex;align-items:center;gap:6px;">
                <select class="adm-select" id="bulkStatusSelect" style="width:130px;">
                    <option value="">상태 선택</option>
                    <option value="ACTIVE"><spring:message code="admin.status.ACTIVE"/></option>
                    <option value="DORMANT"><spring:message code="admin.status.DORMANT"/></option>
                    <option value="DELETED"><spring:message code="admin.status.DELETED"/></option>
                </select>
                <button type="button" class="adm-btn adm-btn-primary" style="font-size:12px;" onclick="applyBulkStatus()">적용</button>
            </div>
            <button type="button" class="adm-btn adm-btn-ghost" style="font-size:12px;margin-left:auto;" onclick="clearSelection()">선택 해제</button>
        </div>

        <div class="adm-table-wrap" style="overflow:visible;">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:40px;text-align:center;">
                        <input type="checkbox" id="checkAll" onchange="toggleAll(this)" style="cursor:pointer;">
                    </th>
                    <th data-sort="nickname" onclick="memberSortBy('nickname')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.common.member"/> <span class="sort-ico">▼</span>
                    </th>
                    <th data-sort="email" onclick="memberSortBy('email')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.context.email"/> <span class="sort-ico">▼</span>
                    </th>
                    <th data-sort="status" onclick="memberSortBy('status')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.common.status"/> <span class="sort-ico">▼</span>
                    </th>
                    <th data-sort="role" onclick="memberSortBy('role')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.common.role"/> <span class="sort-ico">▼</span>
                    </th>
                    <th><spring:message code="admin.members.social"/></th>
                    <th data-sort="lastLoginAt" onclick="memberSortBy('lastLoginAt')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.members.login"/> <span class="sort-ico">▼</span>
                    </th>
                    <th data-sort="createdAt" onclick="memberSortBy('createdAt')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.context.createdAt"/> <span class="sort-ico">▼</span>
                    </th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="m">
                    <tr>
                        <%-- 체크박스 --%>
                        <td style="text-align:center;">
                            <input type="checkbox" class="js-row-check" value="${m.userIdx}" onchange="updateBulkBar()" style="cursor:pointer;">
                        </td>
                        <%-- 회원 정보 --%>
                        <td>
                            <div class="mem-id-cell">
                                <div class="mem-av ${m.accountStatus == 'DORMANT' ? 'dormant' : m.accountStatus == 'DELETED' ? 'deleted' : ''}">
                                    ${m.nickname.substring(0,1)}
                                </div>
                                <div>
                                    <div class="mem-name">
                                        <button type="button" class="adm-inline-link" onclick="openDetail(${m.userIdx}, 'info')" style="font-weight:700;color:#93c5fd;">
                                            ${m.nickname}
                                        </button>
                                    </div>
                                    <div style="font-size:10px;color:#94a3b8;margin-top:2px;">${m.memberGrade} · Lv.${m.levelNo}</div>
                                    <div class="mem-uid">
                                        <c:choose>
                                            <c:when test="${not empty m.userId}">
                                                <button type="button" class="adm-inline-link" onclick="openDetail(${m.userIdx}, 'info')" style="color:#94a3b8;">
                                                    @${m.userId}
                                                </button>
                                            </c:when>
                                            <c:otherwise><span style="color:#475569;"><spring:message code="admin.context.socialOnly"/></span></c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </td>

                        <%-- 이메일 --%>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-member-open-detail"
                                    data-user-idx="${m.userIdx}"
                                    data-default-tab="actions"
                                    data-focus-section="email">
                                <c:choose>
                                    <c:when test="${not empty m.userEmail}">
                                        <span style="font-size:12px;">${m.userEmail}</span>
                                        <c:if test="${m.emailVerified}">
                                            <span style="color:#4ade80;font-size:10px;">✓ <spring:message code="admin.members.emailVerified"/></span>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise><span style="color:#475569;font-size:12px;">—</span></c:otherwise>
                                </c:choose>
                                <span class="adm-cell-link-note">
                                    <c:choose>
                                        <c:when test="${m.verifiedMember}"><spring:message code="admin.members.verifiedMember"/></c:when>
                                        <c:otherwise><spring:message code="admin.members.unverifiedMember"/></c:otherwise>
                                    </c:choose>
                                </span>
                            </button>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <button type="button"
                                    class="adm-inline-link js-member-open-detail"
                                    data-user-idx="${m.userIdx}"
                                    data-default-tab="actions"
                                    data-focus-section="statusRole"
                                    style="padding:0;">
                                <span class="status-badge ${m.accountStatus}">${m.accountStatus}</span>
                            </button>
                        </td>

                        <%-- 권한 --%>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-member-open-detail"
                                    data-user-idx="${m.userIdx}"
                                    data-default-tab="actions"
                                    data-focus-section="statusRole">
                                <span class="role-badge ${m.userRole}">
                                    <c:choose>
                                        <c:when test="${m.userRole eq 'USER'}"><spring:message code="admin.role.USER"/></c:when>
                                        <c:when test="${m.userRole eq 'BUSINESS'}"><spring:message code="admin.role.BUSINESS"/></c:when>
                                        <c:when test="${m.userRole eq 'PARTNER'}"><spring:message code="admin.role.PARTNER"/></c:when>
                                        <c:when test="${m.userRole eq 'BOT'}"><spring:message code="admin.role.BOT"/></c:when>
                                        <c:when test="${m.userRole eq 'ADMIN'}"><spring:message code="admin.role.ADMIN"/></c:when>
                                        <c:when test="${m.userRole eq 'SUPERADMIN'}"><spring:message code="admin.role.SUPERADMIN"/></c:when>
                                        <c:when test="${m.userRole eq 'SYSTEM'}"><spring:message code="admin.role.SYSTEM"/></c:when>
                                        <c:otherwise>${m.userRole}</c:otherwise>
                                    </c:choose>
                                </span>
                                <c:if test="${not empty m.adminPositionCode}">
                                    <span class="adm-cell-link-note">${m.adminPositionCode}</span>
                                </c:if>
                            </button>
                        </td>

                        <%-- 소셜 연동 --%>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-member-open-detail"
                                    data-user-idx="${m.userIdx}"
                                    data-default-tab="info"
                                    data-focus-section="social">
                                <div class="adm-social-list is-compact">
                                    <c:if test="${m.linkedProviders != null && m.linkedProviders.contains('KAKAO')}">
                                        <span class="adm-social-pill kakao" title="<spring:message code='admin.social.kakao'/>">
                                            <span class="adm-social-icon kakao-mark">k</span>
                                            <span class="adm-social-label"><spring:message code="admin.social.kakao"/></span>
                                        </span>
                                    </c:if>
                                    <c:if test="${m.linkedProviders != null && m.linkedProviders.contains('NAVER')}">
                                        <span class="adm-social-pill naver" title="<spring:message code='admin.social.naver'/>">
                                            <span class="adm-social-icon naver-mark">N</span>
                                            <span class="adm-social-label"><spring:message code="admin.social.naver"/></span>
                                        </span>
                                    </c:if>
                                    <c:if test="${m.linkedProviders != null && m.linkedProviders.contains('GOOGLE')}">
                                        <span class="adm-social-pill google" title="<spring:message code='admin.social.google'/>">
                                            <span class="adm-social-icon google-mark">
                                                <svg viewBox="0 0 48 48" aria-hidden="true" focusable="false">
                                                    <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
                                                    <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
                                                    <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
                                                    <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
                                                </svg>
                                            </span>
                                            <span class="adm-social-label"><spring:message code="admin.social.google"/></span>
                                        </span>
                                    </c:if>
                                    <c:if test="${empty m.linkedProviders}">
                                        <span class="adm-social-empty"><spring:message code="admin.members.noLinkedProvider"/></span>
                                    </c:if>
                                </div>
                            </button>
                        </td>

                        <%-- 로그인 이력 --%>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-member-open-detail"
                                    data-user-idx="${m.userIdx}"
                                    data-default-tab="hist"
                                    data-focus-section="loginHistory">
                                <span style="font-size:12px;">
                                    <c:choose>
                                        <c:when test="${m.lastLoginAt != null}">
                                            <fmt:formatDate value="${m.lastLoginAt}" pattern="MM.dd HH:mm"/>
                                        </c:when>
                                        <c:otherwise><span style="color:#475569;"><spring:message code="admin.members.none"/></span></c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">✅${m.loginSuccessCount} / ❌${m.loginFailCount}</span>
                            </button>
                        </td>

                        <%-- 가입일 --%>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-member-open-detail"
                                    data-user-idx="${m.userIdx}"
                                    data-default-tab="info"
                                    data-focus-section="createdMeta"
                                    style="font-size:12px;color:#64748b;">
                                <fmt:formatDate value="${m.createdAt}" pattern="yyyy.MM.dd"/>
                            </button>
                        </td>

                        <%-- 액션 --%>
                        <td>
                            <div class="adm-row-actions">
                                <button class="adm-row-btn detail"
                                        onclick="openDetail(${m.userIdx})"><spring:message code="admin.members.detail"/></button>
                                <c:if test="${m.userRole != 'SYSTEM' and m.userRole != 'SUPERADMIN'}">
                                <div class="action-menu-wrap">
                                    <button class="adm-row-btn detail adm-row-btn-more"
                                            type="button"
                                            onclick="admToggleActionMenu(this)">⋯</button>
                                    <div class="action-menu">
                                        <div class="action-menu-head">
                                            <spring:message code="admin.members.action.changeStatus"/>
                                        </div>
                                        <c:if test="${m.accountStatus != 'ACTIVE'}">
                                            <button class="action-menu-item"
                                                    onclick="changeStatus(${m.userIdx}, 'ACTIVE', this)">
                                                ✅ ${memberStatusActive}
                                            </button>
                                        </c:if>
                                        <c:if test="${m.accountStatus != 'DORMANT'}">
                                            <button class="action-menu-item"
                                                    onclick="changeStatus(${m.userIdx}, 'DORMANT', this)">
                                                😴 ${memberStatusDormant}
                                            </button>
                                        </c:if>
                                        <c:if test="${m.accountStatus != 'BLOCKED'}">
                                            <button class="action-menu-item"
                                                    data-user-idx="${m.userIdx}"
                                                    data-nickname="${fn:escapeXml(m.nickname)}"
                                                    onclick="openBlockModal(this)">
                                                ⛔ ${memberStatusBlocked}
                                            </button>
                                        </c:if>
                                        <c:if test="${m.accountStatus != 'DELETED'}">
                                            <button class="action-menu-item danger"
                                                    onclick="changeStatus(${m.userIdx}, 'DELETED', this)">
                                                🗑️ ${memberStatusDeleted}
                                            </button>
                                        </c:if>
                                        <div class="action-menu-sep"></div>
                                        <div class="action-menu-head">
                                            <spring:message code="admin.members.action.changeRole"/>
                                        </div>
                                        <div class="role-change-box">
                                            <select class="adm-select role-change-select" data-current-role="${m.userRole}">
                                                <option value="USER" ${m.userRole == 'USER' ? 'selected' : ''}><spring:message code="admin.role.USER"/></option>
                                                <option value="BUSINESS" ${m.userRole == 'BUSINESS' ? 'selected' : ''}><spring:message code="admin.role.BUSINESS"/></option>
                                                <option value="PARTNER" ${m.userRole == 'PARTNER' ? 'selected' : ''}><spring:message code="admin.role.PARTNER"/></option>
                                                <option value="BOT" ${m.userRole == 'BOT' ? 'selected' : ''}><spring:message code="admin.role.BOT"/></option>
                                                <option value="ADMIN" ${m.userRole == 'ADMIN' ? 'selected' : ''}><spring:message code="admin.role.ADMIN"/></option>
                                            </select>
                                            <input class="adm-input role-change-reason"
                                                   type="text"
                                                   maxlength="500"
                                                   placeholder="<spring:message code='admin.context.action.roleReasonPlaceholder'/>">
                                            <button class="action-menu-item role-change-submit"
                                                    data-user-idx="${m.userIdx}"
                                                    onclick="changeRoleFromMenu(this)">
                                                <spring:message code="admin.members.action.applyRoleChange"/>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty list}">
                    <tr>
                        <td colspan="9" style="text-align:center;padding:40px;color:#475569;">
                            <spring:message code="admin.common.noResults"/>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <%-- 페이징 --%>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}">
                    <button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button>
                </c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                    <button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}"
                            onclick="goPage(${p})">${p}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button>
                </c:if>
                <span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span>
            </div>
        </c:if>
    </div>
</div>

<%-- ══════════════════════════════════════════
     회원 상세 모달
══════════════════════════════════════════ --%>
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

/* ── 정렬 ── */
function memberSortBy(field) {
    const curField = document.getElementById('sortByInput').value || 'createdAt';
    const curDir   = document.getElementById('sortDirInput').value || 'DESC';
    document.getElementById('sortByInput').value  = field;
    document.getElementById('sortDirInput').value = (field === curField && curDir === 'DESC') ? 'ASC' : 'DESC';
    document.getElementById('searchForm').querySelector('[name=page]').value = 1;
    document.getElementById('searchForm').submit();
}

/* ── 체크박스 ── */
function toggleAll(cb) {
    document.querySelectorAll('.js-row-check').forEach(c => { c.checked = cb.checked; });
    updateBulkBar();
}
function updateBulkBar() {
    const checked = document.querySelectorAll('.js-row-check:checked');
    const n = checked.length;
    document.getElementById('bulkBar').style.display = n > 0 ? 'flex' : 'none';
    document.getElementById('bulkCount').textContent = n;
    const selBtn = document.getElementById('exportSelectedBtn');
    if (selBtn) {
        selBtn.disabled = n === 0;
        selBtn.style.color = n > 0 ? '#e2e8f0' : '#94a3b8';
        selBtn.textContent = '☑ 선택 내보내기 (' + n + ')';
    }
}
function clearSelection() {
    document.querySelectorAll('.js-row-check, #checkAll').forEach(c => { c.checked = false; });
    updateBulkBar();
}

/* ── 일괄 상태 변경 ── */
async function applyBulkStatus() {
    const status = document.getElementById('bulkStatusSelect').value;
    if (!status) { adm_toast('상태를 선택해주세요.', 'error'); return; }
    const ids = Array.from(document.querySelectorAll('.js-row-check:checked')).map(c => c.value);
    if (!ids.length) { adm_toast('선택된 항목이 없습니다.', 'error'); return; }
    if (!confirm(ids.length + '명의 상태를 "' + status + '"(으)로 변경하시겠습니까?')) return;
    const params = new URLSearchParams();
    ids.forEach(id => params.append('userIdxList', id));
    params.append('status', status);
    const res = await fetch(ctx + '/admin/members/bulk/status', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
    });
    const data = await res.json();
    if (res.ok && data.success) { adm_toast(data.message); setTimeout(() => location.reload(), 700); }
    else { adm_toast(data.message || '처리 중 오류가 발생했습니다.', 'error'); }
}

/* ── 내보내기 ── */
function exportData(scope) {
    const format = document.getElementById('exportFormat').value;
    const form   = document.getElementById('searchForm');
    const params = new URLSearchParams();
    new FormData(form).forEach((val, key) => {
        if (key !== 'page' && key !== 'sortBy' && key !== 'sortDir') params.append(key, val);
    });
    params.set('scope', scope);
    params.set('format', format);
    if (scope === 'selected') {
        const ids = Array.from(document.querySelectorAll('.js-row-check:checked')).map(c => c.value);
        if (!ids.length) { adm_toast('선택된 항목이 없습니다.', 'error'); return; }
        params.set('selectedIds', ids.join(','));
    }
    document.getElementById('exportDropdown').style.display = 'none';
    window.location.href = ctx + '/admin/members/export?' + params.toString();
}

/* ── 드롭다운 외부 클릭 닫기 ── */
document.addEventListener('click', function(e) {
    if (!e.target.closest('[onclick*="exportDropdown"]') && !e.target.closest('#exportDropdown')) {
        const dd = document.getElementById('exportDropdown');
        if (dd) dd.style.display = 'none';
    }
});
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
    emailSectionTitle: '<spring:message code="admin.members.action.emailTitle" javaScriptEscape="true"/>',
    emailPlaceholder: '<spring:message code="admin.members.emailPlaceholder" javaScriptEscape="true"/>',
    saveEmail: '<spring:message code="admin.members.action.saveEmail" javaScriptEscape="true"/>',
    emailResetNotice: '<spring:message code="admin.members.emailResetNotice" javaScriptEscape="true"/>',
    emailCellHint: '<spring:message code="admin.members.emailCellHint" javaScriptEscape="true"/>',
    emailUpdated: '<spring:message code="admin.members.emailUpdated" javaScriptEscape="true"/>',
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
        + '<div class="adm-context-panel" id="memberProfilePanel">'
        + '<div class="adm-context-panel-title">' + '<spring:message code="admin.context.action.profileTitle" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.context.nickname" javaScriptEscape="true"/>' + '</div><input id="memberProfileNickname" class="adm-input" type="text" value="' + escapeHtml(m.nickname || '') + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.nationality" javaScriptEscape="true"/>' + '</div><input id="memberProfileNationality" class="adm-input" type="text" value="' + escapeHtml(m.nationality || '') + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.preferredLanguage" javaScriptEscape="true"/>' + '</div><input id="memberProfileLang" class="adm-input" type="text" value="' + escapeHtml(m.preferredLang || '') + '">'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="saveMemberProfile(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.context.action.saveProfile" javaScriptEscape="true"/>' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel" id="memberEmailPanel">'
        + '<div class="adm-context-panel-title">' + ADMIN_MEMBER_MSG.emailSectionTitle + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.context.email" javaScriptEscape="true"/>' + '</div><input id="memberEmailInput" class="adm-input" type="email" placeholder="' + ADMIN_MEMBER_MSG.emailPlaceholder + '" value="' + escapeHtml(m.userEmail || '') + '">'
        + '<div class="adm-cell-link-note" style="margin-top:10px;">' + escapeHtml(ADMIN_MEMBER_MSG.emailResetNotice) + '</div>'
        + '<div style="display:flex;gap:8px;flex-wrap:wrap;margin-top:10px;">'
        + '<span class="status-badge ' + (m.emailVerified ? 'ACTIVE' : 'DORMANT') + '">' + '<spring:message code="admin.members.emailVerified" javaScriptEscape="true"/>' + ': ' + (m.emailVerified ? escapeHtml(ADMIN_MEMBER_MSG.yes) : escapeHtml(ADMIN_MEMBER_MSG.no)) + '</span>'
        + '<span class="status-badge ' + (m.emailLoginEnabled ? 'ACTIVE' : 'DORMANT') + '">' + '<spring:message code="admin.members.emailLoginEnabled" javaScriptEscape="true"/>' + ': ' + (m.emailLoginEnabled ? escapeHtml(ADMIN_MEMBER_MSG.yes) : escapeHtml(ADMIN_MEMBER_MSG.no)) + '</span>'
        + '</div>'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="saveMemberEmail(' + escapeHtml(m.userIdx) + ', this)">' + ADMIN_MEMBER_MSG.saveEmail + '</button>'
        + '</div>'
        + '<div class="adm-context-panel" id="memberStatusRolePanel">'
        + '<div class="adm-context-panel-title">' + '<spring:message code="admin.context.action.statusRoleTitle" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.members.accountStatus" javaScriptEscape="true"/>' + '</div>'
        + '<div style="display:flex;gap:8px;"><select id="memberStatusSelect" class="adm-select" style="width:100%;"><option value="ACTIVE"><spring:message code="admin.status.ACTIVE" javaScriptEscape="true"/></option><option value="DORMANT"><spring:message code="admin.status.DORMANT" javaScriptEscape="true"/></option><option value="BLOCKED"><spring:message code="admin.status.BLOCKED" javaScriptEscape="true"/></option><option value="DELETED"><spring:message code="admin.status.DELETED" javaScriptEscape="true"/></option></select><button type="button" class="adm-btn adm-btn-ghost" onclick="applyStatusFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.common.apply" javaScriptEscape="true"/>' + '</button></div>'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.common.role" javaScriptEscape="true"/>' + '</div>'
        + '<select id="memberRoleSelect" class="adm-select" style="width:100%;"><option value="USER"><spring:message code="admin.role.USER" javaScriptEscape="true"/></option><option value="BUSINESS"><spring:message code="admin.role.BUSINESS" javaScriptEscape="true"/></option><option value="PARTNER"><spring:message code="admin.role.PARTNER" javaScriptEscape="true"/></option><option value="BOT"><spring:message code="admin.role.BOT" javaScriptEscape="true"/></option><option value="ADMIN"><spring:message code="admin.role.ADMIN" javaScriptEscape="true"/></option></select>'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.action.roleReason" javaScriptEscape="true"/>' + '</div>'
        + '<input id="memberRoleReason" class="adm-input" type="text" maxlength="500" placeholder="' + '<spring:message code="admin.context.action.roleReasonPlaceholder" javaScriptEscape="true"/>' + '">'
        + '<button type="button" class="adm-btn adm-btn-ghost" style="margin-top:12px;" onclick="applyRoleFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.context.action.changeRole" javaScriptEscape="true"/>' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel" id="memberQuickBlockPanel">'
        + '<div class="adm-context-panel-title">' + '<spring:message code="admin.context.action.quickBlockTitle" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.context.action.blockType" javaScriptEscape="true"/>' + '</div><select id="detailBlockType" class="adm-select" style="width:100%;"><option value="USER_ONLY">' + '<spring:message code="admin.context.blockType.userOnly" javaScriptEscape="true"/>' + '</option><option value="IP_ONLY">' + '<spring:message code="admin.context.blockType.ipOnly" javaScriptEscape="true"/>' + '</option><option value="USER_IP">' + '<spring:message code="admin.context.blockType.userIp" javaScriptEscape="true"/>' + '</option></select>'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.blockedIp" javaScriptEscape="true"/>' + '</div><input id="detailBlockedIp" class="adm-input" type="text" placeholder="' + '<spring:message code="admin.context.action.blockIpPlaceholder" javaScriptEscape="true"/>' + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.action.blockExpires" javaScriptEscape="true"/>' + '</div><input id="detailBlockedUntil" class="adm-input" type="datetime-local">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.common.reason" javaScriptEscape="true"/>' + '</div><textarea id="detailBlockedReason" class="adm-input" style="min-height:88px;resize:vertical;"></textarea>'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="submitDetailBlock(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.context.action.applyBlock" javaScriptEscape="true"/>' + '</button>'
        + '</div>'
        + '</div>';
}

/* ── 회원 상세 모달 ── */
async function openDetail(userIdx, defaultTab, focusSection) {
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
    if (focusSection) {
        focusMemberSection(activeTab, focusSection);
    }
}

function focusMemberSection(activeTab, focusSection) {
    if (activeTab === 'actions') {
        const panelMap = {
            email: 'memberEmailPanel',
            statusRole: 'memberStatusRolePanel',
            quickBlock: 'memberQuickBlockPanel',
            profile: 'memberProfilePanel'
        };
        const targetId = panelMap[focusSection];
        const panel = targetId ? document.getElementById(targetId) : null;
        if (panel) {
            panel.classList.add('is-focus-flash');
            panel.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            const focusable = panel.querySelector('input, textarea, select, button');
            if (focusable) {
                focusable.focus({ preventScroll: true });
                if (typeof focusable.select === 'function' && focusSection === 'email') {
                    focusable.select();
                }
            }
            setTimeout(() => panel.classList.remove('is-focus-flash'), 1800);
        }
        return;
    }

    if (activeTab === 'hist') {
        const table = document.querySelector('#tab-hist table');
        if (table) table.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
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

async function saveMemberEmail(userIdx, button) {
    const email = document.getElementById('memberEmailInput').value.trim();

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/email', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ email })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || ADMIN_MEMBER_MSG.emailUpdated);
            await openDetail(userIdx, 'actions', 'email');
        } else {
            adm_toast(data.message || '<spring:message code="admin.common.saveFailed" javaScriptEscape="true"/>', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('<spring:message code="admin.common.saveFailed" javaScriptEscape="true"/>', 'error');
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

document.addEventListener('click', function (e) {
    const detailTrigger = e.target.closest('.js-member-open-detail');
    if (!detailTrigger) return;
    openDetail(detailTrigger.dataset.userIdx, detailTrigger.dataset.defaultTab, detailTrigger.dataset.focusSection);
});

document.addEventListener('DOMContentLoaded', function () {
    // 정렬 아이콘 초기화
    const curSort = '${search.sortBy}';
    const curDir  = '${search.sortDir}';
    document.querySelectorAll('th[data-sort]').forEach(th => {
        if (th.dataset.sort === curSort) {
            th.classList.add('sorted');
            const ico = th.querySelector('.sort-ico');
            if (ico) ico.textContent = curDir === 'ASC' ? '▲' : '▼';
        }
    });
    // URL 파라미터로 상세 자동 오픈
    const detailUserIdx = '${fn:escapeXml(param.detailUserIdx)}';
    if (detailUserIdx) {
        openDetail(detailUserIdx);
    }
});
</script>

<%@ include file="../layout-close.jsp" %>
