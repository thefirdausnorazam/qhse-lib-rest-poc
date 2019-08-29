<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><fmt:message key="linkSearch" /></title>
</head>
<body>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			initSortTables();
		} );
	</script>
	<div class="header">
		<h3>
			<fmt:message key="searchResults" />
		</h3>
	</div>
	<c:set var="found" value="${!empty result.results}" />
	<c:set var="colspan">
		<c:choose>
			<c:when test="${showSiteColumn}">8</c:when>
			<c:otherwise>7</c:otherwise>
		</c:choose>
	</c:set>
	<div class="content">
		<div class="table-responsive">
			<div class="panel">
				<c:if test="${found}">
         			  <div class="div-for-pagination"><scannell:paging result="${result}" /></div>
					<table class="table table-bordered table-responsive dataTable">

						<thead>

							<tr>
								<th><fmt:message key="id" /></th>
								<th><fmt:message key="name" /></th>
								<th><fmt:message key="category" /></th>
								<th><fmt:message key="description" /></th>
								<th><fmt:message key="active" /></th>
								<th><fmt:message key="docType" /></th>
							</tr>

						</thead>

						<tbody>
							<c:forEach items="${result.results}" var="item" varStatus="s">
								<tr>
									<td><c:out value="${item.id}" /></td>
									<td>
										<c:choose>
											<c:when test="${not empty item.attachmentType}">
												<a target="attachment" href="<c:url value="viewDocAttachment.xml"><c:param name="id" value="${item.attachmentType}"/><c:param name="showId" value="${item.id}"/><c:param name="attachId" value="${item.attachmentType}"/></c:url>"><c:out value="${item.name}" /></a>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${item.file}">
														<a onclick='openLinkFile("<c:url value="${item.id}"></c:url>")' target="blank"><c:out value="${item.name}" /></a>
													</c:when>
													<c:otherwise>
														<a href="<c:url value="${item.url}"></c:url>" target="blank"><c:out value="${item.name}" /></a>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td><a href='<c:url value="categoryEdit.htm"><c:param name="showId" value="${item.category.id}"/></c:url>' title='<fmt:message key="editCategory" />'><c:out value="${item.category.name}" /></a></td>
									<td><c:out value="${item.description}" /></td>
									<td><c:if test="${item.active == true}">
											<fmt:message key="true" />
										</c:if> <c:if test="${item.active == false}">
											<fmt:message key="false" />
										</c:if></td>
									<td>
										<c:choose>
											<c:when test="${userCanEdit}">
												<c:if test="${not empty item.attachmentType}">
													<a
														href="<c:url value="docAttachmentEdit.htm"><c:param name="showId" value="${item.id}"/><c:param name="attachId" value="${item.attachmentType}"/></c:url>">
														<fmt:message key="docEdit" />
													</a>
												</c:if> <c:if test="${empty item.attachmentType}">
													<a href="<c:url value="linkEdit.htm"><c:param name="showId" value="${item.id}"/></c:url>">
														<fmt:message key="linkEdit" />
													</a>
												</c:if>
											</c:when>
											<c:otherwise>
												<c:if test="${not empty item.attachmentType}">
													<fmt:message key="docs.content" />
												</c:if> 
												<c:if test="${empty item.attachmentType}">
													<fmt:message key="docs.link" />
												</c:if>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
							<tfoot>
								<c:if test="${found}">
									<tr>
										<td colspan="6"><scannell:paging result="${result}" /></td>
									</tr>
								</c:if>
							</tfoot>
						</tbody>
					</table>
				</c:if>
				<c:if test="${!found}">
					<fmt:message key="search.empty" />
				</c:if>

			</div>
		</div>
	</div>
</body>
</html>
