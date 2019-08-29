<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import = "com.scannellsolutions.users.User"
import = "com.scannellsolutions.modules.incident.domain.IncidentRoles"
import = "com.scannellsolutions.modules.action.domain.ActionRoles"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
  <!--<meta name="printable" content="true">-->
  <title></title>  
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>  
  <script type="text/javascript" src="<c:url value="/js/moveSite.js" />"></script>  
  <script type="text/javascript">
  jQuery(document).ready(function(){
	  dateLoad();	
	  initSortTables();
	  toggleQueryDiv();
  }); 
 
  function clearForm(){
	  document.getElementById('groupForm').reset();	  
  }
  
  function dateLoad(){
	  var gForm = document.getElementById('groupForm');
	  if(gForm){
	  document.getElementById('groupForm').reset();	
	  var fr=jQuery("#from").val();
	  var t= jQuery("#to").val();
	  jQuery("#fromOccurredDate").val(fr);
	  jQuery("#toOccurredDate").val(t);
  }
  }
 
	  
  </script>
</head>

<common:moveSite recordType="incident"/>
<c:set var="actionLabel"><fmt:message key="action"/></c:set>
<c:set var="taskLabel"><fmt:message key="task"/></c:set>
<body onLoad="dateLoad();">
<div class="content">

<div class="col-md-12">
		<div id="block" class="">
			<div>
				<div class="col-md-6">
				</div>
				<div class="col-md-12 col-sm-12">
					<div align="right">
					<input type="text" id="refreshCheck" value="no" style="display: none;">
					
						<button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryDiv();">&nbsp;<fmt:message key="search.hideSearch" /></button>				
						<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
					
</div>
					
				</div>
			</div>
    	</div>
	</div>
 
 <form id="groupForm" class="form-horizontal group-border-dashed" action="<c:url value="/incident/home.htm" />" method="get"> 
 <div id="queryDiv">
 <div class="header">
<h3><fmt:message key="searchCriteria" /></h3>
</div>
 <div class="col-sm-12 col-md-12"> 

 
                                <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startDate" /> <fmt:message key="from" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7"  data-min-view="2" data-date-format="dd-MM-yyyy">
                                        <input class="form-control" size="16" id="fromOccurredDate" name="fromOccurredDate" type="text"  readonly>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="startDate" /> <fmt:message key="to" /></label>
									<div class="col-sm-6">
										<div class="input-group date datetime col-md-5 col-xs-7" data-min-view="2" data-date-format="dd-MM-yyyy">
                                        <input class="form-control" size="16" id="toOccurredDate" name="toOccurredDate" type="text"  readonly>
                                        <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                                        </div>
									</div>
								</div>
 <div class="spacer2 text-center">
      <button type="submit" class="g-btn g-btn--primary"><fmt:message key="search" /></button>      
      <button type="button" class="g-btn g-btn--secondary" onClick="clearForm()"><fmt:message key="reset" /></button>
      </div>

</div>
</div>
</form>

<%User user = (User) request.getAttribute("user");%>
<c:set var="showUnassigned" value="${unassignedIncidents != null}" />

<a name="incidents"></a>
 <div class="header">
