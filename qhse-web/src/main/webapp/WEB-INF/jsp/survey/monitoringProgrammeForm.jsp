<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
  <title></title>
  <script type='text/javascript' src="<c:url value="/dwr/interface/WasteDWRService.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>  
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
  </style>
  <script type="text/javascript">
  function onChangeBusinessArea() {
    var element = document.getElementById("objectiveId");
    DWRUtil.removeAllOptions(element.id);
    DWRUtil.addOptions(element.id, {"":"Please Wait..."});
    RiskDWRService.listActiveObjectives(jQuery('#businessAreas'), function(data) { populateCallback(element, data); });
  }
  function populateCallback(element, data) {
    DWRUtil.removeAllOptions(element.id);
    DWRUtil.addOptions(element.id, {"":" "});
    DWRUtil.addOptions(element.id, data);
  }
  </script>
</head>
<body>
<div class="header">
<h2><fmt:message key="managementProgrammeForm.title" /></h2>
</div>

<scannell:form>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col  />
<tbody>
  <c:if test="${managementProgramme.id != null}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="id" />:</td>
    <td class="search">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${managementProgramme.displayId}" />
    </td>

    <td class="searchLabel"><fmt:message key="managementProgramme.status" />:</td>
    <td class="search"><fmt:message key="${managementProgramme.status}" /></td>
  </tr>
  </c:if>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="businessAreas" />:</td>
    <td class="search" colspan="3">
    <spring:bind path="command.businessAreas">
      <div class="checkbox">
      <label>
      <c:forEach var="ba" items="${businessAreaList}">
        <c:set var="selected" value="${false}" />
        <c:forEach items="${command.businessAreas}" var="selectedBA">
          <c:if test="${ba.id == selectedBA.id}"><c:set var="selected" value="${true}" /></c:if>
        </c:forEach>
        <input type="checkbox" id="businessAreas" name="<c:out value="${status.expression}"/>" value="<c:out value="${ba.id}" />"  <c:if test="${selected}">checked="checked"</c:if> onchange="onChangeBusinessArea();" />
        <c:out value="${ba.name}" /><br>
        <c:remove var="selected" />
      </c:forEach>
      </label>
      </div>
      <span class="requiredHinted">*</span>
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind>
<%--
      <scannell:hidden path="businessAreas" />
      <ul>
      <c:forEach items="${command.businessAreas}" var="ba"><li><c:out value="${ba.name}" /></li></c:forEach>
      </ul>
--%>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.name" />:</td>
    <td class="search" colspan="3"><scannell:textarea path="name" cols="75" rows="3" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.creationDate" />:</td>
    <td class="search">
      <input name="creationDate" id="creationDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'creationDate', true);">
    </td>

    <td class="searchLabel"><fmt:message key="managementProgramme.targetCompletionDate" />:</td>
    <td class="search">
      <input name="targetCompletionDate" id="targetCompletionDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'targetCompletionDate', true);">
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.objective" />:</td>
    <td class="search">
      <scannell:select id="objectiveId" path="objectiveId" items="${objectiveList}" itemLabel="name" itemValue="id" class="wide" emptyOptionLabel="Choose Business Area First!" /><br>
      <c:if test="${userHasRiskManagementAccess}">
      <a href="<c:url value="/risk/objectiveEdit.htm" />"><fmt:message key="managementProgramme.createObjective" /></a>
      </c:if>
    </td>

    <td class="searchLabel"><fmt:message key="managementProgramme.responsibleUser" />:</td>
    <td class="search"><select name="responsibleUser" items="${userList}" itemLabel="sortableName" itemValue="id" /></td>
  </tr>

<%
java.util.Collection<Integer> c = new java.util.ArrayList<Integer>();
for (int i=0; i<=20; i++) {
  c.add(new Integer(i*5));
}
pageContext.setAttribute("percentages", c);
%>
  <c:if test="${managementProgramme.id != null}"><%-- Percent fields are only displayed for an edit. --%>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.percentCompleted" />:</td>
    <td class="search"><select name="percentCompleted" items="${percentages}"  renderEmptyOption="false"/></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.progressComment" />:</td>
    <td class="search" colspan="3"><scannell:textarea path="progressComment" cols="75" rows="3" /></td>
  </tr>
  </c:if>

  <c:if test="${managementProgramme.completedByUser != null}" >
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.completedBy" />:</td>
    <td><c:out value="${managementProgramme.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.completionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.completionComment" />:</td>
    <td class="search"><c:out value="${managementProgramme.completionComment}" /></td>
  </tr>
  </c:if>

  <tr class="form-group">
  <c:choose>
  <c:when test="${managementProgramme.createdByUser != null}">
    <td class="searchLabel"><fmt:message key="createdBy" />:</td>
    <td class="search"><c:out value="${managementProgramme.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${managementProgramme.lastUpdatedByUser != null}">
    <td class="searchLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td class="search"><c:out value="${managementProgramme.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" value="<fmt:message key="submit" />">
      <c:choose>
        <c:when test="${managementProgramme.id gt 0}">
        <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/managementProgrammeView.htm"><c:param name="id" value="${managementProgramme.id}"/></c:url>'">
        </c:when>
        <c:otherwise>
        <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/home.htm" />'">
        </c:otherwise>
      </c:choose>
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
