<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="completeAction" /></title>
<style type="text/css">
td.searchLabel {
padding-left: 0px !important;
padding-right: 5%!important;
width: 45%!important;
}
</style>
<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/showUsers.js" />"></script>
<script language="javascript">
	jQuery(document).ready(function() {
		showUserList(${fn:length(users)}, "verifyingUser", "40", "completeActionUserList.json", "<c:out value="${command.verifyingUser.id}"/>", "<c:out value="${command.verifyingUser.sortableName}"/>");
		
		jQuery(".date").find(".requiredHinted").remove();
		onEffectivenessToggleChange();
	});
	
	function onEffectivenessToggleChange() {
		var effectivenessToggle = document.getElementById("effectivenessReviewRequired");
		document.getElementById("verificationTargetDate").disabled = !effectivenessToggle.checked;
		if (!effectivenessToggle.checked) {
			document.getElementById("verificationTargetDate").value = "";
			document.getElementById('required1').style.visibility = 'hidden';
			document.getElementById('required2').style.visibility = 'hidden';
			document.getElementById('cal').style.visibility = 'hidden';
			document.getElementById('hideCal').style.visibility = 'visible';
			jQuery("#verifyingUser").select2("disable");
			jQuery(".hideField").show();
			//jQuery('.emptyValue').val('');
			jQuery('.hideField').attr('id', jQuery('.emptyValue').attr('id'));
			jQuery('.hideField').attr('name', jQuery('.emptyValue').attr('name'));
			jQuery('.verificationRow').hide();
			
		} else {
			jQuery('.hideField').attr('id', 'empty');
			jQuery('.hideField').attr('name', 'empty');
			document.getElementById('required1').style.visibility = 'visible';
			document.getElementById('required2').style.visibility = 'visible';
			document.getElementById('cal').style.visibility = 'visible';
			document.getElementById('hideCal').style.visibility = 'hidden';
			jQuery("#verifyingUser").select2("enable");
			jQuery(".hideField").hide();
			jQuery('.verificationRow').show();
		}
	}
</script>

<style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
</style>

</head>
<body onload="onEffectivenessToggleChange()">

<scannell:form>
<spring:nestedPath path="command">
<spring:bind path="id">
      <input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
</spring:bind>
<spring:bind path="version">
      <input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>" />
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
</spring:bind>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
    <col  />
<tbody>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="comment" /></td>
    <td class="search"><spring:bind path="comment">
      <textarea name="<c:out value="${status.expression}"/>" cols="50" rows="3"><c:out
        value="${status.value}" /></textarea>
      <span class="requiredHinted">*</span>
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind></td>
  </tr>

   <tr class="form-group">
    <td class="searchLabel"><fmt:message key="effectivenessReviewRequired" /></td>
				<td class="search"><spring:bind path="effectivenessReviewRequired">
			    	<input type="hidden" name="_<c:out value="${status.expression}"/>">
				<input type="checkbox" id="effectivenessReviewRequired" onclick="onEffectivenessToggleChange()"
				name="<c:out value="${status.expression}"/>"
				value="true" <c:if test="${status.value}">checked</c:if>/>
				   </spring:bind>
			</td>
		</tr>
  <tr class="form-group verificationRow">
    <td class="searchLabel"><fmt:message key="verificationTargetDate" /></td>
    <td id="showCal" class="search">
    <spring:bind path="verificationTargetDate">
     <div id="hideCal" style="width:250px;">
	                  <input type="text" class="form-control hideField" name="<c:out value="${status.expression}"/>"
        value="<c:out value="${status.value}"/>" size="20" readonly="readonly"
	        id="<c:out value="${status.expression}"/>"></div>  
    <div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="float:left;width:200px;">
                <input type="text" class="form-control emptyValue" name="<c:out value="${status.expression}"/>"
        value="<c:out value="${status.value}"/>" size="20" readonly="readonly"
        id="<c:out value="${status.expression}"/>">   
                    <span id="scal" class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>
                </div>
                &nbsp;<label id="required1" style="color:#FF0000"> <c:out value="*"/> </label>
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
            
    </spring:bind>
    </td>
  </tr>
  <tr id="user" class="form-group verificationRow">
    <td class="searchLabel"><fmt:message key="verifyingUser" /></td>
    <td class="search">
    	<spring:bind path="verifyingUser">
	      	<c:choose>
				<c:when test="${fn:length(users) lt 500}">
					<scannell:select id="verifyingUser" cssStyle="width:300px;" path="verifyingUser" items="${users}" itemLabel="sortableName" itemValue="id" emptyOptionValue="" />
				</c:when>
				<c:otherwise>
					<input type="hidden" id="verifyingUser" style="width:300px !important;" name="verifyingUser" value="<c:out value="${status.value}"/>" />
				</c:otherwise>
			</c:choose>
		</spring:bind>

      <label id="required2" style="color:#FF0000"> <c:out value="*"/> </label>
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
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
</spring:nestedPath>

</scannell:form>

</body>
</html>
