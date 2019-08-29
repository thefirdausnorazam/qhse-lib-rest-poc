<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" var="year"/>
<div class="printCopyright"><fmt:message key="printCopyright"><fmt:param value="${year}" /></fmt:message></div>