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
var siteText = ' <fmt:message key="user.site" />';
var siteMap = {
		<c:forEach var="site" items="${allSites}" varStatus="s">"${site.name}": "${site.id}"<c:if test="${!s.last}">,</c:if></c:forEach>
	};
jQuery(document).ready(function() {
	jQuery('.moduleSelect').select2({width:'40%'});
	jQuery('#domain').select2({width:'40%'});
	jQuery('#department').select2({width:'40%'});
	jQuery('#defaultSite').select2({width:'40%'});
	jQuery("#age").attr( { type:"number", min:"0", max:"100" } );
	jQuery('#gender').select2({width:'40%'});
	
  function activeChanged() {
	  jQuery("#licencesCell").toggle(jQuery('#activeField').is(':checked'));
  }
  jQuery('#activeField').click(activeChanged);
  activeChanged();

  if(jQuery("#id").val() == 0) {
		jQuery(".group").each(function( index ) {
			if(jQuery(this).is(':checked')) {
				var groupName = jQuery(this).next('span').text().replace(siteText, "");
				var siteId = siteMap[groupName];
				if(siteId != undefined) {
			    	jQuery("#defaultSite").append('<option value='+siteId+'>'+groupName+'</option>');
				}
			 	var selectList = jQuery('#defaultSite option');
			  	jQuery('#defaultSite').html(selectList);
			}
		});
		var selectedSiteId = siteMap['${command.defaultSite}'];
		jQuery("#defaultSite").select2().select2('val', selectedSiteId).select2({width:'40%'});
		function updateSendPasswordSetup() {
			jQuery("#sendPasswordSetupEmailMessage").toggle(jQuery('#activeField').is(':checked'));
		}
		jQuery('#activeField').click(updateSendPasswordSetup);
  }
  onChangeSite();
 
  function sort(a,b){
      a = a.text.toLowerCase();
      b = b.text.toLowerCase();
      if(a > b) {
          return 1;
      } else if (a < b) {
          return -1;
      }
      return 0;
  }

  <%-- This is temp solution.
   Level 6 user which is as of now used a guest user should not be allowed to be created by user.
  --%>
  jQuery("#moduleSelect option[value='LEVEL6']").remove();
  
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
	    	jQuery("#defaultSite").append('<option value='+siteId+'>'+groupName+'</option>');
	}
	else
	{
		var siteId = siteMap[groupName];
		if(siteId != undefined)
			jQuery("#defaultSite option[value='"+siteId+"']").remove();
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
  <scannell:hidden id="id" path="id"/>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-responsive table-bordered">     
    <tbody>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="userDomain" /></th>
        <td class="search"><select name="domain" id="domain" items="${userDomains}" itemValue="id" itemLabel="name" class="wide" renderEmptyOption="false" /></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="userName" /></th>
        <td class="search"><input name="userName" class="form-control" cssStyle="float:left;width:40%;" /></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="firstName" /></th>
        <td class="search"><input name="firstName" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="lastName" /></th>
        <td class="search"><input name="lastName" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="user.gender" /></th>
        <td class="search">
        <%-- <input name="gender" class="form-control" cssStyle="float:left;width:40%;"/> --%>
        <select name="gender" id="gender"  class="narrow" >
        <scannell:option value="FEMALE" labelkey="female"/>
        <scannell:option value="MALE" labelkey="male" />
        <scannell:option value="OTHER" labelkey="other" />
        </scannell:select>
        </td>
      </tr>
        <tr class="form-group">
        <th class="searchLabel"><fmt:message key="user.age" /></th>
        <td class="search"><input name="age" id="age" class="form-control" cssStyle="float:left;width:40%;" /></td>
      </tr>
     <tr class="form-group">
        <th class="searchLabel"><fmt:message key="user.commenceDate" /></th>
        <td class="search">
    <%--   <input name="commenceDate" class="form-control" cssStyle="float:left;width:40%;"/> --%>
    
		<div class="col-sm-6">
			<div id="cal" style="width:250px;">
				<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy"	style="width:200px;float:left">
					<scannell:input class="form-control" path="commenceDate" id="commenceDate" readonly="true" />
					<span class="input-group-addon btn btn-primary">
					<span class="glyphicon glyphicon-th"></span>
					</span>
				</div>
			</div>
	</div>
      
      </td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="division" /></th>
        <td class="search"><input name="division" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="title" /></th>
        <td class="search"><input name="title" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="empId" /></th>
        <td class="search"><input name="empId" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="emailAddress" /></th>
        <td class="search"><input name="emailAddress" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="phoneNumber" /></th>
        <td class="search"><input name="phoneNumber" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="active" /></th>
        <td class="search">
        	<scannell:checkbox path="active" id="activeField" />
        	<div id="sendPasswordSetupEmailMessage" style="display:none">
	        	<br/>
	        	<p><fmt:message key="passwordSetupEmailWarning" /></p>
        	</div>
        </td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="user.postReportPost" /></th>
        <td class="search"><input name="postReportPost" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>
       <tr class="form-group">
        <th class="searchLabel"><fmt:message key="user.postNumber" /></th>
        <td class="search"><input name="postNumber" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>
       <tr class="form-group">
        <th class="searchLabel"><fmt:message key="user.userFieldDescription" /></th>
        <td class="search"><input name="userFieldDescription" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>


      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="groups" /></th>
        <td class="search">
          <spring:bind path="command.writableGroups">
            <div class="checkbox" >
            <table class="table" style="border: 0px;" style="width:100%">
              <c:forEach items="${groups}" var="group" varStatus="s">
              	<c:if test="${s.index mod 2 == 0}">
						<tr>
				</c:if>
                <c:set var="selected" value="${false}" />
                <c:forEach items="${command.groups}" var="selectedGroup">
                  <c:if test="${group.id == selectedGroup.id}"><c:set var="selected" value="${true}" /></c:if>
                </c:forEach><td style=" border:0px ">
                <label>
                <input type="checkbox" class="group" onClick="onClickSiteGroup(this, '${group.name}')" name="<c:out value="${status.expression}"/>" value="<c:out value="${group.id}" />" <c:if test="${selected}">checked="checked"</c:if> />
                  <span><c:out value="${group.name}" /> <c:if test="${group.siteGroup == true}"><font color="#017758"><fmt:message key="user.site" /></font></c:if></span><br />
                  </label></td>
                 <c:if test="${s.index mod 2 != 0}">
						</tr>
				</c:if>
				<c:if test="${s.last && s.index mod 2 == 0}">
						<td style=" border:0px "></td>
					</tr>
				</c:if>
              </c:forEach>
              </table>
            </div>
            <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
          </spring:bind>
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
        <td class="search"><select name="writableDepartment" id="department" items="${departments}" itemValue="id" itemLabel="name" activeItemsOnly="true" class="wide" /></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="workArea" /></th>
        <td class="search"><input name="dptCodeDescription" class="form-control" cssStyle="float:left;width:40%;"/></td>
      </tr>
      <tr class="form-group">
        <th class="searchLabel"><fmt:message key="modules" />:</th>
        <td class="search" id="licencesCell">
       	  <c:set var="moduleAccessLevels" value="${licence.moduleAccessLevels}" />	
          <spring:bind path="command.modules">
          <div class="panel">
          	<table class="table table-bprdered table-responsive">
              <c:forEach items="${licence.licencedModules}" var="licencedModule">
              <tr>
              	<c:set var="module" value="${licencedModule.module}" />
              	<c:if test="${not licence.unlimited}">
              		<c:set var="moduleUsageCheck" value="${moduleUsageCheckByModule[module]}" />
              		<c:set var="moduleUsedAndMaxByType" value="${moduleUsageCheck.usedAndMaxByType}" />
              	</c:if>
              	
				<th > <fmt:message key="${module.name}" /></th>
				<td>
					<scannell:select id="moduleSelect" class="moduleSelect" path="modules[${module.code}]" writeErrorsAfterEndTag="true" >
  					  <c:forEach items="${moduleAccessLevels[module]}" var="accessLevel">
						<fmt:message var="label" key="AccessLevel.${accessLevel}" />
		              	<c:choose>
		              		<c:when test="${licence.unlimited}">
								<scannell:option value="${accessLevel}" label="${label}" />
		              		</c:when>
		              		<c:otherwise>
				              	<c:set var="moduleUsedAndMax" value="${moduleUsedAndMaxByType[accessLevel]}" />
								<scannell:option value="${accessLevel}" label="${label} ${moduleUsedAndMax.left}/${moduleUsedAndMax.right}" />
		              		</c:otherwise>
		              	</c:choose>
					  </c:forEach>
					</scannell:select>
				</td>              	
              </tr>
              </c:forEach>
          	</table>
          	</div> 
            <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
          </spring:bind>
        </td>
      </tr>

	  <c:if test="${not empty assignableAccessRights}">
      <tr class="form-group">
        <th class="searchLabel" ><label><fmt:message key="user.assignableAccessRights" /></label></th>
        <td class="search">
          <spring:bind path="command.assignableAccessRights">
            <div class="checkbox" >
             <table class="table" style="border: 0px;" style="width:100%">           
              <c:forEach items="${assignableAccessRights}" var="role">
              <c:if test="${s.index mod 2 == 0}">
						<tr>
				</c:if>
				<td style=" border:0px ">
               <label>
              	<c:set var="roleId" value="${role.left}" />
              	<c:set var="roleName" value="${role.right}" />
                <c:set var="selected" value="${false}" />
                <c:forEach items="${command.assignableAccessRights}" var="selectedRole">
                  <c:if test="${roleId == selectedRole.id}"><c:set var="selected" value="${true}" /></c:if>
                </c:forEach>
                <input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${roleId}" />" <c:if test="${selected}">checked="checked"</c:if> />
                  <span><c:out value="${roleName}" /></span><br />
                   </label>
                   </td>
                    <c:if test="${s.index mod 2 != 0}">
						</tr>
				</c:if>
				<c:if test="${s.last && s.index mod 2 == 0}">
						<td></td>
					</tr>
				</c:if>
              </c:forEach>
              	<!-- <input type="checkbox" name="assignable" value="1" <c:if test="${command.assignable > 0}">checked="checked"</c:if>/>
                  <span><fmt:message key="user.permitToAssess" /></span> -->
             
              </table>
            </div>
            <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
          </spring:bind>
        </td>
      </tr>
      </c:if>

    </tbody>
    <tfoot>
      <tr>
        <td colspan="2" align="center">
        	<input type="submit" class="g-btn g-btn--primary" onclick="this.form.submit(); this.disabled=true;" value="<fmt:message key="submit"/> ">
			<input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/system/userQueryForm.htm"></c:url>'">
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
