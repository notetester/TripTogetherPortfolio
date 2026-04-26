<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message code="admin.members.none" var="adminBlocksNoneLabel"/>
<spring:message code="admin.blocks.individualRule" var="adminBlocksIndividualRuleLabel"/>
<spring:message code="admin.common.settings" var="adminBlocksSettingsLabel"/>
<spring:message code="admin.common.history" var="adminBlocksHistoryLabel"/>
<spring:message code="admin.blocks.ruleOff" var="adminBlocksRuleOffLabel"/>
<spring:message code="admin.blocks.ruleOn" var="adminBlocksRuleOnLabel"/>
<spring:message code="admin.blocks.returnToBatch" var="adminBlocksReturnToBatchLabel"/>
<%@ include file="_ipRuleRowsOnly.jspf" %>
<!--IPRULE-FRAGMENT-SPLIT-->
<%@ include file="_ipRuleDetailsOnly.jspf" %>
