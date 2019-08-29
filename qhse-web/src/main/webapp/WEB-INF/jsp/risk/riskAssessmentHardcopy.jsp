<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title></title>
<script type="text/javascript">
<!--
  function onChangeOpt(opt) {
    var box = document.getElementById("opt" + opt.id);
    if (box) {
      box.style.display = opt.checked ? "" : "none";
    }
  }
// -->
</script>
</head>
<body>
<div class="header">
<h3>Express Risk Assessment Form</h3>
</div>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive">
   <tbody>
    <tr class="hidden-print">
      <td >Select Hazards / Impacts:</td>
      <td>
        <div class="scrolllist">
        <c:forEach items="${options}" var="opt">
          <input type="checkbox" onclick="onChangeOpt(this)" id="<c:out value="${opt.id}" />"><c:out value="${opt.name}" /><br />
        </c:forEach>
        </div>
      </td>
    </tr>
    <tr>
      <td >Choose a Functional Group:</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td >Further Describe the Item:</td>
      <td><div class="answerTextBox"></div></td>
    </tr>
    <tr>
      <td >Responsible:</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td >Enter any other Participants:</td>
      <td>&nbsp;</td>
    </tr>
</tbody>
</table>
</div>
</div>
<c:forEach items="${options}" var="opt">
<div class="header">
<h3><c:out value="${opt.name}" /></h3>
</div>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive" id="<c:out value="opt${opt.id}" />" style="display: none; page-break-before: always;">
 
  <tbody>
  <c:forEach items="${scoringCategories}" var="scoringCategory">
    <tr>
      <td><c:out value="${scoringCategory.name}" /></td>
    </tr>
    <c:forEach items="${scoringCategory.questions}" var="scoringQuestion">
    <tr>
      <td>
        <c:out value="${scoringQuestion.name}" />:&nbsp;&nbsp;&nbsp;
        <c:forEach items="${scoringQuestion.options}" var="option">
          <input type="checkbox" /><c:out value="${option.name}" />&nbsp;<br>
        </c:forEach>
      </td>
    </tr>
    <tr>
      <td>
        <c:out value="${scoringQuestion.description}" />
        <div class="answerTextBox"></div>
      </td>
    </tr>
    </c:forEach>
  </c:forEach>
  </tbody>
</table>
</div>
</div>
</c:forEach>

</body>
</html>
