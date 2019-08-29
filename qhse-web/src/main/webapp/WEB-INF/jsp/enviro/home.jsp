<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="expires"   content="0">
	<meta http-equiv="pragma"    content="no-cache">
	<meta http-equiv="copyright" content="&copy; Ideagen">
	<meta http-equiv="robots"    content="noindex, nofollow, noarchive">	

	<script language="javascript" src="<c:url value="/js/utils.js" />"> </script>
	<script language="javascript" src="<c:url value="/js/incident.js" />"> </script>
	<script type="text/javascript">
		jQuery(document).ready(function() {
			    if(getUrlParameter('IncidentSaved')=='true'){
		    		jQuery('#frameMcont').prepend('<div class="alert alert-success" id="alertLicence"><button type="button" data-dismiss="alert" aria-hidden="true" class="close">×</button><i class="fa fa-times-circle sign"></i><strong><fmt:message key="incident.saved" /></strong> <fmt:message key="incident.saved.message" /></div>');
			    	
			    }
		});
		
		function updateForm(form) {
			  document.filterForm.typeId.value = document.trendForm.incidentType.value
			  document.filterForm.subTypeId.value = document.trendForm.incidentSubType.value  
			  document.filterForm.rootCauseId.value = document.trendForm.causeType.value 
			  document.filterForm.departmentId.value = document.trendForm.department.value
			  document.filterForm.fromOccurredDate.value = document.trendForm.fromDate.value
			  document.filterForm.toOccurredDate.value = document.trendForm.toDate.value
			  document.filterForm.primaryGroupByName.value = document.trendForm.primaryGroupByName.value
			}
		
		
		 window.onload = function() {

		        var imgWidth = sessionStorage.getItem('imgwidth');
		        jQuery('.box-images').find('img').width(imgWidth);

		        var imgHeight = sessionStorage.getItem('imgheight');
		        jQuery('.box-images').find('img').height(imgHeight);

		        var boxWidth = sessionStorage.getItem('boxwidth');
		        jQuery('.box-images').width(boxWidth);

		        var boxHeight = sessionStorage.getItem('boxheight');
		        jQuery('.box-images').height(boxHeight);
		    }
		    
		function changeImgDimmension(value, obj){
			jQuery('.img-square-results').css('opacity', '0.5');
			jQuery(obj).css('opacity', '1');
			if(value == '2'){
				jQuery('.box-images').width((jQuery('.div-container').width() / 2) - 100);
				jQuery('.box-images').height(500);
			} else if(value == '3'){
				jQuery('.box-images').width((jQuery('.div-container').width() / 4) - 50);
				jQuery('.box-images').height(300);
			} else {
				jQuery('.box-images').width((jQuery('.div-container').width() / 5) - 50);
				jQuery('.box-images').height(200);
			}
			jQuery('.box-images').find('img').width(jQuery('.box-images').width() - 50);
			jQuery('.box-images').find('img').height(jQuery('.box-images').height() - 50);
			
			 sessionStorage.setItem("imgwidth", jQuery('.box-images').width() - 50);
		     sessionStorage.setItem("imgheight", jQuery('.box-images').height() - 50);
		     sessionStorage.setItem("boxwidth", jQuery('.box-images').width());
		     sessionStorage.setItem("boxheight", jQuery('.box-images').height());
		}
		
		Highcharts.chart('container', {
		    data: {
		        table: 'datatable'
		    },
		    chart: {
		        type: 'column'
		    },
		    title: {
		        text: 'Data extracted from a HTML table in the page'
		    },
		    yAxis: {
		        allowDecimals: false,
		        title: {
		            text: 'Units'
		        }
		    },
		    tooltip: {
		        formatter: function () {
		            return '<b>' + this.series.name + '</b><br/>' +
		                this.point.y + ' ' + this.point.name.toLowerCase();
		        }
		    }
		});
		
		function getUrlParameter(name) {
		    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
		    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
		    var results = regex.exec(location.search);
		    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
		};
		
	</script>
	<style type="text/css">
	
.small-screen-resize{
			width:270px !important;
		}
	
	.img-square-results{
		    margin-left: 2px;
		    z-index:100;
		    opacity: 0.5;
	}
.img-square-results:hover {
   	opacity: 1;
   }
.img-square-results:active  {
   opacity: 1;
   cursor: default;
   }
   
	
	
</style>
	<style type="text/css">
	

