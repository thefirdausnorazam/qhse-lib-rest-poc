<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
	<head>
		<style type="text/css" media="all">
			@import "<c:url value='/css/doccontrol.css'/>";
		</style>
		<script type="text/javascript">
			function download(){
			    jQuery("#acceptAck").prop("disabled",false);
			    jQuery("#declineAck").prop("disabled",false);
			}
			function setAcceptValue(val){
				jQuery("#accepted").val(val);
				jQuery("form").submit(function() {
					// submit more than once return false
					jQuery(this).submit(function() {
						return false;
					});
					// submit once return true
					return true;
				});
			}
			
		</script>
	</head>
	<body>
		<div class="content"> 
			<div class="form-group" style="width: 40%; margin: 0px auto;">
				<a target="attachment" href="<c:url value="downloadDocument.htm">
						<c:param name="docRevisionId" value="${command.docRevision.id}" />
					</c:url>">
					<button type="button" class="g-btn g-btn--primary"  onclick="download();">
						<i class="fa fa-download" style="color: white"></i>
						<fmt:message key="docControl.download" />
					</button>
				</a>
			</div>
			<scannell:form id="ackForm" >
				<scannell:hidden path="id" />
				<scannell:hidden path="version" />
				<scannell:hidden id="accepted" path="accepted" />
				<div class="form-group" style="width: 40%; margin: 0px auto;">
					<button id="acceptAck" type="submit" class="g-btn g-btn--primary ack" value="true" onclick='setAcceptValue(true);' disabled>
						<i class="fa fa-check" style="color: white"></i>
						<fmt:message key="doccontrol.trainee.accept" />
					</button>
				</div>
				<%-- <div class="form-group" style="width: 45%; margin: 0px auto;">
					<button id="declineAck" type="submit" class="g-btn g-btn--primary ack" value="true" onclick='setAcceptValue(false);' disabled>
						<i class="fa fa-times" style="color: white"></i>
						<fmt:message key="doccontrol.trainee.decline" />
					</button>
				</div> --%>
			</scannell:form>
			<%-- <div class="form-group" style="text-align:center">
				<h3><fmt:message key="doccontrol.trainee.acknowledgementNotification" /></h3>
			</div> --%>
		</div>
	</body>
</html>
