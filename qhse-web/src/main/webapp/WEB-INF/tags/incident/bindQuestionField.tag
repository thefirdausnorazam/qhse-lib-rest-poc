<%@ tag language="java" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" body-content="scriptless"  %>
<%@ attribute name="name" required="true" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="required" required="true" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="question" required="true" rtexprvalue="true" type="com.scannellsolutions.modules.system.domain.Question" %>
<%@ attribute name="labelOverride" required="false" rtexprvalue="true" type="java.lang.String"  %>
<%@ attribute name="style" required="false" rtexprvalue="true" type="java.lang.String"  %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="configured" value="${incidentAvailableFieldsByName[name] != null}" />
<c:set var="fieldValue" value="${command.incident[name]}" />
<c:set var="q" value="${question}" />
<!-- always show existing fields if they have a value -->
<c:set var="displayed" value="${configured || (fieldValue != null && fieldValue != '' && not empty fieldValue)}" />


<c:set var="label" value="${name}" />
<c:if test="${labelOverride != null}">
  <c:set var="label" value="${labelOverride}" />
</c:if>

<c:if test="${displayed}">
<c:choose>
  <c:when test="${q != null and q.active and q.visible}">
	<div class="form-group">
		<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="${label}" /></label>
    <div class="col-sm-6">
      <spring:bind path="${name}">
        <jsp:doBody />
		<c:if test="${required}"><span class="requiredHinted">*</span></c:if>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
     </div>
  </div>
  </c:when>
  <c:otherwise>
        <div class="form-group">
		<label class="col-sm-3 control-label scannellGeneralLabel nowrap"><fmt:message key="${label}" /></label>
			     <div class="col-sm-6">
			        <select name="name" style="float:left;width:80%">
			            <option value=""><fmt:message key="blankOption" /></option>
			          </select>
			        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
			     </div>
  </div>
  </c:otherwise>
</c:choose>
</c:if>
