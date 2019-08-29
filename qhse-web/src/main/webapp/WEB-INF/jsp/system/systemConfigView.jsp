<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="risk" tagdir="/WEB-INF/tags/risk" %>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="admin.setting" /></title>
	<link rel="stylesheet" href="<scannell:resource value="/css/bootstrap-slider.css" />">   
 <style>
.buttonCss {
    background-color: #13ab94;
    border: none;
    color: white;
    padding: 6px 12px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
}
.slider.slider-horizontal{
	width: 80%;
}
.slider-selection {
	background: #4D90FD;
}
.sliderValue {
	display: inline;
	margin-left: 20px;
}
.editable {
	text-align: left;
	border-style: ridge; 
	white-space: pre-wrap;
	background: #d1d1d1;
	padding-bottom: 5px;
    padding-top: 5px;
    padding-left: 5px;
    padding-right: 5px;
    margin-right: 20px;
}
.editing {
	background: #d7ede7;
}
.save, .cancel {
	display:none;
    margin-left: 10px;
}
.textAreaAuto {
	min-height:100px;
	width: auto; 
	height: auto;
}
</style>
	<script type="text/javascript" src="<scannell:resource value="/js/bootstrap-slider.js" />"></script>
   <script type="text/javascript">
 function saveSetting(checkbox){
	 var leg = checkbox.checked;
 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "systemConfigEdit.json",
		  data: 'legacy='+leg+'&configName=legacy',
		  success: function(data){
			  var showLegacy = data.value=='true'?'<fmt:message key="admin.showingLegacy"/>':'<fmt:message key="admin.hidingLegacy"/>';
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append('<fmt:message key="admin.save"/><br>'+showLegacy+'<br><br><fmt:message key="admin.logout"/>');
 			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:300,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open');
		  }
		}); 
 }
 function syncUserSftp(){
	 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "syncUserSftp.json",
		  data: '',
		   beforeSend: function(){
			   jQuery("#divSchedule").dialog({show: "slide", modal: true, autoOpen: false});
			   jQuery("#divSchedule").dialog("open"); 
			   },
		  success: function(data){
			  jQuery("#divSchedule").dialog('close');
			  var autoContent = data.success==true?'<fmt:message key="admin.sftp.sync.success"/><br>':'<fmt:message key="admin.sftp.sync.fail"/><br>';
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append(autoContent);
			  jQuery("#dialogAlert").append('<a href="<c:url value="/system/sftpSyncLog.htm"></c:url>" ><fmt:message key="admin.sftp.logcheck" /></a><br>');
			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:300,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
			  
          
		  },
		  error: function(xhr, textStatus, errorThrown){
			  jQuery("#divSchedule").dialog('close');
			  var autoContent = '<fmt:message key="admin.sftp.sync.fail"/><br>';
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append(autoContent);
			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:300,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
			  
		    },
		 complete:function(data){
			    // Hide dialogue
			   jQuery("#divSchedule").dialog('close');
			   }
		});
 }
 function saveSyncSetting(checkbox){
	 var sync = checkbox.checked;
 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "systemSyncConfigEdit.json",
		  data: 'sync='+sync,
		  success: function(data){
			  var showLegacy = data.sync==true?'<fmt:message key="admin.syncNightly"/>':'<fmt:message key="admin.noSyncNightly"/>';
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append('<fmt:message key="admin.save"/><br>'+showLegacy+'<br>');
 			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:300,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
 			  
           
		  }
		}); 
 }
 
 function saveConetntSetting(checkbox){
	 var content = checkbox.checked;
 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "systemContentConfigEdit.json",
		  data: 'autoContent='+content+'&configName=autoContent',
		  success: function(data){
			  var autoContent = data.value=='true'?'<fmt:message key="admin.autoContent"/>':'<fmt:message key="admin.noAutoContent"/>';
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append('<fmt:message key="admin.save"/><br>'+autoContent+'<br>');

			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:300,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
          
		  }
		}); 
 }
 
 function saveSubmitUserSetting(checkbox){
	 var submitUserChecked = checkbox.checked;
 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "submitUserConfigEdit.json",
		  data: 'submitUser='+submitUserChecked+'&configName=submitUser',
		  success: function(data){
			  var submitUser = data.value=='true'?'<fmt:message key="admin.submitUserSettingSave"/>':'<fmt:message key="admin.submitUserSettingReset"/>';
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append('<fmt:message key="admin.save"/><br>'+submitUser+'<br>');
 			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:300,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
          
		  }
		}); 
 }
 
 function saveCaptchaSetting(checkbox){
	 var captchaChecked = checkbox.checked;
 	 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "submitCaptchaEdit.json",
		  data: 'captcha='+captchaChecked+'&configName=captcha',
		  success: function(data){
			  var captcha = data.value=='true'?'<fmt:message key="admin.captchaShow"/>':'<fmt:message key="admin.captchaHide"/>';
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append('<fmt:message key="admin.save"/><br>'+captcha+'<br>');
 			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:300,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
          
		  }
		}); 
 }
 
 function savePasswordComplexity(checkbox) {
	 var checked = checkbox.checked;
 	 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "submitPasswordComplexity.json",
		  data: 'forcePasswordComplexity='+checked+'&configName=forcePasswordComplexity',
		  success: function(data){
			  var message = data.value=='true'?'<fmt:message key="admin.passwordComplexityEnabled"/>':'<fmt:message key="admin.passwordComplexityDisabled"/>';
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append('<fmt:message key="admin.save"/><br>'+message+'<br>');
 			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:300,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
          
		  }
		}); 
 }
 
 function saveVerificationExpirySetting(select) {
	 var selectedOption = select.item(select.selectedIndex); 
	 jQuery.ajax({
		 	  type: 'POST', 
			  dataType: "json",
			  url: "submitVerificationEmailExpiryTime.json",
			  data: 'emailVerificationExpiryMins='+selectedOption.value+'&configName=emailVerificationExpiryMins',
			  success: function(data){
				  jQuery("#dialogAlert").text('<fmt:message key="admin.emailVerificationExpiryMinsUpdated"/>');
	 			  jQuery("#dialogAlert").dialog({
					  modal:true,
					  height:300,
					  buttons: {
					        Ok: function() {
					          jQuery( this ).dialog( "close" );
					        }
					  }
					  }).dialog('open'); 
	          
			  }
			});
 }
 
 function saveVerificationExpirySetting(select) {
	 var selectedOption = select.item(select.selectedIndex); 
	 jQuery.ajax({
		 	  type: 'POST', 
			  dataType: "json",
			  url: "submitVerificationEmailExpiryTime.json",
			  data: 'emailVerificationExpiryMins='+selectedOption.value+'&configName=emailVerificationExpiryMins',
			  success: function(data){
				  jQuery("#dialogAlert").text('<fmt:message key="admin.emailVerificationExpiryMinsUpdated"/>');
	 			  jQuery("#dialogAlert").dialog({
					  modal:true,
					  height:300,
					  buttons: {
					        Ok: function() {
					          jQuery( this ).dialog( "close" );
					        }
					  }
					  }).dialog('open'); 
	          
			  }
			});
 }
 
 function saveVerificationExpirySetting(select) {
	 var selectedOption = select.item(select.selectedIndex); 
	 jQuery.ajax({
		 	  type: 'POST', 
			  dataType: "json",
			  url: "submitVerificationEmailExpiryTime.json",
			  data: 'emailVerificationExpiryMins='+selectedOption.value+'&configName=emailVerificationExpiryMins',
			  success: function(data){
				  jQuery("#dialogAlert").text('<fmt:message key="admin.emailVerificationExpiryMinsUpdated"/>');
	 			  jQuery("#dialogAlert").dialog({
					  modal:true,
					  height:300,
					  buttons: {
					        Ok: function() {
					          jQuery( this ).dialog( "close" );
					        }
					  }
					  }).dialog('open'); 
	          
			  }
			});
 }
 function saveScanSetting(checkbox){
	 var scanChecked = checkbox.checked;
	 jQuery.ajax({
		 	  type: 'POST', 
			  dataType: "json",
			  url: "submitScanEdit.json",
			  data: 'scan='+scanChecked+'&configName=scan',
			  success: function(data){
				  var scan = data.value=='true'?'<fmt:message key="admin.scan.true"/>':'<fmt:message key="admin.scan.false"/>';
				  jQuery("#dialogAlert").text('');
				  jQuery("#dialogAlert").append('<fmt:message key="admin.save"/><br>'+scan+'<br>');
	 			  jQuery("#dialogAlert").dialog({
					  modal:true,
					  height:300,
					  buttons: {
					        Ok: function() {
					          jQuery( this ).dialog( "close" );
					        }
					  }
					  }).dialog('open'); 
	          
			  }
			});
 }
 
 function savePasswordExpiryTime(timeValue) {
	 jQuery.ajax({
		 	  type: 'POST', 
			  dataType: "json",
			  url: "submitPasswordExpiryTime.json",
			  data: 'passwordExpiryTime='+timeValue+'&configName=passwordExpiryTime',
			  success: function(data){
				  var resultMessage = data.value==timeValue ?
						  				'<fmt:message key="admin.passwordExpiry.successMessage"/>':'<fmt:message key="admin.passwordExpiry.failureMessage"/>';

	  			  jQuery("#dialogAlert").text('');
	  			  jQuery("#dialogAlert").append('<fmt:message key="admin.save"/><br/>'+resultMessage+'<br/>');
	 			  jQuery("#dialogAlert").dialog({
					  modal:true,
					  height:300,
					  buttons: {
					        Ok: function() {
					          jQuery( this ).dialog( "close" );
					        }
					  }
					  }).dialog('open'); 
	          
			  }
			});
 }
 
 function saveMaxRecentlyUsedPasswords(maxValue) {
	 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "submitMaxRecentlyUsedPasswords.json",
		  data: 'maxRecentlyUsedPasswords='+maxValue+'&configName=maxRecentlyUsedPasswords',
		  success: function(data){
			  var resultMessage = data.value==maxValue ?
					  				'<fmt:message key="admin.maxRecentlyUsed.successMessage" />':'<fmt:message key="admin.maxRecentlyUsed.failureMessage" />';

 			  jQuery("#dialogAlert").text('');
 			  jQuery("#dialogAlert").append('<fmt:message key="admin.save"/><br/>'+resultMessage+'<br/>');
			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:300,
				  buttons: {
					  	Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
		  }
		});
 }
 
	function confirmForcePasswordChange() {
		jQuery("#dialogAlert").text('');
		jQuery("#dialogAlert").append('<span style="color: red; font-weight: bold;"><fmt:message key="admin.forceChange.warning" />:</span> <fmt:message key="admin.forceChange.confirmMessage1" />');
		jQuery("#dialogAlert").append('<br/><br/>');
		jQuery("#dialogAlert").append('<fmt:message key="admin.forceChange.confirmMessage2" />');
		
		jQuery("#dialogAlert").dialog({
			modal:true,
			height: 400,
			width: 500,
			buttons: {
				Yes: function() {
					forcePasswordChange();
					jQuery( this ).dialog( "close" );
				},
				No: function() {
					jQuery( this ).dialog( "close" );
				}
			}
		 }).dialog('open');
	} 
	
	function forcePasswordChange() {
		jQuery.ajax({
			type: 'POST', 
			dataType: "json",
			url: "forcePasswordChange.json",
			success: function(data) {
				var resultMessage = data.result=='success' ? '<fmt:message key="admin.forceChange.successMessage" />' : '<fmt:message key="admin.forceChange.failureMessage" />';
				
				jQuery("#dialogAlert").text('');
				jQuery("#dialogAlert").append(resultMessage);
				jQuery("#dialogAlert").dialog({
					modal: true,
					height: 500,
					buttons: {
						Ok: function() {
							jQuery( this ).dialog( "close" );
						}
					}
				}).dialog('open'); 
			}
		});
	}

 	function initializeSlider(sliderId, sliderLabelId, sliderInitialValue, saveValueFunction) {
		jQuery(sliderId).bootstrapSlider({
			value: sliderInitialValue
		});
		
		jQuery(sliderLabelId).text(sliderInitialValue);
		
		jQuery(sliderId).on('slide', function(slideEvt) {
			jQuery(sliderLabelId).text(slideEvt.value);
		});
		
		jQuery(sliderId).on('slideStop', function(slideEvt) {
			saveValueFunction(slideEvt.value);
		});
 	}
 	
 	function cancel(elemId) {
 		var textbox = jQuery('#'+elemId);
 		textbox.attr('readonly', true);
 		textbox.removeClass("editing");
 		textbox.siblings('.edit').show();
 		textbox.siblings('.cancel, .save').hide();
		jQuery(this).hide();
		//Rollback Results 
		textbox.val(textbox.data('prevvalue'));
 	}
 	
 	function save(elemId, isHint) {
 		var textbox = jQuery('#'+elemId);
 		var submit="submit"+elemId+".json";
 		textbox.attr('readonly', true);
 		textbox.removeClass("editing");
 		textbox.siblings('.edit').show();
 		textbox.siblings('.cancel, .save').hide();
 		 jQuery.ajax({
		 	  type: 'POST', 
			  dataType: "json",
			  url: submit,
			  data: elemId+'='+textbox.val(),
			  success: function(data){
				  	if(data.success) {
						  //Save Results
						  if (textbox.val() != textbox.data('prevvalue')) {
						  	textbox.data('prevvalue', textbox.val())
						  }
						  //Open Confirmation of Changes
						  jQuery("#dialogAlert").text(isHint ? msgConfirmHint : msgConfirmBanner);
				  	}
				 	else {
						//Rollback Results 
						textbox.val(textbox.data('prevvalue'));
					  	jQuery("#dialogAlert").text('<fmt:message key="admin.gdpr.errMax" />'+' '+data.error_val);
					  }
					  jQuery("#dialogAlert").css('overflow', 'hidden');
		 			  jQuery("#dialogAlert").dialog({
						  modal:true,
						  height:'auto',
						  width:350,
						  buttons: {
						        Ok: function() {
						          jQuery( this ).dialog( "close" );
						        }
						  }
					  }).dialog('open'); 
	          
			  	}
			});
 	}
 	
 	function edit(elemId) {
 		var textbox = jQuery('#'+elemId);
 		textbox.attr('readonly', false);
 		textbox.addClass("editing");
 		textbox.siblings('.edit').hide();
 		textbox.siblings('.cancel, .save').show();
 	}
 	
 	function initializeGDPR(elemId, text_max) {
 		var feedback = '#'+elemId+'_feedback';
 		var element = jQuery('#'+elemId);
	    jQuery(feedback).html(text_max + msg);
	    element.attr('readonly','readonly');
	    element.keyup(function() {
	        var text_length = element.val().length;
	        var text_remaining = text_max - text_length;

	        jQuery(feedback).html(text_remaining + msg);
	    });
	    element.keyup();
 	}

	var text_banner_max = 500;
	var text_hint_max = 100;
	var msg = ' <fmt:message key="admin.characterLeft"/>';
	var msgConfirmHint = '<fmt:message key="admin.GDPRHintUpdated"/>';
	var msgConfirmBanner = '<fmt:message key="admin.GDPRBannerUpdated"/>';
	jQuery(document).ready(function() {
		initializeSlider('#passwordExpiryTime', 
						 '#passwordExpiryTimeLabel', 
						 <c:out value="${passwordExpiryTime}" />, 
						 savePasswordExpiryTime);
		
		initializeSlider('#maxRecentlyUsedPasswords', 
						 '#maxRecentlyUsedPasswordsLabel', 
						 <c:out value="${maxRecentlyUsedPasswords}" />, 
						 saveMaxRecentlyUsedPasswords);
		initializeGDPR('GDPRHint', text_hint_max);
		initializeGDPR('GDPRBanner', text_banner_max);
	});
	</script>
