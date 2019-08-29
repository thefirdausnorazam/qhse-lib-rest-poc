<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ideagen" uri="/WEB-INF/tlds/ideagen.tld"%>

<!DOCTYPE html>
<!--<c:set var="lawRegisterId" value="${defaultRegisterType.id}" />
<c:if test="${envRegisterType.active}" >
    <c:set var="lawRegisterId" value="1" />
</c:if>
<c:if test="${hsRegisterType.active}" >
    <c:set var="lawRegisterId" value="2" />
</c:if>-->

<html>
<head>
  <title><fmt:message key="taskQueryResult.title" /></title>
  
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
<c:set  var="found"  value="${!empty result.results}" />
 <div class="header">
<h3><fmt:message key="searchResults" /></h3>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<c:if test="${found}">
    <div class="div-for-pagination" > <ideagen:paging result="${result}" /></div>
</c:if>
<table class="table table-bordered table-responsive dataTable">
  <thead>
	    <tr>
	      <th class="sortByNumber"><fmt:message key="id" /></th>
	      <th><fmt:message key="task.name" /></th>
	      <th><fmt:message key="task.status" /></th>
	      <th><fmt:message key="department" /></th>
	      <th><fmt:message key="profileName" /></th>
	      <th><fmt:message key="task.responsibleUser" /></th>
	      <th><fmt:message key="task.targetCompletionDate" /></th>
	      <c:if test="${showSiteColumn}"><th><fmt:message key="site" /></th></c:if>
	    </tr>
  </thead>

  <tbody>

    <c:forEach items="${result.results}" var="task" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
  	    <td><a href="<c:url value="/law/taskViewSearch.htm"><c:param name="id" value="${task.id}"/></c:url>" ><c:out value="LT${task.id}" /></a></td>
  	    <td><c:out value="${task.name}" /></td>
        <td><fmt:message key="${task.status}" /></td>
        <td><c:out value="${task.responsibleDepartment}" /></td>
        <td><c:out value="${task.profileId}" /></td>
        <td><c:out value="${task.responsibleUserDto.name}" /></td>
        <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
		<c:if test="${showSiteColumn}"><td><c:out value="${task.site}" /></td></c:if>
     </tr>
    </c:forEach>
    <tfoot>
        <c:if test="${found}">
            <tr>
                <td colspan="7"><ideagen:paging result="${result}" /></td>
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
