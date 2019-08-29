<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<!--   <meta name="printable" content="true"> -->
  <title><fmt:message key="viewIncidentTypes" /></title>
  <script language="javascript" type="text/javascript" src="<c:url value="/js/utils.js" />"></script>
<style>
	.panelHover:not(:focus):hover {
    	background-color: #e6e6e6 !important;
	}

</style>
<script type="text/javascript"> 
jQuery(document).ready(function() {
	if('${typeId}' != null){
		jQuery('#accordion${typeId}').find('.acc-panel-heading').find('.panel-title').find('.panelHover').click();
		jQuery('#anchorMaster').click(function(){
			window.location = jQuery('#anchorMaster').attr('href');
		});
		setTimeout( function(){ jQuery('#anchorMaster').click();}, 1000 );
	}
});
</script>
</head>
<body>
<a id="anchorMaster" href="#anchor${typeId }"></a>
<div align="right"><button type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button></div>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="viewIncidentTypes" /></h2> --%>
<!-- </div> -->
<div class="content">
<c:forEach items="${types}" var="type" >
<a id="anchor${type.id}" ></a>
<div class="panel-group accordion  accordion-semi" id="accordion${type.id}">
					<div class="acc-panel-heading">
						<h4 class="panel-title ui-state-active">
                        <a id="anchor${type.id}" class="collapsed acc panelHover" data-toggle="collapse"
                           data-parent="#accordion${type.id}" href="#${type.id}">
                           <i class="fa fa-angle-right"></i> 
                              <fmt:message key="${type.key}" />
                        </a>
                     </h4>
<div  id="${type.id}" class="content panel-collapse collapse out">
<div class="table-responsive">
<div class="panel panel-body">
<table class="table table-bordered table-responsive">
<col  />


<tbody>
<tr>
  <th style="width: 30%"><fmt:message key="active" /></th>
  <td colspan="3"><fmt:message key="${type.active}" /></td>
</tr>  
<tr>
  <th style="vertical-align: top;"><fmt:message key="singleAssign" /></th>
  <td colspan="3">
      <ul style="">
      <li><span style="white-space: nowrap;"><c:choose><c:when test="${type.singleAssignable}"><fmt:message key="yes" /></c:when><c:otherwise><fmt:message key="no" /></c:otherwise></c:choose></span></li>
      </ul>
  </td>
</tr>  
<tr>
  <th style="vertical-align: top;"><fmt:message key="assignedMandatory" /></th>
  <td colspan="3">
      <ul style="">
      <li><span style="white-space: nowrap;"><c:choose><c:when test="${type.assignedMandatory}"><fmt:message key="yes" /></c:when><c:otherwise><fmt:message key="no" /></c:otherwise></c:choose></span></li>
      </ul>
  </td>
</tr> 
<tr>
  <th style="vertical-align: top;"><fmt:message key="accessLevel" /></th>
  <td colspan="3">
      <ul style="">
      <li><span style="white-space: nowrap;"><c:choose><c:when test="${type.incidentTypeAccessControl}"><fmt:message key="yes" /></c:when><c:otherwise><fmt:message key="no" /></c:otherwise></c:choose></span></li>
      </ul>
  </td>
</tr> 
<tr>
  <th style="vertical-align: top;"><fmt:message key="confidential" /></th>
  <td colspan="3">
      <ul style="">
      <li><span style="white-space: nowrap;"><c:choose><c:when test="${type.confidential.confidential}"><fmt:message key="yes" /></c:when><c:otherwise><fmt:message key="no" /></c:otherwise></c:choose></span></li>
      </ul>
  </td>
</tr> 
<tr>
  <th style="vertical-align: top;"><fmt:message key="confidentialControlView" /></th>
  <td colspan="3">
      <ul style="">
      <c:choose>
      	<c:when test="${type.confidentialDescription || type.confidentialPeopleInvolved || type.confidentialAttachments}">
	      <c:if test="${type.confidentialDescription}"><li><span style="white-space: nowrap;"><fmt:message key="incident.confidentialDescription" /></span></li></c:if>
	      <c:if test="${type.confidentialPeopleInvolved}"><li><span style="white-space: nowrap;"><fmt:message key="incident.confidentialPeopleInvolved" /></span></li></c:if>
	      <c:if test="${type.confidentialAttachments}"><li><span style="white-space: nowrap;"><fmt:message key="incident.attachments" /></span></li></c:if>
	      </c:when>
	      <c:otherwise>
	      	<li><span style="white-space: nowrap;"><fmt:message key="none" /></span></li>
	     </c:otherwise>
      </c:choose>
      </ul>
  </td>