</head>
<body>
<div id="dialogAlert" style="display:none;overflow: scroll;height:800px" title="System Config"><div><font color="black"></font></div></div>
<c:set var="found" value="${!empty sysConfig}" />
<div class="header">
<h3><fmt:message key="admin.setting" /></h3>
</div>
<!-- Image loader -->
<div id="divSchedule" style="display: none;overflow: scroll;"><fmt:message key="admin.sftp.sync.background"/></div>
<!-- Image loader -->
<form id="form" action="<c:url value="/system/systemConfigEdit.htm" />">
<div class="content">  
<div class="table-responsive">
<div class="panel" >
	<div class="form-group">
		<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.showLegacyId"/>
		</label>

		<div class="col-sm-6">						
			<input id="legacy" name="legacy" type="checkbox" data-size="small" onchange="saveSetting(this);" <c:if test='${legacy}'>checked</c:if>>
		</div>
	</div>

	<div class="form-group">
		<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.autoSync"/>
		</label>

		<div class="col-sm-6">
			<input id="sync" name="sync" type="checkbox" data-size="small" onchange="saveSyncSetting(this);" <c:if test='${sync}'>checked</c:if>>
		</div>
	</div>
	
		<div class="form-group">
		<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.contentAutoDownload"/>
		</label>

		<div class="col-sm-6">
			<input id="autoContent" name="autoContent" type="checkbox" data-size="small" onchange="saveConetntSetting(this);" <c:if test='${autoContent}'>checked</c:if>>
		</div>
	</div>
	
	<div class="form-group">
		<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.submitUserLogin"/>
		</label>

		<div class="col-sm-6">
			<input id="submitUser" name="submitUser" type="checkbox" data-size="small" onchange="saveSubmitUserSetting(this);" <c:if test='${submitUser}'>checked</c:if>>
		</div>
	</div>
	
	<div class="form-group">
		<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.captcha"/>
		</label>

		<div class="col-sm-6">
			<input name="captcha" type="checkbox" data-size="small" onchange="saveCaptchaSetting(this);" <c:if test='${captcha}'>checked</c:if>>
		</div>
	</div>
	
	<div class="form-group">
		<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.setupVerificationExpiryMins"/>
		</label>

		<div class="col-sm-6">
			<select id="emailVerificationExpiryMins" onchange="saveVerificationExpirySetting(this);" >
				<option value="1" <c:if test='${emailVerificationExpiryMins==1}'>selected</c:if>>1 Minute</option>
				<option value="2" <c:if test='${emailVerificationExpiryMins==2}'>selected</c:if>>2 Minutes</option>
				<option value="10" <c:if test='${emailVerificationExpiryMins==10}'>selected</c:if>>10 Minutes</option>
				<option value="60" <c:if test='${emailVerificationExpiryMins==60}'>selected</c:if>>1 Hour</option>
				<option value="360" <c:if test='${emailVerificationExpiryMins==360}'>selected</c:if>>6 Hours</option>
				<option value="1440" <c:if test='${emailVerificationExpiryMins==1440}'>selected</c:if>>24 Hours</option>
				<option value="43200" <c:if test='${emailVerificationExpiryMins==43200}'>selected</c:if>>30 Days</option>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.passwordExpiry.label"/>
		</label>

		<div class="col-sm-6">
			<input id="passwordExpiryTime" type="text" data-slider-min="0" data-slider-max="365" data-slider-step="1"/>
			
			<div class="sliderValue">
				<span id="passwordExpiryTimeLabel"></span>
				<c:if test='${passwordExpiryTimeUnit eq "DAYS"}'>
					<fmt:message key="admin.passwordExpiry.days" />
				</c:if>
				<c:if test='${passwordExpiryTimeUnit eq "MINUTES"}'>
					<fmt:message key="admin.passwordExpiry.minutes" />
				</c:if>
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.maxRecentlyUsed.label" />
		</label>

		<div class="col-sm-6">
			<input id="maxRecentlyUsedPasswords" type="text" data-slider-min="0" data-slider-max="25" data-slider-step="1"/>
			
			<div class="sliderValue">
				<span id="maxRecentlyUsedPasswordsLabel"></span> <fmt:message key="admin.maxRecentlyUsed.passwords" />
			</div>
		</div>
	</div>
	
	<div class="form-group">
		<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.forcePasswordComplexity"/>
		</label>

		<div class="col-sm-6">
			<input name="forcePasswordComplexity" type="checkbox" data-size="small" onchange="savePasswordComplexity(this);" <c:if test='${forcePasswordComplexity}'>checked</c:if>>
		</div>
	</div>
	
	<div class="form-group">
		<label	class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.sftpSync"/>
		</label>

		<div class="col-sm-6">
			<button type="button" class="buttonCss" onclick="syncUserSftp();">
				<fmt:message key="userDomain.synchronise" />
			</button>
		</div>
	</div>  
	
   <div class="form-group">
		<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.forceChange.label" />
		</label>

		<div class="col-sm-6">
			<button type="button" class="buttonCss" onclick="confirmForcePasswordChange();">
				<fmt:message key="admin.forceChange.button" />
			</button>
		</div>
	</div>
	
	<div style="clear: both;"></div>
	
	<div class="form-group textAreaAuto">
		<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.banner.label" />
		</label>
		
		<div>
			<textarea id="GDPRBanner" rows="2" cols="100" maxlength="500" class="editable" data-prevvalue='<c:out value="${GDPRBanner}"/>' ><c:out value="${GDPRBanner}"/></textarea>
		    <input class="edit buttonCss" type="button" value="<fmt:message key='edit' />" onclick="edit('GDPRBanner')" />
		    <input class="save buttonCss" type="button" value="<fmt:message key='save' />" onclick="save('GDPRBanner', false)" /> 
		    <input class="cancel buttonCss" type="button" value="<fmt:message key='cancel' />" onclick="cancel('GDPRBanner')" />
		</div>
		<div id="GDPRBanner_feedback" class="col-sm-5 control-label scannellGeneralLabel rightAlign"></div>
	</div>
	
	<div class="form-group textAreaAuto" >
		<label class="col-sm-3 control-label scannellGeneralLabel rightAlign">
			<fmt:message key="admin.placeholder.label" />
		</label>

		<div>
			<textarea id="GDPRHint" rows="2" cols="100" maxlength="100" class="editable" data-prevvalue='<c:out value="${GDPRHint}"/>'><c:out value="${GDPRHint}"/></textarea>
		    <input class="edit buttonCss" type="button" value="<fmt:message key='edit' />" onclick="edit('GDPRHint')" />
		    <input class="save buttonCss" type="button" value="<fmt:message key='save' />" onclick="save('GDPRHint', true)" /> 
		    <input class="cancel buttonCss" type="button" value="<fmt:message key='cancel' />" onclick="cancel('GDPRHint')" />
		</div>
		<div id="GDPRHint_feedback" class="col-sm-5 control-label scannellGeneralLabel rightAlign"></div>
	</div>
			
	<div style="clear: both;"></div>

	<div class="spacer2 text-center">
		<button type="button" class="g-btn g-btn--primary" onclick="history.back()">
			<fmt:message key="back" />
		</button>
	</div>
</div>
</div>
</form>
</body>
</html>
