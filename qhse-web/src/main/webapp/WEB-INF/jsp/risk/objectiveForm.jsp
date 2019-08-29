<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html">
<html>
<head>
  <title><fmt:message key="objectiveForm.title" /></title>
  
  <script type='text/javascript' src="<c:url value="/dwr/interface/RiskDWRService.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
  <script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <script type="text/javascript">
  jQuery(document).ready(function() {	
	  jQuery("select").select2();
	  jQuery(".date").find(".requiredHinted").remove();
	  
  });
  
  function onChangeBusinessArea() {
    var element =  document.getElementById('category');
    var selectedValue = jQuery('#'+element.id+' option:selected').text();
    DWRUtil.removeAllOptions(element.id);
    DWRUtil.addOptions(element.id, {"":"Please Wait..."});
    var val = [];
    jQuery('#businessAreas:checked').each(function(i){
      val[i] = jQuery(this).val();
    });
    var baSelected = val.length != 0;
    RiskDWRService.listActiveCategories(val, function(data) { populateCallback(element, selectedValue, data, baSelected); });
  }
  function populateCallback(element, selectedValue, data, baSelected) {
    DWRUtil.removeAllOptions(element.id);
    DWRUtil.addOptions(element.id, data);
    
    // sort option alphabetically
    var options = jQuery('select[id*="'+element.id+'"] option');
    options.detach().sort(function(a,b) {               // Detach from select, then Sort
	    var at = jQuery(a).text();
	    var bt = jQuery(b).text();         
	    return (at > bt)?1:((at < bt)?-1:0);            // Tell the sort function how to order
	});
	options.appendTo('select[id*="'+element.id+'"]');
	
	var noOptionSelected = true;
	// add prompt for Business Area if no BA selected
	if (baSelected) {
		jQuery('select[id*="'+element.id+'"]').prepend("<option value=''>CHOOSE</option>");
		// If the originally selected value can be selected, do so.
		for (i=0; i<element.options.length; i++) {
		   if (element.options[i].text == selectedValue) {
		       	element.selectedIndex = i;
		       	noOptionSelected = false;
		   } 
		}
		if(noOptionSelected) {
			element.selectedIndex = 0;
		}		
	} else {
		jQuery('select[id*="'+element.id+'"]').prepend("<option value=''>Choose Business Area First!</option>");
		element.selectedIndex = 0;
	}	
	
	

	
    jQuery("#category").select2({ width: '50%' });
  }
  function limitText(limitField, limitCount, limitNum) {
	  	if (limitField.value.length > limitNum) {
	  		limitField.value = limitField.value.substring(0, limitNum);
	  	} else {
	  		limitCount.value = limitNum - limitField.value.length;
	  	}
	  }
  </script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
    @import "<c:url value='/css/risk.css'/>";
    
  </style>
