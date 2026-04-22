<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="aiHelper"/>
<c:set var="pageTitle" value="AI 도우미 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%@ include file="_section-tabs.jsp" %>

    <div class="adm-card" style="padding:40px;text-align:center;margin-top:20px;">
        <div style="font-size:48px;margin-bottom:12px;">🧭</div>
        <div style="font-size:18px;font-weight:700;margin-bottom:8px;">AI 도우미 관리</div>
        <div style="font-size:13px;color:#64748b;line-height:1.6;max-width:560px;margin:0 auto;">
            AI 도우미 모듈(Claude 기반 여행 일정 자동 생성)의 관리 기능이 여기에 추가될 예정입니다.<br>
            현재는 <code style="padding:2px 6px;background:#f1f5f9;border-radius:4px;">claude-3-5-haiku-20241022</code> 모델을 사용하며,
            요청당 in-memory 히스토리만 관리합니다.<br><br>
            챗봇 관리 기능은 상단 <strong>AI 챗봇</strong> 탭에서 이용할 수 있습니다.
        </div>
        <div style="margin-top:24px;">
            <a class="adm-btn adm-btn-primary" href="${pageContext.request.contextPath}/admin/ai-helper/chatbot">
                AI 챗봇 관리로 이동 →
            </a>
        </div>
    </div>

    <div class="adm-card" style="padding:20px;margin-top:16px;">
        <div style="font-size:14px;font-weight:600;margin-bottom:10px;">📌 향후 추가 예정</div>
        <ul style="font-size:13px;color:#475569;line-height:1.8;padding-left:20px;margin:0;">
            <li>AI 도우미 호출 통계 (일/주/월)</li>
            <li>생성된 여행 일정 모니터링</li>
            <li>프롬프트 템플릿 관리</li>
            <li>부적절 요청 감지 및 차단</li>
        </ul>
    </div>

</div>

<%@ include file="../layout-close.jsp" %>
