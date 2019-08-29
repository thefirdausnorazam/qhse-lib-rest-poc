<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title> </title>
</head>
<body>
<div class="header">
<h2><fmt:message key="userChangePassword" ><fmt:param value="${user.description}" /><fmt:param value="${user.name}" /></fmt:message></h2>
</div>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
    
    <thead>
      <tr>
        <td><fmt:message key="userChangedPassword" /></td>
      </tr>
  </table>
</div>
</div>
</div>
</body>
</html>
