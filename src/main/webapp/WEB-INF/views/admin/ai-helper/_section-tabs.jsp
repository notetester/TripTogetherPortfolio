<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- AI 도우미 관리 섹션 최상위 탭 바 (AI 도우미 / AI 챗봇) --%>
<div class="adm-tabs adm-admin-tabs">
    <a class="adm-tab adm-tab-link ${section == 'assistant' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/admin/ai-helper">🧭 AI 도우미</a>
    <a class="adm-tab adm-tab-link ${section == 'chatbot' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/admin/ai-helper/chatbot">💬 AI 챗봇</a>
</div>
