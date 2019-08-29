<%@ page language="java" %>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html class="no-js g-html k-webkit k-webkit72" lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">
	<meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />     
    <meta http-equiv="Expires" content="-1"> 
    <meta http-equiv="cache-control" content="no-store">
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="copyright" content="&copy; 2005 ScannellSolutions">
    <meta http-equiv="robots" content="noindex, nofollow, noarchive">
	
	<link rel="apple-touch-icon" sizes="152x152" href="<c:url value="/login/imagesj/apple-touch-icon.png" />">
	<link rel="icon" type="image/png" sizes="32x32" href="<c:url value="/login/imagesj/favicon-32x32.png" />">
	<link rel="icon" type="image/png" sizes="16x16" href="<c:url value="/login/imagesj/favicon-16x16.png" />">
	<link rel="mask-icon" href="<c:url value="/login/imagesj/safari-pinned-tab.svg" />" color="#5bbad5">
	<link rel="shortcut icon" href="<c:url value="/login/imagesj/favicon.ico" />">
	<meta name="theme-color" content="#ffffff">

	<title><spring:message code="applicationName"/></title>

	<!-- Bootstrap core CSS -->	
    <link rel="stylesheet" href="<c:url value="/login/jsj/bootstrap/dist/css/bootstrap.css" />">
    <link rel="stylesheet" href="<c:url value="/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css" />">
	<!-- Custom styles for this template -->		
	<link rel="stylesheet" type="text/css" href="<c:url value="/login/cssj/style.css?a=a" />">
	<link class="theme-css" rel="stylesheet" href="<c:url value="/groove/css/groove-qpulse.min.css" />" />
	
	<style type="text/css">
	.modal-dialog {
	  width: 950px;/* your width */
	}
	.hidden{display:none;}
	
	/* If reCAPTCHA is enabled, it will hide the input fields in Edge unless their z-index is 0 */
	#username, #password, #email {
		z-index: auto;
	}
	</style>
   
   
	<script type="text/javascript" src="<c:url value="/login/jsj/jquery.js" />"></script>
	<script type="text/javascript" src="<c:url value="/login/jsj/behaviour/general.js" />"></script>


	<!-- Bootstrap core JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script type="text/javascript" src="<c:url value="/login/jsj/behaviour/voice-commands.js" />"></script>
	<script type="text/javascript" src="<c:url value="/login/jsj/bootstrap/dist/js/bootstrap.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/login/jsj/jquery.flot/jquery.flot.js" />"></script>
	<script type="text/javascript" src="<c:url value="/login/jsj/jquery.flot/jquery.flot.pie.js" />"></script>
	<script src="<c:url value="/login/jsj/jquery.parsley/dist/parsley.min.js" />" type="text/javascript"></script>
	<script src="<c:url value="/login/jsj/jquery.parsley/src/extra/dateiso.js" />" type="text/javascript"></script>
	<script type="text/javascript" src="<c:url value="/login/jsj/jquery.select2/select2.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/login/jsj/jquery.niftymodals/js/jquery.modalEffects.js" />"></script>
  
	<script type="text/javascript">
   
    jQuery(document).ready(function(){ 
    	if(jQuery('#errorMessage').text()){    		
    		jQuery("#errorMessageAlert").removeClass("hidden");
    	}
    	if(jQuery('#infoMessage').text()){    		
    		jQuery("#infoMessageAlert").removeClass("hidden");
    	}
		//jQuery('#form').parsley();
		jQuery('#password').val('');
   		if(isIE(8)){ 
  			alert("IE version 8 is not supported, Please use higher version of IE or Google Chrome");
  			document.getElementById("loginSubmit").disabled = true;

  		}
   		if(isIE(7)){ 
  			alert("IE version 7 is not supported, Please use higher version of IE or Google Chrome");
  			document.getElementById("loginSubmit").disabled = true;

  		}
    });
    
	function isIE( version, comparison ){
	    var $div = $('<div style="display:none;"/>').appendTo($('body'));
	    $div.html('<!--[if '+(comparison||'')+' IE '+(version||'')+']><a>&nbsp;</a><![endif]-->');
	    var ieTest = $div.find('a').length;
	    $div.remove();
	    return ieTest;
	}
    
	</script>
	
	<!--
	Centering in IE11 using this technique:   
	https://css-tricks.com/centering-the-newest-coolest-way-vs-the-oldest-coolest-way/ 
	-->
	<style>
	/* Disabling Groove's vertical centering of login container which does not work well in IE11 */
	.g-body.g-layout-login .g-layout-content .g-layout-login__container {
		top: auto;
		transform: none;
		position: static;
	}
	
	/* Re-implement vertical centering styling which works in IE11 and other suppported browsers */
	html, body {
	  margin: 0;
	  height: 100%;
	}
	.g-layout-content {
	  display: table;
	  width: 100%;
	  height: 100%;
	}
	.g-layout-content > .g-layout-login__container {
	  display: table-cell;
	  vertical-align: middle;
	}
	</style>
	
 	<%-- To avoid the jsessionid being appended to URLs initially, we build URLs on this page using contextURL --%>
	<c:set var="contextURL" value="${pageContext.servletContext.contextPath}" />
  
