<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="checklist" required="true" type="com.scannellsolutions.modules.law.domain.Checklist" %>
<%@ attribute name="profile" required="true" type="com.scannellsolutions.modules.law.domain.LegacyProfile" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>

<%@ tag import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@ tag import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@ tag import="com.scannellsolutions.modules.law.domain.LegacyProfile"%>

   <thead checklistid="${checklist.id}" class="checklist" profileId="${profile.id}">  
      <tr>
        <td valign="top" style="padding-top: 10px; width: 20px;">
          <a href="#top"><img src="<law:url value="/legal/images/enviroMANAGER_Application_Arrow1.gif" />"></a> <br />
          <c:if test="${checklist.changedInLatestContentVersion}">
            <img src="<law:url value="/legal/images/enviroMANAGER_Application_Bullet2.gif" />">
          </c:if>
        </td>
        <td>
          <div class="checklist-title"><a name="<c:out value="${checklist.id}" />"></a>
            <c:out value="${checklist.name}" escapeXml="false" />
          	<law:checklistAltNames checklist="${checklist}" />
            <span class="checklist-id">[ID#:<c:out value="${checklist.id}" />]</span>
          </div>
        </td>
      </tr>
    </thead>  
    
    <tbody checklistid="${checklist.id}" class="checklist"> 
    	<c:choose><c:when test="${param['showAll'] == 'true'}" ><tr><td></td><td><law:checklistBody checklist="${checklist}" profile="${profile}" /></td></tr></c:when><c:otherwise><tr><td></td><td><div id ="showChecklistDetail" class="showChecklistDetail"/></td></tr></c:otherwise></c:choose>
    </tbody>