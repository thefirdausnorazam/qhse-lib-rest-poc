<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"

%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html">
<html>
<head>
  
  <title><fmt:message key="quickLink.open.items" /></title>
  <style type="text/css">
  @media print {
	  .hidden-print {
	    display: none !important;
	  }
	}
.fieldChooser {
    width: 1200px;
    height: 470px;
    display: block;    
    padding-left:3cm;
    padding:1;    
    padding-top: 7px;
}

.fc-field {
    width: 200px;     
    margin: 10px;
    margin-bottom: 10px;
    padding: 5px;
    background-color: #ffffff;
    box-shadow: 0px 0px 10px 0px rgba(222, 222, 222, 1.0);
}

.fc-field:hover {
    outline: #cacaca solid 1px;
}

.fc-selected {
    background-color: #ffe284;
}

.fc-selected:hover {
    background-color: #ffd448;
}

.fc-field-list {
    width: 400px;
    height: 350px; 
    margin: 0px;
    padding: 3px;
    overflow: scroll;
}

.fc-source-fields {
     float: left; 
     display: block;
     padding-left: 2cm;
     /* border-style: solid;
    border-color: #F2DEDE; */
}

.fc-destination-fields {
    float: right;
    display: block;
   /* border-style: solid;
    border-color: #F2DEDE; */
}
.middle{
float: left;
display: block;
width: 200px;
height: 48px;
padding-left:4cm;
padding-top: 2cm;
}

 .panel-heading .accordion-toggle:after {
    /* symbol for "opening" panels */
    font-family: 'Glyphicons Halflings';  /* essential for enabling glyphicon */
    content: "\e114";    /* adjust as needed, taken from bootstrap.css */
    float: right;        /* adjust as needed */
    color: grey;         /* adjust as needed */
}
.panel-heading .accordion-toggle.collapsed:after {
    /* symbol for "collapsed" panels */
    content: "\e080";    /* adjust as needed, taken from bootstrap.css */
}


