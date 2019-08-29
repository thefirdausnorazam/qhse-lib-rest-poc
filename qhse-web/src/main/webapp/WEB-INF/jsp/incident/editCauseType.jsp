<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<style type="text/css">
td.searchLabel {
padding-left: 0px !important;
padding-right: 5%!important;
width:45%!important;
}
</style>
	<c:set var="title" value="editCauseType" />
	<c:if test="${command['new']}"><c:set var="title" value="addCauseType" /></c:if>
	<title><fmt:message key="${title}" /></title>
	<script type="text/javascript" >
		jQuery(document).ready(function() {	 
			jQuery('#category').select2();
		});
		function toggle(source) {
		  checkboxes = document.getElementsByName('activeInSites');
		  for(var i=0, n=checkboxes.length;i<n;i++) {
			    checkboxes[i].checked = source.checked;
			  }

		}

</script>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<spring:hasBindErrors name="command">
	<div class="errorMessage"><fmt:message key="errors.global" /></div>
	<br />
	<spring:bind path="command">
		<div class="errorMessage"><c:out value="${status.errorMessage}" /></div>
		<br />
	</spring:bind>
</spring:hasBindErrors>

<form method="post">
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col  />
<tbody>
<spring:nestedPath path="command">
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="name" />:</td>
		<td class="search">
			<spring:bind path="name">
				<input type="text" class="form-control" style="float:left;width:80%" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}" />" maxlength="250" />
				<span class="requiredHinted">*</span>
				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
			</spring:bind>
			<spring:bind path="id">
				<input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
			</spring:bind>
			<spring:bind path="version">
				<input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
			</spring:bind>
		</td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="category" /></td>
		<td class="search">
			<spring:bind path="category">
				<select  id="category" name="<c:out value="${status.expression}"/>" style="width:300px;">
					<option value=""><fmt:message key="blankChoose" /></option>
					<c:forEach items="${categories}" var="item">
					<option value="<c:out value="${item.name}" />"
					<c:if test="${item.name == status.value}">selected="selected"</c:if>><fmt:message key="${item}" /></option>
					</c:forEach>
				</select>
				<span class="requiredHinted">*</span>
				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
			</spring:bind>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="active" /></td>
		<td class="search">
			<spring:bind path="active">
			<input type="hidden" name="<c:out value="_${status.expression}"/>" />
			<input type="checkbox" name="<c:out value="${status.expression}"/>" <c:if test="${status.value}">checked="checked"</c:if> />
			<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
			</spring:bind>
	</tr>
	 <tr class="form-group">
	 <td  class="searchLabel"><fmt:message key="template.selectAll"/>:</td><td class="search"><input type="checkbox" onClick="toggle(this)" /></td></tr>
	  <tr class="form-group">
	    	 <td class="searchLabel"><fmt:message key="template.sites"/>:</td>
		      <td class="search">
		      <input type="hidden" name="_activeInSites" value="xxx" />
				<spring:bind path="activeInSites">
						<c:forEach items="${sites}" var="site">
							<c:set var="selected" value="${false}" />
							<c:forEach items="${command.activeInSites}" var="selectedSite">
								<c:if test="${site.id == selectedSite.id}"><c:set var="selected" value="${true}" /></c:if>
							</c:forEach>
							<c:set var="enabled" value="${false}" />
							<c:forEach items="${userSites}" var="enabledSite">
								<c:if test="${site.id == enabledSite.id}"><c:set var="enabled" value="${true}" /></c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${enabled}">
									<input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${site.id}" />" <c:if test="${selected}">checked="checked"</c:if>/><span><c:out value="${site.name}" /></span><br />
								</c:when>
								<c:otherwise>
									<input type="checkbox" name="x" <c:if test="${selected}">checked="checked"</c:if> disabled="disabled"/><span><c:out value="${site.name}" /></span><br />
									<c:if test="${selected}">
										<input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${site.id}" />" />
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
				</spring:bind>
		      </td>
	    </tr>
</spring:nestedPath>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"> <button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</form>

</body>
</html>
