
<%@page import="com.scannellsolutions.users.UserUtils"%>
<%@page import="com.scannellsolutions.modules.law.domain.Profile"%>

<link type="text/css" href="../../../jquery/ui-ss-law/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
<!--<link type="text/css" href="../../../jquery/ui-lightness/jquery-ui-1.7.2.custom.css" rel="stylesheet" />-->

<script language="javascript" type="text/javascript">
  var contextPath = '<%=request.getContextPath()%>';
  var relevancyEditable = <%=UserUtils.currentUserIsInAnyRole(Profile.ROLE_CREATE, Profile.ROLE_EDIT_RELEVANCY)%>;
</script>

<script type="text/javascript" src="../../../jquery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../../../jquery/jquery-ui-1.7.2.custom.min.js"></script>
<script type="text/javascript" src="../../../jquery/jquery.loadmask-0.4.min.js" />"></script>
<script type="text/javascript" src="../../../js/profileChecklist.js"></script>
