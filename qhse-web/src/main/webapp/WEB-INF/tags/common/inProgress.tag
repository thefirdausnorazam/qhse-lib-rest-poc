<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Loading Modal -->
<div class="modal fade" id="inProgress" role="dialog" 
	data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-sm" style="z-index: 1100;">
    <div class="modal-content">
      <div class="modal-body text-center">
        <div class="loader"></div>
		<div class="row">
			<div class="col-lg-3 col-centered"></div>
		</div>
        <div class="loader-txt">
          <p><fmt:message key="admin.sync.pleaseWait" /></p>
        </div>
      </div>
    </div>
  </div>
</div>