select {
	width: 200px;
}
		</style>
  <script type="text/javascript" src="<c:url value="/js/utils.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/incident.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/showUsers.js" />"></script>
  <script type="text/javascript">
  
  jQuery(window).load(function() {
	  var workSpa=getURLParam('workspace');
	  if(workSpa=='yes'){		  
		  jQuery('#sub').click();
		 
	  }
	});
  
  jQuery(document).ready(function(){
	  
	  var workSpa=getURLParam('workspace');
	  if(workSpa=='yes'){
		  moveAllRight();
		  toggleQueryDiv();
		  toggleQueryDiv();
	  }else{
		  jQuery('#queryForm').submit();
	  }
	
	     jQuery('#startDateFrom').val('${dtFrom}');
	     jQuery('#startDateTo').val('${dtTo}');
	     jQuery('#selectModel').val('${sModule}');
  		 jQuery("select").select2();
  
  		 
  
		 var sourceFields = jQuery("#sourceFields");
      	 var destinationFields = jQuery("#destinationFields");
      	 var chooser = jQuery("#fieldChooser").fieldChooser(sourceFields, destinationFields);

		  //jQuery("#responsibleUser").select2('val', ${currentUser.id});
		  var deptId = '${currentUser.department.id}';
		  jQuery("#departmentId").select2('val',
					jQuery('#departmentId option:eq(0)').val());
		  if(deptId != '')
		  {
			  var exists = 0 != jQuery('#departmentId option[value='+deptId+']').length;
			  if(exists)
			  {
			  	jQuery("#departmentId").select2('val', deptId);
			  }
		  }
		  populateFiledsFromCriteria();
		  
		  
		  // change user select when there are more 500 users in the list
		  var responsibleUserText='';
		  var responsibleUserId= '<c:out value="${currentUser.id}"/>';
		  if(responsibleUserId != null){
			 responsibleUserText= '<c:out value="${currentUser.sortableName}"/>';
			 jQuery('#responsibleUser').val(responsibleUserId);
			 if(jQuery("#responsibleUser").is("input") == false){ // only does this if it is not an INPUT html
			 	jQuery('#responsibleUser').select2('val', responsibleUserId);
			 }
		  }
		  showResponsibleUserList(${fn:length(userList)}, "100", "mPUserList.json", responsibleUserId,responsibleUserText);

		  
	 });  
  
  function populateFiledsFromCriteria(){
	  var itemString = '${openItemsQueryCriteria.itemType}';
	  var items = itemString.split("-");
	  for (i = 0; i < items.length; i++) { 
		    jQuery('#'+items[i]).appendTo("#destinationFields");
		    }
	  jQuery("#destinationFields .fc-selected")
	  jQuery('#startDateFrom').val('${openItemsQueryCriteria.stringStartDateFrom}');
	  jQuery('#startDateTo').val('${openItemsQueryCriteria.stringStartDateTo}');
	  if('${openItemsQueryCriteria}' != ''){
		  jQuery('#departmentId').val('${openItemsQueryCriteria.departmentId}').trigger('change');
	  }
	  

  }
  function moveSelected(obj) {
		 
		 if(jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields" || jQuery("#"+obj.id).parent().get( 0 ).id == "sourceFields2"){
			 moveSelectedRight();
		 } else if(jQuery("#"+obj.id).parent().get( 0 ).id == "destinationFields" || jQuery("#"+obj.id).parent().get( 0 ).id == "destinationFields2" ) {
			 moveSelectedLeft();
		 }
	 }
  function moveSelectedRight() {
		 //jQuery("#sourceFields2").find('div').removeClass('fc-selected');
		 //jQuery("#destinationFields2").find('div').removeClass('fc-selected');
		 jQuery("#destinationFields").append(jQuery(".fc-selected"));
		 if(jQuery(".fc-selected").text().indexOf('Audit Plan') > -1){
			 jQuery('#auditPlanText').show();
		 }
	 }
	 function moveSelectedLeft() {
		 //jQuery("#sourceFields2").find('div').removeClass('fc-selected');
		 //jQuery("#destinationFields2").find('div').removeClass('fc-selected');
		 //jQuery("#sourceFields").append(jQuery(".fc-selected"));
		 sorDivs("#sourceFields", jQuery("#destinationFields .fc-selected"));
		 cleanItemTypeList();
		 if(jQuery(".fc-selected").text().indexOf('Audit Plan') > -1){
			 jQuery('#auditPlanText').hide();
		 }
	 }
	 function moveAllRight(){
		 //jQuery("#sourceFields2").find('div').removeClass('fc-selected');
		 //jQuery("#destinationFields2").find('div').removeClass('fc-selected');
		 jQuery("#sourceFields").find('div').addClass('fc-selected');
		 jQuery("#destinationFields").append(jQuery(".fc-selected"));
		 unselect();
	 }
	 function moveAllLeft(){	
		 //jQuery("#sourceFields2").find('div').removeClass('fc-selected');
		 //jQuery("#destinationFields2").find('div').removeClass('fc-selected');
		 jQuery("#destinationFields").find('div').addClass('fc-selected');
		 jQuery("#sourceFields").append(jQuery(".fc-selected"));	
		 cleanItemTypeList();
		 unselect();
	 }
	 function unselect() {
			var array = jQuery('div.fc-selected');
			for (var i = 0; i < array.length; i++) {
				jQuery(array[i]).removeClass('fc-selected');
			}
		}
  function sorDivs(id, obj) {

		var sortedDivs = jQuery(id).children('div');
		if(sortedDivs.length > 0) {
			included = false;
			jQuery.each(sortedDivs, function (index, value) {
				if(obj.text() < value.textContent && included == false) {
					jQuery(id).append(obj);
					included = true;
				}
				jQuery(id).append(value);   //adding them to the body
				if(included == false) {
					jQuery(id).append(obj);
				}
			});
		} else {
			jQuery(id).append(jQuery(".fc-selected"));
		}
}
  function onPermissionSubmit() {
	  jQuery("#itemType").val('');
		var authorisedUsers1 = jQuery("#destinationFields").find("div").length;
	    var authorisedUsers = document.getElementById("authorisedUsers");
		
		for (var i = 0; i < authorisedUsers1; i++) {		
			var valu = jQuery("#destinationFields").find("div").eq(i).attr('id');		
			
			if (jQuery("#itemType").val().indexOf(valu) < 0) {
				jQuery("#itemType").val(jQuery("#itemType").val()+"-"+valu);
			}
		}
	}
  function cleanItemTypeList() {
	  jQuery("#itemType").val("");
  }
  
  
  function clearFormFields() {
	  
	  jQuery('#startDateFrom').val('');
	  jQuery('#startDateTo').val('');
	  
	  jQuery("#responsibleUser").select2('val',
				jQuery('#responsibleUser option:eq(0)').val());
	  jQuery("#departmentId").select2('val',
				jQuery('#departmentId option:eq(0)').val());
	  
	  jQuery('#name').val('');
	  
	  cleanItemTypeList();
	  moveAllLeft();
  }
  
  function beforeSubmit(){
	jQuery('#startDateFrom2').val(jQuery('#startDateFrom').val());
	jQuery('#startDateTo2').val(jQuery('#startDateTo').val());
	jQuery('#responsibleUser2').val(jQuery('#responsibleUser').val());
	jQuery('#departmentId2').val(jQuery('#departmentId').val());
	jQuery('#name2').val(jQuery('#name').val());
	jQuery('#overdue2').val(jQuery('#overdue').prop('checked'));
	jQuery('#noPrint').val('true');

	if(getURLParam('printable')){
		  jQuery('#noPrint').val('false');
	  }
	
      }
  function beforePrint(){
		  jQuery('#noPrint').val('false');

  }
  

  </script>
  
	<style type="text/css" media="all">
