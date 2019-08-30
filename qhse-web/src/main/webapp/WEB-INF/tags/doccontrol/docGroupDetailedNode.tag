<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="doccontrol" tagdir="/WEB-INF/tags/doccontrol"%>
<%@ attribute name="docGroup" required="true" type="com.scannellsolutions.modules.doccontrol.domain.DocGroup"%>
	    
      <li>
         <a id="${docGroup.id}" class="treeNode" href="#"><div onclick="window.location='<c:url value="/doccontrol/docGroupView.htm"><c:param name="id" value="${docGroup.id}"/></c:url>'"><c:out value="${docGroup.prefix}"/> </div>          
			<div onclick="window.location='<c:url value="/doccontrol/docGroupView.htm"><c:param name="id" value="${docGroup.id}"/></c:url>'"><h5 style="color:#13AB94"><c:out value="${docGroup.name}"/></h5></div>
			<c:if test="${!empty docGroup.documentsByStatus}">
				<div>
					<button id="docButton${docGroup.id}" class="docButton papers" data-toggle="collapse" data-target="#docList${docGroup.id}"  ondrop="drop(event)" ondragover="allowDrop(event)"><i class="fa fa-file" aria-hidden="true"></i></button>
					<div id="docList${docGroup.id}" class="collapse">
						<div id="docHolder${docGroup.id}" class="docHolderondragover="allowDrop(event)">
							<c:forEach var="doc" items="${docGroup.documentsByStatus}">
					 			<div id="doc${doc.id}" class="note"><c:out value="${fn:substring(doc.name, 0, 15)}"/><c:if test="${fn:length(doc.name) > 15}">...</c:if></div>
							</c:forEach>
						</div>	
					</div>
				</div>
			</c:if>
         </a>
 			<c:if test="${!empty docGroup.children}">
				<ul>
			 		<c:forEach var="node" items="${docGroup.children}">
			 			<!-- The build was failing when I used recursion and the tag, using include instead -->
						<%-- <doccontrol:docGroupDetailedNode docGroup="${node}"/> --%>
						<c:set var="docGroup" value="${node}" scope="request"/>
						<jsp:include page="docGroupDetailedNode.jsp"/>
					</c:forEach>
				</ul>
		   </c:if>
     </li>
