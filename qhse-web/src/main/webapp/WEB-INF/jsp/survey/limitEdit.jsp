<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<c:set var="command_limit_new" value="${false}" />
	<c:set var="title" value="limitEdit" />
	<c:if test="${command.limit['new']}">
		<c:set var="title" value="limitCreate" />
		<c:set var="command_limit_new" value="${true}" />
	</c:if>
	<title><fmt:message key="${title}" /></title>
	 <style type="text/css">
	td.search {
    padding-left: 0%!important;width:60%;
    }
    .showHelp{
    color: red;
    }
	</style> 
	<script type="text/javascript">
 jQuery(document).ready(function() {	  
	 jQuery("form").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});
	 jQuery('select').not('#siteLocation').select2({width:'200px'});
	});

 </script>
<script>
var isManadtory;
	
	function toggleMandatoryValue(){
		isManadtory = document.getElementById("limit.overrideEnabled").checked;
		
		var sign = document.getElementById("mandatorySign");
		isManadtory==false ? sign.style.display='none' : sign.style.display='inline';		
	}
	
	function toggle(){
		if(jQuery('#skipLimit').is(":checked")){
			jQuery('.skipLimitClass').hide();
			jQuery('.showHelp').show();
		}else{
			jQuery('.skipLimitClass').show();
			jQuery('.showHelp').hide();
		}
	}
	
	function setCreateAnotherLimit(){
		jQuery('#createAnotherLimit').val('true');
		}
	
</script>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<div class="content">
<!-- <div class="header"> -->
<%-- <h3><fmt:message key="measurementList" /></h3> --%>
<!-- </div> -->
<scannell:form>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col  />
<tbody>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="quantity" />:</td>
		<td class="search"><c:out value="${command.limit.owner.quantity.longName}" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="measure" />:</td>
		<td class="search"><c:out value="${command.limit.owner.measure.measureName}" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="measurement.frequency" />:</td>
		<td class="search"><fmt:message key="${command.limit.owner.frequency}" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="readingPoint" />:</td>
		<td class="search"><c:out value="${command.limit.owner.readingPoint.description}" /></td>
	</tr>
	<c:if test="${param.showSkipLimit}">
	<tr>
		
		<td class="searchLabel"><fmt:message key="skipLimitCreation" />:</td>
		<td class="search">
			<scannell:checkbox  path="skipLimit" id="skipLimit" value="true" onclick="toggle()" />
		</td>
	</tr>
	</c:if>
	<c:if test="${param.showSkipLimit == false}">
	<input type="hidden" id="skipLimit" name="skipLimit" value="false" />
	</c:if>

	<tr class="form-group skipLimitClass">
		<td class="searchLabel"><fmt:message key="type" />:</td>
		<td class="search">
			<scannell:select class="wide" path="limit.type" items="${types}" itemValue="name" lookupItemLabel="true"
				renderEmptyOption="true" emptyOptionLabel="blankOption" /><span class="requiredHinted">*</span>
		</td>
	</tr>

	<tr class="form-group skipLimitClass">
		<td class="searchLabel"><fmt:message key="limit.frequency" />:</td>
		<td class="search">
			<c:if test="${command_limit_new}">
				<scannell:select class="wide" path="limit.frequency" items="${frequencies}" itemValue="name" lookupItemLabel="true"
					renderEmptyOption="true" emptyOptionLabel="blankOption" />
			</c:if>
			<c:if test="${!command_limit_new}">
				<fmt:message key="${command.limit.frequency}" />
			</c:if><span class="requiredHinted">*</span>
		</td>
	</tr>

	<c:if test="${command.limit.owner.rate and command.limit.owner.numeric}">
		<tr class="form-group skipLimitClass"><td class="searchLabel"></td><td class="search"><span class="requiredHinted">*</span><fmt:message key="required.threshold" /></td></tr>
	</c:if>
	<c:if test="${command.limit.owner.rate}">
	<tr class="form-group skipLimitClass">
		<td class="searchLabel"><fmt:message key="lowerThreshold" />:</td>
		<td class="search">
			<input name="lowerAmount" cssStyle="float:left;width: 100px;display:inline;" class="form-control" />
			<select name="lowerUnit" items="${units}" itemValue="id" itemLabel="description"
				renderEmptyOption="true" emptyOptionLabel="blankOption" cssStyle="width: 300px;"/>
			<c:if test="${command.limit.owner.numeric == false}">
				<span class="requiredHinted">*</span>
			</c:if>
			<spring:bind path="command.limit.lowerThreshold">
				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
			</spring:bind>

		</td>
	</tr>
	</c:if>

	<c:if test="${command.limit.owner.numeric}">
	<tr class="form-group skipLimitClass">
		<td class="searchLabel"><fmt:message key="upperThreshold" />:</td>
		<td class="search">
			<input name="upperAmount" cssStyle="float:left;width: 100px;display:inline;"  class="form-control"/>
			<select name="upperUnit" items="${units}" itemValue="id" itemLabel="description"
				renderEmptyOption="true" emptyOptionLabel="blankOption" cssStyle="width: 300px;"/>
			<c:if test="${command.limit.owner.rate == false}">
				<span class="requiredHinted">*</span>
			</c:if>
			<spring:bind path="command.limit.upperThreshold">
				<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
			</spring:bind>

		</td>
	</tr>
	</c:if>

	<tr class="form-group skipLimitClass">
		<td class="searchLabel"><fmt:message key="additionalInfo" />:</td>
		<td class="search"><scannell:textarea path="limit.additionalInfo" cols="75" rows="3" /></td>
	</tr>

	<tr class="form-group skipLimitClass">
		<td class="searchLabel"><fmt:message key="overrideEnabled" />:</td>
		<td class="search"><scannell:checkbox path="limit.overrideEnabled"  id="limit.overrideEnabled"  onclick="toggleMandatoryValue()"/></td>
	</tr>

	<tr class="form-group skipLimitClass">
		<td class="searchLabel"><fmt:message key="overrideQuestion" />:</td>
		<td class="search"><scannell:textarea path="limit.overrideQuestion" cols="75" rows="3" />
		<div class="mandatorySign" id="mandatorySign"  style="display:none" ><span class="requiredHinted">*</span></div>
		<c:if test="${command.limit.overrideEnabled == true}"> <script>  toggleMandatoryValue(); </script></c:if></td>
	</tr>

	<tr class="form-group skipLimitClass">
		<td class="searchLabel"><fmt:message key="active" />:</td>
		<td class="search"><scannell:checkbox path="limit.active" /></td>
	</tr>
	<tr class="form-group showHelp"  style="display: none;">
		<td colspan="2" align="center">
			<fmt:message key="skipLimitText" />
		</td>
	</tr>
</tbody>

<tfoot>
	<tr>
		<td colspan="2" align="center"><button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
		<c:if test="${param.showSkipLimit == true}">
		<input type="hidden" id="createAnotherLimit" name="createAnotherLimit" value="false" />
		<button type="submit" class="g-btn g-btn--primary skipLimitClass" onclick="return setCreateAnotherLimit()"><fmt:message key="saveAndCreateNew" /></button>
		</c:if>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>
</div>
</body>
</html>
