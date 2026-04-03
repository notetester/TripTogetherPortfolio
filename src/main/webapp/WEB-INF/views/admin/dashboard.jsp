<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="dashboard"/>
<c:set var="pageTitle"  value="대시보드"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <!-- 통계 카드 -->
    <div class="stat-grid">
        <div class="stat-card blue">
            <div class="stat-label">전체 회원</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.totalMembers}" pattern="#,###"/></div>
            <div class="stat-sub">오늘 +${stats.todayNewMembers}명 가입</div>
            <div class="stat-icon">👥</div>
        </div>
        <div class="stat-card green">
            <div class="stat-label">활성 회원</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.activeMembers}" pattern="#,###"/></div>
            <div class="stat-sub">전체의
                <fmt:formatNumber value="${stats.totalMembers > 0 ? stats.activeMembers * 100.0 / stats.totalMembers : 0}"
                                  maxFractionDigits="1"/>%
            </div>
            <div class="stat-icon">✅</div>
        </div>
        <div class="stat-card yellow">
            <div class="stat-label">휴면 회원</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.dormantMembers}" pattern="#,###"/></div>
            <div class="stat-sub">관리 필요</div>
            <div class="stat-icon">😴</div>
        </div>
        <div class="stat-card red">
            <div class="stat-label">탈퇴 회원</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.deletedMembers}" pattern="#,###"/></div>
            <div class="stat-sub">복구 불가</div>
            <div class="stat-icon">🗑️</div>
        </div>
        <div class="stat-card blue">
            <div class="stat-label">오늘 로그인</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.todayLogins}" pattern="#,###"/></div>
            <div class="stat-sub">실패 ${stats.todayFailedLogins}건</div>
            <div class="stat-icon">🔑</div>
        </div>
        <div class="stat-card purple">
            <div class="stat-label">소셜 연동</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.kakaoLinked + stats.naverLinked + stats.googleLinked}" pattern="#,###"/></div>
            <div class="stat-sub">카카오·네이버·구글</div>
            <div class="stat-icon">🔗</div>
        </div>
    </div>

    <!-- 소셜 연동 분포 -->
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">🔗 소셜 로그인 연동 현황</div>
        </div>
        <div class="adm-card-body">
            <div style="display:flex;gap:20px;flex-wrap:wrap;">
                <div style="flex:1;min-width:120px;text-align:center;padding:16px;background:#1a2030;border-radius:10px;">
                    <div style="font-size:24px;margin-bottom:8px;">🟡</div>
                    <div style="font-size:22px;font-weight:700;color:#f1f5f9;">
                        <fmt:formatNumber value="${stats.kakaoLinked}" pattern="#,###"/>
                    </div>
                    <div style="font-size:11px;color:#64748b;margin-top:4px;">카카오</div>
                </div>
                <div style="flex:1;min-width:120px;text-align:center;padding:16px;background:#1a2030;border-radius:10px;">
                    <div style="font-size:24px;margin-bottom:8px;color:#03c75a;font-weight:900;">N</div>
                    <div style="font-size:22px;font-weight:700;color:#f1f5f9;">
                        <fmt:formatNumber value="${stats.naverLinked}" pattern="#,###"/>
                    </div>
                    <div style="font-size:11px;color:#64748b;margin-top:4px;">네이버</div>
                </div>
                <div style="flex:1;min-width:120px;text-align:center;padding:16px;background:#1a2030;border-radius:10px;">
                    <div style="font-size:24px;margin-bottom:8px;">G</div>
                    <div style="font-size:22px;font-weight:700;color:#f1f5f9;">
                        <fmt:formatNumber value="${stats.googleLinked}" pattern="#,###"/>
                    </div>
                    <div style="font-size:11px;color:#64748b;margin-top:4px;">Google</div>
                </div>
            </div>
        </div>
    </div>

    <!-- 빠른 링크 -->
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">⚡ 빠른 이동</div>
        </div>
        <div class="adm-card-body" style="display:flex;gap:12px;flex-wrap:wrap;">
            <a href="${pageContext.request.contextPath}/admin/members"
               class="adm-btn adm-btn-primary">👥 회원 관리</a>
            <a href="${pageContext.request.contextPath}/admin/members?status=DORMANT"
               class="adm-btn adm-btn-ghost">😴 휴면 회원 보기</a>
            <a href="${pageContext.request.contextPath}/admin/members?sortBy=createdAt&sortDir=DESC"
               class="adm-btn adm-btn-ghost">🆕 최근 가입 순</a>
        </div>
    </div>

</div>

<%@ include file="layout-close.jsp" %>
