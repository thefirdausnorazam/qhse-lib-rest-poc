<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="questionEdit" />
<c:if test="${command.id == null}">
	<c:set var="title" value="questionCreate" />
</c:if>
<title></title>
<script type='text/javascript' src="<c:url value="/js/showHelp.js" />"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {	
		setActiveTrue();
		var counter = 0;
		var data;
		jQuery('select').select2({        
                placeholder: "Choose",
                alowClear:true});

		checkRequiredToggle();
		var table = jQuery('#options').DataTable({ 
				"bPaginate": false,
				"bFilter": false,
			    "bInfo": false,
			    "order": [],
			    "aaSorting": [],
			    "oLanguage": {
			    	"sEmptyTable": "",
			    	"sZeroRecords":""
			    	 },
			    "columnDefs": [{
			        targets: "datatable-nosort",
			        orderable: false,
			        bsort: false
			    },{
			        targets: "natural-sort",
			        sType: "natural"
			    }]

			});
		var counter=0;
	    jQuery('#addRow').on( 'click', function () {
	    	jQuery('#options').hide();

	        var row_data = [];
	        var orginal = jQuery('#options').find('tbody tr:last');
	        orginal.find('select').each(function() {
    			jQuery(this).select2("destroy");
    		});
	        var cloned = orginal.clone();
	        var rowCount = jQuery('#options tr.optionRow').length;  //Remove header and footer
	        cloned.attr('id','opt-'+rowCount)
	        //get original selects into a jq object
	        var originalSelects = orginal.find('select');
	        cloned.find('select').each(function(index, item) {
	             //set new select to value of old select
	             jQuery(item).val( originalSelects.eq(index).val() );
	        });
	        cloned.find('td').each(function(index, item) {
	        	jQuery(this).find("input[type='hidden']").remove();
	        	if(jQuery(this).find('select,input').length > 0)
		        {
		        	var id = jQuery(this).find('select,input').attr('id');
		        	id = id.replace("["+(rowCount-1)+"]", "["+rowCount+"]");
		        	var name = jQuery(this).find('select,input').attr('name');
		        	if(name != undefined)
		        	{
			        	name = name.replace("["+(rowCount-1)+"]", "["+rowCount+"]");
			        	jQuery(this).find('select,input').attr("name", name);        		
		        	}
		        	jQuery(this).find('select,input').attr("id", id);
		        	jQuery(this).find('input[id^="name"]').val('');
		        	jQuery(this).find('input[id^="optionActive"]').prop('checked', true);
		        	jQuery(this).find('select option[value=""]').remove();
		        	jQuery(this).find('.fa-times').remove();
		        	jQuery('#removeButton'+(rowCount-1)).hide();
		        	if(id.match("^dependsOptions")){
		        		var td = jQuery(this).last('td');
		        		if(! jQuery('i', td).length>0){
		        		jQuery(this).last('td').append('<i class="fa fa-times" id="removeButton'+rowCount+'" style="color: #13ab94" onclick="removeTr('+(rowCount)+')"></i>');
		        		}
		        	}
	        	}	
	        });
	        cloned.appendTo('#options');

	        jQuery('#options').find('tbody').last('tr').find('td').find('select').select2({               
                placeholder: "Choose",
                alowClear:true
            }); 

	    	jQuery('#options').fadeIn(1000);
	        location.hash = "#addRow";
	    } );
	    
    
		var optionImpl = document.getElementById("optionDiv");
		if(optionImpl){
			optionImpl.style.display='none';
			document.getElementById("dependsOnQuestionsDiv").style.display='none';
		}

		jQuery('#dependsOnQuestion').change(function() {
			populateDependsOnOptions(jQuery('#dependsOnQuestion option:selected').val());
		});
	    jQuery('#answerType').change(function(){
	    	var optionValue = jQuery(this).children('option:selected').attr('value');
	    	jQuery('#required').removeAttr("disabled");
	    	jQuery('#dependsOnQuestion').attr("disabled", true);
	    	jQuery('#dependsOnCheckbox').attr("disabled", "true");
	    	
    	   	if (optionValue.match("^option")) 
    	   	{
    	       jQuery('#dependsOnQuestion').attr("disabled", false);
    		   jQuery('#optionDiv').fadeIn(500);
    		   jQuery("#dependsOnCheckboxQuestionsDiv").fadeOut(5);
    		   jQuery("#dependsOnQuestionsDiv").fadeIn(500);
    	   	}
    	   	else if (optionValue.match("^checkbox")) 
    	   	{
      		   jQuery('#required').attr("checked", false);
     		   jQuery('#required').attr("disabled", true);
     		   jQuery('#optionDiv').fadeOut(500);
    		   jQuery("#dependsOnQuestionsDiv").fadeOut(500);
    		   jQuery("#dependsOnCheckboxQuestionsDiv").fadeOut(500);
     	   	}
    	   	else if (optionValue.match("^text")) 
    	   	{
   	    	   jQuery('#dependsOnCheckbox').attr("disabled", false);
     		   jQuery('#optionDiv').fadeOut(500);
    		   jQuery("#dependsOnQuestionsDiv").fadeOut(5);
    		   jQuery("#dependsOnCheckboxQuestionsDiv").fadeIn(500);
     	   	}
    	   	else
    	   	{
     		   jQuery('#optionDiv').fadeOut(500);
    		   jQuery("#dependsOnQuestionsDiv").fadeOut(500);
    		   jQuery("#dependsOnCheckboxQuestionsDiv").fadeOut(500);
    		}

	    }).change();
	});
	
	   function removeTr(rowCount){  
		   jQuery('#opt-'+rowCount).remove();
		   jQuery('#removeButton'+(rowCount-1)).show();
	   }
	   
	function populateDependsOnOptions(qid)
	{
		var url='listQuestionOptions.json?questionId='+qid;
		jQuery('select[id^="dependsOptions["]').find("option:selected").prop("selected", false);
		jQuery('select[id^="dependsOptions["]').each(function() {
				jQuery(this).find("option:selected").prop("selected", false);
			});
		jQuery('select[id^="dependsOptions["]').empty();

		  jQuery("select[id^='dependsOptions[']").select2().select2('val', jQuery('select[id^="dependsOptions["] option:eq(0)').val());
	    jQuery.getJSON(url, function(d) {	
	    	 for (i = 0; i < d.length; i++) {
	   			jQuery('select[id^="dependsOptions["]').each(function() {
	   				jQuery(this).append("<option id='"+d[i].id+"' value='"+d[i].id+"'>"+d[i].name+"</option>");
	   			});
			 }
  		}); 
	}
	
	function onRequiredToggle() {
		var requiredToggle = document.getElementById("required");
		
		if (requiredToggle.checked) {
			document.getElementById("furtherInfo").value = "required=true";
			
		} else {
			document.getElementById("furtherInfo").value = "";
		}
	}
	function checkRequiredToggle() {
		var furtherInfo = document.getElementById("furtherInfo");
		var requiredToggle = document.getElementById("required");
		
		if (furtherInfo.value.indexOf("required") > -1) {
			requiredToggle.checked = true;
		} else {
			requiredToggle.checked = false;
		}
	}
	function onPageSubmit(aForm) {
		if (jQuery("#answerType").children('option:selected').attr('value').match("^option")) {
			var rows = jQuery('#options tr.optionRow');
			jQuery('#optionLen').val(rows.length);
		}
		else {
			jQuery('#options').remove();
			jQuery('#optionLen').val(0);
		}
		jQuery('select[id^="activeInSite"]').each(function() {
			if(jQuery(this).val() == null) {
				jQuery(this).append( new Option("","",false,true) );
			}
		});
		jQuery('select[id^="dependsOptions"]').each(function() {
			if(jQuery(this).val() == null) {
				jQuery(this).append( new Option("","",false,true) );
			}
		});
	}
	function setActiveTrue()
	{
		if(jQuery("#id").val() == 0)
		{
			document.getElementById("active").checked = true;
			document.getElementById("activeDiv").style.display='none';
		}
	}