<h3><fmt:message key="openIncidentsAssignedToMe" /></h3>
</div>
<div class="content">
	<div class="table-responsive">
        <div class="panel" >   
        <c:choose>
	        <c:when test="${empty assignedSite}">
	        	<table class="table table-bordered  table-responsive dataTable">
	        		<thead>
					    <tr>
					      <th><fmt:message key="id" /></th>
					      <th><fmt:message key="type" /></th>
					      <th><fmt:message key="severity" /></th>
					      <th><fmt:message key="status" /></th>
					      <th><fmt:message key="incident.home.manDaysLost" /></th>
					      <th><fmt:message key="occurredDate" /></th>
					      <th><fmt:message key="location" /></th>
					      <th><fmt:message key="createdBy" /></th>
					    </tr>
				  	</thead>
	        	</table>
	        </c:when>
	        <c:otherwise>
				 <c:forEach items="${assignedSite}" var="inci" varStatus="s"> 
				    <table class="table table-bordered  table-responsive dataTable">
				    	<caption><c:out value="${inci}" /></caption>
						  <thead>
						    <tr>
						      <th><fmt:message key="id" /></th>
						      <th><fmt:message key="type" /></th>
						      <th><fmt:message key="severity" /></th>
						      <th><fmt:message key="status" /></th>
						      <th><fmt:message key="incident.home.manDaysLost" /></th>
						      <th><fmt:message key="occurredDate" /></th>
						      <!-- th><fmt:message key="causeType" /></th-->
						      <th><fmt:message key="location" /></th>
						      <th><fmt:message key="createdBy" /></th>
						    </tr>
						  </thead>
						  <tbody>
						    <c:if test="${empty assignedIncidents}">
						      <tr class="odd">
						        <td colspan="7"><fmt:message key="none" /></td>
						      </tr>
						    </c:if>          
						      <c:choose>
						        <c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
						        <c:otherwise><c:set var="style" value="odd" /></c:otherwise>
						      </c:choose>  	
					      <c:forEach items="${assignedIncidents}" var="incident" varStatus="c">
						       <c:if test="${incident.status.name != 'incident.closed'}">
							       <c:if test="${incident.site.name == inci}">
								       <tr class="<c:out value="${style}" />">            
									        <td><a onclick='changeSite("<c:url value="viewIncident.htm"><c:param name="id" value="${incident.id}"/></c:url>", ${incident.site.id}, "${incident.site}", ${currentSite})' href="#" ><c:out value="${incident.id}" /></a></td>
									        <td><fmt:message key="${incident.type.type.key}" /> : <c:out value="${incident.type.name}" /></td>        
									        <td>
									          <c:if test="${incident.severity == null}"><fmt:message key="none" /></c:if>
									          <c:if test="${incident.severity != null}"><fmt:message key="${incident.severity}" /></c:if>
									        </td>
									        <td><fmt:message key="${incident.status.name}" /></td>
									        <td><c:out value="${incident.investigation.manDaysLost}" /></td>
									        <td><fmt:formatDate value="${incident.occurredTime}" pattern="dd-MMM-yyyy" /></td>
									        <td>
									          <c:if test="${incident.equipmentLocation != null}"><c:out value="${incident.equipmentLocation.name}" /></c:if>
									          <c:if test="${incident.equipmentLocation == null && incident.location != 'default location'}"><c:out value="${incident.location}" /></c:if>
									        </td>
									        <td><c:out value="${incident.createdByUser.displayName}" /></td>
								      	</tr>
							       	</c:if>
						        </c:if>
					      </c:forEach>      
					  </tbody>
					</table>      
				</c:forEach>
			</c:otherwise>
		</c:choose>
    </div>
  </div>
</div>



<%if (user.isInRole(IncidentRoles.EDIT_INCIDENT)) { %>
<c:if test="${showUnassigned}">
<a name="unassigned"></a>

<div class="header">
<h3><fmt:message key="openUnassignedIncidents" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel" >
        <c:choose>
	        <c:when test="${empty unassignedIncidentsSite}">
	        	<table class="table table-bordered  table-responsive dataTable">
	        		<thead>    
					    <tr>
					      <th><fmt:message key="id" /></th>
					      <th><fmt:message key="type" /></th>
					      <th><fmt:message key="severity" /></th>
					      <th><fmt:message key="status" /></th>
					      <th><fmt:message key="occurredDate" /></th>
					      <th><fmt:message key="location" /></th>
					      <th><fmt:message key="createdBy" /></th>
					    </tr>
				  	</thead>
	        	</table>
	        </c:when>
	        <c:otherwise>
  <c:forEach items="${unassignedIncidentsSite}" var="inci" varStatus="s">
		  <c:if test="${!empty unassignedIncidentsSite}"> 
		  <table class="table table-bordered table-responsive dataTable">
		  		<caption><c:out value="${inci}" /></caption>
				<thead>    
				    <tr>
				      <th><fmt:message key="id" /></th>
				      <th><fmt:message key="type" /></th>
				      <th><fmt:message key="severity" /></th>
				      <th><fmt:message key="status" /></th>
				      <th><fmt:message key="occurredDate" /></th>
				      <!--th><fmt:message key="causeType" /></th-->
				      <th><fmt:message key="location" /></th>
				      <th><fmt:message key="createdBy" /></th>
				    </tr>
				  </thead>
				  <tbody>
					  	<c:if test="${empty unassignedIncidents}">
					      <tr class="odd">
					        <td colspan="7"><fmt:message key="none" /></td>
					      </tr>
					    </c:if>         
					    <c:forEach items="${unassignedIncidents}" var="incident" varStatus="s">
					      <c:choose>
					        <c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
					        <c:otherwise><c:set var="style" value="odd" /></c:otherwise>
					      </c:choose>
					      <c:if test="${incident.site.name == inci}">
					      <tr class="<c:out value="${style}" />">
							<td><a onclick='changeSite("<c:url value="viewIncident.htm"><c:param name="id" value="${incident.id}"/></c:url>", ${incident.site.id}, "${incident.site}", ${currentSite})' href="#" ><c:out value="${incident.id}" /></a></td>
							<td><fmt:message key="${incident.type.type.key}" /> : <c:out value="${incident.type.name}" /></td>
					        <td><c:if test="${incident.severity != null}"><fmt:message key="${incident.severity}" /></c:if></td>
					        <td><fmt:message key="${incident.status.name}" /></td>
					        <td><fmt:formatDate value="${incident.occurredTime}" pattern="dd-MMM-yyyy" /></td>
					        <td>
					        	<c:if test="${incident.equipmentLocation != null}"><c:out value="${incident.equipmentLocation.name}" />
					        	</c:if>
					        	<c:if test="${incident.equipmentLocation == null && incident.location != 'default location'}"><c:out value="${incident.location}" />
					        	</c:if>
							</td>
					        <td><c:out value="${incident.createdByUser.displayName}" /></td>
					      </tr>
					      </c:if>
				    	</c:forEach>  
			    	</tbody>
			</table>
			</c:if>
    </c:forEach> 
    </c:otherwise>
    </c:choose> 
        </div>
</div>
</div>
</c:if>
<%} %>



