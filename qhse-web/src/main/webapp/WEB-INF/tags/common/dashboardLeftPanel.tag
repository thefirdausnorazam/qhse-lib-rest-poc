<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="viewType" required="false" type="java.lang.String" %>
<%@ attribute name="currentYear" required="false" type="java.lang.String" %>
<%@ attribute name="yearList" required="false" type="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<script language="javascript" type="text/javascript">
		// The context path is needed in /js/site.js
		jQuery(document).ready(function() {			
			 jQuery('#siteLoc').select2({width:'100%'});
			 jQuery('#dashYear').select2({width:'100%'});
			 jQuery('#businessAreaId').select2({width:'100%'});
			 jQuery('.dashDiv').hide();
			/* 	function dateGenerate() {
					   var date = new Date(), dateArray = new Array(), i;
					   curYear = date.getFullYear();
					    for(i = 0; i<10; i++) {
					        dateArray[i] = curYear-i;
					    }
					    return dateArray;
					}
				var optionsAsString = "";
				 var dates = dateGenerate();
				 
				 jQuery.each(dates, function(index, item) {	
					 if(index==0){
						 
						 jQuery('#da').attr("value",item).text(item); 
					 }else{
					 optionsAsString += "<option  value='" + item + "' selected>" + item + "</option>";		
					 }
					
						 //jQuery('#dashYear').append( new Option(item,index) );				 
					    // do something with `item` (or `this` is also `item` if you like)
					});
				 
				 jQuery("#dashYear").append( optionsAsString );
				 
				 
				// jQuery(".dash option:first").attr('selected','selected'); */
		});
		

	function sort(menu) {
		jQuery('.select2-search-choice').each(function() {
		    var txt1 = jQuery(this).text();
		    jQuery(this).data('name', txt1);
		});
		
		var items = jQuery('.select2-search-choice');
		items.sort(function(a, b) {
		    var chA = $(a).data('name');
		    var chB = $(b).data('name');
		    if (chA < chB) return -1;
		    if (chA > chB) return 1;
		    return 0;
		});
		var grid = jQuery('.select2-choices');
		jQuery(grid).prepend(items);
		}
	</script> 
	
<style type="text/css" media="all">
.hidden
{
  display:none;
}
</style>

<div id="dashBoardPanelDiv" class="page-aside app filters dashDiv">
      <div>
        <div class="content">
          <button class="navbar-toggle" data-target=".app-nav" data-toggle="collapse" type="button">
            <span class="fa fa-chevron-down"></span>
          </button>         
          <div class="header">
          
          </div> 
          <!-- <h2 class="page-title">Criteria</h2> -->
          <!-- <p class="description">Service description</p> -->
          
        </div>        
        <div class="app-nav collapse">
          <div class="content">
          <div class="form-group">
            <button class="btn btn-primary" id="reload" ><fmt:message key="reload" /></button>
            </div>
            <div class="hidden">
              <label class="control-label">Year</label>
              <select id="dashYear" class="dash">   
              <c:forEach items="${yearList}" var="year">
               <c:remove var="selected" />
               <c:if test="${year == currentYear}"><c:set var="selected" value="selected=true" /></c:if>
               <option value="<c:out value="${year}" />" <c:out value="${selected}" /> title="<c:out value="${year}" />"><c:out value="${year}" /></option>
              </c:forEach>        
              </select>	
            </div>
            
              <div class="hidden">
              <label class="control-label"><fmt:message key="businessArea" /></label>
              <c:if test="${businessAreaList != null}"> 
               <select id="businessAreaId" class="businessAreaId">   
               <option value="0" >Choose</option>      
               <c:forEach items="${businessAreaList}" var="businessAreaList">
                <option value="<c:out value="${businessAreaList.id}" />"  title="<c:out value="${businessAreaList.name}" />"><c:out value="${businessAreaList.name}" /></option>
               </c:forEach>    
             <%--  <scannell:select path="businessAreaId" id="businessAreaId" items="${businessAreaList}" itemLabel="name" itemValue="id" renderEmptyOption="true" cssStyle="width:100%" />  --%>
              </select>
              </c:if>
           </div> 
          
          <div class="form-group">
              <label class="control-label"><fmt:message key="dashboardSites" /></label>
              <select id="siteLoc" onChange="sort(this)" style="width: 150px; font-size: 12px;"   multiple>
              <c:choose>
              	<c:when test="${not empty user.sites}">
	              <c:forEach items="${user.displaySites}" var="item">
	                <c:remove var="selected" />
	               <%--  <c:if test="${site.id == item.id}"></c:if> --%>
	                <option selected value="<c:out value="${item.id}" />"  title="<c:out value="${item.name}" />"><c:out value="${item.name}" /></option>
	              </c:forEach>
	             </c:when>
	             <c:when test="${module == 'law'}">
		              <c:forEach items="${viewableSites}" var="item">
	                	<c:remove var="selected" />
	                	<c:if test="${siteSelected.id == item.id}"><c:set var="selected" value="selected=true" /></c:if>
		                <option value="<c:out value="${item.id}" />" <c:out value="${selected}" /> title="<c:out value="${item.name}" />"><c:out value="${item.name}" /></option>
		              </c:forEach>
	             </c:when>
              </c:choose>
              </select>  
            </div> 
         
           
            
          
          </div>

          
        </div>
      </div>
		</div>