<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>

<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<title></title>
</head>
  	<script type="text/javascript" src="<c:url value="/js/moveSite.js" />"></script>  
	<script type="text/javascript">
		jQuery(document).ready(function() {
		    jQuery(".pageSize").val('${defaultPageSize}');
			jQuery('.queryFormSites').each(function (){
				jQuery(this).submit();
			});
			
		} );
	</script>
<body>
<common:moveSite recordType="action"/>

<div class="header">
<h3><fmt:message key="overdueActionsForCompletion"/>  </h3>
</div>
<div class="content"> 
	<div class="panel">
    	<form method="post" class="form-horizontal group-border-dashed queryFormSites" action="<c:url value="/incident/overdueActionsResult.jsp" />" onsubmit="return search(this, 'resultsDivSites');">
		  	<input type="hidden"  name="calculateTotals"value="true" />
			<input type="hidden"  name="pageNumber" value="1"/>
 			<input type="hidden"  class="pageSize" name="pageSize"/>
    		<div id="resultsDivSites"></div>
    	</form>
	</div>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="header">
<h3><fmt:message key="overdueActionsForVerification"/></h3>
</div>
<div class="content"> 
	<div class="panel">
	    <form method="post" class="form-horizontal group-border-dashed queryFormSites" action="<c:url value="/incident/overdueActionsForVerificationResult.jsp" />" onsubmit="return search(this, 'resultsDivVerificationSites');">
		  	<input type="hidden"  name="calculateTotals"value="true" />
			<input type="hidden"  name="pageNumber" value="1"/>
 			<input type="hidden"  class="pageSize" name="pageSize"/>
    		<div id="resultsDivVerificationSites"></div>
    	</form>
	</div>
</div>
</div>
</div>
<div class="header">
<h3><fmt:message key="overdueTasks"/></h3>
</div>
<div class="content"> 
<div class="table-responsive">
	<div class="panel"> 
		<form method="post" class="form-horizontal group-border-dashed queryFormSites" action="<c:url value="/incident/overdueActionTasksResult.jsp" />" onsubmit="return search(this, 'overdueActionTasksResult');">
		  	<input type="hidden"  name="calculateTotals"value="true" />
			<input type="hidden"  name="pageNumber" value="1"/>
 			<input type="hidden"  class="pageSize" name="pageSize"/>
    		<div id="overdueActionTasksResult"></div>
    	</form>
	</div>
</div>
</div>
</body>
</html>