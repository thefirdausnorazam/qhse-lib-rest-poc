<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<!--<meta name="printable" content="true">-->
	<title></title>
<style type="text/css">
th.searchLabel {
width:36%;
}
</style>
</head>

 <script type="text/javascript"> 
 jQuery(document).ready(function () {	 
	 jQuery('#queryForm').submit();
	 jQuery('#online').select2({width:'40%'});
	 jQuery('#active').select2({width:'40%'});
	 jQuery('#sortName').select2({width:'40%'});
	 jQuery('#userDomain').select2({width:'40%'});
		
	 
	 toggleQueryDiv();
	});
 
 function clearUserForm() {
	 jQuery("#online").select2('val',
				jQuery('#online option:eq(0)').val());
	 jQuery("#active").select2('val',
				jQuery('#active option:eq(0)').val());
 }
 </script>
<body>
<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12">
					<div align="right">
					<input type="text" id="refreshCheck" value="no" style="display: none;">
					<form action="<c:url value="/system/userView.htm" />" method="get"
						onSubmit="if(!jQuery('#gotoId')) return false;">
						<fmt:message key="wasp.searchUsersForm.goTo"/>
						<input type="text" id="gotoId" name="id" size="3">
						<input type="submit" class="g-btn g-btn--primary" value="Go">
						<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;Hide
							<fmt:message key="search.displaySearch" />
						</button>
						<c:if test="${addButtonEnabled == true }">
							<button type="button" class="g-btn g-btn--primary" onclick="location.href='userEdit.htm'">
								<i class="fa fa-edit" style="color: white"></i>
								<fmt:message key="userCreate" />
							</button>
						</c:if>
						<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					</form>
</div>
					
				</div>
			</div>
    	</div>
	</div>

<form id="queryForm" action="<c:url value="/system/userQuery.htmf" />" onSubmit="return search(this, 'resultsDiv');">
	<input type="hidden" name="calculateTotals" value="true" />
	<input type="hidden" name="pageNumber" value="1" />
	<input type="hidden" id="pageSize" name="pageSize" />

<div id="queryDiv">
<div class="header">
<h3><fmt:message key="userQueryForm" /></h3>
</div>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-responsive table-bordered" id="queryTable">
<tbody id="searchCriteria">
	<tr class="form-group">
		<th class="searchLabel"><fmt:message key="userName" />:</th>
		<td class="search">
			<input type="text" name="username" class="form-control" style="width:40%"/>
		</td>
		
	</tr>
	<tr class="form-group">
		<th class="searchLabel"><fmt:message key="online" />:</th>
		<td  class="search">
			<select name="online" id="online">
				 <option value="">choose</option>
				<option value="true"><fmt:message key="true"  /></option>
				<option value="false"><fmt:message key="false" /></option>
			</select>
		</td>
	</tr>
	<tr class="form-group">
	   <th class="searchLabel"><fmt:message key="active" />:</th>
		<td  class="search">
			<select name="active" id="active" class="narrow">
				<option value="">choose</option>
				<option value="true" selected="selected"><fmt:message key="true"  /></option>
				<option value="false"><fmt:message key="false" /></option>
			</select>
		</td>
	</tr>
	<tr class="form-group">
	   <th class="searchLabel"><fmt:message key="userDomain" />:</th>
		<td  class="search">
			<select id="userDomain" name="userDomain" style="width: 100%;">
				<option value=""><fmt:message key="choose"  /></option>
				<c:forEach items="${domains}" var="item">
					<option value="<c:out value="${item.id}" />">${item.name}</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr class="form-group">
	   <th class="searchLabel"><fmt:message key="sortName" />:</th>
		<td  class="search">
			<select id="sortName" name="sortName" style="width: 100%;">
				<c:forEach items="${sorts}" var="item">
					<option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
				</c:forEach>
			</select>
		</td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="4" style="text-align:center;">
			<button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1; toggleQueryDiv();"><fmt:message key="search" /></button>
			<button type="reset" class="g-btn g-btn--secondary" onclick="clearUserForm()"><fmt:message key="reset" /></button>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</div>
<div id="resultsDiv"></div>

</form>
</body>
</html>
