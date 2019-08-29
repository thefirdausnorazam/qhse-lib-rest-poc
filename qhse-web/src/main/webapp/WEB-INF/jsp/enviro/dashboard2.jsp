<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
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
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.sparkline/jquery.sparkline.min.js" />"></script>
 <script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.pie.js" />"></script> 
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.resize.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.labels.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.gritter/js/jquery.gritter.js" />"></script>

<script type="text/javascript" src="<scannell:resource value="/js/jsj/behaviour/sampleGeneral.js" />"></script>

 <script type="text/javascript">
 jQuery(document).ready(function() {
	
     jQuery('#ep11').easyPieChart({
    	    barColor: '#FF0000',
    	    trackColor: '#EFEFEF',
    	    lineWidth: 7,
    	    animate: 600,
    	    size: 200,
    	    onStep: function(val) {
    	      jQuery('#ep111', this.$el).html(parseInt(val) + '%');
    	    }
    	  });
    	  jQuery('#ep22').easyPieChart({
    	    barColor: '#FF0000',
    	    trackColor: '#EFEFEF',
    	    lineWidth: 7,
    	    animate: 600,
    	    size: 200,
    	    onStep: function(val) {
    	      jQuery('#ep222', this.$el).html(parseInt(val) + '%');
    	    }
    	  });
    	  jQuery('#ep33').easyPieChart({
    	    barColor: '#FF0000',
    	    trackColor: '#EFEFEF',
    	    lineWidth: 7,
    	    animate: 600,
    	    size: 200,
    	    onStep: function(val) {
    	      jQuery('#ep333', this.$el).html(parseInt(val) + '%');
    	    }
    	  });
});
 
 </script>

  
  
 

</head>

