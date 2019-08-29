<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>


<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="dataEntryQueryResult" /></title>

</head>
<body>
	<script type="text/javascript"> 
 		jQuery('.recordsPerPage > select').select2();
 	</script>
	<c:set var="found" value="${!empty result.results and enterReadingPermissions}" />
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<table class="table table-bordered table-responsive">
					<thead>
						<c:if test="${found}">
							<tr>
								<th>Parameter</th>
								<th>Measure</th>
								<th>Monitoring Point</th>
								<th style="border-right: 0px;">Reading Value</th>
								<th style="border-right: 0px; border-left: 0px;"></th>
							</tr>
						</c:if>
					</thead>

					<tbody>
						<tr>
							<td colspan="5"><span><c:if test="${!found}">
									<fmt:message key="search.empty" />
								</c:if> <c:if test="${found}">
									<scannell:paging result="${result}" />
								</c:if></span></td>
						</tr>
						<c:if test="${found}">
							<c:set var="startOfDay" value="false" />
							<c:set var="startOfWeek" value="false" />
							<c:set var="startOfMonth" value="false" />
							<c:set var="startOfQuarter" value="false" />
							<c:set var="startOfYear" value="false" />

							<c:forEach items="${result.results}" var="reading" varStatus="s">
								<c:choose>
									<c:when test="${s.index mod 2 == 0}">
										<c:set var="style" value="even" />
									</c:when>
									<c:otherwise>
										<c:set var="style" value="odd" />
									</c:otherwise>
								</c:choose>

								<c:if test="${!startOfDay && (reading.type.frequency.name == 'd' or reading.type.frequency.name == 'ds')}">
									<c:set var="startOfDay" value="true" />
									<tr>
										<th class="header" colspan="5"><fmt:message key="${reading.timePeriod.name}" />: 
										<fmt:formatDate value="${reading.timePeriod.startTimestamp}" pattern="${reading.timePeriod.dateFormat}" /></th>
									</tr>
								</c:if>
								<c:if test="${!startOfWeek && (reading.type.frequency.name == 'w' or reading.type.frequency.name == 'ws')}">
									<c:set var="startOfWeek" value="true" />
									<tr>
										<th class="header" colspan="5"><fmt:message key="${reading.timePeriod.name}" />: 
											<fmt:formatDate value="${reading.timePeriod.startTimestamp}" pattern="${reading.timePeriod.dateFormat}" /></th>
									</tr>
								</c:if>
								<c:if test="${!startOfMonth && (reading.type.frequency.name == 'm' or reading.type.frequency.name == 'ms')}">
									<c:set var="startOfMonth" value="true" />
									<tr>
										<th class="header" colspan="5"><fmt:message key="${reading.timePeriod.name}" />: 
											<fmt:formatDate value="${reading.timePeriod.startTimestamp}" pattern="${reading.timePeriod.dateFormat}" />
										</th>
									</tr>
								</c:if>
								<c:if test="${!startOfQuarter && (reading.type.frequency.name == 'q')}">
									<c:set var="startOfQuarter" value="true" />
									<tr>
										<th class="header" colspan="5"><fmt:message key="${reading.timePeriod.name}" />: 
											<fmt:formatDate value="${reading.timePeriod.startTimestamp}" pattern="${reading.timePeriod.dateFormat}" />
										</th>
									</tr>
								</c:if>
								<c:if test="${!startOfYear && (reading.type.frequency.name == 'y' or reading.type.frequency.name == 'ys')}">
									<c:set var="startOfYear" value="true" />
									<tr>
										<th class="header" colspan="5"><fmt:message key="${reading.timePeriod.name}" />: 
											<fmt:formatDate value="${reading.timePeriod.startTimestamp}" pattern="${reading.timePeriod.dateFormat}" />
										</th>
									</tr>
								</c:if>

								<c:set var="id" value="${reading.id}" />
								<tr class="<c:out value="${style}" />">
									<script type="text/javascript">
										isError(${id});
								</script>
									<c:url value="/survey/measurementView.htm" var="measurementURL">
										<c:param name="id" value="${reading.type.id}" />
									</c:url>
									<td><span><a href="<c:out value="${measurementURL}" />">
											<c:out value="${reading.type.quantity.longName}" />
										</a></span></td>
									<td><span><c:out value="${reading.type.measure.measureName}" /></span></td>
									<td><span><c:out value="${reading.type.readingPoint.name}" /></span></td>

									<c:choose>
										<c:when test="${reading.due or reading.overdue}">
											<c:set var="displayStyle" value="display: none" />
											<c:set var="editStyle" value="display: block" />
										</c:when>
										<c:otherwise>
											<c:set var="displayStyle" value="display: block" />
											<c:set var="editStyle" value="display: none" />
										</c:otherwise>
									</c:choose>

									<td id="<c:out value="readingCell[${id}]" />" style="width: 10%; border-right: 0px;">
										<div id="<c:out value="readingDisplay[${id}]" />" onclick="<c:out value="edit(${id})" />"
											onMouseOver="<c:out value="editIcon(${id})" />"
											onMouseOut="css.removeClassFromElement($('readingCell[<c:out value="${id}" />]'), 'editable');" class="edit"
											style="<c:out value="${displayStyle}" />">
											<c:choose>
												<c:when test="${reading.trashed}">
													<fmt:message key="${reading.status}" />
												</c:when>
												<c:otherwise>
													<c:out value="${reading.customUnitValueOfUnitSelected}" />
												</c:otherwise>
											</c:choose>
										</div>

										<div style="display: block; float: left;">
											<div id="<c:out value="readingEdit[${id}]" />" class="edit" style="<c:out value="${editStyle}"/>">
												<div style="white-space: nowrap; float: left;" id="div<c:out value="readingEdit[${id}]" />">
													<c:choose>
														<c:when test="${reading.type.numeric}">
															<input type="text" size="15" id="<c:out value="readingAmount[${id}]" />"
																onchange="<c:out value="modified(${id})" />" onkeypress="<c:out value="modified(${id})" />"
																value="<c:out value="${reading.value.amount}" />">
														</c:when>

														<c:when test="${reading.type['boolean']}">
															<select id="<c:out value="readingAmount[${id}]" />">
																<option value=""></option>
																<option value="1"><fmt:message key="true" /></option>
																<option value="0"><fmt:message key="false" /></option>
															</select>
														</c:when>

														<c:when test="${reading.type.option}">
															<select id="<c:out value="readingAmount[${id}]" />">
																<option value=""></option>
																<option value="2"><fmt:message key="good" /></option>
																<option value="3"><fmt:message key="fair" /></option>
																<option value="4"><fmt:message key="bad" /></option>
															</select>
														</c:when>
													</c:choose>
													<c:if test="${reading.type.defaultUnit.symbol !='y'}">
														<c:out value="${reading.type.defaultUnit.symbol}" />
													</c:if>
												</div>
												<div style="display: none;" id="<c:out value="readingComment[${id}]" />">
													<textarea cols="30" rows="3" onkeypress="<c:out value="modified(${id})" />" style="margin-top: 5px;"></textarea>
												</div>
											</div>
										</div> <span id="errorMessage[${id}]"></span>
									</td>
									<td style="width: 10%; border-left: 0px;">
										<button id="<c:out value="readingCommentLink[${id}]" />" data-toggle="tooltip" class="btn btn-xs"
											data-original-title="<fmt:message key="edit" />" onclick="return edit(${id},this)">
											<span class="glyphicon glyphicon-pencil"></span>
										</button>
										<button onclick="return save(${id})" data-toggle="tooltip" data-original-title="<fmt:message key="save" />"
											class="btn btn-primary btn-xs">
											<span class="glyphicon glyphicon-floppy-disk"></span>
										</button>
										<button type="button" class="btn btn-danger btn-xs" onClick="<c:out value="trash(${id})" />">
											<span class="glyphicon glyphicon-remove"></span>
										</button>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${found}">
							<tr>
								<td colspan="4"><scannell:paging result="${result}" /></td>
							</tr>
						</c:if>

					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
