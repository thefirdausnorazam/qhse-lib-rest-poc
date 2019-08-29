<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="auditPlanCreate" /></title>
	<script type="text/javascript">
	  jQuery(document).ready(function() {	
		  onMultiYearChange();
		  });
	  
		var yearEndBlankMsg = '<fmt:message key="audit.yearEndBlank"/>';
		var yearEndEarlierMsg = '<fmt:message key="audit.yearEndEarlier"/>';
	
		function onMultiYearChange() {	
			var multi = document.getElementById("multiYear");
			var yearEnd = document.getElementById("yearEnd");	
			if(multi != null)
			{
				yearEnd.disabled = !multi.checked;	
			}
		}

		function checkMultiSelect() {
			var multi = document.getElementById("multiYear");
			var yearEnd = document.getElementById("yearEnd");
			if(multi != null && multi.checked) 
			{
				if(yearEnd.value == "") 
				{
				 alert(yearEndBlankMsg);
				 return false;
				}
				var end = yearEnd.value;
				var start = document.getElementById("year").value;
				if(start >= end)
				{
					 alert(yearEndEarlierMsg);
					 return false;
				}
			}
			return true;
		}
		function isNumberKey(evt){
		    var charCode = (evt.which) ? evt.which : evt.keyCode
		    return !(charCode > 31 && (charCode < 48 || charCode > 57));
		}
		
		function verifyBAchecked(){
			var checked = false;
			jQuery('input[type=checkbox].ckbBA').each(function() {
				if ($(this).is(":checked")) {
				   checked = true;
			   }
			});
			if(checked == true) {
				jQuery('#btSubmit').removeAttr('disabled');
			} else {
				jQuery('#btSubmit').attr('disabled','disabled');
			}
		}
	</script>
</head>
<body>
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="auditPlanCreate" /></h2> --%>
<!-- </div> -->
<scannell:form onsubmit="return checkMultiSelect();">
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive">

<tbody>
	<tr class="form-group">
    <td class="searchLabel"><fmt:message key="businessAreas" />:</td>
    <td class="search" style="float:left">
      <fmt:message var="multiSelect" key="risk.businessAreaMultiSelect" />
        <spring:bind path="command.businessAreas">
          <label>
          <c:forEach var="ba" items="${businessAreaList}">
            <c:set var="selected" value="${false}" />
            <c:forEach items="${command.businessAreas}" var="selectedBA">
              <c:if test="${ba.id == selectedBA.id}"><c:set var="selected" value="${true}" /></c:if>
            </c:forEach>

            <input class="ckbBA" type="checkbox" id="businessAreas" onchange="verifyBAchecked()" <c:if test='${command.plan.yearEditable == false}'>disabled='true'</c:if>
                name="<c:out value="${status.expression}"/>"
                value="<c:out value="${ba.id}" />"
                <c:if test="${selected}">checked="checked"</c:if> />
            <c:out value="${ba.name}" /><br>

            <c:remove var="selected" />
          </c:forEach>
          </label>
          <span class="requiredHinted">*</span>
          <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
        </spring:bind>
    </td>
  </tr>
	<tr class="form-group">
	 	<td class="searchLabel"><fmt:message key="audit.multiYear" />:</td>
		<td class="search"><scannell:checkbox path="multiYear" id="multiYear" onclick="onMultiYearChange()" /></td>
	</tr>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="audit.yearFrom" />:</td>
		<td class="search"><scannell:input id="year" path="year" class="form-control" cssStyle="float:left;width:20%" disabled="${command.plan.yearEditable == false}" onkeypress="return isNumberKey(event);" /></td>
	</tr>
	
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="audit.yearTo" />:</td>
		<td class="search"><input name="yearEnd" id="yearEnd" class="form-control" cssStyle="float:left;width:20%" onkeypress="return isNumberKey(event);" /></td>
	</tr>
  	<c:if test="${command.plan.yearEditable == false}">
		<tr><td colspan="2" align="center"><fmt:message key="audit.yearNotEditable" /></td></tr>
	</c:if>
</tbody>
<tfoot>
  <tr>
    <td colspan="2" align="center"><input id="btSubmit" type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"><button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button></td>
  </tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
