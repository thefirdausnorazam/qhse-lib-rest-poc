<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <c:set var="title" value="maintenanceCategoryEdit" />
  <c:if test="${command['new']}"><c:set var="title" value="maintenanceCategoryCreate" /></c:if>
  <title><fmt:message key="${title}.${command.type.name}" /></title>
</head>
<body>

<scannell:form>
<table class="viewForm">
<col class="label" />
<tbody>
  <tr>
    <td class="label"><fmt:message key="name" />:</td>
    <td><input name="name" class="wide" maxlength="50" /></td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="2" align="center"><input type="submit" value="<fmt:message key="submit" />"></td>
  </tr>
</tfoot>
</table>
</scannell:form>

</body>
</html>
