<%@ page language="java" contentType="text/html; charset=UTF-8"     pageEncoding="UTF-8"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<script type="text/javascript" src="<scannell:resource value="/js/highcharts.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/exporting.js" />"></script>
			 
<div class="block">						 
	<div class="header" style="padding-right:0px;">
		<label class="control-label" id="reportTitle"></label>
	</div>								
	<div id="container4"></div>
	<table class="red">
		<thead>
			<tr>
				<th class="halign">Category</th>
				<th class="halign">Last Year</th>
				<th class="halign">Current Year</th>
				<th class="halign">Trend</th>
			</tr>
		</thead>
		<tbody id="display" class="no-border-x"></tbody>
	</table>
</div>


<script type="text/javascript">
	var flashAuditReport_ShowingAllSites = false;

	jQuery(document).ready(function() {
		
		// Tidy up some display issues
		jQuery('#frameMcont').css('min-height', '1000px'); // force vertical scrollbar to appear (needed for highcharts width calculation)
		jQuery('div').removeClass('block-flat');
		
		
		// ---- THIS IS A HACK FOR THE SAMPLE DASHBOARD
		
		document.getElementById('siteLocation').onchange=null; // Purposefully disable the site change toggle
		document.getElementById('siteLocation').onchange=toggleAuditFlashReport;
		
		// ---- END HACK
	
		var complianceList, legList, checkList, profile, lawTabs, levelOfCompletion;
		jQuery('#le-alert').hide();
		jQuery('#chkComp').hide();
		jQuery("#locDiv").hide();
		lawTabs = jQuery('#lawTabs').val();
		jQuery('.close').click(function() {
			jQuery(this).parent().removeClass('in'); // hides alert with Bootstrap CSS3 implem
		});
	
		toggleAuditFlashReport();
	});
	
	function toggleAuditFlashReport() {
		// Toggle the state
		flashAuditReport_ShowingAllSites = !flashAuditReport_ShowingAllSites;
		
		var sampleWarningText = ' <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font>';
		var reportTitle = 'Audit Trend Report';
		
		if(flashAuditReport_ShowingAllSites) {
			jQuery('#reportTitle').html(reportTitle + ' (All Sites)' + sampleWarningText);

			jQuery('#container4').html('');
			jQuery('#display').html('');
			draw(data1);
		} else {

			jQuery('#reportTitle').html(reportTitle + sampleWarningText);

			jQuery('#container4').html(''); 
			jQuery('#display').html('');
			draw(data2);
		}
		
		
		
	}
	
	function draw(json) {
		if (json.locStatus) {
			jQuery('#chkComp').show();
			jQuery("#locDiv").show();
			
			var greenBadge = 'badge-success'; // <span class="badge badge-success locBadge" style="display: block;">87%</span>
			var yellowBadge = 'badge-warning'; // 
			var redBadge = 'badge-danger'; // <span class="badge badge-success locBadge" style="display: block;">87%</span>
			
			var performanceDecreased = '<i class="fa fa-arrow-down"></i>';
			var performanceIncreased = '<i class="fa fa-arrow-up"></i>';
			var performanceIsSteady = '<i class="fa fa-minus"></i>';
			
			
			var trHTML = '';
			jQuery.each(json.locTable, function(k, item) {
				var badgeStyle = redBadge;
				if (item.currentYearPercent > 85) {
					badgeStyle = greenBadge;
				} else if (item.currentYearPercent > 30) {
					badgeStyle = yellowBadge; 
				}
				
				var performanceIndicator = performanceIncreased;
				if (item.currentYearPercent == item.lastYearPercent) {
					performanceIndicator = performanceIsSteady;
				} else if (item.currentYearPercent < item.lastYearPercent) {
					performanceIndicator = performanceDecreased; 
				}
				
				trHTML = '<tr>' +
					'<td text-align="center">' + item.category + '</td>' +
					'<td text-align="center">' + item.lastYearPercent + '%</td>' + 
					'<td text-align="center"><span class="badge ' + badgeStyle + ' locBadge">' + item.currentYearPercent + '%</span></td>' + 
					'<td text-align="center">' + performanceIndicator + '</i></td>' +
					'</tr>' + trHTML;
			});
			jQuery('#display').append(trHTML);
			jQuery('#container4').highcharts({
				chart: {
					type: 'bar'
				},
				title: {
					text: ' '
				},
				subtitle: {
					text: ''
				},
				credits: {
					enabled: false
				},
				xAxis: [{
					categories: json.categoryName,
					reversed: false,
					labels: {
						step: 1
					}
				}, { // mirror axis on right side
					opposite: true,
					reversed: false,
					categories: json.categoryName,
					linkedTo: 0,
					labels: {
						step: 1
					}
				}],
				yAxis: {
					title: {
						text: null
					},
					min: -100,
					max: 100,
					labels: {
						formatter: function() {
							return Math.abs(this.value) + '%';
						}
					}
				},

				plotOptions: {
					series: {
						stacking: 'normal'
					}
				},

				tooltip: {
					formatter: function() {
						return '<b>' + this.series.name + ', ' + this.point.category + '</b><br/>' + '' + Highcharts.numberFormat(Math.abs(this.point.y), 0) + '%';
					}
				},

				series: [{
					name: 'Last Year',
					data: json.lastYear
				}, {
					name: 'Current Year',
					data: json.currentYear

				}]
			});
		} else {
			jQuery('#chkComp').hide();
		}

	};
	
	var data1 = {
		"currentYear": [
			100,
			100,
			52,
			100,
			100,
			0,
			25,
			100,
			33,
			32,
			0,
			100,
			16
		],
		"lastYear": [-100, -100, -40, -33, -75,
			0, -20,
			0, -33, -25,
			0, -100, -16
		],
		"categoryName": [
			"Construction",
			"Emergency Response",
			"Equipment",
			"General",
			"General Safety",
			"Marine",
			"Materials",
			"Planning",
			"Products",
			"Protection of Workers",
			"Transport",
			"Waste",
			"Workplace"
		],
		"locTable": [{
			"lastYearPercent": 100,
			"currentYearPercent": 100,
			"category": "Construction",
			"categoryId": 22,
			"locStatus": false
		}, {
			"lastYearPercent": 100,
			"currentYearPercent": 100,
			"category": "Emergency Response",
			"categoryId": 11,
			"locStatus": false
		}, {
			"lastYearPercent": 40,
			"currentYearPercent": 52,
			"category": "Equipment",
			"categoryId": 12,
			"locStatus": false
		}, {
			"lastYearPercent": 33,
			"currentYearPercent": 100,
			"category": "General",
			"categoryId": 4,
			"locStatus": false
		}, {
			"lastYearPercent": 75,
			"currentYearPercent": 100,
			"category": "General Safety",
			"categoryId": 18,
			"locStatus": false
		}, {
			"lastYearPercent": 0,
			"currentYearPercent": 0,
			"category": "Marine",
			"categoryId": 17,
			"locStatus": false
		}, {
			"lastYearPercent": 20,
			"currentYearPercent": 25,
			"category": "Materials",
			"categoryId": 16,
			"locStatus": false
		}, {
			"lastYearPercent": 0,
			"currentYearPercent": 100,
			"category": "Planning",
			"categoryId": 15,
			"locStatus": false
		}, {
			"lastYearPercent": 33,
			"currentYearPercent": 33,
			"category": "Products",
			"categoryId": 20,
			"locStatus": false
		}, {
			"lastYearPercent": 25,
			"currentYearPercent": 32,
			"category": "Protection of Workers",
			"categoryId": 10,
			"locStatus": false
		}, {
			"lastYearPercent": 0,
			"currentYearPercent": 0,
			"category": "Transport",
			"categoryId": 19,
			"locStatus": false
		}, {
			"lastYearPercent": 100,
			"currentYearPercent": 89,
			"category": "Waste",
			"categoryId": 9,
			"locStatus": false
		}, {
			"lastYearPercent": 16,
			"currentYearPercent": 16,
			"category": "Workplace",
			"categoryId": 13,
			"locStatus": false
		}],
		"locStatus": true
	};
	
	var data2 = {
			"currentYear": [
				10,
				100,
				100,
				52,
				100,
				100,
				16,
				100,
				0,
				32,
				33,
				100,
				25
			],
			"lastYear": [
				-60,  
			    -75,
			    -33, 
			    -40, 
			    -100, 
			    -100, 
				-16,
				-100, 
				-10, 
				-25,
				-33, 
				0, 
				-20 
			],
			"categoryName": [
				"Construction",
				"Emergency Response",
				"Equipment",
				"General",
				"General Safety",
				"Marine",
				"Materials",
				"Planning",
				"Products",
				"Protection of Workers",
				"Transport",
				"Waste",
				"Workplace"
			],
			"locTable": [{
				"lastYearPercent": 60,
				"currentYearPercent": 10,
				"category": "Construction",
				"categoryId": 22,
				"locStatus": false
			}, {
				"lastYearPercent": 75,
				"currentYearPercent": 100,
				"category": "Emergency Response",
				"categoryId": 11,
				"locStatus": false
			}, {
				"lastYearPercent": 33,
				"currentYearPercent": 100,
				"category": "Equipment",
				"categoryId": 12,
				"locStatus": false
			}, {
				"lastYearPercent": 40,
				"currentYearPercent": 52,
				"category": "General",
				"categoryId": 4,
				"locStatus": false
			}, {
				"lastYearPercent": 100,
				"currentYearPercent": 100,
				"category": "General Safety",
				"categoryId": 18,
				"locStatus": false
			}, {
				"lastYearPercent": 100,
				"currentYearPercent": 100,
				"category": "Marine",
				"categoryId": 17,
				"locStatus": false
			}, {
				"lastYearPercent": 16,
				"currentYearPercent": 16,
				"category": "Materials",
				"categoryId": 16,
				"locStatus": false
			}, {
				"lastYearPercent": 100,
				"currentYearPercent": 100,
				"category": "Planning",
				"categoryId": 15,
				"locStatus": false
			}, {
				"lastYearPercent": 10,
				"currentYearPercent": 0,
				"category": "Products",
				"categoryId": 20,
				"locStatus": false
			}, {
				"lastYearPercent": 25,
				"currentYearPercent": 32,
				"category": "Protection of Workers",
				"categoryId": 10,
				"locStatus": false
			}, {
				"lastYearPercent": 33,
				"currentYearPercent": 33,
				"category": "Transport",
				"categoryId": 19,
				"locStatus": false
			}, {
				"lastYearPercent": 0,
				"currentYearPercent": 100,
				"category": "Waste",
				"categoryId": 9,
				"locStatus": false
			}, {
				"lastYearPercent": 20,
				"currentYearPercent": 25,
				"category": "Workplace",
				"categoryId": 13,
				"locStatus": false
			}],
			"locStatus": true
		};
</script>