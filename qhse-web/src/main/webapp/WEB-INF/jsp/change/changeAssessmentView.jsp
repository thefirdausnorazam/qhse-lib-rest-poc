<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
	 <script type="text/javascript">
		 jQuery(document).ready(function(){
			 initSortTables();
			 
			 jQuery(".associatedChangeTable").each(function (){
				 var customizedColspan = jQuery(this).find(".customizedColspan");
				 var thLength = jQuery(this).find("th").size();
				 customizedColspan.attr('colspan', thLength);
			 });
			 
		 });
 	</script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/change.css'/>";
  </style>

</head>
<body>

<c:set var="foundQuestions" value="${!empty change.template.detailsQuestionGroups}" />
<c:set var="foundNotes" value="${!empty change.notes}" />
<c:set var="foundReviews" value="${!empty change.reviews}" />
<c:set var="foundAttachments" value="${!empty change.attachments}" />

<a name="assessment"></a>
		<div class="header">
			<h3>
				<fmt:message key="changeAssessment.title" />
				<c:out value="${change.name}" />
			</h3>
		</div>
<div class="content">
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
						<col />
						<thead>
							<tr>
								<td colspan="2" align="right">
									<div class="navLinks">
										<c:if test="${foundQuestions}"><a href="#questions"><fmt:message key="questions.title" /></a></c:if>
										<c:if test="${foundReviews}">| <a href="#reviews"><fmt:message key="changeAssessment.reviews" /></a></c:if>
										<c:if test="${foundNotes}">| <a href="#notes"><fmt:message key="notes" /></a></c:if>
										<c:if test="${foundAttachments}">| <a href="#attachments"><fmt:message key="attachments" /></a></c:if>
									</div>
								</td>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
								<td><c:out value="${change.id}" /></td>
							</tr>
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="businessAreas" />:</td>
								<td colspan="3">
							      	<ul>
								      	<c:forEach var="ba" items="${change.businessAreas}">
								        	<li><c:out value="${ba.name}" /></li>
								      	</c:forEach>
							      	</ul>
							    </td>
							</tr>
							
							<tr>	
							    <td class="scannellGeneralLabel"><fmt:message key="changeAssessment.status" />:</td>
							    <td id="changeAssessmentStatus"><fmt:message key="changeAssessment${change.status}" /></td>
							</tr>
							
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="changeProgramme" />:</td>
								<td><c:out value="${change.programme.description}" /></td>
							</tr>
						
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.initiator" />:</td>
								<td><c:out value="${change.initiator.displayName}" /></td>
							</tr><tr>
								<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.owner" />:</td>
								<td><c:out value="${change.owner.displayName}" /></td>
							</tr>
						
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.department" />:</td>
								<td><scannell:text value="${change.department.name}" /></td>
							</tr>			
							
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.title" />:</td>
								<td><scannell:text value="${change.name}" /></td>
							</tr>
							
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="description" />:</td>
								<td><scannell:text value="${change.description}" /></td>
							</tr>
							<%--<c:choose>
								<c:when test="${explicit}">		 --%>
									<tr>
										<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.lockdownOwner" />:</td>
										<td colspan="3"><fmt:message key="changeAssessment.lockdownOwner[${change.lockdownOwner}]" /></td>
									</tr>
								<%-- </c:when>
								<c:otherwise>
									<tr>
										<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.itemAffected" />:</td>
										<td colspan="3"><scannell:text value="${change.itemAffected}" /></td>
									</tr>
									
								  	<tr>
										<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.referenceNumber" />:</td>
										<td><scannell:text value="${change.referenceNumber}" /></td>
										
										<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.hazopRequired" />:</td>
								        <td><fmt:message key="changeAssessment.hazopRequired[${change.hazopRequired}]" /></td>
									</tr>			
									<tr>
										<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.reason" />:</td>
										<td colspan="3" style="width:400px; word-wrap: break-word"><scannell:text value="${change.reason}" /></td>
									</tr>	
								</c:otherwise>
							</c:choose> --%>
							
							<c:if test="${change.approvedByUser != null}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.type" />:</td>
								<td><fmt:message key="changeAssessment${change.type}" /></td>
							</tr>		
							
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.postImplementationReview" />:</td>
								<td><fmt:message key="${change.postImplementationReview}" /></td>
							</tr>	
							
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.returnToOriginalStatus" />:</td>
								<td><fmt:message key="${change.returnToOriginalStatus}" /></td>
							</tr>	
							</c:if>
											
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.reviewers" />:</td>		
								<td><c:forEach items="${change.reviewers}" var="reviewer" varStatus="r" ><c:if test="${!r.first}">, </c:if><c:out value="${reviewer.displayName}" /></c:forEach></td>		
							</tr>	
							
							<tr>		
								<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.percentCompleted" />:</td>
								<td><scannell:text value="${change.percentCompleted}%" /></td>
							</tr>
							<tr>
								<%-- <c:choose>		
									<c:when test="${explicit}"> --%>
										<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.targetApprovedDate" />:</td>
										<td><fmt:formatDate value="${change.targetApprovedDate}" pattern="dd-MMM-yyyy" /></td>
									<%-- </c:when>
									<c:otherwise>
										<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.targetTechnicalCloseoutDate" />:</td>
										<td><scannell:text value="${change.targetTechnicalCloseoutDate}" /></td>
									</c:otherwise>
								</c:choose> --%>
							</tr>	
							<%-- <c:if test="${change.completed && !explicit}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.technicalCloseoutComment" />:</td>
									<td><scannell:text value="${change.technicalCloseoutComment}" /></td>		
										
									<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.technicalCloseoutBy" />:</td>
									<td><c:out value="${change.technicalCloseoutByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${change.technicalCloseoutTime}" pattern="dd-MMM-yyyy" /></td>
								</tr>
							</c:if>	 --%>
							<c:if test="${change.approved}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.approvedBy" />:</td>
									<td><c:out value="${change.approvedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${change.approvalDate}" pattern="dd-MMM-yyyy" /></td>
								</tr>
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.approvedComment" />:</td>
									<td><c:out value="${change.approvalComment}" /> </td>
								</tr>				
							</c:if>	
							<c:if test="${!change.approved && change.approvalComment != null}">
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.disapprovedBy" />:</td>
									<td><c:out value="${change.approvedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${change.approvalDate}" pattern="dd-MMM-yyyy" /></td>
								</tr>
								<tr>
									<td class="scannellGeneralLabel"><fmt:message key="changeAssessment.disapprovedComment" />:</td>
									<td><c:out value="${change.approvalComment}" /> </td>
								</tr>				
							</c:if>				
						
						
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
								<td><c:out value="${change.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${change.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
							<tr>
								<c:if test="${change.lastUpdatedByUser != null}">
								<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
								<td><c:out value="${change.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${change.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
								</c:if>
							</tr>
						</tbody>
						
						<tfoot>
							<tr>
								<td colspan="20">
									<c:choose>
										<c:when test="${urls != null}">
											<scannell:url urls="${urls}" />
										</c:when>
										<c:otherwise>
											<fmt:message key="changeAssessment" />
											<fmt:message key="notCurrentSelectedSiteMsg">
												<fmt:param value="${change.site.name}" />
											</fmt:message>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</tfoot>
						</table>
				</div>
			</div>
		</div>