</head>

<body class="g-body g-body--primary g-layout-login">
	<div class="g-layout-content">
		<div class="g-layout-login__container">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12">
						<div class="g-layout-login__wrapper">
						
							<!-- Info / Error messages -->
							<div class="row">
								<div class="alert alert-info hidden" id="infoMessageAlert">
									<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
									<i class="fa fa-info-circle sign"></i>
									<strong><spring:message code="info.exclamation"/></strong>
									<span id="infoMessage"><c:if test="${not empty infoMessage}"><spring:message code="${infoMessage}"/></c:if></span>
								</div>
								<div class="alert alert-danger hidden" id="errorMessageAlert">
									<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
									<i class="fa fa-times-circle sign"></i>
									<strong><spring:message code="error.exclamation"/></strong>
									<span id="errorMessage"><c:if test="${not empty errorMessage}"><spring:message code="${errorMessage}"/></c:if></span>
								</div>
							</div>
								
							<div class="row">
								<div class="col-md-12">
                                    <div class="g-container">
                                        <div class="g-container__inner">
											<!-- Logo -->
											<div class="row">
												<div class="col-md-12 q-pulse-login-logo">
													<img src="<c:url value="/login/imagesj/logotype.png" />" />
												</div>
											</div>
                                
											<!-- Body -->        	
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="g-container__module">
														<sitemesh:write property='body'/>
													</div>
												</div>
											</div>
											
											<!-- Copyright -->
											<div class="row">
												<div class="col-md-12">
													<span style="color: rgb(34, 35, 50);">&copy; <%=java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%> Ideagen PLC.</span>
													
													<c:if test = "${fn:endsWith(pageContext.request.requestURL, 'login.html')}">
														<a class="g-btn g-btn--link" href="#" data-toggle="modal" data-target="#terms-and-conditions-modal"><spring:message code="termsAndConditions"/></a>
														<a class="g-btn g-btn--link" href="<c:out value="${contextURL}/beginSetup.html" />"><spring:message code="setupAccount"/></a>														
													</c:if>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Terms & Conditions Modal -->
	<div class="modal fade" id="terms-and-conditions-modal" tabindex="-1" role="document" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<style>
					.modal-header, .modal-body {
						padding: 50px;
					}
					.modal-body {
						padding-top: 0px;
					}
					#dismiss-terms {
						margin-top: 20px;
						margin-right: 20px;
					}
				</style>
				<button title="Close (Esc)" type="button" data-dismiss="modal" class="mfp-close" id="dismiss-terms"> <span style="color: #000;" class="mfp-close g-input__icon g-icon g-icon-cross"></span></button>
				<div class="modal-header">
					<div class="row">
						<div class="col-md-12 q-pulse-login-logo-terms">
							<img src="<c:url value="/login/imagesj/logotype.png" />">
						</div>
					</div>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<%@include file="../enviro/termsAndConditionsText.jspf"%>
						 </div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="g-btn g-btn--primary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>