<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
		<style type="text/css">

	.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}
	</style>
</head>
<body>
<div class="header">
<h2><fmt:message key="licenceImport" /></h2>
</div>

<scannell:form enctype="multipart/form-data" errorMessageSeperator="<br/> - ">
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>

<tbody>
	<tr class="form-group">
		<th class="searchLabel"><fmt:message key="licenceServerIpAddress" />:</th>
		<td class="search">
			<span><c:out value="${serverIPAddress}"/></span>
		</td>
	</tr>
	<tr class="form-group">
		<th class="searchLabel"><fmt:message key="licence.file" />:</th>
		<td class="search">
			<span class="g-btn g-btn--primary btn-file">Choose File <input type="file" id="file" accept="*.licence" name="file" onchange='jQuery("#upload-file-info").html(jQuery(this).val());'></span>&nbsp;
			<span class='label label-info' id="upload-file-info"></span>
		</td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="2" style="text-align:center;">
			<button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
		</td>
	</tr>
</tfoot>
</table>
</div>
</div>
</div>
</scannell:form>
</body>
</html>
