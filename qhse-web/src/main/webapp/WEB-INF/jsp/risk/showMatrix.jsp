<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
  

<c:if test="${matrix != null and attachment.active == true}">
	<div class="header">
		<h3> <fmt:message key="riskMatrix" /></h3>
		</div>
		<div class="content"> 
			<div class="table-responsive">
			<div class="panel panel-danger"> 
				<table class="table table-bordered table-responsive">
				<col class="label" />
				<tbody>
				  <tr>
					<td align="center"><img class="printImageSize matrixImageSize" src="data:image/jpg;base64,${matrix}" alt="${attachment.name}"/></td>
				  </tr>
				  <tr>
					<td class="center-label"> <c:out value="${attachment.description}"/></td>
				  </tr>
				</tbody>
				</table>
			</div>
		</div>
	</div>
</c:if>
