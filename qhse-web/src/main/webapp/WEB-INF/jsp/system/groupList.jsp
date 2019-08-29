<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title></title>

</head>
<body>
<div class="col-md-12">
	<div id="block" class="">
		<div>
			<div class="col-md-6">
			</div>
			<div class="col-md-12 col-sm-12">
				<div align="right">
					<input type="text" id="refreshCheck" value="no" style="display: none;">
					<c:if test="${addButtonEnabled == true }">
						<button type="button" class="g-btn g-btn--primary" onclick="location.href='groupEdit.htm'">
							<i class="fa fa-edit" style="color: white"></i>
							<fmt:message key="groupCreate" />
						</button>
					</c:if>
					<button  type="button" onclick="window.open(jQuery('#printParam').val(), '_blank')" class="g-btn g-btn--primary"><i class="fa fa-print" style="color:white"></i><span></span></button>
				</div>				
			</div>
		</div>
   	</div>
</div>
<div class="header">
<h2><fmt:message key="groupList" /></h2>
</div>
<div class="content">
<div style="padding-top: 1%;">
<scannell:url urls="${urls}" />
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">

<table class="table table-responsive table-bordered">  
  

  <tbody>
    <c:forEach items="${groups}" var="group" varStatus="s">
      <c:choose>
        <c:when test="${s.index mod 2 == 0}">
          <c:set var="style" value="even" />
        </c:when>
        <c:otherwise>
          <c:set var="style" value="odd" />
        </c:otherwise>
      </c:choose>
      <tr class="<c:out value="${style}" />">
        <td><a href="<c:url value="groupView.htm"><c:param name="id" value="${group.id}"/></c:url>" ><c:out value="${group.name}" /></a></td>
      </tr>
    </c:forEach>  
   </tbody>
  <tfoot>
    <tr>
      <td colspan="10"><scannell:url urls="${urls}" /></td>
    </tr>
  </tfoot>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
