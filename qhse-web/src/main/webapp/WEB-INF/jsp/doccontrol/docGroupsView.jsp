<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="doccontrol" tagdir="/WEB-INF/tags/doccontrol"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="printable" content="true">
	<title></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script language="javascript" src="<c:url value="/js/doccontrol.js" />"> </script>
	<script language="javascript" src="<c:url value="/js/doccontrol/dragDropDocGroup.js" />"> </script>
	<style type="text/css" media="all">
		@import "<c:url value='/css/doccontrol.css'/>";
		@import "<c:url value='/css/material-icons.css'/>";
		@import "<c:url value='/css/tree.css'/>";
		.wrapper {
		    position: absolute;
		    left: 50%;
		    margin-left: -100px;
		}
		.tree li a p {
			border: 0;
		}
		#dialog-confirm {
		    display:none
		}
		#dialog-confirm-docGroup {
		    display:none
		}
		
	</style>
	<%-- <script type="text/javascript" src="<c:url value="/js/jquery.singleclick.js" />"></script>
	 --%>
	<script>
		var title = '<fmt:message key="docControl.addSubDG"/>';

		jQuery(document).ready(function() {
			jQuery(".docButton").click(function(){
				jQuery(this).toggleClass("papers").toggleClass("nopaper").end();
				animateJumpTo(jQuery(this).attr('id'));
			});
			  doccontrol = {}; // namespace
		      jQuery(document.body).append('<div id="dialogDiv"></div>');
		      jQuery("#dialogDiv").html('<iframe id="dialogFrame" width="640" height="440" marginWidth="0" marginHeight="0" frameBorder="0" src="about:blank" />');
		      
		      jQuery("#dialogDiv").dialog({
		        title: title,
		        height: 'auto',
		        width: 640,
		        modal: true,
		        resizable: false,
		        draggable: true,
		        autoOpen: false,
		        create: function (event, ui) {
		        	$(event.target).parent().css('position', 'fixed');
		        }
		      });
		      
			jQuery('.newGroup').on('click', function(e) {
				var url = jQuery(this).attr( "id" );
	          	jQuery("#dialogFrame").attr("src", url);
	          	jQuery("#dialogDiv").dialog("open");
			});

			jQuery('.edit').on('click', function(e) {
				var url = jQuery(this).attr( "id" );
				window.location=url;	    
			});

			jQuery('a').on('mouseenter', function(e) {
			  	jQuery("a").removeClass('changeHover');
			});
			
			doccontrol.addDocGroupDialogClose = function() {
				var oldUrl = jQuery("#dialogFrame").attr("src");
			    var id = oldUrl.substring(oldUrl.indexOf('=')+1, oldUrl.indexOf('&'));
			    jQuery("#dialogDiv").dialog("close");
			    var url = '${pageContext.request.contextPath}' + '/doccontrol/docGroupsView.htm?navTo='+id;
			    window.location=url;
			};
			
			//Highlight Doc Group to land on
			highlightDocGroup("${navTo}", "${showActiveOnly}", "${docGroup.status}", "${docGroup.id}");
			
			//Switch between document and doc group view for drag and drop
			jQuery('.bootSwitch').on('switchChange.bootstrapSwitch', function(event, state) {
				if("${navTo}") {
					location.href='<c:url value="/doccontrol/docGroupsView.htm" ><c:param name="navTo" value="${navTo}" /><c:param name="showActiveOnly" value="${showActiveOnly}" /><c:param name="showDocuments" value="${!showDocuments}" /><c:param name="source" value="${source}" /></c:url>';
				}
				else if("${subDocGroupView}")  {
					location.href='<c:url value="/doccontrol/docGroupsSubView.htm" ><c:param name="id" value="${docGroup.id}" /><c:param name="showActiveOnly" value="${showActiveOnly}" /><c:param name="showDocuments" value="${!showDocuments}" /><c:param name="source" value="${source}" /></c:url>';				
				}
				else {
					location.href='<c:url value="/doccontrol/docGroupsView.htm" ><c:param name="id" value="${docGroup.id}" /><c:param name="showActiveOnly" value="${showActiveOnly}" /><c:param name="showDocuments" value="${!showDocuments}" /><c:param name="source" value="${source}" /></c:url>';				
				}
			});
			
		});
		function onPopupClose() {
		  doccontrol.addDocGroupDialogClose();
		}
		
	</script>
</head>
<body>
	<div class="header">
		<h2><span class="nowrap">
			<c:choose>
				<c:when test="${subDocGroupView}"><fmt:message key="doccontrol.hierarchy.sub" /></c:when>
				<c:otherwise><fmt:message key="doccontrol.hierarchy" /></c:otherwise>
			</c:choose>
		</span></h2>
	</div>
	<doccontrol:documentSwitch showActiveOnly="${showActiveOnly}"/>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<div id="hierarchy" class="tree" style="vertical-align: middle " >
					<ul><doccontrol:docGroupNode docGroup="${docGroup}" canEdit="${canEdit}" showDocuments="${showDocuments}"/> </ul>
				</div>	
			</div>
		</div>
	</div>
	<doccontrol:documentSwitch showActiveOnly="${showActiveOnly}"/>
	<div id="dialog-confirm"><fmt:message key="doccontrol.docGroup.moveDocument.warning"/></div>
	<div id="dialog-confirm-docGroup"><fmt:message key="doccontrol.docGroup.moveDocgroup.warning"/></div>
</body>
</html>
