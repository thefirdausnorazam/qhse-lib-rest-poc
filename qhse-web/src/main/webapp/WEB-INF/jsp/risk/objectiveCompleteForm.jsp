<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="objectiveCompleteForm.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
  </style>
    <script type="text/javascript">
  jQuery(document).ready(function() {		
	  jQuery(".date").find(".requiredHinted").remove();
  });
  </script>
</head>
<body>
<scannell:form>
<c:set var="objective" value="${command.objective}" />
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">

<tbody>
  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="id" />:</td>
    <td class="search">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${objective.displayId}" />
    </td>

    <td class="searchLabel nowrap" ><fmt:message key="objective.status" />:</td>
    <td colspan="3" class="search"><fmt:message key="task.${objective.status}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="businessAreas" />:</td>
    <td colspan="3" class="search">
      <ul>
      <c:forEach var="ba" items="${objective.businessAreas}">
        <li><c:out value="${ba.name}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="objective.name" />:</td>
    <td colspan="3" class="search"><scannell:text value="${objective.name}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="objective.benefit" />:</td>
    <td colspan="3" class="search"><scannell:text value="${objective.benefit}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="objective.creationDate" />:</td>
    <td class="search" class="search"><fmt:formatDate value="${objective.creationDate}" pattern="dd-MMM-yyyy"/></td>

    <td  class="searchLabel nowrap"><fmt:message key="objective.targetCompletionDate" />:</td>
    <td class="search" class="search"><fmt:formatDate value="${objective.targetCompletionDate}" pattern="dd-MMM-yyyy"/></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="objective.category" />:</td>
    <td colspan="3" class="search"><c:out value="${objective.category.name}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="objective.externalObjective" />:</td>
    <td colspan="3" class="search"><c:out value="${objective.externalObjective}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="objective.sponsor" />:</td>
    <td colspan="3" class="search"><c:out value="${objective.sponsor}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="objective.percentCompleted" />:</td>
    <td class="search" colspan="3"><c:out value="${objective.percentCompleted}" />%</td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="objective.progressComment" />:</td>
    <td colspan="3" class="search"><scannell:text value="${objective.progressComment}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="objective.completionDate" />:</td>
    <td class="search nowrap" colspan="3">
    <div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left">
                  <scannell:input class="form-control" path="completionDate" id="completionDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>	
                </div>
                  <span class="requiredHinted">*</span>
      <%-- <input name="completionDate" id="completionDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'completionDate', true);"> --%>
    </td>
  </tr>

  <tr class="form-group">
    <td  class="searchLabel"><fmt:message key="objective.completionComment" />:</td>
    <td colspan="3"  class="search"><scannell:textarea path="completionComment" cols="75" rows="3" /></td>
  </tr>

  <tr class="form-group">
    <td  class="searchLabel"><fmt:message key="createdBy" />:</td>
    <td class="search"><c:out value="${objective.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${objective.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${objective.lastUpdatedByUser != null}">
    <td  class="searchLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td class="search"><c:out value="${objective.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${objective.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" value="<fmt:message key="submit" />">
      <input type="button" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/objectiveView.htm"><c:param name="id" value="${objective.id}"/></c:url>'">
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
