<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message code="admin.common.history" var="adminBlocksHistoryLabel"/>
<%@ include file="_userBlockRowsOnly.jspf" %>
<!--USERBLOCK-FRAGMENT-SPLIT-->
<%@ include file="_userBlockDetailsOnly.jspf" %>
