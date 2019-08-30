<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- Modal -->
<div id="updateQuestions" class="modal fade" role="dialog"
	data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog  modal-lg" style="z-index: 1100;">
		<div class="modal-content">
			<div class="modal-header" style="border-bottom: 2px solid #0084b4;">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
				<h5 class="modal-title"><fmt:message key="auditView.questionsUpdated"/></h5>
			</div>
			<div class="modal-body">
				<div class="col-lg-12">
					<span  style="font-size: 30px;" class="fa fa-bell unchecked"></span> 
					<fmt:message key="auditView.questionsUpdatedMsg"/></br></br>
				<div class="col-lg-12">
					<fmt:message key="auditView.questionsUpdatedWarning"/>
				</div>
					</span>
					
				</div>
				<div class="row">
					<div class="col-centered"></div>
				</div>
			</div>
			<div class="modal-footer">
				
				<button type="button" id="update" class="g-btn g-btn--primary"
					data-dismiss="modal" ><fmt:message key="yes"/>
				</button>
				<button type="button" id="noUpdate" class="g-btn g-btn--primary"
					data-dismiss="modal"><fmt:message key="no"/>
				</button>
			</div>
		</div>

	</div>
</div>