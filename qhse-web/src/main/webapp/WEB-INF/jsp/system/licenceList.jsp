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
	<div class="col-md-12 col-sm-12 pull-right">
		<div align="right">
		<input type="text" id="refreshCheck" value="no" style="display: none;">
		<div id="fontColorChanged">
			<c:forEach items="${urls}" var="urlModel">
				<button type="button" class="g-btn g-btn--primary" onclick="location.href='${urlModel.url}'"><i class="fa fa-download" style="color: white"></i>&nbsp;<fmt:message key="${urlModel.name}"/></button>
			</c:forEach>
		    <button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
		</div>
		</div>
	</div>
<div class="header">
<h2><fmt:message key="licenceList" /></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
  <thead>
    <tr>
      <th><fmt:message key="licence.comment" /></th>
      <th><fmt:message key="licence.current" /></th>
      <th><fmt:message key="licence.expiryDate" /></th>
      <th><fmt:message key="licence.importedBy" /></th>
    </tr>
  </thead>

  <tbody>
    <c:forEach items="${licences}" var="licence" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="licenceView.htm"><c:param name="id" value="${licence.id}"/></c:url>" ><c:out value="${licence.comment}" /></a></td>
        <td><c:if test="${licence.current}"><fmt:message key="yes" /></c:if>&nbsp;</td>
	    <td><c:out value="${licence.expiryDate}" /></td>
	    <td><c:out value="${licence.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${licence.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
      </tr>
    </c:forEach>  
  </tbody>

</table>
</div>
</div>
</div>
</body>
</html>
