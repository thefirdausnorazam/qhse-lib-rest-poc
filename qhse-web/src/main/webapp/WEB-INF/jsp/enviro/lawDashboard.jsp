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
  <style type="text/css">
  
  #container {
    height: 500px; 
    width: 900px; 
    margin: 0 auto; 
}

.highcharts-tooltip>span {
    padding: 10px;
    white-space: normal !important;
    width: 200px;
}

.loading {
    margin-top: 10em;
    text-align: center;
    color: gray;
}

.f32 .flag {
    vertical-align: middle !important;
}
  </style>

 <!--  <title>enviroMANAGER Dashboard</title> -->
<%-- <script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.sparkline/jquery.sparkline.min.js" />"></script>
 <script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.pie.js" />"></script> 
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.resize.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.flot/jquery.flot.labels.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.gritter/js/jquery.gritter.js" />"></script>--%>


<script src="https://code.highcharts.com/maps/highmaps.js"></script>
<script src="https://code.highcharts.com/maps/modules/data.js"></script>
<script src="https://code.highcharts.com/maps/modules/exporting.js"></script>
<script src="https://code.highcharts.com/mapdata/custom/world.js"></script>

<!-- Flag sprites service provided by Martijn Lafeber, https://github.com/lafeber/world-flags-sprite/blob/master/LICENSE -->
<link rel="stylesheet" type="text/css" href="http://cloud.github.com/downloads/lafeber/world-flags-sprite/flags32.css" />

 <script type="text/javascript">
 jQuery(document).ready(function() {
	 jQuery('div').removeClass('block-flat');	
	 
	 
	jQuery.getJSON('https://www.highcharts.com/samples/data/jsonp.php?filename=world-population-density.json&callback=?', function (data) {

	        // Add lower case codes to the data set for inclusion in the tooltip.pointFormat
	       jQuery.each(data, function () {
	            this.flag = this.code.replace('UK', 'GB').toLowerCase();
	        });

	        // Initiate the chart
	       jQuery('#container').highcharts('Map', {

	            title: {
	                text: ''
	            },

	            legend: {
	                title: {
	                    text: 'Level of Compliance',
	                    style: {
	                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
	                    }
	                }
	            },

	            mapNavigation: {
	                enabled: true,
	                buttonOptions: {
	                    verticalAlign: 'bottom'
	                }
	            },

	            tooltip: {
	                backgroundColor: 'none',
	                borderWidth: 0,
	                shadow: false,
	                useHTML: true,
	                padding: 0,
	                pointFormat: '<span class="f32"><span class="flag {point.flag}"></span></span>' +
	                    ' {point.name}: <b>{point.value}</b>%',
	                positioner: function () {
	                    return { x: 0, y: 250 };
	                }
	            },

	            colorAxis: {
	                min: 1,
	                max: 1000,
	                type: 'logarithmic'
	            },

	            series : [{
	                data : data,
	                mapData: Highcharts.maps['custom/world'],
	                joinBy: ['iso-a2', 'code'],
	                name: 'Level of Compliance',
	                states: {
	                    hover: {
	                        color: '#BADA55'
	                    }
	                }
	            }]
	        });
	    });
	});

	 
	 
	 
	 
	
    /*  jQuery('#ep11').easyPieChart({
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
    	  }); */
/* }); */
 
 </script>

  
  
 

</head>

<body id="tip">

        
                <div class="stats_bar">
				<%-- <div class="butpro butstyle" data-step="2" data-intro="<strong>Beautiful Elements</strong> <br/> If you are looking for a different UI, this is for you!.">
					<div class="sub">
					  <h2>risk</h2>
					  <span id="riskTargetCount">2</span></div>
					<div class="stat"><span class="up" > Targets</span></div>
				</div> --%>
				<div class="butpro butstyle">
					<div class="sub">
					  <h2>law</h2>
					  <span id="lawCompliance">64</span></div>
					<div class="stat"><span class="up"> Law Task</span></div>
				</div>
				<!-- <div class="butpro butstyle">
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
				</div>	 -->

		  </div>
  
          <div class="row dash-cols" style="padding-top:2%">
			
				<div class="col-sm-12 col-md-12">
					<div class="block">
						<div class="header">
							<h2 style="font-size: 200%!important">Compliance Across International Locations <font style="text-shadow: orange;font-size: 150%; font-weight: bold;color: red">(SAMPLE)</font></h2>
						</div>
						
						 <div class="container" id="container">
					
							<!-- <div class="clear"></div> -->
						</div> 
					</div>
				</div>	
				<!-- <div class="col-sm-6 col-md-6">
				<div class="block">
						  <div class="header">							
							<h2>Incident Potential Severity P1</h2>
						</div> 
						<div class="content full-width">
							 <div id="chart3-legends"  class="legend-container"></div>
							<div id="chart3s" style="height:220px;"></div>	
                             <h5>&nbsp;&nbsp;&nbsp;Jan&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Feb&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;March&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;April&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;May&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;June&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;July</h5>						
						</div>
					</div>

			</div> -->
            </div>
			 <!-- <div class="row">
				<div class="col-sm-6 col-md-6">
					
				
					<div class="block-wizard">
						<div class="header">
							<h3>Safety Audit by People Hazards</h3>
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
							<h2>Total Business Risk Profile</h2>
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
                
			</div> -->
			
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
	<!-- 		<div class="row dash-cols">
				<div class="col-sm-6 col-md-6 col-lg-4">
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
				</div>	
				<div class="col-sm-6 col-md-6 col-lg-4">
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
				</div>	
				<div class="col-sm-6 col-md-6 col-lg-4">
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
				</div>	
			</div> -->

</body>
</html>