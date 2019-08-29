jQuery(document).ready(function() {
  var auditGraph, auditsByMonth, blockData, data, inciActualSeverity, inciPotentialSeverity, inciPotentialSeverity1, actionTasks, riskTasks, previousPoint, riskAssessmentGraph, showTooltip, toggleSideBar;
  blockData = void 0;
  auditsByMonth = void 0;
  data = void 0;
  previousPoint = void 0;
  showTooltip = void 0;
  toggleSideBar = void 0;
  inciActualSeverity = void 0;
  actionTasks = void 0;
  riskTasks = void 0;
  inciPotentialSeverity = void 0;
  inciPotentialSeverity1 = void 0;
  riskAssessmentGraph = void 0;
  auditGraph = void 0;
  blockData = void 0;
  inciActualSeverity = void 0;
  inciPotentialSeverity = void 0;
  inciPotentialSeverity1 = void 0;
  actionTasks = void 0;
  riskAssessmentGraph = void 0;
  auditGraph = void 0;
  data = void 0;
  previousPoint = void 0;
  showTooltip = void 0;
  toggleSideBar = void 0;
  blockData = void 0;
  data = void 0;
  previousPoint = void 0;
  showTooltip = void 0;
  toggleSideBar = void 0;
  previousPoint = null;
  toggleSideBar = function(_this) {
    var b, s, w;    
    b = jQuery('#sidebar-collapse')[0];
    w = jQuery('#cl-wrapper');
    s = jQuery('.cl-sidebar');
    if (w.hasClass('sb-collapsed')) {
      jQuery('.fa', b).addClass('fa-angle-left').removeClass('fa-angle-right');
      w.removeClass('sb-collapsed');
    } else {
      jQuery('.fa', b).removeClass('fa-angle-left').addClass('fa-angle-right');
      w.addClass('sb-collapsed');
    }
  };
  showTooltip = function(x, y, contents) {
    jQuery('<div id=\'tooltip\'>' + contents + '</div>').css({
      position: 'absolute',
      display: 'none',
      top: y + 5,
      left: x + 5,
      border: '1px solid #000',
      padding: '5px',
      'color': '#fff',
      'border-radius': '2px',
      'font-size': '11px',
      'background-color': '#000',
      opacity: 0.80
    }).appendTo('body').fadeIn(200);
  };
  blockData = function() {
    var businessAreaId, site, url, years;    
    years = jQuery('#dashYear').val();
    site = jQuery('#siteLoc').val();
    businessAreaId = jQuery('#businessAreaId').val();
    url = contextPath + '/enviro/blockDashBoardData.json?' + 'years=' + years + '&sites=' + site + '&businessAreaId=' + businessAreaId;
    jQuery.getJSON(url, function(json) {
      jQuery('#criticCount').text(json.incidentCriticalCount);
      jQuery('#typeCount').text(json.typeCount);
      jQuery('#externalBreaches').text(json.dataBreachesCount);
      jQuery('#lawCompliance').text(json.lawCompliance);
      jQuery('#auditYear').text(json.auditYear);
      //jQuery('#planYear').text(json.planYear + '%');
      jQuery('#auditYearYear:last').text('Audits Overdue ');
      jQuery('#planYearYear:last').text('Change Plan '+years);
      jQuery('#riskTargetCount').text(json.riskTargetCount);
      if (json.riskTargetCount <= 0) {
        jQuery('#icoTarget').removeClass().addClass('equal');
      } else {
        jQuery('#icoTarget').removeClass().addClass('neg');
      }
      if (json.lawCompliance <= 0) {
        jQuery('#icoLaw').removeClass().addClass('equal');
      } else {
        jQuery('#icoLaw').removeClass().addClass('neg');
      }
      if (json.dataBreachesCount <= 0) {
        jQuery('#icoData').removeClass().addClass('equal');
      } else {
        jQuery('#icoData').removeClass().addClass('neg');
      }
      if (json.incidentCriticalCount <= 0) {
        jQuery('#icoInci').removeClass().addClass('equal');
      } else {
        jQuery('#icoInci').removeClass().addClass('neg');
      }
      if (json.incidentLTICount <= 0) {
          jQuery('#ltiInci').removeClass().addClass('equal');
        } else {
          jQuery('#ltiInci').removeClass().addClass('neg');
        }
    });
  };
  inciActualSeverity = function() {
    var businessAreaId, site, url, years;
    years = jQuery('#dashYear').val();
    site = jQuery('#siteLoc').val();
    businessAreaId = jQuery('#businessAreaId').val();
    url = contextPath + '/enviro/dashIncidentActualSeverity.json?' + 'years=' + years + '&site=' + site + '&businessAreaId=' + businessAreaId;
    jQuery.getJSON(url, function(json) {
      jQuery('#container5').highcharts({
        chart: {
          type: 'bar'
        },
        credits: {
            enabled: false
        },
        title: {
          text: 'Incident Actual Severity'
        },
        xAxis: {
          title: {
            text: 'Sites'
          },
          categories: json.dataSite
        },
        yAxis: {
          allowDecimals: false,
          min: 0
        },
        legend: {
          reversed: true
        },
        plotOptions: {
          series: {
            stacking: 'normal'
          }
        },
        series: [
          {
            name: 'Overdue',
            data: json.dataOverdue,
            color: '#D84830'
          }, {
            name: 'Closed',
            data: json.dataClosed,
            color: '#78A830'
          }
        ]
      });
    });
  };
  /*inciPotentialSeverity = function() {
    var businessAreaId, site, url, years;
    years = jQuery('#dashYear').val();
    site = jQuery('#siteLoc').val();
    businessAreaId = jQuery('#businessAreaId').val();
    url = contextPath + '/enviro/incidentPotentialSeverity.json?' + 'years=' + years + '&site=' + site + '&businessAreaId=' + businessAreaId;
    jQuery.getJSON(url, function(json) {
      jQuery('#container5').highcharts({
        chart: {
          type: 'bar'
        },
        credits: {
            enabled: false
        },
        title: {
          text: 'Incident Potential Severity'
        },
        xAxis: {
          title: {
            text: 'Sites'
          },
          categories: json.dataSite
        },
        yAxis: {
          allowDecimals: false,
          min: 0
        },
        legend: {
          reversed: true
        },
        plotOptions: {
          series: {
            stacking: 'normal'
          }
        },
        series: [
          {
            name: 'Overdue',
            data: json.dataOverdue,
            color: '#D84830'
          }, {
            name: 'Closed',
            data: json.dataClosed,
            color: '#78A830'
          }
        ]
      });
    });
  };*/
  actionTasks = function() {
	  var businessAreaId, site, url, years;
	    years = jQuery('#dashYear').val();
	    site = jQuery('#siteLoc').val();
	    if(site == null) {
	    	years = '2100';//this is for avoid bring results if there is no site selected 
	    }
	    businessAreaId = jQuery('#businessAreaId').val();
	    url = contextPath + '/enviro/dashActionsTasks.json?' + 'years=' + years + '&sites=' + site + '&businessAreaId=' + businessAreaId;
	    jQuery.getJSON(url, function(json) {
	    	jQuery('#container5').highcharts({
                chart: {
                    type: 'area'
                },
                credits: {
                    enabled: false
                },
                title: {
                    text: 'Total Actions & Tasks'
                },
                subtitle: {
                    text: ''
                },
                 xAxis: {
                    categories: [
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dec'
                    ],
                   
                },
                yAxis: {
                    title: {
                        text: ''
                    },
                    allowDecimals: false
                },
                tooltip: {
                    shared: true,
                    valueSuffix: ' Actions & Tasks'
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    area: {
                        stacking: 'normal',
                        lineColor: '#666666',
                        lineWidth: 1,
                        marker: {
                            lineWidth: 1,
                            lineColor: '#666666'
                        }
                    }
                },
                series: [
{
    name: 'Overdue',
    data: json.dataOverdue,
    color: '#D84830'
  }, {
    name: 'Due',
    data: json.dataDue,
    color: '#f08800'
  }, {
    name: 'Closed',
    data: json.dataClosed,
    color: '#78A830'
    	//fcffa2
  }
  
                
                ]
            });
	    });
};
	 
riskTasks = function() {
		  var businessAreaId, site, url, years;
		    years = jQuery('#dashYear').val();
		    site = jQuery('#siteLoc').val();
		    if(site == null) {
		    	years = '2100';//this is for avoid bring results if there is no site selected 
		    }
		    businessAreaId = jQuery('#businessAreaId').val();
		    url = contextPath + '/enviro/dashRiskTasks.json?' + 'years=' + years + '&sites=' + site + '&businessAreaId=' + businessAreaId;
		    jQuery.getJSON(url, function(json) {
		    	jQuery('#container2').highcharts({
	                chart: {
	                    type: 'area'
	                },
	                credits: {
	                    enabled: false
	                },
	                title: {
	                    text: 'Risk Management (RA & MP Tasks)'
	                },
	                subtitle: {
	                    text: ''
	                },
	                 xAxis: {
	                    categories: [
	                        'Jan',
	                        'Feb',
	                        'Mar',
	                        'Apr',
	                        'May',
	                        'Jun',
	                        'Jul',
	                        'Aug',
	                        'Sep',
	                        'Oct',
	                        'Nov',
	                        'Dec'
	                    ],
	                   
	                },
	                yAxis: {
	                    title: {
	                        text: ''
	                    },
	                    allowDecimals: false
	                },
	                tooltip: {
	                    shared: true,
	                    valueSuffix: ' Tasks'
	                },
	                credits: {
	                    enabled: false
	                },

	                plotOptions: {
	                    area: {
	                        stacking: 'normal',
	                        lineColor: '#666666',
	                        lineWidth: 1,
	                        marker: {
	                            lineWidth: 1,
	                            lineColor: '#666666'
	                        }
	                    }
	                },
	                series: [
	{
	    name: 'Overdue',
	    data: json.dataOverdue,
	    color: '#D84830'
	  }, {
	    name: 'Due',
	    data: json.dataDue,
	    color: '#f08800'
	  }, {
	    name: 'Closed',
	    data: json.dataClosed,
	    color: '#78A830'
	    	//fcffa2
	  }
	  
	                
	                ]
	            });		    	
		    });
};
		  
  inciPotentialSeverity1 = function() {
	    var businessAreaId, site, url, years;
	    years = jQuery('#dashYear').val();
	    site = jQuery('#siteLoc').val();
	    businessAreaId = jQuery('#businessAreaId').val();
	    url = contextPath + '/enviro/incidentPotentialSeverity1.json?' + 'years=' + years + '&site=' + site + '&businessAreaId=' + businessAreaId;
	    jQuery.getJSON(url, function(json) {
	      jQuery('#container4').highcharts({
	        chart: {
	          type: 'area'
	        },
	        credits: {
	            enabled: false
	        },
	        title: {
	          text: 'Incident Potential Severity P1'
	        },
	        xAxis: {
	        	 title: {
	 	            text: 'Months'
	 	          },
                categories: [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec'
                ],
               
            },
            yAxis: {
                title: {
                    text: ''
                },
                allowDecimals: false
            },
            tooltip: {
                shared: true,
                valueSuffix: ' Incidents'
            },
	        /*xAxis: {
	          title: {
	            text: 'Sites'
	          },
	          categories: json.dataSite
	        },*/
            credits: {
                enabled: false
            },
            plotOptions: {
                area: {
                    stacking: 'normal',
                    lineColor: '#666666',
                    lineWidth: 1,
                    marker: {
                        lineWidth: 1,
                        lineColor: '#666666'
                    }
                }
            },
            series: [
                     {
                       name: 'Overdue',
                       data: json.dataOverdue,
                       color: '#D84830'
                     }, {
                 	    name: 'Due',
                	    data: json.dataDue,
                	    color: '#f08800'
                	  }, {
                       name: 'Closed',
                       data: json.dataClosed,
                       color: '#78A830'
                     }
                   ]
	      });
	    });
	  };
  riskAssessmentGraph = function() {
    var businessAreaId, site, url, years;
    years = jQuery('#dashYear').val();
    site = jQuery('#siteLoc').val();
    businessAreaId = jQuery('#businessAreaId').val();
    url = contextPath + '/enviro/dashRiskAssessment.json?' + 'years=' + years + '&site=' + site + '&businessAreaId=' + businessAreaId;
    jQuery.getJSON(url, function(json) {
      jQuery('#container1').highcharts({
        chart: {
          type: 'bar'
        },
        credits: {
            enabled: false
        },
        title: {
          text: 'Risk Assessment'
        },
        xAxis: {
          title: {
            text: 'Sites'
          },
          categories: json.dataSite
        },
        yAxis: {
          allowDecimals: false,
          min: 0
        },
        legend: {
          reversed: true
        },
        plotOptions: {
          series: {
            stacking: 'normal'
          }
        },
        series: [
          {
            name: 'High',
            data: json.dataHigh,
            color: '#D84830'
          }, {
            name: 'Medium',
            data: json.dataMedium,
            color: '#F0A800'
          }, {
            name: 'Low',
            data: json.dataLow,
            color: '#78A830'
          }
        ]
      });
    });
  };
  auditGraph = function() {
    var businessAreaId, site, url, years;
    years = jQuery('#dashYear').val();
    site = jQuery('#siteLoc').val();
    businessAreaId = jQuery('#businessAreaId').val();
    url = contextPath + '/enviro/dashAudits.json?' + 'years=' + years + '&site=' + site + '&businessAreaId=' + businessAreaId;
    jQuery.getJSON(url, function(json) {
      jQuery('#container6').highcharts({
        chart: {
          type: 'bar'
        },
        credits: {
            enabled: false
        },
        title: {
          text: 'Audit'
        },
        xAxis: {
          title: {
            text: 'Sites'
          },
          categories: json.dataSite
        },
        yAxis: {
          allowDecimals: false,
          min: 0
        },
        legend: {
          reversed: true
        },
        plotOptions: {
          series: {
            stacking: 'normal'
          }
        },
        series: [
          {
            name: 'Overdue',
            data: json.dataOverdue,
            color: '#D84830'
          }, {
            name: 'Due',
            data: json.dataDue,
            color: '#f08800'
          }, {
            name: 'Closed',
            data: json.dataClosed,
            color: '#78A830'
          }
        ]
      });
    });
  };
  
  auditByMonth = function() {
	    var businessAreaId, site, url, years;
	    years = jQuery('#dashYear').val();
	    site = jQuery('#siteLoc').val();
	    businessAreaId = jQuery('#businessAreaId').val();
	    url = contextPath + '/enviro/dashAuditStatus.json?' + 'years=' + years + '&site=' + site + '&businessAreaId=' + businessAreaId;
	    jQuery.getJSON(url, function(json) {	    	
	      jQuery('#container3').highcharts({
	    	  chart: {
		          type: 'area'
		        },
		        credits: {
		            enabled: false
		        },
		        title: {
		          text: 'Audits'
		        },
		        xAxis: {
		        	 title: {
		 	            text: 'Months'
		 	          },
	                categories: [
	                    'Jan',
	                    'Feb',
	                    'Mar',
	                    'Apr',
	                    'May',
	                    'Jun',
	                    'Jul',
	                    'Aug',
	                    'Sep',
	                    'Oct',
	                    'Nov',
	                    'Dec'
	                ],
	               
	            },
	            yAxis: {
	                title: {
	                    text: ''
	                },
                    allowDecimals: false
	            },
	            tooltip: {
	                shared: true,
	                valueSuffix: ' Audits'
	            },
		        /*xAxis: {
		          title: {
		            text: 'Sites'
		          },
		          categories: json.dataSite
		        },*/
	            credits: {
	                enabled: false
	            },

                plotOptions: {
                    area: {
                        stacking: 'normal',
                        lineColor: '#666666',
                        lineWidth: 1,
                        marker: {
                            lineWidth: 1,
                            lineColor: '#666666'
                        }
                    }
                },
	            series: [
	                     {
	                       name: 'Overdue',
	                       data: json.dataOverdue,
	                       color: '#D84830'
	                     }, {
	                         name: 'Due',
	                         data: json.dataDue,
	                         color: '#f08800'
	                       }, {
	                       name: 'Closed',
	                       data: json.dataClosed,
	                       color: '#78A830'
	                     }
	                   ]
		      });
		    });
		  };
	  
  jQuery('div').removeClass('block-flat');
  
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
  jQuery('#site_statistics_loading').hide();
  jQuery('#site_statistics_content').show();
  jQuery('#reload').click(function() {
    blockData();
    //inciActualSeverity();
    //inciPotentialSeverity();
    inciPotentialSeverity1();
    actionTasks();
    riskTasks();
    //riskAssessmentGraph();
    //auditGraph();
    auditByMonth();
  });
  blockData();
 // inciActualSeverity();
  //inciPotentialSeverity();
  inciPotentialSeverity1();
  actionTasks();
  riskTasks();
  //riskAssessmentGraph();
 // auditGraph();
  auditByMonth();
  
  
});

