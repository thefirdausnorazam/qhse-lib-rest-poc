<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>

<a name="top"></a>

<table width="100%">
  <tbody>
    <c:forEach items="${profile.checklistsByCategory}" var="categoryEntry">
      <tr>
        <td>
          <a href="#top"><img src="<c:url value="/legal/images/enviroMANAGER_Application_Arrow1.gif" />"></a>
        </td>
        <td>
          <div class="checklist-title"><a name="${categoryEntry.key.id}"></a>${categoryEntry.key.name}</div>
        </td>
        <td>
          <div class="checklist-title" align="center" >Relevance Entered</div>
        </td>
      </tr>
      <c:forEach items="${categoryEntry.value}" var="checklist">
      <tr>
        <td>
          <c:choose>
            <c:when test="${checklist.changedInLatestContentVersion}">
              <img src="<c:url value="/legal/images/enviroMANAGER_Application_Bullet2.gif" />">
            </c:when>
            <c:otherwise>
              <img src="<c:url value="/legal/images/enviroMANAGER_Application_Bullet1.gif" />">
            </c:otherwise>
          </c:choose>
        </td>
        <td class="checklist-legislation-item">
          <c:out value="${checklist.name}" escapeXml="false" />
          <law:checklistAltNames checklist="${checklist}" /> 
          <span class="checklist-id">[ID#:<c:out value="${checklist.id}" />]</span>
        </td>
        <td class="checklist-legislation-item" align="center">
    	 <span class="ss-checkbox-${checklist.relevanceEntered ? 'on' : 'off'}">&nbsp;</span>
        </td>
      </tr>
      </c:forEach>
    </c:forEach>

  </tbody>
</table>
