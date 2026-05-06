<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_members_none" code="admin.members.none"/>
<spring:message var="msg_admin_blocks_individualRule" code="admin.blocks.individualRule"/>
<spring:message var="msg_admin_common_settings" code="admin.common.settings"/>
<spring:message var="msg_admin_common_history" code="admin.common.history"/>
<spring:message var="msg_admin_blocks_ruleOff" code="admin.blocks.ruleOff"/>
<spring:message var="msg_admin_blocks_ruleOn" code="admin.blocks.ruleOn"/>
<spring:message var="msg_admin_blocks_returnToBatch" code="admin.blocks.returnToBatch"/>
<%@ include file="_ipRuleRowsOnly.jspf" %>
<!--IPRULE-FRAGMENT-SPLIT-->
<%@ include file="_ipRuleDetailsOnly.jspf" %>
