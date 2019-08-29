<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="doccontrol" tagdir="/WEB-INF/tags/doccontrol"%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="printable" content="true">
		<title></title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script language="javascript" src="<c:url value="/js/doccontrol.js" />"> </script>
		<style type="text/css" media="all">
			@import "<c:url value='/css/doccontrol.css'/>";
			@import "<c:url value='/css/material-icons.css'/>";
			@import "<c:url value='/css/tree.css'/>";
		</style>
		<script type="text/javascript">
			var trash = '${action != "reopen" && action != "untrash"}';
			var dgId = "${docGroup.id}";
			
			jQuery(document).ready(function(){
				jQuery(".docButton").click(function(){
					jQuery(this).toggleClass("papers").toggleClass("nopaper").end();
					animateJumpTo(jQuery(this).attr('id'));
				});
				jQuery('.action').click(function () {
					jQuery('#changeChildrenStatus').val(jQuery(this).data('change'));
					if(!jQuery(this).data('change') && trash == "true"){ 
						return confirm("<fmt:message key='doccontrol.docGroup.changeStatusWarning'/>");
					}
				});
				//Show title on button only if trashing/archiving
				if(trash == "true") {
					jQuery(".docGroupOnly").attr('title', '<fmt:message key="doccontrol.docGroup.moveDocsToParent"/>');
				}
				//Highligh affected Doc Groups
				jQuery(".docGroupOnly").mouseenter(function() {
					  jQuery(".tree a#"+dgId).addClass("trashDocGroup");
				});
				jQuery(".docGroupOnly").mouseleave(function() {
					  jQuery(".tree a#"+dgId).removeClass("trashDocGroup");
				});
				jQuery(".docGroupWithChildren").mouseenter(function() {
					  jQuery(".tree a").addClass("trashDocGroup");
				});
				jQuery(".docGroupWithChildren").mouseleave(function() {
					  jQuery(".tree a").removeClass("trashDocGroup");
				});
			});
		</script>
	</head>
	<body>
		<c:set var="prefix" value="${docGroup.prefix}"/>
		<c:set var="emptyDG" value="${empty docGroup.children && empty docGroup.documentsByStatus}"/>
		<div class="header">
			<h2><span class="nowrap"><fmt:message key="${action}" /> <fmt:message key="docGroupBC" /></span></h2>
		</div>
		<div class="content">
			<div class="table-responsive">
				<table class="table table-bordered table-responsive">	
					<col />		
					<tbody>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="id" />:</td>
							<td><c:out value="${docGroup.id}" /></td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="doccontrol.docGroupSearchForm.prefix" />:</td>
							<td>
								<c:out value="${docGroup.prefix}" />
							</td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="name" />:</td>
							<td>
								<c:out value="${docGroup.name}" />
							</td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="frequency" />:</td>
							<td>
								<c:out value="${docGroup.frequency}" />
							</td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="status" />:</td>
							<td>
								<fmt:message key="${docGroup.status}" />
							</td>
						</tr>
						<tr>
							<td class="scannellGeneralLabel"><fmt:message key="createdBy" />:</td>
							<td><c:out value="${docGroup.createdByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${docGroup.createdTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
						</tr>
						<c:if test="${docGroup.lastUpdatedByUser != null}">
							<tr>
								<td class="scannellGeneralLabel"><fmt:message key="lastUpdatedBy" />:</td>
								<td><c:out value="${docGroup.lastUpdatedByUser.displayName}" /> <fmt:message key="at" /> <fmt:formatDate value="${docGroup.lastUpdatedTs}" pattern="dd-MMM-yyyy HH:mm:ss" /></td>
							</tr>
						</c:if>
				</tbody>
			</table>
			<div style="color: red; text-align: left; font-weight: bold"><h3>***  <fmt:message key="doccontrol.docGroup.changeStatus.warning"/>  ***</h3></div>
			
			<div style="clear: both;"></div>
			<div class="tree" style="vertical-align: middle " >
				<ul><doccontrol:docGroupDetailedNode docGroup="${docGroup}"/> </ul>
			</div>
			<div style="clear: both;"></div>
			<scannell:form>
				<scannell:hidden id="changeChildrenStatus" path="changeChildrenStatus" />
				<div class="spacer2 text-center">
					<c:choose>
						<c:when test="${emptyDG}">
							<input class="g-btn g-btn--primary action docGroupOnly" type="submit" data-change="true" value="<fmt:message key="${action}"/>: <fmt:message key="doccontrol.docGroup.label"/>">
						</c:when>
						<c:otherwise>					
							<c:if test="${docGroup.parentDocGroup != null}">
								<input class="g-btn g-btn--primary action docGroupOnly" type="submit" data-change="false"  value="<fmt:message key="${action}"/>: '<c:out value="${prefix}"/>' <fmt:message key="doccontrol.docGroup.changeStatusOnly"/>">
							</c:if>
							<input class="g-btn g-btn--primary action docGroupWithChildren" type="submit" data-change="true" value="<fmt:message key="${action}"/>: <fmt:message key="doccontrol.docGroup.changeStatusChildren"/>">
						</c:otherwise>
					</c:choose>
					<button type="button" class="g-btn g-btn--secondary" onclick="window.history.go(-1)"><fmt:message key="cancel" /></button>
				</div>
			</scannell:form>
		</div>
	</div>

	</body>
</html>
