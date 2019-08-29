<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="doccontrol" tagdir="/WEB-INF/tags/doccontrol"%>
<%@ attribute name="docGroup" required="true" type="com.scannellsolutions.modules.doccontrol.domain.DocGroup"%>
<%@ attribute name="canEdit" required="true" rtexprvalue="true" type="java.lang.Boolean" description="if not part of current site cannot edit" %>
<%@ attribute name="showDocuments" required="true" rtexprvalue="true" type="java.lang.Boolean" %>

      <li class="docGroup" <c:if test="${canEdit && !showDocuments}">ondrop="dropDocGroup(event)" ondragover="allowDropDocGroup(event)"</c:if>>
         <a title="<fmt:message key='doccontrol.docGroup.viewSubHierarchy'/>" id="${docGroup.id}" class="treeNode <c:if test="${!docGroup.activeStatus}">inactiveGroup</c:if>" 
         	<c:if test="${canEdit && docGroup.parentDocGroup.id > 0 && docGroup.activeStatus && !showDocuments}">draggable="true"  ondragstart="drag(event)"</c:if> href="#">
         	
         	<!-- Display Doc Group Prefix and Name -->
         	<div onclick="window.location='<c:url value="/doccontrol/docGroupsSubView.htm"><c:param name="id" value="${docGroup.id}"/></c:url>'"><c:out value="${docGroup.prefix}"/></div>          
			<div onclick="window.location='<c:url value="/doccontrol/docGroupsSubView.htm"><c:param name="id" value="${docGroup.id}"/><c:param name="showDocuments" value="${showDocuments}" /></c:url>'"><h5 style="color:#13AB94"><c:out value="${fn:substring(docGroup.name, 0, 30)}"/><c:if test="${fn:length(docGroup.name) > 30}">...</c:if></h5></div>
			
			<!-- Add Sub Doc Group -->
			<c:if test="${canEdit && docGroup.activeStatus}">
				<p title="<fmt:message key='doccontrol.addSubDocGroup'/>" class="newGroup" id="<c:url value="/doccontrol/docGroupAddSubGroup.htm">
					<c:param name="parentId" value="${docGroup.id}"/>	
				    <c:param name="rootId" value="1"/>			
				</c:url>"><i class="material-icons">create_new_folder</i></p>  
			</c:if>
			
			<!-- Edit Doc Group -->
			<p  title="<fmt:message key='doccontrol.editDocGroup'/>" class="edit" id="<c:url value="/doccontrol/docGroupView.htm"><c:param name="id" value="${docGroup.id}"/></c:url>"><i class="fa fa-edit small-icon"></i></p>
         	
         	<!-- Move documents -->
			<c:if test="${canEdit && docGroup.activeStatus && showDocuments}">
				<div>
					<button  title="<fmt:message key='doccontrol.docGroup.viewDocuments'/>" id="docButton${docGroup.id}" class="docButton papers" data-toggle="collapse" data-target="#docList${docGroup.id}"  ondrop="drop(event)" ondragover="allowDrop(event)"><i class="fa fa-file" aria-hidden="true"></i></button>
					<div id="docList${docGroup.id}" class="collapse" >
						<div id="docHolder${docGroup.id}" class="docHolder" ondrop="drop(event)" ondragover="allowDrop(event)">
							<c:choose>
								<c:when test="${fn:length(docGroup.documentsByStatus) > 0}">
									<c:forEach var="doc" items="${docGroup.documentsByStatus}">
							 			<div id="doc${doc.id}" class="note" draggable="true" ondragstart="drag(event)"><c:out value="${fn:substring(doc.name, 0, 15)}"/><c:if test="${fn:length(doc.name) > 15}">...</c:if></div>
									</c:forEach>
								</c:when>
								<c:otherwise><fmt:message key='doccontrol.docGroup.empty'/></c:otherwise>
							</c:choose>
						</div>	
					</div>
				</div>
				</br>
			</c:if>
         </a>
         	<!-- All the Doc Group children -->
			<ul id="docGroupList${docGroup.id}" class="docGroupList <c:if test="${empty docGroup.children}">hideDocGroupChildren</c:if>">
		 		<c:forEach var="node" items="${docGroup.children}">
		 			<!-- The build was failing when I used recursion and the tag, using include instead -->
					<%-- <doccontrol:dgIcon docGroup="${node}"/> --%>
					<c:set var="docGroup" value="${node}" scope="request"/>
					<c:set var="canEdit" value="${canEdit}" scope="request"/>
					<c:set var="showDocuments" value="${showDocuments}" scope="request"/>
					<jsp:include page="docGroupNode.jsp"/>
				</c:forEach>
			</ul>
     </li>
