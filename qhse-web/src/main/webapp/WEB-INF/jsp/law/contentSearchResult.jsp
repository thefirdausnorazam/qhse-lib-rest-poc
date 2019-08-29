<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
  
</head>
<body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		initSortTablesForClass('dataTablePublication');
		initSortTablesForClass('dataTableChecklist');
		initSortTablesForClass('dataTableEvaluation');
		
		if(jQuery("#anchor").val() != '') {
			window.location.hash=jQuery("#anchor").val();
		}
		
		jQuery(".next").click(function() {
			var id = jQuery(this).closest(".panel").attr("id");
			updatePageNumber(id, true);
	    });
		jQuery(".prev").click(function() {
			var id = jQuery(this).closest(".panel").attr("id");
			updatePageNumber(id, false);
	    });
		jQuery(".recordsPerPage select").change(function() {
			var id = jQuery(this).closest(".panel").attr("id");
			updatePageSize(id, jQuery(this).val());
	    });
		
	} );

	
	function page(theForm, pageNumber) {
		//Keep this here to override one in utils
	}
	
	function updatePageNumber(id, next) {
		var tag = "#pageNumber"+id;
        var val = parseInt(jQuery(tag).val());
        val = next ? val+1 : val-1;
        jQuery(tag).val(val);
        updatePage(id);
	}
	
	function updatePageSize(id, size) {
		var tag = "#pageSize"+id;
        jQuery(tag).val(size);
        updatePage(id);
	}
	
	function updatePage(id) {
		var anchor = "anchor"+id;
        jQuery("#anchor").val(anchor);
        jQuery("#queryForm").submit();
	}
	
</script>
<div class="header">
<h3><fmt:message key="searchResults" /></h3>
</div>
<div class="content">  
<div class="table-responsive">

<!-- START: Search Keywords for Latest Publication -->
<c:if test="${!criteria.currentProfile && criteria.keywordSearch > 0}">
<div id="Key" class="panel" >
	<c:set var="foundKeywords" value="${!empty result.keywordChecklists.results}" />
	<c:if test="${foundKeywords}">
	  <div class="div-for-pagination" ><scannell:paging result="${result.keywordChecklists}" /></div>
	</c:if>
<table class="table table-bordered table-responsive dataTableEvaluation">
<caption><fmt:message key="searchLegalKeyWordChecklist" /></caption>
<col width="20%"/>
<col width="51%"/>
<col width="5%"/>
<col width="13%"/>
<thead style="text-align: center;"> 
  <tr >
    <th><fmt:message key="category" /></th>
    <th><fmt:message key="name" /></th>
    <th><fmt:message key="version" /></th>
    <th><fmt:message key="date" /></th>
  </tr>
</thead>
<tbody>
    <c:forEach items="${result.keywordChecklists.results}" var="item" varStatus="status">
      <tr>
        <td class="checklist-legislation-item"><c:out value="${item.category.name}" escapeXml="false" /></td>
        <td class="checklist-legislation-item">
            <a href="<c:url value="/law/checklistsForKeyword.htm"><c:param name="chklistId" value="${item.id}" /></c:url>">
            <c:out value="${item.name}" escapeXml="false" /></a>
            <law:checklistAltNames checklist="${item}" />
        </td>
        <td class="checklist-legislation-item"><c:out value="${item.version}" /></td>
        <td class="checklist-legislation-item"><fmt:formatDate value="${item.dateEnteredAsDate}" pattern="dd MMM yyyy"/></td>
      </tr>
    </c:forEach>
</tbody>
  <tfoot>    
    <c:if test="${foundKeywords}">
    <tr>
      <td colspan="4"> 
        <scannell:paging result="${result.keywordChecklists}" />
      </td>
    </tr>
    </c:if>
  </tfoot>
</table>
</div>
</c:if>
<!-- END: Search Keywords for Latest Publication -->

<!-- START: searchLegalPublication -->
<c:if test="${criteria.searchSynopsis && criteria.keywordSearch == 0}">
<a name="anchorLeg"/>
<div id="Leg" class="panel" >
	<c:set var="foundLegs" value="${!empty result.legislations.results}" />
	<c:if test="${foundLegs}">
	  <div class="div-for-pagination" ><scannell:paging result="${result.legislations}" /></div>
	</c:if>
<table class="table table-bordered table-responsive dataTablePublication">
<caption><fmt:message key="searchLegalPublication" /></caption>
<col width="20%"/>
<col width="1%"/>
<col width="51%"/>
<col width="5%"/>
<col width="13%"/>

<thead style="text-align: center;"> 
  <tr >
    <th><fmt:message key="category" /></th>
    <th></th>
    <th><fmt:message key="name" /></th>
    <th><fmt:message key="version" /></th>
    <th><fmt:message key="date" /></th>
  </tr>
