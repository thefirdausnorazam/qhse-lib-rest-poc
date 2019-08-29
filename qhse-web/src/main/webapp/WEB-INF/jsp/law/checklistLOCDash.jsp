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
  <link rel="stylesheet" type="text/css" href="<scannell:resource value="/js/jsj/jquery.easypiechart/jquery.easy-pie-chart.css" />" /> 
<%-- <%@ include file="headInclude.jsp" %> --%>
<script type="text/javascript" src="<scannell:resource value="/js/bootstrap-tooltip.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jquery.blockUI.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.easypiechart/jquery.easy-pie-chart.js" />"></script>
<title></title>

</head>
<body> 
<script type="text/javascript">
jQuery(document).ready(function() {
	 jQuery('.epie-chart').easyPieChart({
	        lineWidth: 8,
	        animate: 600,
	        size: 100,
	        onStep: function(val){//Update current value while animation
	          $("span", this.$el).html(parseInt(val) + "%");
	        }
	        });
	 
	 /*jQuery('.cat').on('click', function() {
		    var url;
		    url = '<law:url value="/law/checklists.htm?refine=false&viewAll=true&legRegister=" />' + jQuery('#lawTabs').val() + '&checkCategory=' + jQuery(this).attr('cat-id');
		    location.href = url;
		  });
	  jQuery('.withoutCat').on('click', function() {
		    var urlCat;
		    urlCat = '<law:url value="/law/checklists.htm?refine=false&viewAll=true&legRegister=" />' + jQuery('#lawTabs').val();
		    location.href = urlCat;
		  }); */
	  
	  /* var locst=<c:out value="${loc}"></c:out>;
	  if(locst){
		  jQuery("#locDiv").show();
	  }else{
		  jQuery("#locDiv").hide();
	  } */
	});
	
	function test(categoryId) {
	    var url;
	    url = '<law:url value="/law/checklists.htm?refine=false&viewAll=true&legRegister=" />' + jQuery('#lawTabs').val() + '&checkCategory=' + categoryId;
	    location.href = url;
  	};
	

 </script>
 
 <c:if test="${loc eq true}">
	<div class="row">	
	<div class="content" style="height: 517px; text-align:center;">
	<c:forEach items="${catViewDashList}" var="categoryEntry">
	
	<c:if test="${categoryEntry.categoryLevelOfCompliance ge 80}">
	<a href='#' onclick="test(${categoryEntry.categoryId})">
    <div style="float:left; width: 50%;"><h4>${categoryEntry.categoryName}</h4>
    <div class="epie-chart easyPieChart" style="cursor: pointer;" data-barcolor="#60C060" data-trackcolor="#F3F3F3" data-percent="<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>" style="width: 100px; height: 100px; line-height: 100px;"><span><c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%</span><canvas width="110" height="110"></canvas><canvas width="103" height="103"></canvas><canvas width="100" height="100"></canvas></div></div>                        
    </a>
    </c:if>     
     <c:if test="${categoryEntry.categoryLevelOfCompliance ge 50 and categoryEntry.categoryLevelOfCompliance le 79}">
     <a href='#' onclick="test(${categoryEntry.categoryId})">
     <div style="float:left; width: 50%;"><h4>${categoryEntry.categoryName}</h4>
     <div class="epie-chart easyPieChart" style="cursor: pointer;" data-barcolor="#FC9700" data-trackcolor="#F3F3F3" data-percent="<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>" style="width: 100px; height: 100px; line-height: 100px;"><span><c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%</span><canvas width="110" height="110"></canvas><canvas width="103" height="103"></canvas><canvas width="100" height="100"></canvas></div></div>                        
     </a>
     </c:if>  
     <c:if test="${categoryEntry.categoryLevelOfCompliance ge 1 and categoryEntry.categoryLevelOfCompliance le 49}">
     <a href='#' onclick="test(${categoryEntry.categoryId})">
     <div style="float:left; width: 50%;"><h4>${categoryEntry.categoryName}</h4>
     <div class="epie-chart easyPieChart" style="cursor: pointer;" data-barcolor="#DA4932" data-trackcolor="#F3F3F3" data-percent="<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>" style="width: 100px; height: 100px; line-height: 100px;"><span><c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%</span><canvas width="110" height="110"></canvas><canvas width="103" height="103"></canvas><canvas width="100" height="100"></canvas></div></div>                        
     </a>
     </c:if>  
      <c:if test="${categoryEntry.categoryLevelOfCompliance eq 0}">
      <a href='#' onclick="test(${categoryEntry.categoryId})">
      <div style="float:left; width: 50%;"><h4>${categoryEntry.categoryName}</h4>
      <div class="epie-chart easyPieChart" style="cursor: pointer;" data-barcolor="#DA4932" data-trackcolor="#F3F3F3" data-percent="<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>" style="width: 100px; height: 100px; line-height: 100px;"><span><c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%</span><canvas width="110" height="110"></canvas><canvas width="103" height="103"></canvas><canvas width="100" height="100"></canvas></div></div>                        
      </a>
      </c:if>
               
    </c:forEach>
    </div>
	</div> 