<body id="tip">

        
                <div class="stats_bar">
				<div class="butpro butstyle" data-step="2" data-intro="<strong>Beautiful Elements</strong> <br/> If you are looking for a different UI, this is for you!.">
					<div class="sub">
					  <h2>risk</h2>
					  <span id="riskTargetCount">2</span></div>
					<div class="stat"><span class="up" > Targets</span></div>
				</div>
				<div class="butpro butstyle">
					<div class="sub">
					  <h2>law</h2>
					  <span id="lawCompliance">64</span></div>
					<div class="stat"><span class="up"> Compliance Task</span></div>
				</div>
				<div class="butpro butstyle">
					<div class="sub">
					  <h2>change</h2><span id="planYear">12</span></div>
					<div class="stat"><span class="down" id="planYearYear"> Change Plan 2015</span></div>
				</div>	
				<div class="butpro butstyle">
					<div class="sub">
					  <h2 >audit</h2>
					  <span id="auditYear">36</span></div>
					<div class="stat"><span class="equal" id="auditYearYear">Audit Plan 2015</span></div>
				</div>	
				<div class="butpro butstyle">
					<div class="sub">
					  <h2>Data</h2>
					  <span id="externalBreaches">18</span></div>
					<div class="stat"><span class="down">External Breaches</span></div>
				</div>
				<div class="butpro butstyle">
					<div class="sub">
					  <h2 >incidents</h2>
					  <span id="criticCount">0</span></div>
					<div class="stat"><span class="equal"> Critical</span></div>
				</div>	

		  </div>
  
          <div class="row dash-cols">
			
				<div class="col-sm-6 col-md-6">
					<div class="block">
						<div class="header">
							<h2>Total Man Hours Lost <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font></h2>
						</div>
						<div class="content blue-chart"  data-step="3" data-intro="<strong>Unique Styled Plugins</strong> <br/> We put love in every detail to give a great user experience!.">
							<div id="site_stat" style="height:180px;"></div>
						</div>
						<div class="content">
							<div class="stat-data">
								<div class="stat-blue">
									<h2 id="totalHours">1024</h2>
									<span id="displayManHours">Total Man Hours Lost 2015</span>
								</div>
							</div>
							<div class="stat-data">
								<div class="stat-number">
									<div>
									  <h2 id="totalIncidents">85</h2></div>
									<div>Total Incidents<br />
									  <span id="year">(2015)</span></div>
								</div>
								<div class="stat-number">
									<div>
									  <h2>2</h2></div>
									<div>Average<br />
									  <span>(Daily)</span></div>
								</div>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>	
				<div class="col-sm-6 col-md-6">
				<div class="block">
						  <div class="header">							
							<h2>Incident Potential Severity P1 <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font></h2>
						</div> 
						<div class="content full-width">
							 <div id="chart3-legends"  class="legend-container"></div>
							<div id="chart3s" style="height:220px;"></div>	
                             <h5>&nbsp;&nbsp;&nbsp;Jan&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Feb&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;March&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;April&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;May&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;June&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;July</h5>						
						</div>
					</div>

			</div>
            </div>
			 <div class="row">
				<div class="col-sm-6 col-md-6">
					
				
					<div class="block-wizard">
						<div class="header">
							<h3>Safety Audit by People Hazards <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font></h3>
                            <h5>01/01/2014 to 31/06/2014</h5>
						</div>
						<div class="content overflow-hidden">
							<div id="piecha" style="height: 315px; padding: 0px; position: relative;">
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-sm-6 col-md-6">
                   <div class="block">
						<div class="header no-border">
							<h2>Total Business Risk Profile <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font></h2>
						</div>
                        <div class="content">
						<h4>Business Continuity</h4>
							<div class="progress progress-striped">
							  <div class="progress-bar progress-bar-success" style="width: 40%">40%</div>
							  <div class="progress-bar progress-bar-info" style="width: 10%">10%</div>
							  <div class="progress-bar progress-bar-warning" style="width: 25%">25%</div>
							</div>
                            <h4>Environmental Aspects</h4>
							<div class="progress progress-striped">
							  <div class="progress-bar progress-bar-success" style="width: 20%">20%</div>
							  <div class="progress-bar progress-bar-info" style="width: 50%">50%</div>
							  <div class="progress-bar progress-bar-danger" style="width: 10%">10%</div>
							</div>
                            <h4>Area Safety</h4>
							<div class="progress progress-striped">
							  <div class="progress-bar progress-bar-success" style="width: 18%">18%</div>
							  <div class="progress-bar progress-bar-info" style="width: 22%">22%</div>
							  <div class="progress-bar progress-bar-warning" style="width: 34%">34%</div>
							</div>
                            <h4>Job Safety</h4>
							<div class="progress progress-striped">
							  <div class="progress-bar progress-bar-success" style="width: 45%">45%</div>
							  <div class="progress-bar progress-bar-info" style="width: 15%">15%</div>
							  <div class="progress-bar progress-bar-warning" style="width: 8%">8 d%</div>
							</div>
                              <h4>Energy Aspects</h4>
							<div class="progress progress-striped">
							  <div class="progress-bar progress-bar-success" style="width: 65%">65%</div>
							  <div class="progress-bar progress-bar-warning" style="width: 10%">10%</div>
							  <div class="progress-bar progress-bar-danger" style="width: 10%">10%</div>
							</div>
                            </div>
					</div>
					
				</div>
                
			</div>
			
			    <!-- <div class="row dash-cols">
				<div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
					  <div class="white-box">
							<div class="fact-data">
								<div id="ep1" class="epie-chart" data-percent="86"><span>0%</span></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3>safety comments</h3>
								<h2>18</h2>
                                <h3>of Target 20</h3>
								<p>Total Incident July 2014</p>
						</div>
						</div>
					</div>
				</div>	
				<div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
					  <div class="white-box">
							<div class="fact-data">
								<div id="ep2" class="epie-chart" data-percent="29"><span>0%</span></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3>safety audits</h3>
								<h2>10</h2>
                                <h3>of Target 30</h3>
								<p>Total Accident July 2014</p>
						</div>
						</div>
					</div>
				</div>	
				<div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
						<div class="white-box">
							<div class="fact-data">
								<div id="ep3" class="epie-chart" data-percent="32"><span>0%</span></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3>Complaint</h3>
								<h2>3 </h2>
                                <h3>of Target 10</h3>
								<p>Total Complaints July 2014</p>
						  </div>
						</div>
					</div>
				</div>	
			</div> -->
			<div class="row dash-cols">
				<div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
					  <div class="white-box">
							<div class="fact-data">
								<div id="ep11" class="epie-chart" data-percent="86"><span id="ep111">0%</span></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3>safety comments <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font></h3>
								<h2>18</h2>
                                <h3>of Target 20</h3>
								<p>Total Incident July 2014</p>
						</div>
						</div>
					</div>
				</div>	
				<div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
					  <div class="white-box">
							<div class="fact-data">
								<div id="ep22" class="epie-chart" data-percent="29"><span id="ep222">0%</span></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3>safety audits <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font></h3>
								<h2>10</h2>
                                <h3>of Target 30</h3>
								<p>Total Accident July 2014</p>
						</div>
						</div>
					</div>
				</div>	
				<div class="col-sm-6 col-md-6 col-lg-4">
					<div class="widget-block">
						<div class="white-box">
							<div class="fact-data">
								<div id="ep33" class="epie-chart" data-percent="32"><span id="ep333">0%</span></div>
							</div>
							<div class="fact-data no-padding text-shadow">
								<h3>Complaint <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font></h3>
								<h2>3 </h2>
                                <h3>of Target 10</h3>
								<p>Total Complaints July 2014</p>
						  </div>
						</div>
					</div>
				</div>	
			</div>

</body>
</html>