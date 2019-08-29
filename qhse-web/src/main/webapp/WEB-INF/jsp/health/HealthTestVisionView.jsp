<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta name="printable" content="true">
	<title><fmt:message key="healthTestVisionView.title" /></title>
  <style type="text/css" media="all">
		TABLE.vision TH, TABLE.vision td {
			text-align: center;
			vertical-align: middle;
		};
	</style>
</head>
<body>

<a name="record"></a>
<table class="viewForm">
<tbody>
	<tr>
		<td class="label"><fmt:message key="id" />:</td>
		<td><c:out value="${test.id}" /></td>
	</tr>

	<c:url var="recordViewURL" value="/health/recordView.htm">
		<c:param name="id" value="${test.record.id}" />
	</c:url>
	<tr>
		<td class="label"><fmt:message key="healthRecord.person" />:</td>
		<td><a href="<c:out value="${recordViewURL}"/>"><c:out value="${test.record.person.displayName}" /></a></td>

		<td class="label"><fmt:message key="healthRecord.department" />:</td>
		<td><c:out value="${test.record.department.name}" /></td>
	</tr>

	<tr>
		<td class="label"><fmt:message key="healthTest.testDate" />:</td>
		<td colspan="3"><fmt:formatDate value="${test.testDate}" pattern="dd-MMM-yyyy HH:mm" /></td>
	</tr>

	<tr>
		<td class="label"><fmt:message key="healthTest.testReason" />:</td>
		<td colspan="3"><scannell:text value="${test.testReason}" /></td>
	</tr>

  <tr>
    <td class="label"><fmt:message key="healthTestVision.checks" />:</td>
    <td>
    	<fmt:message key="healthTestVision.correctiveLenses" />: <fmt:message key="${test.correctiveLenses}" /><br>
    	<fmt:message key="healthTestVision.spectables" />: <fmt:message key="${test.spectables}" /><br>
    	<fmt:message key="healthTestVision.contactLenes" />: <fmt:message key="${test.contactLenes}" /><br>
		</td>
		<td>
     	<fmt:message key="healthTestVision.farVision" />: <fmt:message key="${test.farVision}" /><br>
    	<fmt:message key="healthTestVision.nearVision" />: <fmt:message key="${test.nearVision}" /><br>
		</td>
		<td>
     	<fmt:message key="healthTestVision.biFocal" />: <fmt:message key="${test.biFocal}" /><br>
    	<fmt:message key="healthTestVision.variFocal" />: <fmt:message key="${test.variFocal}" />
		</td>
  </tr>

	<tr>
		<td>&nbsp;</td>
		<td colspan="3">
<table border="1" class="vision" style="border: thin">
<tr>
	<td style="border-bottom: none;">&nbsp;</td>
	<th style="border-bottom: none;" colspan="3" >Far Vision</th>
	<th style="border-bottom: none;">Intermediate</th>
	<th style="border-bottom: none;" colspan="3">Near Vision</th>
</tr>
<tr>
	<td style="border-top: none;">&nbsp;</td>
	<th style="border-top: none;"><fmt:message key="healthTestVision.right" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.left" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.binoc" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.binoc" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.right" /></th>
	<th style="border-top: none;"><fmt:message key="healthTestVision.left" /></th>
	<th style="border-top: none; "><fmt:message key="healthTestVision.binoc" /></th>
</tr>

<tr>
	<th><fmt:message key="healthTestVision.corrected" /></th>
	<td><c:out value="${test.correctedFarRight}" /></td>
	<td><c:out value="${test.correctedFarLeft}" /></td>
	<td><c:out value="${test.correctedFarBinoc}" /></td>
	<td><c:out value="${test.correctedIntermediateBinoc}" /></td>
	<td><c:out value="${test.correctedNearRight}" /></td>
	<td><c:out value="${test.correctedNearLeft}" /></td>
	<td><c:out value="${test.correctedNearBinoc}" /></td>
</tr>

<tr>
	<th><fmt:message key="healthTestVision.uncorrected" /></th>
	<td><c:out value="${test.unCorrectedFarRight}" /></td>
	<td><c:out value="${test.unCorrectedFarLeft}" /></td>
	<td><c:out value="${test.unCorrectedFarBinoc}" /></td>
	<td><c:out value="${test.unCorrectedIntermediateBinoc}" /></td>
	<td><c:out value="${test.unCorrectedNearRight}" /></td>
	<td><c:out value="${test.unCorrectedNearLeft}" /></td>
	<td><c:out value="${test.unCorrectedNearBinoc}" /></td>
</tr>
</table>
		</td>
	</tr>

  <tr>
    <td class="label"><fmt:message key="healthTestVision.testPassed" />:</td>
    <td colspan="3"><fmt:message key="${test.testPassed}" /></td>
  </tr>

	<tr>
		<td class="label"><fmt:message key="healthTest.notes" />:</td>
		<td colspan="3"><scannell:text value="${test.notes}" /></td>
	</tr>

	<tr>
		<td class="label"><fmt:message key="healthTest.retestDate" />:</td>
		<td colspan="3"><fmt:formatDate value="${test.retestDate}" pattern="dd-MMM-yyyy" /></td>
	</tr>

	<tr>
		<td class="label"><fmt:message key="createdBy" />:</td>
		<td><c:out value="${test.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${test.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>

		<c:if test="${test.lastUpdatedByUser != null}">
		<td class="label"><fmt:message key="lastUpdatedBy" />:</td>
		<td><c:out value="${test.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${test.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
		</c:if>
	</tr>
</tbody>

<tfoot>
	<tr><td colspan="4"><scannell:url urls="${urls}" /></td></tr>
</tfoot>
</table>

<%@include file="testAttachmentList.jsp" %>

</body>
</html>