.quick-buttons {
    position: relative;
    display: block;
    background: #06941F;
    padding: 20px 10px 20px 20px;
    margin-bottom: 10px;
    overflow: hidden;
    -webkit-border-radius: 5px;
    -webkit-background-clip: padding-box;
    -moz-border-radius: 5px;
    -moz-background-clip: padding;
    border-radius: 5px;
    background-clip: padding-box;
    -webkit-transition: all 300ms ease-in-out;
    -moz-transition: all 300ms ease-in-out;
    -o-transition: all 300ms ease-in-out;
    transition: all 300ms ease-in-out;
}

.quick-buttons .icon {
    color: rgba(0, 0, 0, 0.1);
    position: absolute;
    top: 1px;
    right: 5px;
    z-index: 1;
    opacity: .3;
}

.quick-buttons.tile-red {
  background: #f56954;
}
.quick-buttons.tile-red:hover {
  background: #f4543c;
}
.quick-buttons.tile-red .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-red .num,
.quick-buttons.tile-red h3,
.quick-buttons.tile-red p {
  color: #fff;
}
.quick-buttons.tile-green {
  background: #00a65a;
}
.quick-buttons.tile-green:hover {
  background: #008d4c;
}
.quick-buttons.tile-green .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-green .num,
.quick-buttons.tile-green h3,
.quick-buttons.tile-green p {
  color: #fff;
}
.quick-buttons.tile-blue {
  background: #0073b7;
}
.quick-buttons.tile-blue:hover {
  background: #00639e;
}
.quick-buttons.tile-blue .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-blue .num,
.quick-buttons.tile-blue h3,
.quick-buttons.tile-blue p {
  color: #fff;
}
.quick-buttons.tile-aqua {
  background: #00c0ef;
}
.quick-buttons.tile-aqua:hover {
  background: #00acd6;
}
.quick-buttons.tile-aqua .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-aqua .num,
.quick-buttons.tile-aqua h3,
.quick-buttons.tile-aqua p {
  color: #fff;
}
.quick-buttons.tile-cyan {
  background: #00b29e;
}
.quick-buttons.tile-cyan:hover {
  background: #009987;
}
.quick-buttons.tile-cyan .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-cyan .num,
.quick-buttons.tile-cyan h3,
.quick-buttons.tile-cyan p {
  color: #fff;
}
.quick-buttons.tile-purple {
  background: #ba79cb;
}
.quick-buttons.tile-purple:hover {
  background: #b167c4;
}
.quick-buttons.tile-purple .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-purple .num,
.quick-buttons.tile-purple h3,
.quick-buttons.tile-purple p {
  color: #fff;
}
.quick-buttons.tile-pink {
  background: #ec3b83;
}
.quick-buttons.tile-pink:hover {
  background: #ea2474;
}
.quick-buttons.tile-pink .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-pink .num,
.quick-buttons.tile-pink h3,
.quick-buttons.tile-pink p {
  color: #fff;
}
.quick-buttons.tile-orange {
  background: #ffa812;
}
.quick-buttons.tile-orange:hover {
  background: #f89d00;
}
.quick-buttons.tile-orange .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-orange .num,
.quick-buttons.tile-orange h3,
.quick-buttons.tile-orange p {
  color: #fff;
}
.quick-buttons.tile-brown {
  background: #6c541e;
}
.quick-buttons.tile-brown:hover {
  background: #584418;
}
.quick-buttons.tile-brown .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-brown .num,
.quick-buttons.tile-brown h3,
.quick-buttons.tile-brown p {
  color: #fff;
}
.quick-buttons.tile-plum {
  background: #701c1c;
}
.quick-buttons.tile-plum:hover {
  background: #5c1717;
}
.quick-buttons.tile-plum .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-plum .num,
.quick-buttons.tile-plum h3,
.quick-buttons.tile-plum p {
  color: #fff;
}
.quick-buttons.tile-gray {
  background: #f5f5f5;
}
.quick-buttons.tile-gray:hover {
  background: #e8e8e8;
}
.quick-buttons.tile-gray .icon {
  color: rgba(0, 0, 0, 0.1);
}
.quick-buttons.tile-gray .num,
.quick-buttons.tile-gray h3,
.quick-buttons.tile-gray p {
  color: #8f8f8f;
}
.quick-buttons:hover {
  background-color: #252a32;
}
.quick-buttons .icon {
  text-align: center;
  padding: 20px;
}
.quick-buttons .icon i {
  font-size: 80px;
  line-height: 1;
  margin: 0;
  padding: 0;
  vertical-align: middle;
}
.quick-buttons .icon i:before {
  margin: 0;
  padding: 0;
  line-height: 1;
}
.quick-buttons .icon i,
.quick-buttons h3,
.quick-buttons p {
  color: #fff;
}
.quick-buttons .title {
  background: #252a32;
  text-align: center;
}
.quick-buttons .title h3,
.quick-buttons .title p {
  margin: 0;
  padding: 0 20px;
}
.quick-buttons .title h3 {
  padding-top: 20px;
  font-size: 16px;
  font-weight: bold;
}
.quick-buttons .title p {
  padding-bottom: 20px;
  font-size: 11px;
  color: rgba(255, 255, 255, 0.85);
}



