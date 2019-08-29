<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
	<title><fmt:message key="managementProgrammeCompleteForm.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type="text/javascript">
  jQuery(document).ready(function() {		
	  jQuery(".date").find(".requiredHinted").remove();
  });
  </script>
  <style type="text/css">
  td.search {
padding-left: 5%!important;
}
  </style>
  
  <style>
  td.searchLabel{
padding-left: 100px !important;	
background-color: white !important;
border-width: 0px !important;  
font-family: 'Open Sans', sans-serif !important;
font-weight: 600;
text-align: right;
padding-top: 22px !important;
margin-top: 0;
margin-bottom: 0;
font-size:100%;
width:40px !important;
}
</style>
</head>
<body>

<scannell:form>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">

<col  />
<tbody>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="id" />:</td>
    <td class="search">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${managementProgramme.displayId}" />
    </td>

    <td class="searchLabel"><fmt:message key="managementProgramme.status" />:</td>
    <td class="search"><fmt:message key="task.${managementProgramme.status}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="businessAreas" />:</td>
    <td colspan="3" class="search">
      <ul>
      <c:forEach var="ba" items="${managementProgramme.businessAreas}">
        <li><c:out value="${ba.name}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.name" />:</td>
    <td colspan="2" class="search"><scannell:text value="${managementProgramme.name}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.creationDate" />:</td>
    <td class="search"><fmt:formatDate value="${managementProgramme.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="searchLabel nowrap"><fmt:message key="managementProgramme.targetCompletionDate" />:</td>
    <td class="search"><fmt:formatDate value="${managementProgramme.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.responsibleUser" />:</td>
    <td class="search" colspan="3"><c:out value="${managementProgramme.responsibleUser.displayName}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.objective" />:</td>
    <td colspan="3" class="search">
      <c:if test="${managementProgramme.objective != null}">
        <c:url var="objectiveViewUrl" value="/risk/objectiveView.htm"><c:param name="id" value="${managementProgramme.objective.id}" /></c:url>
        <a href="<c:out value="${objectiveViewUrl}" />"><c:out value="${managementProgramme.objective.displayId}" /></a> -
        <c:out value="${managementProgramme.objective.name}" />
      </c:if>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.percentCompleted" />:</td>
    <td class="search" colspan="3"><c:out value="${managementProgramme.percentCompleted}" />%</td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.progressComment" />:</td>
    <td class="search" colspan="3"><scannell:text value="${managementProgramme.progressComment}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="managementProgramme.completionDate" />:</td>
    <td class="search" colspan="3">
      <%-- <input name="completionDate" id="completionDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'completionDate', true);"> --%>
      <div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left">
                  <scannell:input class="form-control" path="completionDate" id="completionDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>			
                  
                </div>
                  <span class="requiredHinted">*</span>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel nowrap"><fmt:message key="managementProgramme.completionComment" />:</td>
    <td class="search" colspan="3"><scannell:textarea path="completionComment" cols="75" rows="3" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="createdBy" />:</td>
    <td class="search"><c:out value="${managementProgramme.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${managementProgramme.lastUpdatedByUser != null}">
    <td class="searchLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td class="search"><c:out value="${managementProgramme.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${managementProgramme.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/managementProgrammeView.htm"><c:param name="id" value="${managementProgramme.id}"/></c:url>'">
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
