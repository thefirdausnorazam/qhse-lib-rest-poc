<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="legislation" required="true"
	type="com.scannellsolutions.modules.law.domain.Legislation"%>
<%@ attribute name="profile" required="true"
	type="com.scannellsolutions.modules.law.domain.LegacyProfile"%>
<%@ attribute name="viewType" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>

<%@ tag import="com.scannellsolutions.modules.law.domain.Legislation"%>
<%@ tag import="com.scannellsolutions.modules.law.domain.LegacyProfile"%>

<!-- Added By Manjush on 15 Jan 2015  -->


      <%-- <a href="#top"><img src="<law:url value="/legal/images/enviroMANAGER_Application_Arrow1.gif" />"></a> --%>
      <!-- <div class="header">
      <h3>STATUTORY INSTRUMENTS</h3>
      </div> -->
    
<div class="content">
   
    <c:forEach items="${legislation.statutoryInstruments}" var="statutoryInstrument">
      <div>
               
		        <c:if test="${statutoryInstrument.changedInLatestContentVersion}">
		           <span style="padding-right:5px;"><img src="<law:url value="/legal/images/enviroMANAGER_Application_Bullet2.gif" />"></span>
		        </c:if>         
        	
		         <span style="padding-right:5px;"><img src="<law:url value="/legal/images/${statutoryInstrument.economicRegion.id}.gif" />"></span>
        	
              <law:legislationLink legislation="${statutoryInstrument}" profile="${profile}" viewType="${viewType}" />
        	
        
      </div>
    </c:forEach>      
     
  </div> 