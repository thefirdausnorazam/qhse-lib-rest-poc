<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="readingEdit" />
<c:if test="${command['new']}"><c:set var="title" value="readingCreate" /></c:if>
<title><fmt:message key="${title}" /></title>


<script type="text/javascript" >
jQuery(document).ready(function() {
	 jQuery('select').select2();
	jQuery("form").submit(function() {
		// submit more than once return false
		jQuery(this).submit(function() {
			return false;
		});
		// submit once return true
		return true;
	});
});

<!--
function onFormSubmit(frm) {
  if (frm.readingDate.value.length == 0) {
    frm.readingTime.value = "";
  } else {
    frm.readingTime.value = frm.readingDate.value + " "
      + frm.readingHour.value + ":" + frm.readingMinute.value + ":00";
  }
}
// -->
</script>


</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->

<div class="content">
<scannell:form onsubmit="onFormSubmit(this)">

<table class="table table-bordered table-responsive">
    <col  />
<tbody>
  <c:set var="type" value="${command.type}" />
  <tr>
    <td ><fmt:message key="quantity" />:</td>
    <td><c:out value="${type.quantity.longName}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="measure" />:</td>
    <td><c:out value="${type.measure.measureName}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="readingPoint" />:</td>
    <td><c:out value="${type.readingPoint.name}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="measurement.frequency" />:</td>
    <td><c:out value="${command.readingMetaData == null ? type.frequencyDisplay : command.readingMetaData.frequencyDisplay}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="additionalInfo" />:</td>
    <td><scannell:text value="${type.additionalInfo}" /></td>
  </tr>

  <tr>
    <td ><fmt:message key="readingTime" />:</td>
    <td>
    <spring:bind path="command.readingTime">
      <input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" >
		<div  style="width: 450px;">
              <div class="input-group date datetime col-md-5 col-xs-7" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" >
              <input class="form-control" style="float:left;" id="readingDate" name="readingDate" type="text"  readonly value="<fmt:formatDate value="${command.readingTime}" pattern="dd-MMMM-yyyy" />"/>
              <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
              </div>
         </div>
       <select name="readingHour"  class="narrow">
        <c:forEach items="${hours}" var="item">
        <!-- remove these comment after investigation -->
        <!-- item = <c:out value="${item}" /> -->
        <!-- item:hour = <c:out value="${item == hour}" /> -->
         <!-- item:hour eq <c:out value="${item eq hour}" /> -->
         <!-- item:hour check unequal  <c:out value="${not (item > hour)  && not (item < hour)}" /> -->
          <!-- hour = <c:out value="${hour}" /> -->
         <option value="<c:out value="${item}" />" <c:if test="${not (item > hour)  && not (item < hour)}">selected="selected"</c:if>><c:out value="${item} " /></option>
        </c:forEach>
      </select>

      <select name="readingMinute" class="narrow">
        <c:forEach items="${minutes}" var="item">
          <option value="<c:out value="${item}" />" <c:if test="${not (item > minute)  && not (item < minute)}">selected="selected"</c:if>><c:out value="${item}" /></option>
        </c:forEach>
      </select>
      <span class="requiredHinted">*</span>
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind>
    <%--       <input type="text" name="readingDate" value="<fmt:formatDate value="${command.readingTime}" pattern="dd-MMM-yyyy" />"
        size="20" readonly="readonly" id="readingDate">
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'readingDate', true);"> --%>
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="value" /> (<c:out value="${command.type.defaultUnit.name}" />):</td>
    <td>
      <c:choose>
        <c:when test="${command.type.numeric}">
          <input name="value" class="form-control"  cssStyle="width:20%"/>
        </c:when>
        <c:when test="${command.type['boolean']}">
          <select name="value" items="${options}" itemValue="amount" lookupItemLabel="true" renderEmptyOption="true" />
        </c:when>
        <c:when test="${command.type.option}">
          <select name="value" items="${options}" itemValue="amount" renderEmptyOption="true"/>
        </c:when>
      </c:choose>
    </td>
  </tr>

  <tr>
    <c:choose>
      <c:when test="${command.entered}">
        <td ><fmt:message key="updateComment" />:</td>
        <td><scannell:textarea path="updateComment" cols="50" rows="3"  cssStyle="width:60%"/><span class="requiredHinted">*</span></td>
      </c:when>
      <c:otherwise>
        <td ><fmt:message key="comment" />:</td>
        <td><scannell:textarea path="notes" cols="50" rows="3" class="form-control" cssStyle="width:60%" /></td>
      </c:otherwise>
    </c:choose>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
  </tr>
</tfoot>
</table>

</scannell:form>
</div>
</body>
</html>