</script>
<style type="text/css">
td.searchLabel {
width: 35%;
</style>
</head>
<body>
<div class="header">
<h2><fmt:message key="${title}" /></h2>
</div>
<scannell:form onsubmit="onPageSubmit(this);">
	<scannell:hidden id="id" path="id" />
	<scannell:hidden path="version" />
	<input type="hidden" id="optionLen" name="optionLen" value="" />

<div class="content">
<div class="table-responsive">
<div class="panel">
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="questionUniqueName" /></label>						
			<div class="col-sm-6"><input name="codeName" class="form-control" cssStyle="width:90%;display: inline-block;"/></div>
			<img id="showIncidentSeverity" src="<c:url value="/images/help_small.gif"/>"
														data-toggle="tooltip" data-original-title='<fmt:message key="questionUniqueName.help"/>' />
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="name" /></label>
			<div class="col-sm-6"><input name="name" class="form-control" cssStyle="width:90%;display: inline-block;"/></div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="tooltip" /></label>
			<div class="col-sm-6"><input name="tooltip" class="form-control" cssStyle="width:90%;display: inline-block;"/></div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="clientQuestionMandatory" /></label>
			<div class="col-sm-6">
				<scannell:hidden id="furtherInfo" path="furtherInfo"/>
				<input type="checkbox" id="required" onclick="onRequiredToggle()">
			</div>
		</div>
		<div style="clear: both;"></div>
		<div id="activeDiv" class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="active" /></label>
			<div class="col-sm-6"><scannell:checkbox id="active" path="active" /></div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="questionAnswerType" />:</label>
			<div class="col-sm-6"><select name="answerType" id="answerType" items="${answerTypes}"
				itemValue="name" lookupItemLabel="true" class="wide" cssStyle="width:40%" /></div>
		</div>
		<div style="clear: both;"></div>
		
		<div id="dependsOnQuestionsDiv" class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="dependsOnQuestions" />:</label>
			<div class="col-sm-6"><select name="dependsOnQuestion" id="dependsOnQuestion" items="${questions}"
				itemValue="id" itemLabel="displayName" lookupItemLabel="true" class="wide" cssStyle="width:90%"/></div>
		</div>
		<div id="dependsOnCheckboxQuestionsDiv" class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="dependsOnCheckbox" />:</label>
			<div class="col-sm-6"><select name="dependsOnQuestion" id="dependsOnCheckbox" items="${checkboxQuestions}"
				itemValue="id" itemLabel="displayName" lookupItemLabel="true" class="wide" cssStyle="width:90%"/></div>
		</div>
		<div style="clear: both;"></div>
		<div id="optionDiv" class="form-group-large">
    	 	<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align:right;"><fmt:message key="options"/>:</label>
	      	<div class="col-sm-12">
			      <table id="options" class='table table-responsive table-bordered'>
				      	<thead>
				      		<tr>
					      		<th class="datatable-nosort"><fmt:message key="active" /></th>
					      		<th class="datatable-nosort"><fmt:message key="InActiveInSite" /></th>
					      		<th class="datatable-nosort" style="width:60%"><fmt:message key="name" /></th>
					      		<th class="datatable-nosort dependsOn"><fmt:message key="dependsOnOptions" /></th>
					      	</tr>
				      	</thead>
				      	<tbody>
				      		<spring:bind path="command.options">
				      		<c:choose>
				      			<c:when test="${!empty command.options}">
						      		<c:forEach items="${command.options}" var="option" varStatus="s">
										<tr id="opt[${s.index}]" class="optionRow">
								      	 	<td><scannell:checkbox path="options[${s.index}].activeIgnoreSite" id="activeOption[${s.index}]" /></td>
											<td>
								      	 		<select name="options[${s.index}].inactiveInSites" id="activeInSites[${s.index}]"
													size="2" multiple="true" renderEmptyOption="false" itemValue="id" itemLabel="name" items="${sites}">
												</scannell:select>
											</td>
								      	 	<td><input name="options[${s.index}].name" id="name[${s.index}]" class="form-control" cssStyle="width:90%;display: inline-block;" writeRequiredHint="true" /><span class="requiredHinted">*</span></td>
								      	 	<td class="dependsOn">
								      	 		<c:choose>
								      	 			<c:when test="${!empty command.dependsOnQuestion.activeOptionsIgnoreSite}">
								      	 				<select name="options[${s.index}].dependsOnOptionsOption" id="dependsOptions[${s.index}]"
															size="5" multiple="true" renderEmptyOption="false" itemLabel="name"  itemValue="id" items="${command.dependsOnQuestion.activeOptionsIgnoreSite}"/>
													</c:when>
													<c:otherwise>
								      	 				<select name="options[${s.index}].dependsOnOptionsOption" id="dependsOptions[${s.index}]"
															size="5" multiple="true" renderEmptyOption="false" itemLabel="name"  itemValue="id"/>
													</c:otherwise>
												</c:choose>
											</td>
								      	 </tr>
									</c:forEach>
								</c:when>
								<c:when test="${optionType == null}">
									<tr id="opt[0]" class="optionRow">
								      	 	<td><input id="activeOption[0]" name="options[0].activeIgnoreSite" type="checkbox" checked="checked"/></td>
											<td>
								      	 		<select id="activeInSites[0]" name="options[0].inactiveInSites" multiple="multiple">
								      	 			<c:forEach items="${sites}" var="site">
														<option value="<c:out value="${site.id}" />"
															<c:if test="${inactiveInSites.site.id == site.id}">selected="selected"</c:if>>
														<c:out value="${site}" /></option>
													</c:forEach>
								      	 		</select>
												
											</td>
								      	 	<td><input id="name[0]" name="options[0].name" class="form-control" style="width:90%;display: inline-block;" type="text" /><span class="requiredHinted">*</span></td>
								      	 	<td class="dependsOn">
								      	 		<select id="dependsOptions[0]" name="options[0].dependsOnOptionsOption" size="2" multiple="multiple"><option value=""></option></select>							
											</td>
								      	 </tr>
								</c:when>
							</c:choose>
							</spring:bind>
						</tbody>
						<tfoot>
							<tr style="align:right"><td colspan="4" style="text-align: right;">
								<a id="addRow" href="javascript:void(0);"><fmt:message key="question.addOption"/></a>
							</td></tr>
						</tfoot>
			      </table>
	      </div>
		</div>
		<div style="clear: both;"></div>
		<div class="form-group" style="min-height:150px">
    	 	<label class="col-sm-3 control-label scannellGeneralLabel nowrap" style="text-align: right;"><fmt:message key="modules"/>:</label>
	      	<div class="col-sm-6">
	      		<select id="modules" name="modules" multiple="multiple" style="width:90%">
      	 			<c:forEach items="${modules}" var="module">
      	 				<c:set var="selected" value="${false}" />
						<c:forEach items="${command.modules}" var="selectedModule">
							<c:if test="${module.id == selectedModule.id}"><c:set var="selected" value="${true}" /></c:if>
						</c:forEach>
						<option value="<c:out value="${module.id}" />"
							<c:if test="${selected}">selected="selected"</c:if>>
							<fmt:message key="${module.name}" />
						</option>
					</c:forEach>
      	 		</select>
	      </div>
		</div>
		
		<div class="help" id="help" style="display: none;display: inline-block;"></div>
		
		<div class="spacer2 text-center">
			<input class="g-btn g-btn--primary" type="submit"
					value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
		</div>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
