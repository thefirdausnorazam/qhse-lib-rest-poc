<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
<fmt:message key="${action['class'].name}" var="typeName" />
<title></title>
<%-- <link type="text/css" href="<c:url value="/jquery/ui-ss-law/jquery-ui-1.7.2.custom.css" />" rel="stylesheet" /> --%>
 <style type="text/css">
  @media print {
  .tab-content > .tab-pane {display: block !important; opacity: 1 !important;}
 }
  </style>
   <script type="text/javascript">
   var tablesInitialised = false;
  jQuery(document).ready(function(){

    jQuery("#myTab li:eq(1) a").tab('show');
    
    jQuery('.nav-tabs > li ').hover( function(){
        if(jQuery(this).hasClass('hoverblock'))
            return;
        else
        	jQuery(this).find('a').tab('show');
   });


    jQuery('.nav-tabs > li').find('a').click( function(){
    	jQuery(this).parent()
        .siblings().addClass('hoverblock');
   });
    jQuery('.nav-tabs > li').find('a#actionTasks').hover( function(){
    	if(!tablesInitialised)
    	{
			tablesInitialised = true;
			initSortTables();
    	}
   });
})
</script>
<script type="text/javascript" >

/*jQuery(document).ready(function() {
	var removeHolderLink;
	
	jQuery('a.remove-action-holder').click(function() {
		removeHolderLink = jQuery(this);
		jQuery('#dialog-confirm').dialog('open');
	});

	jQuery("#dialog-confirm").dialog({
		height:140,
	    width: 400,
	    modal: true,
	    resizable: false,
	    draggable: false,
	    autoOpen: false,
		buttons: {
			Remove: function() {
				removeHolderLink.closest('form').submit();
				jQuery(this).dialog("close");
			},
			Cancel: function() {
				jQuery(this).dialog("close");
			}
		}
	 });
});*/
  
  
	function onPageLoad() {
		var inProgressWarning = '<c:out value="${action.inProgressWarning}" />';
		if (inProgressWarning == 'true') {
			//alert("This Action has been in progress for more than 60 days");
		}
	}
	
jQuery(window).bind('load', onPageLoad);
   </script>

</head>
<body>
<div class="header">
<h2><fmt:message key="viewAction" ><fmt:param value="${typeName}" /></fmt:message></h2>
</div>

<!--  <div id="dialog-confirm" title="<fmt:message key="actionHolder.remove.confirm" />">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span><fmt:message key="actionHolder.remove.message" /></p>
</div>-->

<c:set var="updateIncidentAllowed" value="${action.site.id==site.id}" />
<div class="content">

<ul class="nav nav-tabs nav-justified " id="myTab" >
        <li><a data-toggle="tab" href="#sectionA"><span class="tabHead"><fmt:message key="associatedWith" /></span></a></li>
        <li><a data-toggle="tab" href="#sectionB"><span class="tabHead"> <fmt:message key="actionDetails" /></span></a></li>
        <li><a id="actionTasks" data-toggle="tab" href="#sectionC"><span class="tabHead"> <fmt:message key="tasks" /></span></a></li>
        <li><a data-toggle="tab" href="#sectionD"><span class="tabHead"> <fmt:message key="attachments" /></span></a></li>
        <c:if test="${action.verified}">
        <li><a data-toggle="tab" href="#sectionE"><span class="tabHead"> <fmt:message key="evaluationReviewNotes" /></span></a></li>
        </c:if>
        
</ul>
<div class="tab-content">


<div id="sectionA" class="tab-pane fade">

<a name="associatedWith"></a>
<div class="header">
        <h3> <fmt:message key="associatedWith" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">


<table class="table table-bordered table-responsive">
<thead>
</thead>
<tbody> 
  <c:if test="${action.type == 'prevent'}" >
    <c:forEach items="${action.justifications}" var="item">
    <tr>
      <td><a href="<c:url value="viewJustification.htm"><c:param name="id" value="${item.id}" /></c:url>">
        <fmt:message key="${item['class'].name}" /></a></td>
      <td><scannell:text value="${item.description}" /></td>
      <td>&nbsp;</td>
    </tr>
    </c:forEach>
  </c:if>
  <c:forEach items="${action.holders}" var="item">
  <tr>
    <td><scannell:entityUrl entity="${item.owner}"/></td>
	<incident:actionHolderDescription holder="${holder}" />
     <!--<td>&nbsp;
     <c:if test="${action.removeHolderPermitted}">
    	<form method="post" action="<c:url value="/incident/removeActionHolder.htm" />">
	    	<input type="hidden" name="id" value="${action.id}">
	    	<input type="hidden" name="version" value="${action.version}">
	    	<input type="hidden" name="actionHolderId" value="${item.id}">
	    	<a href="#" class="remove-action-holder"><img src="<c:url value="/images/trash.gif" />" /></a>
    	</form>
    </c:if>	
    </td> -->
  </tr>
  </c:forEach>
  </tbody>
