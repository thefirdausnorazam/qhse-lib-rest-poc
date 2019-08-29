<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

 <script type="text/javascript">
    jQuery(document).ready(function(){
    	 
    	
        jQuery('#ep1').easyPieChart({
          barColor: '#FF0000',
          trackColor: '#EFEFEF',
          lineWidth: 7,
          animate: 600,
          size: 150,
          onStep: function(val){//Update current value while animation
           // $("span", this.$el).html(parseInt(val) + "%");
          }
          });
        jQuery('#ep2').easyPieChart({
            barColor: '#FF0000',
            trackColor: '#EFEFEF',
            lineWidth: 7,
            animate: 600,
            size: 150,
            onStep: function(val){//Update current value while animation
             // $("span", this.$el).html(parseInt(val) + "%");
            }
            });
        jQuery('#ep3').easyPieChart({
            barColor: '#FF0000',
            trackColor: '#EFEFEF',
            lineWidth: 7,
            animate: 600,
            size: 150,
            onStep: function(val){//Update current value while animation
             // $("span", this.$el).html(parseInt(val) + "%");
            }
            });
       jQuery('.epie-chart').easyPieChart({
        lineWidth: 8,
        animate: 600,
        size: 150,
        onStep: function(val){//Update current value while animation
          /* jQuery("#user", this.jQueryel).html(parseInt(33) + "%"); */
        }
        });
        jQuery('div').removeClass('block-flat');
      });
    </script>
<title><fmt:message key="administratorDashboard" /></title>
</head>
<body>

		 <div class="row dash-cols">
				<div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
					  <div class="white-box">
							<div class="fact-data">
								<div class="epie-chart easyPieChart" data-percent="${userPercent}" style="width: 150px; height: 150px; line-height: 150px;"><span id="user">${userPercent}</span><canvas width="150" height="150"></canvas></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3><fmt:message key="enviro.totalActiveUser" /></h3>
								<h2>${countActive}</h2><br>
                                <h3><fmt:message key="enviro.totalUser" /></h3><h2>${usertotal}</h2><br>
								<!-- <p>Total Incident July 2014</p> -->
						</div>
						</div>
					</div>
				</div>	
				<div class="col-sm-5 col-md-7 col-lg-4" >
					<div class="widget-block">
					  <div class="white-box">
							<div class="fact-data">
								<div class="epie-chart easyPieChart" data-percent="${licPercent}" style="width: 150px; height: 150px; line-height: 150px;"><span>${licPercent}</span><canvas width="150" height="150"></canvas></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3><fmt:message key="enviro.licenceExpiry" /></h3>
								<h2>${expDate}</h2><br>
                                <h3><fmt:message key="enviro.licenceCreated" /></h3>
								<h2>${creatDate}</h2><br>
								<%-- <h3>Version Number</h3>
								<h2>${versNo}</h2> --%>
						</div>
						</div>
					</div>
				</div>	
				<div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
						<div class="white-box">
							<div class="fact-data" style="width: 1%; height: 150px; line-height: 150px;">
								
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3><fmt:message key="enviro.versionNumber" /></h3>
								<h2> &nbsp;<fmt:message key="applicationName" />&nbsp;${appVersion}</h2><br>
								<h3> &nbsp;<fmt:message key="clientRelease" /></h3>
                                <h2>&nbsp;${clientRelease}</h2><br>
						  </div>
						</div>
					</div>
				</div>	
			</div>
		 
		<div class="widget-block">
		              <div class="header">
							<h2><fmt:message key="enviro.modules" /></h2>
						</div>
						<div class="white-box">						
						<div class="content">
							<table class="">
								<thead class="no-border">
									<tr>
										<th class="text-center"><fmt:message key="enviro.moduleName" /></th>										
										<th class="text-center"><fmt:message key="general.defaultLandingPage.level1" /></th>
										<th class="text-center"><fmt:message key="general.defaultLandingPage.level2" /></th>
										<th class="text-center"><fmt:message key="general.defaultLandingPage.level3" /></th>
									</tr>
								</thead>
								<tbody class="">								 
								   <c:forEach items="${iterValues}" var="iterValues" > 
								    <c:set var="bk" value="${iterValues.key}" />								  
								    <c:set var="bv" value="${iterValues.value}" />  
								 <tr>							   
								   <c:forEach items="${bv}" var="iter" >								  		
								  	<c:if test="${iter.key eq 'module'}">		
									<td class="text-center"><fmt:message key="${iter.value}" /></td> 								
									</c:if>
									 <c:if test="${iter.key eq 'level1'}">		
									<td class="text-center"><span class="badge badge-info"><c:out value="${iter.value}" /></span></td> 								
									</c:if>									
									<c:if test="${iter.key eq 'level2'}">		
									<td class="text-center"><span class="badge badge-warning"><c:out value="${iter.value}" /></span></td> 								
									</c:if>   
									 <c:if test="${iter.key eq 'level3' }">		
									<td class="text-center"><span class="badge badge-success"><c:out value="${iter.value}" /></span></td> 								
									</c:if>									
									 </c:forEach> 								
								</tr>
								 </c:forEach> 									
								</tbody>
							</table>
						</div>
					</div>
					</div>
</body>
</html>