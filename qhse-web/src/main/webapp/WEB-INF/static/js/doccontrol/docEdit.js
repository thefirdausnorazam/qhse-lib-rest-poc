var enterChars = '<fmt:message key="select2.enterChars"/>';


function setUpListElements() {
	jQuery('#docGroup').select2({width:'90%'});
	jQuery('#departments').select2({width:'90%'});
	jQuery('#status').select2({width:'90%'});
	jQuery('#trainneeGroup').select2({width:'90%'});
	jQuery('#trainneeSite').select2({width:'90%'});
	jQuery('#approvedVer').select2({width:'90%'});
	jQuery('#draftVer').select2({width:'90%'});
	
	alert("${command.approvedByUser}");
	if ("${command.approvedByUser}") {
		var approvedByUser = '<c:out value="${command.approvedByUser.id}"/>';
		if(approvedByUser != null){
			jQuery('#approvedByUser').val(approvedByUser);
		}
	}
	
	jQuery('#approvedByUser').select2({				  
		  width:'60%',
		  minimumInputLength : 3,
		  placeholder :  enterChars,
		  escapeMarkup: function(m) {
		        // Do not escape HTML in the select options text
		        return m;
		     },
		  ajax: {
		        url: "approverList.json&docGroup="+jQuery('#docGroup').val(),
		        dataType: 'json',
		        type: "GET",
		        quietMillis: 100,
		        data: function (term) {
		            return {
		                term: term
		            };
		        },
		        results: function (data) {
		            return {
		                results: $.map(data, function (item) {
		                    return {
		                        text: item.userName,	
		                        slug: item.slug,
		                        id: item.id
		                    }
		                })
		            };
		        }
		    },
		    initSelection: function (element, callback) {
		    	if ("${command.approvedByUser}") {
		    		var data = {id: '<c:out value="${command.approvedByUser.id}"/>', text: '<c:out value="${command.approvedByUser.sortableName}"/>'};
		    		callback(data);
		    	}
			},

		      // NOT NEEDED: These are just css for the demo data
		      dropdownCssClass : 'capitalize',
		      containerCssClass: 'capitalize',

		      // configure as multiple select
		      multiple         : false,

		      // NOT NEEDED: text for loading more results
		      formatLoadMore   : 'Loading more...',				      
		      // query with pagination	
		      cache: true
				
		});
	
	var data = [];
	if("${command.reviewers}" != "") {
		"${command.reviewers}".forEach(function(sa) {
			jQuery('#reviewers').append("<option value='${sa.id}' >${sa.sortableName}</option>") 
	    	jQuery('#reviewers').val('<c:out value="${sa.id}"/>');
	    	jQuery('#reviewers option[value="${sa.id}"]').attr("selected","selected");
	    	data.push('${sa.id}');
		});
	}
	
	jQuery('#reviewers').select2('val', data);
	
	jQuery('#reviewers').select2({				  
	  width:'60%',
	  minimumInputLength : 3,
	  placeholder :  enterChars,
	  escapeMarkup: function(m) {
	        // Do not escape HTML in the select options text
	        return m;
	     },
	  ajax: {
	        url: "reviewerList.json&docGroup="+jQuery('#docGroup').val(),
	        dataType: 'json',
	        type: "GET",
	        quietMillis: 100,
	        data: function (term) {
	            return {
	                term: term
	            };
	        },
	        results: function (data) {
	            return {
	                results: $.map(data, function (item) {
	                    return {
	                        text: item.userName,	
	                        slug: item.slug,
	                        id: item.id
	                    }
	                })
	            };
	        }
	    },
	    initSelection: function (element, callback) {				    	
			var data = [];
			"${command.reviewers}".forEach(function(sa) {
				data.push({id: '<c:out value="${sa.id}"/>', text: '<c:out value="${sa.sortableName}"/>'});
			});
		    callback(data); 
		},

	      // NOT NEEDED: These are just css for the demo data
	      dropdownCssClass : 'capitalize',
	      containerCssClass: 'capitalize',
	      // configure as multiple select
	      multiple         : true,
	      // NOT NEEDED: text for loading more results
	      formatLoadMore   : 'Loading more...',	
	      cache: true,
	});
	
	var data = [];
	if("${command.trainees.audUsers}" != "[]") {
		"${command.trainees.audUsers}".forEach(function(sa) {
	    	jQuery('#trainneeUser').append("<option value='${sa.id}' >${sa.sortableName}</option>") 
	    	jQuery('#trainneeUser').val('<c:out value="${sa.id}"/>');
	    	jQuery('#trainneeUser option[value="${sa.id}"]').attr("selected","selected");
	    	data.push('${sa.id}');
		});
	}
	
	jQuery('#trainneeUser').select2('val', data);
	
	jQuery('#trainneeUser').select2({				  
	  width:'60%',
	  minimumInputLength : 3,
	  placeholder :  enterChars,
	  escapeMarkup: function(m) {
	        // Do not escape HTML in the select options text
	        return m;
	     },
	  ajax: {
	        url: "userList.json&docGroup="+jQuery('#docGroup').val(),
	        dataType: 'json',
	        type: "GET",
	        quietMillis: 100,
	        data: function (term) {
	            return {
	                term: term
	            };
	        },
	        results: function (data) {
	            return {
	                results: $.map(data, function (item) {
	                    return {
	                        text: item.userName,	
	                        slug: item.slug,
	                        id: item.id
	                    }
	                })
	            };
	        }
	    },
	    initSelection: function (element, callback) {				    	
			var data = [];
			"${command.trainees.audUsers}".forEach(function(sa) {
		    	data.push({id: '<c:out value="${sa.id}"/>', text: '<c:out value="${sa.sortableName}"/>'});
			});
		    callback(data); 
		},

	      // NOT NEEDED: These are just css for the demo data
	      dropdownCssClass : 'capitalize',
	      containerCssClass: 'capitalize',
	      // configure as multiple select
	      multiple         : true,
	      // NOT NEEDED: text for loading more results
	      formatLoadMore   : 'Loading more...',	
	      cache: true,
	});
}