<a name="incompleteActions"></a>
<div class="header">
<h3><fmt:message key="incompleteActionsAssignedToMe" /></h3>
</div>
<div class="content">
<div class="table-responsive">
  <div class="panel" id="accordion4" >
        <c:choose>
	        <c:when test="${empty incompleteActionsSite}">
	        	<table class="table table-bordered  table-responsive dataTable">
	        		<thead>   
					    <tr>
					      <th><fmt:message key="id" /></th>
					      <th><fmt:message key="type" /></th>
					      <th><fmt:message key="completionTargetDate" /></th>
					      <th><fmt:message key="description" /></th>
					      <th><fmt:message key="createdBy" /></th>
					    </tr>
				 	</thead>
	        	</table>
	        </c:when>
	        <c:otherwise>
	    <c:forEach items="${incompleteActionsSite}" var="act" varStatus="s">
		    <c:if test="${!empty incompleteActionsSite}"> 
			    <table class="table table-bordered table-responsive dataTable">
			    	<caption><c:out value="${act}" /></caption>
					<thead>   
					    <tr>
					      <th><fmt:message key="id" /></th>
					      <th><fmt:message key="type" /></th>
					      <th><fmt:message key="completionTargetDate" /></th>
					      <th><fmt:message key="description" /></th>
					      <th><fmt:message key="createdBy" /></th>
					    </tr>
					  </thead>
					  <tbody>
						    <c:if test="${empty incompleteActions}">
						      <tr class="odd">
						        <td colspan="7"><fmt:message key="none" /></td>
						      </tr>
						    </c:if>   
						    <c:forEach items="${incompleteActions}" var="action" varStatus="s">
							      <c:choose>
							        <c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
							        <c:otherwise><c:set var="style" value="odd" /></c:otherwise>
							      </c:choose>
							      <c:if test="${action.site.name == act}">
								      <tr class="<c:out value="${style}" />">
								        <td><a onclick='changeSiteOfType("<c:url value="viewAction.htm"><c:param name="id" value="${action.id}"/></c:url>", ${action.site.id}, "${action.site}", ${currentSite}, "${actionLabel}")' href="#"><c:out value="${action.id}" /></a></td>
								        <td><fmt:message key="${action['class'].name}" /></td>
								        <td><fmt:formatDate value="${action.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
								        <td><div><c:out value="${action.description}" /></div></td>
								        <td><c:out value="${action.createdByUser.displayName}" /></td>
								      </tr>
								  </c:if>
	    					</c:forEach>
			  			</tbody>
					</table>
		      </c:if> 
     	</c:forEach>
     	</c:otherwise>
     	</c:choose>
	</div>
</div>
</div>


