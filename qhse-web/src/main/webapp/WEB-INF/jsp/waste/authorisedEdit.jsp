<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="${authorisedType}Edit" />
<c:if test="${command.id == 0}">
  <c:set var="title" value="${authorisedType}Create" />
</c:if>
<title><fmt:message key="${title}" /></title>

</head>
<body>

<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="form-group">
<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="name" /></label>
<div class="col-sm-6">
<input name="name" cssStyle="width:80%" class="form-control" />
</div>
</div>

<div class="form-group">
<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="address" /></label>
<div class="col-sm-6">
<scannell:textarea path="address" cssStyle="width:80%" class="form-control" />
</div>
</div>

<div style="clear: both;"></div>

<div class="form-group">
<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="phoneNumber" /></label>
<div class="col-sm-6">
<scannell:textarea path="phoneNumber" cssStyle="width:80%" class="form-control" />
</div>
</div>

<div class="form-group">
<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="emailAddress" /></label>
<div class="col-sm-6">
<input name="emailAddress" cssStyle="width:80%"/>
</div>
</div>
 <c:if test="${authorisedType == 'consignee'}">
<div class="form-group">
<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="disposalLocation" /></label>
<div class="col-sm-6">
<input name="disposalLocation" cssStyle="width:80%" />
</div>
</div>

<div class="form-group">
<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="treatmentTypes" /></label>
<div class="col-sm-6">
 <scannell:selectList items="${treatmentTypes}" path="treatmentTypes" cssStyle="width:80%" itemValue="id" />
</div>
</div>      
</c:if>
<div style="clear: both;"></div>
<div class="spacer2 text-center ">
<button type="submit" class="g-btn g-btn--primary"><fmt:message key="submit" /></button>
</div>
</div>
</div>
</scannell:form>

</body>
</html>
