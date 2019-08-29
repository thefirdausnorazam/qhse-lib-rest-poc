<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common"%>

<!DOCTYPE html>
<html class="g-html" lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta charset="ISO-8859-1">
	<meta http-equiv="cache-control" content="max-age=0" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="copyright" content="&copy; 2005 ScannellSolutions">
	<meta http-equiv="robots" content="noindex, nofollow, noarchive">
	<meta name="description" content="">
	<meta name="author" content="">

	<link rel="apple-touch-icon" sizes="152x152" href="<c:url value="/images/imagesj/apple-touch-icon.png" />">
	<link rel="icon" type="image/png" sizes="32x32" href="<c:url value="/images/imagesj/favicon-32x32.png" />">
	<link rel="icon" type="image/png" sizes="16x16" href="<c:url value="/images/imagesj/favicon-16x16.png" />">
	<link rel="mask-icon" href="<c:url value="/images/imagesj/safari-pinned-tab.svg" />" color="#5bbad5">
	<link rel="shortcut icon" href="<c:url value="/images/imagesj/favicon.ico" />">
	<meta name="theme-color" content="#ffffff">

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	<![endif]-->
	<%@include file="headNew.jspf"%>
	<%@include file="breadcrumbsNew.jspf"%>
	<%@include file="javascript.translations.jsp"%>

	<link class="theme-css" rel="stylesheet" href="<c:url value="/groove/css/groove-qpulse.min.css" />" />

	<style type="text/css">
		.disabled {
			color: grey;
		}

		.nopadding {
			padding: 0 !important;
			margin: 0 !important;
		}
		.page-head .col-sm-12 .col-sm-3.pull-right {
			z-index: 9999;
		}
		a.hoverable:hover {
			background-color:#627279 !important;

		}

		.bigToolTip{
			width: auto !important;
			height: auto !important;
		}
		textarea:-ms-input-placeholder{
			color:#999 !important;
		}

		.qtip-vimeo .qtip-content{
			padding: 0;
		}

		.grey-background {
			position: fixed;
			width: 100%;
			height: 100%;
			visibility: hidden;
			top: 0;
			left: 0;
			z-index: 1000;
			opacity: 0;
			background: rgba(0,0,0,0.8);
			transition: all 0.3s;
		}

	</style>


	<style type="text/css">
		/*  @media screen {
              div#bodyCentreDiv { overflow: scroll; overflow-x: auto; overflow-y: auto; }
              div#ssChromeMinimize { position: fixed; top: 12px; right: 12px; cursor: pointer;}
            } */
		@media print {
			div#headerDiv {
				display: none;
			}
			div#bodyLeftDiv {
				display: none;
			}
			div#bodyRightDiv {
				display: none;
			}
			div#footerDiv {
				display: none;
			}
			div#bodyCentreDiv {
				width: 95% !important;
				height: auto !important;
				overflow: visible !important;
				left: 0;
				top: 0; ! important;
				margin: 50px !important;
			}
			div#ssChromeMinimize {
				display: none;
			}
		}

		.bodyCentreDivExpanded {
			width: 100% !important;
			height: 100% !important;
		}

		.bodyCentreDivNormal {
			position: absolute;
			top: 100px;
			left: 249px;
			width: 640px;
			height: 480px;
		}

		.ui-tooltip, .qtip{

			max-width: 700px !important;
			min-width: 50px;

			font-size: 10.5px;
			line-height: 12px;
		}
	</style>
	<script type="text/javascript" src="<c:url value="/js/jquery.blockUI.js" />"></script>
	<script type='text/javascript' src="<c:url value="/js/gdpr.js" />"></script>

	<script language="javascript" type="text/javascript">
		jQuery(document).ready(function(){
			var module = "${module}";
			if(module == "risk" || module == "incident") {
				inializeGDPR();
			}
			jQuery("#pageSize").val('${defaultPageSize}');
		});

		var onSiteChange;
		var tour;
		// The context path is needed in /js/site.js ccccc
		var contextPath = '<%=request.getContextPath()%>';
		onSiteChange = function() {
			<c:choose>
			<c:when test="${module == 'audit'}"   ><c:url var="landingPage" value="/audit/workspace.htm" /></c:when>
			<c:when test="${module == 'change'}"   ><c:url var="landingPage" value="/change/workspace.htm" /></c:when>
			<c:when test="${module == 'enviro'}"  ><c:url var="landingPage" value="/enviro/home.htm"     /></c:when>
			<c:when test="${module == 'health'}"  ><c:url var="landingPage" value="/health/home.htm"     /></c:when>
			<c:when test="${module == 'incident'}"><c:url var="landingPage" value="/incident/home.htm"   /></c:when>
			<c:when test="${module == 'risk'}"    ><c:url var="landingPage" value="/risk/workspaceQueryForm.htm"       /></c:when>
			<c:when test="${module == 'survey'}"  ><c:url var="landingPage" value="/survey/home.htm"     /></c:when>
			<c:when test="${module == 'law'}"> <c:url var="landingPage" value="/law/lawDashboard.htm"/></c:when>
			<c:when test="${module == 'docs'}"> <c:url var="landingPage" value="/doclink/linkSearchForm.htm"     /></c:when>
			<c:when test="${module == 'client'}"> <c:url var="landingPage" value="/client/clientQuestionList.htm"     /></c:when>
			<c:when test="${module == 'doccontrol'}"> <c:url var="landingPage" value="/doccontrol/workspace.htm"     /></c:when>
			</c:choose>
			var newSiteURI, selectedSite;
			newSiteURI = '<c:out value="${landingPage}" />';
			selectedSite = jQuery('#siteLocation').val();
			window.location = newSiteURI + '?switchToSite=' + selectedSite;
		};
	</script>

	<script type="text/javascript" src="<c:url  value="/js/frameDecoratorJS.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/jquery.blockUI.js" />"></script>
	<sitemesh:write property='head'/>
