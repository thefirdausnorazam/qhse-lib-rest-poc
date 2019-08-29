<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags" %>

<html>
<head>
  	<title><fmt:message key="configureTemplateSites"/></title>
	<script type="text/javascript">
		function toggle(source) {
		  checkboxes = document.getElementsByName('activeInSites');
		  for(var i=0, n=checkboxes.length;i<n;i++) {
			    checkboxes[i].checked = source.checked;
			  }

		}
   	</script>
</head>

<body>

<scannell:form>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive">
    <col class="label"/>
    <tbody>

    <tr class="form-group">
      <td class="searchLabel" style="width: 50%"><fmt:message key="changeTemplateTitle"/>:</td>
      <td class="search"><scannell:text value="${command.template.name}" /></td>
    </tr>
	<tr class="form-group">
		<td class="searchLabel">
			<fmt:message key="template.selectAll"/>:
		</td>
		<td class="search">
			<input type="checkbox" onClick="toggle(this)" />
		</td>
	</tr>
    <tr class="form-group">
    	 <td class="searchLabel"><fmt:message key="template.sites"/>:</td>
	      <td class="search">
	      <input type="hidden" name="_activeInSites" value="xxx" />
			<spring:bind path="command.activeInSites">
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
    </tbody>
    <tfoot>
    <tr>
      <td colspan="3" align="center"><input type="submit" value="<fmt:message key="submit" />"  class="g-btn g-btn--primary"></td>
    </tr>
    </tfoot>
  </table>

</div>
</div>
</scannell:form>

</body>
</html>
