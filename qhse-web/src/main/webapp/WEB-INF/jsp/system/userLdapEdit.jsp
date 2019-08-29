<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="userEdit" />
<c:if test="${user.id == null}">
  <c:set var="title" value="userCreate" />
</c:if>
<title><fmt:message key="${title}" /></title>
<style type="text/css">
th.searchLabel {
width:30%;
}
</style>
<%-- <script type="text/javascript" src="<c:url value="/jquery/jquery-1.3.2.min.js" />"></script> --%>
	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>

<script type="text/javascript">
var siteMap = {
		<c:forEach var="site" items="${allSites}" varStatus="s">"${site.name}": "${site.id}"<c:if test="${!s.last}">,</c:if></c:forEach>
	};
jQuery(document).ready(function() {
	jQuery('.moduleSelect').select2({width:'40%'});
	jQuery('#domain').select2({width:'40%'});
	jQuery('#department').select2({width:'40%'});
	jQuery('#defaultSite').select2({width:'40%'});
	
  function activeChanged() {
	  jQuery("#licencesCell").toggle(jQuery('#activeField').is(':checked'));
  }
  jQuery('#activeField').click(activeChanged);
  activeChanged();
  onChangeSite();
});
	
function onChangeSite() {
    var site = jQuery('#defaultSite').find(':selected');
    if(site != null && site.val() != "")
    {
        var element = 'department';
	    var siteId = site.val();
	    if(siteId != '')
	    {
	    	var value = jQuery('#department').find(':selected').val();
		    DWRUtil.removeAllOptions(element);
		    DWRUtil.addOptions(element, {"":"Please Wait..."});
		    SystemDWRService.getQuestionOptionsArrayBySite(42, siteId, function(data) { populateCallback(element, data, value); });
	    }
    }
    else
    {
    	DWRUtil.removeAllOptions('department');
    }
  }
  
function onClickSiteGroup(chkbox, groupName) {
	if(chkbox.checked)
	{
		var siteId = siteMap[groupName];
		if(siteId != undefined)
	    	$("#defaultSite").append('<option value='+siteId+'>'+groupName+'</option>');
	}
	else
	{
		var siteId = siteMap[groupName];
		if(siteId != undefined)
			$("#defaultSite option[value='"+siteId+"']").remove();
	}
  }
  
  
function populateCallback(element, data, value) {
    DWRUtil.removeAllOptions(element);
    DWRUtil.addOptions(element, {"":" "});
    DWRUtil.addOptions(element, data);
    
    if(value) {
    	var options = document.getElementById(element).options;
	    for (var i=0, l=options.length; i<l ;i++) {
	        if (options[i].value == value) {
	            options[i].selected = true;
	        }
	    }
    }
  }
 	
</script>

</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form>
  <scannell:hidden path="id"/>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-responsive table-bordered">     
    <tbody>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="userDomain" /></th>
        <td class="search"><c:out value="${command.domain}"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="userName" /></th>
        <td class="search"><c:out value="${command.userName}"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="firstName" /></th>
        <td class="search"><c:out value="${command.firstName}"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="lastName" /></th>
        <td class="search"><c:out value="${command.lastName}"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="empId" /></th>
        <td class="search">
	        <c:choose>
	        	<c:when test="${editEmployeeId}">
        			<input name="empId" class="form-control" cssStyle="float:left;width:40%;"/>
	        	</c:when>
	        	<c:otherwise>
	        		<c:out value="${command.empId}"/>
	        	</c:otherwise>
	        </c:choose>
        </td>
      </tr>
	  <tr class="form-group">
        <th class="searchLabel"><fmt:message key="defaultSite" /></th>
        <td class="search">
          <select name="defaultSite" id="defaultSite" items="${sites}" itemValue="id" itemLabel="name" activeItemsOnly="true" class="wide" onchange="onChangeSite()"/>
        </td>
      </tr>
	
	   <tr class="form-group">
        <th class="searchLabel"><fmt:message key="department" /></th>
        <td class="search"><select name="department" id="department" items="${departments}" itemValue="id" itemLabel="name" activeItemsOnly="true" class="wide" /></td>
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
