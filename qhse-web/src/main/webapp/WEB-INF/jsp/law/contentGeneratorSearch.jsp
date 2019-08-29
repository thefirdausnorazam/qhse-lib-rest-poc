<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<script type="text/javascript" src='<law:url value="/js/search.js" />'></script>

<script type="text/javascript">

var checklists = [
<c:forEach items="${profile.checklists}" var="checklist" varStatus="status" >
	[ "chk${checklist.id}-${profile.registerType.id}.html",
	  "<scannell:text value="${checklist.name}" pattern="${searchEscapePattern}" patternReplacement=" " htmlEscape="false" newlineEscape="false" />",
	  "",
	  "<scannell:text value="${checklist.name} ${checklist.description} ${checklist.thingsToConsider} ${checklist.relevance} ${checklist.compliance}" pattern="${searchEscapePattern}" patternReplacement=" " htmlEscape="false" newlineEscape="false" />"
	] <c:if test="${!status.last}" >,</c:if>
</c:forEach>
];

var legislations = [
<c:forEach items="${profile.legislations}" var="legislation" varStatus="status" >
	[ "leg${legislation.id}-${profile.registerType.id}.html",
	  "<scannell:text value="${legislation.name}" pattern="${searchEscapePattern}" patternReplacement=" " htmlEscape="false" newlineEscape="false" />",
	  "",
	  "<scannell:text value="${legislation.name} ${legislation.synopsis}" pattern="${searchEscapePattern}" patternReplacement=" " htmlEscape="false" newlineEscape="false" />"
	] <c:if test="${!status.last}" >,</c:if>
</c:forEach>
];

var both = checklists.concat(legislations);
var page = both;
	
function WriteHTML() {
  //write full document to iframe and then get the body
  var searchResultsIframe = document.getElementById("searchResultsIframe");
  var doc = (searchResultsIframe.contentWindow || searchResultsIframe.contentDocument);
  if (doc.document) doc = doc.document;

  doc.open();
  doc.write(sOutput);
  doc.close();  
  document.getElementById("searchResultsDiv").innerHTML = doc.body.innerHTML;
}
</script>

<title>Search this site</title>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0"
	background="../images/enviroMANAGERimages/scannelApp_BackgroundTile2.gif">
<table border="0" cellpadding="10" cellspacing="0" width="95%"
	align="center">
	<tr>
		<td align="center" valign="top">
		<h3 align="center"><font color="#666699" face="Tahoma"> <font
			color="#003366">Search enviroLAW</font></font></h3>
		<table border="0" cellpadding="5" cellspacing="0" width="100%"
			align="left">
			<tr>
				<td height="13">
				<table width="95%" border="0" align="center">
					<tr>
						<td><font face="Verdana" size="1">
						<p align="center"><font face="Verdana" size="1"><small><font
							color="#000000">The search engine will find pages on this
						website only. <br>
						For best results enter just one or two words. <br>
						Searches on more than one word will be treated "as a phrase". <br>
						Use the asterisk (*) character for wildcard searches.</font></small></font></p>
						</font></td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0">
							<tr bgcolor="#CCCCCC">
								<td height="80">
								<table width="60%" border="0" align="center">
									<tr>
										<td width="197">
										<p><font face="Verdana" size="1"><font
											face="Verdana" size="1"><small><font
											color="#000000">Search for: </font></small></font></font></p>
										</td>
										<td width="315"><font face="Verdana" size="1"> 
											<label for="type.both"><input type="radio" id="type.both" name="type" onclick="page=both;" checked="checked" />Both </label> 
											<label for="type.leg"><input type="radio" id="type.leg" name="type" onclick="page=legislations;" />Legislation </label> 
											<label for="type.chk"><input type="radio" id="type.chk" name="type" onclick="page=checklists;" />Relevancies</label> 
										</font></td>
									</tr>
									<tr>
										<td width="197"><font face="Verdana" size="1"><font
											face="Verdana" size="1"><small><font
											color="#000000">Insert a key word:</font></small></font></font></td>
										<td width="315">
										<form name="formSearch" action="javascript:startsearch() //"><input
											name="txtSearch">&nbsp; <input name="send"
											type="submit" value="Search"></form>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
			<iframe id="searchResultsIframe" style="display: none;" src="about:blank" ></iframe>
			<div id="searchResultsDiv"></div>
		</td>
	</tr>
</table>
<table border="0" cellpadding="5" cellspacing="0" width="100%">
</table>

</body>
</html>