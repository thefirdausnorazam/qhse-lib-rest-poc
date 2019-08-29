<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<script type="text/javascript">
  function onChangeOpt(opt) {
    var box = document.getElementById("opt" + opt.id);
    if (box) {
      box.style.display = opt.checked ? "" : "none";
    }
  }
</script>
</head>
<body>

<table class="viewForm">
  <col class="label" />
  <thead>
    <tr>
      <td colspan="2">BT Express Risk Assessment Form</td>
    </tr>
  </thead>
  <tbody>
    <tr class="noprint">
      <td class="label">Environmental Aspect:</td>
      <td>
        <div class="scrolllist">
          <c:forEach items="${options}" var="opt">
            <input type="checkbox" onclick="onChangeOpt(this)" id="<c:out value="${opt.key}" />"><c:out value="${opt.value}" /><br />
          </c:forEach>  
        </div>
      </td>
    </tr>
    <tr>
      <td class="label">Choose a Business Area:</td>
      <td>&nbsp;</td>
    </tr>
    <br />
    <tr>
      <td class="label">Choose a Risk Group:</td>
      <td>&nbsp;</td>
    </tr>
    <br />
     <tr>
      <td class="label">Choose a Risk to Assess:</td>
      <td>&nbsp;</td>
    </tr>
     <tr>
      <td class="label">Description of what is being Assessed:</td>
      <td><div class="answerTextBox"></div></td>
    </tr>
    <tr>
      <td class="label">Choose an Environmental Impact:</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td class="label">Choose an Impact Type:</td>
      <td>&nbsp;</td>
    </tr>
        <tr>
      <td class="label">Choose a Mode of Operation:</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td class="label">Choose an Environmental Impact:</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td class="label">Responsible:</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td class="label">Enter any other Participants:</td>
      <td>&nbsp;</td>
    </tr>
</tbody>
</table>

<c:forEach items="${options}" var="opt">
<table class="viewForm bordered" id="<c:out value="opt${opt.key}" />" style="display: none; page-break-before: always;">
  <thead>
    <tr>
      <td><c:out value="${opt.value}" /></td>
    </tr>
  </thead>
  <tbody>          
  <c:forEach items="${scoringModel.categories}" var="cat">
    <tr>
      <td><c:out value="${cat.name}" /></td>
    </tr>
    <c:forEach items="${cat.subCategories}" var="subCat">
      <tr>
        <td>
          <c:out value="${subCat.name}" />:<br>
          <c:forEach items="${subCat.options}" var="opt">
            <input type="checkbox" /><c:out value="${opt.name}" />&nbsp;
            <br>
          </c:forEach>
        </td>
      </tr>
      <tr>
        <td>
          <c:out value="${subCat.description}" />
	        <div class="answerTextBox"></div>
        </td>
      </tr>
      
    </c:forEach>
  </c:forEach>
  </tbody>
</table>
</c:forEach>

</body>
</html>
