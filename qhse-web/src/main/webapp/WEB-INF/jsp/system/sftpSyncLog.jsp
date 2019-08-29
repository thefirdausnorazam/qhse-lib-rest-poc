<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
	<script type='text/javascript' src="<c:url value="/js/common.js"/>"></script>
	<script type='text/javascript' src="<c:url value="/js/css.js"/>"></script>
	<script type='text/javascript' src="<c:url value="/js/standardista-table-sorting.js"/>"></script>
	 <script type="text/javascript">
 function getException(id){
	 var exceptionId = id;
 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "syncSftpLogExceptionId.json",
		  data: 'id='+exceptionId,
		  success: function(data){
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append(data.value);
 			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
 			  
           
		  }
		}); 
 }
 </script>
</head>

<body>
<div class="header">
<h2><fmt:message key="sftp.SyncLog" />: <c:out value="${domain.name}" /></h2>
</div>
<a name="user"></a>
<div style="padding-top: 1%;">
<scannell:url urls="${urls}" />
</div>
<div class="content">
<div class="table-responsive">
<c:if test="${not empty sftpConfig}">
<div class="panel">
<table class='table table-responsive table-bordered sortable'>
		<th><fmt:message key="admin.sftp.host" /></th><td><c:out value="${sftpConfig.host}"/><td>
		<th><fmt:message key="admin.sftp.user" /></th><td><c:out value="${sftpConfig.user}"/><td>
		<th><fmt:message key="admin.sftp.port" /></th><td><c:out value="${sftpConfig.port}"/><td>
		<th><fmt:message key="admin.sftp.fileName" /></th><td><c:out value="${sftpConfig.fileName}"/><td>
	</tr>
</table>
</div>
</c:if>
<div class="panel">
<table class='table table-responsive table-bordered sortable'>
<thead>
	<%-- <tr><td colspan="10"><scannell:url urls="${urls}" /></td></tr> --%>
	<tr>	
		<th><fmt:message key="userDomain.synchronisedBy" /></th>
		<th><fmt:message key="sftp.synchronised" /></th>
		<th><fmt:message key="successful" /></th>
		<th><fmt:message key="admin.sftp.fileName" /></th>
		<th><fmt:message key="admin.sftp.Exceptions" /></th>
	</tr>
</thead>

<tbody>
	<c:forEach items="${sftpLog}" var="log" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}">
				<c:set var="style" value="even" />
			</c:when>
			<c:otherwise>
				<c:set var="style" value="odd" />
			</c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><c:out value="${log.createdByUser.displayName}" /></td>
			<td><fmt:formatDate value="${log.createdTs}" pattern="dd-MMM-yyyy HH:mm"  /></td>
			<td <c:if test="${not log.success}"> bgcolor="#ffe6e6"</c:if> <c:if test="${log.success}"> bgcolor="#e6fff8"</c:if>><fmt:message key="${log.success}" /></td>
			<td><c:out value="${log.fileName}"/></td>
			<td style="height: 100px"><div style="height: 100%;overflow: auto;margin: 0;padding: 0">
				<c:out value="${log.exceptions}"/>
				</div>
			</td>
		</tr>
	</c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</body>
</html>