</head>
<body onload="onChangeBusinessArea();">
<!-- <div class="header"> -->
<%-- <h2><span class="nowrap"><fmt:message key="objectiveForm.title" /></span></h2> --%> 
<!-- </div> -->
<scannell:form>
<c:set var="objective" value="${command.objective}" />
<div class="content">  
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<%-- <col class="label" /> --%>
<tbody>
  <c:if test="${objective.id != null}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="id" />:</td>
    <td class="search">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${objective.displayId}" />
    </td>

    <td class="searchLabel"><fmt:message key="objective.status" />:</td>
    <td class="search"><fmt:message key="task.${objective.status}" /></td>
  </tr>
  </c:if>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="businessArea" />:</td>
    <td class="search" colspan="3">
      <fmt:message var="multiSelect" key="risk.businessAreaMultiSelect" />
      <c:choose>
        <c:when test="${multiSelect}">
        <spring:bind path="command.businessAreas">
          <label>
          <c:forEach var="ba" items="${businessAreaList}">
            <c:set var="selected" value="${false}" />
            <c:forEach items="${command.businessAreas}" var="selectedBA">
              <c:if test="${ba.id == selectedBA.id}"><c:set var="selected" value="${true}" /></c:if>
            </c:forEach>

            <input type="checkbox" id="businessAreas"
                name="<c:out value="${status.expression}"/>"
                value="<c:out value="${ba.id}" />"
                <c:if test="${selected}">checked="checked"</c:if> onchange="onChangeBusinessArea();" />
            <c:out value="${ba.name}" /><br>

            <c:remove var="selected" />
          </c:forEach>
          </label>
          <span class="requiredHinted">*</span>
          <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
        </spring:bind>
        </c:when>
        <c:otherwise>

          <scannell:select id="businessAreas" path="businessAreas"
              items="${businessAreaList}" itemLabel="name" itemValue="id"
              class="wide" onchange="onChangeBusinessArea();"/>

        </c:otherwise>
      </c:choose>
    </td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="objective.name" />:</td>
    <td class="search" colspan="3">	<scannell:textarea path="name" cols="75" rows="3" onkeydown="limitText(this.form.name,this.form.countdown,250);"
		onkeyup="limitText(this.form.name,this.form.countdown,250);"/>
		<br>
		<font size="1">You have <input readonly type="text" name="countdown" size="3" value="${desclength}" style="border: none">characters left.</font></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="objective.benefit" />:</td>
    <td colspan="3" class="search"><scannell:textarea path="benefit" cols="75" rows="3" /></td>
  </tr>

  <tr class="form-group">
  <td class="searchLabel"><fmt:message key="objective.creationDate" />:</td>
		<td class="search nowrap">			
			<div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left">
                  <scannell:input class="form-control" path="creationDate" id="creationDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>			
                  
                </div>
                <span class="requiredHinted">*</span>
                </td>
                
  </tr>
  <tr>
   <td class="searchLabel nowrap"><fmt:message key="objective.targetCompletionDate" />:</td>
                <td class="search nowrap">			
			<div  style="width:250px;display:inline;">
                  <div id="cal2" class="input-group date datetime" data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left">
                  <scannell:input class="form-control" path="targetCompletionDate" id="targetCompletionDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>                     
                  </div>			
                 <span class="requiredHinted">*</span>
                </div>
		  
		</td>   
  
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="objective.category" />:</td>
    <fmt:message var="emptyCategoryLabel" key="emptyCategoryDropdownLabel" />
    <td colspan="3" class="search"><scannell:select id="category" path="category" items="${categoryList}" itemLabel="name" itemValue="id" cssStyle="width:400px; text-transform: uppercase !important;" emptyOptionLabel="${emptyCategoryLabel}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel nowrap"><fmt:message key="objective.externalObjective" />:</td>
    <td colspan="3" class="search"><input name="externalObjective" cssStyle="width:400px;" class="form-control"/></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="objective.sponsor" />:</td>
    <td colspan="3" class="search"><input name="sponsor" cssStyle="width:400px;display:inline" class="form-control" /></td>
  </tr>

<%
java.util.Collection<Integer> c = new java.util.ArrayList<Integer>();
for (int i=0; i<=20; i++) {
  c.add(new Integer(i*5));
}
pageContext.setAttribute("percentages", c);
%>
  <c:if test="${objective.id != null}"><%-- Percent fields are only displayed for an edit. --%>
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="objective.percentCompleted" />:</td>
    <td colspan="3" class="search"><select name="percentCompleted" items="${percentages}" cssStyle="width:400px;"  renderEmptyOption="false"/></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="objective.progressComment" />:</td>
    <td colspan="3" class="search"><scannell:textarea path="progressComment" cols="75" rows="3" /></td>
  </tr>
  </c:if>

  <tr class="form-group">
  <c:choose>
  <c:when test="${objective.createdByUser != null}">
    <td class="searchLabel"><fmt:message key="createdBy" />:</td>
    <td class="search"><c:out value="${objective.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${objective.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td class="searchLabel">&nbsp;</td>
    <td class="search">&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${objective.lastUpdatedByUser != null}">
    <td class="searchLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td class="search"><c:out value="${objective.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${objective.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td class="searchLabel">&nbsp;</td>
    <td class="search">&nbsp;</td>
  </c:otherwise>
  </c:choose>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
      <c:choose>
        <c:when test="${objective.id gt 0}">
        <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/objectiveView.htm"><c:param name="id" value="${objective.id}"/></c:url>'">
        </c:when>
        <c:otherwise>
        <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/home.htm" />'">
        </c:otherwise>
      </c:choose>
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
