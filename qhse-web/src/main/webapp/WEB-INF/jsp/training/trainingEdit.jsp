<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<c:set var="title" value="trainingEdit" />
<c:if test="${command['new']}">
  <c:set var="title" value="trainingCreate" />
</c:if>

<title><fmt:message key="${title}" /></title>

<script language="javascript" type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>

<style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
</style>

</head>
<body>

<spring:hasBindErrors name="command">
  <div class="errorMessage"><fmt:message key="errors.global" /></div>
  <br />
  <spring:bind path="command">
    <div class="errorMessage"><c:out value="${status.errorMessage}" /></div>
    <br />
  </spring:bind>
</spring:hasBindErrors>


<form method="post">

<spring:nestedPath path="command">
<table class="viewForm">
    <col class="label" />
<tbody>

  <tr class="title">
    <th colspan="2"><fmt:message key="userDetails" /></th>
  </tr>

  <c:if test="${!command['new']}">
  <tr>
    <td class="label"><fmt:message key="training.category" />:</td>
    <td><c:out value="${command.category.name}" /></td>
  </tr>
  <tr>
    <td class="label"><fmt:message key="training.receiver" />:</td>
    <td><c:out value="${command.receiver.displayName}" /></td>
  </tr>
  </c:if>

  <c:if test="${command['new']}">

  <tr>
    <td class="label"><fmt:message key="training.category" />:</td>
    <td>
      <spring:bind path="category">
        <select name="<c:out value="${status.expression}"/>" class="wide" >
          <option id="blankOption" value=""><fmt:message key="noneOrNew" /></option>
          <c:forEach items="${categories}" var="item">
          <option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
            <c:out value="${item.name}" />
          </option>
          </c:forEach>
        </select>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="training.newCategory" />:</td>
    <td><input type="text" name="newCategory" size="50"/>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="training.receiver" />:</td>
    <td>
      <spring:bind path="receiver">
        <select name="<c:out value="${status.expression}"/>" class="wide" >
          <option id="blankOption" value=""><fmt:message key="blankOption" /></option>
          <c:forEach items="${users}" var="item">
          <option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
            <c:out value="${item.sortableName}" />
          </option>
          </c:forEach>
        </select>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>

</c:if>

  <tr>
    <td class="label"><fmt:message key="description" />:</td>
    <td>
      <spring:bind path="description">
        <textarea name="<c:out value="${status.expression}"/>" cols="75" rows="3"><c:out
          value="${status.value}" /></textarea>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="training.responsible" />:</td>
    <td>
      <spring:bind path="responsible">
        <select name="<c:out value="${status.expression}"/>" class="wide" >
          <option id="blankOption" value=""><fmt:message key="blankOption" /></option>
          <c:forEach items="${users}" var="item">
          <option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
            <c:out value="${item.sortableName}" />
          </option>
          </c:forEach>
        </select>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="training.receiversDepartment" />:</td>
    <td>
      <spring:bind path="receiversDepartment">
        <select name="<c:out value="${status.expression}"/>" class="wide" >
          <option id="blankOption" value=""><fmt:message key="blankOption" /></option>
          <c:forEach items="${departments}" var="item">
            <c:if test="${item.active || item.id == status.value}">
              <option value="<c:out value="${item.id}" />" <c:if test="${item.id == status.value}">selected="selected"</c:if>>
                <c:out value="${item.name}" /></option>
            </c:if>
          </c:forEach>
        </select>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="training.replacementFrequency" />:</td>
    <td>
      <spring:bind path="intervalAmount">
        <input type="text" name="<c:out value="${status.expression}"/>"
          value="<c:out value="${status.value}"/>" size="20" />
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
      <spring:bind path="intervalType" >
        <select name="<c:out value="${status.expression}"/>" >
          <c:forEach items="${frequencies}" var="item" varStatus="st">
            <option value="<c:out value="${item.name}" />" <c:if test="${item.name == status.value}">selected="selected"</c:if>>
              <fmt:message key="${item}" />
            </option>
          </c:forEach>
        </select>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="training.dueDate" />:</td>
    <td>
    <spring:bind path="dueDate">
      <input type="text" name="<c:out value="${status.expression}"/>"
        value="<c:out value="${status.value}"/>"
        size="20" readonly="readonly" id="dueDate" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar"
        onclick="return showCalendar(event, 'dueDate', true);">
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="training.alertLeadDays" />:</td>
    <td>
    <spring:bind path="alertLeadDays">
      <input type="text" name="<c:out value="${status.expression}"/>"
        value="<c:out value="${status.value}"/>" size="10" />
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="active" />:</td>
    <td>
      <spring:bind path="active">
        <input type="hidden" name="<c:out value="_${status.expression}"/>" />
        <input type="checkbox" name="<c:out value="${status.expression}"/>" <c:if test="${status.value}">checked="checked"</c:if> />
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>

  <tr class="title">
    <th colspan="2"><fmt:message key="training.issueDetails" /></th>
  </tr>

  <tr>
    <td class="label"><fmt:message key="training.actualDate" />:</td>
    <td>
    <spring:bind path="actualDate">
      <input type="text" name="<c:out value="${status.expression}"/>"
        value="<c:out value="${status.value}"/>"
        size="20" readonly="readonly" id="actualDate" />
      <img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar"
        onclick="return showCalendar(event, 'actualDate', true);">
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="training.carriedOutBy" />:</td>
    <td>
    <spring:bind path="carriedOutBy">
      <input type="text" name="<c:out value="${status.expression}"/>"
        value="<c:out value="${status.value}"/>" size="50" />
      <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
    </spring:bind>
    </td>
  </tr>

  <tr>
    <td class="label"><fmt:message key="comment" />:</td>
    <td>
      <spring:bind path="comment">
        <textarea name="<c:out value="${status.expression}"/>" cols="75" rows="3"><c:out
          value="${status.value}" /></textarea>
        <span class="errorMessage"><c:out value="${status.errorMessage}" /></span>
      </spring:bind>
    </td>
  </tr>
</tbody>
<tfoot>
  <tr>
    <td colspan="2" align="center"><button type="submit"><fmt:message key="submit" /></button></td>
  </tr>
</tfoot>
</table>

</spring:nestedPath>

</form>

</body>
</html>
