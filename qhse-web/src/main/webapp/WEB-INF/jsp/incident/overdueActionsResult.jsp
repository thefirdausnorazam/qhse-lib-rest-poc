<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
</head>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			jQuery('.recordsPerPage').find("select").select2();
			initSortTablesForClass('dataTableA');
		} );
	</script>
<body>
<div class="content"> 
<div class="panel">
    <c:if test="${!empty result.results}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
    </c:if>    
	    <table id="overdueActionsForCompletion" class="table table-responsive table-bordered dataTableA" >
		  <thead>   
		    <tr>
		      <th><fmt:message key="id"/></th>
		      <th style="width:10%"><fmt:message key="type"/></th>
		      <th style="width:40%"><fmt:message key="description"/></th>
		      <th style="width:10%"><fmt:message key="responsibleUser"/></th>
		      <th style="width:10%"><fmt:message key="completionTargetDate"/></th>
		      <th style="width:10%"><fmt:message key="site"/></th>
		    </tr>  
		  </thead>
		  <tbody>
		    <c:forEach items="${result.results}" var="action" varStatus="s"><!--  completionOverdueActions -->
		         <tr>
		           <td><a
		              onclick='changeSite("<c:url value="viewAction.htm"><c:param name="id" value="${action.id}"/></c:url>", ${action.site.id}, "${action.site}", ${currentSite})' href="#" >
						<c:out value="${action.id}" /></a></td>
		           <td><fmt:message key="${action['class'].name}" /></td>  
		           <td><div><c:out value="${action.description}" /></div></td>
		           <td><c:out value="${action.responsibleUser.displayName}" /></td>
		           <td><fmt:formatDate value="${action.completionTargetDate}" pattern="dd-MMM-yyyy"/></td>
		           <td><c:out value="${action.site}" /></td>
		         </tr>
		         
		    </c:forEach>
   </tbody>
</table>
   
</div>
</div>

</body>
</html>