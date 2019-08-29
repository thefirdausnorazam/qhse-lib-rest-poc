<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
<title></title>
	 <script type="text/javascript">
		 jQuery(document).ready(function(){
			 initSortTables();
		 })
 	</script>
</head>
<body>
<div class="header">
<h2><fmt:message key="selectAction" /></h2>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel panel-danger"> 
<table class="table table-bordered table-responsive datatable">
  <thead>
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="type" /></th>
      <th><fmt:message key="description" /></th>
      <th><fmt:message key="completionTargetDate" /></th>
      <th><fmt:message key="responsibleUser" /></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${actions}" var="item" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
      <td><c:out value="${item.id}" /></td>
      <td><fmt:message key="${item['class'].name}" /></td>
      <td><div><c:out value="${item.description}" /></div></td>
      <td><fmt:formatDate value="${item.completionTargetDate}" pattern="dd-MMM-yyyy" /></td>
      <td><c:out value="${item.responsibleUser.displayName}" /></td>
      <td><a href="<c:url value="selectAction.htm"><c:param name="id" value="${item.id}" /></c:url>" ><fmt:message key="select" /></a></td>
    </tr>
  </c:forEach>
  </tbody>

</table>
</div>
</div>
</div>



</body>
</html>
