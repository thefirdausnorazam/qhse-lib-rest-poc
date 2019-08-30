<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ attribute name="recordType" required="true" type="java.lang.String" %>

<!-- Modal -->
<div id="moveSiteModal" class="modal fade" role="dialog"
	data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog  modal-lg" style="z-index: 1100;">
		<div class="modal-content">
			<div class="modal-header" style="border-bottom: 2px solid #0084b4;">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
				<h5 class="modal-title"><span id="recordT"><fmt:message key="${recordType}" /></span> <fmt:message key="common.modal.changeSiteHeading" /></h5>
			</div>
			<div class="modal-body">
				<div class="col-lg-12">
					<span  style="font-size: 30px;" class="fa fa-bell unchecked"></span> 
					<fmt:message key="common.modal.changeSiteText" /> '<b><span class="changeSiteSite"></b>'</span>
				</div>
				<div class="row">
					<div class="col-lg-3 col-centered"></div>
				</div>
			</div>
			<div class="modal-footer">
				<span style="float:left;"><input id="moveSiteRememeberMe" type="checkbox" onclick="resetMoveSite()"/><fmt:message key="common.modal.changeSiteRemember" /></span>
				<button type="button" id="moveSiteYes" class="g-btn g-btn--primary"
					data-dismiss="modal" ><fmt:message key="yes"/>
				</button>
				<button type="button" id="moveSiteNo" class="g-btn g-btn--primary"
					data-dismiss="modal"><fmt:message key="no"/>
				</button>
			</div>
		</div>

	</div>
</div>