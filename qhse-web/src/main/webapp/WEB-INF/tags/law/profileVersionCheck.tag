<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="profile" required="true" type="com.scannellsolutions.modules.law.domain.LegacyProfile"%>
<%@tag import="com.scannellsolutions.users.UserUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>

<c:if test="${profile.requiresUpdateAndCurrentUserCanUpdate}">
<%-- <div class="content">
 
 <div>The database has been updated since you created your Profile. </div>
  If you want to update your Profile click <a target="_top" href="<law:profileManagerUrl editProfile="${profile}" />">here</a>
 
  </div> --%>
  
  <div class="alert alert-danger">
  <button type="button" data-dismiss="alert" aria-hidden="true" class="close">×</button>
  <i class="fa fa-times-circle sign"></i>
  <strong><fmt:message key="law.updateprofile" /></strong> 
  <fmt:message key="law.updateprofile.message" />&nbsp;<a target="_top" href="<law:profileManagerUrl editProfile="${profile}" />"><fmt:message key="here" />. </a>
  </div>
</c:if>