@import "<c:url value='/css/calendar.css'/>";
</style>
</head>
<body >
<c:set value="500" var="maxListSize"/>
 <input type="hidden" id="formName" name="formName" value="all">

 <div class="col-md-12 hidden-print">
		<div id="block" class="">
			<div>
				<div class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12">
					<div align="right">
					<input type="text" id="refreshCheck" value="no" style="display: none;">
					<form action="" method="get"
						onSubmit="if(!jQuery('#gotoId')) return false;">
						
						<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;Hide
							Search</button>
						
						<button  type="button" id="printButton" onclick="beforePrint();window.open(jQuery('#printParam').val()+'&print2=true&noPrint=false', '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					</form>
</div>
					
				</div>
			</div>
    	</div>
	</div>

<scannell:form id="queryForm" action="/enviro/generalOpenSearchResult.ajax" onsubmit=" return search(this, 'resultsDiv');">
<c:set var="criteria" value="${sessionScope.openItemsQueryCriteria}"/>
 <input type="hidden" id="itemType" name="itemType" value="${openItemsQueryCriteria.itemType}">
 <input type="hidden" id="startDateFrom2" name="startDateFrom2" value="${openItemsQueryCriteria.startDateFrom}">
 <input type="hidden" id="startDateTo2" name="startDateTo2" value="${openItemsQueryCriteria.startDateTo}">
 <input type="hidden" id="responsibleUser2" name="responsibleUser2" value="${openItemsQueryCriteria.responsibleUser.id}">
 <input type="hidden" id="departmentId2" name="departmentId2" value="${openItemsQueryCriteria.departmentId}">
 <input type="hidden" id="name2" name="name2" value="${openItemsQueryCriteria.departmentId}">
  <input type="hidden" id="noPrint" name="noPrint" value="false">
  <input type="hidden" id="overdue2" name="overdue2" value="false">

 <scannell:hidden path="calculateTotals" />
<scannell:hidden path="pageNumber" />
 <scannell:hidden path="pageSize" />
 <input type="hidden" name="currentUser" id="currentUser" value="${currentUser}"/>
 <div id="queryDiv" class="hidden-print">
 <div>
 <div class="header">
					<h3>
						<fmt:message key="searchCriteria" />
					</h3>
				</div>
