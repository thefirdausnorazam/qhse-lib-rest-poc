<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
<script type="text/javascript">

	jQuery(document).ready(function() {
	if(${group.active}){
		jQuery("input[name*='active']").attr('checked', true); 
	}else{
		jQuery("input[name*='active']").attr('checked', false);
	}
	
	jQuery("input[name*='active']").click(function() {
	    if(! jQuery(this).is(":checked")) {
	    	jQuery("#questionList").fadeIn(1000);
	    } else {
	    	jQuery("#questionList").fadeOut(1000);
	    }
	});
	});
	
</script>
</head>
<body>
<div class="header">
<h2><fmt:message key="group.GroupView" /></h2>
</div>
<div class="content">
<div class="header nowrap">
<h3><fmt:message key="group.title" /></h3>
</div>
<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-responsive table-bordered">     
    <tbody>
      <tr class="form-group">
        <td class="searchLabel"><fmt:message key="id" /></td>
        <td class="search"><c:out value="${group.id}" /></td>
      </tr>
	        <tr class="form-group">
        <td class="searchLabel"><fmt:message key="name" /></td>
        <td class="search"><input type="text" name="name" class="form-control" style="float:left;width:60%" maxlength="249" value = "${group.name}"><br></td>
      </tr>
	        <tr class="form-group">
        <td class="searchLabel"><fmt:message key="active" /></td>
        <td class="search"><scannell:checkbox path="active" cssStyle="float:left;width:20%" value="${group.active}" /></td>
      </tr>
	        <tr class="form-group">
        <td class="searchLabel"><fmt:message key="createdBy" /></td>
        <td class="search"><c:out value="${group.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${group.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
      </tr>
	  <c:if test="${group.lastUpdatedByUser.displayName != null}">
	        <tr class="form-group">
        <td class="searchLabel"><fmt:message key="lastUpdatedBy" /></td>
        <td class="search"><c:out value="${group.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${group.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
      </tr>
	  </c:if>
    </tbody>
    <tfoot>
      <tr>
        <td colspan="2" align="center">
			<input type="submit" id="form_submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
		</td>
      </tr>
    </tfoot>
  </table>
</div>
</div>
</div>

<div id="questionList" style="display: none;">
<div class="header">
<h3><fmt:message key="questions.title" /> <span style="color:red">(<fmt:message key="question.group.message" />)</span></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<thead>	
	<tr>
		<th><fmt:message key="question" /></th>
		<th><fmt:message key="additionalInfo" /></th>
		<th><fmt:message key="active" /></th>
	</tr>
		<c:forEach items="${questions}" var="question" varStatus="s">
		<c:if test="${question.active == true}">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><a href="<c:url value="templateQuestionView.htm"><c:param name="id" value="${question.id}" /></c:url>"><c:out value="${question.name}" /></a></td>
			<td><c:out value="${question.additionalInfo}" /></td>
			<td><fmt:message key="${question.active}" /></td>
		</tr>
		</c:if>
	</c:forEach>
</thead>
<tbody>
</tbody>
</table>
</div>
</div>
</div>
</div>
</scannell:form>
</div>
</body>
</html>