</tr>
<tr>
  <th style="vertical-align: top;"><fmt:message key="autoClose" /></th>
  <td colspan="3">
      <ul style="">
      <li><span style="white-space: nowrap;"><c:choose><c:when test="${type.autoClose}"><fmt:message key="yes" /></c:when><c:otherwise><fmt:message key="no" /></c:otherwise></c:choose></span></li>
      </ul>
  </td>
</tr>  
<c:if test="${type.mobileEnabled}">
	<tr>
	  <th style="vertical-align: top;"><fmt:message key="mobileEnabled" /></th>
	  <td colspan="3">
	      <ul style="">
	      <li><span style="white-space: nowrap;"><c:choose><c:when test="${type.mobileEnabled}"><fmt:message key="yes" /></c:when><c:otherwise><fmt:message key="no" /></c:otherwise></c:choose></span></li>
	      </ul>
	  </td>
	</tr> 
</c:if>
<c:if test="${!empty type.incidentQuestionGroups}">
<tr>
<th><fmt:message key="incident.fields" /></th>
  <td colspan="2">
    <table width="100%" style="border: none;border-spacing: 0;">
    	<c:forEach var="group" items="${type.incidentQuestionGroups}" varStatus="s">				  				
				<tr>
					<td><h2><fmt:message key="group" />: <c:out value="${group.name}"/>	</h2></td>
					<td style="white-space: nowrap;">
						<c:if test="${group.lastUpdatedTs != null}">
			          			<a href="javascript:openHistory(<c:out value="${group.id},'${group['class'].name}'" />)"><fmt:message key="viewHistory" /></a>
			        	</c:if>
			        </td>
</tr>

				<c:forEach var="templateQuestion" items="${group.questions}" varStatus="loop">
					<c:choose>
						<c:when	test="${templateQuestion.clientQuestion}">
						<c:if test="${templateQuestion.question.active}">
							<tr>
								<td style="padding-left: 50px;">
									<c:out value="${templateQuestion}" />
									<c:if test="${type.mobileEnabled}">
										<c:if test="${templateQuestion.displayDefaultValue != null}">
												<br/><font color="#13ab94"><fmt:message key="incident.defaultValue" />:</font> ${templateQuestion.displayDefaultValue}
										</c:if>
										<c:if test="${templateQuestion.hideOnMobile}">
												<br/><font color="#13ab94"><fmt:message key="incident.hideOnMobile" />:</font><fmt:message key="true" />
										</c:if> 
									</c:if>
								</td>
								<td style="white-space: nowrap;" width="20%">
									<c:if test="${templateQuestion.lastUpdatedTs != null}">
											<a href="javascript:openHistory(<c:out value="${templateQuestion.id},'${templateQuestion['class'].name}'" />)">
											<fmt:message key="viewHistory" /></a>
									</c:if>
								</td>
							</tr>
							</c:if>
						</c:when>
						<c:otherwise>
							<tr>
								<td style="padding-left: 50px;">
									<fmt:message key="${templateQuestion.questionName}" />
									<c:if test="${type.mobileEnabled}">
										<c:if test="${templateQuestion.displayDefaultValue != null}">
												<br/><font color="#13ab94"><fmt:message key="incident.defaultValue" />:</font> ${templateQuestion.displayDefaultValue}
										</c:if>
										<c:if test="${templateQuestion.hideOnMobile}">
												<br/><font color="#13ab94"><fmt:message key="incident.hideOnMobile" />:</font><fmt:message key="true" />
										</c:if> 
									</c:if>
								</td>
								<td style="white-space: nowrap;" width="20%">
									<c:if test="${templateQuestion.lastUpdatedTs != null}">
										<a href="javascript:openHistory(<c:out value="${templateQuestion.id},'${templateQuestion['class'].name}'" />)">
										<fmt:message key="viewHistory" /></a>
									</c:if>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:forEach>
      	</table>
      </td>
      
</tr>
    </c:if>
    
 <c:if test="${!empty type.investigationQuestionGroups}">
