<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="wasteTypeCategoryEdit" />
<c:if test="${command.id == null}">
  <c:set var="title" value="wasteTypeCategoryCreate" />
</c:if>
<title><fmt:message key="${title}" /></title>
<script type="text/javascript">
jQuery(document).ready(function() {	  
	jQuery('#categories').select2({width:'80%'});
});
</script>

</head>
<body>
<!-- <div class="header"> -->
<%-- <h2><fmt:message key="${title}" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="form-group">
<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="name" /></label>
<div class="col-sm-6">
<input name="name" cssStyle="width:80%" class="form-control" />
</div>
</div>
<div class="form-group">
<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="categoryClass" /></label>
<div class="col-sm-6">
<scannell:select id="categories" path="categoryClass" items="${categoryClassList}" itemValue="id" itemLabel="name" emptyOptionValue="" emptyOptionLabel="Choose" class="wide" />
</div>
</div>
<div class="form-group">
<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="additionalInfo" /></label>
<div class="col-sm-6">
<scannell:textarea path="additionalInfo" cssStyle="width:80%" />
</div>
</div>

<div class="spacer2  text-center ">
 <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
</div>

</scannell:form>
</body>
</html>
