<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
	<c:if test="${showLegacyId}">
  		<script type="text/javascript" src="<c:url value="/js/removeKeyboardClick.js" />"></script>
  	</c:if>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script language="javascript" type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type="text/javascript">
		jQuery(document).ready(function(){
			jQuery('#queryForm').addClass('form-horizontal group-border-dashed');
			  jQuery('#businessAreaId').select2({width:'100%'});
			  jQuery('#sortName').select2({width:'100%'});
			  jQuery('#status').select2({width:'100%'});
			  if('${quickLink}' != '') {
				  	clearForm();
					if('${selectedStatus}' != '') {
						jQuery('#status').val('${selectedStatus}');
						jQuery('#status option[value="${selectedStatus}"]').change();
					}
			  }
			  jQuery('#queryForm').submit();
			  toggleQueryTable();
		  });
	
		var displayText = "<fmt:message key="search.displaySearchCriteria"/>";
		var hideText = "<fmt:message key="search.hideSearchCriteria"/>";
		
		/*function toggleQueryTable() {
			$('queryTableToggleLink').innerHTML = $('queryTable').visible() ? displayText : hideText;
			$('queryTable').visible() ? Effect.Fade('queryTable') : Effect.Appear('queryTable');
		}*/
		
		function clearForm(){
			jQuery('#businessAreaId').select2({width:'100%'}).select2('val', jQuery('#businessAreaId option:eq(0)').val());
			jQuery('#sortName').select2({width:'100%'}).select2('val', jQuery('#sortName option:eq(0)').val());
			jQuery('#status').select2({width:'100%'}).select2('val', jQuery('#status option:eq(0)').val());
		    var inputs = document.getElementById('queryForm').getElementsByTagName('input');
		    for (var i = 0; i<inputs.length; i++) {
		        switch (inputs[i].type) {
		          case 'text':
		                inputs[i].value = '';
		                break;
		        }
		    }
	    
		}
		
		function getObjects(){
			//jQuery('#goToForm').attr('action', '${pageContext.request.contextPath}' +'/audit/legacyId.htm').submit();
			jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/audit/planQuery.htmf?searchByLegacyId=true&legacyId='+jQuery('#gotoLegacyId').val()).submit();
			jQuery('#queryForm').attr('action', '${pageContext.request.contextPath}' +'/audit/planQuery.htmf');
		}

	</script>
</head>
<body>

<div class="col-md-12">
	
	<div id="block" class="">
		<div >
		    <div style="padding-left:0px;" class="col-md-6">
			</div>
		    <div class="col-md-12 col-sm-12">
		    	<div align="right">
		    <form id="goToForm" action="<c:url value="/audit/planView.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
		       <input type="hidden" name="page" value="plan"/>
		       <c:if test="${showLegacyId}">
		        <label>Legacy ID</label> 
		        <input type="text" id="gotoLegacyId" name="legacyId" size="12"><input type="button" class="g-btn g-btn--primary" value="Go" onclick="getObjects();">
			   </c:if>
			    <fmt:message key="audit.planQueryForm.goTo" />
			    <input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
			    <button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryTable();">&nbsp;Display Search</button>
					<c:if test="${addButtonEnabled == true }">
						<button type="button" class="g-btn g-btn--primary" onclick="location.href='planEdit.htm'"><i class="fa fa-edit" style="color:white"></i>&nbsp;<fmt:message key="auditPlanCreate" /></button>
					</c:if>
			  </form>

		  		</div>
		 	</div>
		</div>
		<input type="text" id="refreshCheck" value="no" style="display: none;">
	</div>
</div>

<div id="block" class="block" > 
	
	
<!--  
<div class="pull-right">
  	<form action="<c:url value="/audit/planView.htm" />" method="get" onsubmit="if(!jQuery('#gotoId')) return false;">
  		<fmt:message key="audit.planQueryForm.goTo" />
  		<input type="text" id="gotoId" name="id" size="3"><input type="submit" value="Go">
  	</form>
  	</div>
 <div style="text-align:right;"> 
<a href="#" id="queryTableToggleLink" onclick="toggleQueryTable();"><fmt:message key="search.displaySearchCriteria"/></a>
  <c:if test="${urls != null}">
  | <scannell:url urls="${urls}" />
  </c:if>
  </div>
  -->

 <scannell:form  id="queryForm" action="/audit/planQuery.htmf" onsubmit="return search(this, 'resultsDiv', false, true);">
 <scannell:hidden path="calculateTotals" />
 <scannell:hidden path="pageNumber" />
 <scannell:hidden path="pageSize" />
 
 <input type="hidden" name="currentUser" id="currentUser" value="${currentUser}"/>
  <div class="content" id ="queryTable">
<div id ="queryTableTitle" class="header">
	<h3><fmt:message key="searchCriteria" /></h3>
</div>
                               <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="businessArea" /></label>
									<div class="col-sm-6">
										 <select name="businessAreaId" id="businessAreaId" items="${businessAreaList}" itemLabel="name" itemValue="id"  />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="audit.yearFrom" /></label>
									<div class="col-sm-6">
									<input type="text" name="year" id="year" class="form-control" />											
									</div>
								</div>
								 <div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="audit.yearTo" /></label>
									<div class="col-sm-6">
										<input type="text" name="yearEnd" id="yearEnd" class="form-control"/>
									</div>
								</div> 
							<div class="form-group">
								<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="status" /></label>
								<div class="col-sm-6">
									<select name="status" id="status" class="wide" >
                       			 	<scannell:option value="IN_PROGR" labelkey="IN_PROGR" />
                        			<scannell:option value="COMPLETE" labelkey="COMPLETE" />
                        			<scannell:option value="TRASH" labelkey="TRASH" />
                        			</scannell:select>
								</div>
							</div>
							<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="sortName" /></label>
									<div class="col-sm-6">
										<select name="sortName" id="sortName">
				                        <c:forEach items="${sorts}" var="item">
					                    <option value="<c:out value="${item}" />"><fmt:message key="${item}" /></option>
				                        </c:forEach>
			                           </select>
									</div>
								</div> 
								
								<div class="spacer2 text-center">
			                     <button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryTable(false);"><fmt:message key="search" /></button>
			                     <button type="reset" class="g-btn g-btn--secondary" onClick="clearForm();"><fmt:message key="reset" /></button>
			                  </div>
			                  
			                  
			                  

</div>
<div id="resultsDiv"></div>
</scannell:form>

</div>
 

<script type="text/javascript">
displayQueryTable(false); 
</script>
</body>
</html>