</thead>
<tbody>
    <c:forEach items="${result.legislations.results}" var="item" varStatus="status">
      <tr>
        <td class="checklist-legislation-item"><c:out value="${item.category.name}" escapeXml="false" /></td>
        <td class="checklist-legislation-item" style="margin: 0; padding-left: 0; padding-right: 0;"><img src="<c:url value="/legal/images/${item.economicRegion.id}.gif" />"></td>
        <td class="checklist-legislation-item">
   <c:choose>
	  <c:when test="${viewType == 'relevant'}">
	    	<a href="<c:url value="/law/legislation.htm"><c:param name="legId" value="${item.id}" /><c:param name="profileId" value="${profile.id}" /><c:param name="search" value="yes" /><c:param name="view" value="${viewType}" /></c:url>">
           <c:out value="${item.name}" escapeXml="false" /></a> 
           <law:legislationAltNames legislation="${item}" />
	  </c:when>
	  <c:otherwise>
	       <a href="<c:url value="/law/legislation.htm"><c:param name="legId" value="${item.id}" /><c:param name="view" value="${viewType}" /></c:url>">
           <c:out value="${item.name}" escapeXml="false" /></a> 
           <law:legislationAltNames legislation="${item}" />
	  </c:otherwise>
	</c:choose>
  
        </td>
        <td class="checklist-legislation-item"><c:out value="${item.version}" /></td>
        <td class="checklist-legislation-item"><fmt:formatDate value="${item.origDateAsDate}" pattern="dd MMM yyyy"/></td>
      </tr>
    </c:forEach>
</tbody>
  <tfoot>    
    <c:if test="${foundLegs}">
    <tr>
      <td colspan="4"> 
        <scannell:paging result="${result.legislations}" />
      </td>
    </tr>
    </c:if>
  </tfoot>
</table>
</div>
</c:if>
<!-- END: searchLegalPublication -->

<!-- START: searchLegalChecklist -->
<c:if test="${criteria.searchChecklists && criteria.keywordSearch == 0}">
<a name="anchorCheck"/>
<div id="Check" class="panel" >
	<c:set var="foundChecklists" value="${!empty result.checklists.results}" />
	<c:if test="${foundChecklists}">
	  <div class="div-for-pagination" ><scannell:paging result="${result.checklists}" /></div>
	</c:if>
<table class="table table-bordered table-responsive dataTableChecklist">
<caption><fmt:message key="searchLegalChecklist" /></caption>
<col width="20%"/>
<col width="51%"/>
<col width="5%"/>
<col width="13%"/>
<!-- START: searchLegalPublication -->
<thead style="text-align: center;"> 
  <tr >
    <th><fmt:message key="category" /></th>
    <th><fmt:message key="name" /></th>
    <th><fmt:message key="version" /></th>
    <th><fmt:message key="date" /></th>
  </tr>
</thead>
<tbody>
    <c:forEach items="${result.checklists.results}" var="item" varStatus="status">
      <tr>
        <td class="checklist-legislation-item"><c:out value="${item.category.name}" escapeXml="false" /></td>
        <td class="checklist-legislation-item">
            <a href="<c:url value="/law/checklists.htm"><c:param name="chklistId" value="${item.id}" /><c:param name="view" value="${viewType}" /></c:url>">
                <c:out value="${item.name}" escapeXml="false" /></a>
            <law:checklistAltNames checklist="${item}" />
        </td>
        <td class="checklist-legislation-item"><c:out value="${item.version}" /></td>
        <td class="checklist-legislation-item"><fmt:formatDate value="${item.dateEnteredAsDate}" pattern="dd MMM yyyy"/></td>
      </tr>
    </c:forEach>
</tbody>
  <tfoot>    
    <c:if test="${foundChecklists}">
    <tr>
      <td colspan="4"> 
        <scannell:paging result="${result.checklists}" />
      </td>
    </tr>
    </c:if>
  </tfoot>
</table>
</div>
</c:if>
<!-- END: searchLegalChecklist -->

<!-- START: searchLegalRelAndCom -->
<c:if test="${(criteria.searchRelevance || criteria.searchEvaluationOfCompliance)  && criteria.keywordSearch == 0}">
<a name="anchorRel"/>
<div id="Rel" class="panel" >
	<c:set var="foundRels" value="${!empty result.relevance.results}" />
	<c:if test="${foundRels}">
	  <div class="div-for-pagination" ><scannell:paging result="${result.relevance}" /></div>
	</c:if>
<table class="table table-bordered table-responsive dataTableEvaluation">
<caption><fmt:message key="searchLegalRelAndCom" /></caption>
<col width="20%"/>
<col width="51%"/>
<col width="5%"/>
<col width="13%"/>
<thead style="text-align: center;"> 
  <tr >
    <th><fmt:message key="category" /></th>
    <th><fmt:message key="name" /></th>
    <th><fmt:message key="version" /></th>
    <th><fmt:message key="date" /></th>
  </tr>
</thead>
<tbody>
    <c:forEach items="${result.relevance.results}" var="item" varStatus="status">
      <tr>
        <td class="checklist-legislation-item"><c:out value="${item.category.name}" escapeXml="false" /></td>
        <td class="checklist-legislation-item">
            <a href="<c:url value="/law/checklists.htm"><c:param name="chklistId" value="${item.id}" /><c:param name="view" value="${viewType}" /></c:url>">
                  <c:out value="${item.name}" escapeXml="false" /></a>
            <law:checklistAltNames checklist="${item}" />
        </td>
        <td class="checklist-legislation-item"><c:out value="${item.version}" /></td>
        <td class="checklist-legislation-item"><fmt:formatDate value="${item.dateEnteredAsDate}" pattern="dd MMM yyyy"/></td>
      </tr>
    </c:forEach>
</tbody>
  <tfoot>    
    <c:if test="${foundRels}">
    <tr>
      <td colspan="4"> 
        <scannell:paging result="${result.relevance}" />
      </td>
    </tr>
    </c:if>
  </tfoot>
</table>
</div>
</c:if>
<!-- END: searchLegalRelAndCom -->
</div>
</div>

</body>
</html>
