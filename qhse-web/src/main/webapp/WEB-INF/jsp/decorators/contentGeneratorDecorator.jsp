<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java"
import = "com.scannellsolutions.users.User"
import = "com.opensymphony.module.sitemesh.Page"
%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"       uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="lawRegisterId" value="${defaultRegisterType.id}" />
<c:if test="${param['legRegister'] != null}">
    <c:set var="lawRegisterId" value="${param['legRegister']}" />
</c:if>
<c:if test="${param['registerType'] != null}">
    <c:set var="lawRegisterId" value="${param['registerType']}" />
</c:if>

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  
  <style type="text/css">
    @media screen {
      div#bodyCentreDiv { overflow: scroll; overflow-x: auto; overflow-y: auto; }
      div#ssChromeMinimize { position: fixed; top: 12px; right: 12px; cursor: pointer;}
    }
    @media print {
      div#headerDiv { display: none; }
      div#bodyLeftDiv { display: none; }
      div#bodyRightDiv { display: none; }
      div#footerDiv { display: none; }
      div#bodyCentreDiv { width: auto !important; height: auto !important; overflow: auto; left: 0 !important;  }
    }
    .bodyCentreDivExpanded { width: 100% !important; height: 100% !important; }
    .bodyCentreDivNormal { position: absolute; top: 100px; left:249px; width: 640px; height: 480px; }
    
  </style>  

	<title>SCANNELL</title>

	<script language="javascript" type="text/javascript"><!--
		// The context path is needed in /js/site.js
		var contextPath = '<%=request.getContextPath()%>';
	//--></script>

	<meta http-equiv="copyright" content="&copy; 2005 ScannellSolutions">
	<meta http-equiv="robots"    content="noindex, nofollow, noarchive">

	<style type="text/css" media="all">
		@import "<c:url value='resources/css/default.css'/>";

		h2, a, a:visited, table.viewForm a, div.menuContainer, table.viewForm tfoot tr td {color: <c:out value="${moduleColor}" />;}
		table.viewForm thead tr td {border-bottom-color: <c:out value="${moduleColor}" />; color: <c:out value="${moduleColor}" />; }
		div.menuTitle {background-color: <c:out value="${moduleColor}" />;}
		table.viewForm {border-color: <c:out value="${moduleColor}" />;}
	</style>

	<script type="text/javascript" src="<c:url value="resources/js/prototype.js" />" ></script>
	<script type="text/javascript" src="<c:url value="resources/js/effects.js" />" ></script>
	<script type="text/javascript" src="<c:url value="resources/js/utils.js" />"></script>
    <script type="text/javascript" src="<c:url value="resources/jquery/jquery-1.3.2.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="resources/jquery/jquery-ui-1.7.2.custom.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="resources/jquery/jquery.loadmask-0.4.min.js" />"></script>
	<script type="text/javascript">
      var $jq = jQuery.noConflict();
	<!--
		function onBodyLoad() {
			window.focus();
			if (window.onDecoratorLoad) {
				onDecoratorLoad();
			}
			<decorator:getProperty property="body.onload"  /> ;
			doJumpto();
		}
		function onBodyUnLoad() {
			<decorator:getProperty property="body.onunload"  />;
		}
	// -->
	</script>

  <script type="text/javascript">
  <!--
    window.onresize = function() {resize();};


    $jq(document).ready(function() {

	    $jq('#ssChromeMinimize>img').click(function() {
	    	$jq('#headerDiv, #bodyLeftDiv, #bodyRightDiv, #footerDiv').toggle();
	    	$jq('#bodyCentreDiv').toggleClass('bodyCentreDivExpanded');
	    	$jq('#bodyCentreDiv').toggleClass('bodyCentreDivNormal');
	    });
    });
  // End of script -->
  </script>

  <decorator:usePage id="myPage" />

  <decorator:head />
</head>

<body onload="onBodyLoad();" onunload="onBodyUnLoad();" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="overflow: hidden"  >

<div id="headerDiv" class="noprint" style="position: absolute; width: 100%; height: 100px; top: 0; background-repeat: repeat-x; background-image: url(<c:url value="resources/images/${module}/tc.giff" />)">
<img hspace="0" vspace="0" align="left" src="<c:url value="resources/images/${module}/tl.giff" />" />
<img style="position: absolute; top: 48px; right: 26px;" src="<c:url value="resources/images/${module}/tcr.giff" />" hspace="0" vspace="0"  />
<img style="position: absolute; top: 0; right: 0;" src="<c:url value="resources/images/${module}/tr.giff" />" hspace="0" vspace="0" />
</div>

<div id="ssChromeMinimize" >
	<img src="<c:url value="resources/images/hideChrome.gif" />" />
</div>

