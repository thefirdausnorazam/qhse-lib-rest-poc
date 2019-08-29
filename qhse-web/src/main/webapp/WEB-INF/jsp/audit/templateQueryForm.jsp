<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<!-- <meta name="printable" content="true"> -->
	<title></title>
    <style type="text/css">
    td.search {    
    padding-right: 10% !important;
    }
    td.searchLabel {    
    padding-right: 0% !important;
    }
    
    </style>
	
	<script type="text/javascript">
    jQuery(document).ready(function() {		
		jQuery('#queryForm').submit();
		jQuery('#active').select2({width:'100%'});
		jQuery('#activeInSiteId').select2({width:'100%'}); 		
		toggleQueryTable();
		
	 });
    
    function hardResetForm(form) {
	jQuery('#active').select2({width:'100%'}).select2('val', jQuery('#active option:eq(1)').val());
	}
	
    function trimDescription(){
    	jQuery("#name").val(jQuery.trim(jQuery("#name").val()));
   	}	
	
	</script>
	
</head>
<body>

<div class="col-md-12">
	<div id="block" class="">
		<div>
		    <div style="padding-left:0px;" class="col-md-6">
			</div>
		    <div class="col-md-12 col-sm-12">
		    	<div align="right">
		     <form action="<c:url value="/audit/templateView.htm" />" method="get" onSubmit="if(!jQuery('#gotoId')) return false;">
			    <fmt:message key="audit.templateQueryForm.goTo"/>
			    <input type="text" id="gotoId" name="id" size="3"><input type="submit" class="g-btn g-btn--primary" value="Go">
			    <button type="button" class="g-btn g-btn--primary" id="queryTableToggleLink" onclick="toggleQueryTable();">&nbsp;Hide Search</button>
					<c:if test="${addButtonEnabled == true }">
						<button type="button" class="g-btn g-btn--primary" onclick="location.href='templateEdit.htm'"><i class="fa fa-edit" style="color:white"></i>&nbsp;<fmt:message key="templateCreate" /></button>
					</c:if>
				<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
			  </form>
		  		</div>
		 	</div>
		</div>
		<input type="text" id="refreshCheck" value="no" style="display: none;">
	</div>
</div>


<div class="content" >

			<form id="queryForm"  class="form-horizontal group-border-dashed" style="border-radius: 0px;"  action="<c:url value="/audit/templateQuery.htmf" />" onSubmit="return search(this, 'resultsDiv'); ">
						<input type="hidden" name="calculateTotals" value="true" />
						<input type="hidden" name="pageNumber" value="1" />
						<input type="hidden" id="pageSize" name="pageSize"/>
								
						<div id="queryTable">
						<div id ="queryTableTitle" class="header">
							<h3 ><fmt:message key="searchCriteria" /></h3>
						</div>	
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="name" /></label>
									<div class="col-sm-6">
										<input type="text"  id="name" name="name"  class="form-control"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel"><fmt:message key="active" /></label>
									<div class="col-sm-6">
										<select id="active" name="active" class="narrow" style="min-width:100px">
				                        <option></option>
				                        <option  value="true" selected="selected"><fmt:message key="true" /></option>
				                        <option value="false"><fmt:message key="false" /></option>
			                            </select>	
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="template.activeInSites" /></label>
									<div class="col-sm-6">
										<select id="activeInSiteId" name="activeInSiteId" class="wide">
	          	                        <option value=""><fmt:message key="choose" /></option>
	                                    <c:forEach items="${sites}" var="site">
            	                         <option value="${site.id}" <c:if test="${currentSite.id == site.id}">selected</c:if>><c:out value="${site.name}" /></option>
          	                            </c:forEach>	      
	                                   </select>	
									</div>
								</div>
								
								<div class="spacer2 text-center">
			                     <button type="submit" class="g-btn g-btn--primary" onClick="this.form.pageNumber.value = 1;displayQueryTable(false);trimDescription();"><fmt:message key="search" /></button>
			                   <button type="reset"  class="g-btn g-btn--secondary" onclick="hardResetForm(this.form);"><fmt:message key="reset" /></button>
			                  </div>
			                  
			                  
						</div>	
						<div id="resultsDiv"></div>
				</form>
						

 </div>
 

</body>
</html>
