<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>

<!DOCTYPE html>
<html>
<head>
	<title><fmt:message key="doccontrol.filterDocGroup" /></title>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script language="javascript" src="<c:url value="/js/doccontrol.js" />"> </script>

	<script type="text/javascript">
		var contextPath = '<%=request.getContextPath()%>';
		var rootExistsMsg = "<fmt:message key='doccontrol.docGroup.rootExists'/>";
		var noAccessMsg = "<fmt:message key='doccontrol.docGroup.noAccess'/>";
		
		jQuery(document).ready(function() {
			jQuery("form").submit(function() {
				// submit more than once return false
				jQuery(this).submit(function() {
					return false;
				});
				// submit once return true
				return true;
			});
		});
		
		function toggle(source) {
			  checkboxes = document.getElementsByName('activeInSites');
			  for(var i=0, n=checkboxes.length;i<n;i++) {
				    checkboxes[i].checked = source.checked;
				  }
			
		}
		
	</script>
</head>
<body>
	<scannell:form >
		<scannell:hidden path="id" />
		<scannell:hidden path="version" />
		<input type="hidden" name="userDefaultSite"/>

		<div id="configureSites">
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="id"/>:
				</label>
				<div class="col-sm-6" >
					<c:out value="${docGroup.id}" />
				</div>
			</div>
			<div style="clear: both;"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="name"/>:
				</label>
				<div class="col-sm-6" >
					<c:out value="${docGroup.name}" />
				</div>
			</div>
			<div style="clear: both;"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="frequency"/>:
				</label>
				<div class="col-sm-6" >
					<c:out value="${docGroup.frequency}" />
				</div>
			</div>
			<div style="clear: both;"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="status"/>:
				</label>
				<div class="col-sm-6" >
					<fmt:message key="${docGroup.status}" />
				</div>
			</div>
			<div style="clear: both;"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="template.selectAll"/>:
				</label>
				<div class="col-sm-6" >
					<input type="checkbox" onClick="toggle(this)" />
				</div>
			</div>
			
		
			<div class="form-group" style="overflow:auto;height: auto;">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="template.sites"/>:
				</label>
				<div class="col-sm-3" style="overflow: auto; ">
			      	<input type="hidden" name="_activeInSites" value="xxx" />
					<spring:bind path="command.activeInSites">
							<c:forEach items="${sites}" var="site"  varStatus="loop">
								<c:set var="selected" value="${false}" />
								<c:forEach items="${command.activeInSites}" var="selectedSite">
									<c:if test="${site.id == selectedSite.id}"><c:set var="selected" value="${true}" /></c:if>
								</c:forEach>
								<c:set var="enabled" value="${false}" />
								<c:set var="msg" value="${noAccessMsg}" />
								<c:if test="${enviromanager:contains(parentActiveSites, site)}">
									<c:if test="${enviromanager:contains(userSites, site)}">
										<c:set var="enabled" value="${true}" /><c:set var="msg" value="" />
									</c:if>
								</c:if>
									<c:choose>
										<c:when test="${enabled}">
											<input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${site.id}" />" <c:if test="${selected}">checked="checked"</c:if>/><span>&nbsp;<c:out value="${site.name}" /></span>
											<c:if test="${loop.last}"><span class="requiredHinted">*</span></c:if><br/>
										</c:when>
										<c:otherwise>
											<input type="checkbox" name="x" <c:if test="${selected}">checked="checked"</c:if> disabled="disabled"/><span>&nbsp;<c:out value="${site.name}" /></span><c:out value ="${msg}"/>
											<c:if test="${loop.last}"><span class="requiredHinted">*</span></c:if><br/>
											<c:if test="${selected}">
												<input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${site.id}" />" />
											</c:if>
										</c:otherwise>
									</c:choose>
							</c:forEach>
						
						<span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
					</spring:bind>
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>
		
		<div class="spacer2 text-center">
			<input class="g-btn g-btn--primary" type="submit"  value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
		</div>
	</scannell:form>

</body>
</html>
