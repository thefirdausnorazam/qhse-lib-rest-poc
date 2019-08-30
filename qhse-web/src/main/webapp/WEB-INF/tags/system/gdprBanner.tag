<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ tag import="com.scannellsolutions.modules.system.domain.SystemConfigUtil"%>

	<c:set var="msg"><%=SystemConfigUtil.getGDPRBanner()%></c:set>

	<c:if test="${msg != ''}">
		<div class="alert alert-warning myrow" style="padding: 5px 15px 0px 15px;">
			<div class="mycolumn" style="width: 2%;"><i class="fa fa-lock  fa-2x" aria-hidden="true"></i></div>
				<div id="bannerDiv" style="width: 98%;text-align: left;white-space: pre-wrap" class="mycolumn scannellGeneralLabel"><c:out value="${msg}"/>					
        		</div>
			</div>
		 
	</c:if>