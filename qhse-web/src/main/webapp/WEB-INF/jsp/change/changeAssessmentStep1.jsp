<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager"
	uri="https://www.envirosaas.com/tags/enviromanager"%>
	
<c:url var="linkUrl" value="/doclink/linkView.htm"></c:url>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<c:set var="title" value="changeAssessment.edit" />
	<c:set var="programType" value="${programmes}" />
	<c:if test="${command.change.change == null}">
		<c:set var="title" value="changeAssessment.create" />
	</c:if>
	<title></title>

	<%-- <script type="text/javascript" src="<c:url value="/js/scriptaculous.js" />" ></script> --%>
	<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

	<script type="text/javascript">
	jQuery(document).ready(function() {		
		jQuery('select').select2({width:'300px'});
		
		jQuery(".date").find(".requiredHinted").remove();
		var spanMsg = jQuery('#targetTechnicalCloseoutDateDiv').find('.error');
		jQuery('#targetTechnicalCloseoutDateDiv').find('.error').remove();
		jQuery('#targetTechnicalCloseoutDateColumn .errorMessage').append(spanMsg);
		
		onPageLoad();
		//init();
		
	});
	function onPageLoad(){
		var automaticCreateAction = document.getElementById("automaticCreateAction").value;;

		accessUrls();
		if(automaticCreateAction == 'true'){
			var hazapRequired = document.getElementById("hazopRequired");
			if(hazapRequired != null)
				hazapRequired.style.display='none';
			var labelHazopRequired = document.getElementById("labelHazopRequired");
			if(labelHazopRequired != null)
				labelHazopRequired.style.display='none';
			var furtherAssessmentRequired = document.getElementById("furtherAssessmentRequired");
			if(furtherAssessmentRequired != null)
				furtherAssessmentRequired.checked=true;
			//toggleFurtherAssessmentRequired(furtherAssessmentRequired);
		}
	}
	
	function onTypeChange(typeSel) {
		jQuery("#templateChange").val("true");
		  var form = jQuery("#changeForm"); 
		  form.submit();

	}
	
	function accessUrls() {
		var currentUser=document.getElementById('currentUser').value;
		var owner=document.getElementById('owner').value;
		
		var submitButton = document.getElementById("submitButton");
		var nextButton = document.getElementById("nextButton");
		var lockdownOwner = document.getElementById("lockdownOwner");
			
		var createrIsOwner = (owner == currentUser);
		var lockdownOwnerChecked = document.getElementById("lockdownOwner").checked;
		createrIsOwner==true ? nextButton.style.display='inline' : lockdownOwnerChecked==true ? nextButton.style.display='none' : nextButton.style.display='inline';
		createrIsOwner==true ? submitButton.style.display='none' : lockdownOwnerChecked==true ? submitButton.style.display='inline' : submitButton.style.display='none';

	}
	
/* 	function showLink() {
		var programTypeId=1;
		var programmes = '<c:out value="${programmes}" />';
		//alert('<c:out value="${programmes[1].type.id}" />');
		var selectedProgType=$jq("#scoringQuestion option:selected" ).text();
		for(var i = 0; i < programmes.length; i++){
			var programtypeName = '<c:out value="${programmes[i].type.name}" />';
			if((selectedProgType.length>0)&&(programtypeName ==selectedProgType)){
				alert("match: "+programtypeName+"  "+ selectedProgType)
				programTypeId = '<c:out value="${programmes[i].type.id}" />';
			}
		}
		if(programTypeId != null){
			//var id =1; // FIXME - set it to the id of the changeprogrammeType not changeProgramme.
			//var id = programmeId.children[programmeId.selectedIndex].value
			//var url	= '/enviro-web/doclink/linkView.htm?name=ChangeProgrammeType[' + id + ']';
			var url	=contextPath+'/change/programmeTypeView.htm?id=' + programTypeId;
		
			alert(url);
			openPopup(url, 700, 400);
			linkDislayed=true;
		}		

	}	 */
	
	
	function showLink() {
		//
		var programmeId = document.getElementById("programmeId");
		if(programmeId != null){
			var id =1; // FIXME - set it to the id of the changeprogrammeType not changeProgramme.
			//var id = programmeId.children[programmeId.selectedIndex].value
			//var url	= '/enviro-web/doclink/linkView.htm?name=ChangeProgrammeType[' + id + ']';
			var url	= '<c:out value="${linkUrl}" />' + '?name=ChangeProgrammeType[' + id + ']';
		}else{
			var url = '<c:out value="${linkUrl}" />' + '?name=ChangeProgrammeType[' + '<c:out value="${command.change.programme.type.id}" />' + ']';
		}
		var docUrl=contextPath+'/doclink/linkSearchForm.htm';
		openPopup(docUrl, 700, 400);
		linkDislayed=true;
	}
	function openPopup(url, w, h) {
	    var x = (screen.height - h) / 2, y = (screen.width - w) / 2;
	    var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width="+w+",height="+h+",top="+x+",left="+y + "";
	    var win = window.open(url, "links", att);
	    win.focus();
	}	
	
	</script>

	<style type="text/css" media="all">
		@import "<c:url value='/css/calendar.css'/>";
    	@import "<c:url value='/css/change.css'/>";		
	</style>
