<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<style type="text/css">
	#fontColorChanged a {
		color:#13ab94 !important;
	}
	table {
		border-bottom: 1px solid #DDDDDF !important;
		border-left: 1px solid #DDDDDF !important;
		border-right: 1px solid #DDDDDF !important;
	}
	</style>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTables();
	} );
</script>
</head>
<body>
<div class="col-md-12 col-sm-12 pull-right">
					<div align="right">
					<input type="text" id="refreshCheck" value="no" style="display: none;">
					<form action="<c:url value="/audit/programmeTypeEdit.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
						<div id="fontColorChanged">
							<c:forEach items="${urls}" var="urlModel">
								<button type="button" class="g-btn g-btn--primary" onclick="location.href='${urlModel.url}'"><i class="fa fa-edit" style="color: white"></i>&nbsp;<fmt:message key="${urlModel.name}"/></button>
							</c:forEach>
						</div>
					</form>
					</div>
				</div>
	
	
	
<div id="block" class="block" >
<div class="header nowrap">
<h2><fmt:message key="programmeTypeList" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-responsive table-bordered dataTable">
<thead>	
	<tr>
		<th><fmt:message key="name" /></th>
		<th><fmt:message key="expressQuestionGroup" /></th>
		<th><fmt:message key="active" /></th>
	</tr>
</thead>

<tbody>
<c:forEach items="${types}" var="type" varStatus="s">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}">
			<c:set var="style" value="even" />
		</c:when>
		<c:otherwise>
			<c:set var="style" value="odd" />
		</c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td><a href="<c:url value="programmeTypeView.htm"><c:param name="id" value="${type.id}"/></c:url>" ><c:out value="${type.name}" /></a></td>
		<td><c:if test="${type.expressQuestionGroup==null}"><fmt:message key="programmeType.nullExpressQuestionGroup"/></c:if><c:out value="${type.expressQuestionGroup.name}" /></td>
		<td><fmt:message key="${type.active}" /></td>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>
</div>

</div>
</body>
</html>