<table id="queryTablea" class="table table-bordered table-responsive noprint" >
<tbody id="searchCriteria" >
  <tr class="form-group">
      <td class="searchLabel">
		<fmt:message key="responsibleUser" />:
	  </td>
	  <td  class="search">
	  	<c:if test="${openItemsSearchFields}">
	  		<c:choose>
				<c:when test="${fn:length(userList)  lt maxListSize && fn:length(userList) > 0}">
					<scannell:select  path="responsibleUser" id="responsibleUser" items="${userList}" itemLabel="sortableName" cssStyle="width:300px" itemValue="id" renderEmptyOption="true"  />
				</c:when>
				<c:otherwise>
					<input type="hidden" id="responsibleUser" name="responsibleUser" />
				</c:otherwise>
			</c:choose>
		</c:if>
		<c:if test="${!openItemsSearchFields}">
			<select id="responsibleUser" name = "responsibleUser" style="width:300px"><option value="${currentUser.id}">${currentUser.displayName }</option></select>
		</c:if>
		</td>
    <td  class="searchLabel"><fmt:message key="responsibleDepartment" />:</td>
    <td class="search">
    	<select name="departmentId" id="departmentId" class="wide" style="width: 300px" >
	        <option value="0">Choose</option>
	    	<c:forEach items="${departments}" var="item">
	          <option value="<c:out value="${item.id}" />" ><c:out value="${item.name}" /></option>
	        </c:forEach>
	   </select>
	</td>
  </tr>

  <tr class="form-group">
    <td id="startDateFromLabel" class="searchLabel"> <fmt:message key="from" />:</td>
    <td class="search">
      	<div id="cal" style="width: 250px;">
			<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
				<input id="startDateFrom" class="form-control" type="text" name="startDateFrom" readonly="readonly">
				<span class="input-group-addon btn btn-primary">
					<span class="glyphicon glyphicon-th"></span>
				</span>
			</div>
		</div>
    </td>
    <td id="startDateToLabel" class="searchLabel"><fmt:message key="to" />:</td>
    <td class="search">
      <div id="cal" style="width: 250px;">
			<div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 200px;">
				<input id="startDateTo" class="form-control" type="text" name="startDateTo" readonly="readonly">
				<span class="input-group-addon btn btn-primary">
					<span class="glyphicon glyphicon-th"></span>
				</span>
			</div>
		</div>
    </td>
  </tr>
  
<tr class="form-group">  
  <td class="searchLabel">
		<fmt:message key="description" />:
  </td>
  <td class="search">
  	<input name="name" id="name" class="form-control" cssStyle="width:82%;"/><span style="display:none;color: red;" id="auditPlanText">For Audit Plan Year please use the description field.</span>
  </td>
  <td class="searchLabel">
		<fmt:message key="overdue" />:
  </td>
  <td  class="search">
  	<scannell:checkbox path="overdue" id="overdue" />
  </td>
