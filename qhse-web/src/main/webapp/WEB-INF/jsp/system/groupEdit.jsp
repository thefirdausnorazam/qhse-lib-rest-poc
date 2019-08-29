<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="groupEdit" />
<c:if test="${group.id == null}">
  <c:set var="title" value="groupCreate" />
</c:if>
<title></title>
</head>
<script type="text/javascript">

jQuery(document).ready(function() {
	  jQuery('select').not('#siteLocation').select2({width: '40%'});
});
</script>
<body>
<div class="header">
<h2><fmt:message key="${title}" /></h2>
</div>
<scannell:form>
  <scannell:hidden path="id"/>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
    
    <tbody>
 	    <tr>
        <td class="searchLabel"><fmt:message key="name" /></td>
        <td class="search"><input name="name" cssStyle="float:left;width:40%" class="wide form-control" /></td>
      </tr>
 
	<c:if test="${showModules}">
      <tr>
        <td class="searchLabel"><fmt:message key="modules" />:</td>
        <td class="search">
       	  <c:set var="moduleAccessLevels" value="${licence.moduleAccessLevels}" />	
          <spring:bind path="command.modules">
          	<table class='table table-responsive table-bordered'>
              <c:forEach items="${licence.licencedModules}" var="licencedModule">
              	<c:set var="module" value="${licencedModule.module}" />
	              <tr>
					<th> <fmt:message key="${module.name}" /></th>
					<td>
						<scannell:select class="moduleSelect" path="modules[${module.code}]" writeErrorsAfterEndTag="true">
	  					  <c:forEach items="${moduleAccessLevels[module]}" var="accessLevel">
							<scannell:option value="${accessLevel}" labelkey="AccessLevel.${accessLevel}" />
						  </c:forEach>
						</scannell:select>
					</td>              	
	              </tr>
              </c:forEach>
          	</table>
            <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
          </spring:bind>
        </td>
      </tr>

	  <c:if test="${not empty assignableAccessRights}">
      <tr>
        <td class="searchLabel"><fmt:message key="user.assignableAccessRights" /></td>
        <td class="search">
          <spring:bind path="command.assignableAccessRights">
            <div class="scrolllist" >
              <c:forEach items="${assignableAccessRights}" var="role">
              	<c:set var="roleId" value="${role.left}" />
              	<c:set var="roleName" value="${role.right}" />
                <c:set var="selected" value="${false}" />
                <c:forEach items="${command.assignableAccessRights}" var="selectedRole">
                  <c:if test="${roleId == selectedRole.id}"><c:set var="selected" value="${true}" /></c:if>
                </c:forEach>
                <input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${roleId}" />" <c:if test="${selected}">checked="checked"</c:if> />
                  <span><c:out value="${roleName}" /></span><br />
              </c:forEach>
            </div>
            <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
          </spring:bind>
        </td>
      </tr>
	  </c:if>

	</c:if>

      <tr>
        <td class="searchLabel"><fmt:message key="users" /></td>
        <td class="search">
              
          <c:forEach items="${command.users}" var="user">
              <input type="checkbox" name="users" value="<c:out value="${user.id}" />" checked="checked" />
                <span><c:out value="${user.lastName}, ${user.firstName}" /></span><br />
            </c:forEach>
          <c:forEach items="${users}" var="user">
              <c:set var="selected" value="${false}" />
              <input type="checkbox" name="users" value="<c:out value="${user.id}" />"/>
                <span><c:out value="${user.lastName}, ${user.firstName}" /></span><br />
            </c:forEach>
        </td>
      </tr>

    </tbody>
    <tfoot>
      <tr>
        <td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
      </tr>
    </tfoot>
  </table>
</div>
</div>
</div>

</scannell:form>

</body>
</html>