<a name="questions"></a>
<div class="header">
			<h3>
				<fmt:message key="questions.title" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
<col class="label" />
<thead>
	<tr>
		<td colspan="6" align="right">
			<div class="navLinks">
				<c:if test="${foundNotes}"> <a href="#notes"><fmt:message key="notes" /></a></c:if>
				<c:if test="${foundAttachments}">${foundNotes ? '|' : ''} <a href="#attachments"><fmt:message key="attachments" /></a></c:if>
			</div>
		</td>
	</tr>
	
	<tr>
		<th><fmt:message key="question" /></th>
		<th><fmt:message key="answer" /></th>
	</tr>
</thead>

<tbody>
	<c:forEach items="${change.template.detailsQuestionGroups}" var="group">
	   <c:if test="${!empty group.questions}">		
			<c:if test="${group.name != null && group.name != ''}">
				<tr><td colspan="4" class="scannellGeneralLabel" style="background-color:#DDDDDD;font-weight:bold;"><c:out value="${group.name}"/></td></tr>
			</c:if>
			<c:forEach items="${group.questions}" var="cq">
				<c:set var="q" value="${cq.question}" />
				<c:if test="${cq.active && q.active}">
				<tr>
				<c:choose>
					<c:when test="${q.answerType.name == 'label'}">
						<td colspan="4" class="scannellGeneralLabel"><c:out value="${q.name}" /></td>
					</c:when>
					<c:otherwise>																	
							<td class="scannellGeneralLabel" width="50%"><c:out value="${q.name}" />:</td>
							<td id="change.answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}" answers="${change.answers}" /></td>												
					</c:otherwise>
				</c:choose>
				</tr>
				</c:if>
			</c:forEach>	
		</c:if>
	  </c:forEach>
	  
	  <c:forEach items="${change.template.checklistQuestionGroups}" var="group">
	   <c:if test="${!empty group.questions}">		
			<c:if test="${group.name != null && group.name != ''}">
				<tr><td colspan="4" class="scannellGeneralLabel" style="background-color:#DDDDDD;font-weight:bold;"><c:out value="${group.name}"/></td></tr>
			</c:if>
			<c:forEach items="${group.questions}" var="cq">
				<c:set var="q" value="${cq.question}" />
				<c:if test="${cq.active && q.active}">
					<tr>
					<c:choose>
						<c:when test="${q.answerType.name == 'label'}">
							<td colspan="4" class="scannellGeneralLabel"><c:out value="${q.name}" /></td>
						</c:when>
						<c:otherwise>																	
								<td class="scannellGeneralLabel" width="50%"><c:out value="${q.name}" />:</td>
								<td id="answers[<c:out value="${q.id}"/>]" colspan="3"><enviromanager:answer question="${q}" answers="${change.answers}" /></td>												
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
		<td colspan="4"><scannell:url urls="${urls1}" /></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>

