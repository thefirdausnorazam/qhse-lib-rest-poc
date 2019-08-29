<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>
<body>
<div class="header">
<h2><fmt:message key="questionOptionView" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>

	<tbody>
		<tr>
			<td  class="scannellGeneralLabel"><fmt:message key="id" />:</td>
			<td><c:out value="${option.id}" /></td>
		</tr>
		<tr>
			<td  class="scannellGeneralLabel"><fmt:message key="name" />:</td>
			<td><c:out value="${option.name}" /></td>
		</tr>
		<%-- <tr>
			<td ><fmt:message key="furtherInfo" />:</td>
			<td><c:out value="${option.furtherInfo}" /></td>
		</tr> --%>
		<tr>
			<td  class="scannellGeneralLabel"><fmt:message key="order" />:</td>
			<td><c:out value="${option.optionOrder}" /></td>
		</tr>
		<tr>
			<td  class="scannellGeneralLabel"><fmt:message key="active" />:</td>
			<td><fmt:message key="${option.activeIgnoringSite}" /></td>
		</tr>
	      <tr>
	        <td  class="scannellGeneralLabel"><fmt:message key="questionOption.activeInSites" />:</td>
	        <td>
	          <ul>
	            <c:forEach items="${activeInSites}" var="site">
	              <li><c:out value="${site.name}" /></li>
	            </c:forEach>
	          </ul>
	        </td>
	      </tr>
  		<%-- <tr>
			<td ><fmt:message key="visible" />:</td>
			<td><fmt:message key="${option.visible}" /></td>
		</tr> --%>
		<tr>
			<td  class="scannellGeneralLabel"><fmt:message key="question" />:</td>
			<td><a href="<c:url value="clientQuestionView.htm"><c:param name="id" value="${option.question.id}" /></c:url>"><c:out value="${option.question.name}" /></a></td>
		</tr>
		<tr>
			<td  class="scannellGeneralLabel"><fmt:message key="dependsOn" />:</td>
			<td>
				<table>
					<c:forEach items="${option.dependsOnOptions}" var="dependsOnOption" varStatus="s">
						<tr>
							<td><c:out value="${dependsOnOption.dependsOnOption.name}" /></td>
							<td>
								<c:url var="optionEditUrl" value="dependsOnOptionConfigure.htm">
									<c:param name="id" value="${dependsOnOption.id}" />
									<c:param name="questionId" value="${option.question.id}" />
									<c:param name="optionId" value="${option.id}" />
								</c:url>
								<a href="<c:out value="${optionEditUrl}" />" style="align:right;text-align: right"> &nbsp;<fmt:message key="configureDependsOnQuestions" /></a> 
								<c:if test="${dependsOnOption.lastUpdatedByUser != null}">
							     	&nbsp;|&nbsp;
							        <a href="javascript:openHistory(<c:out value="${dependsOnOption.id},'${dependsOnOption['class'].name}'" />)">
							        <fmt:message key="viewHistory" /></a>
							    </c:if>
						    </td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
		<tr>
			<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
			<td><c:out value="${option.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
					value="${option.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
		</tr>
		<c:if test="${option.lastUpdatedByUser != null}">
			<tr>
				<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
				<td><c:out value="${option.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate
						value="${option.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
			</tr>
		</c:if>
		</tbody>
	<tfoot>
		<tr>
			<td colspan="2">
				<scannell:url urls="${urls}" />
			</td>
		</tr>
	</tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
