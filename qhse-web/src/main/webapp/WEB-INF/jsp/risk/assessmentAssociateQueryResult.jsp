<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="assessmentAssociateQueryResult.title" /></title>
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			  var assColspan = jQuery("#assTable > tbody").find("> tr:first > td").length;
			  jQuery("#assTable > tfoot tr td").attr('colSpan', assColspan);
			initSortTables();
			 jQuery('select').select2();
		} );
	</script>
<div class="header">
<h3> <fmt:message key="assessmentQueryResult.searchResults" /></h3>
</div>
<c:set var="found" value="${!empty result.results}" />
<div class="content">  
<div class="table-responsive">
<div class="panel" >
    <c:if test="${found}">
          <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
    </c:if>
<table id="assTable" class="table table-bordered table-responsive dataTable">
  <thead>    
    <c:if test="${found}">
    <tr>
      <th style="width:50%"><fmt:message key="id" />/<fmt:message key="assessment.name" /></th>
      	<c:forEach items="${result.results}" var="assessment" varStatus="s">
      	<c:if test="${s.index == 0 }">
      		<c:forEach var="sq" items="${template.summaryQuestions}">
      			<c:forEach items="${assessment.template.detailsQuestionGroups}" var="g">
			  		<c:if test="${g.active}">
		        		<c:forEach items="${g.questions}" var="q">
		        			<c:if test="${sq.id == q.id and q.active and q.visible}">
					      		<th><c:out value="${q.name}" /></th>
					      	</c:if>
		        			<c:if test="${!empty q.columns}">
		        				<c:forEach items="${q.columns}" var="childQ">
		        					<c:if test="${sq.id == childQ.id and childQ.active and childQ.visible}">
		        						<th><c:out value="${q.name}" /></th>
		        					</c:if>
		        				</c:forEach>
		        			</c:if>
					     </c:forEach>   
					</c:if>
			  	</c:forEach>
			  </c:forEach>
			</c:if>
		</c:forEach>
      <th><fmt:message key="assessment.responsibleUser" /></th>
      <th><fmt:message key="assessment.score" /></th>
      <th>&nbsp;</th>
    </tr>
    </c:if>
  </thead>

  <tbody>

    <c:forEach items="${result.results}" var="assessment" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />" style="${assessmentOwner == assessment.id ? 'display:none' : ''}">
        <td>
          <a href="<c:url value="/risk/assessmentView.htm"><c:param name="id" value="${assessment.id}"/></c:url>" ><c:out value="${assessment.displayId}" /></a><br>
          <c:if test="${assessment.confidential}"><fmt:message key="assessment.confidential"/></c:if>
	  	  <c:if test="${assessment.sensitiveDataViewable}"><scannell:text value="${assessment.name}" /></c:if>
        </td>

        <c:forEach items="${template.summaryQuestions}" var="sq">
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

        <td><c:out value="${assessment.responsibleUser.displayName}" /></td>
        <c:if test="${assessment.template.scorable}">
        <td>
        <c:if test="${assessment.template.prefix != 'SA'}">
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
          </c:if>
        </td>
        </c:if>
		<c:if test="${!assessment.template.scorable}">
			<td> </td>
		</c:if>
        <td id="<c:out value="assessment[${assessment.id}].link" />">
          <c:set var="associated" value="false" />
          <c:forEach var="a" items="${associateAssessment.associatedAssessments}">
            <c:if test="${a == assessment}">
              <c:set var="associated" value="true" />
            </c:if>
          </c:forEach>
          <c:choose>
            <c:when test="${associated}">
              <a href="#" onclick="<c:out value="unassociate(${assessment.id});" />">UnAssociate</a>
            </c:when>
            <c:otherwise>
              <a href="#" onclick="<c:out value="associate(${assessment.id});" />">Associate</a>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
    </c:forEach>
    <tfoot>
	    <c:if test="${found}">
	    <tr>
	      <td colspan="99"><scannell:paging result="${result}" /></td>
	    </tr>
	    </c:if>
    </tfoot>
  </tbody>
</table>
</div>
</div>
</div>
</body>
</html>
