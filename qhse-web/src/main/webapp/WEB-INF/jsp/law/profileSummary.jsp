<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@page import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@page import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@page import="com.scannellsolutions.modules.law.domain.LegacyProfile"%><html>
<head>
<jsp:include page="headInclude.jsp" />

<title><fmt:message key="profileSummary"/></title>

<style type="text/css">

.ss-profile-summary {
  width: 95%;
}

.ss-category-title-footer {
  background-color: #bac3d2;
  width: 100%;
  height: 5px;
  overflow: hidden;
}

.ss-category-title-header {
  border: 0;
  padding: 0;
  margin-top: 40px;
  margin-left: 10px;
  height: 5px;
  background-color: #bac3d2;
  font-size: 1px;
}

.ss-category-title-header tr td {
  height: 5px;
}


.ss-category-title-header-center {
  width: 230px;
}

.ss-category-title-text {
  margin-left: 10px;
  background-color: #bac3d2;
  font-size: 12px;
  font-weight: normal;
  text-align: center;
  font-family:'Arial','Helvetica';
  width: 240px;
}

tr.group-row td{
  background-color: #cccccc;
  color: #666666;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 10px;
  font-weight: bold;
  color: black;
}
tr.quest-row  td{
  background-color: #eeeeee;
  border-bottom: 1px solid #BDBDBD;
  border-top: 1px solid #BDBDBD;
  padding-bottom: 10px;
  color: #666666;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 10px;
  font-weight: bold;
  color: #666666;
  empty-cells: show;
  vertical-align: top;
}
td.quest-label { width: 30% }
td.quest-value { width: 70% }

</style>

<script type="text/javascript">
//window.print(); 
</script>

</head>
<body>
<div class="law">

<div class="title">
<fmt:message key="profileSummary"/>
<a href="javascript:print();">
    <img src="<c:url value="/legal/images/enviroMANAGER_Application_PrinterLink.gif" />" width="27" height="27" border="0" alt="Print" />
  </a>
</div>
  
</div>


<table class="ss-profile-summary">
<c:forEach items="${categories}" var="category">
  <c:set var="generalCategory" value="${category == 'GENERAL'}" />
    <tr>
      <td colspan="2">
        <table class="ss-category-title-header" cellpadding="0" cellspacing="0">
          <tr>
            <td><img border="0" src="<c:url value="/legal/StyleSheets/lefttab.gif" />"  /></td>
            <td class="ss-category-title-header-center">&nbsp;</td>
            <td><img border="0" src="<c:url value="/legal/StyleSheets/righttab.gif" />"  /></td>
          </tr> 
        </table>
        <div class="ss-category-title-text">${category}</div>
        <div class="ss-category-title-footer">&nbsp;</div>
      </td>
    </tr>

    <c:if test="${generalCategory}">
      <tr class="quest-row">
        <td class="quest-label">Profile Name (ID, VER, STATE, PRIMARY OWNER, SECONDARY OWNER) </td>
        <td class="quest-value">${profile.name} (${profile.id}, ${profile.version}, ${profile.state}, ${profile.effectiveOwner.firstName} ${profile.effectiveOwner.lastName}, ${profile.owner.firstName} ${profile.owner.lastName})</td>
      </tr>     
      <tr class="quest-row">
        <td class="quest-label">Profile Description </td>
        <td class="quest-value">${profile.description}</td>
      </tr>     
    </c:if>

    <c:forEach items="${groupsByCategories[category]}" var="group">
      <c:if test="${!generalCategory}">
        <tr class="group-row">
          <td style="margin-left: 10px;" colspan="2">${group.description}</td>
        </tr>
      </c:if>
      
      <c:forEach items="${group.questions}" var="question">
        <tr class="quest-row">
          <td class="quest-label">${question.name}</td>
          <td class="quest-value">
            <c:forEach items="${questionsToAnswerDescriptions[question]}" var="answer">
              ${answer} <br />
            </c:forEach>
            &nbsp;
          </td>
        </tr>     
      </c:forEach>
    </c:forEach>
</c:forEach>

    
  <tr>
    <td colspan="2">
      <table class="ss-category-title-header" cellpadding="0" cellspacing="0">
        <tr>
          <td><img border="0" src="<c:url value="/legal/StyleSheets/lefttab.gif" />"  /></td>
          <td class="ss-category-title-header-center">&nbsp;</td>
          <td><img border="0" src="<c:url value="/legal/StyleSheets/righttab.gif" />"  /></td>
        </tr> 
      </table>
      <div class="ss-category-title-text"><fmt:message key="checkRelCompProfSum"/></div>
      <div class="ss-category-title-footer">&nbsp;</div>
    </td>
  </tr>
  <c:forEach items="${profile.checklists}" var="checklist">
    <tr class="quest-row">
      <td class="quest-label">${checklist.name}</td>
      <td class="quest-value">
        <fmt:message key="relevanceProfSum"/> <br />
        <c:choose>
          <c:when test="${empty checklist.relevance}"><fmt:message key="notSpec"/></c:when>
          <c:otherwise>${checklist.relevance}</c:otherwise>
        </c:choose>
        <br /><fmt:message key="compInfoProfSum"/><br />
        <c:choose>
          <c:when test="${empty checklist.compliance}"><fmt:message key="notSpec"/></c:when>
          <c:otherwise>${checklist.compliance}</c:otherwise>
        </c:choose>
      </td>
    </tr>     
  </c:forEach>
</table>

</div>

</body>
</html>
