<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>

<!DOCTYPE html>
<html>
<head>
  <meta name="confidential" content="false">
  <meta name="printCopyright" content="true">
  
<jsp:include page="headInclude.jsp" />

<%-- <title>${title}</title> --%>


<style type="text/css">

.change-item-title {
  background-color: #d8e0f0;
  font-weight: bold;
  font-size: 12px;
  line-height: 2em;
  border-top: 5px;
  margin-bottom: 2px;
}

.profile-title {
  font-size: 16px;
  color: #666699;
  font-weight: bold;
  text-align: center;
  margin-bottom: 10px;
}
.view-all {
  font-size: 12px;
  color: #666699;
  text-align: center;
  margin-bottom: 10px;
}
.links {
  margin-top: 5px;
}
</style>
 <script type="text/javascript">
 jQuery(document).ready(function() {	 
	 jQuery('.printCopyright').hide();
 });

 </script>
</head>

<body>
<a name="top"></a>

<div class="row">
<div class="col-sm-12 col-md-12 col-lg-12">
<div class="block-flat">
<div class="header">
				<div class="content"><h2><c:out value="${title}" /></h2></div>
				<div class="content"><h3>for Profile: <c:out value="${profile.name}" /></h3></div>
				<div class="content"><h4><a class="g-btn g-btn--primary" href="<law:url value="/law/changeRecord.htm?legRegister=${profile.registerType.id}" />"><i class="fa fa-cloud-upload"></i>
				View All Changes</a></h4></div>
			</div>


<law:profileVersionCheck profile="${profile}" />




<c:set var="latestChangedLegislationsByCategory" value="${profile.latestChangedLegislationsByCategory}" />
<c:if test="${empty latestChangedLegislationsByCategory}">
  <div class="content">No changes</div>
</c:if>
  
<c:forEach items="${latestChangedLegislationsByCategory}" var="categoriesToLegislationEntry" varStatus="sm">
  <c:set var="category" value="${categoriesToLegislationEntry.key}" />
  <c:set var="legislations" value="${categoriesToLegislationEntry.value}" />

<div class="panel-group accordion accordion-semi" id="accordion<c:out value="${sm.index}" />">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="collapsed" data-toggle="collapse"
												data-parent="#accordion3" href="#${sm.index}"> <i class="fa fa-angle-right"></i> 
												<span  class="badge"><c:out value="${category.name}" /></span>
												
												  
											</a>
										</h4>
									</div>
									<div id="${sm.index}" class="panel-collapse collapse out"	>	
										<div class="panel-body">
										
										  <div class="content">
    <div>
      <c:forEach items="${legislations}" var="legislation" >
           <div class=row>
            <div class="col-sm-1">
             <a name="leg:${legislation.id}:${legislation.version}" />
             <img src="<law:url value="/legal/images/${legislation.economicRegion.id}.gif" />">
            </div>
          <div class="col-sm-5">
	            <div class="legislationtitle">
	              <c:out value="${legislation.name}" escapeXml="false" />
	              <law:legislationAltNames legislation="${legislation}" /> 
	            </div>
	            <div class="links">
	              <a title="Synopsis &amp; Secondary Legislation" href="<law:legislationUrl legislation="${legislation}" profile="${profile}" viewType="${viewType}" />">
	                VIEW SYNOPSIS <img src="<law:url value="/legal/images/enviroLAW_Application_Arrow12x12.gif" />"/></a>
	              <a title="Checklists" href="<law:relevanceUrl legislation="${legislation}" profile="${profile}" viewType="${viewType}" />">
	                UPDATE COMPLIANCE <img src="<law:url value="/legal/images/enviroLAW_Application_Arrow12x12.gif" />"/></a>
	            </div>
          </div>
           <div class="col-sm-6">
             <c:choose>
               <c:when test="${not empty legislation.changeComment}"><c:out value="${legislation.changeComment}" escapeXml="false" /></c:when>
               <c:otherwise>No Comment</c:otherwise>
             </c:choose>
           </div>
         </div>
      </c:forEach>
    </div>
  </div>
										
										
										
										
										
										
										
										</div> <!-- Panel Body -->
								</div>
							</div>				
				
				  </div>







  
  

  
</c:forEach>

</div>
</div>
</div>

</body>
</html>
