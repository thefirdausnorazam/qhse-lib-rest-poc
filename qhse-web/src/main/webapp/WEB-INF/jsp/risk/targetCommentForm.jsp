<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
  <title><fmt:message key="targetCommentForm.title" /></title>
   <script type="text/javascript">
  		jQuery(document).ready(function(){
  				jQuery( "select[name='targetAchievement']" ).change(function(value){
					jQuery( this).attr('class',jQuery(this).val())
  				});			

  		 	  //jQuery('select').select2({width: '40%'});
  		}) 
   </script>
   <style type="text/css">
   .GREEN {
background-color: green;
}
.AMBER {
background-color: orange;
}
.RED {
background-color: red;
}   
   </style>
</head>
<body>
<!-- <div class="header nowrap"> -->
<%-- <h2><fmt:message key="targetCommentForm.title" /></h2> --%>
<!-- </div> -->
<scannell:form>
<div class="content">
<div class="table-responsive">
<div class="panel panel-danger">
<table class="table table-bordered table-responsive">
<tbody>
   <tr>
   <scannell:hidden path="id" />
   <scannell:hidden path="version" />
    <td class="scannellGeneralLabel nowrap"><fmt:message key="targetComment.comment" />:</td>
    <td colspan="3"><scannell:textarea path="comment" cols="75" rows="3" /></td>
  </tr>
  <tr>
    <td class="scannellGeneralLabel"><fmt:message key="targetComment.targetAchievement" />:</td>
    <td colspan="3"> 
           <spring:bind path="command.targetAchievement" >
                  <select name="<c:out value="${status.expression}"/>" style="width:100px" class="${status.value}">
                  <option id="blankOption" value=""><fmt:message key="blankChoose" /></option>
                    <c:forEach items="${targetAchievementList}" var="item">
                      <option value="<c:out value="${item.name}" />" class="${item.name}" 
                        <c:if test="${item.name == status.value}">selected="selected"</c:if>></option>
                    </c:forEach>
                  </select>
                   <span class="requiredHinted">*</span>
                  <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
           </spring:bind> 
	</td>
  </tr>
  
</tbody>

<tfoot>
  <tr>
    <td colspan="4" align="center">
      <input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />">
      <input type="button" class="g-btn g-btn--secondary" value="<fmt:message key="cancel" />" onclick="window.location='<c:url value="/risk/targetView.htm"><c:param name="id" value="${command.targetId}"/></c:url>'">
    </td>
  </tr>
</tfoot>
</table>
</div>
</div>
</div>

</scannell:form>