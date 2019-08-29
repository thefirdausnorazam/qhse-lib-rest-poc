<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions' %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law"%>

<!DOCTYPE html>

<%@page import="com.scannellsolutions.enviromanager.util.DocLinkManager"%>
<%@page import="com.scannellsolutions.modules.law.domain.Checklist"%>
<%@page import="com.scannellsolutions.modules.law.domain.LegacyProfile"%><html>


<head>
<jsp:include page="headInclude.jsp" />

<script>
jQuery(document).ready(function(){
    jQuery("#myTab li:eq(0) a").tab('show'); 
    //initializing the first language 
    var index = jQuery("#firstLangage").val();
    
    
    
    jQuery("#language"  + index).removeClass('hide');
    jQuery("#language"  + index).addClass('show');
    
    jQuery("#ul" + index).addClass('show');
    //changeLetter(index + '' + index);
    jQuery("#block00").removeClass('hide');
    jQuery("#block00").addClass('show');
    jQuery("#letter00").addClass('active');
});

function changeLetter(index) {
	//put all letters in inactive state
	jQuery('li.active').each(function() {
		jQuery("#" + this.id).removeClass('active');
	});
	//hide all block element with the links to Relevancies for Keyword
	jQuery('div.block').each(function() {
		jQuery("#" + this.id).removeClass('show');
		jQuery("#" + this.id).addClass('hide');
	});
	jQuery("#letter" + index).addClass('active');
	jQuery("#block" + index).addClass('show');
// 	jQuery("#content").append(jQuery("block"+index));
}
function changeLanguage(index) {
	//hide all language blocks
	jQuery('div.language').each(function() {
		jQuery("#" + this.id).removeClass('show');
		jQuery("#" + this.id).addClass('hide');
	});
	jQuery("#language" + index).addClass('show');
	//hide every letter menu
	jQuery('ul.pagination-lg').each(function() {
		jQuery("#" + this.id).removeClass('show');
		jQuery("#" + this.id).addClass('hide');
	});
	jQuery("#ul" + index).addClass('show');
	//show the letter selected in the before letter menu
	jQuery("#ul" + index).children().each(function() {
		if(jQuery("#" + this.id).text() == jQuery('li.active a.menuLetter').text()){
			changeLetter(this.id.substring(6))
		}
	});
}
</script>

<title></title>

<style type="text/css">
.title {
	color: #000000;
	font-size: 18px;
	font-weight: bold;
	text-align: center;
	margin-bottom: 25px;
}

.keywords-nav {
	margin: 20px;
	text-align: center;
	font-size: 12px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}

.keywords-nav a {
	padding: 3px;
}

.keywords-nav-selected {
	font-size: 32px;
}

.keywords-item {
	background-color: #EEEEEE;
	border-bottom: 1px solid #BDBDBD;
	border-top: 1px solid #BDBDBD;
	padding: 2px;
	margin: 2px;
	color: #666666;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #666666;
}
.hide {
	display: none;
}
.show {
	display: block;
}

.menuLetter {
	
}
.language{
}
.disabledLink {
  opacity: 0.5;
  pointer-events: none;
  cursor: default;
  color: grey;
}
</style>

</head>
<body>
<div class="block-flat">
	<div class="header">
		<h2><fmt:message key='indexOfKeywords'/></h2> 
	</div>
	
	<c:set var="keywordsByLetter" value="" />
	<c:forEach items="${languageLetters}" var="item" varStatus="s">
		<c:set var="keywordsByLetter" value="${item.value}" />
		<c:set var="language" value="${item.key}" />
		<c:if test="${s.index == 0 }"><input type="hidden" id="firstLangage" value="${language.id}"/></c:if>
		<ul class="pagination pagination-lg hide" id="ul${language.id}">
			<li class="disabledMenuLetter"><a href="#" class="disabledLink"><i class="fa fa-backward"></i></a></li>
			<c:forEach items="${keywordsByLetter}" var="item" varStatus="i">
					<c:set var="letter" value="${item.key}" />
					<c:set var="keywords" value="${item.value}" />
					<li id="letter${s.index }${i.index}" value="${item.key}"><a href="#" class="menuLetter" onclick="changeLetter('${s.index}${i.index}')">${item.key}</a></li>
			</c:forEach>
			<li><a href="#" class="disabledLink"><i class="fa fa-forward"></i></a></li>
		</ul>
	</c:forEach>
<div style="clear: both;"></div>
	
	
	<div class="content">
	<div class="tab-container">
	
		<c:if test="${fn:length(languageLetters) ge 1}" >
		<ul class="nav nav-tabs" id="myTab">
			<c:forEach items="${languageLetters}" var="item">
				<c:set var="language" value="${item.key}" />
					<li>
						<a href="#language${language.id}" onclick="changeLanguage(${language.id})" data-toggle="tab">${language.nativeName}</a>
					</li>
								
			</c:forEach>
		</ul>
		</c:if>
		<div class="tab-content">
			<div class="tab-pane active" id="language-0">
				<div class="content" id="content">
					<c:forEach items="${languageLetters}" var="item" varStatus="s"> 
						<c:set var="language" value="${item.key}" />
						<c:set var="keywordsByLetter" value="${item.value}" />
							<div id="language${language.id}" class="hide language">
							<c:forEach items="${keywordsByLetter}" var="item" varStatus="i">
								<c:set var="letter" value="${item.key}" />
								<c:set var="keywords" value="${item.value}" />
								<div class="block hide" id="block${s.index}${i.index}" >
										<ul class="items">
											<c:forEach items="${keywords}" var="keyword">
												<li>
												<a href="<law:keywordUrl keyword="${keyword.left}" profile="${profile}" />">${keyword.right}</a>
												</li>
											</c:forEach>
										</ul>
								</div>
							</c:forEach>
							</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>




</body>
</html>
