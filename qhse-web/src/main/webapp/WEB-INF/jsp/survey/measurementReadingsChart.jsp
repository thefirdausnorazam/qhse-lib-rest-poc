<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<!DOCTYPE html>
<html>
<head>
	<script type='text/javascript' src="<c:url value="/dwr/interface/SurveyDWRService.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
	<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
 	<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/css.js" />"></script>
<style type="text/css" media="all">
    @import "<c:url value='/css/calendar.css'/>";
</style>
</head>

<body>
<scannell:form>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive" >
<col class="label" />
<tr>
	<td>
		<IMG src = <%=response.encodeURL(request.getContextPath( )+ "/DrawPieChart")%> border = "10">

		<c:if test="${size > 0 && stdev}">
			<IMG src = <%=response.encodeURL(request.getContextPath( )+ "/DrawSTDChart")%> border = "10">
		</c:if>
		<INPUT TYPE="HIDDEN" NAME="id" VALUE="<%=request.getParameter("id") %>"/>
	</td>
</tr>
</table>
</div>
</div>
<div class="content"> 
<div class="table-responsive">
<table class="table table-bordered table-responsive" >
<col class="label" />
<tbody>

 <tr>
		<td><fmt:message key="from" />:</td>
		<td>
			<%-- <input type="text" id="fromDate" name="fromDate" size="15" readonly="readonly" value="${fromDate}"/>
			<img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'fromDate', true);"> --%>
			<div style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                    <input class="form-control" id="fromDate" name="fromDate" size="6" value="${fromDate}" type="text"  readonly>
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>					
                </div>
		</td>
	<tr>
	<tr>
		<td><fmt:message key="to" />:</td>
		<td>
		<div style="width:250px;">
                  <div class="input-group date datetime " data-min-view="2" data-date-format="dd-MM-yyyy" style="width:200px;">
                    <input class="form-control" id="toDate" name="toDate" size="6" type="text" value="${toDate}"  readonly>
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>					
                </div>
			<%-- <input type="text" id="toDate" name="toDate" size="15" readonly="readonly" value="${toDate}">
			<img src="<c:url value="/images/calendar.gif"/>" alt="show-calendar" onclick="return showCalendar(event, 'toDate', true);"> --%>
		</td>
	<tr>
	<tr>
		<td>
			Display Average Line
		</td>
		<td>
			<c:if test="${avg}">
				<INPUT TYPE="CHECKBOX" NAME="avg" CHECKED/>
			</c:if>
			<c:if test="${!avg}">
				<INPUT TYPE="CHECKBOX" NAME="avg"/>
			</c:if>

		</td>
	</tr>
	<tr>
		<td>
			Display Min / Max Line(s)
		</td>
		<td>
			<c:if test="${limits != null}">
				<c:if test="${minmax}">
					<INPUT TYPE="CHECKBOX" NAME="minmax" CHECKED/>
				</c:if>
				<c:if test="${!minmax}">
					<INPUT TYPE="CHECKBOX" NAME="minmax" />
				</c:if>
			</c:if>
			<c:if test="${limits == null}">
				<INPUT TYPE="CHECKBOX" NAME="minmax" disabled="disabled"/>
			</c:if>
		</td>
	</tr>
	<tr>
		<td>
			Display Standard Deviation graph
		</td>
		<td>
			<c:if test="${stdev}">
				<INPUT TYPE="CHECKBOX" NAME="stdev" CHECKED/>
			</c:if>
			<c:if test="${!stdev}">
				<INPUT TYPE="CHECKBOX" NAME="stdev"/>
			</c:if>
		</td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td align="left"><a href="<c:url value="/survey/monitoringProgrammeViewCategories.htm" />"><fmt:message key="survey.monitoringProgrammeViewCategories.title" /></td>
		<td align="center"><input type="submit" class="g-btn g-btn--primary" value="<fmt:message key="graph" />"></td>
	</tr>
</tfoot>
</table>

</div>
</div>


</scannell:form>
</body>
</html>

