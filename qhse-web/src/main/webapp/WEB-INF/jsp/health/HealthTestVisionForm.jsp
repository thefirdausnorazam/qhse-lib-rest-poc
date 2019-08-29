<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title><fmt:message key="healthTestVisionForm.title" /></title>
  <script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
  <style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";

		TABLE.vision TH, TABLE.vision td {
			text-align: center;
			vertical-align: middle;
		};
  </style>
</head>
<body>

<scannell:form>
<table class="viewForm">
<tbody>
  <c:if test="${test.id != null}">
  <tr>
    <td class="label"><fmt:message key="id" />:</td>
    <td>
      <scannell:hidden path="id" />
      <scannell:hidden path="version" />
      <c:out value="${test.id}" />
    </td>

    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  </c:if>

  <tr>
    <td class="label"><fmt:message key="healthRecord.person" />:</td>
    <td><c:out value="${command.record.person.displayName}" /></td>

    <td class="label"><fmt:message key="healthRecord.department" />:</td>
    <td><c:out value="${command.record.department.name}" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthTest.testDate" />:</td>
    <td colspan="3">
      <input name="testDate" id="testDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'testDate', true);">
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthTest.testReason" />:</td>
    <td colspan="3"><scannell:textarea path="testReason" cols="75" rows="3" /></td>
  </tr>


  <tr>
    <td class="label"><fmt:message key="healthTestVision.checks" />:</td>
    <td>
    	<scannell:checkbox path="correctiveLenses" /><fmt:message key="healthTestVision.correctiveLenses" /><br>
    	<scannell:checkbox path="spectables" /><fmt:message key="healthTestVision.spectables" /><br>
    	<scannell:checkbox path="contactLenes" /><fmt:message key="healthTestVision.contactLenes" /><br>
		</td>
    <td>
    	<scannell:checkbox path="farVision" /><fmt:message key="healthTestVision.farVision" /><br>
    	<scannell:checkbox path="nearVision" /><fmt:message key="healthTestVision.nearVision" /><br>
		</td>
    <td>
    	<scannell:checkbox path="biFocal" /><fmt:message key="healthTestVision.biFocal" /><br>
    	<scannell:checkbox path="variFocal" /><fmt:message key="healthTestVision.variFocal" />
		</td>
  </tr>

	<tr>
		<td></td>
		<td colspan="3">

<table border="1" class="vision" style="border: thin double;">
<tr>
	<td style="border-bottom: none;">&nbsp;</td>
	<th style="border-bottom: none;" colspan="3" ><fmt:message key="healthTestVision.farVision" /></th>
	<th style="border-bottom: none;"><fmt:message key="healthTestVision.intermediate" /></th>
	<th style="border-bottom: none;" colspan="3"><fmt:message key="healthTestVision.nearVision" /></th>
</tr>
<tr>
	<td style="border-top: none;"></td>
	<th style="border-top: none;"><fmt:message key="healthTestVision.right" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.left" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.binoc" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.binoc" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.right" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.left" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.binoc" /></th>
</tr>

<tr>
	<th><fmt:message key="healthTestVision.corrected" /></th>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="correctedFarRight" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="correctedFarLeft" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="correctedFarBinoc" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="correctedIntermediateBinoc" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="correctedNearRight" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="correctedNearLeft" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="correctedNearBinoc" /></td>
</tr>

<tr>
	<th><fmt:message key="healthTestVision.uncorrected" /></th>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="unCorrectedFarRight" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="unCorrectedFarLeft" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="unCorrectedFarBinoc" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="unCorrectedIntermediateBinoc" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="unCorrectedNearRight" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="unCorrectedNearLeft" /></td>
	<td><scannell:input writeRequiredHint="false" class="narrow" path="unCorrectedNearBinoc" /></td>
</tr>
</table>

		</td>
	</tr>

  <tr>
    <td class="label"><fmt:message key="healthTestVision.testPassed" />:</td>
    <td colspan="3"><scannell:checkbox path="testPassed" /></td>
  </tr>


  <tr>
    <td class="label"><fmt:message key="healthTest.notes" />:</td>
    <td colspan="3"><scannell:textarea path="notes" cols="75" rows="3" /></td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="healthTest.retestDate" />:</td>
    <td colspan="3">
      <input name="retestDate" id="retestDate" readonly="true" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'retestDate', true);">
    </td>
  </tr>


  <tr>
  <c:choose>
  <c:when test="${command.createdByUser != null}">
    <td class="label"><fmt:message key="createdBy" />:</td>
    <td><c:out value="${command.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${command.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>

  <c:choose>
  <c:when test="${command.lastUpdatedByUser != null}">
    <td class="label"><fmt:message key="lastUpdatedBy" />:</td>
    <td><c:out value="${command.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${command.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
  </c:when>
  <c:otherwise>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </c:otherwise>
  </c:choose>
  </tr>
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" value="<fmt:message key="submit" />">
      <input type="button" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/health/recordView.htm"><c:param name="id" value="${command.record.id}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</scannell:form>

</body>
</html>
