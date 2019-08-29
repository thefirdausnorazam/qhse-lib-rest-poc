<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>

<html>
<script type="text/javascript">
jQuery(document).ready(function(){
	var showId = getUrlParameter('showId');
	jQuery('#destinationURL').attr("href", jQuery('#destinationURL').attr("href")+ '?id='+showId);
	<c:set var="id" scope="session" value="${showId}"/>
});


function getUrlParameter(sParam)
{
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) 
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) 
        {
            return sParameterName[1];
        }
    }
} 
</script>
<body>
<div class="header">
<h2><fmt:message key="accessDenied.title"/></h2>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
    <tbody>
    <tr><td><fmt:message key="LimitPeriodNotReviewableException.body"/></td></tr>
  </tbody>

  <tfoot>
 
    <tr><td>
    <a id="destinationURL" href="<c:url value="/survey/limitPeriodView.htm"></c:url>"><fmt:message key="LimitPeriodNotReviewableException.goback"/></a></td></tr>
  </tfoot>
</table>
</div>
</div>
</div>
</body>
</html>