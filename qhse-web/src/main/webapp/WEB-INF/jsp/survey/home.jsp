<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>


<!DOCTYPE html>
<html>
<head>
<meta name="printable" content="true">
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
    <script type="text/javascript" src="<c:url value="/js/moveSite.js" />"></script>  
	<style type="text/css" media="all">
 		@import "<c:url value='/css/survey.css'/>";
	</style>
<title></title>
</head>
<body>
<common:moveSite recordType="limitPeriod"/>
<c:set var="measLabel"><fmt:message key="measurement"/></c:set>
<c:set var="paramLabel"><fmt:message key="quantity"/></c:set>

<div class="content">

<div class="header">
<h3><fmt:message key="myLimitBreaches" /></h3>
</div>
<div class="content">
	<div class="table-responsive">
		<div class="panel">  
        	<c:choose>
		        <c:when test="${empty alertsSites}">
		        	<table class="table table-bordered  table-responsive dataTable">
		        		<thead>
						    <tr>
						    	<th><fmt:message key="id" /></th>
						      	<th><fmt:message key="quantity" /></th>
						      	<th><fmt:message key="measure" /></th>
						      	<th><fmt:message key="readingPoint" /></th>
						      	<th><fmt:message key="type" /></th>
						      	<th><fmt:message key="timePeriod" /></th>
						      	<th><fmt:message key="limitAmount" /></th>
						      	<th><fmt:message key="limitReadingValue" /></th>
						      	<th><fmt:message key="complianceStatus" /></th>
						    </tr>
					   	</thead>
		        	</table>
		        </c:when>
		        <c:otherwise>
				 	<c:forEach items="${alertsSites}" var="alertS" varStatus="s">   
						<table class="table table-bordered table-responsive dataTable">
							<caption><c:out value="${alertS}" /></caption>
							  <thead>
							    <tr>
							    	<c:if test="${!empty alerts}">
									      <th><fmt:message key="id" /></th>
									      <th><fmt:message key="quantity" /></th>
									      <th><fmt:message key="measure" /></th>
									      <th><fmt:message key="readingPoint" /></th>
									      <th><fmt:message key="type" /></th>
									      <th><fmt:message key="timePeriod" /></th>
									      <th><fmt:message key="limitAmount" /></th>
									      <th><fmt:message key="limitReadingValue" /></th>
									      <th><fmt:message key="complianceStatus" /></th>
							      	</c:if>
							    </tr>
							  </thead>
		
							  <tbody>
							    <c:if test="${empty alerts}">
							      <tr class="odd">
							        <td colspan="7"><fmt:message key="none" /></td>
							      </tr>
							    </c:if>
							    <c:forEach items="${alerts}" var="limitPeriod" varStatus="s">
							     <c:if test="${limitPeriod.site.name == alertS}">
							      <c:choose>
							        <c:when test="${s.index mod 2 == 0}">
							          <c:set var="style" value="even" />
							        </c:when>
							        <c:otherwise>
							          <c:set var="style" value="odd" />
							        </c:otherwise>
							      </c:choose>
							      <tr class="<c:out value="${style}" />">
							        <td><a onclick='changeSite("<c:url value="limitPeriodView.htm"><c:param name="id" value="${limitPeriod.id}"/></c:url>", ${limitPeriod.site.id}, "${limitPeriod.site}", ${currentSite})' href="#" ><c:out value="${limitPeriod.id}" /></a></td>
							        <td><c:out value="${limitPeriod.limit.owner.quantity.longName}" /></td>
							        <td><c:out value="${limitPeriod.limit.owner.measure.measureName}" /></td>
							        <td><c:out value="${limitPeriod.limit.owner.readingPoint.name}" /></td>
							        <td><fmt:message key="${limitPeriod.limit.type}" /></td>
							        <td><c:out value="${limitPeriod.timePeriod}" /></td>
							        <td>
							          <c:if test="${limitPeriod.lowerThreshold != null}"><c:out value="${limitPeriod.lowerThreshold} -> " /></c:if>
							          <spring:message code="${limitPeriod.upperThreshold}" text="${limitPeriod.upperThreshold}" />
							        </td>
							        <td>
										<c:choose>
											<c:when test="${limitPeriod.limit.owner.rate}" >
											<fmt:message key="max" />: <span style="white-space:nowrap;"><spring:message code="${limitPeriod.upperValue}" text="${limitPeriod.upperValue}" /></span><br>
											<fmt:message key="min" />: <span style="white-space:nowrap;"><spring:message code="${limitPeriod.lowerValue}" text="${limitPeriod.lowerValue}" /></span>
											</c:when>
											<c:otherwise>
											<spring:message code="${limitPeriod.upperValue}" text="${limitPeriod.upperValue}" />
											</c:otherwise>
										</c:choose>
							        </td>
							        <td class="<c:out value="${limitPeriod.complianceStatus.name}" />"><fmt:message key="${limitPeriod.complianceStatus}" /></td>
							      </tr>
							      </c:if>
							    </c:forEach>
							  </tbody>
							  <c:if test="${bulkReviewable}">
								<tfoot>
								  <tr>
								    <td colspan="9">
							        <a href="<c:url value="bulkLimitPeriodBreachWarningReview.htm"><c:param name="site" value="${alertS.id}" /></c:url>"><fmt:message key="bulkLimitPeriodBreachWarningReview" /></a>
								    </td>
								  </tr>
								</tfoot>
							  </c:if>
							</table>    
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

