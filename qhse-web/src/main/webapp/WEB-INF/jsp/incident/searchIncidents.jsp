<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="searchIncidents" /></title> 
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
	
	if('${searchByLegacyId}' == 'true'){
		if('${fn:length(result.results)}' == '1'){
			location.href = '${pageContext.request.contextPath}' + '/incident/viewIncident.htm?id=${result.results[0].id}';
		}
	}
</script>
<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >8</c:when> 
	  <c:otherwise>7</c:otherwise> 
	</c:choose> 
</c:set>
<c:if test="${showLegacyId}"><c:set var="colspan" value="${colspan + 1}" /></c:if>
<c:set var="found" value="${!empty result.results}" />
<div class="header">
<h3><fmt:message key="incidents" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel"> 
<div class="table-responsive">
        <c:if test="${found}">
          <div class="div-for-pagination" ><scannell:paging result="${result}" /></div>
        </c:if>
<table class="table table-bordered  table-responsive dataTable">
  <thead>   
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="type" /></th>
      <th><fmt:message key="status" /></th>
      <th><fmt:message key="description" /></th>
      <th><fmt:message key="occurredDate" /></th>
      <th><fmt:message key="department" /></th>
      <c:if test="${!empty summaryList}">
        <c:forEach var="summaryItem" items="${summaryList}" varStatus="s">
			<c:if test="${summaryItem == 'severity'}">
      			<th><fmt:message key="severity" /></th>
			</c:if>
			<c:if test="${summaryItem == 'location'}">
      			<th><fmt:message key="location" /></th>
			</c:if>
		</c:forEach>
	  </c:if>
      <th><fmt:message key="assignees" /></th>
	  <c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
	   <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
    </tr>
  </thead>

  <tbody>
  
    <c:forEach items="${result.results}" var="incident" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="viewIncident.htm"><c:param name="id" value="${incident.id}"/></c:url>" ><c:out value="${incident.id}" /></a></td>
        <td><fmt:message key="${incident.type.type.key}" /> : <c:out value="${incident.type.name}" /></td>
        <td><fmt:message key="${incident.status.name}" /></td>
        <td><c:choose>
	        	<c:when test="${incident.confidential}">
	        		<c:choose>
	        			<c:when test="${incident.type.type.confidentialDescription && !confidentialRight}">
	        				<font color="red"><c:out value="CONFIDENTIAL"/></font>
	        			</c:when>
	        			<c:otherwise>
	        			<c:if test="${incident.type.type.confidentialDescription && confidentialRight}"></c:if>
	        				<c:out value="${incident.description}" />
	        			</c:otherwise>
	        		</c:choose>
	        	</c:when>
	        	<c:otherwise>
	        		<c:out value="${incident.description}" />
	        	</c:otherwise>
        	</c:choose>
        </td>
        <td><fmt:formatDate value="${incident.occurredTime}" pattern="dd-MMM-yyyy" /></td>
        <td><c:out value="${incident.department.name}" /></td>     
        <c:if test="${!empty summaryList}">
	        <c:forEach var="summaryItem" items="${summaryList}" varStatus="s">
				<c:if test="${summaryItem == 'severity'}">
					<td>
			        	<c:if test="${incident.severity == null}"><fmt:message key="none" /></c:if>
			        	<c:if test="${incident.severity != null}"><fmt:message key="${incident.severity}" /></c:if>
			        </td>
				</c:if>
				<c:if test="${summaryItem == 'location'}">
			        <td>
				        <c:if test="${incident.equipmentLocation != null}">
				        	<c:out value="${incident.equipmentLocation.name}" />
				        </c:if>
				        <c:if test="${incident.equipmentLocation == null && incident.location != 'default location'}">
				        	<c:out value="${incident.location}" />
				        </c:if>
			        </td>
				</c:if>
			</c:forEach>
		</c:if>
        <td>
	      <c:forEach items="${incident.assignees}" var="item">
	        <c:out value="${item.displayName}" /><br />
	      </c:forEach>
        </td>
        <c:if test="${showSiteColumn}">
        	<td><c:out value="${incident.site.name}" /></td>
        </c:if>
       <c:if test="${showLegacyId}">
       		<td> <c:out value="${incident.legacyId}" /> </td>
     	</c:if>
      </tr>
    </c:forEach>
    
  </tbody>
  <tfoot>    
    <c:if test="${found}">
    <tr>
      <td colspan="${colspan}"> 
        <scannell:paging result="${result}" />
      </td>
    </tr>
    </c:if>
  </tfoot>
    
</table>
</div>
</div>
</div>
</div>
</body>
</html>
