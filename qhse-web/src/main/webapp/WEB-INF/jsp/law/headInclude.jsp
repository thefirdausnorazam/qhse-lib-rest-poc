<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>
<%@page import="com.scannellsolutions.users.UserUtils"%>
<%@page import="com.scannellsolutions.modules.law.domain.Profile"%>


<script language="javascript" type="text/javascript">
jQuery(document).ready(function() {	  
	  jQuery('#block').removeClass('block-flat');
	  jQuery('#checklistMenuSelect').select2({width:'100%'});
	  
});
  var contextPath = '<%=request.getContextPath()%>';
  var relevancyEditable = <%=UserUtils.currentUserIsInAnyRole(Profile.ROLE_CREATE, Profile.ROLE_EDIT_RELEVANCY)%>;
  var canAddChecklistTasks = <%=UserUtils.currentUser().isInRole(com.scannellsolutions.modules.risk.domain.RiskUserRoles.MANAGEMENT_ACCESS)%>;
  
</script>