<%if (user.isInRole(ActionRoles.VERIFY_ACTION)) { %>
<a name="unverifiedActions"></a>
<div class="header">
<h3><fmt:message key="unverifiedActionsAssignedToMe" /></h3>
</div>
<div class="table-responsive">
  <div class="panel" id="accordion5" >
        <c:choose>
	        <c:when test="${empty unverifiedActionsSite}">
	        	<table class="table table-bordered  table-responsive dataTable">
		        	<thead>    
					    <tr>
					      <th><fmt:message key="id" /></th>
					      <th><fmt:message key="type" /></th>
					      <th><fmt:message key="verificationTargetDate" /></th>
					      <th><fmt:message key="description" /></th>
					      <th><fmt:message key="createdBy" /></th>
					    </tr>
				 	</thead>
	        	</table>
	        </c:when>
	        <c:otherwise>
    <c:forEach items="${unverifiedActionsSite}" var="act" varStatus="s">
	    <table class="table table-bordered table-striped   table-responsive dataTable">
	    	<caption><c:out value="${act}" /></caption>
		<thead>    
		    <tr>
		      <th><fmt:message key="id" /></th>
		      <th><fmt:message key="type" /></th>
		      <th><fmt:message key="verificationTargetDate" /></th>
		      <th><fmt:message key="description" /></th>
		      <th><fmt:message key="createdBy" /></th>
		    </tr>
		  </thead>
		  <tbody>
		    <c:if test="${empty unverifiedActions}">
		      <tr class="odd">
		        <td colspan="5"><fmt:message key="none" /></td>
		      </tr>
		    </c:if>
	    <c:if test="${!empty unverifiedActionsSite}"> 

	    </c:if>  
		    <c:forEach items="${unverifiedActions}" var="action" varStatus="s">
		    <c:if test="${action.effectivenessReviewRequired}">
		      <c:choose>
		        <c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		        <c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		      </c:choose>
		        <c:if test="${action.site.name == act}">
		      <tr class="<c:out value="${style}" />">
		        <td><a onclick='changeSiteOfType("<c:url value="viewAction.htm"><c:param name="id" value="${action.id}"/></c:url>", ${action.site.id}, "${action.site}", ${currentSite}, "${actionLabel}")' href="#"><c:out value="${action.id}" /></a></td>
		        <td><fmt:message key="${action['class'].name}" /></td>
		        <td><fmt:formatDate value="${action.verificationTargetDate}" pattern="dd-MMM-yyyy" /></td>
		        <td><div><c:out value="${action.description}" /></div></td>
		        <td><c:out value="${action.createdByUser.displayName}" /></td>
		      </tr>
		      </c:if>
		       </c:if>
		    </c:forEach>
		  </tbody>
		</table>
    </c:forEach>
    </c:otherwise>
    </c:choose>
        </div>
        </div>
<%} %>


<a name="tasks"></a>
<div class="header">
<h3><fmt:message key="incompleteTasksAssignedToMe" /></h3>
</div>
<div class="content">
<div class="table-responsive">
  <div class="panel" id="accordion6" >
        <c:choose>
	        <c:when test="${empty incompleteTasksSite}">
	        	<table class="table table-bordered  table-responsive dataTable">
		        	<thead>   
					    <tr>
					      <th><fmt:message key="id" /></th>
					      <th><fmt:message key="targetDate" /></th>
					      <th><fmt:message key="description" /></th>
					      <th><fmt:message key="createdBy" /></th>
					    </tr>
					</thead>
	        	</table>
	        </c:when>
	        <c:otherwise>
    <c:forEach items="${incompleteTasksSite}" var="ta" varStatus="s">
     	<c:if test="${!empty incompleteTasksSite}">  
		     <table class="table table-bordered  table-responsive dataTable">
		     	<caption><c:out value="${ta}" /></caption>
				<thead>   
				    <tr>
				      <th><fmt:message key="id" /></th>
				      <th><fmt:message key="targetDate" /></th>
				      <th><fmt:message key="description" /></th>
				      <th><fmt:message key="createdBy" /></th>
				    </tr>
				  </thead>
				  <tbody>
				    <c:if test="${empty incompleteTasks}">
				      <tr>
				        <td><fmt:message key="none" /></td>
				         <td></td>
				          <td></td>
				           <td></td>
				      </tr>
			      
			    </c:if> 
		    <c:forEach items="${incompleteTasks}" var="task" varStatus="s">
		      <c:choose>
		        <c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		        <c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		      </c:choose>
		       <c:if test="${task.site.name == ta}">
		      <tr class="<c:out value="${style}" />">     
		        <td><a onclick='changeSiteOfType("<c:url value="viewTask.htm"><c:param name="id" value="${task.id}"/></c:url>", ${task.site.id}, "${task.site}", ${currentSite}, "${taskLabel}")' href="#"><c:out value="${task.id}" /></a></td>
		        <td><fmt:formatDate value="${task.targetDate}" pattern="dd-MMM-yyyy" /></td>
		        <td><div><c:out value="${task.description}" /></div></td>
		        <td><c:out value="${task.createdByUser.displayName}" /></td>
		      </tr>
		      </c:if>  
		    </c:forEach>
		  </tbody>
		</table>
		</c:if>
    </c:forEach>
    </c:otherwise>
    </c:choose>
 </div> 
 </div>
</div>
<input type="hidden" id="from" name="from" value="${fromOccuredDate}" />
<input type="hidden" id="to" name="to" value="${toOccuredDate}" />

</div>

</body>
</html>



