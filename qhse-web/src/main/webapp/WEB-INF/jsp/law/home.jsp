<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>enviroLAW</title>
<script type="text/javascript">
location.href = '<c:url value="/law/lawDashboard.htm"/>';
</script>
</head>
<body>

<table border="0" cellpadding="10" cellspacing="0" width="95%" align="center">
  <tr>
    <td align="center" valign="top" height="453">
    <h3 align="center"><font color="#408080" face="Tahoma"> <font color="#000000">Welcome to</font></font></h3>

    <table border="0" cellpadding="5" cellspacing="0" width="100%">
      <tr valign="top" align="center">
        <td width="100%" height="13">
        <div align="center"><img src="<law:url value="/images/law/homeLogo.gif" />" width="454" height="284"></div>
        </td>
      </tr>
      <tr valign="top" align="center">
        <td width="100%" height="32">
        <div align="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Please use the
        navigation on your left to review the <b><font size="4" color="#999999">enviro</font> <font size="4"><font
          color="#666699">law</font></font></b> data.</font></div>
        </td>
      </tr>
      <tr valign="top" align="center">
        <td width="100%">
        <table width="100" border="0" cellspacing="2" cellpadding="2" align="center">
          <tr>

            <td colspan="2">
            <div align="center"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#000000"
              size="2">Data Access:</font></b></div>
            </td>
          </tr>
          <tr>
            <c:if test="${envRegisterType.active}" >
                <c:url var="keywordIndexUrl" value="/legal/front/checklists/KeywordIndex.jsp?registerType=1" />
            	<c:if test="${param['cgen'] == 'true'}">
	            	<c:set var="keywordIndexUrl" value="kwdIndex-1.html" />
            	</c:if>
	            <td><a href="${keywordIndexUrl}"><img src="<law:url value="/images/law/envButton.gif" />" width="183" height="62" border="0"></a></td>
            </c:if>
            <c:if test="${hsRegisterType.active}" >
                <c:url var="keywordIndexUrl" value="/legal/front/checklists/KeywordIndex.jsp?registerType=2" />
            	<c:if test="${param['cgen'] == 'true'}">
	            	<c:set var="keywordIndexUrl" value="kwdIndex-2.html" />
            	</c:if>
	            <td><a href="${keywordIndexUrl}"><img src="<law:url value="/images/law/hsButton.gif" />" width="183" height="62" border="0"></a></td>
            </c:if>
          </tr>
        </table>
        </td>
      </tr>
    </table>
    </td>

  </tr>
</table>


</body>
</html>