<c:if test="${foundNotes}">
<a name="notes"></a>
<div class="header">
			<h3>
				<fmt:message key="notes" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
<col class="label" />
<thead>
	<tr>
		<td colspan="4" align="right">
			<div class="navLinks">
				<a href="#assessment"><fmt:message key="changeAssessment" /></a>
				| <a href="#questions"><fmt:message key="questions.title" /></a>
				<c:if test="${foundAttachments}">| <a href="#attachments"><fmt:message key="attachments" /></a></c:if>
			</div>
		</td>
	</tr>
	<tr>
		<th><fmt:message key="title" /></th>
		<th><fmt:message key="text" /></th>
		<th><fmt:message key="createdBy" /></th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${change.notes}" var="note" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">
			<td><c:out value="${note.name}" /></td>
			<td><scannell:text value="${note.text}" /></td>
			<td><c:out value="${note.createdByUser.displayName}" /> <fmt:message key="at" />  <fmt:formatDate value="${note.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
		</tr>
	</c:forEach>
</tbody>
</table>
</div>
</div>
</div>
</c:if>

<c:if test="${foundReviews}">
<a name="reviews"></a>
<div class="header">
			<h3>
				<fmt:message key="changeAssessment.reviews" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
<col class="label" />
<thead>
	<tr>
		<td colspan="4" align="right">
			<div class="navLinks">
				<a href="#assessment"><fmt:message key="changeAssessment" /></a>
				| <a href="#questions"><fmt:message key="questions.title" /></a>
				<c:if test="${foundAttachments}">| <a href="#attachments"><fmt:message key="attachments" /></a></c:if>
			</div>
		</td>
	</tr>
	<tr>		
		<th><fmt:message key="comment" /></th>
		<th><fmt:message key="createdBy" /></th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${change.reviews}" var="review" varStatus="s">
		<c:choose>
			<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
			<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
		</c:choose>
		<tr class="<c:out value="${style}" />">			
			<td width="80%"><scannell:text value="${review.comment}" /></td>        				
			<td><c:out value="${review.createdByUser.displayName}" /> <fmt:message key="at" />  <fmt:formatDate value="${review.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
		</tr>
	</c:forEach>
</tbody>
</table>
</div>
			</div>
		</div>
</c:if>

<a name="action"></a>
	<div class="header">
		<h3>
			<fmt:message key="actions" />
		</h3>
	</div>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive dataTable">
			      <thead>
				      <tr>
					      	<c:if test="${change.hasCurrentActions}">
						        <th><fmt:message key="id" /></th>
						        <th><fmt:message key="category" /></th>
						        <th><fmt:message key="description" /></th>
						        <th><fmt:message key="completionTargetDate" /></th>
						        <th><fmt:message key="responsibleUser" /></th>
						        <th><fmt:message key="status" /></th>
						        <th>&nbsp;</th>
						    </c:if>
				      </tr>
			      </thead>
			      <tbody>
				     <c:forEach items="${change.currentActions}" var="item">
					      <c:choose>
						      <c:when test="${item != null}">
							      <tr class="<c:out value="${style}" />">
								        <td><c:out value="${item.id}" /></td>
								        <td>
								        	<c:choose>
								        		<c:when test="${item.category ne null}">${item.category.name}</c:when>
								        		<c:otherwise><fmt:message key="ActionType[${item.type}]" /></c:otherwise>
								        	</c:choose>
								         </td>
								        <td><div><c:out value="${item.description}" /></div></td>
								        <td><fmt:formatDate value="${item.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
								        <td><c:out value="${item.responsibleUser.displayName}" /></td>
									    <td><fmt:message key="${item.statusCode}" /></td>
								        <td><a href="<c:url value="/incident/viewAction.htm"><c:param name="id" value="${item.id}" /></c:url>" ><fmt:message key="view" /></a></td>
							      </tr>
						      </c:when>
				      		</c:choose>
				      </c:forEach>
			      </tbody>
			</table>
		</div>
	</div>