</table> 

</div>
</div>
</div>

<div id="sectionB" class="tab-pane fade active in">
<a name="action"></a>
<div class="header">
        <h3>  <fmt:message key="actionDetails" /> </h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel "> 

<table class="table table-bordered table-responsive">
    <col  />
<tbody>
  <tr>
    <td ><fmt:message key="id" /></td>
    <td><c:out value="${action.id}" /></td>
  </tr>
  <c:if test="${showLegacyId}">
  <tr>
    <td >Legacy Id</td>
    <td><scannell:text value="${action.legacyId}" /></td>
  </tr>
  </c:if>
	<tr>
		<td><fmt:message key="businessAreas" />:</td>
		<td colspan="3">
		     <ul>
		      <c:forEach var="ba" items="${action.businessAreas}">
		        	<li><c:out value="${ba.name}" /></li>
		      </c:forEach>
		      </ul>
		</td>
	</tr>
  <tr>
    <td ><fmt:message key="type" /></td>
    <td><c:out value="${typeName}" /></td>
  </tr>
  <c:if test="${action.category != null}">
	  <tr>
	    <td ><fmt:message key="category" /></td>
	    <td><c:out value="${action.category.name}" /></td>
	  </tr>
  </c:if>
  <tr>
    <td ><fmt:message key="description" /></td>
    <td><scannell:text htmlEscape="true" value="${action.description}"  /></td>
  </tr>
  <tr>
    <td ><fmt:message key="capaType" /></td>
    <td><scannell:text htmlEscape="true" value="${action.capaType.name}"  /></td>
  </tr>
  <tr>
    <td ><fmt:message key="status" /></td>
    <td>
    <c:choose>
    <c:when test="${action.trash}"><fmt:message key="trash" /></c:when>
    <c:otherwise> <fmt:message key="${action.statusCode}" /></c:otherwise>
    </c:choose>
  </td>
  </tr>  
  <c:if test="${action.priority != null}">
  <tr>
    <td ><fmt:message key="priority" /></td>
    <td><fmt:message key="${action.priority}" /></td>
  </tr>
  </c:if>
    
  <tr>
    <td ><fmt:message key="completionTargetDate" /></td>
    <td><fmt:formatDate value="${action.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="responsibleUser" /></td>
    <td><c:out value="${action.responsibleUser.displayName}" /></td>
<%--   	<c:if test="${action.responsibleUser.department != ''}">   --%>
<%-- 	    <td class="label"><fmt:message key="department" /></td> --%>
<%-- 	    <td><c:out value="${action.responsibleUser.department}" /></td> --%>
<%-- 	</c:if>     --%>
  </tr>
  <tr>
    <td ><fmt:message key="responsibleDepartment" /></td>
    <td><c:out value="${action.responsibleDepartment.name}" /></td>
  </tr>
<c:if test="${action.completed}">
  <tr>
    <td ><fmt:message key="completedBy" /></td>
    <td><c:out value="${action.completedBy.displayName}" /> <fmt:message key="at" />
      <fmt:formatDate value="${action.completedTime}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="completedComment" /></td>
    <td><scannell:text value="${action.completedComment}" /></td>
  </tr>
<c:if test="${action.verifiable}">
  <tr>
    <td ><fmt:message key="verificationTargetDate" />:</td>
    <td><fmt:formatDate value="${action.verificationTargetDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="verifyingUser" /></td>
    <td><c:out value="${action.verifyingUser.displayName}" /></td>
  </tr>
</c:if>
</c:if>
<c:if test="${action.verified}">
  <tr>
    <td ><fmt:message key="verifiedBy" /></td>
    <td><c:out value="${action.verifiedBy.displayName}" /> <fmt:message key="at" />
      <fmt:formatDate value="${action.verifiedTime}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="verificationSuccessful" /></td>
    <td><fmt:message key="${action.verificationSuccessful}" /></td>
  </tr>
  <tr>
    <td ><fmt:message key="verifiedComment" /></td>
    <td><scannell:text value="${action.verificationComment}" /></td>
  </tr>
