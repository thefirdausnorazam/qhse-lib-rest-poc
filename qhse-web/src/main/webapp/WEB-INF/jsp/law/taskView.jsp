<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
  <meta name="printable" content="true">
  <title>
  	
  </title>
  <script type="text/javascript">
  
  jQuery(document).ready(function() {
	  jQuery.ajaxSetup({ cache: false });
	  var contextPath = "${pageContext.request.contextPath}"
	  if (window.opener) {
		  jQuery("#linkCheck").attr("href", contextPath+"/law/checklistsPopup.htm?popup=yes&legRegister=<c:out value='${legRegister }' />&chklistId=<c:out value='${task.checklistId }' />&taskId=<c:out value='${task.id }' />&viewType=<c:out value='${viewType }' />");
		   
		} else if (window.top !== window.self) {
			jQuery("#linkCheck").attr("href", contextPath+"/law/checklistsPopup.htm?popup=yes&legRegister=<c:out value='${legRegister }' />&chklistId=<c:out value='${task.checklistId }' />&taskId=<c:out value='${task.id }' />&viewType=<c:out value='${viewType }' />");
		   
		} else {
			 jQuery("#linkCheck").attr("href", contextPath+"/law/checklists.htm?legRegister=<c:out value='${legRegister }' />&chklistId=<c:out value='${task.checklistId }' />&viewType=<c:out value='${viewType }' />");
		  
		}
      // Wait for the HTML to finish loading.	  
  
  var openHistory;
  openHistory = void 0;
  
  jQuery(document.body).append('<div  id="dialogDivTest1" ></div>');
  jQuery('#dialogDivTest1').html('<iframe class="test" id="dialogFrameTest1"  width="550" height="350" marginWidth="0" marginHeight="0" frameBorder="0" close="no" src="about:blank" />');
  jQuery('#dialogDivTest1').dialog({
    title: SCANNELL_TRANSLATIONS.viewHistory,
    height: 'auto',
    width: 600,
    modal: true,
    resizable: false,
    draggable: false,
    autoOpen: false,
    buttons: [
      {
        text: SCANNELL_TRANSLATIONS.close,
        class: 'g-btn g-btn--primary',
        icons: {
          primary: 'ui-icon-closethick'
        },
        id: 'closebtn',
        click: function() {	        	
          var $this;
          $this = jQuery(this);
          $this.dialog('close');
        }
      }
    ],
    open: function() {
      jQuery(this).closest('.ui-dialog').find('.ui-dialog-titlebar-close').removeClass('ui-dialog-titlebar-close').html('<span class=\'fa fa-times fa-lg\'></span>');
    }
  });
  
  });
  
  openHistory = function(id, type) {
	  var contextPath = "${pageContext.request.contextPath}";
	    var url;
	    url = contextPath + '/enviro/viewHistory.htm?id=' + id + '&type=' + type;
		url = encodeURI(url);
	    jQuery('#dialogFrameTest1').attr('src', url);
	    jQuery('#dialogDivTest1').dialog('open');
	  };
 
  </script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/law.css'/>";
  </style>
</head>
<body>
	<div class="header">
		<h2>
			<fmt:message key="task" />
		</h2>
	</div>
<a name="task"></a>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive" style="width:100%;border-top:1px solid #DADADA;">
  <tbody>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="id" />:</td>
    <td><c:out value="${task.displayId}" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.status" />:</td>
    <td><fmt:message key="${task.status}" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="businessAreas" />:</td>
    <td colspan="3">
	 	<ul>
      		<c:forEach var="ba" items="${task.businessAreas}">
        		<li><c:out value="${ba.name}" /></li>
      		</c:forEach>
	    </ul>
	</td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.name" />:</td>
    <td colspan="3"><scannell:text value="${task.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.additionalInformation" />:</td>
    <td colspan="3"><scannell:text value="${task.additionalInformation}" /></td>
  </tr>

  <c:if test="${task.priority != null}">      
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="priority" /></td>
    <td><fmt:message key="${task.priority}" /></td>
  </tr>  
  </c:if>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.creationDate" />:</td>
    <td><fmt:formatDate value="${task.creationDate}" pattern="dd-MMM-yyyy" /></td>

    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.targetCompletionDate" />:</td>
    <td><fmt:formatDate value="${task.targetCompletionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.responsibleUser" />:</td>
    <td colspan="3"><c:out value="${task.responsibleUser.displayName}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.responsibleDepartment" />:</td>
    <td colspan="3"><c:out value="${task.responsibleDepartment.name}" /></td>
  </tr>

  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.profile" />:</td>
    <td colspan="3">
       	<c:out value="${task.profile.name}" />
    </td>
   </tr>
   <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.checklist" />:</td>
    <td colspan="3">
    	<c:choose>
    		<c:when test="${showCheckList == true}">
    			<a href='' id="linkCheck"><span align="right" class="label label-default"><i class="fa fa-bookmark"></i><fmt:message key="id" /> <c:out value="${task.checklistId}" /></span> <c:out value="${checkList.name}" /></a>
    		</c:when>
    		<c:otherwise>
    			<c:out value="${checkList.name}" /></br><span align="right" class="label label-default" title="<fmt:message key='task.selectProfileToViewChecklist' />"><i class="fa fa-bookmark" title="<fmt:message key='task.selectProfileToViewChecklist' /> <c:out value='${task.profile.name}' />"></i> <fmt:message key="id" /> <c:out value="${task.checklistId}" /></span>
    		</c:otherwise>
    	</c:choose>
        
    </td>
   </tr>

  <c:if test="${task.completed}">
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.achieved" />:</td>
    <td colspan="3"><fmt:message key="boolean.${task.achieved}" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.completedBy" />:</td>
    <td colspan="3"><c:out value="${task.completedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.completionDate}" pattern="dd-MMM-yyyy" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="task.completionComment" />:</td>
    <td colspan="3"><scannell:text value="${task.completionComment}" /></td>
  </tr>
  </c:if>
<!-- 
  <tr>
    <td class="label"><fmt:message key="associatedDocuments" />:</td>
    <td colspan="3">
      <ul>
      <c:forEach var="link" items="${docLinkHolder.links}">
        <li><a href="<c:out value="${link.url}" />" target="linkedDoc"><c:out value="${link.name}" /></a> - <c:out value="${link.description}" /></li>
      </c:forEach>
      </ul>
    </td>
  </tr>
 -->
  <tr>
    <td class="scannellGeneralLabel nowrap"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${task.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

    <c:if test="${task.lastUpdatedByUser != null}">
    <td class="scannellGeneralLabel nowrap"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${task.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${task.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
    </c:if>
  </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="4">
		<c:choose>
			<c:when test="${urls != null}"><scannell:url urls="${urls}" /></c:when>
			<c:otherwise><fmt:message key="taskView.title" /> <fmt:message key="notCurrentSelectedSiteMsg" >
						<fmt:param value="${task.site.name}" />
					 </fmt:message>
			</c:otherwise>
		</c:choose>
      </td>
    </tr>
  </tfoot>
</table>
</div>
</div>
</div>
</body>
</html>