</div>

<c:if test="${foundAttachments}">
<a name="attachments"></a>
<div class="header">
			<h3>
				<fmt:message key="attachments" />
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive">
<col class="label" />
<thead>
	<tr>
		<td colspan="3" align="right">
			<div class="navLinks">
				<a href="#assessment"><fmt:message key="changeAssessment" /></a>
				| <a href="#questions"><fmt:message key="questions.title" /></a>
				<c:if test="${foundNotes}">| <a href="#notes"><fmt:message key="notes" /></a></c:if>
			</div>
		</td>
	</tr>
	<tr>
		<th><fmt:message key="name" /></th>
		<th><fmt:message key="description" /></th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${change.attachments}" var="item" varStatus="s">
	<c:if test="${item.active}">
	<c:choose>
		<c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
		<c:otherwise><c:set var="style" value="odd" /></c:otherwise>
	</c:choose>
	<tr class="<c:out value="${style}" />">
		<td>
			<c:choose>
				<c:when test="${item.type.name == 'attach'}">
					<a target="attachment" href="<c:url value="changeAttachmentView.htm"><c:param name="id" value="${item.id}" /></c:url>"><c:out value="${item.name}" /></a>
				</c:when>
				<c:otherwise>
					<a target="attachment" href="<c:out value="${item.externalUrl}" />"><c:out value="${item.name}" /></a>
				</c:otherwise>
			</c:choose>
			<br />
			<fmt:message key="createdBy" /> <c:out value="${item.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${item.createdTs}" pattern="dd-MMM-yyyy hh:mm:ss" />
		</td>
		<td><scannell:text value="${item.description}" /></td>
	</tr>
	</c:if>
	</c:forEach>
</tbody>

<tfoot>
<tr>
	<td colspan="2">
		<c:if test="${change.editable}">
			<a href="<c:url value="changeAttachmentEdit.htm"><c:param name="showId" value="${change.id}" /></c:url>"><fmt:message key="addAttachment" /></a>
		</c:if>
		<c:if test="${change != null && change.editable && !empty change.attachments}">
			&nbsp;| <a href="<c:url value="changeAttachmentList.htm"><c:param name="id" value="${change.id}" /></c:url>">&nbsp;<fmt:message key="editAttachments" /></a>
		</c:if>
	</td>
</tr>
</tfoot>
</table>
</div>
</div>
</div>
</c:if>


	<c:forEach items="${licences}" var="item">
		<c:choose>
			<c:when test="${item=='risk'}">
				<c:set var="riskLicence" value="${true}" />
			</c:when>
		</c:choose>
	</c:forEach>

	<%-- <c:if test="${licences}"> --%>
<c:if test="${not empty sortedAssociatedAssessments && riskLicence}">
<a name="associatedAssessments"></a>
<c:set var="first" value="${false}" />
<c:set var="last" value="${null}" />
<c:forEach items="${sortedAssociatedAssessments}" var="assessment" varStatus="s">
  <c:if test="${assessment.template != last.template}">
    <c:choose>
      <c:when test="${first == false}"><c:set var="first" value="${true}" /></c:when>
      <c:otherwise></tbody></table></div></div></div></c:otherwise>
    </c:choose>

    <div class="header">
			<h3>
				<fmt:message key="changeAssessment.associatedRiskAssessments" /> - <c:out value="${assessment.template.name}"/>
			</h3>
		</div>
		<div class="content">
			<div class="table-responsive">
				<div class="panel">
					<table class="table table-bordered table-responsive dataTable associatedChangeTable">