</head>
<body id="zoo" class="zoo g-body">
<input id="gdpr" type="hidden" value="${gdprText}"/>
<!-- Fixed navbar -->
<div id="head-nav" class="navbar navbar-default navbar-fixed-top" style="position: fixed">
	<div class="container-fluid">
		<div class="navbar-brand" style="height:auto;width:auto;">
			<img class="img-responsive" src="<c:url value="../images/imagesj/logotype.png" />" alt="SCANNELL" width="144">
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<c:if test="${user.isAdmin()==true}">
				<li class="dropdown" id="enviroDropdown">
					<a href="<c:url value="/enviro/home.htm"  />" class="dropdown-toggle" data-toggle="dropdown">Admin <b class="caret"></b></a>
					<ul class="dropdown-menu col-menu-2">
						<li class="col-sm-6 no-padding">
							<ul>
								<li class="dropdown-header"><i class="fa fa-legal"></i> <fmt:message key="menu.actions" /></li>
								<li><a href="<c:url value="/system/groupList.htm" />"><fmt:message key="enviro.groups"/></a></li>
								<li><a href="<c:url value="/system/reportingGroupList.htm" />"><fmt:message key="enviro.reportingGroups"/></a></li>
								<li><a href="<c:url value="/system/userQueryForm.htm" />"><fmt:message key="enviro.users"/></a></li>
								<!-- <li><a href="<c:url value="/system/transferUserRecordsList.htm" />">Transfer Records</a></li> -->
								<li><a href="<c:url value="/enviro/userAccessCreateReport.htm" />"><fmt:message key="userAccessCreateReport" /></a></li>
							</ul>
						</li>
						<li class="col-sm-6 no-padding">
							<ul>

								<li><a href="<c:url value="/system/moduleList.htm" />"><fmt:message key="enviro.modules"/></a></li>
								<li><a href="<c:url value="/system/userDomainList.htm" />"><fmt:message key="enviro.userDomains"/></a></li>
								<li><a href="<c:url value="/system/licenceList.htm" />"><fmt:message key="enviro.licences"/></a></li>
								<li><a href="<c:url value="/system/questionList.htm" />"><fmt:message key="enviro.questions"/></a></li>
								<li><a href="<c:url value="/system/changeLog.htm" />"><fmt:message key="enviro.changeLog"/></a></li>

							</ul>
						</li>
					</ul></li>
				</c:if>
				<c:if test="${not user.isInRole('IncidentRoles.INCIDENT_GUEST_LOGIN')}">
					<c:forEach items="${licences}" var="item">
						<c:choose>
							<c:when test="${item=='risk'}">
								<li class="dropdown" id="riskDropdown">
									<a href="<c:url value="/risk/home.htm" />" class="dropdown-toggle" data-toggle="dropdown"><fmt:message key="riskMenu" /> <b class="caret"></b></a>
									<ul class="dropdown-menu col-menu-2">
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-eye"></i><fmt:message key="menu.views" /></li>
												<li data-toggle="WorkSpace"><a href="<c:url value="/risk/workspaceQueryForm.htm" />"><fmt:message key="myWorkspace" /></a></li>
												<li data-toggle="Scoreboard"><a href="<c:url value="/risk/assessmentQueryForm.htm" />"><fmt:message key="scoreboard" /></a></li>
												<li><a href="<c:url value="/risk/objectiveQueryForm.htm" />"><fmt:message key="objectiveQueryResult.title" /></a></li>
												<li><a href="<c:url value="/risk/targetQueryForm.htm" />"><fmt:message key="menu.targets" /></a></li>
												<li><a href="<c:url value="/risk/managementProgrammeQueryForm.htm" />"><fmt:message key="managementProgrammes" /></a></li>
												<li><a href="<c:url value="/risk/taskQueryForm.htm" />"><fmt:message key="raAndMpTasks" /></a></li>
												<li><a href="<c:url value="/risk/overdueQueryForm.htm" />"><fmt:message key="overdueItems" /></a></li>
												<li><a href="<c:url value="/risk/reportList.htm?tag=risk" />"><fmt:message key="reports" /></a></li>
											</ul>
										</li>
										<li class="col-sm-6 no-padding">
											<c>
												<li class="dropdown-header"><i class="fa fa-legal"></i><fmt:message key="menu.actions" /></li>
												<c:if test="${user.isInRole('RiskUserRoles.ASSESSMENT_CREATION')}">
												<li><a href="<c:url value="/risk/assessmentTemplateList.htm" />"> <fmt:message key="addRiskAssessment" /></a></li>
												</c:if>
												<c:if test="${user.isInRole('RiskUserRoles.MANAGEMENT_ACCESS')}">
												<li><a href="<c:url value="/risk/objectiveEdit.htm" />"><fmt:message key="managementProgramme.createObjective" /></a></li>
												</c:if>
												<c:if test="${user.isInRole('RiskUserRoles.MANAGEMENT_PROGRAMME_ACCESS')||role.isInRole('RiskUserRoles.MANAGEMENT_ACCESS')}">
												<li><a href="<c:url value="/risk/managementProgrammeEdit.htm" />"><fmt:message key="addMProgramme" /></a></li>
												</c:if>
												<c:if test="${user.isInRole('RiskUserRoles.MANAGEMENT_ACCESS')}">
												<li><a href="<c:url value="/risk/templateQueryForm.htm" />"><fmt:message key="riskTemplates" /></a></li>
												</c:if>
											</ul>
										</li>
									</ul></li>
							</c:when>
							<c:when test="${item=='law'}">
								<fmt:message key="menuOptions" var="menuOpt" />
								<li class="dropdown" id="lawDropdown"><a
										href="<c:url value="/law/home.htm" />" tabindex="3"
										class="dropdown-toggle" title="${menuOpt}" data-toggle="dropdown"><fmt:message
										key="lawMenu" /> <b class="caret"></b></a>
									<ul class="dropdown-menu col-menu-2">
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-home"></i> <fmt:message key="homeMenu" /></li>
												<li><a href="<c:url value="/law/lawDashboard.htm" />"> <fmt:message key="enviro.dashboard" /></a></li>
												<li class="dropdown-header"><i class="fa fa-eye"></i> <fmt:message key="menu.views" /></li>
												<li><a id="lawLink1"> <fmt:message key="indexOfLegislation" /></a></li>
												<li><a id="lawLink2"> <fmt:message key="complianceChecklists" /></a></li>
												<li><a id="lawLink3"> <fmt:message key="indexOfKeywords" /></a></li>
												<li><a id="lawLink4"> <fmt:message key="changeRecord" /></a></li>
												<li><a id="lawLink6"> <fmt:message key="lawTasks" /></a></li>
											</ul>
										</li>
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-legal"></i><fmt:message key="menu.actions" /></li>
												<c:if test="${user.isInRole('com.scannellsolutions.modules.law.domain.Profile.ROLE_CREATE') || user.isInRole('com.scannellsolutions.modules.law.domain.Profile.ROLE_SHARE')}">
													<li><a href="javascript:openProfileManager()" onclick="endTour();"><fmt:message key="law.profileManager" /></a></li>

													<c:if test="${module == 'law'}"   >
														<li><a href="javascript:openDocLinkPageFromLaw(jQuery('#profileSelect').val())"> <fmt:message key="manageOtherRequirements" /></a></li>
													</c:if>
												</c:if>
												<li><a href="<c:url value="/law/contentSearchForm.htm?legRegister=${lawRegisterId}" />"> <fmt:message key="search" /></a></li>
											</ul>
										</li>
									</ul>
								</li>
							</c:when>
							<c:when test="${item == 'audit'}">
								<li class="dropdown" id="auditDropdown"><a href="#" class="dropdown-toggle"  data-toggle="dropdown">
									<fmt:message key="auditMenu" /> <b class="caret"></b></a>
									<ul class="dropdown-menu col-menu-2">
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-eye"></i> <fmt:message key="menu.views" /></li>
												<li><a href="<c:url value="/audit/workspace.htm" />"><fmt:message key="workspaceView" /></a></li>
												<li><a href="<c:url value="/audit/planQueryForm.htm" />"><fmt:message key="auditPlans" /></a></li>
												<li><a href="<c:url value="/audit/programmeQueryForm.htm" />"><fmt:message key="programmes.title" /></a></li>
												<li><a href="<c:url value="/audit/auditQueryForm.htm" />"><fmt:message key="audits.title" /></a></li>
												<li><a href="<c:url value="/audit/auditRecurringQueryForm.htm" />"><fmt:message key="auditRecurrings.title" /></a></li>
												<li><a href="<c:url value="/audit/reportList.htm?tag=audit" />"> <fmt:message key="reports" /></a></li>
											</ul>
										</li>
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-legal"></i> <fmt:message key="menu.actions" /></li>
												<li><a href="<c:url value="/audit/programmeTypeList.htm" />"><fmt:message key="programmeTypeList" /></a></li>
												<li><a href="<c:url value="/audit/templateQueryForm.htm" />"><fmt:message key="templates.title" /></a></li>
												<li><a href="<c:url value="/audit/thirdPartyQueryForm.htm" />"><fmt:message key="thirdPartyList" /></a></li>
												<li><a href="<c:url value="/audit/auditTypeQueryForm.htm" />"><fmt:message key="inspectionProgrammeTypeList" /></a></li>
											</ul>
										</li>
									</ul></li>
							</c:when>
							<c:when test="${item=='health'}">
								<li class="dropdown"><a href="#" class="dropdown-toggle"  data-toggle="dropdown">
									<fmt:message key="health" /> <b class="caret"></b></a>
									<ul class="dropdown-menu col-menu-2">
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-eye"></i><fmt:message key="menu.views" /></li>
												<li><a href="<c:url value="/health/recordQueryForm.htm" />"><fmt:message key="healthRecordQueryForm" /></a></li>
												<li><a href="<c:url value="/health/testQueryForm.htm" />"><fmt:message key="healthTestQueryForm" /></a></li>
												<c:if test="${user.isInRole('HealthUserRoles.VIEW_REPORTS')}">
													<li><a href="<c:url value="/health/reportList.htm?tag=health" />"><fmt:message key="reports" /></a></li>
												</c:if>
											</ul>
										</li>
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-legal"></i><fmt:message key="menu.actions" /></li>
												<c:if test="${user.isInRole('HealthUserRoles.RECORD_CREATE')}">
													<li><a href="<c:url value="/health/recordAdd.htm" />"><fmt:message key="healthRecordAdd" /></a></li>
												</c:if>

											</ul>
										</li>
									</ul></li>
							</c:when>
							<c:when test="${item == 'data'}">
								<li class="dropdown" id="dataDropdown"><a href="<c:url value="/survey/home.htm" />" tabindex="5"
																		  class="dropdown-toggle"  data-toggle="dropdown"><fmt:message key="data" /><b class="caret"></b></a>
									<ul class="dropdown-menu col-menu-2">
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-eye"></i> <fmt:message key="menu.views" /></li>
												<li><a href="<c:url value="/survey/home.htm" />"><fmt:message key="myWorkspace" /></a></li>
												<li class="dropdown-header"><a href="<c:url value="/survey/home.htm" />"><i class="fa fa-book"></i><fmt:message key="data" /></a></li>
												<li><a href="<c:url value="/survey/dataEntryQueryForm.htm" />"><fmt:message key="surveyDataEntry" /></a></li>
												<li>
													<a href="<c:url value="/survey/monitoringProgrammeViewCategories.htm" />"><fmt:message key="survey.monitoringProgrammeViewCategories.title" /></a>
												</li>
												<li>
													<a href="<c:url value="/survey/measurementQueryForm.htm" />"><fmt:message key="measurementQueryForm" /></a>
												</li>
												<li><a href="<c:url value="/survey/readingQueryForm.htm" />"><fmt:message
														key="survey.readingQueryForm.menuItem" /></a></li>
												<li><a href="<c:url value="/survey/limitPeriodQueryForm.htm" />"><fmt:message
														key="limitPeriodQueryForm" /></a></li>
												<li><a href="<c:url value="/maintenance/ppeQueryForm.htm" />"><fmt:message key="ppeQueryForm" /></a></li>
												<li>
													<a href="<c:url value="/maintenance/trainingQueryForm.htm" />"><fmt:message key="trainingQueryForm" /></a>
												</li>
												<li>
													<a href="<c:url value="/maintenance/equipmentQueryForm.htm" />"><fmt:message key="equipmentQueryForm" /></a>
												</li>
												<c:if test="${user.isInRole('SurveyRoles.VIEW_REPORTS')}">
													<li><a href="<c:url value="/survey/reportList.htm" />"><fmt:message key="reports" /></a></li>
												</c:if>
												<li class="dropdown-header"><a href="<c:url value="/survey/home.htm" />"><i class="fa fa-archive"></i><fmt:message key="waste" /></a></li>
												<li><a href="<c:url value="/waste/wasteConsignmentQueryForm.htm" />"><fmt:message
														key="wasteConsignmentQueryForm" /></a></li>
												<li><a href="<c:url value="/waste/wasteConsignmentItemQueryForm.htm" />"><fmt:message
														key="wasteConsignmentItemQueryForm" /></a></li>
												<li><a href="<c:url value="/waste/carrierList.htm" />"><fmt:message key="carrierList" /></a></li>
												<li><a href="<c:url value="/waste/consigneeList.htm" />"><fmt:message key="consigneeList" /></a></li>
											</ul>
										</li>
										<li class="col-sm-6 no-padding">
											<ul>

												<li><a href="<c:url value="/waste/brokerList.htm" />"><fmt:message key="brokerList" /></a></li>
												<li><a href="<c:url value="/waste/wasteTypeList.htm" />"><fmt:message key="wasteTypeList" /></a></li>
												<li><a href="<c:url value="/waste/wasteTypeCategoryList.htm" />"><fmt:message key="wasteTypeCategoryList" /></a></li>
											</ul>
										</li>
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-legal"></i> <fmt:message key="menu.actions" /></li>
												<li class="dropdown-header"><a href="<c:url value="/survey/home.htm" />"><i class="fa fa-book"></i><fmt:message key="data" /></a></li>
												<li><a href="<c:url value="/survey/quantityCategoryList.htm" />"><fmt:message key="quantityCategoryList" /></a></li>
												<li><a href="<c:url value="/survey/readingPointList.htm" />"><fmt:message key="readingPointList" /></a></li>
												<li><a href="<c:url value="/survey/measurementList.htm" />"><fmt:message key="measurementList" /></a></li>
												<li><a href="<c:url value="/maintenance/categoryList.htm" />"><fmt:message key="maintenanceCategoryList" /></a></li>
												<li><a href="<c:url value="/maintenance/thirdPartyQueryForm.htm" />"><fmt:message key="traineeThirdParty" /></a></li>
												<li class="dropdown-header"><a href="<c:url value="/survey/home.htm" />"><i class="fa fa-archive"></i><fmt:message key="waste" /></a></li>
												<c:if test="${user.isInRole('WasteRoles.DATA_ENTRY')}">
													<li><a href="<c:url value="/waste/wasteConsignmentEdit.htm" />"><fmt:message key="wasteConsignmentCreate" /></a></li>
												</c:if>
												<c:if test="${user.isInRole('WasteRoles.CONFIGURE')}">
													<li><a href="<c:url value="/waste/brokerEdit.htm" />"><fmt:message key="brokerCreate" /></a></li>
													<li><a href="<c:url value="/waste/carrierEdit.htm" />"><fmt:message key="carrierCreate" /></a></li>
													<li><a href="<c:url value="/waste/consigneeEdit.htm" />"><fmt:message key="consigneeCreate" /></a></li>
													<li><a href="<c:url value="/waste/wasteTypeEdit.htm" />"><fmt:message key="wasteTypeCreate" /></a></li>
													<li><a href="<c:url value="/waste/wasteTypeCategoryEdit.htm" />"><fmt:message key="wasteTypeCategoryCreate" /></a></li>
												</c:if>
											</ul>
										</li>
									</ul></li>
							</c:when>
							<c:when test="${item == 'change'}">

								<li class="dropdown" id="changeDropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message
										key="change" /> <b class="caret"></b></a>
									<ul class="dropdown-menu col-menu-2">
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-eye"></i> <fmt:message key="menu.views" /></li>
												<li><a href="<c:url value="/change/workspace.htm" />"><fmt:message key="workspaceView" /></a></li>
												<li><a href="<c:url value="/change/planList.htm" />"><fmt:message key="changePlans" /></a></li>
												<li><a href="<c:url value="/change/programmeQueryForm.htm" />"><fmt:message key="changeProgrammes" /></a></li>
												<li><a href="<c:url value="/change/changeQueryForm.htm" />"><fmt:message key="changeAssessments" /></a></li>


											</ul>
										</li>
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-legal"></i> <fmt:message key="menu.actions" /></li>
												<li><a href="<c:url value="/change/programmeTypeList.htm" />"><fmt:message
														key="changeProgrammeType.list" /></a></li>
												<li><a href="<c:url value="/change/templateQueryForm.htm" />"><fmt:message key="changeTemplates.title" /></a></li>
											</ul>
										</li>
									</ul></li>
							</c:when>
							<c:when test="${item == 'incident'}">
								<li class="dropdown" id="incidentDropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message
										key="incidentMenu" /> <b class="caret"></b></a>
									<ul class="dropdown-menu col-menu-2">
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-eye"></i> <fmt:message key="menu.views" /></li>
												<li><a href="<c:url value="/incident/home.htm" />"><fmt:message key="incidentHome" /></a></li>
												<li><a href="<c:url value="/incident/searchIncidentsForm.htm" />"><fmt:message
														key="searchIncidents" /></a></li>
												<li><a href="<c:url value="/incident/searchActionsForm.htm" />"><fmt:message key="searchActions" /></a></li>
												<li><a href="<c:url value="/incident/searchTasksForm.htm" />"><fmt:message key="searchTasks" /></a></li>
												<li><a href="<c:url value="/incident/viewOverdueActions.htm" />"><fmt:message key="overdueActions" /></a></li>
												<c:if test="${user.isInRole('IncidentRoles.INCIDENT_VIEW_REPORTS')}">
													<li><a href="<c:url value="/incident/reportList.htm?tag=incident" />"><fmt:message key="reports" /></a></li>
												</c:if>
											</ul>
										</li>
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-legal"></i> <fmt:message key="menu.actions" /></li>
												<c:if test="${user.isInRole('IncidentRoles.EDIT_INCIDENT')}">
													<li><a href="<c:url value="/incident/editIncident.htm" />"><fmt:message key="createIncident" /></a></li>
												</c:if>
												<c:if test="${user.isInRole('ActionRoles.EDIT_ACTION')}">
													<li><a href="<c:url value="/incident/editIncidentTrend.htm?" />"><fmt:message key="incidentTrendMenu" /></a></li>
												</c:if>
												<c:if test="${user.isInRole('IncidentRoles.EDIT_REFRERENCE_DATA')}">
													<li><a href="<c:url value="/incident/viewIncidentTypes.htm" />"><fmt:message key="viewIncidentTypes" /></a></li>
													<li><a href="<c:url value="/incident/editExcelLayout.htm" />">Specify Excel Layout</a></li>
													<li><a href="<c:url value="/incident/viewReportees.htm" />"><fmt:message key="viewReportees" /></a></li>
													<li><a href="<c:url value="/incident/viewCauseTypes.htm" />"><fmt:message key="viewCauseTypes" /></a></li>
												</c:if>
											</ul>
										</li>
									</ul></li>
							</c:when>
							<c:when test="${item == 'doccontrol'}">
								<li class="dropdown" id="doccontrolDropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message
										key="docControlMenu" /> <b class="caret"></b></a>
									<ul class="dropdown-menu col-menu-2">
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-eye"></i> <fmt:message key="menu.views" /></li>
												<li data-toggle="WorkSpace"><a href="<c:url value="/doccontrol/workspace.htm" />"><fmt:message key="myWorkspace" /></a></li>
												<li data-toggle="WorkSpace"><a href="<c:url value="/doccontrol/distributedDocumentsForm.htm" />"><fmt:message key="docControl.myDocuments" /></a></li>
												<c:if test="${user.isInRole('DocControlRoles.CREATOR')}">
													<li><a href="<c:url value="/doccontrol/documentSearchForm.htm" />"><fmt:message key="docControl.documents" /></a></li>
													<li><a href="<c:url value="/doccontrol/docGroupSearchForm.htm" />"><fmt:message key="docControl.docGroups" /></a></li>
												</c:if>
												<c:if test="${user.isInRole('DocControlRoles.MAINTENANCE')}">
													<li><a href="<c:url value="/doccontrol/docTrainingRecordQueryForm.htm" ><c:param name="generalSearch" value="true"/></c:url>"><fmt:message key="docControl.ackRecords" /></a></li>
												</c:if>
											</ul>
										</li>
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-legal"></i> <fmt:message key="menu.actions" /></li>
												<c:if test="${user.isInRole('DocControlRoles.CREATOR')}">
													<li><a href="<c:url value="/doccontrol/documentEdit.htm" />"><fmt:message key="docControl.addDocument" /></a></li>
												</c:if>
												<c:if test="${user.isInRole('DocControlRoles.MAINTENANCE')}">
													<li><a href="<c:url value="/doccontrol/docGroupEdit.htm" />"><fmt:message key="doccontrol.addDocGroup" /></a></li>
												</c:if>
											</ul>
										</li>
									</ul></li>
							</c:when>
							<c:when test="${item=='docs'}">
								<li class="dropdown"><a href="#" class="dropdown-toggle" title="Documents/Links" data-toggle="dropdown"><fmt:message
										key="health" /> <b class="caret"></b></a>
									<ul class="dropdown-menu col-menu-2">
										<li class="col-sm-6 no-padding">
											<ul>
												<li class="dropdown-header"><i class="fa fa-eye"></i>Views</li>
											</ul>
										</li>
									</ul>
								</li>
							</c:when>
						</c:choose>
					</c:forEach>

					<c:if test="${site != null}">
						<li class="dropdown" id="doclinksDropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message key="docs" /> <b class="caret"></b></a>
							<ul class="dropdown-menu col-menu-2">
								<li class="col-sm-6 no-padding">
									<ul>
										<li class="dropdown-header"><i class="fa fa-home"></i><fmt:message key="viewDoclink" /></li>
										<li><a href="<c:url value="/doclink/linkSearchForm.htm" />" tabindex="10"><fmt:message key="searchForLinks"/></a></li>
									</ul>
								</li>
								<li class="col-sm-6 no-padding">
									<ul>
										<li class="dropdown-header"><i class="fa fa-legal"></i><fmt:message key="menu.actions" /></li>
										<c:if test="${user.isInRole('DoclinkRoles.EDIT_DOCLINK')}">
											<li><a href="<c:url value="/doclink/linkEdit.htm" />"><fmt:message key="addLink" /></a></li>
										</c:if>
										<c:if test="${user.isInRole('DoclinkRoles.EDIT_DOCLINK')}">
											<li><a href="<c:url value="/doclink/docAttachmentEdit.htm" />"><fmt:message key="uploadLink" /></a></li>
										</c:if>
									</ul>
								</li>
							</ul>
						</li>
					</c:if>
				</c:if>
			</ul>
			<ul class="nav navbar-nav navbar-right user-nav">
				<fmt:message key="loggedInUser" var="loggedIn"/>
				<li class="dropdown profile_menu"><a href="#" class="dropdown-toggle" title="${loggedIn}" data-toggle="dropdown"><img
						alt="Avatar" src="../images/imagesj/avatar2.jpg" /><span><c:out value="${uName}" /></span> <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<c:if test="${passwordEditable}">
							<li><a href="<c:url value="/system/userChangePassword.htm" />"><fmt:message key="changePassword" /></a></li>
						</c:if>>
						<li class="divider"></li>
						<li><a href="<c:url value="/logout"/>"><fmt:message key="signOut" /></a></li>
					</ul></li>
			</ul>
			<ul class="nav navbar-nav navbar-right user-nav">
				<fmt:message key="changeLanguage" var="changeLang"/>
				<li class="dropdown profile_menu international"><a href="#" class="dropdown-toggle" title="${changeLang}" data-toggle="dropdown"><i
						class="fa fa-globe"></i><span>&nbsp; <fmt:message key="languages" /> </span> <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#"><fmt:message key="currentLocale" />${pageContext.response.locale}</a></li>
						<li class="divider"></li>
						<li><a href="<c:out value="${landingPage}" />?language=en"><fmt:message key="english" /></a></li>
						<li><a href="<c:out value="${landingPage}" />?language=span"><fmt:message key="spanish" /> <span
								class="flag-icon flag-icon-es"></span></a></li>
						<li><a href="<c:out value="${landingPage}" />?language=fr"><fmt:message key="french" /> <span class="flag-icon flag-icon-fr"></span></a></li>
						<li><a href="<c:out value="${landingPage}" />?language=zh_CN"><fmt:message key="chinese" />  <span
								class="flag-icon flag-icon-cn"></span></a></li>
					</ul></li>
			</ul>
			<ul class="nav navbar-nav navbar-right not-nav">
				<li class="button"><a href="javascript:;" id="sidebar-collapse"><i class="fa fa-angle-left"></i></a></li>
				<c:if test="${user.isInRole('IncidentRoles.INCIDENT_ADVANCED_REPORTS')}">
					<li class="button" data-placement="bottom" data-toggle="tooltip" title="<fmt:message key='groupSites' />" data-original-title="Group Sites">
						<a href="<c:url value="/enviro/groupSites.htm" />"><i class="fa fa-sitemap"></i><span id="groupSiteBubble" class="bubble">1</span></a>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