<div class="header">
<h3><fmt:message key="myQuantities" /></h3>
</div>
<div class="content">
	<div class="table-responsive">
		<div class="panel">   
        	<c:choose>
		        <c:when test="${empty quantitiesSites}">
		        	<table class="table table-bordered  table-responsive dataTable">
		        		<thead>
						    <tr>
					      	  <th><fmt:message key="id" /></th>
						      <th><fmt:message key="name" /></th>
						      <th><fmt:message key="categoryName" /></th>
						      <th><fmt:message key="categoryType" /></th>
						    </tr>
					    </thead>
		        	</table>
		        </c:when>
		        <c:otherwise>
				 	<c:forEach items="${quantitiesSites}" var="quantityS" varStatus="s">   
						<table class="table table-bordered table-responsive dataTable">
						  <caption><c:out value="${quantityS}" /></caption>
						  <thead>
						    <tr>
						    	<c:if test="${!empty quantities}">
								      <th><fmt:message key="id" /></th>
								      <th><fmt:message key="name" /></th>
								      <th><fmt:message key="categoryName" /></th>
								      <th><fmt:message key="categoryType" /></th>
								</c:if>
						    </tr>
						  </thead>
						  <tbody>
						    <c:forEach items="${quantities}" var="quantity" varStatus="s">
							     <c:if test="${quantity.site.name == quantityS}">
								      <c:choose>
								        <c:when test="${s.index mod 2 == 0}">
								          <c:set var="style" value="even" />
								        </c:when>
								        <c:otherwise>
								          <c:set var="style" value="odd" />
								        </c:otherwise>
								      </c:choose>
								      <tr class="<c:out value="${style}" />">
								        <td><a onclick='changeSiteOfType("<c:url value="quantityView.htm"><c:param name="id" value="${quantity.id}"/></c:url>", ${quantity.site.id}, "${quantity.site}", ${currentSite}, "${paramLabel}")' href="#"  ><c:out value="${quantity.id}" /></a></td>
								        <td><c:out value="${quantity.name}" /></td>
								        <td><c:out value="${quantity.category.name}" /></td>
								        <td><fmt:message key="${quantity.category.type}" /></td>
								      </tr>
							      </c:if>
						    </c:forEach>
						  </tbody>
						</table>   
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>



<div class="header">
<h3><fmt:message key="myMeasurements" /></h3>
</div>
<div class="content">
	<div class="table-responsive">
		<div class="panel">   
        	<c:choose>
		        <c:when test="${empty measurementsSites}">
		        	<table class="table table-bordered  table-responsive dataTable">
		        	<thead>
					    <tr>
					    	<th><fmt:message key="id" /></th>
				      		<th><fmt:message key="quantity" /></th>
				      		<th><fmt:message key="measure" /></th>
				      		<th><fmt:message key="readingPoint" /></th>
				      		<th><fmt:message key="frequency" /></th>
					    </tr>
				    </thead>
		        	</table>
		        </c:when>
		        <c:otherwise>
				 	<c:forEach items="${measurementsSites}" var="measurementS" varStatus="s"> 
						<table class="table table-bordered table-responsive dataTable">
							<caption><c:out value="${measurementS}" /></caption>
							  <thead>
							    <tr>
							    	<c:if test="${!empty measurements}">
									      <th><fmt:message key="id" /></th>
									      <th><fmt:message key="quantity" /></th>
									      <th><fmt:message key="measure" /></th>
									      <th><fmt:message key="readingPoint" /></th>
									      <th><fmt:message key="frequency" /></th>
							      	</c:if>
							    </tr>
							  </thead>
							  <tbody>
							    <c:forEach items="${measurements}" var="measurement" varStatus="s">
								     <c:if test="${measurement.site.name == measurementS}">
									      <c:choose>
									        <c:when test="${s.index mod 2 == 0}">
									          <c:set var="style" value="even" />
									        </c:when>
									        <c:otherwise>
									          <c:set var="style" value="odd" />
									        </c:otherwise>
									      </c:choose>
									      <tr class="<c:out value="${style}" />">
									        <td><a href='javascript:changeSiteOfType("<c:url value="measurementView.htm"><c:param name="id" value="${measurement.id}"/></c:url>", ${measurement.site.id}, "${measurement.site}", ${currentSite}, "${measLabel}")'   ><c:out value="${measurement.id}" /></a></td>
									        <td><c:out value="${measurement.quantity.longName}" /></td>
									        <td><c:out value="${measurement.measure.measureName}" /></td>
									        <td><c:out value="${measurement.readingPoint.name}" /></td>
									        <td><c:out value="${measurement.frequencyDisplay}" /></td>
									      </tr>
									</c:if>
							    </c:forEach>
							  </tbody>
							</table>  
						</c:forEach>
					</c:otherwise>
				</c:choose>
		</div>
	</div>
</div>


</div>
</body>
</html>
