<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message code="admin.status.ACTIVE" var="memberStatusActive"/>
<spring:message code="admin.status.DORMANT" var="memberStatusDormant"/>
<spring:message code="admin.status.BLOCKED" var="memberStatusBlocked"/>
<spring:message code="admin.status.DELETED" var="memberStatusDeleted"/>
<c:forEach items="${list}" var="m">
                    <c:set var="hasKakao" value="${m.linkedProviders != null and fn:contains(m.linkedProviders, 'KAKAO')}"/>
                    <c:set var="hasNaver" value="${m.linkedProviders != null and fn:contains(m.linkedProviders, 'NAVER')}"/>
                    <c:set var="hasGoogle" value="${m.linkedProviders != null and fn:contains(m.linkedProviders, 'GOOGLE')}"/>
                    <c:set var="socialRank" value="${(hasKakao ? 4 : 0) + (hasNaver ? 2 : 0) + (hasGoogle ? 1 : 0)}"/>
                    <tr class="js-member-row"
                        data-user-idx="${m.userIdx}"
                        data-nickname="${fn:escapeXml(m.nickname)}"
                        data-email="${fn:escapeXml(m.userEmail)}"
                        data-status="${fn:escapeXml(m.accountStatus)}"
                        data-role="${fn:escapeXml(m.userRole)}"
                        data-social-count="${m.socialCount}"
                        data-social-rank="${socialRank}"
                        data-last-login-at="${m.lastLoginAt != null ? m.lastLoginAt.time : 0}"
                        data-created-at="${m.createdAt != null ? m.createdAt.time : 0}">
                        <%-- 체크박스 --%>
                        <td style="text-align:center;">
                            <input type="checkbox" class="js-row-check adm-check" value="${m.userIdx}" onchange="updateBulkBar()">
                        </td>
                        <%-- 회원 정보 --%>
                        <td data-sort-value="${fn:escapeXml(m.nickname)}">
                            <div class="mem-id-cell">
                                <div class="mem-av ${m.accountStatus == 'DORMANT' ? 'dormant' : m.accountStatus == 'DELETED' ? 'deleted' : ''}">
                                    <c:choose>
                                        <c:when test="${not empty m.nickname}">${fn:substring(m.nickname, 0, 1)}</c:when>
                                        <c:otherwise>?</c:otherwise>
                                    </c:choose>
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
                        <td data-sort-value="${fn:escapeXml(m.userEmail)}">
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
                        <td data-sort-value="${fn:escapeXml(m.accountStatus)}">
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
                        <td data-sort-value="${fn:escapeXml(m.userRole)}">
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
                                    <c:if test="${hasKakao}">
                                        <span class="adm-social-pill kakao" title="<spring:message code='admin.social.kakao'/>">
                                            <span class="adm-social-icon kakao-mark">k</span>
                                            <span class="adm-social-label"><spring:message code="admin.social.kakao"/></span>
                                        </span>
                                    </c:if>
                                    <c:if test="${hasNaver}">
                                        <span class="adm-social-pill naver" title="<spring:message code='admin.social.naver'/>">
                                            <span class="adm-social-icon naver-mark">N</span>
                                            <span class="adm-social-label"><spring:message code="admin.social.naver"/></span>
                                        </span>
                                    </c:if>
                                    <c:if test="${hasGoogle}">
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
                        <td data-sort-value="${m.lastLoginAt != null ? m.lastLoginAt.time : 0}">
                            <button type="button"
                                    class="adm-cell-link js-member-open-detail"
                                    data-user-idx="${m.userIdx}"
                                    data-default-tab="hist"
                                    data-focus-section="loginHistory">
                                <span style="font-size:12px;">
                                    <c:choose>
                                        <c:when test="${m.lastLoginAt != null}">
                                            <fmt:formatDate value="${m.lastLoginAtDate}" pattern="MM.dd HH:mm"/>
                                        </c:when>
                                        <c:otherwise><span style="color:#475569;"><spring:message code="admin.members.none"/></span></c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">✅${m.loginSuccessCount} / ❌${m.loginFailCount}</span>
                            </button>
                        </td>

                        <%-- 가입일 --%>
                        <td data-sort-value="${m.createdAt != null ? m.createdAt.time : 0}">
                            <button type="button"
                                    class="adm-cell-link js-member-open-detail"
                                    data-user-idx="${m.userIdx}"
                                    data-default-tab="info"
                                    data-focus-section="createdMeta"
                                    style="font-size:12px;color:#64748b;">
                                <fmt:formatDate value="${m.createdAtDate}" pattern="yyyy.MM.dd"/>
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