</div>

<div id="cl-wrapper" class="fixed-menu">
	<c:if test="${not user.isInRole('IncidentRoles.INCIDENT_GUEST_LOGIN')}">
	<div class="cl-sidebar">
		<div class="cl-toggle">
			<i class="fa fa-bars"></i>
		</div>
		<div class="cl-navblock">
			<div class="g-palette--mastergrey menu-space">
				<div class="content">
					<ul class="cl-vnavigation">
						<li id="hoverTest" title-center="Dashboards" class="testHover"><a href="#" class="hoverable"><i class="fa fa-dashboard"></i><span><fmt:message key="enviro.dashboard" /></span></a>
							<ul class="sub-menu">
								<c:if test="${not role.isAdmin()}">
									<li><a href="<c:url value="/enviro/dashboard.htm" />"><fmt:message key="myGeneralDashbord" /></a></li>
									<li><a href="<c:url value="/enviro/dashboard2.htm" />"><fmt:message key="sampleGeneralDashboard" /></a></li>
									<li><a href="<c:url value="/enviro/dashboard2.htm?page=incident" />"><fmt:message key="sampleIncidentDashboard" /></a></li>
									<li><a href="<c:url value="/enviro/dashboard2.htm?page=audit" />"><fmt:message key="sampleAuditDashboard" /></a></li>
									<li><a href="<c:url value="/enviro/dashboard2.htm?page=law" />"><fmt:message key="sampleLawDashboard" /></a></li>
								</c:if>
								<c:if test="${user.isAdmin() || role.isInRole('SystemRoles.ADMINISTRATOR')}">
								<li><a href="<c:url value="/enviro/adminDashboard.htm" />"><fmt:message key="administratorDashboard" /></a></li>
								</c:if>
								<li><a href="<c:url value="/law/lawDashboard.htm" />"><fmt:message key="lawDashboard" /></a></li>
								<li><a href="<c:url value="/enviro/generalOpenSearch.htm?workspace=yes" />"><fmt:message key="quickLink.open.items" /></a></li>
								<li><a href="<c:url value="/enviro/savedSearchCriteria.htm" />"><fmt:message key="quickLink.savedCriteria" /></a></li>
							</ul></li>

						<li id="hoverTest" title-center="All Workspaces" class="testHover"><a href="<c:url value="/enviro/generalHome.htm" />" class="hoverable"><i class="fa fa-desktop"></i><span><fmt:message key="myWorkspace" /></span></a>
							<ul class="sub-menu">
								<li><a href="<c:url value="/enviro/generalHome.htm" />"><fmt:message key="applicationName" /> - <fmt:message key="general.QuickLinks" /></a></li>
								<li><a href="<c:url value="/risk/workspaceQueryForm.htm" />">Risk - <fmt:message key="workspaceView" /></a></li>
								<li><a href="<c:url value="/audit/workspace.htm" />">Audit - <fmt:message key="workspaceView" /></a></li>
								<li><a href="<c:url value="/survey/home.htm" />">Data - <fmt:message key="workspaceView" /></a></li>
								<li><a href="<c:url value="/incident/home.htm" />">Incident - <fmt:message key="workspaceView" /></a></li>
								<li><a href="<c:url value="/change/workspace.htm" />">Change - <fmt:message key="workspaceView" /></a></li>

							</ul>
						</li>

						<c:if test="${user.isInRole('IncidentRoles.EDIT_REFRERENCE_DATA')}">
						<li class="testHover" title-center="Questions"><a href="#" class="hoverable"><i
								class="glyphicon glyphicon-star"></i><span><fmt:message key="questionWorkspace" /></span></a>
							<ul class="sub-menu">
								<li><a href="<c:url value="/client/clientQuestionList.htm" />"><fmt:message key="userQuestionAdmin" />
								</a></li>
								<li><a href="<c:url value="/system/questionList.htm" />"><fmt:message key="enviroQuestionAdmin" />
								</a></li>

							</ul>
						</li>
						</c:if>
						<c:if test="${user.isAdmin() || role.isInRole('SystemRoles.ADMINISTRATOR')}">
						<li id="hoverTest" title-center="Admin Settings" class="testHover"><a href="#" class="hoverable"><i
								class="fa fa-cogs"></i><span><fmt:message key="admin.setting" /></span></a>
							<ul class="sub-menu">
								<li><a href="<c:url value="/system/systemConfigView.htm"></c:url>" ><fmt:message key="admin.setting" /></a></li>
								<li><a href="<c:url value="/system/sftpSyncLog.htm"></c:url>" ><fmt:message key="admin.sftpSyncLog" /></a></li>
								<li><a href="<c:url value="/system/samlSsoSettings.htm"></c:url>" ><fmt:message key="admin.samlSsolSettings" /></a></li>
							</ul>
						</li>
						</c:if>
						<li id="hoverTest" class="testHover helpClass"><a href="#" class="hoverable"><i
								class="fa fa-info-circle"></i><span><fmt:message key="menu.help" /></span></a>
							<ul class="sub-menu">
								<li>
									<a target="scannell_help" href="https://scannellsaas.com/q-pulse-help"><fmt:message key="menu.help" /></a>
								</li>
								<li>
									<a target="scannell_help" href="https://scannellsaas.com/q-pulse-contact"><fmt:message key="menu.contactInfo" /></a>
								</li>
								<li>
									<a href="<c:url value="/enviro/termsAndConditions.htm" />" ><fmt:message key="termsAndConditions"/></a>
								</li>
								<li>
									<a href="<c:url value="/enviro/endUserAgreement.htm" />" ><fmt:message key="endUserAgreement"/></a>
								</li>
								<li>
									<a href="<c:url value="/enviro/privacyPolicy.htm" />" ><fmt:message key="privacyPolicy"/></a>
								</li>
							</ul>
						</li>
						<li style="display:none" class="testHover quick-link-law"><a href="#" onclick="showQuickLegislation(1);" class="hoverable quickLegislation"><i class="fa fa-gavel"></i><span><fmt:message key="legislation" /></span></a></li>
						<li style="display:none"class="testHover quick-link-law"><a href="#" onclick="showQuickLegislation(2);"class="hoverable"><i class="fa fa-list-ol"></i><span><fmt:message key="checklists" /></span></a></li>
						<li id="keywordShort" style="display:none"class="testHover quick-link-law"><a href="#" onclick="showQuickLegislation(3);"class="hoverable"><i class="fa fa-sort-alpha-asc"></i><span><fmt:message key="keywords" /></span></a></li>
						<li style="display:none"class="testHover quick-link-law"><a href="#" onclick="showQuickLegislation(4);"class="hoverable"><i class="fa fa-exchange"></i><span><fmt:message key="changes" /></span></a></li>
						<li style="display:none"class="testHover quick-link-law"><a href="#" onclick="showQuickLegislation(5);"class="hoverable"><i class="fa fa-search"></i><span><fmt:message key="search" /></span></a></li>
						<li style="display:none"class="testHover quick-link-law"><a href="#" onclick="showQuickLegislation(6);"class="hoverable"><i class="fa fa-ticket"></i><span><fmt:message key="tasks" /></span></a></li>
					</ul>
				</div>
			</div>

			<div class="copyright" style="padding: 7px 9px;">
				<span class="g-brand g-brand-ideagen g-brand--tiny"></span>
				</br> &copy; Copyright <%=java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%> Ideagen PLC
			</div>
		</div>
	</div>
	</c:if>
	<c:if test="${module == 'enviro'}">
		<common:dashboardLeftPanel yearList="${yearList}" currentYear="${currentYear}" viewType="${viewType}" />
	</c:if>
	<c:if test="${module == 'law'}">
		<common:lawLeftPanel yearList="${yearList}" currentYear="${currentYear}" viewType="${viewType}" />
		<c:set var="urlString" value='<c:out value="${pageContext.request.requestURL}"/>'/>
	</c:if>
	<div class="container-fluid" id="pcont" style="z-index: 99">
		<c:if test="${not user.isInRole('IncidentRoles.INCIDENT_GUEST_LOGIN')}">
		<div class="page-head">
			<div class="row">
				<div class="col-sm-12 col-xs-12 col-md-12 col-lg-12">
					<div class="col-sm-6 col-xs-12 col-md-6 col-lg-5 pull-right ">
							<span class="btn"
								  style="background-color: #FFFFFF; border-color: #FFFFFF !important; border-radius: 0px !important;"
								  data-placement="top" data-toggle="tooltip" data-original-title=<fmt:message key="sites" />> <i class="fa fa-sitemap"
																																 style="color: #13ab94"></i></span>
						<select id="siteLocation" class="site"	style="width: 83%; padding-left :0px; font-size: 12px;" onchange="onSiteChange();">
							<c:choose>
								<c:when test="${not empty requestScope.userReq.sites}">
									<c:forEach items="${requestScope.userReq.displaySites}" var="item">
										<c:remove var="selected" />
										<c:if test="${site.id == item.id}">
											<c:set var="selected" value="selected=true" />
										</c:if>
										<option value="<c:out value="${item.id}" />" <c:out value="${selected}" />
										/><c:out value="${item.name}" /></option>
									</c:forEach>
								</c:when>
								<c:when test="${module == 'law'}">
									<c:forEach items="${viewableSites}" var="item">
										<c:remove var="selected" />
										<c:if test="${siteSelected.id == item.id}">
											<c:set var="selected" value="selected=true" />
										</c:if>
										<option value="<c:out value="${item.id}" />" <c:out value="${selected}" />
												title="<c:out value="${item.name}" />"><c:out value="${item.name}" /></option>
									</c:forEach>
								</c:when>
							</c:choose>
						</select>
					</div>
					<!-- <h2 id="h2Mod"></h2> -->
					<div class="col-sm-6 col-xs-12 col-md-6 col-lg-7 ">
						<ol id="breadcrumb" class="breadcrumb" >
							<c:choose>
								<c:when test="${user.isAdmin() || role.isInRole('SystemRoles.ADMINISTRATOR')}">
									<li id="liLink" title-center="Breadcrumb links take you back"><a href="<c:url value="/enviro/home.htm"  />"><fmt:message key="enviro.dashboard" /></a></li>
								</c:when>
								<c:otherwise>
									<li id="liLink" title-center="Breadcrumb links take you back"><a href="<c:url value="/enviro/generalHome.htm"  />"><fmt:message key="applicationName" /> - <fmt:message key="general.QuickLinks" /></a></li>
								</c:otherwise>
							</c:choose>
							<li id="liLink1"><a id="link1"></a></li>
						</ol>
					</div>
				</div>
			</div>
		</div>
		</c:if>

		<div id="frameMcont" class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div id="block" class="block-flat">
						<sitemesh:write property='body'/>
					</div>
					<div style="height: 30px;">&nbsp;</div>
					<common:printCopyright />
				</div>
			</div>
		</div>

	</div>
