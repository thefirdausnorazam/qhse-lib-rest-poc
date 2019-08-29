<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-bordered table-responsive">


  <tr id="itemRow">
    <td class="searchLabel">
      <c:out value="${type.description}" />
      <input type="hidden" name="items.type" value="<c:out value="${type.id}" />" />
    </td>
    <td class="search">
      <input type="text" name="items.estimatedWeightAmount" class="form-control" />
      <select name="items.estimatedWeightUnit">
        <c:forEach items="${units}" var="item">
          <option value="<c:out value="${item.id}" />"><c:out value="${item.name}" /></option>
        </c:forEach>
      </select>
    </td>
    <td class="searchLabel">
    <c:choose>
      <c:when test="${type.customUnit.convertToBaseDescription == null}">
        <input type="text" name="items.containerCount" class="form-control" onchange="calculatedEstimatedWeight(getParent('tr',this))" readonly="true"/> 
      </c:when>
      <c:otherwise>
        <input type="text" name="items.containerCount" class="form-control" onchange="calculatedEstimatedWeight(getParent('tr',this))" /> 
      </c:otherwise>
    </c:choose>
    </td>
     <td class="search"> <c:out value="${type.customUnit.convertToBaseDescription}" /> </td>
    <td>
      <button type="button" class="delete" class="g-btn g-btn--primary" onclick="deleteRow(getParent('tr',this));"><fmt:message key="deleteShort" /></button>
    </td>
  </tr>
</table>