</c:if>			
		<!-- <div class="content"> -->
						<!--For Loop First -->
		
	<%-- 	<c:forEach items="${catViewDashList}" var="categoryEntry">
		<h5>
															<strong>${categoryEntry.categoryName} </strong>
														</h5>														
		<c:if test="${categoryEntry.categoryLevelOfCompliance ge 80}">
        <div class="progress">
        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>"
         aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%"><c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%   
        </div>
        </div>
        </c:if>
        <c:if test="${categoryEntry.categoryLevelOfCompliance ge 50 and categoryEntry.categoryLevelOfCompliance le 79}">
	    <div class="progress">
        <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>"
         aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%"><c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%   
        </div>
        </div>
        </c:if>
                                                       <c:if test="${categoryEntry.categoryLevelOfCompliance ge 1 and categoryEntry.categoryLevelOfCompliance le 49}">
														<div class="progress">
                                                       <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>"
                                                       aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%"><c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%   
                                                       </div>
                                                       </div>
                                                       </c:if>
                                                       <c:if test="${categoryEntry.categoryLevelOfCompliance eq 0}">
													   <div class="progress">
                                                       <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>"
                                                       aria-valuemin="0" aria-valuemax="100" style="width:<c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%"><c:out value="${categoryEntry.categoryLevelOfCompliance}"/>%   
                                                       </div>
                                                       </div>
                                                       </c:if>
          </c:forEach> --%>
		 <%-- <div class="list-group tickets">
		 <c:set var="total" value="0"/>
		 <li href="#" class="list-group-item withoutCat"><a href="#">All</a> 
		  <c:if test="${levelOfComplianceOverAllPercentage ge 80}">
	       <span class="badge badge-warning" ><c:out value="${levelOfComplianceOverAllPercentage}%"></c:out> </span>
	      </c:if>
	       <c:if test="${levelOfComplianceOverAllPercentage ge 50 and levelOfComplianceOverAllPercentage le 79}">
	       <span class="badge badge-success" ><c:out value="${levelOfComplianceOverAllPercentage}%"></c:out> </span>
	      </c:if>	       
	      <c:if test="${levelOfComplianceOverAllPercentage ge 1 and levelOfComplianceOverAllPercentage le 49}">
	       <span class="badge badge-danger" ><c:out value="${levelOfComplianceOverAllPercentage}%"></c:out> </span>
	      </c:if>
	      <span class="badge badge-warning" ><c:out value="${checkTotal}"></c:out> </span>		 
		 </li> 		         
		 <c:forEach items="${catViewDashList}" var="categoryEntry">		  
	       <li href="#" class="list-group-item cat" cat-id="${categoryEntry.categoryId}">	       
	       <a href="#" >${categoryEntry.categoryName}</a> 
	       <c:if test="${categoryEntry.categoryLevelOfCompliance ge 80}">
	       <span class="badge badge-warning" ><c:out value="${categoryEntry.categoryLevelOfCompliance}%"></c:out></span>
	       </c:if>
	       <c:if test="${categoryEntry.categoryLevelOfCompliance ge 50 and categoryEntry.categoryLevelOfCompliance le 79}">
	       <span class="badge badge-success" ><c:out value="${categoryEntry.categoryLevelOfCompliance}%"></c:out></span>
	       </c:if>	       
	       <c:if test="${categoryEntry.categoryLevelOfCompliance ge 1 and categoryEntry.categoryLevelOfCompliance le 49}">
	       <span class="badge badge-danger" ><c:out value="${categoryEntry.categoryLevelOfCompliance}%"></c:out> </span>
	       </c:if>
	        <span class="badge badge-primary">${categoryEntry.checkListCount}</span>
	       </li>		   
		 </c:forEach>
		 </div> --%>
		<!-- </div> -->
</body>
</html>
