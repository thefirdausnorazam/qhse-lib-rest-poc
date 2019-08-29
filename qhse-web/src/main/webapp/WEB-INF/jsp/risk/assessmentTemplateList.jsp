<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <title></title>
  <style type="text/css" media="all">      
  </style>
</head>
<body>
<div class="header nowrap">
<h2><fmt:message key="assessmentTemplateList.title" /></h2>
</div>
<c:set var="found" value="${!empty templateList}" />
<div class="content">  
<div class="table-responsive">
<div class="panel">
   	<c:if test="${!found}">
          <fmt:message key="search.empty" />
    </c:if>
<table class="table table-bordered table-responsive">
  <col class="label" />
  <tbody>
  <c:forEach items="${templateList}" var="template" varStatus="s">
  <c:set var="expressQuestionGroup" value="${template.expressQuestionGroup==null}"></c:set>
    <c:choose>
      <c:when test="${s.index mod 2 == 0}">
        <c:set var="style" value="even" />
      </c:when>
      <c:otherwise>
        <c:set var="style" value="odd" />
      </c:otherwise>
    </c:choose>
    <tr class="<c:out value="${style}" />">
      <td >
        <c:choose>
          <c:when test="${param.expressTemplatesOnly == 'true'}">
				<ul><li class="nowrap"><a target="assessmentHardcopy" href="<c:url value="/risk/assessmentHardcopy.htm?printable=true"><c:param name="templateId" value="${template.id}" /></c:url>"><c:out value="${template.name}" /></a></li></ul>
          </c:when>
          <c:otherwise>
          		<c:choose>
        			<c:when test="${expressQuestionGroup}">
        				<c:choose>
        					<c:when test="${(template.prefix == 'RAMS' || template.prefix == 'HS-PPE') || (template.prefix == 'PTA' && template.multiApproval)}">
        						<ul><li class="nowrap"><a href="<c:url value="/risk/assessmentRAMSStep1.htm"><c:param name="templateId" value="${template.id}" /></c:url>"><c:out value="${template.name}" /></a></li></ul>
        					</c:when>
        					<c:otherwise>
        						<ul><li class="nowrap"><a href="<c:url value="/risk/assessmentStep1.htm"><c:param name="templateId" value="${template.id}" /></c:url>"><c:out value="${template.name}" /></a></li></ul>
        					</c:otherwise>
        				</c:choose>
					</c:when>
					<c:otherwise>
						<c:if test="${template.prefix == 'SA'}">
							<ul><li class="nowrap"><a href="<c:url value="/risk/expressAssessmentABBPStep1.htm"><c:param name="templateId" value="${template.id}" /></c:url>"><c:out value="${template.name}" /></a></li></ul>
						</c:if>
						<c:if test="${template.prefix != 'SA'}">
							<ul><li class="nowrap"><a href="<c:url value="/risk/expressAssessmentStep1.htm"><c:param name="templateId" value="${template.id}" /></c:url>"><c:out value="${template.name}" /></a></li></ul>
						</c:if>
         			</c:otherwise>
        	  </c:choose>
          </c:otherwise>
        </c:choose>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</div>
</div>
</div>
</body>
</html>
