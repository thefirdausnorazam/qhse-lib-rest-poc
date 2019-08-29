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
</script>
<body>
<scannell:form>
  <scannell:hidden path="id"/>
	<div class="form-group">
        <label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="name" /></label>
        <div class="col-sm-6"><input name="name" cssStyle="float:left;width:40%" class="wide form-control" /></div>
	</div>
	
 	<div class="form-group" style="overflow:auto;height: auto;">
        <label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="enviro.reportingGroups" /></label>
        <div class="col-sm-6">
          <%-- <c:forEach items="${reportingGroups}" var="reportingGroup">
				<c:set var="selected" value="${false}" />
				<c:forEach items="${command.reportingGroups}" var="selectedReportingGroup">
					<c:if test="${reportingGroup.id == selectedReportingGroup.id}"><c:set var="selected" value="${true}" /></c:if>
				</c:forEach>
				<input type="checkbox" name="reportingGroups" value="<c:out value="${reportingGroup.id}" />" <c:if test="${selected}">checked="checked"</c:if>/>  <span><c:out value="${reportingGroup.name}" /></span><br />
			</c:forEach> --%>
			<c:forEach items="${allReportingGroups}" var="reportingGroup">
				<c:set var="selected" value="${false}" />
				<c:forEach items="${command.reportingGroups}" var="selectedReportingGroup">
					<c:if test="${reportingGroup.id == selectedReportingGroup.id}"><c:set var="selected" value="${true}" /></c:if>
				</c:forEach>
				<c:set var="enabled" value="${false}" />
				<c:forEach items="${reportingGroups}" var="enabledReportingGroup">
					<c:if test="${reportingGroup.id == enabledReportingGroup.id}"><c:set var="enabled" value="${true}" /></c:if>
				</c:forEach>
				<c:choose>
					<c:when test="${enabled}">
						<input type="checkbox" name="reportingGroups" value="<c:out value="${reportingGroup.id}" />" <c:if test="${selected}">checked="checked"</c:if>/>  <span><c:out value="${reportingGroup.name}" /></span><br />
					</c:when>
					<c:otherwise>
						<input type="checkbox" name="x" disabled="disabled"/><span>  <c:out value="${reportingGroup.name}" /> &nbsp;<fmt:message key="enviro.nestedReportingGroups"><fmt:param value="${command.name}" /></fmt:message></span><br />
					</c:otherwise>
				</c:choose>
			</c:forEach>
        </div>
      </div>
      
	<div class="form-group" style="overflow:auto;height: auto;">
        <label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="sitesActive" /></label>
        <div class="col-sm-6">
          <c:forEach items="${sites}" var="site">
				<c:set var="selected" value="${false}" />
				<c:forEach items="${command.sites}" var="selectedSite">
					<c:if test="${site.id == selectedSite.id}"><c:set var="selected" value="${true}" /></c:if>
				</c:forEach>
				<input type="checkbox" name="sites" value="<c:out value="${site.id}" />" <c:if test="${selected}">checked="checked"</c:if>/>  <span><c:out value="${site.name}" /></span><br />
			</c:forEach>
        </div>
      </div>

	<div class="form-group" style="overflow:auto;height: auto;">
        <label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="groups" /></label>
        <div class="col-sm-6">
          <fmt:message key="groupEdit.allGroupUsersWillBeAdded" /><br/>
          <c:forEach items="${groups}" var="group">
				<c:set var="selected" value="${false}" />
				<c:forEach items="${command.groups}" var="selectedGroup">
					<c:if test="${group.id == selectedGroup.id}"><c:set var="selected" value="${true}" /></c:if>
				</c:forEach>
				<input type="checkbox" name="groups" value="<c:out value="${group.id}" />" <c:if test="${selected}">checked="checked"</c:if>/>  <span><c:out value="${group.name}" /></span><br />	
			</c:forEach>
			<scannell:errors path="groups"/>
        </div>
      </div>
      
      <div class="form-group" style="overflow:auto;height: auto;">
        <label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="users" /></label>
        <div class="col-sm-6">
          <c:forEach items="${command.users}" var="user">
              <input type="checkbox" name="users" value="<c:out value="${user.id}" />" checked="checked" />
                <span><c:out value="${user.lastName}, ${user.firstName}" /></span><br />
            </c:forEach>
          <c:forEach items="${users}" var="user">
              <c:set var="selected" value="${false}" />
              <input type="checkbox" name="users" value="<c:out value="${user.id}" />"/>
                <span><c:out value="${user.lastName}, ${user.firstName}" /></span><br />
            </c:forEach>
			<scannell:errors path="users"/>
        </div>
      </div>

    
	<div class="spacer2 text-center">
        <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
     </div>

</scannell:form>

</body>
</html>
