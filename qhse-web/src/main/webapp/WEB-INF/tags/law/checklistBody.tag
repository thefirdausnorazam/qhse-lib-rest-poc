<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="checklist" required="true" type="com.scannellsolutions.modules.law.domain.Checklist" %>
<%@ attribute name="profile" required="true" type="com.scannellsolutions.modules.law.domain.LegacyProfile" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>

<%@ tag import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@ tag import="com.scannellsolutions.modules.law.domain.LegacyProfile"%>

  <%--     <tr>
        <td></td>
        <td>
          <div class="checklist-description">
            <scannell:text value="${checklist.description}" htmlEscape="false" newlineEscape="true" />
          </div>
          <div class="checklist-description">
            <div class="checklist-description-title">Things to Consider:</div>
            <scannell:text value="${checklist.thingsToConsider}" htmlEscape="false" newlineEscape="true" />
          </div>
          <c:if test="${not empty checklist.changeComments}" >
          <div class="checklist-description">
            <div class="checklist-description-title">Changes:</div>
            <ul>
		  	<c:forEach items="${checklist.changeCommentsNewestFirst}" var="item">
				<li>
		  		<div class="checklist-change-hist-version">Version ${item.version} - <fmt:formatDate value="${item.publicationDate}" pattern="dd MMMM yyyy"/></div>
		  		<div class="checklist-change-hist-comment">${item.comment}</div>
				</li>		  		
		  	</c:forEach>
            </ul>
          </div>
          </c:if>
          
		<c:if test="${profile != null}">
          <div>
            <div class="relevance-title">&nbsp;</div>
          </div>
          <div class="relevance-detail">
           	<law:checklistRelevance checklist="${checklist}" profile="${profile}"/>
          </div>
          </c:if>
        </td>
      </tr> --%>

      <tr>
        <td> 
        </td>
        <td class="checklist-legislation">
            <div class="checklist-legislation-title">
              <a href="#top"><img src="<law:url value="/legal/images/enviroMANAGER_Application_Arrow1.gif" />"></a>
              Legislation:  
            </div>
        </td>    
      </tr>    
      <c:forEach items="${checklist.relatedLegislationsByRegionDisplayOrderAndOrigDate}" var="legislation">
	      <c:if test="${legislation.economicRegion != lastEcomomicRegion || legislation.dispalyOrder != lastDisplayOrder }" >
		      <tr>
		        <td class="change-indicator">
		        </td>
		        <td>
		          <div class="checklist-legislation-item">
		          	${legislation.economicRegion.name}, <fmt:message key="LegislationDispalyOrder.${legislation.dispalyOrder}" />
		          </div>
		        </td>
		      </tr>
	      </c:if>
	      <tr>
	      	<td class="change-indicator"></td>
	        <td>
	          <div class="checklist-legislation-item">
		        <table style="margin: 0;">
		          <tr>
		          	<td style="vertical-align: top; width: 20px;">
	          			<c:if test="${legislation.changedInLatestContentVersion}">
	            			<img src="<law:url value="/legal/images/enviroMANAGER_Application_Bullet2.gif" />">
	          			</c:if>
	        		</td>
		        	<td style="vertical-align: top; width: 20px;">
			            <img src="<law:url value="/legal/images/${legislation.economicRegion.id}.gif" />">
		        	</td>
		        	<td>
		        	  <law:legislationLink legislation="${legislation}" profile="${profile}" />
		        	</td>
	              </tr>
		        </table>
	          </div>
	        </td>
	      </tr>
	      <c:set var="lastEcomomicRegion" value="${legislation.economicRegion}" />
	      <c:set var="lastDisplayOrder" value="${legislation.dispalyOrder}" />
      </c:forEach>      

      <c:if test="${not empty checklist.relatedChecklists}">
        <tr>
          <td> 
          </td>
          <td class="checklist-legislation">
              <div class="checklist-legislation-title">
                <a href="#top"><img src="<law:url value="/legal/images/enviroMANAGER_Application_Arrow1.gif" />"></a>
                Related Checklists:
              </div>
          </td>    
        </tr>    
        <c:forEach items="${checklist.relatedChecklists}" var="relatedChecklist">
          <tr>
            <td class="change-indicator"></td>
            <td>
              <div class="checklist-legislation-item">
              <table style="margin: 0;">
	            <tr>
	            	<td style="vertical-align: top; width: 20px;">
	            		<c:if test="${relatedChecklist.changedInLatestContentVersion}">
                			<img src="<law:url value="/legal/images/enviroMANAGER_Application_Bullet2.gif" />">
              			</c:if>
              		</td>
	              <td style="vertical-align: top; width: 20px;">
                    <img src="<law:url value="/legal/images/enviroMANAGER_Application_Bullet1.gif" />">
	              </td>
    	          <td>
    	            <c:set var="relatedChecklistUrl"><law:checklistUrl checklist="${relatedChecklist}" profile="${profile}"/></c:set>
	                <c:if test="${param['viewAll'] == 'true'}" >
	                  <c:set var="relatedChecklistUrl" value="${'#'}${relatedChecklist.id}" />
	                </c:if>
	                <a href="${relatedChecklistUrl}"><c:out value="${relatedChecklist.name}" escapeXml="false" /></a>
	                <law:checklistAltNames checklist="${relatedChecklist}" />
	        	  </td>
                </tr>
	          </table>
              </div>
            </td>
          </tr>
        </c:forEach>
      </c:if>