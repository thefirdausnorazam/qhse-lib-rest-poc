<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="reviewForm.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
   <script type="text/javascript">
	jQuery(document).ready(function() {
		 jQuery(".requiredHinted").hide();
		 jQuery("#theForm").submit(function() {				
				jQuery(this).submit(function() {
					return false;
				});
				// submit once return true
				return true;
			});	
	});
	</script>
</head>
<body>
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="reviewForm.title" /></h2> --%>
<!-- </div> -->
<scannell:form id="theForm">
<div class="content">  
<div class="table-responsive">
<div class="panel panel-danger">

<table class="table table-bordered table-responsive">
<col />
<tbody>
  <c:if test="${review.id != null}">
  <tr>
    <td ><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${review.id}" />
    </td>
  </tr>
  </c:if>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="review.assessment" />:</td>
    <td colspan="3">
      <c:url var="url" value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>
      <a href="<c:out value="${url}" />"><c:out value="${assessment.displayId}" /></a> -
      <c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
	  <c:if test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:if>
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="review.date" />:</td>
    <td>
    <div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left">
                  <scannell:input class="form-control" path="date" id="date" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>			
                  <span class="requiredHinted"> *</span>
                </div>
     <%--  <input name="date" id="date" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'date', true);"> --%>
    </td>
    <td class="scannellGeneralLabel"><fmt:message key="assessment.targetReviewDate" />:</td>
    <td>
      <input name="targetReviewDate" id="date" readonly="true" disabled="true"/>
    </td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="review.comment" />:</td>
    <td colspan="3"><scannell:textarea path="comment" cols="75" rows="3" />
    <span class="requiredHinted"> *</span></td>
  </tr>

  <tr>
  <c:choose>
  <c:when test="${review.createdByUser != null}">
    <td ><fmt:message key="createdBy" />:</td>
    <td><scannell:text value="${review.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${review.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${review.lastUpdatedByUser != null}">
    <td ><fmt:message key="lastUpdatedBy" />:</td>
    <td><scannell:text value="${review.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${review.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
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
      <input type="submit" id="submitButton" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/reviewQueryForm.htm"><c:param name="assessmentId" value="${param.assessmentId}"/></c:url>'">
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