</head>
<body>
<div class="content">
<ul class="caMenu">
				<c:choose>
					<c:when test="${command.change.id != null}">
					    <li class="selected"> Change Assessment <i class="fa fa-chevron-circle-right fa-1g"></i></li>  
						<c:if test="${param.showId != null}">
							<li id="step2" style="display: none"><a
								href="<c:url value="/change/changeAssessmentStep2.htm"><c:param name="showId" value="${param.showId}" /></c:url>"
								onclick="<fmt:message key="warning.changeAssessmentTab" />">Checklist</a></li>
						</c:if>
						<c:if test="${param.showId == null}">
							<li id="step2" style="display: none">Checklist</li>
						</c:if>
					</c:when>
					<c:otherwise>
					    <li class="selected"> Change Assessment <i class="fa fa-chevron-circle-right fa-1g"></i></li>    
					    <li>Checklist</li>    
				  </c:otherwise>
				</c:choose>
				</ul>
<c:set var="progBa" value="${command.change.programme.businessAreas}"/>
	<scannell:form id="changeForm" >
<div class="content">
			<div class="table-responsive">
				<div class="panel">
				<input type="hidden" id="templateChange" name="templateChange" value="" />
				<input type="hidden" name="currentUser" id="currentUser" value="${currentUser}"/>
				<input type="hidden" name="automaticCreateAction" id="automaticCreateAction" value="${command.change.programme.type.automaticCreateAction}"/>
				
				<table class="viewForm" style="margin-top:0px;">
				<col class="label" />
				<tbody>				
					<tr>
						<c:if test="${command.change.change != null}">
				    		<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.status" />:</td>
				    		<td id="changeAssessmentStatus"><fmt:message key="changeAssessment${command.change.status}" /></td>
				    	</c:if>    			
					</tr>
					<tr>		
						<td class="scannellGeneralLabel"><fmt:message key="changeTemplate" />:</td>
						
						<td><scannell:select id="templateId" path="change.template" items="${templates}" itemValue="id" itemLabel="name" class="wide" onchange="onTypeChange(this);"/>
						<span class="requiredHinted template-required">*</span>
						          <span class="errorMessage template-required"><c:if test="${changeTemplate != null}"><fmt:message key="${changeTemplate}" /></c:if></span></td>
					</tr>
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
						<td colspan="3" class="changeAssessmentStatus" id="assessmentBusinessAreas">
	      					<input type="hidden" name="_change.businessAreas" value="xxx" />
							<spring:bind path="command.change.businessAreas">
						          <label style="font-weight: normal;">
						          <c:forEach var="ba" items="${businessAreaList}">
						            <c:set var="selected" value="${false}" />
						            <c:forEach items="${command.change.businessAreas}" var="selectedBA">
						              	<c:if test="${ba.id == selectedBA.id}"><c:set var="selected" value="${true}" /></c:if>
						            </c:forEach>
									<input type="checkbox" 
									name="<c:out value="${status.expression}"/>" 
									value="<c:out value="${ba.id}" />" 
	                				<c:if test="${not enviromanager:contains(progBa,ba)}">disabled="disabled"</c:if>
									<c:if test="${selected}">checked="checked"</c:if>/><span><c:out value="${ba.name}" /></span><br />
						            <%-- <input class="ckbBA" type="checkbox" id="businessAreas" 
						                name="<c:out value="${status.expression}"/>"
						                value="<c:out value="${ba.id}" />"
						                <c:if test="${selected}">checked="checked"</c:if> />
						            <c:out value="${ba.name}" /><br> --%>
						
						            <c:remove var="selected" />
						          </c:forEach>
						          </label>
						          <span class="requiredHinted">*</span>
						          <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
						        </spring:bind>
						</td>
					</tr>
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.initiator" />:</td>
						<td><select name="change.initiator" items="${initiators}" itemValue="id" itemLabel="sortableName" class="wide" /></td>
					</tr>
					
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.department" />:</td>		
						<td><select name="change.department" items="${departments}" itemValue="id" itemLabel="name" class="wide" />
						<span class="requiredHinted template-required">*</span>
						          <span class="errorMessage template-required"><c:if test="${changeDepartment != null}"><fmt:message key="${changeDepartment}" /></c:if></span></td>		
					</tr>
					
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.owner" />:</td>
						<td><select name="change.owner" id ="owner" items="${owners}" itemValue="id" itemLabel="sortableName" class="wide" onchange="accessUrls();"/></td>
					</tr>
							
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.title" />:</td>
						<td><input name="change.name" class="wide" /></td>
					</tr>
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.description" />:</td>
						<td><scannell:textarea path="change.description" cols="75" rows="3" /></td>
					</tr>
						
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.targetApprovedDate" />:</td>
						<td>	
							<div id="reviewDateDiv2" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width: 250px;float:left;">
								<scannell:input id="targetApprovedDate" path="change.targetApprovedDate" class="form-control" cssStyle="float:left;" readonly="true" />
											<!--   <input type="text" id="idPlaceHolderEndDate" name="incident.investigation.recouperationPeriods.periodEndDate" class="form-control" readonly="readonly">	 -->
									<span class="input-group-addon btn btn-primary">
										<span class="glyphicon glyphicon-th"></span>
									</span>
							</div>
							<span class="requiredHinted">*</span>
							<span class="errorMessage">
								<c:out value="${status.errorMessage}" />
							</span>
						</td>				
					</tr>	
				
					<tr>
						<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.lockdownOwner" /></td>
						<td>
							<scannell:checkbox id="lockdownOwner" path="change.lockdownOwner" onclick="accessUrls();"/>
						</td>
					</tr>	
							
					<c:forEach items="${command.change.template.detailsQuestionGroups}" var="g">
					    <c:if test="${g.active}">
					      <c:if test="${g.name != null && g.name != ''}">
					      <tr><td colspan="4"  class="scannellGeneralLabel" style="background-color:#DDDDDD;font-weight:bold;"><c:out value="${g.name}"/></td></tr>
					      </c:if>
					      <c:forEach items="${g.questions}" var="cq">
					      	<c:set var="q" value="${cq.question}" />
					        <c:if test="${cq.active && q.active}">
					          <tr>
					          <c:choose>
					            <c:when test="${q.answerType.name == 'label'}">
					              <td colspan="4" class="scannellGeneralLabel"><c:out value="${q.name}" /></td>
					            </c:when>
					            <c:otherwise>
					              <td class="scannellGeneralLabel"><c:out value="${q.name}" />:</td>
					              <td><enviromanager:question path="change.answers" question="${q}" emptyOptionLabel="Choose" required="${cq.mandatory}" /></td>
					            </c:otherwise>
					          </c:choose>
					          </tr>
					        </c:if>
					      </c:forEach>
					    </c:if>
					</c:forEach>

				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" align="center">
							<input id="submitButton" type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">			
							<input id="nextButton" class="g-btn g-btn--primary"  style="display: none" type="submit" value="<fmt:message key="next" />">
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