<tr>
<th><fmt:message key="investigation.fields" /></th>
  <td colspan="2">
    		<c:forEach var="group" items="${type.investigationQuestionGroups}" varStatus="s">			
				<table width="100%" >		  				
				<tr>
					<td><h2><fmt:message key="group" />: <c:out value="${group.name}"/>	</h2></td>
					<td style="white-space: nowrap;" width="20%">
						<c:if test="${group.lastUpdatedTs != null}">
			          			<a href="javascript:openHistory(<c:out value="${group.id},'${group['class'].name}'" />)"><fmt:message key="viewHistory" /></a>
			        	</c:if>
			        </td>
			    </tr>
				<c:forEach var="templateQuestion" items="${group.questions}" varStatus="loop">
					<c:choose>
						<c:when	test="${templateQuestion.clientQuestion}">
						<c:if test="${templateQuestion.question.active}">
							<tr>
								<td style="padding-left: 50px;">
									<c:out value="${templateQuestion}" />
								</td>
								<td style="white-space: nowrap;" width="20%">
									<c:if test="${templateQuestion.lastUpdatedTs != null}">
											<a href="javascript:openHistory(<c:out value="${templateQuestion.id},'${templateQuestion['class'].name}'" />)">
											<fmt:message key="viewHistory" /></a>
									</c:if>
								</td>
							</tr>
							</c:if>
						</c:when>
						<c:otherwise>
							<tr>
								<td style="padding-left: 50px;">
									<fmt:message key="${templateQuestion.questionName}" />
								</td>
								<td style="white-space: nowrap;" width="20%">
									<c:if test="${templateQuestion.lastUpdatedTs != null}">
										<a href="javascript:openHistory(<c:out value="${templateQuestion.id},'${templateQuestion['class'].name}'" />)">
										<fmt:message key="viewHistory" /></a>
									</c:if>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</table>
        	 </c:forEach>
      </td>
      
</tr>
    </c:if> 
    
<tr>
  <th><fmt:message key="incidentType.subtypes" /></th>
  <td colspan="3">
    <table width="100%">
	  <tr>
	    <th  width="60%"><fmt:message key="name" /></th>
	    <th><fmt:message key="active" /></th>
	    <c:if test="${!type.mobileEnabled && type.mutableSubTypes}">
	    	<th>&nbsp;</th>
	    </c:if>
	  </tr>
		<c:if test="${empty type.subTypes}">
		<tr class="even">
		  <td colspan="3"><fmt:message key="none" /></td>
		</tr>
		</c:if>
		<c:forEach items="${type.subTypes}" var="subType" varStatus="s">
		  <tr >
		    <td><c:out value="${subType.name}" /></td>
		    <td><fmt:message key="${subType.active}" /></td>
		    <c:if test="${ type.mutableSubTypes}">
			    <td>
			        <a href="<c:url value="editIncidentSubType.htm"><c:param name="showId" value="${subType.id}"/></c:url>" ><fmt:message key="edit" /></a>&nbsp;
			        <c:if test="${subType.lastUpdatedTs != null}">
			          <a href="javascript:openHistory(<c:out value="${subType.id},'${subType['class'].name}'" />)"><fmt:message key="viewHistory" /></a>
			        </c:if>
			    </td>
		    </c:if>
		  </tr>
		</c:forEach>
    </table>
  </td>
</tr>
  
</tbody>

<tfoot>
  <td colspan="4">
  	  <c:if test="${!type.mobileEnabled && (editAble == true)}">
      		<a href="<c:url value="editIncidentType.htm"><c:param name="showId" value="${type.id}"/></c:url>" ><fmt:message key="edit" /></a>&nbsp;|
      		<a href="<c:url value="configureTemplateSites.htm"><c:param name="id" value="${type.id}"/></c:url>" ><fmt:message key="configureTemplateSites" /></a>&nbsp; |
      		<a href="<c:url value="configureQuestionSite.htm"><c:param name="id" value="${type.id}"/></c:url>" ><fmt:message key="configureQuestionSites"/></a>&nbsp; |
      		<a href="<c:url value="viewSiteTemplate.htm"><c:param name="id" value="${type.id}"/></c:url>" ><fmt:message key="viewTemplateSites"/></a>&nbsp; |
       </c:if>
      <c:if test="${ type.mutableSubTypes}">
      		<a href="<c:url value="editIncidentSubType.htm"><c:param name="typeId" value="${type.id}"/></c:url>" ><fmt:message key="addIncidentSubType" /></a>&nbsp;|
      </c:if>
       <c:if test="${type.lastUpdatedTs != null}">
       		<a href="javascript:openHistory(<c:out value="${type.id},'${type['class'].name}'" />)"><fmt:message key="viewHistory" /></a> 
       </c:if>
  </td>
</tfoot>
</table>
</div>
</div>
</div>
</div>
</div>
</c:forEach>
</div>
</body>
</html>
