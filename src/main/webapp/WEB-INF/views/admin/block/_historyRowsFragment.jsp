<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message code="admin.members.none" var="adminBlocksNoneLabel"/>
<%@ include file="_historyRowsOnly.jspf" %>
<!--HISTORY-FRAGMENT-SPLIT-->
<%@ include file="_historyDetailsOnly.jspf" %>
