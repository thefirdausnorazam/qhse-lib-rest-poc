<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title><fmt:message key="healthRecordQueryResult.title" /></title>
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
<c:set var="found" value="${!empty result.results}" />
<div class="content">
<div class="table-responsive">
<div class="panel">
    <c:if test="${found}">
          <scannell:paging result="${result}" />
    </c:if>
<table class="viewForm bordered dataTable">
  <thead>
    <tr>
      <td colspan="5"><fmt:message key="healthRecordQueryResult.searchResults" /></td>
    </tr>
    <c:if test="${found}">
    <tr>
      <th><fmt:message key="id" /></th>
      <th><fmt:message key="healthRecord.person" /></th>
      <th><fmt:message key="healthRecord.department" /></th>
      <th><fmt:message key="healthRecord.seg" /></th>
      <th><fmt:message key="healthRecord.employmentStartDate" /></th>
    </tr>
    </c:if>
  </thead>

  <tbody>

    <c:forEach items="${result.results}" var="record" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="/health/recordView.htm"><c:param name="id" value="${record.id}"/></c:url>" ><c:out value="${record.id}" /></a></td>
        <td><scannell:text value="${record.person.displayName}" /></td>
        <td><scannell:text value="${record.department.name}" /></td>
        <td><scannell:text value="${record.seg}" /></td>
        <td><fmt:formatDate value="${record.employmentStartDate}" pattern="dd-MMM-yyyy" /></td>
      </tr>
    </c:forEach>
    <tfoot>
	    <c:if test="${found}">
	    <tr>
	      <td colspan="5"><scannell:paging result="${result}" /></td>
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
