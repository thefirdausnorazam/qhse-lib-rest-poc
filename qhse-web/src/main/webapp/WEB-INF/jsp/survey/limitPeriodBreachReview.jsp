<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>
<div class="header">
<h2> <fmt:message key="limitPeriodBreachReview" /></h2>
</div>
<scannell:form>
<div class="content"> 
<div class="table-responsive">
<div class="panel">
<table class="table table-bordered table-responsive">
<col  />
<tbody>
	<c:if test="${command.limitPeriod.overrideEnabled}" >
	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="overrideQuestion" />:</td>
		<td class="search"><scannell:text value="${command.limitPeriod.overrideQuestion}" /></td>
	</tr>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="override" />:</td>
		<td class="search">
			<select name="override">
				<scannell:option value="true" labelkey="yes"/>
				<scannell:option value="false" labelkey="no"/>
			</scannell:select>
			<span "requiredHinted">*</span>
		</td>
	</tr>
	</c:if>

	<tr class="form-group">
		<td class="searchLabel"><fmt:message key="comment" />:</td>
		<td class="search"><scannell:textarea path="comment" cols="75" rows="3" /></td>
	</tr>
</tbody>

<tfoot>
	<tr>
		<td colspan="2" align="center"><button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button></td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
