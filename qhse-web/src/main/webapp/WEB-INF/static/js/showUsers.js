var maxListSize = 500;
var enterChars = 'Type to search for user';

function showResponsibleUserList(userCount, optionWidth, initialUserId, initialUserVal) {
	showUserList(userCount, "responsibleUser", optionWidth, "userList.json", initialUserId, initialUserVal);
}

function showResponsibleUserList(userCount, optionWidth, jsonUrl, initialUserId, initialUserVal) {
	showUserList(userCount, "responsibleUser", optionWidth, jsonUrl, initialUserId, initialUserVal);
}

function showUserList(userCount, userList, optionWidth, jsonUrl, initialUserId, initialUserVal) {
	showUserListInternal(userCount, userList, optionWidth, jsonUrl, [{id: initialUserId, text: initialUserVal}], false);
}

function showMultipleUserList(userCount, userList, optionWidth, jsonUrl, initialUserList) {
	showUserListInternal(userCount, userList, optionWidth, jsonUrl, initialUserList, true);
}

function showUserListInternal(userCount, userList, optionWidth, jsonUrl, initialUserList, multipleSelect) {
	if(userCount < maxListSize && userCount > 0) {
		jQuery('#'+userList).select2({width:optionWidth+'%'});
	
	} else {	
		var selectedIds = initialUserList.map(function(item) {
			return item.id;
		});
		jQuery('#'+userList).val(selectedIds);
		
		jQuery('#'+userList).select2({				  
		  width:optionWidth+'%',
		  allowClear: true,
		  minimumInputLength : 3,
		  placeholder :  enterChars,
		  escapeMarkup: function(m) {
		        // Do not escape HTML in the select options text
		        return m;
		  },
		  ajax: {
		        url: jsonUrl,
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
		    	if (initialUserList.length > 0) {
		    		if (multipleSelect) {
				        callback(initialUserList);
		    		} else {
		    			callback(initialUserList[0]);
		    		}
		    	}
			},

		      // NOT NEEDED: These are just css for the demo data
		      dropdownCssClass : 'capitalize',
		      containerCssClass: 'capitalize',

		      // configure as multiple select
		      multiple         : multipleSelect,

		      // NOT NEEDED: text for loading more results
		      formatLoadMore   : 'Loading more...',				      
		      // query with pagination	
		      cache: true
				
		});
	}
}