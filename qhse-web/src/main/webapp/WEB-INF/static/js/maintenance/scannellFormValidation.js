/**
 * Author Manjush
 * Date : 4 Dec 2014
 * 
 */
		jQuery(document).ready(function() {			
			jQuery( "#form_actualDate" ).on('change', function() {					
				var input=jQuery(this);
				var is_name=input.val();
				var selectedDate =Date.parse(jQuery('#form_actualDate').val());				
				var check = Date.today().compareTo(selectedDate); 
				
				if (check == -1) {
					jQuery("#spanActualDate").text("Date cannot be in the future");
					jQuery('#spanActualDate').removeClass("errorValidation").addClass("error_show");
					input.removeClass("valid").addClass("invalid");
				}
				else if(is_name){input.removeClass("invalid").addClass("valid");jQuery('#spanActualDate').removeClass("error_show").addClass("errorValidation");}
				else{input.removeClass("valid").addClass("invalid");}
				});
			
			jQuery('#form_carriedOutBy').on('input', function() {
				var input=jQuery(this);
				var is_name=input.val();
				if(is_name){input.removeClass("invalid").addClass("valid");jQuery('#spanCarriedOutBy').removeClass("error_show").addClass("errorValidation");}
				else{input.removeClass("valid").addClass("invalid");}
			});
				
				
		
			/*<!-- After Form Submitted Validation-->*/
			jQuery("#form_submit").click(function(event){				
				var valid=0;
				var dt = jQuery('#form_actualDate').val();
				var cob = jQuery('#form_carriedOutBy').val();				
				var check = 0;				
								
				if(dt == null || dt =='' || dt =='undefined' ){						
					jQuery('#form_actualDate').removeClass("valid").addClass("invalid");					
					jQuery('#spanActualDate').removeClass("errorValidation").addClass("error_show");	
					valid=1;
				 }else if (Date.today().compareTo(Date.parse(dt)) == -1){	/*This else is needed to call the Date.parse without an empty string	*/			 						
								
							jQuery("#spanActualDate").text("Date cannot be in the future");
							jQuery('#spanActualDate').removeClass("errorValidation").addClass("error_show");
							jQuery('#form_actualDate').removeClass("valid").addClass("invalid");
							valid=1;						
				 }else {					
					 jQuery('#form_actualDate').removeClass("invalid").addClass("valid");
					 valid=0;
									 
				 }					 
			/*End of Date Validation , Start of Carried out by*/
				
				if(cob == null || cob =='' || cob =='undefined' ){					
					jQuery('#form_carriedOutBy').removeClass("valid").addClass("invalid");	
					valid=1;
					jQuery('#spanCarriedOutBy').removeClass("errorValidation").addClass("error_show");					
				 }
			
				if (valid != 0){					 
					jQuery('#alrt').removeClass("hide");
					event.preventDefault();
				}else{					
					 
				}
				
			});
			
			
			
		});
	