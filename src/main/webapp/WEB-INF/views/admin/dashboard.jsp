<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="dashboard"/>
<c:set var="pageTitle" value="대시보드"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="stat-grid">
        <div class="stat-card blue">
            <div class="stat-label">전체 회원</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.totalMembers}" pattern="#,###"/></div>
            <div class="stat-sub">오늘 신규 ${stats.todayNewMembers}명</div>
            <div class="stat-icon">👥</div>
        </div>
        <div class="stat-card green">
            <div class="stat-label">활성 회원</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.activeMembers}" pattern="#,###"/></div>
            <div class="stat-sub">운영 가능 계정</div>
            <div class="stat-icon">✅</div>
        </div>
        <div class="stat-card yellow">
            <div class="stat-label">휴면 회원</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.dormantMembers}" pattern="#,###"/></div>
            <div class="stat-sub">리마인드 대상</div>
            <div class="stat-icon">😴</div>
        </div>
        <div class="stat-card red">
            <div class="stat-label">오늘 로그인 실패</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.todayFailedLogins}" pattern="#,###"/></div>
            <div class="stat-sub">오늘 성공 ${stats.todayLogins}건</div>
            <div class="stat-icon">🚨</div>
        </div>
        <div class="stat-card purple">
            <div class="stat-label">소셜 연동</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.kakaoLinked + stats.naverLinked + stats.googleLinked}" pattern="#,###"/></div>
            <div class="stat-sub">카카오·네이버·구글</div>
            <div class="stat-icon">🔗</div>
        </div>
        <div class="stat-card blue">
            <div class="stat-label">대기 문의</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.pendingInquiries}" pattern="#,###"/></div>
            <div class="stat-sub">전체 문의 ${stats.totalInquiries}건</div>
            <div class="stat-icon">📩</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">서비스 개요</div>
        </div>
        <div class="adm-card-body">
            <div class="stat-grid" style="margin-bottom:0;">
                <div class="stat-card">
                    <div class="stat-label">커뮤니티 게시글</div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.totalCommunityPosts}" pattern="#,###"/></div>
                    <div class="stat-sub">활성 ${stats.activeCommunityPosts}건</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">활성 신고</div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.activeReports}" pattern="#,###"/></div>
                    <div class="stat-sub">콘텐츠 검토 필요</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">완료 문의</div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.completedInquiries}" pattern="#,###"/></div>
                    <div class="stat-sub">응답 처리 완료</div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">소셜 연동 현황</div>
        </div>
        <div class="adm-card-body">
            <div style="display:flex;gap:20px;flex-wrap:wrap;">
                <div class="social-card" style="flex:1;min-width:120px;text-align:center;padding:16px;border-radius:10px;">
                    <div style="font-size:24px;margin-bottom:8px;">🟡</div>
                    <div class="social-card-value" style="font-size:22px;font-weight:700;"><fmt:formatNumber value="${stats.kakaoLinked}" pattern="#,###"/></div>
                    <div style="font-size:11px;color:#64748b;margin-top:4px;">카카오</div>
                </div>
                <div class="social-card" style="flex:1;min-width:120px;text-align:center;padding:16px;border-radius:10px;">
                    <div style="font-size:24px;margin-bottom:8px;color:#03c75a;font-weight:900;">N</div>
                    <div class="social-card-value" style="font-size:22px;font-weight:700;"><fmt:formatNumber value="${stats.naverLinked}" pattern="#,###"/></div>
                    <div style="font-size:11px;color:#64748b;margin-top:4px;">네이버</div>
                </div>
                <div class="social-card" style="flex:1;min-width:120px;text-align:center;padding:16px;border-radius:10px;">
                    <div style="font-size:24px;margin-bottom:8px;color:#4285f4;font-weight:900;">G</div>
                    <div class="social-card-value" style="font-size:22px;font-weight:700;"><fmt:formatNumber value="${stats.googleLinked}" pattern="#,###"/></div>
                    <div style="font-size:11px;color:#64748b;margin-top:4px;">Google</div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">빠른 이동</div>
        </div>
        <div class="adm-card-body" style="display:flex;gap:12px;flex-wrap:wrap;">
            <a href="${pageContext.request.contextPath}/admin/members" class="adm-btn adm-btn-primary">👥 회원 관리</a>
            <a href="${pageContext.request.contextPath}/admin/logins?success=FAIL" class="adm-btn adm-btn-ghost">🔐 로그인 실패 보기</a>
            <a href="${pageContext.request.contextPath}/admin/inquiries?status=PENDING" class="adm-btn adm-btn-ghost">📩 대기 문의 보기</a>
        </div>
    </div>
</div>

<%@ include file="layout-close.jsp" %>
