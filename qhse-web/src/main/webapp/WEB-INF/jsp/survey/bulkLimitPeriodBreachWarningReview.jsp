<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	
<script type="text/javascript">
jQuery(document).ready(function() {
	initSortTables();
  jQuery('#bulkSelect').change(function() {
    if(jQuery('#bulkSelect').attr('checked')) {
      jQuery('input:checkbox').attr('checked','checked');
    } else {
      jQuery('input:checkbox').removeAttr('checked');      
    }
  });
});
</script>
	
</head>
<body>
<div class="header">
<h2> <fmt:message key="bulkLimitPeriodBreachWarningReview" /> </h2>
</div>
<scannell:form>
<div class="header">
<h2> <fmt:message key="myLimitBreacheWarnings" /> </h2>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive dataTable">
 <thead>
   
   <tr>
     <th><input id="bulkSelect" type="checkbox"></th>
     <th><fmt:message key="id" /></th>
     <th><fmt:message key="quantity" /></th>
     <th><fmt:message key="measure" /></th>
     <th><fmt:message key="readingPoint" /></th>
     <th><fmt:message key="type" /></th>
     <th><fmt:message key="timePeriod" /></th>
     <th><fmt:message key="limitAmount" /></th>
     <th><fmt:message key="limitReadingValue" /></th>
     <th><fmt:message key="complianceStatus" /></th>
     <th><fmt:message key="site" /></th>
   </tr>
 </thead>

 <tbody>
   <c:forEach items="${breaches}" var="limitPeriod" varStatus="s">
     <c:choose>
       <c:when test="${s.index mod 2 == 0}">
         <c:set var="style" value="even" />
       </c:when>
       <c:otherwise>
         <c:set var="style" value="odd" />
       </c:otherwise>
     </c:choose>
     <tr class="<c:out value="${style}" />">
       <td><scannell:checkbox path="targetIds" value="${limitPeriod.id}" />
       <td><a href="<c:url value="limitPeriodView.htm"><c:param name="id" value="${limitPeriod.id}"/></c:url>" ><c:out value="${limitPeriod.id}" /></a></td>
       <td><c:out value="${limitPeriod.limit.owner.quantity.longName}" /></td>
       <td><c:out value="${limitPeriod.limit.owner.measure.measureName}" /></td>
       <td><c:out value="${limitPeriod.limit.owner.readingPoint.name}" /></td>
       <td><fmt:message key="${limitPeriod.limit.type}" /></td>
       <td><c:out value="${limitPeriod.timePeriod}" /></td>
       <td>
         <c:if test="${limitPeriod.lowerThreshold != null}"><c:out value="${limitPeriod.lowerThreshold} -> " /></c:if>
         <spring:message code="${limitPeriod.upperThreshold}" text="${limitPeriod.upperThreshold}" />
       </td>
       <td>
      <c:choose>
        <c:when test="${limitPeriod.limit.owner.rate}" >
        <fmt:message key="max" />: <span style="white-space:nowrap;"><spring:message code="${limitPeriod.upperValue}" text="${limitPeriod.upperValue}" /></span><br>
        <fmt:message key="min" />: <span style="white-space:nowrap;"><spring:message code="${limitPeriod.lowerValue}" text="${limitPeriod.lowerValue}" /></span>
        </c:when>
        <c:otherwise>
        <spring:message code="${limitPeriod.upperValue}" text="${limitPeriod.upperValue}" />
        </c:otherwise>
      </c:choose>
       </td>
       <td class="<c:out value="${limitPeriod.complianceStatus.name}" />"><fmt:message key="${limitPeriod.complianceStatus}" /></td>
       <td><c:out value="${limitPeriod.site}" /></td>
     </tr>
   </c:forEach>
  <tr>
    <td  colspan="2"><fmt:message key="comment" />:</td>
    <td colspan="9"><scannell:textarea path="comment" cols="125" rows="5" /></td>
  </tr>
</tbody>

<tfoot>
	<tr>
		<td colspan="11" align="center"><button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
