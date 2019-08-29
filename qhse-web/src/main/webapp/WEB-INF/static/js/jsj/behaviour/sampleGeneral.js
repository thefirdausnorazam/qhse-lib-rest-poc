 jQuery(document).ready(function() {	  
	
	  jQuery('div').removeClass('block-flat');	 
	  //toggleSideBar();
	  
	  function toggleSideBar(_this){
	        var b = jQuery("#sidebar-collapse")[0];
	        var w = jQuery("#cl-wrapper");
	        var s = jQuery(".cl-sidebar");
	        
	        if(w.hasClass("sb-collapsed")){
	        	jQuery(".fa",b).addClass("fa-angle-left").removeClass("fa-angle-right");
	          w.removeClass("sb-collapsed");
	        }else{
	        	jQuery(".fa",b).removeClass("fa-angle-left").addClass("fa-angle-right");
	          w.addClass("sb-collapsed");
	        }
	        
	      }	  
	  
	
	  function showTooltip(x, y, contents) {
		  
		  jQuery("<div id='tooltip'>" + contents + "</div>").css({
	        position: "absolute",
	        display: "none",
	        top: y + 5,
	        left: x + 5,
	        border: "1px solid #000",
	        padding: "5px",
	        'color':'#fff',
	        'border-radius':'2px',
	        'font-size':'11px',
	        "background-color": "#000",
	        opacity: 0.80
	      }).appendTo("body").fadeIn(200);
	    } 
	  
	 
	  var pageviews = [
	                   [1, 1],
	                   [2, 2],
	                   [3, 3],
	                   [4, 4],
	                   [5, 5 ],
	                   [6, 10 ],
	                   [7, 15 ],
	                   [8, 20 ],
	                   [9, 25 ],
	                   [10, 30 ],
	                   [11, 35 ],
	                   [12, 25 ]
	                  
	                   ];

	  jQuery('#site_statistics_loading').hide();
	  jQuery('#site_statistics_content').show();
	  var data;
	  jQuery.plot(jQuery("#site_stat"), [{
	        data: pageviews,
	        label: "Hours Lost"
	      }
	      ], {
	        series: {
	          lines: {
	            show: true,
	            lineWidth: 2, 
	            fill: true,
	            fillColor: {
	              colors: [{
	                opacity: 0.2
	              }, {
	                opacity: 0.51
	              }
	              ]
	            } 
	          },
	          points: {
	            show: true
	          },
	          shadowSize: 2
	        },
	        legend:{
	          show: false
	        },
	        grid: {
	        labelMargin: 10,
	           axisMargin: 500,
	          hoverable: true,
	          clickable: true,
	          tickColor: "rgba(255,255,255,0.22)",
	          borderWidth: 0
	        },
	        colors: ["#FFFFFF", "#4A8CF7", "#52e136"],
	        xaxis: {
	          ticks: [[0,''],[1,'Jan'],[2,'Feb'],[3,'Mar'],[4,'Apr'],[5,'May'],[6,'Jun'],[7,'Jul'],[8,'Aug'],[9,'Sept'],[10,'Oct'],[11,'Nov'],[12,'Dec']],
	          tickDecimals: 0
	        },
	        yaxis: {
	          ticks: 5,
	          tickDecimals: 0
	        }
	      });
	 
    	  
    	  function actionTasks(){
    		  var years = jQuery('#dashYear').val();    		  
    		  var site =  jQuery('#siteLoc').val(); 
    		  var businessAreaId =  jQuery('#businessAreaId').val();
    		  var url = contextPath+"/enviro/dashActionsTasks.json?"+"years="+years+"&sites="+site+"&businessAreaId="+businessAreaId;
    		  jQuery.getJSON(url, function(json) {	  

    	            jQuery('#containerArea').highcharts({
                        chart: {
                            type: 'area'
                        },
                        title: {
                            text: 'Actions & Tasks'
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
                            }
                        },
                        tooltip: {
                            shared: true,
                            valueSuffix: ' Actions & Tasks'
                        },
                        credits: {
                            enabled: false
                        },
                        plotOptions: {
                            areaspline: {
                                fillOpacity: 0.5
                            }
                        },
                        series: [
                           {
                          name: json.closed,
                          data: json.dataClosed
                        },       
                        {
                            name: json.overdue,
                            data: json.dataOverdue
                        },                         
                        {
                            name: json.due,
                            data: json.dataDue
                        }
                        
                        ]
                    });
    			  
    		  });
      }
    	  
    	  function blockData(){
    		  var years = jQuery('#dashYear').val();    		  
    		  var site =  jQuery('#siteLoc').val(); 
    		  var businessAreaId =  jQuery('#businessAreaId').val();
    		  var url = contextPath+"/enviro/blockDashBoardData.json?"+"years="+years+"&sites="+site+"&businessAreaId="+businessAreaId;
    		  jQuery.getJSON(url, function(json) {	  
    			  jQuery('#criticCount').text(json.incidentCriticalCount);
    			  jQuery('#externalBreaches').text(json.dataBreachesCount);
    			  jQuery('#lawCompliance').text(json.lawCompliance);
    			  jQuery('#auditYear').text(json.auditYear+'%');
    			  jQuery('#planYear').text(json.planYear+'%');
    			  jQuery('#riskTargetCount').text(json.riskTargetCount);
    			  
    		  });
         }
	 
    	  function manDaysLost(){
    		  var years = jQuery('#dashYear').val();    		  
    		  var site =  jQuery('#siteLoc').val();    		  
    		  var url = contextPath+"/enviro/dashManDaysLost.json?"+"years="+years+"&sites="+site;
    		  jQuery.getJSON(url, function(json) {	    
    			  jQuery('#totalIncidents').text(json.inciCount);
    			  jQuery('#totalHours').text(json.inciTotalHours);
    			  jQuery('#year').text('('+json.selectedYear+')');
    			  jQuery('#displayManHours').text("Total Man Hours Lost in "+json.selectedYear);
    			  jQuery('#planYearYear').text("Change Plan "+json.selectedYear);
    			  jQuery('#auditYearYear').text("Audit Plan "+json.selectedYear);
    			  
    			
    			  jQuery.plot(jQuery("#site_stat"), [{
    			        data: json.outer,
    			        label: "Hours Lost"
    			      }
    			      ], {
    			        series: {
    			          lines: {
    			            show: true,
    			            lineWidth: 2, 
    			            fill: true,
    			            fillColor: {
    			              colors: [{
    			                opacity: 0.2
    			              }, {
    			                opacity: 0.51
    			              }
    			              ]
    			            } 
    			          },
    			          points: {
    			            show: true
    			          },
    			          shadowSize: 2
    			        },
    			        legend:{
    			          show: false
    			        },
    			        grid: {
    			        labelMargin: 10,
    			           axisMargin: 500,
    			          hoverable: true,
    			          clickable: true,
    			          tickColor: "rgba(255,255,255,0.22)",
    			          borderWidth: 0
    			        },
    			        colors: ["#FFFFFF", "#4A8CF7", "#52e136"],
    			        xaxis: {
    			          ticks: [[0,''],[1,'Jan'],[2,'Feb'],[3,'Mar'],[4,'Apr'],[5,'May'],[6,'Jun'],[7,'Jul'],[8,'Aug'],[9,'Sept'],[10,'Oct'],[11,'Nov'],[12,'Dec']],
    			          tickDecimals: 0
    			        },
    			        yaxis: {
    			          ticks: 5,
    			          tickDecimals: 0
    			        }
    			      });
    		  });
      }
	  
     jQuery("#site_stat").bind("plothover", function (event, pos, item) {
          
          var str = "(" + pos.x.toFixed(2) + ", " + pos.y.toFixed(2) + ")";

          if (item) {
            if (previousPoint != item.dataIndex) {
              previousPoint = item.dataIndex;
              jQuery("#tooltip").remove();
              var x = item.datapoint[0].toFixed(2),
              y = item.datapoint[1].toFixed(2);
              showTooltip(item.pageX, item.pageY,
              item.series.label + " of " + x + " = " + y);
            }
          } else {
        	jQuery("#tooltip").remove();
            previousPoint = null;
          }
        }); 
      
      
      /*Pie Chart*/
      var data = [
      { label: "All<br>Safe (38%)", data: 38},
      { label: "Awkward<br>Positions (7%)", data: 12},
      { label: "Caught<br>Between <br>(10%)", data: 10},
      { label: "Caught<br>On/In <br>(3%)", data: 10},
      { label: "Over<br>Exertion <br>(12%)", data: 12},
      { label: "Struck by (8%)", data: 18}
      ]; 

      jQuery.plot('#piecha', data, {
        series: {
          pie: {
            show: true,
            innerRadius: 0.27,
            shadow:{
              top: 5,
              left: 15,
              alpha:0.3
            },
            stroke:{
              width:0
            },
            label: {
                        show: true,
                        formatter: function (label, series) {
                            return '<div style="font-size:12px;text-align:center;padding:2px;color:#333;">' + label + '</div>';

                        }
                    },
            highlight:{
              opacity: 0.08
            }
          }
        },
        grid: {
          hoverable: true,
          clickable: true
        },
        colors: ["#5793f3", "#d4df5a", "#5578c2","#dd4444","#fd9c35","#fec42c","#dd74d79","#ededed"],
        legend: {
          show: false
        }
      });
      
       var data_com3 = [
                       [1, 3],
                       [2, 2],
                       [3, 8],
                       [4, 3],
                       [5, 4],
                       [6, 5],
                       [7, 1],
                       [8, 0],
                       [9, 0],
                       [10, 0],
                       [11, 0],
                       [12, 0]
                     ];
               	  var data_com2 = [
                       [1, 5],
                       [2, 8],
                       [3, 2],
                       [4, 3],
                       [5, 5],
                       [6, 10],
                       [7, 15],
                       [8, 0],
                       [9, 0],
                       [10, 0],
                       [11, 0],
                       [12, 0]
                     ];
                     var data_com = [
                       [1, 5],
                       [2, 8],
                       [3, 10 ],
                       [4, 15],
                       [5, 17 ],
                       [6, 19 ],
                       [7, 15 ],
                       [8, 0],
                       [9, 0],
                       [10, 0],
                       [11, 0],
                       [12, 0]
                     ];
                      var names = [
                                   "Alpha",
                                   "Beta",
                                   "Gamma",
                                   "Delta",
                                   "Epsilon",
                                   "Zeta",
                                   "Eta",
                                   "Theta"
                               ];
                         
                     var plot_stat = jQuery.plot(jQuery("#chart3s"), [{
                       data: data_com, showLabels: true, label: "Closed", labelPlacement: "below", canvasRender: true, cColor: "#FFFFFF" 
                     },{
                       data: data_com2, showLabels: true, label: "Due", labelPlacement: "below", canvasRender: true, cColor: "#FFFFFF"  
                     },{
                       data: data_com3, showLabels: true, label: "Overdue", labelPlacement: "below", canvasRender: true, cColor: "#FFFFFF" 
                     }
                     ], {
                       series: {
                         lines: {
                           show: true,
                           lineWidth: 1, 
                           fill: true,
                            fillColor: { colors: [{ opacity: 0.5 }, { opacity: 1.8}] }
                         },
                         fillColor: "rgba(0, 0, 0, 1)",
                         points: {
                           show: false,
                           fill: true
                         },
                         shadowSize: 2
                       },
                       legend:{
                         show: true,
                          position:"nw",
                          backgroundColor: "green",
                          container: $("#chart3-legends")
                       },
                       grid: {
                         show:false,
                         margin: 0,
                         labelMargin: 0,
                          axisMargin: 0,
                         hoverable: true,
                         clickable: true,
                         tickColor: "rgba(255,255,255,1)",
                         borderWidth: 0
                       },
                       colors: ["#E3E6E8","#1fb594"],
                       xaxis: {
                         autoscaleMargin: 0,
                         ticks: [[0,''],[1,'Jan'],[2,'Feb'],[3,'Mar'],[4,'Apr'],[5,'May'],[6,'Jun'],[7,'Jul'],[8,'Aug'],[9,'Sept'],[10,'Oct'],[11,'Nov'],[12,'Dec']],
                         tickDecimals: 0
                       },
                       yaxis: {
                         autoscaleMargin: 0.2,
                         ticks: 5,
                         tickDecimals: 0
                       }
                     }); 
                     
                      jQuery("#chart3s").bind("plothover", function (event, pos, item) {
                         
                         var str = "(" + pos.x.toFixed(2) + ", " + pos.y.toFixed(2) + ")";

                         if (item) {
                           if (previousPoint != item.dataIndex) {
                             previousPoint = item.dataIndex;
                             jQuery("#tooltip").remove();
                             var x = item.datapoint[0].toFixed(2),
                             y = item.datapoint[1].toFixed(2);
                             showTooltip(item.pageX, item.pageY,
                             item.series.label + " of " + x + " = " + y);
                           }
                         } else {
                        	 jQuery("#tooltip").remove();
                           previousPoint = null;
                         }
                       });     
                     
        

	    
	   
  });