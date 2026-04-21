<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  마이페이지 메인
  Controller : GET /mypage
  Model 필요 :
    - user           : UsersVO
    - communityList  : List<MyPageCommunityDto>
    - communityCount : int
    - inquiryList    : List<MyPageInquiryDto>
    - inquiryCount   : int
    - reviewList     : List<MyPageReviewDto>
    - reviewCount    : int
    - planList       : List<MyPagePlanDto>
    - planCount      : int
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<%-- ── 레벨 바 · 등급 바 공통 추가 스타일 ── --%>
<style>
    /* ── 공통: 뱃지 + 바 가로 한 줄 레이아웃 ── */
    .mp-grade-row {
        display: flex;
        align-items: center;
        gap: 24px;
    }
    /* 뱃지 크기 통일: LEVEL과 BRONZE 등 모든 뱃지가 동일한 너비를 차지하도록 고정 */
    .mp-grade-row .mp-grade-badge {
        flex-shrink: 0;
        min-width: 120px;        /* 가장 긴 뱃지(PLATINUM)에 맞춘 고정 너비 */
        text-align: center;      /* 텍스트 가운데 정렬 */
        box-sizing: border-box;
    }
    /* 바 영역이 남은 공간을 모두 차지 → 뱃지 너비가 같으면 바 길이도 자동으로 같아짐 */
    .mp-grade-row .mp-level-wrap {
        flex: 1;
        min-width: 180px;
    }

    /* ── LEVEL 뱃지 (BRONZE 뱃지와 동일한 알약 스타일, 보라색 테마) ── */
    .mp-badge-level {
        background: #ede9fe;
        color: #5b21b6;
        border: 1.5px solid #c4b5fd;
    }

    /* ── 등급 바 섹션 ── */
    .mp-grade-bar-section {
        padding: 16px 24px 20px;
    }

    /* ── 등급 바 채움 색상 (금색 그라데이션) ── */
    .mp-grade-fill {
        height: 100%;
        background: linear-gradient(90deg, #f59e0b 0%, #d97706 100%);
        border-radius: 4px;
        transition: width .4s ease;
    }

    /* ── 승급 예정 안내 (할당량 100% 달성 시) ── */
    .mp-grade-promotion {
        margin-top: 8px;
        padding: 8px 14px;
        background: linear-gradient(135deg, #fef3c7, #fde68a);
        color: #92400e;
        font-size: 13px;
        font-weight: 700;
        border-radius: 8px;
        text-align: center;
        animation: mp-grade-pulse 2s ease-in-out infinite;
    }
    @keyframes mp-grade-pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.75; }
    }

    /* ── 다음 등급 힌트 (바 미달성 시) ── */
    .mp-grade-next-hint {
        margin-top: 6px;
        font-size: 11px;
        color: var(--gray-400, #94a3b8);
    }
</style>

<div class="mp-wrap">

    <%-- ══════════════════════════════════════════
         프로필 배너
    ══════════════════════════════════════════ --%>
    <div class="mp-banner">
        <div class="mp-banner-inner">
            <div class="mp-avatar">👤</div>
            <div class="mp-banner-info">
                <div class="mp-banner-nick">${user.nickname}</div>
                <div class="mp-banner-meta">
                    <span>
                        <c:choose>
                            <c:when test="${user.nationality eq 'KR'}">🇰🇷 대한민국</c:when>
                            <c:when test="${user.nationality eq 'US'}">🇺🇸 미국</c:when>
                            <c:when test="${user.nationality eq 'JP'}">🇯🇵 일본</c:when>
                            <c:when test="${user.nationality eq 'CN'}">🇨🇳 중국</c:when>
                            <c:when test="${user.nationality eq 'GB'}">🇬🇧 영국</c:when>
                            <c:when test="${user.nationality eq 'FR'}">🇫🇷 프랑스</c:when>
                            <c:when test="${user.nationality eq 'DE'}">🇩🇪 독일</c:when>
                            <c:when test="${user.nationality eq 'AU'}">🇦🇺 호주</c:when>
                            <c:when test="${user.nationality eq 'CA'}">🇨🇦 캐나다</c:when>
                            <c:otherwise>🌍 ${user.nationality}</c:otherwise>
                        </c:choose>
                    </span>
                    <span>
                        <c:choose>
                            <c:when test="${user.preferredLang eq 'ko'}">🇰🇷 한국어</c:when>
                            <c:when test="${user.preferredLang eq 'en'}">🇺🇸 English</c:when>
                            <c:when test="${user.preferredLang eq 'ja'}">🇯🇵 日本語</c:when>
                            <c:when test="${user.preferredLang eq 'zh'}">🇨🇳 中文</c:when>
                            <c:otherwise>${user.preferredLang}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            <button class="mp-banner-edit"
                    onclick="location.href='${pageContext.request.contextPath}/mypage/edit-confirm'">
                ✏️ 정보 수정
            </button>
        </div>
    </div>

    <div class="mp-inner" style="padding-top: 48px;">


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title"><span class="mp-card-icon">🏷️</span> 등급 · 자산 · 레벨</div>
            </div>
            <div class="mp-info-grid">
                <div class="mp-info-item"><div class="mp-info-label">회원 등급</div><div class="mp-info-value">${user.memberGrade}</div></div>
                <div class="mp-info-item"><div class="mp-info-label">인증 회원</div><div class="mp-info-value"><c:choose><c:when test="${user.verifiedMember}"><span style="color:#15803d;">● 인증 회원</span></c:when><c:otherwise><span style="color:#64748b;">○ 비인증 회원</span></c:otherwise></c:choose></div></div>
                <div class="mp-info-item"><div class="mp-info-label">캐쉬</div><div class="mp-info-value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">마일리지</div><div class="mp-info-value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">포인트</div><div class="mp-info-value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">레벨 / 경험치</div><div class="mp-info-value">Lv.${user.levelNo} / <fmt:formatNumber value="${user.expPoints}" pattern="#,##0"/> EXP</div></div>
                <div class="mp-info-item"><div class="mp-info-label">게시글 수</div><div class="mp-info-value">${user.totalPostCount}</div></div>
                <div class="mp-info-item"><div class="mp-info-label">댓글 수</div><div class="mp-info-value">${user.totalCommentCount}</div></div>
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             내 등급 & 재화
             TODO: UsersVO 필드 추가 후 EL 교체
               - 등급: ${user.memberGrade}       (BRONZE/SILVER/GOLD/DIAMOND/PLATINUM)
               - 인증: ${user.isVerifiedMember}  (boolean)
               - 레벨: ${user.levelNo}
               - 경험치: ${user.expPoints}
               - 포인트: ${user.pointBalance}
               - 마일리지: ${user.mileageBalance}
               - 캐시: ${user.cashBalance}
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🏅</span> 내 등급 &amp; 재화
                </div>
            </div>
            <%-- 레벨/경험치 바 (LEVEL 뱃지 + 바 가로 배치) --%>
            <div class="mp-grade-bar-section">
                <%-- LEVEL 뱃지 + 바를 가로 한 줄로 (등급 바와 동일한 구조) --%>
                <div class="mp-grade-row">
                    <%-- 왼쪽: LEVEL 뱃지 (BRONZE 뱃지와 동일한 알약 스타일) --%>
                    <span class="mp-grade-badge mp-badge-level">⚡ LEVEL</span>
                    <%-- 오른쪽: 레벨 경험치 바 --%>
                    <div class="mp-level-wrap">
                    <%--
                        경험치 바 계산 로직:
                        - currentLevelExp : 현재 레벨에 진입하기 위해 필요했던 누적 EXP (시작점)
                        - nextLevelExp    : 다음 레벨에 진입하기 위해 필요한 누적 EXP (끝점)
                        - user.expPoints  : 유저의 현재 누적 EXP
                        - 바 퍼센트 = (현재EXP - 현재레벨시작EXP) / (다음레벨EXP - 현재레벨시작EXP) × 100
                    --%>
                    <c:set var="expInLevel" value="${user.expPoints - currentLevelExp}" />
                    <c:set var="expNeeded" value="${nextLevelExp - currentLevelExp}" />
                    <c:set var="expPercent" value="${expNeeded > 0 ? (expInLevel * 100 / expNeeded) : 100}" />
                    <%-- 퍼센트가 100을 넘지 않도록 보정 --%>
                    <c:if test="${expPercent > 100}"><c:set var="expPercent" value="100" /></c:if>
                    <c:if test="${expPercent < 0}"><c:set var="expPercent" value="0" /></c:if>

                    <div class="mp-level-header">
                        <span class="mp-level-label">Lv. ${user.levelNo}</span>
                        <span class="mp-level-xp">
                            <fmt:formatNumber value="${user.expPoints}" pattern="#,##0" />
                            /
                            <fmt:formatNumber value="${nextLevelExp}" pattern="#,##0" /> XP
                        </span>
                    </div>
                    <div class="mp-xp-bar">
                        <div class="mp-xp-fill" style="width: ${expPercent}%;"></div>
                    </div>
                </div>
                <%-- /mp-grade-row --%>
                </div>
            </div>

            <%-- ── 등급 진행 바 ── --%>
            <%--
                등급 바 계산 로직:
                - gradePolicies       : 활성 등급 정책 목록 (sort_order ASC: BRONZE→PLATINUM)
                - currentMonthPayment : 당월 결제 총액 (이번 달 결제 → 다음 달 등급 산정 기준)
                - 다음 등급의 min_monthly_payment → 바의 끝점
                - 최고 등급이면 바 100%로 채움
            --%>
            <c:set var="currentGradeMin" value="0" />
            <c:set var="nextGradeMin" value="0" />
            <c:set var="nextGradeName" value="" />
            <c:set var="nextGradeFound" value="false" />
            <c:set var="isMaxGrade" value="true" />
            <%-- 당월 결제액 기준으로 예상되는 등급 계산 --%>
            <c:set var="expectedGrade" value="BRONZE" />

            <%-- 등급 정책 순회: 현재 등급의 기준값 + 다음 등급 정보 + 예상 등급 --%>
            <c:forEach var="gp" items="${gradePolicies}">
                <c:if test="${gp.memberGrade eq user.memberGrade}">
                    <c:set var="currentGradeMin" value="${gp.minMonthlyPayment}" />
                </c:if>
                <%-- 당월 결제액이 충족하는 가장 높은 등급 = 예상 등급 --%>
                <c:if test="${currentMonthPayment >= gp.minMonthlyPayment}">
                    <c:set var="expectedGrade" value="${gp.memberGrade}" />
                </c:if>
            </c:forEach>

            <%-- 다음 등급 찾기: 현재 등급보다 기준이 높은 첫 번째 등급 --%>
            <c:forEach var="gp" items="${gradePolicies}">
                <c:if test="${!nextGradeFound && gp.minMonthlyPayment > currentGradeMin}">
                    <c:set var="nextGradeMin" value="${gp.minMonthlyPayment}" />
                    <c:set var="nextGradeName" value="${gp.memberGrade}" />
                    <c:set var="nextGradeFound" value="true" />
                    <c:set var="isMaxGrade" value="false" />
                </c:if>
            </c:forEach>

            <%-- 등급 바 퍼센트 계산 --%>
            <c:choose>
                <c:when test="${isMaxGrade}">
                    <c:set var="gradePercent" value="100" />
                </c:when>
                <c:otherwise>
                    <c:set var="gradeRange" value="${nextGradeMin - currentGradeMin}" />
                    <c:set var="gradeProgress" value="${currentMonthPayment - currentGradeMin}" />
                    <c:set var="gradePercent" value="${gradeRange > 0 ? (gradeProgress * 100 / gradeRange) : 0}" />
                    <c:if test="${gradePercent > 100}"><c:set var="gradePercent" value="100" /></c:if>
                    <c:if test="${gradePercent < 0}"><c:set var="gradePercent" value="0" /></c:if>
                </c:otherwise>
            </c:choose>

            <div class="mp-grade-bar-section">
                <%-- 등급 뱃지 + 바를 가로로 나란히 배치 (레벨 바와 동일한 구조) --%>
                <div class="mp-grade-row">
                    <%-- 왼쪽: 등급 뱃지 --%>
                    <span class="mp-grade-badge mp-grade-${user.memberGrade}">
                        <c:choose>
                            <c:when test="${user.memberGrade eq 'BRONZE'}">🥉 BRONZE</c:when>
                            <c:when test="${user.memberGrade eq 'SILVER'}">🥈 SILVER</c:when>
                            <c:when test="${user.memberGrade eq 'GOLD'}">🥇 GOLD</c:when>
                            <c:when test="${user.memberGrade eq 'DIAMOND'}">💎 DIAMOND</c:when>
                            <c:when test="${user.memberGrade eq 'PLATINUM'}">👑 PLATINUM</c:when>
                            <c:otherwise>${user.memberGrade}</c:otherwise>
                        </c:choose>
                    </span>
                    <%-- 오른쪽: 바 영역 (레벨 바와 동일한 mp-level-wrap 구조) --%>
                    <div class="mp-level-wrap">
                        <div class="mp-level-header">
                            <span class="mp-level-label">등급</span>
                            <span class="mp-level-xp">
                                <c:choose>
                                    <c:when test="${isMaxGrade}">
                                        최고 등급 달성!
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${currentMonthPayment}" pattern="#,##0" />
                                        /
                                        <fmt:formatNumber value="${nextGradeMin}" pattern="#,##0" />원
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="mp-xp-bar">
                            <div class="mp-grade-fill" style="width: ${gradePercent}%;"></div>
                        </div>
                    </div>
                </div>
                <%-- 바 아래 승급 예정 / 다음 등급 안내 --%>
                <c:choose>
                    <c:when test="${isMaxGrade}">
                        <%-- 최고 등급이면 별도 안내 없음 --%>
                    </c:when>
                    <c:when test="${expectedGrade ne user.memberGrade}">
                        <div class="mp-grade-promotion">
                            ${user.memberGrade} → ${expectedGrade} 승급 예정!
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mp-grade-next-hint">
                            다음 등급:
                            <c:choose>
                                <c:when test="${nextGradeName eq 'SILVER'}">🥈 SILVER</c:when>
                                <c:when test="${nextGradeName eq 'GOLD'}">🥇 GOLD</c:when>
                                <c:when test="${nextGradeName eq 'DIAMOND'}">💎 DIAMOND</c:when>
                                <c:when test="${nextGradeName eq 'PLATINUM'}">👑 PLATINUM</c:when>
                                <c:otherwise>${nextGradeName}</c:otherwise>
                            </c:choose>
                            (이번 달 결제 <fmt:formatNumber value="${nextGradeMin}" pattern="#,##0" />원 이상)
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <%-- 재화 --%>
            <div class="mp-currency-grid">
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-point.svg" alt="포인트" width="40" height="40"></div>
                    <div class="mp-currency-label">포인트</div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0" /></div>
                </div>
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-mileage.svg" alt="마일리지" width="40" height="40"></div>
                    <div class="mp-currency-label">마일리지</div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0" /></div>
                </div>
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-cash.svg" alt="캐시" width="40" height="40"></div>
                    <div class="mp-currency-label">캐시</div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0" /></div>
                </div>
            </div>
            <%-- 활동 통계
                 TODO: UsersVO 필드 추가 후 EL 교체
                   - 작성글:    ${user.totalPostCount}
                   - 작성댓글:  ${user.totalCommentCount}
                   - 리뷰:      ${user.totalReviewCount}    (explore 팀 구현 후)
                   - 여행코스:  ${user.totalCourseCount}    (courses 팀 구현 후)
            --%>
            <div class="mp-stats-grid">
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-community">커뮤니티</span>
                    <div class="mp-stats-value">${user.totalPostCount}</div>
                    <div class="mp-stats-label">작성 글</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-community">커뮤니티</span>
                    <div class="mp-stats-value">${user.totalCommentCount}</div>
                    <div class="mp-stats-label">작성 댓글</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-explore">여행지탐색</span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label">리뷰</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-courses">여행코스</span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label">여행코스</div>
                </div>
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             내 정보
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🪪</span> 내 정보
                </div>
            </div>
            <div class="mp-info-grid">
                <div class="mp-info-item">
                    <div class="mp-info-label">닉네임</div>
                    <div class="mp-info-value">${user.nickname}</div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">아이디</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${not empty user.userId}">${user.userId}</c:when>
                            <c:otherwise><span style="color:var(--gray-400);">소셜 로그인 전용</span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">국적</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.nationality eq 'KR'}">🇰🇷 대한민국</c:when>
                            <c:when test="${user.nationality eq 'US'}">🇺🇸 미국</c:when>
                            <c:when test="${user.nationality eq 'JP'}">🇯🇵 일본</c:when>
                            <c:when test="${user.nationality eq 'CN'}">🇨🇳 중국</c:when>
                            <c:when test="${user.nationality eq 'GB'}">🇬🇧 영국</c:when>
                            <c:when test="${user.nationality eq 'FR'}">🇫🇷 프랑스</c:when>
                            <c:when test="${user.nationality eq 'DE'}">🇩🇪 독일</c:when>
                            <c:when test="${user.nationality eq 'AU'}">🇦🇺 호주</c:when>
                            <c:when test="${user.nationality eq 'CA'}">🇨🇦 캐나다</c:when>
                            <c:otherwise>🌍 ${user.nationality}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">선호 언어</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.preferredLang eq 'ko'}">🇰🇷 한국어</c:when>
                            <c:when test="${user.preferredLang eq 'en'}">🇺🇸 English</c:when>
                            <c:when test="${user.preferredLang eq 'ja'}">🇯🇵 日本語</c:when>
                            <c:when test="${user.preferredLang eq 'zh'}">🇨🇳 中文</c:when>
                            <c:otherwise>${user.preferredLang}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">이메일</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${not empty user.userEmail}">
                                ${user.userEmail}
                                <c:if test="${user.emailVerified}">
                                    <span style="font-size:11px;color:#15803d;margin-left:4px;">✓ 인증됨</span>
                                </c:if>
                            </c:when>
                            <c:otherwise><span style="color:var(--gray-400);">미등록</span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">계정 상태</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.accountStatus eq 'ACTIVE'}">
                                <span style="color:#15803d;">● 정상</span>
                            </c:when>
                            <c:otherwise>${user.accountStatus}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <%-- 알림 카드 --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">📬</span> 새 알림
                    <c:if test="${not empty notifications}">
                        <span class="mp-notif-count">${totalNotificationCount}</span>
                    </c:if>
                </div>
            </div>
            <div class="mp-notif-list">
                <c:choose>
                    <c:when test="${empty notifications}">
                        <div class="mp-notif-empty">새로운 알림이 없어요.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="noti" items="${notifications}">
                            <div class="mp-notif-item" data-notification-id="${noti.notificationId}"
             onclick="deleteNotification('${noti.notificationId}', '${noti.sourceType}', '${noti.sourceId}')">
                        <span class="mp-notif-type">
                            <c:choose>
                                <c:when test="${noti.sourceType eq 'community'}">[커뮤니티]</c:when>
                                <c:when test="${noti.sourceType eq 'inquiry'}">[문의게시판]</c:when>
                                <c:when test="${noti.sourceType eq 'report'}">[신고게시판]</c:when>
                                <c:otherwise>[알림]</c:otherwise>
                            </c:choose>
                        </span>
                                <span class="mp-notif-msg">${noti.message}</span>
                                <span class="mp-notif-date">
                            <fmt:formatDate value="${noti.createdAt}" pattern="yyyy-MM-dd"/>
                        </span>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="mp-notif-footer">
                새 알림은 최신순으로 최대 10개까지만 표시됩니다.
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             내 리뷰
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">⭐</span>
                    내 리뷰
                    <span class="mp-card-count">${reviewCount}</span>
                </div>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty reviewList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">⭐</div>
                            작성한 리뷰가 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="review" items="${reviewList}">
                            <a href="${pageContext.request.contextPath}/detail/${review.spotIdx}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${review.spotName}</div>
                                    <div class="mp-list-meta">
                                        <span class="mp-review-stars">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= review.rating}">★</c:when>
                                                    <c:otherwise>☆</c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </span>
                                        <c:if test="${not empty review.content}">
                                            <span class="mp-review-excerpt">${fn:substring(review.content, 0, 40)}<c:if test="${fn:length(review.content) > 40}">…</c:if></span>
                                        </c:if>
                                        <span><fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd"/></span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-rating">${review.rating}점</span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>


        <%-- ══════════════════════════════════════════
             내 여행 일정
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🗺️</span>
                    내 여행 일정
                    <span class="mp-card-count">${planCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/courses/list"
                   class="mp-card-more">전체보기 →</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty planList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">🗺️</div>
                            등록된 여행 일정이 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="plan" items="${planList}">
                            <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.planId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${plan.title}</div>
                                    <div class="mp-list-meta">
                                        <c:if test="${not empty plan.destination}">
                                            <span>${plan.destination}</span>
                                        </c:if>
                                        <span>
                                            <fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd"/>
                                            ~
                                            <fmt:formatDate value="${plan.endDate}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <span><fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd"/></span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <c:choose>
                                        <c:when test="${plan.isPublic}">
                                            <span class="mp-badge mp-badge-public">공개</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="mp-badge mp-badge-private">비공개</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${plan.planSource eq 'AI'}">
                                        <span class="mp-badge mp-badge-ai">AI</span>
                                    </c:if>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>


        <%-- ══════════════════════════════════════════
             예매 정보
             - 항공권 구매 시뮬레이션으로 생성된 FLIGHT_PURCHASE_SIMULATION 이력
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">✈️</span>
                    예매 정보
                    <span class="mp-card-count">${flightBookingCount}</span>
                </div>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty flightBookingList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">✈️</div>
                            항공권 예매 정보가 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="booking" items="${flightBookingList}">
                            <a href="${pageContext.request.contextPath}/detail/${booking.spotIdx}"
                               class="mp-list-item mp-flight-booking-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">
                                        ${booking.spotName}
                                        <span class="mp-flight-booking-no">${booking.purchaseNo}</span>
                                    </div>
                                    <div class="mp-list-meta mp-flight-booking-meta">
                                        <span>${booking.airlineName} · ${booking.flightNo}</span>
                                        <span>${booking.originAirportCode} → ${booking.destinationAirportCode}</span>
                                        <span>
                                            <fmt:formatDate value="${booking.departureTime}" pattern="yyyy-MM-dd HH:mm"/>
                                            출발
                                        </span>
                                        <span>${booking.returnAirlineName} · ${booking.returnFlightNo}</span>
                                        <span>${booking.returnOriginAirportCode} → ${booking.returnDestinationAirportCode}</span>
                                        <span>
                                            <fmt:formatDate value="${booking.returnDepartureTime}" pattern="yyyy-MM-dd HH:mm"/>
                                            귀국
                                        </span>
                                        <span>
                                            총액 <fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0"/> C
                                        </span>
                                        <span>
                                            캐시 <fmt:formatNumber value="${booking.usedCash}" pattern="#,##0"/> C
                                            · 마일리지 <fmt:formatNumber value="${booking.usedMileage}" pattern="#,##0"/> M
                                        </span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-flight">${booking.status}</span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>


        <%-- ══════════════════════════════════════════
             내가 작성한 커뮤니티 글
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">✍️</span>
                    내 커뮤니티 글
                    <span class="mp-card-count">${communityCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/community/list?userIdx=${user.userIdx}"
                   class="mp-card-more">전체보기 →</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty communityList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">📝</div>
                            작성한 게시글이 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="post" items="${communityList}">
                            <a href="${pageContext.request.contextPath}/community/${post.postId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${post.title}</div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/></span>
                                        <span>👁 ${post.viewCount}</span>
                                        <span>❤️ ${post.likeCount}</span>
                                        <span>💬 ${post.commentCount}</span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-type-${post.postType}">
                                        <c:choose>
                                            <c:when test="${post.postType eq 'review'}">후기</c:when>
                                            <c:when test="${post.postType eq 'photo'}">사진</c:when>
                                            <c:when test="${post.postType eq 'tip'}">팁</c:when>
                                            <c:when test="${post.postType eq 'question'}">질문</c:when>
                                            <c:otherwise>${post.postType}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             내 문의 글
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">📬</span>
                    내 문의
                    <span class="mp-card-count">${inquiryCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/inquiry/list"
                   class="mp-card-more">전체보기 →</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty inquiryList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">📭</div>
                            작성한 문의가 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="inq" items="${inquiryList}">
                            <a href="${pageContext.request.contextPath}/inquiry/${inq.inquiryId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${inq.title}</div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${inq.createdAt}" pattern="yyyy-MM-dd"/></span>
                                        <span>
                                            <c:choose>
                                                <c:when test="${inq.category eq 'service'}">서비스</c:when>
                                                <c:when test="${inq.category eq 'payment'}">결제</c:when>
                                                <c:when test="${inq.category eq 'account'}">계정</c:when>
                                                <c:when test="${inq.category eq 'bug'}">오류신고</c:when>
                                                <c:otherwise>기타</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-${inq.status}">
                                        <c:choose>
                                            <c:when test="${inq.status eq 'PENDING'}">대기중</c:when>
                                            <c:when test="${inq.status eq 'IN_PROGRESS'}">처리중</c:when>
                                            <c:when test="${inq.status eq 'COMPLETED'}">✓ 답변완료</c:when>
                                        </c:choose>
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>


        <%-- ══════════════════════════════════════════
             내 신고내역
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🚨</span>
                    내 신고내역
                    <span class="mp-card-count">${reportCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/report/list"
                   class="mp-card-more">전체보기 →</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty reportList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">📭</div>
                            접수한 신고가 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="rpt" items="${reportList}">
                            <a href="${pageContext.request.contextPath}/report/${rpt.reportId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">
                                        <c:choose>
                                            <c:when test="${rpt.targetType eq 'post'}">게시글 신고</c:when>
                                            <c:when test="${rpt.targetType eq 'comment'}">댓글 신고</c:when>
                                            <c:when test="${rpt.targetType eq 'user'}">유저 신고</c:when>
                                            <c:otherwise>신고</c:otherwise>
                                        </c:choose>
                                        <span style="color:var(--gray-400);font-size:12px;margin-left:4px;">#${rpt.targetId}</span>
                                    </div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${rpt.createdAt}" pattern="yyyy-MM-dd"/></span>
                                        <c:if test="${not empty rpt.reason}">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${rpt.reason eq 'spam'}">스팸/광고</c:when>
                                                    <c:when test="${rpt.reason eq 'abuse'}">욕설/비방</c:when>
                                                    <c:when test="${rpt.reason eq 'privacy'}">개인정보 노출</c:when>
                                                    <c:when test="${rpt.reason eq 'adult'}">음란물</c:when>
                                                    <c:when test="${rpt.reason eq 'illegal'}">불법 정보</c:when>
                                                    <c:when test="${rpt.reason eq 'other'}">기타</c:when>
                                                    <c:otherwise>${rpt.reason}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-${rpt.status}">
                                        <c:choose>
                                            <c:when test="${rpt.status eq 'IN_REVIEW'}">검토중</c:when>
                                            <c:when test="${rpt.status eq 'RESOLVED'}">처리완료</c:when>
                                            <c:when test="${rpt.status eq 'DISMISSED'}">반려</c:when>
                                            <c:otherwise>${rpt.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">ITEM</span> 내 꾸미기 아이템
                </div>
            </div>

            <c:if test="${not empty itemMessage}">
                <div class="mp-item-alert mp-item-alert--success">${itemMessage}</div>
            </c:if>
            <c:if test="${not empty itemError}">
                <div class="mp-item-alert mp-item-alert--error">${itemError}</div>
            </c:if>

            <c:choose>
                <c:when test="${empty inventoryItems}">
                    <div class="mp-empty">
                        <div class="mp-empty-icon">SHOP</div>
                        <div>아직 보유한 꾸미기 아이템이 없습니다.</div>
                        <button class="mp-item-shop-btn"
                                type="button"
                                onclick="location.href='${pageContext.request.contextPath}/shop'">
                            상품 보러가기
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:set var="hasNicknameColor" value="false"/>
                    <c:set var="hasNicknameEffect" value="false"/>
                    <c:set var="hasProfileBadge" value="false"/>
                    <c:set var="hasBubbleStyle" value="false"/>

                    <c:forEach var="item" items="${inventoryItems}">
                        <c:if test="${item.itemType eq 'NICKNAME_COLOR'}"><c:set var="hasNicknameColor" value="true"/></c:if>
                        <c:if test="${item.itemType eq 'NICKNAME_EFFECT'}"><c:set var="hasNicknameEffect" value="true"/></c:if>
                        <c:if test="${item.itemType eq 'PROFILE_BADGE'}"><c:set var="hasProfileBadge" value="true"/></c:if>
                        <c:if test="${item.itemType eq 'BUBBLE_STYLE'}"><c:set var="hasBubbleStyle" value="true"/></c:if>
                    </c:forEach>

                    <div class="mp-item-section-list">
                        <c:if test="${hasNicknameColor}">
                            <section class="mp-item-section">
                                <div class="mp-item-section-head">
                                    <span>NC</span>
                                    <div>
                                        <h3>닉네임 색상</h3>
                                        <p>게시글, 댓글, 리뷰 작성자명에 적용할 기본 색상 상품입니다.</p>
                                    </div>
                                </div>
                                <div class="mp-item-grid">
                                    <c:forEach var="item" items="${inventoryItems}">
                                        <c:if test="${item.itemType eq 'NICKNAME_COLOR'}">
                                            <%@ include file="item-card-fragment.jspf" %>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </section>
                        </c:if>

                        <c:if test="${hasNicknameEffect}">
                            <section class="mp-item-section">
                                <div class="mp-item-section-head">
                                    <span>NE</span>
                                    <div>
                                        <h3>닉네임 테두리/글로우</h3>
                                        <p>닉네임을 더 눈에 띄게 만드는 효과형 상품입니다.</p>
                                    </div>
                                </div>
                                <div class="mp-item-grid">
                                    <c:forEach var="item" items="${inventoryItems}">
                                        <c:if test="${item.itemType eq 'NICKNAME_EFFECT'}">
                                            <%@ include file="item-card-fragment.jspf" %>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </section>
                        </c:if>

                        <c:if test="${hasProfileBadge}">
                            <section class="mp-item-section">
                                <div class="mp-item-section-head">
                                    <span>PB</span>
                                    <div>
                                        <h3>프로필 뱃지</h3>
                                        <p>나의 여행 취향과 활동 스타일을 보여주는 뱃지 상품입니다.</p>
                                    </div>
                                </div>
                                <div class="mp-item-grid">
                                    <c:forEach var="item" items="${inventoryItems}">
                                        <c:if test="${item.itemType eq 'PROFILE_BADGE'}">
                                            <%@ include file="item-card-fragment.jspf" %>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </section>
                        </c:if>

                        <c:if test="${hasBubbleStyle}">
                            <section class="mp-item-section">
                                <div class="mp-item-section-head">
                                    <span>CB</span>
                                    <div>
                                        <h3>댓글/리뷰 말풍선</h3>
                                        <p>댓글과 리뷰 카드의 분위기를 바꾸는 말풍선 스타일 상품입니다.</p>
                                    </div>
                                </div>
                                <div class="mp-item-grid">
                                    <c:forEach var="item" items="${inventoryItems}">
                                        <c:if test="${item.itemType eq 'BUBBLE_STYLE'}">
                                            <%@ include file="item-card-fragment.jspf" %>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </section>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <%-- /mp-inner --%>
</div>
<%-- /mp-wrap --%>

<script>
    /**
     * 단일 알림 삭제
     */
    /* ===== 뒤로가기 캐시 새로고침 ===== */
    window.addEventListener('pageshow', function(e) {
        if (e.persisted) location.reload();
    });

    function deleteNotification(notificationId, sourceType, sourceId) {
        var ctx = '${pageContext.request.contextPath}';
        var fallbackUrl = ctx + (
            sourceType === 'community' ? '/community/' + sourceId :
            sourceType === 'inquiry'   ? '/inquiry/'   + sourceId :
            sourceType === 'report'    ? '/report/'    + sourceId : '/mypage'
        );

        fetch(ctx + '/mypage/notification/' + notificationId + '/read', {
            method: 'POST',
            headers: {'X-Requested-With': 'XMLHttpRequest'}
        }).then(r => r.json())
          .then(data => {
              location.href = (data.success && data.redirectUrl)
                  ? ctx + data.redirectUrl
                  : fallbackUrl;
          })
          .catch(function() {
              location.href = fallbackUrl;
          });
    }

    /**
     * 날짜 포맷팅 (YYYY-MM-DD)
     */
    function formatDate(dateString) {
        const date = new Date(dateString);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

</script>

<%-- ══════════════════════════════════════════
     레벨업 축하 팝업
     Controller에서 levelUpLevel 값이 전달되면 자동으로 표시됩니다.
══════════════════════════════════════════ --%>
<c:if test="${not empty levelUpLevel}">
<div id="levelup-overlay" class="levelup-overlay">
    <div class="levelup-popup">
        <div class="levelup-icon">🎉</div>
        <div class="levelup-title">LEVEL UP!</div>
        <div class="levelup-level">Lv.${levelUpLevel}</div>
        <div class="levelup-msg">레벨업 달성! 축하합니다!</div>
        <button class="levelup-close-btn" onclick="closeLevelUpPopup()">확인</button>
    </div>
</div>
<style>
    /* ── 레벨업 팝업 오버레이 ── */
    .levelup-overlay {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0,0,0,0.5);
        display: flex; align-items: center; justify-content: center;
        z-index: 9999;
        animation: levelup-fade-in 0.3s ease;
    }
    /* ── 팝업 카드 ── */
    .levelup-popup {
        background: #fff; border-radius: 20px; padding: 40px 48px;
        text-align: center; box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        animation: levelup-scale-in 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    }
    /* ── 아이콘 ── */
    .levelup-icon {
        font-size: 56px; margin-bottom: 8px;
        animation: levelup-bounce 0.6s ease 0.3s both;
    }
    /* ── LEVEL UP! 타이틀 ── */
    .levelup-title {
        font-size: 14px; font-weight: 700; letter-spacing: 4px;
        color: #6366f1; margin-bottom: 4px;
    }
    /* ── 레벨 숫자 ── */
    .levelup-level {
        font-size: 40px; font-weight: 800;
        background: linear-gradient(135deg, #6366f1, #a855f7);
        -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        background-clip: text; margin-bottom: 8px;
    }
    /* ── 축하 메시지 ── */
    .levelup-msg {
        font-size: 15px; color: #64748b; margin-bottom: 24px;
    }
    /* ── 확인 버튼 ── */
    .levelup-close-btn {
        background: linear-gradient(135deg, #6366f1, #a855f7);
        color: #fff; border: none; border-radius: 12px;
        padding: 12px 48px; font-size: 15px; font-weight: 600;
        cursor: pointer; transition: transform 0.15s, box-shadow 0.15s;
    }
    .levelup-close-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 16px rgba(99,102,241,0.4);
    }
    /* ── 애니메이션 ── */
    @keyframes levelup-fade-in { from { opacity: 0; } to { opacity: 1; } }
    @keyframes levelup-scale-in { from { transform: scale(0.6); opacity: 0; } to { transform: scale(1); opacity: 1; } }
    @keyframes levelup-bounce {
        0% { transform: scale(0); }
        60% { transform: scale(1.3); }
        100% { transform: scale(1); }
    }
</style>
<script>
    /**
     * 레벨업 팝업 닫기.
     * 오버레이를 fade-out 시키고 DOM에서 제거합니다.
     */
    function closeLevelUpPopup() {
        var overlay = document.getElementById('levelup-overlay');
        if (overlay) {
            overlay.style.animation = 'levelup-fade-in 0.2s ease reverse';
            setTimeout(function() { overlay.remove(); }, 200);
        }
    }
</script>
</c:if>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
