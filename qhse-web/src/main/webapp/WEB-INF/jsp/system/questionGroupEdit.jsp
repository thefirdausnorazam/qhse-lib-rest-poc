<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<c:set var="title" value="questionGroupEdit" />
<c:if test="${command.id == null}">
	<c:set var="title" value="questionGroupCreate" />
</c:if>
	<title></title>

	<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
	<script type="text/javascript">
	jQuery(document).ready(function() {	 
	jQuery('#newQuestionId').select2();
	});
	</script>
	<script type="text/javascript" >
	
	<!--
	function addQuestion() {
		// check to see if the question was already added
		var questionId = document.getElementById('newQuestionId'); 

		//Add the new question
		SystemDWRService.getQuestion(jQuery('#questionId').val(), function(data) { populateQuestionCallback(data); });
	}

	function populateQuestionCallback(data) {
		var table = document.getElementById('questionTable');
		var rowTemplate = document.getElementById('questionTableRow');

		var row = table.tBodies[0].insertRow(-1);
		for (var i = 0; i < rowTemplate.cells.length; i++) {
			var cell = row.insertCell(i);

			var str = rowTemplate.cells[i].innerHTML;
			str = replace(str, "questionId"     , data.id);
			str = replace(str, "questionCode"   , data.codeName);
			str = replace(str, "questionName"   , data.name);
			str = replace(str, "questionActive" , data.active ? "Yes" : "No");
			str = replace(str, "questionVisible", data.visibile ? "Yes" : "No");
			cell.innerHTML = str;
		}
	}

	function removeQuestion(targetRow) {
		if (targetRow != null) {
			var table = getParent("table", targetRow);
			table.deleteRow(targetRow.rowIndex);
		}
	}

	function replace(str, val, x) {
		while(str.indexOf(val) > -1) {
			str = str.replace(val, x);
		}
		return str;
	}

	// -->
	</script>
</head>
<body>
<div class="header">
<h2><fmt:message key="${title}" /></h2>
</div>
<scannell:form>
<scannell:hidden path="id"/>
<scannell:hidden path="version"/>
<div class="content">
<div class="table-responsive">
<div class="panel">
<table class='table table-responsive table-bordered'>
		<tbody>
			<tr class="form-group">
				<th class="searchLabel"><fmt:message key="codeName" /></th>
				<td class="search"><input name="codeName" class="form-control" cssStyle="width:40%" /></td>
			</tr>

			<tr class="form-group">
				<th class="searchLabel"><fmt:message key="displayName" /></th>
				<td class="search"><input name="name" class="form-control" cssStyle="width:40%" /></td>
			</tr>

			<tr class="form-group">
				<th class="searchLabel"><fmt:message key="active" /></th>
				<td class="search"><scannell:checkbox path="active" /></td>
			</tr>

			<tr class="form-group">
				<th class="searchLabel"><fmt:message key="questions" /></th>
				<td class="search" colspan="3">
					<table class='table table-responsive table-bordered' id="questionTable">
					<thead>
						<tr>
							<th><fmt:message key="codeName" /></th>
							<th><fmt:message key="displayName" /></th>
							<th><fmt:message key="active" /></th>
							<th><fmt:message key="visible" /></th>
							<th>&nbsp;</th>
						</tr>
					</thead>

					<tbody>
					<c:forEach items="${command.questions}" var="question" varStatus="s">
						<tr>
							<td>
								<input type="hidden" name="questions" value="<c:out value="${question.id}"/>">
								<!--
								<input type="hidden" name="questions[<c:out value="${s.index}"/>]" value="<c:out value="${question.id}"/>">
								<scannell:hidden path="questions[${s.index}].id" />
								-->
								<a href="<c:url value="questionView.htm"><c:param name="id" value="${question.id}" /></c:url>"><c:out value="${question.codeName}" /></a>
							</td>
							<td><c:out value="${question.name}" /></td>
							<td><fmt:message key="${question.active}" /></td>
							<td><fmt:message key="${question.visible}" /></td>
							<td onclick="deleteRow(this.row)">
								<button type="button" class="delete btn btn-primary" onclick="deleteRow(getParent('tr',this));"><fmt:message key="deleteShort" /></button>
							</td>
						</tr>
					</c:forEach>
					</tbody>

					<tfoot>
						<tr>
							<td colspan="5" align="center">
								<select id="newQuestionId" name="newQuestionId" class="wide">
									<c:forEach var="q" items="${questionList}">
									<option value="<c:out value="${q.id}"/>"><c:out value="${q.name}"/></option>
									</c:forEach>
								</select>
								<input type="button" class="g-btn g-btn--primary" value="<fmt:message key="add" />" onclick="addQuestion()">
							</td>
						</tr>
					</tfoot>
					</table>
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

<table style="display: none;" class='table table-responsive table-bordered'>
<tr id="questionTableRow">
	<td>
		<input type="hidden" name="questions" value="questionId">
		<a href="<c:url value="questionView.htm"/>?id=questionId">questionCodeName</a>
	</td>
	<td>questionName</td>
	<td>questionActive</td>
	<td>questionVisible</td>
	<td onclick="deleteRow(this.row)" ><button type="button" class="g-btn g-btn--primary" class="delete" onclick="deleteRow(getParent('tr',this));"><fmt:message key="deleteShort" /></button></td>
</tr>
</table>


</body>
</html>
