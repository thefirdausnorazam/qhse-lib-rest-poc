<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="readingPointEdit" />
<c:if test="${command['new']}"><c:set var="title" value="readingPointCreate" /></c:if>
	<title><fmt:message key="${title}" /></title>	

   <style>
  td.searchLabel{
width:30% !important;
}
</style>
  <script type="text/javascript">
  jQuery(document).ready(function() {		
		jQuery('select').not('#siteLocation').select2({width:'50%'});
		onTypeChange();
});

  function onTypeChange() {
	  var type = jQuery("#type").val();
	  if ("IND" == type) {
		  show("attribute1"); show("attribute2"); show("attribute3"); show("attribute4"); show("attribute5"); show("attribute6"); show("attribute7"); show("attributex");
	  } else {
		  hide("attribute1"); hide("attribute2"); hide("attribute3"); hide("attribute4"); hide("attribute5"); hide("attribute6"); hide("attribute7"); hide("attributex");
	  }
  }
  function show(element) {
	  jQuery('#'+element).show();
  }
  function hide(element) {
	  jQuery('#'+element).hide();
  }

	</script>
</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col  />
<tbody>
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="type" />:</td>
		<td class="search">
			<scannell:select id="type" path="type" onchange="onTypeChange();" renderEmptyOption="true" >
		        <scannell:option value="IND" label="Individual" />
        		<scannell:option value="LOC" label="Location" />
			</scannell:select>
		</td>
	 </tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="name" />:</td>
		<td class="search"><input name="name"   cssStyle="width:50%;"/></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="location" />:</td>
		<td class="search"><input name="location"  cssStyle="width:50%;" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="active" />:</td>
		<td class="search"><scannell:checkbox path="active"  /></td>
	</tr>

	<tr id="attribute1" class="form-group">
		<td class="searchLabel"><fmt:message key="survey.readingPoint.attribute1" />:</td>
		<td class="search"><input name="attribute1"   cssStyle="width:50%;"/></td>
	</tr>

	<tr class="form-group" id="attribute2">
		<td class="searchLabel"><fmt:message key="survey.readingPoint.attribute2" />:</td>
		<td class="search"><input name="attribute2"  cssStyle="width:50%;" /></td>
	</tr>

	<tr class="form-group" id="attribute3">
		<td class="searchLabel"><fmt:message key="survey.readingPoint.attribute3" />:</td>
		<td class="search"><input name="attribute3"  cssStyle="width:50%;" /></td>
	</tr>

	<tr class="form-group" id="attribute4">
		<td class="searchLabel"><fmt:message key="survey.readingPoint.attribute4" />:</td>
		<td class="search"><input name="attribute4"  cssStyle="width:50%;" /></td>
	</tr>

	<tr class="form-group" id="attributex">
		<td   class="searchLabel" ><fmt:message key="survey.readingPoint.attributex" />:</td>
		<td class="search"></td>
	</tr>

	<tr class="form-group" id="attribute5">
		<td class="searchLabel"><fmt:message key="survey.readingPoint.attribute5" />:</td>
		<td class="search"><input name="attribute5"  cssStyle="width:50%;" /></td>
	</tr>

	<tr class="form-group" id="attribute6">
		<td class="searchLabel"><fmt:message key="survey.readingPoint.attribute6" />:</td>
		<td class="search"><input name="attribute6"  cssStyle="width:50%;" /></td>
	</tr>

	<tr class="form-group" id="attribute7">
		<td class="searchLabel"><fmt:message key="survey.readingPoint.attribute7" />:</td>
		<td class="search"><input name="attribute7"  cssStyle="width:50%;" /></td>
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
</scannell:form>

</body>
</html>
