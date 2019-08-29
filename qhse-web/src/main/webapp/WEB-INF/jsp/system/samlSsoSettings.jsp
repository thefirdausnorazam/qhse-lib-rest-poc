<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
	<script type='text/javascript' src="<c:url value="/js/common.js"/>"></script>
	<script type='text/javascript' src="<c:url value="/js/css.js"/>"></script>
	<script type='text/javascript' src="<c:url value="/js/standardista-table-sorting.js"/>"></script>
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
</style>
	 <script type="text/javascript">
 function getMetaData(){
	 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "getSAMLMetaData.json",
		  data: '',
		   beforeSend: function(){
			   jQuery("#divSchedule").dialog({show: "slide", modal: true, autoOpen: false, height:800});
			   jQuery("#divSchedule").dialog("open"); 
			   },
		  success: function(data){
			  jQuery("#divSchedule").dialog('close');
			  var samlMetaData = data.metadata;
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").text(samlMetaData);
			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:800,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
			  
         
		  },
		  error: function(xhr, textStatus, errorThrown){
			  jQuery("#divSchedule").dialog('close');
			  var autoContent = '<fmt:message key="admin.saml.metadata.fail"/><br>';
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append(autoContent);
			  jQuery("#dialogAlert").dialog({
				  modal:true,
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
 
 function getSampleSamlConf(){
	 jQuery.ajax({
	 	  type: 'POST', 
		  dataType: "json",
		  url: "getSampleSamlConf.json",
		  data: '',
		   beforeSend: function(){
			   jQuery("#divSchedule").dialog({show: "slide", modal: true, autoOpen: false, height:800});
			   jQuery("#divSchedule").dialog("open"); 
			   },
		  success: function(data){
			  jQuery("#divSchedule").dialog('close');
			  var samlMetaData = data.metadata;
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").text(samlMetaData);
			  jQuery("#dialogAlert").dialog({
				  modal:true,
				  height:800,
				  buttons: {
				        Ok: function() {
				          jQuery( this ).dialog( "close" );
				        }
				  }
				  }).dialog('open'); 
			  
         
		  },
		  error: function(xhr, textStatus, errorThrown){
			  jQuery("#divSchedule").dialog('close');
			  var autoContent = '<fmt:message key="admin.saml.metadata.fail"/><br>';
			  jQuery("#dialogAlert").text('');
			  jQuery("#dialogAlert").append(autoContent);
			  jQuery("#dialogAlert").dialog({
				  modal:true,
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
 </script>
  <script>
  function uploadMetaData(){
            var url = "uploadSamlSsoSetting.jason";
            //var form = jQuery("#samlForm")[0];
            var form = document.getElementById("samlForm");
            var data = new FormData(form);
            /* var data = {};
            data['key1'] = 'value1';
            data['key2'] = 'value2'; */
            jQuery.ajax({
                type : "POST",
                encType : "multipart/form-data",
                url : url,
                cache : false,
                processData : false,
                contentType : false,
                data : data,
                success : function(data) {
    			  var autoContent = '<fmt:message key="admin.saml.ip.metadata.success"/>';
    			  jQuery("#dialogAlert").text('');
    			  jQuery("#dialogAlert").text(autoContent);
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
                error : function(data) {
                 var autoContent = '<fmt:message key="admin.saml.ip.metadata.fail"/>';
      			  jQuery("#dialogAlert").text('');
      			  jQuery("#dialogAlert").text(autoContent);
      			  jQuery("#dialogAlert").append( '<br> <a target="scannell_help"	href="https://scannellsaas.com/q-pulse-contact"><fmt:message key="menu.contactInfo" /></a>' );
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
</script>
</head>

<body>
	<%
		String url = request.getRequestURL().toString();
		String contextPath = request.getContextPath().toString();
		String finalUrl = url.substring(0, url.indexOf(contextPath))+contextPath;
	%>
<div id="dialogAlert" style="display:none;overflow: scroll;height:800px" title="SAML Config"><div><font color="black"></font></div></div>
<div class="header">
<h2><fmt:message key="admin.samlSsolSettings" /></h2>
</div>
<a name="user"></a>
<div style="padding-top: 1%;">
<scannell:url urls="${urls}" />
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered sortable'>
     <tr>
		<th><fmt:message key="admin.saml.metadata" /></th>
		<td><button type="button" <fmt:message key="admin.saml.upload" /> class="buttonCss" onclick="getMetaData();"><fmt:message key="admin.saml.metadata.show" /></button></td>
	</tr>
	<tr>
		<th><fmt:message key="admin.saml.ip.metadata.sample" /></th>
		<td><button type="button" class="buttonCss"	onclick="getSampleSamlConf();">	<fmt:message key="admin.saml.ip.metadata.sample.show" /> </button></td>
	</tr>
	<tr>
		<th><fmt:message key="admin.saml.assertion.consumer.service.url" /></th>
		<td><%= finalUrl %>/samlssoresponse/login</td>
	</tr>
	<tr>
		<th><fmt:message key="admin.saml.assertion.consumer.service.binding" /></th>
		<td>urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST</td>
	</tr>
	<tr>
		<th><fmt:message key="admin.saml.service.entity" /></th>
		<td><%= finalUrl %>/samlmetadata/login</td>
	</tr>
</table>
</div>
<div class="alert alert-danger">
  <strong><fmt:message key="warning" /></strong> <fmt:message key="admin.saml.ip.metadata.warning" />
  <a target="scannell_help"	href="https://scannellsaas.com/q-pulse-contact"><fmt:message key="admin.menu.contactInfo" /></a>
</div>
<div class="panel">
<form id="samlForm" method="POST" action="uploadSamlSsoSetting.jason" enctype = "multipart/form-data">
				<div class="form-group">
						<label
							class="col-sm-3 control-label scannellGeneralLabel rightAlign">
							<fmt:message key="admin.saml.ip.metadata.upload" />
						</label>

						<div class="col-sm-6">
							<input type="file" style="float: centre" name="metadataFile"	id="metadataFile" />
							<button type="button" class="buttonCss" style="align: right"	onclick="uploadMetaData();"><fmt:message key="admin.saml.upload" /></button>
						</div>
					</div>
					<div style="clear: both;"></div>
				</form>
<div id="divSchedule" style="display: none;overflow: scroll;"><fmt:message key="admin.sftp.sync.background"/></div>
</div>
</div>
</div>
</body>
</html>
