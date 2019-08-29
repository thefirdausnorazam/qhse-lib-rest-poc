
		function showHideDocGroupWarning() {
			var selectedDocGroup = jQuery("#docGroup").val();
			if(selectedDocGroup == undefined || selectedDocGroup > 0) {
				 jQuery(".selectDocGroup").hide();
     			 jQuery('#trainneeUser').prop("disabled", false);
      			 jQuery('#approvedByUser').prop("disabled", false);
      			 jQuery('#reviewers').prop("disabled", false);
      		 }
      		 else {
      			 jQuery(".selectDocGroup").show();
      			 jQuery('#trainneeUser').prop("disabled", true);
      			 jQuery('#approvedByUser').prop("disabled", true);
      			 jQuery('#reviewers').prop("disabled", true);
      		 }
		}
		
		function changeFile() {
			var content = jQuery('#content').val();
			var name= getName(content);
			jQuery('#filename').val(name);
			jQuery("#file-info").html(name);

		}

		function urlFile() {
			var content = jQuery('#filename').val();
			if (content != null && content.length > 0) {
				jQuery("#file-info").html(content);
			}
		}
		function getName(s){
			var arr=s.split('\\');
			var name= arr[(arr.length-1)];
			return name;
		}

		function onStatusChange() {
			if (jQuery('#status').val() == 'APPROVED') {
				showBlock('approvedUser');
				showBlock('approvedComment');
				showBlock('approvedDate');
				jQuery('#draftVer').select2('val', '0');
				jQuery('#draftVer').prop("disabled", true);
			
			} else {
				hideBlock('approvedUser');
				hideBlock('approvedComment');
				hideBlock('approvedDate');
				jQuery('#draftVer').prop("disabled", false);
			}
		}
		
		