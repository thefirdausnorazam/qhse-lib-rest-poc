<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>

<head>
	 <title><fmt:message key="measurementReportView" /></title> 
	<script type="text/javascript" src="<c:url value="/js/datatables/datatables.min.js" />"></script>
	<style type="text/css" media="all">    
        @import "<c:url value='/js/datatables/datatables.min.css'/>";
     </style>
	<script type="text/javascript">
	jQuery(document).ready(function() {
		
		var columnLength = '${fn:length(command.selectedMeasurementWithLogicalVariables)}';
		var orientation = (columnLength>6) ? "landscape" : "portrait";
		jQuery('#tableMeasurementReadings').DataTable( {
	        dom: 'rtpB',
	        colReorder: true,
	        stateSave: true,
	        buttons: [
           {
				extend: 'pdfHtml5',
				orientation: orientation,
				pageSize: 'LEGAL',
				exportOptions:{
	                  			rows: ':not(.hideRow)'
                              },
                customize: function ( doc ) {
		                     doc.content.splice( 0, 0, {
		                         margin: [ 0, 0, 0, 0 ],
		                         alignment: 'center',
		                         image: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAALMAAAAeCAYAAABnli/DAAAACXBIWXMAAAsSAAALEgHS3X78AAAHrklEQVR4nO1cS3LbOBDtuLS3b2DnBCJPYOUEpndcTJWVE5grba1suYl8AtM77UKfwPIJJJ5gpMWsRzpBplr14MCtBglS32T4qlhlUyQAAg+N190gP/38+ZN8EYfpFRHxERDRBW6bENF8PB3MvQtq0WIPqCQzCJwQUURElyWXLogoJ6JRS+wWx4CTzHGYsuUdEdFdg3Y9E9GwJXWLQ0IlcxymbIUzIjrfoi0rIuqPp4O8HdEWh8AGmeMw7RPRU0XdBREtoZu7Fdd+HU8HWTuavxCHaYBVz0Yyng5mJ9C83xYdu+EVRGbpkGuWFpY8ckiSpzhMqQmh0Z4IDqfR629ENNuFNkf5/YrLZjj42Zfb1GeBjcC1cu5k4JhwZVhPRuu+zGfMretn4+kgUX5nn20IDhjDuUDggeuYmGs7SqESBeSC02qA4HkcpiPIE2mtmdAzX8uDtmjlEEjAx30cpo9aB9TAlUIqrT7GiJ9vPB0Mt6jvd4I24cpgJqO5b1LjPrUe8Oke/xYwZAZsOO/iMH1f+W3LPFI08guI7GWRQNYgDtNMsdIZZlcpQOSJp15nQgfj6aDn074twe15YEsxng6qrPmfhG/HmMBxmA5B5AJWfyJ+vwKn2FD2eEzO6NdyK2dHMZ4OIklkJk8cpglXhmODoBjsF3G6i3qq4HI8CywvEtd48EOBrcE2q0ELP5g+jiSRwbE5JGiBMQmMZZYkW+HCd1gyRJKerdWb4sBwmXNBzARkVQGyS2lR4IHW+tih67kN2Y5CgV9M5/GMR5tvxDVJTT3ZGGgDY1lDppnkFkGL7krrHwTgGvPmrWxM+bkgRZgPUQcPLgn6wbnyWPrXGgnmfmZVlAjidSELXIOiWbzIbgvrI7T5QV63a4IxqVnrE9G/4qdLtKEv2zGeDj6Zv7FiOH93Af09lJOIHWmseCPNWqG+vkxuxWFaIO6fW+ci1LFEeacUQjWTj1XARcVknBktzTJD05vvpEDyJPfQsOcgtO2Vax2k6lvcJ62ya2ZqpI2Uc1sDHfmmlHO146rWwMozVVYDAz7/aks27jtMugdHlpb79YeRY4LIfCQ4dxLAmC/AqVJJx4aRfSbW9WeKUyZ1aVUa28a5LVlABKmdXc6a5hyqHjHKle2s43nXxV6IK2FlXX3whNWBSiI/Eg+QLX2QeY5+z/ZlDLaA8YOMf1YZuuwoJLq0JMOywUPK5X4mrMyu4qnzGpOsESwpsVEPJMiuoyiBsgLesgRAXa/it34cprlixRcYgwDjYZc5tJbxK+tv11Leq3KwHdGOyvusNmhlZpBVI6w4CZ6Vj4kmPTpaQZjlZrDqkq8y/LZvxGFaFuNUg/MWXtGJZXg+4OOsBw2T55v4beIwNpHxS+C3fLd+4xXsL5B6hPEdlRita49VTyOtz32lAKEn1ka3OxPyjcN0w3fQyPwIKdCtEfi2cQqe8z4lR1Gl47aA5hi/woEzFknGWyWR1pEoSwNrlu8fENA8R19zKIHnsghUCXzvC8Rk+wDo5wSWOcBKGWE1uonD9NnE/V2WuQci++gwiUPtLzhG+rdWEqkuEAF6tLJeBl0crHlXIMnQ0Y5zJdKzAZO19WjivIToW9/nsQq+A6uNIXbP7OpEIqvXAWltS9ZDpzYltOwguXy54oba+TLJosWjDbTog0HVZCvE6rLEPbuKY5eCJRAiE1pGlnDuHn1ziMznSQITJTA+A69EHWVwu2D6vAGhC3tzCRwoea8rQsH1LYSz1dPijI5M4vtzbJne3kidHhrQijkMQQ+HdEKvS8JpjxVy76T3mWN8rzzT6CYe/26ZtQv6NS10oVgKrTFlRMnFEnsOC/Uhpuoo9xS3mdYK6SGbZa9GudGDIO4PcUuASSx9hKUkAgjivdnryIhgbXOP9pqJGXRA2GexMegO6eGJB6FXINzItqAQ63Kz0UvFUm0yWPbyeoeycuhk+TshuXJUa2pghY+GDUKHczGZAwzovMSaZorGfrD6jNBnTPgFMrCnnt6ewNomHlt0zeo0P8MfWqA+N4FqPHzP0qVM4FsiCsfTAcuAoSDyhcO5KE0IoAwtUtCFU3OvEHnl8cD7gvaMN0jhN4mBy/L4Wf+Ow3SJrODG9bBcLCtc7XiyLPdlwwjVoZFhXEs3dYlty9k6moFN1dI6c0fy+QgpQ2mhh5oDAp2cK4P54mM9rWB51dsuBv1jvWuIfnsrCQWu6rx6Br/hVtk5qJXxaO2DYafxwuN9zUWDie+b/NgIGzaF4Np3EDqDpFpCXtkrP29TnZxZ9SVKithkA9cPIyx0V9mLQQ7Ho5b1hBP52TM5ke0hE1cHkSN68tZkxUDIrFcSkSmQFUzEfVzXV8c2WUJYsWyTlwvXWBWrjp2OAdrJhtEkih7gM7wiLn2HPvpi/IMP7wBW7I4z8c0chDX7AQoTzrPKubAs+Aq/N3Y8BFm1LZl07HcNxbbLnXxHBP1oO4Re2zlFW+hU/IltIJ9J6wvthdY6b3oYuAid7+NFTWVr5Qr1tC/O/o/h+tSAIWKdtPAGofcJ63MItK3lb/FnoPSLRohN1gkxHZrQAWKq7cdmWlR/nos+fkpAy0SR9eq3+imCFi0OgVofTrTIbT6c6P1eWosWewUR/QfB7tbQLNDoGAAAAABJRU5ErkJggg=='
		                     } );
                 },
                 title: 'Q-Pulse: Data Reports'

            },
            {
  				extend: 'excelHtml5',
  				exportOptions:{
  	                 			 rows: ':not(.hideRow)',
  								 title: 'Q-Pulse: Data Reports'
  	             			  },
  	            customize: function( xlsx ) 
  	            			 {
  	               				 var sheet = xlsx.xl.worksheets['sheet1.xml'];
   	                			 jQuery('row c[r^="A"]', sheet).attr( 's', '2' );
   	            			 }
             },
             {
      			extend: 'csv',
      			exportOptions:{
      	               		 	rows: ':not(.hideRow)',
      	               		rows: ':not(.hideRow2)'
      	           			 }

              },
              {
      			extend: 'copy',
      			exportOptions:{
      	            	       rows: ':not(.hideRow)'
      	        	     	 }
              }
        ],
	    "bPaginate": false,
	    "bSort" : false,
	    
	    } );
		
		
		 jQuery( ".dt-button" ).removeClass( "dt-button" ).addClass( "btn btn-primary" );
		 
				jQuery("#hideShowCalculation").click(function () {
				jQuery(this).text(function(i, text){
		          return text === "Hide Calculations" ? "Show Calculations" : "Hide Calculations";
		      })
		   });
	});

	function onTimeChangeSubmitForm(){
		if (jQuery('#reportingYear').length) {
			jQuery('#reportingYear').val(jQuery('#yearList').val());
		}
		if (jQuery('#reportingMonth').length) {
			jQuery('#reportingMonth').val(jQuery('#monthList').val());
		}
		if (jQuery('#reportingWeek').length) {
			jQuery('#reportingWeek').val(jQuery('#weekList').val());
		}
		jQuery('#form').submit();
	}

	function SaveComment(){
		jQuery("#saveComment").val("true");
		jQuery("#comment").val(encodeURI(jQuery("#commentText").val().replace(/'/g, "`")));
		onTimeChangeSubmitForm();
		
	}
	
	function ClearPlaceHolder(input) {
	    if (input.value == input.defaultValue) {
	        input.value = "";
	    }
	}

	function SetPlaceHolder(input) {
	    if (input.value == "") {
	        input.value = input.defaultValue;
	    }
	}
	// Had to write own print as on reload report show current reporting period
	function printData() {
	   var divToPrint=document.getElementById("tableMeasurementReadingsInfo");
	   var divToPrint2=document.getElementById("tableMeasurementReadings");
	   var htmlToPrint = '' +
       '<style type="text/css">' +
       'table th, table td {' +
       'border:1px solid #DADADA;' +
       'padding;0.5em;' +
       '}' +
       'table {'+
    	'border-collapse: collapse;'+
    	'}'+
       '</style>';
   htmlToPrint += divToPrint.outerHTML;
   htmlToPrint += divToPrint2.outerHTML;
   newWin = window.open("");
   newWin.document.write(htmlToPrint);
   newWin.document.close();
   newWin.print();
   newWin.close();
	}
	
	function toggleClass(){
		jQuery('.dynamicRow' ).toggleClass( "hideRow showRow" );
		jQuery('.showRow' ).show();
		jQuery('.hideRow' ).hide();
	}
	
	</script>
<style type="text/css">

td{
border: 1px solid black;
}
.center td {
border: 1px solid black;
text-align: center !important;
}
.drag {
border: 1px solid black;
cursor: pointer;
}



</style>
</head>

<div>
	<div style="float: left;">
<%-- 		<h3 style="color: #13AB94">
		${command.title}
		</h3> --%>
	</div>
	<div align="right">
		<button type="button"	onclick="printData();"	class="g-btn g-btn--primary">
			<i class="fa fa-print printcolor" style="color: white"></i><span	class="printcolor"></span>
		</button>
	</div>
</div>

<body>
<scannell:form id="form">

<div class="content">
<div class="table-responsive">

<table id="tableMeasurementReadingsInfo" class="table table-bordered table-responsive" style="width: 100%; border-top: 1px solid #DADADA;">
  <tr>
    <th class="scannellGeneralLabel nowrap"><fmt:message key="id" />:</th>
    <td><c:out value="${command.id}" /></td>
  </tr>
    <tr>
    <th class="scannellGeneralLabel nowrap"><fmt:message key="title" />:</th>
    <td><c:out value="${command.title}" /></td>
  </tr>
   <tr>
    <th class="scannellGeneralLabel nowrap"><fmt:message key="addLicenseReference" />:</th>
    <td>
    	 <c:out value="${command.licenseReference}" />
     </td>
  </tr>
   <tr>
    <th class="scannellGeneralLabel nowrap"><fmt:message key="readingPoint" />:</th>
    <td>
    	 <c:out value="${command.selectedMeasurementWithLogicalVariables[0].measurement.readingPoint.description}" />
     </td>
  </tr>
     <tr >
    <th class="scannellGeneralLabel nowrap"><fmt:message key="reportingType" />:</th>
    <td >
 		<c:out value="${command.period}" />
 		<c:if test="${command.period == 'Yearly'}">
 		(${command.reportingYear})
 		</c:if>
 		<c:if test="${command.period == 'Monthly'}">
 		(${command.reportingMonth}-${command.reportingYear})
 		</c:if>
 		<c:if test="${command.period == 'Weekly'}">
 		(${command.reportingWeek}  ${command.reportingYear})
 		</c:if>
    </td>
  </tr>
    <tr class="noExcel">
    <th class="scannellGeneralLabel nowrap noExcel"><fmt:message key="reportyear" />:</th>
    <td>	
    <select id="yearList" name="yearList"  class="narrow" onchange="onTimeChangeSubmitForm();">
				<c:forEach items="${command.yearList}" var="year">
					<option value="${year}" ${command.reportingYear == year ? 'selected' : ''}>${year }</option>
				</c:forEach>
			</select>
		
    </td>
  </tr>
    <c:if test="${command.period == 'Monthly'}">
   <tr class="noExcel">
    <th class="scannellGeneralLabel nowrap noExcel"><fmt:message key="reportingMonth" />:</th>
    <td class="noExcel">
        <select id="monthList" name="monthList"  class="narrow" onchange="onTimeChangeSubmitForm();">
				<c:forEach items="${command.monthList}" var="month">
					<option value="${month}" ${command.reportingMonth == month ? 'selected' : ''}>${month }</option>
				</c:forEach>
		</select>
    </td>
  </tr>
  </c:if>
  <c:if test="${command.period == 'Weekly'}">
   <tr class="noExcel">
    <th class="scannellGeneralLabel nowrap noExcel"><fmt:message key="reportingWeek" />:</th>
    <td class="noExcel">

         <select id="weekList" name="weekList"  class="narrow" onchange="onTimeChangeSubmitForm();">
				<c:forEach items="${command.weekList}" var="week">
					<option value="${week}" ${command.reportingWeek == week ? 'selected' : ''}>${week }</option>
				</c:forEach>
		</select>   
    </td>
  </tr>
  </c:if>
     <tr>
    <th class="scannellGeneralLabel nowrap "><fmt:message key="createdBy" />:</th>
    <td><c:out value="${command.createdByUser.displayName}" /></td>
  </tr>
       <tr>
    <th class="scannellGeneralLabel nowrap"><fmt:message key="createdTs" />:</th>
    <td>
    <fmt:formatDate type="both" dateStyle="medium" pattern="dd-MMM-yyy H:m" value="${command.createdTs}" />
    </td>
  </tr>
</table>
</div>
</div>
<div class="content"> 
<div class="table-responsive">
<div class="panel"> 
<c:set var="found" value="${!empty result.results}" />
<table id="tableMeasurementReadings"   class="table table-bordered table-responsive"  style="width: 100%; border-top: 1px solid #DADADA;" >

<thead>

	<tr>
		<th class="drag"><fmt:message key="date" /></th>
		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<th class="drag" ${variable.master ? 'bgcolor="#D3D3D3"' : ''} >${variable.measurement.quantity.name}</br>(${variable.measurement.defaultUnit.symbol })</th> 
		</c:forEach>
	</tr>
</thead>

<tbody>
	<tr class="even hideRow dynamicRow" style="display:none">
		<td class="hideRow dynamicRow"><span style="font-weight:bold">Parameter</span></td>
	<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td align="center">
			<a href="<c:url value="quantityView.htm"><c:param name="id" value="${variable.measurement.quantity.id}"/></c:url>"><c:out	value="${variable.measurement.quantity.id}" /></a>
			</td>
	</c:forEach>
	</tr>
	<tr class="odd hideRow dynamicRow" id="measurementRow" style="display:none">
		<td><span style="font-weight:bold">Measurement</span></td>
	<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td class="hideRow dynamicRow" align="center"><a href="<c:url value="measurementView.htm"><c:param name="id" value="${variable.measurement.id}"/></c:url>"><c:out	value="${variable.measurement.id}" /></a></td>
	</c:forEach>
	</tr>
	<c:if test="${command.externalLimit}">
	<tr class="even">
		<td><span style="font-weight:bold"><fmt:message key="externalLimit" /></span></td>
	<c:forEach items="${externalLimitList}" var="eLimit" varStatus="s">
			<td><c:out value="${eLimit}" /></td>
	</c:forEach>
	</tr>
	</c:if>
	<c:if test="${command.internalLimit}">
	<tr class="odd">
		<td><span style="font-weight:bold"><fmt:message key="internalLimit" /></span></td>
	<c:forEach items="${internalLimitList}" var="eLimit" varStatus="s">
			<td><c:out value="${eLimit}" /></td>
	</c:forEach>
	</tr>
	</c:if>
	<c:forEach items="${dates}" var="date" varStatus="s">
		<tr class="even">
		<c:if test="${command.period == 'Yearly'}">
			<td><span style="font-weight:bold" class="nowrap">${command.monthList[s.index]}</span></td>
		</c:if>
		<c:if test="${command.period != 'Yearly'}">
			<td><span style="font-weight:bold" class="nowrap">${date}</span></td>
		</c:if>
			<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			
			<td align="center">
				<c:if test="${!variable.measurement.rate and !variable.measurement.accumulation and !null}">
					${measurementAndItsReadings[variable.measurement.id][date].reading.value}
				</c:if>
				<c:if test="${variable.measurement.rate or variable.measurement.accumulation}">
				<fmt:formatNumber minFractionDigits="2" maxFractionDigits="2" value="${measurementAndItsReadings[variable.measurement.id][date].readingAvg}"/>
				<c:if test="${readingWithCustomUnit[measurementAndItsReadings[variable.measurement.id][date].reading.id] != null}">
					(${readingWithCustomUnit[measurementAndItsReadings[variable.measurement.id][date].reading.id]})
				</c:if>
				</c:if>
			</td>
			</c:forEach>
		</tr>
	</c:forEach>
	<!-- (${readingMap[measurement.id]}) -->
	<tr class="odd">
		<td><span style="font-weight:bold"><fmt:message key="emissionLimit" /></span></td>
		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td align="center">
				${variable.emissionLimitValue}
			</td>
		</c:forEach>
	</tr>
	<c:if test="${command.sumColumn}">
		<tr class="even">
		<td><span style="font-weight:bold"><fmt:message key="sumColumns" /></span></td>
		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td align="center">
			<c:if test="${allReadingSum[variable.measurement.id]>0 }">
				${allReadingSum[variable.measurement.id]}
			</c:if>
			</td>
		</c:forEach>
	</tr>
	</c:if>
	<c:if test="${command.avgColumn}">
	<tr class="odd" >
		<td><span style="font-weight:bold"><fmt:message key="avgColumns" /></span></td>
		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td align="center">
			<c:if test="${allReadingAvg[variable.measurement.id]>0 }">
				${allReadingAvg[variable.measurement.id]}
			</c:if>
			</td>
		</c:forEach>
	</tr>
	</c:if>
	<c:if test="${command.ytdColumn}">
	<tr class="even">
		<td><span style="font-weight:bold"><fmt:message key="ytdTotal" /></span></td>
		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td align="center">
			<c:if test="${allReadingYtd[variable.measurement.id]>0 }">
				${allReadingYtd[variable.measurement.id]}
			</c:if>
			</td>
		</c:forEach>
	</tr>
	</c:if>
	

	<tr class="hideRow odd dynamicRow noExcel2" style="display:none">
		<td class="hideRow dynamicRow"><span style="font-weight:bold"><fmt:message key="customUnitByUser" /></span></td>
		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td class="slideRow2" align="center">
				${variable.customSymbol}
			</td>
		</c:forEach>
	</tr>
		
	<tr class="hideRow even dynamicRow noExcel2" style="display:none">
		<td class="hideRow dynamicRow"><span style="font-weight:bold"><fmt:message key="result" /></span> (<fmt:message key="calculation" />)</td>
		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td class="slideRow2" ${variable.master ? 'bgcolor="#D3D3D3"' : ''} align="left">
			<c:if test="${variable.master}">
			<p style="font-size:12px">
			<span style="font-weight:bold"><fmt:message key="master" /></span>
			</p>
			</c:if>
			<c:if test="${! variable.master}">
			<p style="font-size:12px">
				<span style="font-weight:bold">${calculationResult[variable.id]}</span>
			</p>
			</c:if>
				
			</td>
		</c:forEach>
	</tr>
	<c:if test="${command.addComment}">
	<tr>
		<td ><span style="font-weight:bold">Comment</span></td>
		<td id="commentTd" colspan="${fn:length(command.selectedMeasurementWithLogicalVariables)}">${command.comment}</td>
		 <c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td style="display:none" ></td>
		</c:forEach>
	</tr>	
	</c:if>
	<c:forEach var="i" begin="1" end="5">
	  	<tr style="display:none" class="hideRow2">
			<td class="hideRow2" >-</td>
			<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td class="hideRow2" >&nbsp;</td>
			</c:forEach>
		</tr>
	</c:forEach>
	<tr style="display:none">
   		 <td class="scannellGeneralLabel nowrap"><fmt:message key="id" /></td>
   		 <td><c:out value="${command.id}" /></td>
   		 <c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td ></td>
		</c:forEach>
     </tr >
    <tr style="display:none">
    		<td class="scannellGeneralLabel nowrap"><fmt:message key="title" /></td>
    		<td><c:out value="${command.title}" /></td>
   			<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
				<td ></td>
			</c:forEach>
    </tr>
   <tr style="display:none">
    		<td class="scannellGeneralLabel nowrap"><fmt:message key="addLicenseReference" /></td>
    		<td><c:out value="${command.licenseReference}" /></td>
    		<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
				<td ></td>
			</c:forEach>
  </tr>
  
   <tr style="display:none">
   	 <td ><fmt:message key="readingPoint" />:</td>
   	     <td> <c:out value="${command.selectedMeasurementWithLogicalVariables[0].measurement.readingPoint.description}" />    </td>
   	 	<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td ></td>
		</c:forEach>
    </tr>
    
       <tr style="display:none">
   	 <td ><fmt:message key="reportingType" /></td>
   	     <td>  		
	   	     <c:out value="${command.period}" />
	 		<c:if test="${command.period == 'Yearly'}">
	 		(${command.reportingYear})
	 		</c:if>
	 		<c:if test="${command.period == 'Monthly'}">
	 		(${command.reportingMonth}-${command.reportingYear})
	 		</c:if>
	 		<c:if test="${command.period == 'Weekly'}">
	 		(${command.reportingWeek}  ${command.reportingYear})
	 		</c:if>   
 		 </td>
   	 	<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td ></td>
		</c:forEach>
    </tr>
    
       <tr style="display:none">
   	 <td ><fmt:message key="createdBy" />:</td>
   	     <td> <c:out value="${command.createdByUser.displayName}" />   </td>
   	 	<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td ></td>
		</c:forEach>
    </tr>
    
       <tr style="display:none">
   	 <td ><fmt:message key="createdTs" />:</td>
   	     <td>  <fmt:formatDate type="both" dateStyle="medium" pattern="dd-MMM-yyy H:m" value="${command.createdTs}" />    </td>
   	 	<c:forEach items="${command.selectedMeasurementWithLogicalVariables}" var="variable" varStatus="s">
			<td ></td>
		</c:forEach>
    </tr>

</tbody>
</table>
<c:if test="${allowCreateReport == true }">
<c:if test="${command.addComment}">
<div style="clear: both;"></div>
<div>
<div style="width: 20%; float: left;"> &nbsp; </div>
<div class="input-group spacer2 text-center" style="width: 60%; float: left;" >
    <textarea name="commentText" id="commentText" class="form-control custom-control" rows="3" cols="100" style="resize:none" onfocus="ClearPlaceHolder(this)" onblur="SetPlaceHolder(this)">Enter Comment here...</textarea>     
    <span class="input-group-addon btn btn-primary"  onclick="SaveComment();" ><fmt:message key="save" /></span>
 </div>

  </div>
</c:if>
</c:if>
<iframe id="txtArea1" style="display:none"></iframe>
</div>
</div>
</div>
<input type="hidden" id="reportingYear" name="reportingYear">
<input type="hidden" id="reportingMonth" name="reportingMonth">
<input type="hidden" id="reportingWeek" name="reportingWeek">
<input type="hidden" id="comment" name="comment" value="hello">
<input type="hidden" id="saveComment" name="saveComment">
</scannell:form>

<div style="clear: both;"></div>
<div class="spacer2 text-center">
<button type="button" id="hideShowCalculation" value="Export" class="g-btn g-btn--primary" onclick="toggleClass();" data-toggle="tooltip" id="relevant">
<fmt:message key="showCalculation" />
</button>
<a href="<c:url value="measurementEditReport.htm"><c:param name="id" value="${command.id}"/></c:url>" class="g-btn g-btn--primary" >
	<fmt:message key="trash" />
</a>
</div>
</body>
</html>