<col class="label" />
      <thead>
        <tr>
          <td colspan="4" align="right" class="customizedColspan">
            <div class="navLinks">
              <a href="#assessment"><fmt:message key="assessment" /></a> <!-- |
              <a href="#tasks"><fmt:message key="assessment.tasks" /></a> Looks does not have tasks for this page-->
            </div>
          </td>
        </tr>
        <tr>
          <th><fmt:message key="id" /> / <fmt:message key="assessment.name" /></th>
          <c:forEach items="${assessment.template.summaryQuestions}" var="sq">
           <c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
	      <c:if test="${g.active}">
	        <c:forEach items="${g.questions}" var="q">
	          <c:if test="${sq.id == q.id and q.active and q.visible}">
	         <th><c:out value="${sq.name}" /></th>
	          </c:if>
	          <c:if test="${!empty q.columns}">
	          <c:forEach items="${q.columns}" var="childQ">
	            <c:if test="${sq.id == childQ.id and childQ.active and childQ.visible}">
	              <th><c:out value="${sq.name}" /></th>
	            </c:if>
	          </c:forEach>
	          </c:if>
	        </c:forEach>
	      </c:if>
	    </c:forEach>
          
          </c:forEach>
          <th><fmt:message key="assessment.status" /></th>
          <th><fmt:message key="assessment.responsibleUser" /></th>
          <c:if test="${assessment.template.scorable}">
          <th><fmt:message key="assessment.score" /></th>
          </c:if>
        </tr>
      </thead>
      <tbody id="questionsTbody">
  </c:if>

  <c:choose>
    <c:when test="${s.index mod 2 == 0}"><c:set var="style" value="even" /></c:when>
    <c:otherwise><c:set var="style" value="odd" /></c:otherwise>
  </c:choose>
  <tr class="<c:out value="${style}" />">
    <td>
      <a href="<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>" ><c:out value="${assessment.displayId}" /></a><br>
      <c:choose>
        <c:when test="${assessment.confidential}"><fmt:message key="assessment.confidential" /></c:when>
        <c:otherwise><scannell:text value="${assessment.name}" /></c:otherwise>
      </c:choose>
    </td>

    <c:forEach items="${assessment.template.summaryQuestions}" var="sq">
	    <c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
	      <c:if test="${g.active}">
	        <c:forEach items="${g.questions}" var="q">
	          <c:if test="${sq.id == q.id and q.active and q.visible}">
	          <td><enviromanager:answer question="${q}" answers="${assessment.answers}" /></td>
	          </c:if>
	          <c:if test="${!empty q.columns}">
	          <c:forEach items="${q.columns}" var="childQ">
	            <c:if test="${sq.id == childQ.id and childQ.active and childQ.visible}">
	              <td><enviromanager:answer question="${childQ}" answers="${assessment.answers}" /></td>
	            </c:if>
	          </c:forEach>
	          </c:if>
	        </c:forEach>
	      </c:if>
	    </c:forEach>
    </c:forEach>

    <td><fmt:message key="assessment${assessment.status}" /></td>
    <td><c:out value="${assessment.responsibleUser.displayName}" /></td>
    <c:if test="${assessment.template.scorable}">
    <td>
      <c:set var="threshold" value="${assessment.threshold}" />
      <c:choose>
		    <c:when test="${assessment.template.critical == true && assessment.score ge threshold.criticalLimit}">
		      <img src="<c:url value="/images/risk/score_redlight.giff" />" />
		    </c:when>
		    <c:when test="${assessment.template.critical == true && assessment.score ge threshold.upperLimit}">
		      <img src="<c:url value="/images/risk/score_amberlight.giff" />" />
		    </c:when>
		    <c:when test="${assessment.template.critical == false && assessment.score ge threshold.upperLimit}">
		      <img src="<c:url value="/images/risk/score_redlight.giff" />" />
		    </c:when>
		    <c:when test="${assessment.template.critical == true && assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
		      <img src="<c:url value="/images/risk/score_yellowlight.giff" />" />
		    </c:when>
		    <c:when test="${assessment.score lt threshold.upperLimit and assessment.score ge threshold.lowerLimit}">
		      <img src="<c:url value="/images/risk/score_amberlight.giff" />" />
		    </c:when>
		    <c:otherwise><img src="<c:url value="/images/risk/score_greenlight.giff" />" /></c:otherwise>
		</c:choose>
      <c:out value="${assessment.score}" />
    </td>
    </c:if>
  </tr>

  <c:set var="last" value="${assessment}" />
  <c:if test="${s.last}"></tbody></table></div></div></div></c:if>
</c:forEach>
</c:if>
<%-- </c:if> --%>
</div>
</body>
</html>
