<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
 jQuery(document).ready(function() {		
		jQuery('#estimatedWeightUnit').select2({width:'200px'});
});
 </script>
<title><fmt:message key="wasteConsignmentItemEdit" /></title>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="wasteConsignmentItemEdit" /></h2> --%>
<!-- </div> -->
<div class="content">
<form method="post"><spring:nestedPath path="command">
<!-- <div class="header"> -->
<%-- <h3><fmt:message key="wasteConsignmentItem" /></h3> --%>
<!-- </div> -->
<div class="content">
<div class="table-responsive">
<div class="panel">

	<table class="table table-bordered table-responsive">
		<col  />

		
		<tbody>
			<tr class="form-group">
				<td class="editLabel"><fmt:message key="id" />:</td>
				<td class="search"><c:out value="${command.id}" /></td>
			</tr>
			<tr class="form-group">
				<td class="editLabel"><fmt:message key="type" />:</td>
				<td class="search"><c:out value="${command.type.description}" /></td>
			</tr>
			<tr class="form-group">
			<td class="editLabel"><fmt:message key="estimatedWeight" />:</td>
			<td class="search"><spring:bind path="estimatedWeightAmount">
			  	<input id="estimatedWeight" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>"/>
		        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      		</spring:bind>
      		<spring:bind path="estimatedWeightUnit">
                    <select name="estimatedWeightUnit" id="estimatedWeightUnit">
                      <option value="">Choose</option>
                      <c:forEach items="${units}" var="unit">
                        <option value="<c:out value="${unit.id}" />"
                          <c:if test="${unit.id == status.value}">selected="selected"</c:if>><c:out
                          value="${unit.name}" /></option>
                      </c:forEach>
                    </select>
                    <div class="errorMessage"><c:out value="${status.errorMessage}" /></div>
                  </spring:bind>
			</td>
				
			</tr>
			<tr class="form-group">
				<td class="editLabel"><fmt:message key="containerQuantity" />:</td>
				<td class="search"><c:out value="${command.containerQuantity}" /></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2" align="center">
				<button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
</div>
</div>
</spring:nestedPath></form>
</div>
</body>
</html>
