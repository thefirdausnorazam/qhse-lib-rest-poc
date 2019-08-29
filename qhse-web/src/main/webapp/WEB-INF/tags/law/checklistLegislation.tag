<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="checklist" required="true"
	type="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@ attribute name="relevantRelatedChecklist" required="true"
	type="java.util.Collection"%>
<%@ attribute name="profile" required="true"
	type="com.scannellsolutions.modules.law.domain.LegacyProfile"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>

<%@ tag import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@ tag import="com.scannellsolutions.modules.law.domain.LegacyProfile"%>
<script>
jQuery(document).ready(function(){     
    jQuery('.legAnchor').on('click', function(event) {
    	event.preventDefault ? event.preventDefault() : event.returnValue = false;
	    var url;
	    url = '<law:url value="/law/legislation.htm?legRegister=" />' + jQuery(this).attr('leg-regiLeg') + '&legId=' + jQuery(this).attr('leg-id');
	    if("${profile}" != "") 
	    {
	    	url = url +'&profileId='+jQuery('#profileSelect').val();
	    }
	    
	    location.href = url;
	  });
    jQuery('.legAnchorCheck').on('click', function() {    	
	    var url;
	    url = '<law:url value="/law/checklists.htm?legRegister=" />' + jQuery(this).attr('leg-regi') + '&chklistId=' + jQuery(this).attr('check-id')+'&viewAll=false&refine=false&checkDetail=true&checklistsPage=true';
	    location.href = url;
	  });
	  
});
</script>

<!-- Added By Manjush on 15 Jan 2015  -->

<div class="legislation-<c:out value="${checklist.id}" />">
<c:if test="${empty checklist.relatedLegislationsByRegionDisplayOrderAndOrigDate}">
 <i class="fa fa-times"></i> &nbsp; <fmt:message key='none'/>
</c:if>
     <div class="content">	
	 <c:forEach items="${checklist.relatedLegislationsByRegionDisplayOrderAndOrigDate}" var="legislation">	 
	  <a href="#" class="list-group-item legAnchor"  style="overflow: hidden;" leg-id="${legislation.id}" leg-regiLeg="${legislation.registerType.id}">
							  <h4>
							 
							     <c:choose>
							     <c:when test="${legislation.dispalyOrder.id == 1}">
								 <div class="col-sm-1"><i class="fa fa-circle"></i>  </div>
								 </c:when>
								 <c:when test="${legislation.dispalyOrder.id == 2}">
								 <div class="col-sm-1"><i class="fa fa-arrow-circle-down"></i> </div>
								 </c:when>
								 <c:otherwise>
								 <div class="col-sm-1"><i class="fa fa-circle-o"></i> </div> 
								  </c:otherwise>
								  </c:choose>	
								 
								
								<div class="col-sm-10">  
                                      <c:choose>
	                                  <c:when test="${empty text}">	
	                                  <c:out value="${legislation.name}" escapeXml="false" /> <br> </c:when>
	                                  
	                                 <c:otherwise>${text} <br> </c:otherwise>
                                     </c:choose>
                                     
                                 </div>
								<img src="<law:url value="/legal/images/${legislation.economicRegion.id}.gif" />">
								<%-- <c:if test="${legislation.changedInLatestContentVersionIncludingChildren}"><span class="badge badge-danger">NEW</span></c:if> --%>	
								<c:if test="${legislation.legNew}"><span class="badge badge-danger">NEW</span></c:if>		
								<c:if test="${legislation.changedInLatestContentVersionAmd}"><span class="badge badge-danger">Amd</span></c:if>								
								</h4>
							  </a>	 	
		
		<c:set var="lastEcomomicRegion" value="${legislation.economicRegion}" />
		<c:set var="lastDisplayOrder" value="${legislation.dispalyOrder}" />
	</c:forEach> 
	</div>
</div>

 <div>
    <c:if test="${empty checklist.changeComments}">
    <div class="changes-<c:out value="${checklist.id}" />">
    <i class="fa fa-times"></i> &nbsp; <fmt:message key='none'/>
    </div>
    </c:if>
	<c:if test="${not empty checklist.changeComments}">
		<div class="changes-<c:out value="${checklist.id}" />">
			<ul>
				<c:forEach items="${checklist.changeCommentsNewestFirst}" var="item">
					<li>
						<div >
							<h4 style="font-weight: bold;">Version ${item.version} -
							<fmt:formatDate value="${item.publicationDate}"	pattern="dd MMMM yyyy" /></h4>
						</div>
						<div>${item.comment}</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>
</div> 




 <div class="relatedCheck-<c:out value="${checklist.id}" />">
	<c:if test="${not empty relevantRelatedChecklist}">
		<div class="content">
			<c:forEach items="${relevantRelatedChecklist}"	var="relatedChecklist">			
				<div class="row">
				<c:choose>
                <c:when test="${not empty relatedChecklist.relevance && not empty relatedChecklist.compliance}">
                <div class="alert alert-info legAnchorCheck" style="cursor:pointer" check-id="${relatedChecklist.id}" leg-regi="${relatedChecklist.registerType.id}">
                <i class="fa fa-check sign"></i><c:out value="${relatedChecklist.name}"  />
				 </div>	
                </c:when>               
               <c:otherwise>
               <c:if test="${not empty relatedChecklist.relevance || not empty relatedChecklist.compliance}">
                 <div class="alert alert-warning legAnchorCheck" style="cursor:pointer" check-id="${relatedChecklist.id}" leg-regi="${relatedChecklist.registerType.id}">
                 <i class="fa fa-warning"></i> <c:out value="${relatedChecklist.name}"  />
				 </div>	
              </c:if>
              <c:if test="${empty relatedChecklist.relevance &&  empty relatedChecklist.compliance}">
                 <div class="alert alert-danger legAnchorCheck" style="cursor:pointer" check-id="${relatedChecklist.id}" leg-regi="${relatedChecklist.registerType.id}">
                <i class="fa fa-times-circle sign"></i><c:out value="${relatedChecklist.name}"  />
				 </div>
				 </c:if>              
                </c:otherwise>              
               </c:choose>			
               </div>
			</c:forEach>
		</div>
	</c:if>
	<c:if test="${empty relevantRelatedChecklist}">
	<div class="content">
	<i class="fa fa-times"></i> &nbsp; <fmt:message key='none'/>
	</div>
	</c:if>
</div>