<div id="bodyLeftDiv" class="noprint" style="position: absolute; top: 100px; left:0px; width: 249px; background-image: url(<c:url value="resources/images/${module}/lbg.giff" />); background-repeat: repeat-y;" >
    <c:choose>
      <c:when test="${module == 'law'}">
        <img style="position: absolute; top: 0px; left: 0px;" src="<c:url value="resources/images/${module}/tabs${lawRegisterId}.gif" />" hspace="0" vspace="0" usemap="#lawTabs" />
        <map name="lawTabs">
            <c:if test="${envRegisterType.active}" >
    	        <area shape="rect" coords="12,2,88,24" href="<c:url value="legIndex-1.html" />">
            </c:if>
            <c:if test="${hsRegisterType.active}" >
	            <area shape="rect" coords="94,2,188,24" href="<c:url value="legIndex-2.html" />">
            </c:if>
        </map>
      </c:when>
      <c:otherwise>
        <img style="position: absolute; top: 0px; left: 0px;" src="<c:url value="resources/images/${module}/lt.giff" />" hspace="0" vspace="0" />
      </c:otherwise>
    </c:choose>

  <img style="position: absolute; top: 0px; left: 193px;" src="<c:url value="resources/images/${module}/lr.giff" />" usemap="#Map1" hspace="0" vspace="0" />
  <map name="Map1">
    <area shape="rect" coords="17,36,43,61" href="envirolawHome.html" alt="Home" title="Home" />
    <area shape="rect" coords="16,67,44,94" href="search-${lawRegisterId}.html" alt="Search Legislation" title="Search Legislation" />
    <area shape="rect" coords="15,100,43,127" href="enviroApplication_HELP.html" alt="Help" title="Help" />
    <area shape="rect" coords="17,135,44,160" href="mailto:envirosupport@scannellsolutions.com" alt="Contact Scannell" title="Contact Scannell" />
    <area shape="rect" coords="16,168,43,194" href="envirolawHome.html" alt="Log Out" title="Log Out" />
  </map>


  <div class="menuContainer" style="position: absolute; top: 30px; left:15px; width: 150px;">
    <%
      User user = (User) request.getAttribute("user");
      if (user == null) {
        user = (User) session.getAttribute(User.SESSION_ID);
      }
    %>

      <div class="inset menuBranch" style="margin-top: 10px;">
        <b class="b1"></b><b class="b2"></b><b class="b3"></b><b class="b4"></b>
        <div class="boxcontent">
          <div class="menuTitle">Publication Reference</div>
          <div class="menuLeaf"><c:out value="${profile.publicationReference}" /></div>
        </div>
        <b class="b4"></b><b class="b3"></b><b class="b2"></b><b class="b1"></b>
      </div>

      <div class="inset menuBranch" style="margin-top: 10px;">
        <b class="b1"></b><b class="b2"></b><b class="b3"></b><b class="b4"></b>
        <div class="boxcontent">
          <div class="menuTitle"><fmt:message key="menu.views" /></div>
          <div class="menuLeaf"><a href="legIndex-${lawRegisterId}.html">Index of Legislation</a></div>
          <div class="menuLeaf"><a href="chkIndex-${lawRegisterId}.html">Index of Checklists </a></div>
          <div class="menuLeaf"><a href="kwdIndex-${lawRegisterId}.html">Index of Keywords </a></div>
          <div class="menuLeaf"><a href="changeRecord-${lawRegisterId}.html">Change Record</a></div>
        </div>
        <b class="b4"></b><b class="b3"></b><b class="b2"></b><b class="b1"></b>
      </div>
      
  </div>
</div>

<div id="bodyCentreDiv" class="bodyCentreDivNormal" >

  <%if ("true".equalsIgnoreCase(myPage.getProperty("meta.printCopyright"))) {%>
    <common:printCopyright />
  <%}%>

  <h2 style="padding-bottom: 5px;" align="center"><decorator:title default="" /></h2>
    <%if ("true".equalsIgnoreCase(myPage.getProperty("meta.printable"))) {
          String parms = request.getQueryString();
          if (parms == null || parms.length() == 0) {
              parms = "?printable=true";
          } else {
              parms = "?" + parms + "&printable=true";
          }
    %>
    <div align="right" class="noprint" style="font-size: xx-small;" >(<a href="<%=parms%>" target="printpopup">printable version</a>)</div>
    <%}%>

  <%if (!"false".equalsIgnoreCase(myPage.getProperty("meta.confidential"))) {%>
    <div class="printable"><fmt:message key="confidential" /></div>
  <%}%>
  
  <decorator:body />

  <%-- <%if (!"false".equalsIgnoreCase(myPage.getProperty("meta.confidential"))) {%>
    <div class="printable"><fmt:message key="confidential" /></div>
  <%}%> --%>

  <div style="height: 30px;">&nbsp;</div>
  <%if ("true".equalsIgnoreCase(myPage.getProperty("meta.printCopyright"))) {%>
    <common:printCopyright />
  <%}%>
  
  <div style="height: 30px;">&nbsp;</div>
  
</div>

<div id="bodyRightDiv" class="noprint" style="position: absolute; top: 100px; right:0px; width: 26px; height: 480px; background-image: url(<c:url value="resources/images/${module}/rbg.giff" />); background-repeat: repeat-y;" />

</div>

<div id="footerDiv" class="noprint" style="position: absolute; width: 100%; height: 58px; bottom: 0; background-image: url(<c:url value="resources/images/${module}/cb.giff" />); background-repeat: repeat-x">
  <img style="position: absolute; bottom: 0; left: 0;" src="<c:url value="resources/images/${module}/lb.giff" />" hspace="0" vspace="0" />
  <div style="margin-top: 10px;"><c:out value="${user.displayName}" /></div>
  <img style="position: absolute; bottom: 0; right: 0;" src="<c:url value="resources/images/${module}/rb.giff" />" hspace="0" vspace="0" />
</div>

<script type="text/javascript">
  resize();
</script>


</body>
</html>
