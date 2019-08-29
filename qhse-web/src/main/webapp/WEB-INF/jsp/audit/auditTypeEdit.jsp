<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
<html>
<head>
	<c:set var="title" value="inspectionProgrammeEdit" />
	<c:if test="${command.id == 0}"><c:set var="title" value="inspectionProgrammeCreate" /></c:if>
	<title><fmt:message key="${title}" /></title>
	<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
	
	<script type="text/javascript">
		var enterChars = '<fmt:message key="select2.enterChars"/>';
		var ownerCount = ${fn:length(owners)};
		var maxListSize = 500;
	
	jQuery(document).ready(function() {	
		jQuery("form").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});
		jQuery('#saveAndReview').select2({width:'40%'});
		/*jQuery('#type').select2({width:'40%'});		
		jQuery('#cal .requiredHinted').remove();	
		*/
		
	});

	  function onChangePlan(plan) {
		  var plan = plan[plan.selectedIndex].text;
		  jQuery(".ckbBA").prop('disabled', false);
		  jQuery(".ckbBA").each(function() {
			  var label = jQuery('label[for=' + jQuery(this).attr('id') + ']').html();
			  var value = label.replace("amp;", ""); 
			  if(plan.indexOf(value) == -1) {
				  jQuery(this).prop('disabled', true);
				  jQuery(this).prop('checked', false);
			  }
			});
	  }
	</script>
	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
	</style>
</head>
<body>
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="content">
<div class="table-responsive">
<table class="table table-bordered table-responsive" >

<tbody>
	
	
	<tr class="form-group" style="display:none">
		<td class="searchLabel"><fmt:message key="codeName" />:</td>
		<td class="search"><scannell:textarea path="codeName" id="codeName" cols="75" rows="3" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel nowrap"><fmt:message key="name" />:</td>
		<td class="search"><scannell:textarea path="name" id="name" cols="75" rows="3" /></td>
	</tr>

</tbody>
<tfoot>
	<tr>
		<td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"><input type="button" onclick="location.href='${command.id > 0 ? 'auditTypeView.htm' : 'auditTypeQueryForm.htm'}?id=${command.id}'" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />"></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</scannell:form>

</body>
</html>
