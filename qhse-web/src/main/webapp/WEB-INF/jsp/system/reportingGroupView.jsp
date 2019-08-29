<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
</head>

<body>
<div class="header">
<h2><fmt:message key="reportingGroupView" /></h2>
</div>

<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
<tbody>
  <tr>
    <td ><fmt:message key="name" />:</td>
    <td><c:out value="${group.name}" /></td>
  </tr>
  <tr>
    <td><fmt:message key="usersCountActive" />:</td>
    <td>
    	<c:out value="${usersCountActive}" />
    </td>
  </tr>
  <tr>
    <td><fmt:message key="usersCount" />:</td>
    <td>
    	<c:out value="${usersCount}" />
    </td>
  </tr>
  <tr>
    <td><fmt:message key="enviro.reportingGroupsSites" />:</td>
    <td>
      <%-- <ul>
      <c:forEach items="${group.reportingGroups}" var="rgroup" varStatus="s">
        <system:childReportingGroup rgroup="${child}"/>
      </c:forEach>
      </ul> --%>
      <ul>
      <c:forEach items="${group.reportingGroups}" var="rgroup" varStatus="s">
        <li><a href="<c:url value="reportingGroupView.htm"><c:param name="id" value="${rgroup.id}" /></c:url>"><c:out value="${rgroup.name}" /></a></li>
	        <ul>
		        <c:forEach items="${rgroup.sites}" var="site" varStatus="s">
		        	<li><c:out value="${site.name}" /></li>
		        </c:forEach>
		        <c:forEach items="${rgroup.reportingGroups}" var="childGroup1" varStatus="s"><li><a href="<c:url value="reportingGroupView.htm"><c:param name="id" value="${childGroup1.id}" /></c:url>"><c:out value="${childGroup1.name}" /></a></li>
			        <ul>
				        <c:forEach items="${childGroup1.sites}" var="site" varStatus="s">
				        	<li><c:out value="${site.name}" /></li>
				        </c:forEach>
				        <c:forEach items="${childGroup1.reportingGroups}" var="childGroup2" varStatus="s"><li><a href="<c:url value="reportingGroupView.htm"><c:param name="id" value="${childGroup2.id}" /></c:url>"><c:out value="${childGroup2.name}" /></a></li>
					        <ul>
						        <c:forEach items="${childGroup2.sites}" var="site" varStatus="s">
						        	<li><c:out value="${site.name}" /></li>
						        </c:forEach>
						        <c:forEach items="${childGroup2.reportingGroups}" var="childGroup3" varStatus="s"><li><a href="<c:url value="reportingGroupView.htm"><c:param name="id" value="${childGroup3.id}" /></c:url>"><c:out value="${childGroup3.name}" /></a></li>
							        <ul>
								        <c:forEach items="${childGroup3.sites}" var="site" varStatus="s">
								        	<li><c:out value="${site.name}" /></li>
								        </c:forEach>
								        <c:forEach items="${childGroup3.reportingGroups}" var="childGroup4" varStatus="s"><li><a href="<c:url value="reportingGroupView.htm"><c:param name="id" value="${childGroup4.id}" /></c:url>"><c:out value="${childGroup4.name}" /></a></li>
									        <ul>
										        <c:forEach items="${childGroup4.sites}" var="site" varStatus="s">
										        	<li><c:out value="${site.name}" /></li>
										        </c:forEach>
										        <c:forEach items="${childGroup4.reportingGroups}" var="childGroup5" varStatus="s"><li><a href="<c:url value="reportingGroupView.htm"><c:param name="id" value="${childGroup5.id}" /></c:url>"><c:out value="${childGroup5.name}" /></a></li>
											        <ul>
												        <c:forEach items="${childGroup5.sites}" var="site" varStatus="s">
												        	<li><c:out value="${site.name}" /></li>
												        </c:forEach>
												        <c:forEach items="${childGroup5.reportingGroups}" var="site" varStatus="s">
												        	<li><c:out value="${site.name}" /></li>
												        </c:forEach>
											        </ul>
										      </c:forEach>
									        </ul>
								      </c:forEach>
							        </ul>
						      </c:forEach>
					        </ul>
				      </c:forEach>
			        </ul>
		      </c:forEach>
	        </ul>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr>
    <td><fmt:message key="sitesActive" />:</td>
    <td>
      <ul>
      <c:forEach items="${group.sites}" var="site" varStatus="s">
        <li><c:out value="${site.name}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr>
    <td><fmt:message key="groups" />:</td>
    <td>
      <ul>
      <c:forEach items="${group.groups}" var="group" varStatus="s">
        <li><a href="<c:url value="groupView.htm"><c:param name="id" value="${group.id}" /></c:url>"><c:out value="${group.name}" /></a></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr>
    <td><fmt:message key="groupView.groupUsers" />:</td>
    <td>
      <ul>
      <c:forEach items="${groupUsers}" var="user" varStatus="s">
        <li><a href="<c:url value="userView.htm"><c:param name="id" value="${user.id}" /></c:url>"><c:out value="${user.sortableName}" /></a></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr>
    <td><fmt:message key="users" />:</td>
    <td>
      <ul>
      <c:forEach items="${group.users}" var="user" varStatus="s">
        <li><a href="<c:url value="userView.htm"><c:param name="id" value="${user.id}" /></c:url>"><c:out value="${user.sortableName}" /></a></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
  <tr>
    <td ><fmt:message key="createdBy" /></td>
    <td><c:out value="${group.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${group.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </tr>

  <c:if test="${group.lastUpdatedByUser != null}">
	  <tr>
	    <td ><fmt:message key="lastUpdatedBy" /></td>
	    <td>
	      <c:out value="${group.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${group.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" />
	    </td>
	  </tr>
	</c:if>
</tbody>

<tfoot>
  <tr><td colspan="2"><scannell:url urls="${urls}" /></td></tr>
</tfoot>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
