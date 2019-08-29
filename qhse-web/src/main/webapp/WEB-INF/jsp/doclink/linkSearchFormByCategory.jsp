<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><fmt:message key="linkSearchForm" /></title>

  <script language="javascript" type="text/javascript">
    var contextPath = '<%=request.getContextPath()%>';
  </script>

  <script language="javascript" src="<c:url value="/js/utils.js" />"> </script>

  <script type="text/javascript">
    function searchLinks(form, targetElementId) {
      var url = buildFormUrl("/doclink/linkSearch.htmf", form);
      getXMLDoc(url, targetElementId);
      return false;
    }
    
    function onSelectLink(linkId) {
      var url = contextPath + '/doclink/linkEdit.htm';
      if (linkId) {
        url = url + '?showId=' + linkId;
      }
      location.href=url;
      location.target=top;
    }

    function onIFrameClose() {
      document.getElementById("searchButton").click();
      var editFrame = document.getElementById("editFrame")
      editFrame.style.display = "none";
    }
  </script>

<style type="text/css" media="all">
  @import "<c:url value='/css/default.css'/>";
</style>

</head>
<body onload="$('queryForm').onsubmit();">
<br /><br />

<form id="queryForm" action="<c:url value="/doclink/linkSearch.htmf" />" onsubmit="return search(this, 'resultsDiv');">
  <input type="hidden" name="calculateTotals" value="true" /> 
  <input type="hidden" name="pageNumber" value="1" /> 
  <input type="hidden" id="pageSize" name="pageSize" />
  <input type="hidden" name="sortName" value="name" />

<c:if test="${userCanEdit}">
  <table align="center" width="85%">
    <tr>
      <td align="center">
        <button type="button" onclick="onSelectLink();"><fmt:message key="addLink" /></button>
      </td>
    </tr>
  </table>
</c:if>

<table id="docSearch" align="center" border="3">
  <tr>
    <td align="center" ><fmt:message key="docSearchKey" />:
        <input type="text" name="name" />
    </td>
    <td align="center">
      <fmt:message key="docChooseCat" />:
      <select name="categoryId" class="wide">
        <option></option>
        <c:forEach items="${categories}" var="item">
          <option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
        </c:forEach>
      </select>
    </td>
    <td align="center">
      <button type="submit" onClick="this.form.pageNumber.value = 1;"><fmt:message key="search" /></button>
      <input style="display: none;" type="submit" name="submitBtn" />
      <button id="searchButton"  style="display: none;" type="submit">I'm hidden</button>
      <button type="reset"><fmt:message key="reset" /></button> 
    </td>
  </tr>

</table>
<div id="resultsDiv"></div>

</form>

</body>
</html>