</div>
</div>


<script type="text/javascript">
	jQuery(document).ready(function(){
		//initialize the javascript
		function onBodyLoad() {
			window.focus();
			if (window.onDecoratorLoad) {
				onDecoratorLoad();
			}
			doJumpto();
			<fmt:message key="logoutTimer" />;
			<fmt:message key="ui.showPrintDialog" var="showPrintDialog" />
			<c:if test="${param.printable && showPrintDialog != 'false'}">
			setTimeout('print()',4000);
			</c:if>
			<c:if test="${defaultTarget ne null}">
			jQuery("a").click(function() {
				var target = this.target || $jq("base").attr("target");
				var opener = window.opener ? window.opener : window.parent ? window.parent.opener : null;
				if(target && opener && target == opener.name && !$jq(this).hasClass("ui-dialog-titlebar-close")) {
					setTimeout(function() {
						opener.focus()
					}, 500);
				}
			});
			</c:if>
		}
		function onBodyUnLoad() {
			;
		}
		jQuery('caption').css("white-space","nowrap");
		jQuery('*').qtip('destroy');
		jQuery('.blockOverlay').click( function() {
			jQuery('*').qtip('destroy');
			jQuery.unblockUI();
			$.unblockUI();
		} );
	});

	function showToolTips(){
		jQuery.blockUI({
			message: null,
			overlayCSS: { opacity:.3 },
			onOverlayClick: hideToolTips()
		});
		jQuery('[title!=""]').qtip({ // Grab all elements with a non-blank data-tooltip attr.
			content: {
				attr: 'title' // Tell qTip2 to look inside this attr for its content
			},
			position: {
				my: 'top left',  // Position my top left...
				at: 'bottom center',
				hide: 'click'
			},
			style: {
				classes: 'qtip-bootstrap'
			},
			hide: false
		}).qtip('show');

		jQuery('[title-center!=""]').qtip({ // Grab all elements with a non-blank data-tooltip attr.
			content: {
				attr: 'title-center' // Tell qTip2 to look inside this attr for its content
			},
			position: {
				my: 'top left',  // Position my top left...
				at: 'center'
			},
			style: {
				classes: 'qtip-bootstrap'
			},
			hide: false
		}).qtip('show');

		jQuery(".complianceChecklist").qtip({
			content: {
				text: jQuery(".complianceChecklistToolTips").clone(),

			},
			position: {
				my: 'top left'  // Position my top left...

			},
			style: {
				classes: 'qtip-bootstrap bigToolTip',
				'default': false
			},
			hide: false
		}).qtip('show');
		jQuery(".helpClass").qtip({
			content: {
				title: "Help",
				text: "Close Tip",
				button: true
			},
			position: {
				my: 'top left',  // Position my top left...
				at: 'center'
			},
			style: {
				classes: 'qtip-bootstrap'
			},
			hide: false
		}).qtip('show');
		jQuery(".ui-icon-close").on("click", function() {
			jQuery('*').qtip('destroy');
			jQuery('.blockOverlay').removeAttr("style");

		});

	}



	function hideToolTips(){
		jQuery('*').qtip('destroy');
		jQuery('.blockOverlay').removeAttr("style");
	}
