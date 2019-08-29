<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="incident" tagdir="/WEB-INF/tags/incident" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="searchActions" /></title>
<link rel="stylesheet"
	href="<scannell:resource value="/css/jquery-ui.css" />">
 <style type="text/css">
/*  .datatable_wrapper
{
	border:1px  #983060;
}
.fa-sort-amount-asc:before {
  content: "\f160";
  color: #92007B;
}
tr.odd.selected{background-color:#acbad4} */
 </style>
 
   </head>
<body>

<script type="text/javascript">
	jQuery(document).ready(function() {
			initSortTables();
	} );
	
	if('${searchByLegacyId}' == 'true'){
		if('${fn:length(result.results)}' == '1'){
			location.href = '${pageContext.request.contextPath}' + '/incident/viewAction.htm?id=${result.results[0].id}';
		}
	}
</script>

<c:set var="colspan">
	<c:choose> 
	  <c:when test="${showSiteColumn}" >10</c:when> 
	  <c:otherwise>9</c:otherwise> 
	</c:choose> 
</c:set>
<c:if test="${showLegacyId}"><c:set var="colspan" value="${colspan + 1}" /></c:if>
<c:set var="found" value="${!empty result.results}" />
<div class="header" style="border-bottom: 2px solid #13ab94;padding-bottom: 12px;">
<h3><fmt:message key="actions" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
        <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
        </c:if>
<table id="datatable" aria-describedby="datatable_info" class="table table-bordered dataTable  table-responsive dataTable">

  <thead>    
    <tr role="row">
      <th aria-label="ID: activate to sort column descending" aria-sort="ascending"  colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc"><fmt:message key="id" /></th>
      <th aria-label="Type: activate to sort column descending" aria-sort="ascending" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc"><fmt:message key="type" /></th>
      <th  aria-label="Status: activate to sort column descending" aria-sort="ascending" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc"><fmt:message key="status" /></th>
      <th  aria-label="Description: activate to sort column descending" aria-sort="ascending" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc"><fmt:message key="description" /></th>
      <th  aria-label="User Responsible: activate to sort column descending" aria-sort="ascending"  colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc"><fmt:message key="responsibleUser" /></th>
      <th  aria-label="Department: activate to sort column descending" aria-sort="ascending"  colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc"><fmt:message key="department" /></th>
      <th  aria-label="Target Completion Date: activate to sort column descending" aria-sort="ascending" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc"><fmt:message key="targetCompletionDate" /></th>
      <th  aria-label="Associated With: activate to sort column descending" aria-sort="ascending"  colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc"><fmt:message key="associatedWith" /></th>
      <th  aria-label="Created By: activate to sort column descending" aria-sort="ascending" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc"><fmt:message key="createdBy" /></th>
      <c:if test="${showSiteColumn}">
      	<th  aria-label="Site: activate to sort column descending" aria-sort="ascending" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc"><fmt:message key="site" /></th>
      </c:if>
      <c:if test="${showLegacyId}"><th><fmt:message key="legacyId" /></th></c:if>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${result.results}" var="action" varStatus="s">
      <tr>
      
        <td class="numeric"><a class="datatable-nosort" href="<c:url value="viewAction.htm"><c:param name="id" value="${action.id}"/></c:url>" ><c:out value="${action.id}" /></a></td>
        <td><fmt:message key="${action['class'].name}" /></td>
        <td>
        	<c:choose>
    			<c:when test="${action.trash}"><fmt:message key="trash" /></c:when>
    			<c:otherwise> <fmt:message key="${action.statusCode}" /></c:otherwise>
   		 	</c:choose>
        </td>
        <td><c:out value="${action.description}" /></td>
        <td><c:out value="${action.responsibleUser.displayName}" /></td>
        <td><c:out value="${action.responsibleDepartment.name}" /></td>
        <td><fmt:formatDate value="${action.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
        
        <td>
        	<c:if test="${action.type == 'prevent'}" >
			    <c:forEach items="${action.justifications}" var="item">
			    	<a href="<c:url value="viewJustification.htm"><c:param name="id" value="${item.id}" /></c:url>">
			        <fmt:message key="${item['class'].name}" /></a> [<scannell:text value="${item.id}" />] - <scannell:text value="${item.description}" />
			      	<br>
			    </c:forEach>
			</c:if>
        	<c:forEach var="holder" items="${action.holders}" >
        		<scannell:entityUrl entity="${holder.owner}"/> <c:out value="[ID-${holder.owner.id}]" /> <incident:actionHolderDescription holder="${holder}" />
        	</c:forEach>
        </td>
        <td><c:out value="${action.createdByUser.displayName}" /></td>
        <c:if test="${showSiteColumn}">
        	<td><c:out value="${action.site.name}" /></td>
        </c:if>
        <c:if test="${showLegacyId}">
       		<td> <c:out value="${action.legacyId}" /> </td>
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
