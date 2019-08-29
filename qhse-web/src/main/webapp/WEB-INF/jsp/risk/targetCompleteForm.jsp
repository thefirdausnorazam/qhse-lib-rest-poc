<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="targetCompleteForm.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type="text/javascript">
  jQuery(document).ready(function() {	
	  jQuery("#achieved").select2({width:'40%'});
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
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="targetCompleteForm.title" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="content">  
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive" >
<col />
<tbody>
  <c:if test="${target.id != null}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="id" />:</td>
    <td width="30%" class="search">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${target.displayId}" />
    </td>

    <td class="searchLabel nowrap"><fmt:message key="target.status" />:</td>
    <td class="search nowrap"><fmt:message key="task.${target.status}" /></td>
  </tr>
  </c:if>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="target.name" />:</td>
    <td class="search" colspan="3"><scannell:text value="${target.name}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel nowrap"><fmt:message key="target.creationDate" />:</td>
    <td class="search"><fmt:formatDate value="${target.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="searchLabel nowrap"><fmt:message key="target.targetCompletionDate" />:</td>
    <td class="search nowrap"><fmt:formatDate value="${target.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="target.responsibleUser" />:</td>
    <td class="search" colspan="3"><c:out value="${target.responsibleUser.displayName}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="target.objective" />:</td>
    <td class="search" colspan="3">
      <c:if test="${target.objective != null}">
        <c:url var="objectiveViewUrl" value="/risk/objectiveView.htm"><c:param name="id" value="${target.objective.id}" /></c:url>
        <a href="<c:out value="${objectiveViewUrl}" />"><c:out value="${target.objective.displayId}" /></a> -
        <c:out value="${target.objective.name}" />
      </c:if>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel nowrap"><fmt:message key="target.completionDate" />:</td>
    <td class="search nowrap" colspan="3">
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
    <td class="searchLabel nowrap"><fmt:message key="target.completionComment" />:</td>
    <td class="search"><scannell:textarea path="completionComment" cols="75" rows="3" cssStyle="float:left;width:90%"/></td>
    
    <td class="searchLabel nowrap"><fmt:message key="target.achieved" />:</td>
    <td class="search nowrap" colspan="3">
      <select name="achieved" id="achieved" renderEmptyOption="false" cssStyle="min-width:80px;width:20%">
        <scannell:option value="true" label="Yes" />
        <scannell:option value="false" label="No" />
      </scannell:select>
    </td>
  </tr>

  <tr class="form-group">
  <c:choose>
  <c:when test="${target.createdByUser != null}">
    <td class="searchLabel"><fmt:message key="createdBy" />:</td>
    <td class="search"><c:out value="${target.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td class="searchLabel">&nbsp;</td>
    <td class="search">&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${target.lastUpdatedByUser != null}">
    <td class="searchLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td class="search"><c:out value="${target.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td class="searchLabel">&nbsp;</td>
    <td class="search">&nbsp;</td>
  </c:otherwise>
  </c:choose>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/targetView.htm"><c:param name="id" value="${target.id}"/></c:url>'">
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
