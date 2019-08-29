<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title>
 

  </title> 
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
  </style>
  <script type="text/javascript">
  jQuery(document).ready(function() {	  
	 	 jQuery('select').not('#siteLocation').select2({width:'200px'});
	 	jQuery('#queryForm').submit();
	 	});
  
  </script>
</head>
<body>
<div class="header">
<h2> <fmt:message key="survey.monitoringProgrammeQueryForm.title" /></h2>
</div>
<a href="#" id="queryTableToggleLink" onclick="toggleQueryTable();">Display Search Criteria</a>

<form id="queryForm" action="<c:url value="/survey/monitoringProgrammeQuery.ajax" />" onSubmit="return search(this, 'resultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" />
  <input type="hidden" name="pageNumber" value="1" />
  <input type="hidden" id="pageSize" name="pageSize" />
  <div class="header">
<h2> <fmt:message key="searchCriteria" /></h2>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table id="queryTable" class="table table-bordered table-responsive" >

<tbody id="searchCriteria">
  <tr class="form-group">
    <td class="searchLabel"><label for="businessAreaId"><fmt:message key="survey.monitoringProgrammeQueryForm.quantityCategoryType" /></label>:</td>
    <td class="search" colspan="3">
      <select id="categoryTypeCode" name="categoryTypeCode">
        <option value="">Choose</option>
        <c:forEach items="${quantityCategoryTypes}" var="quantityCategoryType">
          <option value="<c:out value="${quantityCategoryType.name}" />" <c:if test="${businessArea == quantityCategoryType}">selected="selected"</c:if>><fmt:message key="${quantityCategoryType}" /></option>
        </c:forEach>
      </select>
    </td>
  </tr>

	<tr class="form-group">
    <td class="searchLabel"><label for="status"><fmt:message key="survey.monitoringProgrammeQueryForm.quantityCategories" /></label>:</td>
    <td class="search" colspan="3">
      <select id="quantityCategoryId" name="quantityCategoryId" class="wide">
        <option value="">Choose</option>
        <c:forEach items="${quantityCategories}" var="quantityCategory">
          <option value="<c:out value="${quantityCategory.id}" />"><c:out value="${quantityCategory.name}" /></option>
<!--           <option value="<c:out value="${quantityCategory.id}"/><c:out value="${quantityCategory.name}"/></option>  -->
        </c:forEach>
      </select>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><label for="responsibleUser"><fmt:message key="responsibleUser" /></label>:</td>
    <td class="search" colspan="3">
      <select id="authorisedUserId" name="authorisedUserId" class="wide">
        <option value="">Choose</option>
        <c:forEach items="${userList}" var="user">
          <c:choose>
            <c:when test="${user.id==responsibleUser.id}"><c:set var="selected" value="selected=selected" /></c:when>
            <c:otherwise><c:set var="selected" value="" /></c:otherwise>
          </c:choose>
          <option value="<c:out value="${user.id}" />" <c:out value="${selected}"/>><c:out value="${user.sortableName}" /></option>
        </c:forEach>
      </select>
    </td>
  </tr>
<!--
  <tr>
    <td><label for="sortName"><fmt:message key="sortName" />:</td>
    <td colspan="3">
      <select id="sortName" name="sortName" class="wide">
        <option></option>
        <c:forEach items="${sortList}" var="sort">
          <option value="<c:out value="${sort}" />"><fmt:message key="${sort}" /></option>
        </c:forEach>
      </select>
    </td>
  </tr>
-->
</tbody>

<tfoot>
  <tr>
    <td colspan="4">
      <button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;"><fmt:message key="search" /></button>
      <button type="reset" class="g-btn g-btn--secondary"><fmt:message key="reset" /></button>
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
<div id="resultsDiv"></div>

</form>
</body>
</html>