h2 { 
   position: absolute; 
   top: 10px; 
   left: 0; 
   width: 100%; 
}

h2 span { 
   color: white; 
   font: bold 21px/50px Helvetica, Sans-Serif; 
   letter-spacing: -1px;  
   background: rgb(0, 0, 0); /* fallback color */
   background: rgba(0, 0, 0, 0.7);
   padding: 10px; 
   text-shadow: 1px 1px AAF6EF;
}

.bottomMargin {
margin-bottom:10px !important;
}

.imgContainerDiv {
    height: 300px;
    width: 300px;
    background-size: 100px 100px;
    background-color:#333333;
    overflow: hidden;
    margin: 30px;
  
    background-repeat:repeat;
    z
}


.imgQuickLinks {
    max-width: 100%;
    max-height: 100%;
}
	</style>
	
</head>

<body>


<div class="col-md-12">
	<div id="block" class="">
		<div >
		    <div class="col-md-12 col-sm-12">
		    </div>
		    <div style="padding-left:0px;" class="col-md-6">
			</div>
		    <div class="col-md-12 col-sm-12">
		    	<div align="right">
					<c:if test="${configure == true }">
						<button title="<fmt:message key="quickLink.heading"/>"  type="button" class="g-btn g-btn--primary" onclick="location.href='homeEdit.htm'">
							<i class="fa fa-edit" style="color: white"></i>
							<fmt:message key="edit"/>
						</button>
					</c:if>
		  		</div>
		 	</div>
		</div>
		<input type="text" id="refreshCheck" value="no" style="display: none;">
	</div>
</div>

<div id="block" class="block" style="box-shadow: 0px 0px 0px "> 
	
<div class="header">
<h3><fmt:message key="general.QuickLinks"/></h3>
</div>

<div class="stats_bar">                
    <div class="row">
		<c:forEach items="${links}" var="link" varStatus="status">
			<a href="<c:url value="${link.url}" />" >
				<div title="${link.hint}" class="col-sm-2 col-xs-4 small-screen-resize"> 
					<div class="quick-buttons tile-${link.bgcolour}" > 
					<div class="icon"><i class="fa fa-${link.symbol}"></i></div>  
					<h3><c:out value="${link.label}" /></h3><p>&nbsp;</p></div> 
				</div> 
			</a>
			<div class="clear visible-xs"></div> 
		</c:forEach>
	</div>
	<div class="clear visible-xs"></div> 
	<br/>
	<div id="block" class="block" style="box-shadow: 0px 0px 0px "> 
	
<div class="header bottomMargin" style="display:block">
<h3 style="float:left"><fmt:message key="general.QuickViews"/></h3><div style="width:100%; text-align:center;margin-left:-6%" class="imgs-square"><a href="#" id="bt-2-result" class="img-square-results"  onclick="changeImgDimmension('2', this)"><span ><img src="../images/2-results.png"></span></a><a href="#" onclick="changeImgDimmension('3', this)" class="img-square-results"><img src="../images/3-results.png"></a><a href="#" onclick="changeImgDimmension('4', this)" class="img-square-results"><img src="../images/4-results.png"></a></div>
</div>
	
	<div class="row div-container" style="text-align: center;">
		<c:forEach items="${myImageLinks}" var="ilink" varStatus="status">
				<div class="col-sm-6 col-xs-4 box-images imgContainerDiv">  
					
					<a href="<c:url value="${ilink.url}?quickLinkId=${ilink.id}" />" >
						
      						 <img src="data:image/jpg;base64,${ilink.displayImage}" class="imgQuickLinks" alt="${ilink.hint}" title="${ilink.hint}" style='height: 100%; width: 100%; object-fit: contain'/> 
      						<h2 style="align:center"><span><c:out value="${ilink.label}" /></span></h2> <p>&nbsp;</p>
					
					</a>
				</div> 
			<div class="clear visible-xs"></div> 
		</c:forEach>
	</div>
</div>  
</div>
</body>
</html>