</script>
<script type="text/javascript" src="<c:url value="/js/jquery.qtip.min.js" />"></script>
<script type="text/javascript">
	// this javascript should be here, in the same document as it uses java tag, otherwise it will not work
	var cookValue = $.cookie('lawTabs');
	if(cookValue != undefined && cookValue != "" && cookValue > 0 && '<%= request.getAttribute("legReg") %>' != 'null'){
		jQuery(".quick-link-law").show();
	} else {
		cookValue = 3;
	}
	function showQuickLegislation(iconOption){
		var urlCat;
		if(iconOption == 1){
			urlCat = '<c:url  value="/law/legislationsView.htm?legRegister=" />'+cookValue;
		} else if(iconOption == 2){
			urlCat = '<c:url  value="/law/checklists.htm?refine=false&viewAll=true&legRegister=" />'+cookValue;
		} else if(iconOption == 3){
			urlCat = '<c:url  value="/legal/front/checklists/KeywordIndex.jsp?registerType=" />'+cookValue;
		}else if(iconOption == 4){
			urlCat = '<c:url  value="/legal/front/legislation/Log.jsp?legRegister=" />'+cookValue;
		}else if(iconOption == 5){
			urlCat = '<c:url  value="/law/contentSearchForm.htm?legRegister=" />';
		}else if(iconOption == 6){
			urlCat = '<c:url  value="/law/taskQueryForm.htm?legRegister=" />'+cookValue;
		}

		location.href = urlCat;
	}
</script>
<style>
	.quick-link-law a i{
		color:#a2aeb4 !important;
	}
</style>
<style type="text/css" media="all">  @import "<c:url value='/js/jquery.qtip.min.css'/>"; </style>

</body>
</html>