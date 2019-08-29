<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="targetForm.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
     @import "<c:url value='/css/risk.css'/>";
  </style>
  <style type="text/css">
td.searchLabel {
padding-left: 0% !important;
padding-right:1%!important;
}
td.search {
background-color: white !important;
border-width: 0px !important;
padding-top: 20px !important;
/* width: 2%!important;
padding-left:0%!important; */
}
  </style>
   <script type="text/javascript">
		var enterChars = '<fmt:message key="select2.enterChars"/>';
		var userCount = ${fn:length(userList)};
		var maxListSize = 500;
	
   jQuery(document).ready(function() {
	   jQuery("form").submit(function() {
			// submit more than once return false
			jQuery(this).submit(function() {
				return false;
			});
			// submit once return true
			return true;
		});	 	
	   jQuery(".date").find(".requiredHinted").remove();
	   
	   var responsibleUser= '<c:out value="${command.responsibleUser.id}"/>';
		if(responsibleUser != null){
			jQuery('#responsibleUser').val(responsibleUser);
		}
		if(userCount < maxListSize)
		{
			jQuery('#responsibleUser').select2({width:'30%'});
		}
		else 
		{
			jQuery('#responsibleUser').select2({				  
			  width:'30%',
			  minimumInputLength : 3,
			  placeholder :  enterChars,
			  escapeMarkup: function(m) {
			        // Do not escape HTML in the select options text
			        return m;
			     },
			  ajax: {
			        url: "mAccessUserList.json",
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
			    	var data = {id: "<c:out value="${command.responsibleUser.id}"/>", text: "<c:out value="${command.responsibleUser.sortableName}"/>"};
				      callback(data);
				},

			      // NOT NEEDED: These are just css for the demo data
			      dropdownCssClass : 'capitalize',
			      containerCssClass: 'capitalize',

			      // configure as multiple select
			      multiple         : false,

			      // NOT NEEDED: text for loading more results
			      formatLoadMore   : 'Loading more...',				      
			      // query with pagination			  
			      cache: true
			});
		}
		
		if(jQuery('#cal2').find('.error').text() != ''){
			jQuery('.targetDateError').append('<span class=\"error\">'+jQuery('#cal2').find('.error').text()+'</span>');
			jQuery('#cal2').find('.error').remove();
		}
		
   });
   </script>
</head>
<body>
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="targetForm.title" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="content">  
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col  />
<tbody>
  <c:if test="${target.id != null}">
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="id" />:</td>
    <td class="search">
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${target.displayId}" />
    </td>

    <td class="searchLabel"><fmt:message key="target.status" />:</td>
    <td class="search"><fmt:message key="task.${target.status}" /></td>
  </tr>
  </c:if>

  <tr class="form-group">
    <td class="searchLabel" ><fmt:message key="target.name" />:</td>
    <td class="search" colspan="3"><scannell:textarea path="name" cols="75" rows="3" cssStyle="width:70%" class="form-control"/></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel nowrap"><fmt:message key="target.creationDate" />:</td>
   <td class="search">			
			<div id="cal" style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left;">
                  <scannell:input class="form-control" path="creationDate" id="creationDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>			
                  
                </div>
                  <span class="requiredHinted">*</span>
                </td>
    <!-- <td class="col-md-3">
    <div class="input-group date datetime"  data-min-view="2" data-date-format="dd-M-yyyy"  >
         <input class="form-control" size="9" name="creationDate" id="creationDate" type="text"  readonly >
         <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
     </div> -->
     
   

    <td class="searchLabel nowrap"><fmt:message key="target.targetCompletionDate" />:</td>
     <td class="search">			
			<div  style="width:250px;">
                  <div id="cal2" class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;float:left;">
                  <scannell:input class="form-control" path="targetCompletionDate" id="targetCompletionDate" readonly="true" />
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>                     
                  </div>			
                 <span class="requiredHinted targetDateError">*</span>
                </div>
		  
		</td>    
      
    
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="target.responsibleUser" />:</td>
    <td class="search" colspan="3">
    	<c:choose>
			<c:when test="${fn:length(userList) lt 500}">
				<select name="responsibleUser" id="responsibleUser" items="${userList}" itemLabel="sortableName" itemValue="id" cssStyle="width:30%" />
			</c:when>
			<c:otherwise>
				<input type="hidden" id="responsibleUser" style="width:30% !important;"  name="responsibleUser" /><scannell:errors path="responsibleUser"/>
			</c:otherwise>
		</c:choose>
    </td>
  </tr>

  <tr class="form-group">
    <c:if test="${objective != null}">
    <td class="searchLabel"><fmt:message key="target.objective" />:</td>
    <td class="search" colspan="3">
      <scannell:hidden path="objectiveId" />
      <c:url var="objectiveViewUrl" value="/risk/objectiveView.htm"><c:param name="id" value="${objective.id}" /></c:url>
      <a href="<c:out value="${objectiveViewUrl}" />"><c:out value="${objective.displayId}" /></a> -
      <c:out value="${objective.name}" />
    </td>
    </c:if>

    <c:if test="${managementProgramme != null}">
    <td class="searchLabel"><fmt:message key="target.managementProgramme" />:</td>
    <td class="search"><scannell:hidden path="managementProgrammeId" /><c:out value="${managementProgramme.id} - ${managementProgramme.name}" /></td>
    </c:if>
  </tr>

  <c:if test="${target.completedByUser != null}" >
  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="target.completedBy" />:</td>
    <td class="search"><c:out value="${target.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.completionDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="searchLabel"><fmt:message key="target.achieved" />:</td>
    <td class="search"><fmt:message key="boolean.${target.achieved}" /></td>
  </tr>

  <tr class="form-group">
    <td class="searchLabel"><fmt:message key="target.completionComment" />:</td>
    <td class="search"><c:out value="${target.completionComment}" /></td>
  </tr>
  </c:if>

  <tr class="form-group">
  <c:choose>
  <c:when test="${target.createdByUser != null}">
    <td class="searchLabel"><fmt:message key="createdBy" />:</td>
    <td class="search"><c:out value="${target.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td class="searchLabel">&nbsp;</td>
    <td class="search">&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${target.lastUpdatedByUser != null}">
    <td class="searchLabel"><fmt:message key="lastUpdatedBy" />:</td>
    <td class="search"><c:out value="${target.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${target.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
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
        <c:when test="${command.id == 0}">
        <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/objectiveView.htm"><c:param name="id" value="${objective.id}"/></c:url>'">
        </c:when>
        <c:otherwise>
        <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/targetView.htm"><c:param name="id" value="${target.id}"/></c:url>'">
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
