<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message var="msg_admin_blocks_pageTitle" code="admin.blocks.pageTitle"/>
<c:set var="activeMenu" value="blocks"/>
<c:set var="pageTitle" value="${msg_admin_blocks_pageTitle}"/>
<%@ include file="../layout.jsp" %>
<jsp:include page="_list_messages_01.jsp"/>
<jsp:include page="_list_messages_02.jsp"/>
<jsp:include page="_list_messages_03.jsp"/>
<jsp:include page="_list_messages_04.jsp"/>
<jsp:include page="_list_01_dashboard.jsp"/>
<jsp:include page="_list_02_user_blocks.jsp"/>
<jsp:include page="_list_03_ip_rules.jsp"/>
<jsp:include page="_list_04_batches.jsp"/>
<jsp:include page="_list_05_histories.jsp"/>
<jsp:include page="_list_06_modals.jsp"/>

<style>
    .adm-inline-link {
        border: 0;
        background: transparent;
        padding: 0;
        cursor: pointer;
        font: inherit;
        text-align: left;
    }

    .adm-inline-link:hover {
        text-decoration: underline;
    }

    .adm-link-btn {
        width: 100%;
        border: 0;
        background: transparent;
        padding: 0;
        text-align: left;
        color: inherit;
        cursor: pointer;
    }

    .adm-link-btn:hover span:first-child {
        color: #93c5fd !important;
    }

    .adm-block-tab-row {
        flex-wrap: wrap;
        gap: 8px;
    }

    .adm-local-toolbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        padding: 16px;
        border-bottom: 1px solid rgba(148, 163, 184, 0.14);
        background: rgba(15, 23, 42, 0.42);
    }

    .adm-local-toolbar-group {
        display: flex;
        align-items: center;
        gap: 8px;
        flex-wrap: wrap;
    }

    .adm-local-toolbar .adm-input {
        min-width: 240px;
    }

    .adm-local-pagination {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        padding: 14px 16px 16px;
        border-top: 1px solid rgba(148, 163, 184, 0.14);
        background: rgba(15, 23, 42, 0.42);
        font-size: 13px;
        color: #cbd5e1;
    }

    .adm-local-page-actions {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .adm-local-empty td {
        text-align: center;
        padding: 28px;
        color: #64748b;
    }

    .adm-quick-row {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
        margin-top: 10px;
    }

    .adm-chip-btn {
        border: 1px solid rgba(148, 163, 184, 0.28);
        background: #182030;
        color: #cbd5e1;
        border-radius: 6px;
        padding: 6px 10px;
        font-size: 12px;
        cursor: pointer;
    }

    .adm-chip-btn:hover {
        border-color: rgba(96, 165, 250, 0.5);
        color: #eff6ff;
    }
</style>

<jsp:include page="_list_script_01.jsp"/>
<jsp:include page="_list_script_main_01.jsp"/>
<jsp:include page="_list_script_main_02.jsp"/>
<jsp:include page="_list_script_main_03.jsp"/>
<jsp:include page="_list_script_main_04.jsp"/>
<jsp:include page="_list_script_main_05.jsp"/>
<jsp:include page="_list_script_main_06.jsp"/>

<%@ include file="../layout-close.jsp" %>

<jsp:include page="_list_script_upload.jsp"/>