</c:if>
  <tr>
    <td ><fmt:message key="createdBy" /></td>
    <td><c:out value="${action.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${action.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>
  <c:if test="${action.lastUpdatedByUser != null}">
  <tr>
    <td ><fmt:message key="lastUpdatedBy" /></td>
    <td>
      <c:out value="${action.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${action.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
    </td>
  </tr>
  </c:if>
  <c:if test="${action.superceeds != null}" >
  <tr>
    <td ><fmt:message key="supercedesAction" /></td>
    <td><a href="<c:url value="viewAction.htm"><c:param name="id" value="${action.superceeds.id}" /></c:url>">
        <c:out value="${action.superceeds.id}" /> - <scannell:text value="${action.superceeds.description}" /></a>
    </td>
  </tr>
  </c:if>
  <c:if test="${action.superceededBy != null}" >
  <tr>
    <td ><fmt:message key="supercededByAction" /></td>
    <td><a href="<c:url value="viewAction.htm"><c:param name="id" value="${action.superceededBy.id}" /></c:url>">
        <c:out value="${action.superceededBy.id}" /> - <scannell:text value="${action.superceededBy.description}" /></a>
    </td>
  </tr>
  </c:if>
</tbody>
<tfoot>
  <tr>
    <td colspan="2">
    	<c:choose>
	    	<c:when test="${updateIncidentAllowed}">
				     <c:if test="${action.editable}">
				       <a href="<c:url value="editAction.htm"><c:param name="showId" value="${action.id}" /></c:url>">
				         <fmt:message key="edit" /></a>
				     </c:if>
				     <c:if test="${action.taskAddable}">
				     	<c:if test="${action.editable}">&nbsp;|&nbsp;</c:if>
				       <a href="<c:url value="editTask.htm"><c:param name="actionId" value="${action.id}" /></c:url>">
				         <fmt:message key="addTask" /></a>
				     </c:if>
				     <c:if test="${action.completable}">
				     	<c:if test="${action.editable or action.taskAddable}">&nbsp;|&nbsp;</c:if>
				       <a href="<c:url value="completeAction.htm"><c:param name="showId" value="${action.id}" /></c:url>">
				         <fmt:message key="completeAction" /></a>
				     </c:if>
				     <c:if test="${action.reopenable}">
				     	<c:if test="${action.editable or action.taskAddable or action.completable}">&nbsp;|&nbsp;</c:if>
				       <a href="<c:url value="reopenAction.htm"><c:param name="id" value="${action.id}" /></c:url>">
				         <fmt:message key="reopenAction" /></a>
				     </c:if>
				     <c:if test="${action.verifiable}">
				     	<c:if test="${action.editable or action.taskAddable or action.reopenable or action.completable}">&nbsp;|&nbsp;</c:if>
				       <a href="<c:url value="verifyAction.htm"><c:param name="showId" value="${action.id}" /></c:url>">
				         <fmt:message key="verifyAction" /></a>
				     </c:if>
				     <c:if test="${action.verified}">
				     	<c:if test="${action.editable or action.taskAddable or action.reopenable or action.completable}">&nbsp;|&nbsp;</c:if>
				       <a href="<c:url value="addActionNote.htm"><c:param name="showId" value="${action.id}" /></c:url>">
				         <fmt:message key="addActionNote" /></a>
				     </c:if>
				     <c:if test="${action.editable || action.verifiable}">
				     	<c:if test="${action.editable or action.taskAddable or action.reopenable or action.completable or action.verified}">&nbsp;|&nbsp;</c:if>
				       <a href="<c:url value="addActionAttachment.htm"><c:param name="showId" value="${action.id}" /></c:url>">
				         <fmt:message key="addAttachment" /></a>
				     </c:if>
				     <c:if test="${action.editable && !action.completed}">
				     		<a href="<c:url value="addProgressComment.htm"><c:param name="id" value="${action.id}" /><c:param name="parent" value="action" /></c:url>">
							         &nbsp;|&nbsp;<fmt:message key="action.addProgressComment" /></a>
					     <c:if test="${!action.trash}">
						     <a href="<c:url value="editActionTrash.htm"><c:param name="showId" value="${action.id}" /></c:url>">
							         &nbsp;|&nbsp;<fmt:message key="trash" /></a>
						    </c:if>
				     </c:if>
				     <c:if test="${action.untrashable}">
				     	<a href="<c:url value="editActionTrash.htm"><c:param name="showId" value="${action.id}" /></c:url>">
						        	<fmt:message key="untrash" /></a>
				     </c:if>
				     <c:if test="${action.lastUpdatedByUser != null}">
				     	<c:if test="${action.editable or action.taskAddable or action.reopenable or action.completable or action.verified}"></c:if>
				       <a href="javascript:openHistory(<c:out value="${action.id},'${action['class'].name}'" />)">
				         &nbsp;|&nbsp;<fmt:message key="viewHistory" /></a>
				     </c:if>
			</c:when>
			<c:otherwise><fmt:message key="notCurrentSelectedSite" ><fmt:param value="${action.site.name}" /></fmt:message></c:otherwise>
		</c:choose>
    </td>
  </tr>
