<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>

<div class="col-md-12">
	
	<div id="block" class="">
		<div >
		    <div style="padding-left:0px;" class="col-md-6">
			</div>
		    <div class="col-md-12 col-sm-12">
		    	<div align="right">
		    <form action="<c:url value="/system/clientQuestionView.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
				<button type="button" class="g-btn g-btn--primary" onclick="location.href='questionEdit.htm'"><i class="fa fa-edit" style="color:white"></i>&nbsp;<fmt:message key="newClientQuestion" /></button>

			  </form>

		  		</div>
		 	</div>
		</div>
		<input type="text" id="refreshCheck" value="no" style="display: none;">
	</div>
</div>


<div class="header">
<h3><fmt:message key="listClientQuestion" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
  <thead>
    <%-- <tr>
      <td colspan="10"><scannell:url urls="${urls}" /></td>
    </tr> --%>
    <tr>
      <th><fmt:message key="questionUniqueName" /></th>
      <th><fmt:message key="displayName" /></th>
      <th><fmt:message key="type" /></th>
      <th><fmt:message key="modules" /></th>
	  <th><fmt:message key="active" /></th>
    </tr>
  </thead>

  <tbody>
    <c:forEach items="${questions}" var="question" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="clientQuestionView.htm"><c:param name="id" value="${question.id}"/></c:url>" ><c:out value="${question.codeName}" /></a></td>
        <td><c:out value="${question.name}" /></td>
        <td><fmt:message key="${question.answerType}" /></td>
		<td>
			 <c:forEach items="${question.modules}" var="module">
			 	<fmt:message key="${module.name}" />&nbsp;
			 </c:forEach>
		</td>
		<td><fmt:message key="${question.active}" /></td>
      </tr>
    </c:forEach>
   </tbody>
</table>
</div>
</div>
</div>
</body>
</html>
