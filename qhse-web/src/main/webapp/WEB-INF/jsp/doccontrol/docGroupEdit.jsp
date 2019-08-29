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
	<title>	
		<c:choose>
			<c:when test="${empty command.name && command.parentDocGroup.id > 0}"><fmt:message key="doccontrol.addSubDocGroup" /></c:when>
			<c:when test="${empty command.name}"><fmt:message key="doccontrol.addDocGroup" /></c:when>
			<c:otherwise><fmt:message key="doccontrol.editDocGroup" /></c:otherwise>
		</c:choose>
	</title>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script language="javascript" src="<c:url value="/js/doccontrol.js" />"> </script>

	<script type="text/javascript">
		var rootId = getSearchParams("rootId");
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
			jQuery('select').not('#siteLocation').select2({width:'75%'});
			onParentChange();
		});
		
		function toggle(source) {
			  checkboxes = document.getElementsByName('activeInSites');
			  for(var i=0, n=checkboxes.length;i<n;i++) {
				    checkboxes[i].checked = source.checked;
				  }
			
		}
		
		function onParentChange() {
			if (jQuery('#parentDocGroup').val() > 0) {
				jQuery('#configureSites').hide();
			
			} else {
				jQuery('#configureSites').show();
			}
		}
		
		function getCancelUrl(){
			if(rootId) {
				closeme();
			}
			else if('${command.parentDocGroup.id}') {
				window.location=contextPath + '/doccontrol/docGroupView.htm?id=${command.parentDocGroup.id}';
			}
			else {
				window.history.go(-1);
			}
		}
		
	</script>
</head>
<body>
	<scannell:form >
		<scannell:hidden path="id" />
		<scannell:hidden path="version" />
		<scannell:hidden path="status" />
		<c:set var="allowcreateRoot" value="${rootAccess && ((command.id > 0) || (sitesAvailable))}"/>
		<input type="hidden" name="userDefaultSite"/>

		<c:if test="${rootAccess || (command.id == 0 && !empty docGroups) || (command.id != 0 && command.parentDocGroup != null)}">
			<div class="form-group">
				<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
					<fmt:message key="docControl.parent" />:
				</label>
				<c:choose>
					<c:when test="${command.id == 0 && command.parentDocGroup.id > 0}">
						<label class="col-sm-6 control-label scannellGeneralLabel nowrap" style="text-align: left;">
							<c:out value="${command.parentDocGroup.prefix}"/>: <c:out value="${command.parentDocGroup.name}"/> 
							<c:set var="allowcreateRoot" value="false"/>
						</label>
					</c:when>
					<c:when test="${allowcreateRoot}">
						<!-- Allow user change root directory as sub directory -->
						<div class="col-sm-6">
							<select name="parentDocGroup" id="parentDocGroup" renderEmptyOption="true" items="${docGroups}" itemLabel="displayName" itemValue="id" onchange="onParentChange();" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="col-sm-6">
							<select name="parentDocGroup" id="parentDocGroup" renderEmptyOption="false" items="${docGroups}" itemLabel="displayName" itemValue="id" onchange="onParentChange();" />
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>
				
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="doccontrol.docGroupSearchForm.prefix" />:
			</label>
			<div class="col-sm-6">
				<input name="prefix" cssStyle="float:left;width:75%" class="form-control" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="name" />:
			</label>
			<div class="col-sm-6">
				<input name="name" cssStyle="float:left;width:75%" class="form-control" />
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-3 control-label scannellGeneralLabel nowrap">
				<fmt:message key="frequency" />:
			</label>
			<div class="col-sm-6">
				<select name="frequency" id="frequency" lookupItemLabel="true" renderEmptyOption="true" items="${frequencies}" itemLabel="label" itemValue="name" />
			</div>
		</div>
		
		<c:if test="${allowcreateRoot}">
			<div id="configureSites">
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
									<c:forEach items="${userSites}" var="enabledSite">
										<c:if test="${site.id == enabledSite.id}"><c:set var="enabled" value="${true}" /><c:set var="msg" value="" /></c:if>
									</c:forEach>
									<c:forEach items="${rootSites}" var="rootSite">
										<c:if test="${site.id == rootSite.id}"><c:set var="enabled" value="${false}" /><c:set var="msg" value="${rootExistsMsg}" /></c:if>
									</c:forEach>
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
			</c:if>
		
		<div class="spacer2 text-center">
			<input class="g-btn g-btn--primary" type="submit"  value="<fmt:message key="submit" />">
			<button type="button" class="g-btn g-btn--secondary" onclick="getCancelUrl()"><fmt:message key="cancel" /></button>
		</div>
	</scannell:form>

</body>
</html>
