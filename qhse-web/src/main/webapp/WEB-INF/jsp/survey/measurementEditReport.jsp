<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>

<head>

<title><fmt:message key="editReport" /></title>

</head>
<body>

<scannell:form id="form">
<div class="content">
<div class="table-responsive">

<table id="tableMeasurementReadingsInfo" class="table table-bordered table-responsive" style="width: 100%; border-top: 1px solid #DADADA;">
	<thead>
		<tr>
			<td colspan="4">
				<h3 style="color:red;"><fmt:message key="trashReport" /></h3>
			</td>
		</tr>
	</thead>
  <tr>
    <th class="scannellGeneralLabel nowrap"><fmt:message key="id" />:</th>
    <td><c:out value="${command.id}" /></td>
  </tr>
    <tr>
    <th class="scannellGeneralLabel nowrap"><fmt:message key="title" />:</th>
    <td><c:out value="${command.title}" /></td>
  </tr>
   <tr>
    <th class="scannellGeneralLabel nowrap"><fmt:message key="addLicenseReference" />:</th>
    <td>
    	 <c:out value="${command.licenseReference}" />
     </td>
  </tr>
   <tr>
    <th class="scannellGeneralLabel nowrap"><fmt:message key="readingPoint" />:</th>
    <td>
    	 <c:out value="${command.selectedMeasurementWithLogicalVariables[0].measurement.readingPoint.description}" />
     </td>
  </tr>
     <tr >
    <th class="scannellGeneralLabel nowrap"><fmt:message key="reportingType" />:</th>
    <td >
 		<c:out value="${command.period}" />
    </td>
  </tr>
     <tr>
    <th class="scannellGeneralLabel nowrap "><fmt:message key="createdBy" />:</th>
    <td><c:out value="${command.createdByUser.displayName}" /></td>
  </tr>
       <tr>
    <th class="scannellGeneralLabel nowrap"><fmt:message key="createdTs" />:</th>
    <td><c:out value="${command.createdTs}" /></td>
  </tr>
</table>
</div>
</div>
<div style="clear: both;"></div>
<div class="spacer2 text-center">
<button type="submit" id="submitButton" class="g-btn g-btn--primary" >
<fmt:message key="trash" />
</button>
	<a href="<c:url value="measurementViewReport.htm"><c:param name="id" value="${command.id}"/></c:url>" class="g-btn g-btn--primary" >
		<fmt:message key="cancel" />
	</a>
</div>
</scannell:form>
</body>
</html>
