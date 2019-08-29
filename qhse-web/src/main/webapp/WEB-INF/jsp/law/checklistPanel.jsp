<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <meta name="confidential" content="false">
  <meta name="printCopyright" content="true">
<style type="text/css">
.gre {
	text-align: center;
	width: 20px;
	font-size: 14px;
	margin-right: 7px;
	color: #13ab94;
}
.re {
	text-align: center;
	width: 20px;
	font-size: 14px;
	margin-right: 7px;
	color: red;
}
.bl {
	text-align: center;
	width: 20px;
	font-size: 14px;
	margin-right: 7px;
	color: #4D90FD;
}
.blu {
	text-align: center;
	width: 20px;
	font-size: 14px;
	margin-right: 7px;
	color: white;
	background-color: #4D90FD;
}
.accordion.accordion-semi .panel-head a {
background-color: #FFF !important;
color: #00b1ac!important;
transition: background-color 200ms ease-in-out !important;
border-bottom: 0px solid #FFF !important;
}
</style>
<%@ include file="headInclude.jsp" %>
<script type="text/javascript" src="<scannell:resource value="/js/bootstrap-tooltip.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jquery.blockUI.js" />"></script>
<title></title>
</head>
<body> 

<script type="text/javascript">
jQuery(document).ready(function() {	
	  jQuery(".locBadge").hide();
	  jQuery(".countBadge").show();
	  jQuery('.cat').on('click', function() {
	    var url;
	    url = '<law:url value="/law/checklists.htm?refine=false&viewAll=true&legRegister=" />' + jQuery('#lawTabs').val() + '&checkCategory=' + jQuery(this).attr('cat-id');
	    location.href = url;
	  });
	  jQuery('.withoutCat').on('click', function() {
	    var urlCat;
	    urlCat = '<law:url value="/law/checklists.htm?refine=false&viewAll=true&legRegister=" />' + jQuery('#lawTabs').val();
	    location.href = urlCat;
	  });	  
	  jQuery("#bootSwitch").bootstrapSwitch();
	  jQuery('#bootSwitch').on('switchChange.bootstrapSwitch', function(event, state) {		 
		  if(state== true){
			  jQuery(".locBadge").show();
			  jQuery(".countBadge").hide();
		  }else{
			  jQuery(".locBadge").hide();
			  jQuery(".countBadge").show();
		  }
		});
	});
 </script><c:if test="${loc ge true}">
         <div class="col-sm-12" style="padding-bottom:5%;text-align: center">       
          <input id="bootSwitch" class="switch" data-size="small" type="checkbox">  
         </div>
         </c:if>
									
		 <div class="list-group tickets">
		 <c:set var="total" value="0"/>
		 <li href="#" class="list-group-item withoutCat"><a href="#">All</a> 
		 <c:if test="${loc ge true}">
		  <c:if test="${levelOfComplianceOverAllPercentage ge 80}">
	       <span  class="badge badge-success locBadge" ><c:out value="${levelOfComplianceOverAllPercentage}%"></c:out> </span>
	      </c:if>
	       <c:if test="${levelOfComplianceOverAllPercentage ge 50 and levelOfComplianceOverAllPercentage le 79}">
	       <span  class="badge badge-warning locBadge" ><c:out value="${levelOfComplianceOverAllPercentage}%"></c:out> </span>
	      </c:if>	       
	      <c:if test="${levelOfComplianceOverAllPercentage ge 0 and levelOfComplianceOverAllPercentage le 49}">
	       <span  class="badge badge-danger locBadge" ><c:out value="${levelOfComplianceOverAllPercentage}%"></c:out> </span>
	      </c:if>
	      </c:if>
	      <span  class="badge badge-primary countBadge" ><c:out value="${checkTotal}"></c:out> </span>		 
		 </li> 		      
		  
		 <c:forEach items="${catViewDashList}" var="categoryEntry">		  
	       <li href="#" class="list-group-item cat" cat-id="${categoryEntry.categoryId}">	       
	       <a href="#" >${categoryEntry.categoryName}</a> 
	       <c:if test="${loc ge true}">  
	       <c:if test="${categoryEntry.categoryLevelOfCompliance ge 80}">
	       <span  class="badge badge-success locBadge" ><c:out value="${categoryEntry.categoryLevelOfCompliance}%"></c:out></span>
	       </c:if>
	       <c:if test="${categoryEntry.categoryLevelOfCompliance ge 50 and categoryEntry.categoryLevelOfCompliance le 79}">
	       <span  class="badge badge-warning locBadge" ><c:out value="${categoryEntry.categoryLevelOfCompliance}%"></c:out></span>
	       </c:if>	       
	       <c:if test="${categoryEntry.categoryLevelOfCompliance ge 1 and categoryEntry.categoryLevelOfCompliance le 49}">
	       <span  class="badge badge-danger locBadge" ><c:out value="${categoryEntry.categoryLevelOfCompliance}%"></c:out> </span>
	       </c:if>
	        </c:if>
	        <span  class="badge badge-primary countBadge">${categoryEntry.checkListCount}</span>
	       </li>		   
		 </c:forEach>		
		 </div>
</body>
</html>
