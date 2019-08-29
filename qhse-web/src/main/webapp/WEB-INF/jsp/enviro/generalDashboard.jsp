<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<!DOCTYPE">
<html>
<head>
  <meta http-equiv="expires" content="0">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="copyright" content="&copy; Scannell Solutions">
  <meta http-equiv="robots" content="noindex, nofollow, noarchive">

 <!--  <title>enviroMANAGER Dashboard</title> -->

<%-- <script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.pie.js" />"></script> 
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.resize.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.labels.js" />"></script> --%>
<script type="text/javascript">
jQuery(document).ready(function() {	
	var data = [];
	<c:forEach items="${currentSitesSelected}" var="sa">
		data.push('${sa.id}');
	</c:forEach>
	
	jQuery('#siteLoc').select2('val', data);
	jQuery('#siteLoc').val(data);
});
</script>
<script type="text/javascript" src="<scannell:resource value="/js/highcharts.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/exporting.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/generalDashBoardJS.js" />"></script>
<script type="text/javascript">
jQuery(document).ready(function() {	
	setTimeout(replaceSpecialCharacter, 1000);
	setTimeout(replaceSpecialCharacter, 2000);
	var rtime = new Date(1, 1, 2000, 12, 0, 0);
	var timeout = false;
	var delta = 200;
	jQuery(window).resize(function() {
	    rtime = new Date();
	    if (timeout === false) {
	        timeout = true;
	        setTimeout(resizeend, delta);
	    }
	});

	function resizeend() {
	    if (new Date() - rtime < delta) {
	        setTimeout(resizeend, delta);
	    } else {
	        timeout = false;
	        replaceSpecialCharacter();
	    }               
	}
	
});
function replaceSpecialCharacter() {
	jQuery( "tspan" ).each(function( index ) {
			var myText1 = jQuery(this).text();
			var myText = myText1.replace("â€¦", "...");
			jQuery(this).text(myText);
		});
}

</script>
</head>

<body id="tip">        
                <div class="stats_bar" style="text-align:center">
                <c:forEach items="${licences}" var="item"> 
                <c:choose>
                <c:when test="${item=='risk'}">
				<div class="butpro butstyle" data-step="2" >
					<div class="sub">
					  <h2>risk</h2>
					  <span id="riskTargetCount"></span></div>
					<div class="stat"><span id="icoTarget"  > RA Tasks Overdue</span></div>
				</div>
				</c:when>
				 <c:when test="${item=='law'}">
				<div class="butpro butstyle">
					<div class="sub">
					  <h2>law</h2>
					  <span id="lawCompliance"></span></div>
					<div class="stat"><span id="icoLaw"> <fmt:message key="tasksOverdue"/>	</span></div>
				</div>
				</c:when>
				<%-- <c:when test="${item=='change'}">
				<div class="butpro butstyle">
					<div class="sub">
					  <h2>change</h2><span id="planYear"></span></div>
					<div class="stat"><span class="equal" id="planYearYear"> </span></div>
				</div>	
				</c:when> --%>
				<c:when test="${item=='audit'}">
				<div class="butpro butstyle linkToAuditPlanPage">
					<div class="sub">
					  <h2 >audit</h2>
					  <span id="auditYear"></span></div>
					<div class="stat"><span class="equal" id="auditYearYear"> Overdue</span></div>
				</div>	
				</c:when>
				<c:when test="${item=='data'}">
				<div class="butpro butstyle">
					<div class="sub">
					  <h2>Data</h2>
					  <span id="externalBreaches"></span></div>
					<div class="stat"><span id="icoData">External Breaches ytd</span></div>
				</div>
				</c:when>
				<c:when test="${item=='incident'}">
					<div class="butpro butstyle" style="display:none">
						<div class="sub">
						  <h2 >incidents</h2>
						  <span id="criticCount"></span></div>
						<div class="stat"><span id="icoInci" class="equal"> Investigations Overdue</span></div>
					</div>	
					<div class="butpro butstyle">
						<div class="sub">
						  <h2 >incidents</h2>
						  <span id="typeCount"></span></div>
						<div class="stat"><span id="ltiInci" class="equal"> LTI ytd</span></div>
					</div>
				</c:when>
                </c:choose>
                </c:forEach>
		  </div>
  
          <!-- <div class="row dash-cols">			
				<div class="col-sm-6 col-md-6">
					<div class="block">
					<div id="container" style="min-width: 310px; max-width: 800px; height: 400px; margin: 0 auto"></div>						
					</div>
				</div>	
				<div class="col-sm-6 col-md-6">
				<div class="block">	
				<div id="container1" style="min-width: 310px; max-width: 800px; height: 400px; margin: 0 auto"></div>		
				</div>
			   </div>			
            </div> -->
            
       
		<fmt:message key='generaldashboard.incidentgraphP1' var="showGraphP1"/>	
		<c:set var="showP1" value="true"></c:set>
		<c:if test="${showGraphP1 == 'false'}">
		<c:set var="showP1" value="false"> </c:set>
		</c:if>
			<!--  <div class="row"> -->
			  <c:forEach items="${licences}" var="item"> 
                <c:choose>
                <c:when test="${item=='risk'}">
                				<div class="col-sm-6 col-md-6 riskTasks">	
									<div class="block-wizard">
										<div id="container2" style="min-width: 310px; max-width: 800px; height: 400px; margin: 0 auto"></div>	
									</div>
								</div>
                </c:when>
                <c:when test="${item=='audit'}">
                	<div class="col-sm-6 col-md-6 auditByMonth">
                   		<div class="block">
							<div id="container3" style="min-width: 310px; max-width: 800px; height: 400px; margin: 0 auto"></div>
						</div>
					</div>
                </c:when>
                <c:when test="${item=='incident'}">
                			<div class="col-sm-6 col-md-6 inciPotentialSeverity1" style="display: ${showP1 ? 'block': 'none'};">				
								<div class="block-wizard">
									<div id="container4" style="min-width: 310px; max-width: 800px; height: 400px; margin: 0 auto"></div>	
								</div>
							</div>
							<div class="col-sm-6 col-md-6 inciActualSeverity">				
								<div class="block-wizard">
									<div id="container5" style="min-width: 310px; max-width: 800px; height: 400px; margin: 0 auto"></div>	
								</div>
							</div>   
				</c:when>
                </c:choose>
                </c:forEach>

				                
		<!-- 	</div> -->
			
		<!-- 	<div class="row"> -->
            
		<!-- 	</div> -->
			    <div class="row dash-cols">
				<!-- <div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
					  <div class="white-box">
							<div class="fact-data">
								<div id="ep11" class="epie-chart" data-percent="86"><span id="ep111">0%</span></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3>safety comments</h3>
								<h2>18</h2>
                                <h3>of Target 20</h3>
								<p>Total Incident July 2014</p>
						</div>
						</div>
					</div>
				</div>	 -->
			<!-- 	<div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
					  <div class="white-box">
							<div class="fact-data">
								<div id="ep22" class="epie-chart" data-percent="29"><span id="ep222">0%</span></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3>safety audits</h3>
								<h2>10</h2>
                                <h3>of Target 30</h3>
								<p>Total Accident July 2014</p>
						</div>
						</div>
					</div>
				</div> -->	
			<!-- 	<div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
						<div class="white-box">
							<div class="fact-data">
								<div id="ep33" class="epie-chart" data-percent="32"><span id="ep333">0%</span></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3>Complaint</h3>
								<h2>3 </h2>
                                <h3>of Target 10</h3>
								<p>Total Complaints July 2014</p>
						  </div>
						</div>
					</div>
				</div> -->	
			</div>
		

</body>
</html>