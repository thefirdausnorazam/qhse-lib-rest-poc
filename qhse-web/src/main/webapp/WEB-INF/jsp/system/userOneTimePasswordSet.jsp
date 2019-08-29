<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<div class="header">
	<h2>
		<fmt:message key="userOneTimePassword.title" >
			<fmt:param value="${theUser.description}" />
			<fmt:param value="${theUser.name}" />
		</fmt:message>
	</h2>
</div>
<div class="content">
	<div class="table-responsive">
		<div class="panel">
			<table class='table table-responsive table-bordered'>
		    	<thead>
		    		<tr>
		    			<td><fmt:message key="userOneTimePassword.successMessage" /></td>
		    		</tr>
		    	</thead>
		    </table>
		</div>
	</div>
</div>
