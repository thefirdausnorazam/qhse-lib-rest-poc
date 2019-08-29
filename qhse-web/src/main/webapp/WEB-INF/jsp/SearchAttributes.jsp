<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${param.structureFormat=='table'}">
	<tr class="form-group">
		<td id="createdByUserLabel" class="searchLabel"><fmt:message key="createdBy" />:</td>
		<td colspan="3" class="search">
				<select id="createdByUser" style="width: 40%" class="commonSearchAtributes">
				<option value=""><fmt:message key="choose" /></option>
				<c:forEach items="${userList}" var="item">
				<option value="${item.id}"><c:out value="${item.displayName}"></c:out> </option>
				</c:forEach>
				</select>
	   </td>
	</tr>
	<tr class="form-group">
		<td id="lastUpdatedByLabel" class="searchLabel"><fmt:message key="lastUpdatedBy" />:</td>
		<td colspan="3" class="search">
				<select id="lastUpdatedBy" style="width: 40%" class="commonSearchAtributes">
				<option value=""><fmt:message key="choose" /></option>
				<c:forEach items="${userList}" var="item">
				<option value="${item.id}"><c:out value="${item.displayName}"></c:out> </option>
				</c:forEach>
				</select>
		</td>
	</tr>
	<tr class="form-group">
		<td id="createdByDepartmentLabel" class="searchLabel"><fmt:message key="createdByDepartment" />:</td>
		<td colspan="3" class="search">
			<select id="createdByDepartment" style="width: 40%" class="commonSearchAtributes">
			<option value=""><fmt:message key="choose" /></option>
				<c:forEach items="${departments}" var="item">
				<option value="${item.id}"><c:out value="${item.name}"></c:out> </option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr class="form-group">
		<td id="lastUpdatedByDepartmentLabel" class="searchLabel"><fmt:message key="lastUpdatedByDepartment" />:</td>
		<td colspan="3" class="search">
			<select id="lastUpdatedByDepartment" style="width: 40%" class="commonSearchAtributes">
			<option value=""><fmt:message key="choose" /></option>
				<c:forEach items="${departments}" var="item">
				<option value="${item.id}"><c:out value="${item.name}"></c:out> </option>
				</c:forEach>
				</select>
		</td>
	</tr>
</c:if>
	<c:if test="${param.structureFormat=='divFormat'}">

				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel">
						<fmt:message key="createdBy" />
					</label>
					<div class="col-sm-6">
						<select id="createdBy" style="width: 40%" class="commonSearchAtributes">
							<option value=""><fmt:message key="choose" /></option>
							<c:forEach items="${userList}" var="item">
							<option value="${item.id}"><c:out value="${item.displayName}"></c:out> </option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel">
						<fmt:message key="lastUpdatedBy" />
					</label>
					<div class="col-sm-6">
						<select id="lastUpdatedBy" style="width: 40%" class="commonSearchAtributes">
							<option value=""><fmt:message key="choose" /></option>
							<c:forEach items="${userList}" var="item">
							<option value="${item.id}"><c:out value="${item.displayName}"></c:out> </option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel">
						<fmt:message key="createdByDepartment" />
					</label>
					<div class="col-sm-6">
				<select id="createdByDepartment" style="width: 40%" class="commonSearchAtributes">
					<option value=""><fmt:message key="choose" /></option>
						<c:forEach items="${departments}" var="item">
						<option value="${item.id}"><c:out value="${item.name}"></c:out> </option>
						</c:forEach>
				</select>	
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label scannellGeneralLabel">
						<fmt:message key="lastUpdatedByDepartment" />
					</label>
					<div class="col-sm-6">
				<select id="lastUpdatedByDepartment" style="width: 40%" class="commonSearchAtributes">
					<option value=""><fmt:message key="choose" /></option>
						<c:forEach items="${departments}" var="item">
						<option value="${item.id}"><c:out value="${item.name}"></c:out> </option>
						</c:forEach>
				</select>
					</div>
				</div>
</c:if>
<c:if test="${param.structureFormat=='incident'}">
 <div class="row">

    <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="createdBy" /></label>                      
           
             <select id="createdBy"  class="commonSearchAtributes" style="width:100%;">
							<option value=""><fmt:message key="choose" /></option>
							<c:forEach items="${userList}" var="item">
							<option value="${item.id}"><c:out value="${item.displayName}"></c:out> </option>
							</c:forEach>
			</select>
               </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="lastUpdatedBy" /></label>                         
                     <select id="lastUpdatedBy"  class="commonSearchAtributes" style="width:100%;">
							<option value=""><fmt:message key="choose" /></option>
							<c:forEach items="${userList}" var="item">
							<option value="${item.id}"><c:out value="${item.displayName}"></c:out> </option>
							</c:forEach>
			       </select>
                   </div>
      </div>
 </div>
 
 <div class="row">

   <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="scannellGeneralLabel "><fmt:message key="createdByDepartment" /></label>                      
           
				<select id="createdByDepartment" style="width: 100%" class="commonSearchAtributes">
					<option value=""><fmt:message key="choose" /></option>
						<c:forEach items="${departments}" var="item">
						<option value="${item.id}"><c:out value="${item.name}"></c:out> </option>
						</c:forEach>
				</select>
               </div>
     </div>
      <div class="col-sm-6 col-md-6">
              <div class="form-group">
              <label class="control-label scannellGeneralLabel nowrap"><fmt:message key="lastUpdatedByDepartment" /></label>                         
                 <select id="lastUpdatedByDepartment" style="width: 100%" class="commonSearchAtributes">
					<option value=""><fmt:message key="choose" /></option>
						<c:forEach items="${departments}" var="item">
						<option value="${item.id}"><c:out value="${item.name}"></c:out> </option>
						</c:forEach>
				</select>
                   </div>
      </div>
 </div>
</c:if>