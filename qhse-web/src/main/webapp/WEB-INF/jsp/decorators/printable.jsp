<!DOCTYPE html>
<%@ page language="java" %>

<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="fmt"       uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<html>
<head>

<link rel="shortcut icon" href="<c:url value="/images/imagesj/favicon.ico" />">

<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%@include file="headNew.jspf" %>
    <sitemesh:write property='head'/>
  
    <script type="text/javascript" >
	
        jQuery(document).ready(function() {
             var link = document.location.href;
             var arr = new Array();
             arr = link.split('/');

             if(window.location.href.indexOf("printable=true") > -1) {
                 jQuery('<link/>').attr({
                     rel:'stylesheet',
                     type:'text/css',
                     media:'all',
                     href:'<c:url value="/css/print.css"/>'}).appendTo('head');
                }
        });
	</script>
	<script type="text/javascript">	
      
      var  ajaxPrint;

		function onBodyLoad() {			
						
			   window.focus();
			if (window.onDecoratorLoad) {
				onDecoratorLoad();
			}
			<decorator:getProperty property="body.onload"  /> ;
			doJumpto();
			<fmt:message key="logoutTimer" />;
			<fmt:message key="ui.showPrintDialog" var="showPrintDialog" />			
            <c:if test="${param.printable && showPrintDialog != 'false'}">             
              setTimeout('print()',4000);             
            </c:if>
        	<c:if test="${defaultTarget ne null}">
        	jQuery("a").click(function() {
    			var target = this.target || $jq("base").attr("target");
    			var opener = window.opener ? window.opener : window.parent ? window.parent.opener : null;
    			if(target && opener && target == opener.name && !$jq(this).hasClass("ui-dialog-titlebar-close")) {
    			  setTimeout(function() {
    				opener.focus()
    			  }, 500);
    			}
    		  });
         	</c:if>
			
		}
		function onBodyUnLoad() {
			<decorator:getProperty property="body.onunload"  />;
		}
	</script>
</head>

<body onload="onBodyLoad();" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
	<%
		String parms = request.getRequestURL().toString()+'?'+request.getQueryString();
	%>
<input value="<%=parms%>" type="hidden" id="printParam"/>
    <div class="printable"><fmt:message key="confidential" /></div>  

    <h2 align="center"><decorator:title default="" /></h2>
    <div >
      <decorator:body />
    </div>

    <%-- <div class="printable"><fmt:message key="confidential" /></div>  --%> 

</body>
</html>