</tr>
<tr class="form-group">
	<td colspan="4" class="searchLabel" align="center">
		<div class="content">  
			<div class="table-responsive">
			<div class="panel hidden-print" id="accordion1" >
			
			 <div id="collapse1" class="panel-collapse collapse in" >
			 <div id="fieldChooser" tabIndex="1" class="fieldChooser" style=" margin: 0 auto;">
			 			<input type="hidden" name="<c:out value="_${status.expression}"/>" />
						<span class="errorMessage"><c:out
								value="${status.errorMessage}" /></span>
						
			        <div id="sourceFields"  >
			            <c:if test="${fn:contains(licences, 'risk')}"><div id="Objective" ondblclick="moveSelected(this)" ><c:out value="Objective" /></div> </c:if>
			            <c:if test="${fn:contains(licences, 'risk')}"><div id="Target" ondblclick="moveSelected(this)" ><c:out value="Target" /></div></c:if>
			            <c:if test="${fn:contains(licences, 'risk')}"><div id="ManagementProgramme" ondblclick="moveSelected(this)" ><c:out value="Management Programme" /></div></c:if>
			            <c:if test="${fn:contains(licences, 'risk')}"><div id="RiskAssessment" ondblclick="moveSelected(this)" ><c:out value="Risk Assessment" /></div> </c:if>
			            <c:if test="${fn:contains(licences, 'risk')}"><div id="RATask" ondblclick="moveSelected(this)" ><c:out value="Task(RA)" /></div></c:if>
			            <c:if test="${fn:contains(licences, 'risk')}"><div id="MPTask" ondblclick="moveSelected(this)" ><c:out value="Task(MP)" /></div></c:if>
			            <c:if test="${fn:contains(licences, 'incident')}"><div id="Incident" ondblclick="moveSelected(this)" ><c:out value="Incident" /></div></c:if>
			            <c:if test="${fn:contains(licences, 'incident')}"><div id="TaskInci" ondblclick="moveSelected(this)" ><c:out value="Task(Incident)" /></div></c:if>
			            <c:if test="${fn:contains(licences, 'incident')}"><div id="Action" ondblclick="moveSelected(this)" ><c:out value="Action" /></div> </c:if>
			            <c:if test="${fn:contains(licences, 'law')}"><div id="LawTask" ondblclick="moveSelected(this)" ><c:out value="Task(Law)" /></div></c:if>
			            <c:if test="${fn:contains(licences, 'audit')}"><div id="Audit" ondblclick="moveSelected(this)" ><c:out value="Audit" /></div> </c:if>
			            <c:if test="${fn:contains(licences, 'audit')}"><div id="AProgramme" ondblclick="moveSelected(this)" ><c:out value="Audit Programme" /></div> </c:if>
			            <c:if test="${fn:contains(licences, 'data')}"><div id="Tranning" ondblclick="moveSelected(this)" ><c:out value="Training" /></div></c:if>
			            <c:if test="${fn:contains(licences, 'data')}"><div id="PPE" ondblclick="moveSelected(this)" ><c:out value="PPE" /></div></c:if>
			            <c:if test="${fn:contains(licences, 'data')}"><div id="Equipment" ondblclick="moveSelected(this)" ><c:out value="Equipment" /></div> </c:if>
			            <c:if test="${fn:contains(licences, 'data')}"><div id="Waste" ondblclick="moveSelected(this)" ><c:out value="Waste" /></div>    </c:if>  
			            <c:if test="${fn:contains(licences, 'change')}"><div id="ChangeProgramme" ondblclick="moveSelected(this)" ><c:out value="Change Programme" /></div>    </c:if> 
			            <c:if test="${fn:contains(licences, 'change')}"><div id="ChangeAssessment" ondblclick="moveSelected(this)" ><c:out value="Change Assessment" /></div>    </c:if>       
			        </div>
			        <div align="center" class="middle" style="padding-right: 2cm;padding-left: 2cm;">
					<input type="button" class="btn btn-primary btn-block" name="right" value="&gt;&gt;"     onclick="moveSelectedRight();" id="userRightButton" /><br /> <br />
					<input type="button" class="btn btn-primary btn-block" name="right" value="all &gt;&gt;" onclick="moveAllRight();" /><br /><br />
					<input type="button" class="btn btn-primary btn-block" name="left"  value="&lt;&lt;"     onclick="moveSelectedLeft();" /><br /><br />
					<input type="button" class="btn btn-primary btn-block" name="left"  value="all &lt;&lt;" onclick="moveAllLeft();" />
				   </div>	   
			            <div id="destinationFields" style="float: left;">
			            
			            
			            
			            </div>
			   </div> 
			   </div>
			 </div>	
			</div>
			</div>
	</td>
</tr>
								
</tbody>
<tfoot>
  <tr>
    <td colspan="4" style="text-align: center">
	    <div class="spacer2 text-center">
	      <button id="sub" type="submit" class="g-btn g-btn--primary" onClick="beforeSubmit();onPermissionSubmit();this.form.pageNumber.value = 1;toggleQueryDiv();"><fmt:message key="search" /></button>
          
	      <button type="button" onClick="clearFormFields();" class="g-btn g-btn--secondary"><fmt:message key="reset" /></button>
	                             
	    </div>
    </td>
  </tr>
</tfoot>
</table>
<select id="authorisedUsers"  class="dropfalse" name="authorisedUsers" multiple="multiple" size="10" style="display:none;" ondblclick="moveSelectedOptions(this.form['authorisedUsers'],this.form['unselected'])" >
		</select>
</div>
</div>



<div id="resultsDiv"></div>
</scannell:form>
</body>
</html>