</tfoot>
</table>
</div> 
</div>
</div>
<c:if test="${not empty progressComments}">
<div class="header">
<h3><fmt:message key="action.progress.comment" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-bordered table-responsive">
  <thead>    
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="comment" /></th>
      <th><fmt:message key="createdBy" /></th>
    </tr>
  </thead>
  <tbody id="questionsTbody">
  <c:forEach items="${progressComments}" var="progressComment" >
    <tr>
       <td><c:out value="${progressComment.id}" /></td>
      <td><c:out value="${progressComment.comment}" /></td>
      <td><c:out value="${progressComment.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${progressComment.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </tr>
  </c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</c:if>

</div>


<div id="sectionC" class="tab-pane fade">
<a name="tasks"></a>
<div class="header">
        <h3>  <fmt:message key="tasks" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel"> 
	<table class="table table-bordered table-responsive dataTable">
		<thead>  
			  <tr>
				    <th><fmt:message key="description" /></th>
				    <th><fmt:message key="targetDate" /></th>
				    <th><fmt:message key="responsibleUser" /></th>
				    <th><fmt:message key="status" /></th>
				    <th>&nbsp;</th>
			  </tr>
		</thead>
		<tbody>
		      <c:forEach items="${action.tasks}" var="item">
			      	<c:choose>
				      <c:when test="${item != null and !item.trash}">
					      <tr>
						        <td><scannell:text value="${item.description}" /></td>
						        <td><fmt:formatDate value="${item.targetDate}" pattern="dd-MMM-yyyy" /></td>
						        <td><c:out value="${item.responsibleUser.displayName}" /></td>
						        <td><fmt:message key="closed.${item.completed}" /></td>
						        <td><a href="<c:url value="viewTask.htm"><c:param name="id" value="${item.id}" /></c:url>"><fmt:message key="view" /></a></td>
					      </tr>
					  </c:when>
					</c:choose>
		      </c:forEach>
		</tbody>
	</table>
</div>
</div>
</div>
</div>

<div id="sectionD" class="tab-pane fade">
<a name="attachments"></a>
<div class="header">
        <h3>  <fmt:message key="attachments" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel "> 

<table class="table table-bordered table-responsive">
<tbody>
  <c:if test="${empty action.attachments}">
  <tr>
    <td colspan="2" ><fmt:message key="none" /></td>
  </tr>
  </c:if>
  <common:attachments urlPrefix="viewActionAttachment.htm" attachments="${action.attachments}" />
</tbody>
<tfoot>
<tr>
	<td colspan="2">
		<c:choose>
			<c:when test="${updateIncidentAllowed}">
				      <c:if test="${action.editable || action.verifiable}">
				        <a href="<c:url value="addActionAttachment.htm"><c:param name="showId" value="${action.id}" /></c:url>">
				          <fmt:message key="addAttachment" /></a>
				          <c:if test="${action != null && action.attachmentsEditable && !empty action.attachments}">
				          |
				          </c:if>
				      </c:if>
				      <c:if test="${action != null && action.attachmentsEditable && !empty action.attachments}">
				        <a href="<c:url value="editActionAttachments.htm"><c:param name="showId" value="${action.id}" /></c:url>">
				          <fmt:message key="editAttachments" /></a>
				      </c:if>
			</c:when>
			<c:otherwise><fmt:message key="notCurrentSelectedSite" ><fmt:param value="${action.site.name}" /></fmt:message></c:otherwise>
		</c:choose>
     </td>
</tr>
</tfoot>
</table>
</div>
</div>
</div>
</div>

<a name="evaluationReviewNotes"></a>
<div id="sectionE" class="tab-pane fade">
<c:if test="${action.verified}">
<div class="header">
        <h3>  <fmt:message key="evaluationReviewNotes" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel panel-danger"> 

<table class="table table-bordered table-responsive">
<tbody>
  <c:if test="${empty action.evaluationReviewNotes}">
  <tr>
    <td colspan="2" ><fmt:message key="none" /></td>
  </tr>
  </c:if>

  <c:forEach items="${action.evaluationReviewNotes}" var="item">
  <tr>
    <td>
      <c:out value="${item.createdByUser.displayName}" /><br />
       <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy hh:mm:ss" />
    </td>
    <td><scannell:text value="${item.text}" /></td>
  </tr>
  </c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</c:if>
</div>

</div> 
</div> 
</body>
</html>
