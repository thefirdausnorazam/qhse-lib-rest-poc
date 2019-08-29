/**
 * 
 */
jQuery(document).ready(function() {
	  var complianceList, legList ,checkList , profile ,lawTabs ,levelOfCompletion;	  
	  jQuery('#le-alert').hide();
	  jQuery('#chkComp').hide();
	  jQuery("#locDiv").hide();
	  lawTabs = jQuery('#lawTabs').val();	  
	  jQuery('.close').click(function () {
		  jQuery(this).parent().removeClass('in'); // hides alert with Bootstrap CSS3 implem
		});
	 
	  legList = function() {
	    var url;
	    url = contextPath + '/law/lawDashboardLegislations.json?legRegister=' + lawTabs;	    
	    jQuery.getJSON(url, function(json) {
	      jQuery('#container1').highcharts({
	        chart: {
	          plotBackgroundColor: null,
	          plotBorderWidth: null,
	          plotShadow: false
	        },
	        title: {
	          text: ''
	        },
	        credits: {
	            enabled: false
	        },
	        tooltip: {
	          pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	          pie: {
	            allowPointSelect: true,
	            cursor: 'pointer',
	            dataLabels: {
	              enabled: true,
	              format: '<b>{point.name}</b>: {point.percentage:.1f} %',
	              style: {
	                color: Highcharts.theme && Highcharts.theme.contrastTextColor || 'black'
	              }
	            }
	          }
	        },
	        series: [
	          {
	            type: 'pie',
	            name: 'Legislation',
	            data: json.outer
	          }
	        ]
	      });
	    });
	  };
	  
	  profile = function() {
		  var url;
		  var site=jQuery('#siteLocation').val();		 
		    url = contextPath + '/law/profileDash.json?profileId=' + jQuery('#profileSelect').val()+'&sites='+site+'&legRegister='+lawTabs;
		    jQuery.getJSON(url, function(json) {		    	
		    	 if(json.updateAndCurrentUserCanUpdate){
		    		 jQuery('#le-alert').show();
		    		jQuery('#le-alert').addClass('in');		    		
		    	} 
		    	jQuery('#overDueCount').text(json.overDueCount); 
		    	jQuery('#dueCount').text(json.dueCount);
		    	jQuery('#profileName').text(json.profileUserName);
		    	jQuery('#countryName').text(json.country);
		    	jQuery('#contentUpdateDate:last').text(json.contentUpdatedDate);
		    	jQuery('#newLeg').text(json.legNewCount);
		    	jQuery('#newAmd').text(json.legAmendmentCount);
		    });
	  };
	  
	  checkList = function() {
		    var url;
		    url = contextPath + '/law/checklists.htm?refine=false&viewAll=true&dash=true&legRegister='+lawTabs;
		    jQuery.getJSON(url, function(json) {		    	
		    //jQuery('#relCount').html(json.relevanceCount);
		   // jQuery('#compCount').html(json.complianceCount);
		      jQuery('#container2').highcharts({
		        chart: {
		          plotBackgroundColor: null,
		          plotBorderWidth: null,
		          plotShadow: false
		        },
		        title: {
		          text: ''
		        },
		        credits: {
		            enabled: false
		        },
		        tooltip: {
		          pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		        },
		        plotOptions: {
		          pie: {
		            allowPointSelect: true,
		            cursor: 'pointer',
		            dataLabels: {
		              enabled: true,
		              format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		              style: {
		                color: Highcharts.theme && Highcharts.theme.contrastTextColor || 'black'
		              }
		            }
		          }
		        },
		        series: [
		          {
		            type: 'pie',
		            name: 'Legislation',
		            data: json.outer
		          }
		        ]
		      });
		    });
		  };
		  
		  levelOfCompletion=function() {   
			  var url;
			  url = contextPath + '/law/checklists.htm?refine=false&viewAll=true&levelOfCompletion=true&legRegister='+lawTabs;			  
			  jQuery.getJSON(url, function(json) {
				  if(json.locStatus){
					  jQuery('#chkComp').show();
					  jQuery("#locDiv").show();
				  var trHTML = '';
				  jQuery.each(json.locTable, function(k, item) {					  
					  if(item.evaluationPercent < 100 || item.relevancePercent < 100 ){
						  var urlLink ;						  
						  urlLink=contextPath+'/law/checklists.htm?refine=false&viewAll=true&levelOfCompletionDetail=true&legRegister=' + lawTabs + '&checkCategory='+item.categoryId;
					trHTML += '<tr><td text-align="center">' + item.category + '&nbsp;<a href='+urlLink+' style="float:right;color:black;" ><i  cat-id='+item.categoryId+ ' class="fa fa-external-link"></i></a></td><td text-align="center">' + item.evaluationPercent + '%</td><td text-align="center">' + item.relevancePercent +
					      '%</td></tr>';
					  }else{
					trHTML += '<tr><td text-align="center">' + item.category + '</td><td text-align="center">' + item.evaluationPercent  + '%</td><td text-align="center">' + item.relevancePercent +
					      '%</td></tr>';  
					  }
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
	                min:-100,
	                max:100,
	                labels: {
	                    formatter: function () {
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
	                formatter: function () {
	                    return '<b>' + this.series.name + ', ' + this.point.category + '</b><br/>' +'' + Highcharts.numberFormat(Math.abs(this.point.y), 0)+'%';
	                }
	            },

	            series: [{
	            	name: SCANNELL_TRANSLATIONS.complianceCompleted,
	                data: json.evaluationComplete
	            }, {
	            	name:  SCANNELL_TRANSLATIONS.relevanceCompleted,
	                data: json.relevanceComplete
	                
	            }]
	        });
			  }else{
				  jQuery('#chkComp').hide();
			  }
			});
			  
		  };
		  
	  jQuery('#block').removeClass('block-flat');
	  legList();	  
	  checkList();
	  profile();	 
	  levelOfCompletion();
	});
