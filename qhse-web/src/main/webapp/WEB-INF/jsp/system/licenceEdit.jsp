<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<script type="text/javascript">
function checkAll(tick) {
     var theForm = tick.form, z = 0;
	 for(z=0; z<theForm.length;z++){
      if(theForm[z].type == 'checkbox' && theForm[z].name != 'checkall'){
	  theForm[z].checked = tick.checked;
	  }
     }
    }
</script>
</head>
<body>
<div class="header">
<h2><fmt:message key="licenceEdit" /></h2>
</div>

<scannell:form>
  <scannell:hidden path="id"/>

 <div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
    <col  />
    <tbody>
 	    <tr>
        <td ><fmt:message key="name" />:</td>
        <td><c:out value="${command.name}" /></td>
      </tr>

      <tr>
        <td ><fmt:message key="users" />:</td>
        <td>
          <spring:bind path="command.users">
            <c:forEach items="${users}" var="user">
              <c:set var="selected" value="${false}" />
              <c:forEach items="${command.users}" var="selectedUser">
                <c:if test="${user.id == selectedUser.id}"><c:set var="selected" value="${true}" /></c:if>
              </c:forEach>
              <input type="checkbox" name="<c:out value="${status.expression}"/>" value="<c:out value="${user.id}" />" <c:if test="${selected}">checked="checked"</c:if> />
                <span><c:out value="${user.lastName}, ${user.firstName}" /></span><br />
            </c:forEach>
             <input type="checkbox" name="checkall" onclick="checkAll(this);"/>Select/Unselect all (At least one user must be selected before saving)
           <scannell:errors path="users"/>
          </spring:bind>
        </td>
      </tr>

    </tbody>
    <tfoot>
      <tr>
        <td colspan="2" align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="submit" />"></td>
      </tr>
    </tfoot>
  </table>
</div>
</div>
</div>

</scannell:form>

</body>
</html>
