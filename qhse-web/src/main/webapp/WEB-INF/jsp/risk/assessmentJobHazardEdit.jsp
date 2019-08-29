<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="enviromanager" uri="https://www.envirosaas.com/tags/enviromanager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<script type="text/javascript" src="<c:url value="/js/calendar.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/engine.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/util.js" />"></script>
<script type='text/javascript' src="<c:url value="/js/risk.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/addRemoveRiskHazardJobs.js" />"></script>
<script type='text/javascript' src="<c:url value="/dwr/interface/SystemDWRService.js" />"></script>




<style>
table.tabClass thead tr th{
	max-width:200px
}
textarea {
	width: 100%;
}

select {
	width:100%;
}

input[type="text"] {
	width: 100%; display: block;
	min-width: 50px;
}
/*.col-sm-10{
width: 83% !important;
padding-left: 0px !important;padding-right: 0px !important;
}
span.requiredHinted {
  margin-right: 5px;
  display: initial;
}
table.tabClass tr td {
	padding: 10px 3px 12px 2px!important;
}*/
  .tabClass th:first-child {
 	width:15%;
}
</style>


<script type="text/javascript">
  var jobScoringQuestions=null;
  var jobScoringTotal=null;
  var rrQuestion=null;
  var rrQuestionCon=0;
  var rrQuestionMag=0;
  var probability=0;
  var controlFactor;
  var correctedMagnitude;
  var checkForTheCondition;
  var riskTitle = '<fmt:message key="risk.placeholder.riskAssessmentTitle"/>';
  
  jQuery(document).ready(function() {
	  jQuery(".tabClass>tbody>tr>td>span").removeClass("col-sm-10");
	  jQuery('.delete').addClass('g-btn g-btn--primary');
	 // jQuery('select').select2({width: '150px'});
	  jQuery('#theJobTable thead th:last-child').after('<th>&nbsp;</th>');
	  jQuery('#theJobTable thead th:last-child').after('<th>&nbsp;</th>');
	  jobScoringQuestions='<%=request.getAttribute("jobScoringQuestions")%>';
	  jobScoringTotal='<%=request.getAttribute("jobScoringTotal")%>';
	  rrQuestion='<%=request.getAttribute("rrQuestion")%>';
	  rrQuestionCon='<%=request.getAttribute("rrQuestionCon")%>';
	  rrQuestionMag='<%=request.getAttribute("rrQuestionMag")%>';
	  probability='<%=request.getAttribute("probabilityQuestion")%>';
	  controlFactor='<%=request.getAttribute("controlFactorQuestion")%>';
	  correctedMagnitude='<%=request.getAttribute("correctedMagnitude")%>';
		initScore();
		var multiselect = jQuery('select[multiple="multiple"]');
		multiselect.removeClass("scrollList");
		multiselect.select2({
			width : '180px'
		});

		init();
		initDependsOn("theForm");
	
	if('${outSideTableJobQuestion}'.length>0){
		jQuery('.pestel').select2({width: '50%'});
		//jQuery('.pestel').attr('disabled', true);
		jQuery('.pestel option').not(':selected').remove();
	}
	
	jQuery(".tabClass").find("th").last().css("width", "70px");
	jQuery(".tabClass").find("th").last().prev("th").css("width", "70px");
	
	checkForTheCondition = function() {
		  
		  var va=false;
		  jQuery('.requiredHinted').each(function() {
			   var sp =jQuery(this).prev('span');
			   var tt=sp.children('[id^=answer]');	
			   if(jQuery(tt).prop('type') == "select-multiple"){
				   if(jQuery(tt).val() == null){
					   jQuery(this).text('* required');
						  tt.css('border-color', 'red');
						  jQuery('input[type="submit"]').prop('disabled', false);
						   va=true; 
				   }
			   }		 
			});
		  if(va){
			  $(jQuery('#loadMask')).unblock();
			  return false;
		  }		  
	  };
	});
  
	function hideHint() {

		var myE = document.getElementById("assessmentNameText");

		if (myE.value == "Risk Assessment Title") {
			myE.style.color = "#000";
			myE.value = "";
		}
	}

	function showHelp(event, questionHelp, aImg) {
		// aImg.style.cursor='help';

		var myDiv = document.getElementById("help");
		//clear previous help element

		if (myDiv.hasChildNodes()) {
			toRemove = myDiv.childNodes[0];
			myDiv.removeChild(toRemove);
		}

		var i = document.createTextNode(questionHelp);

		var el = this.parent;

		var cursor = getPosition(event);

		myDiv.style.left = cursor.x + "px";
		myDiv.style.top = cursor.y + "px";

		myDiv.appendChild(i);
		Effect.Appear('help');
	}

	function hideHelp() {
		Effect.Fade('help');
	}

	function getPosition(e) {
		e = e || window.event;
		var cursor = {
		x : 0,
		y : 0
		};
		if (e.layerX || e.layerY) {
			cursor.x = e.layerX;
			cursor.y = e.layerY;
		} else {
			var de = document.documentElement;
			var b = document.body;
			cursor.x = e.clientX + (de.scrollLeft || b.scrollLeft) - (de.clientLeft || 0);
			cursor.y = e.clientY + (de.scrollTop || b.scrollTop) - (de.clientTop || 0);
		}

		var top = document.body.scrollTop || window.pageYOffset || (document.body.parentElement ? document.body.parentElement.scrollTop : 0);

		return cursor;
	}

	function showLink() {
		var url = '<c:out value="${url}" />';
		openPopup(url, 700, 400);
		linkDislayed = true;
	}

	function openPopup(url, w, h) {
		var x = (screen.height - h) / 2, y = (screen.width - w) / 2;
		var att = "toolbar=no,directories=no,location=no,status=no,menubar=no, resizable=yes,scrollbars=yes,width=" + w + ",height=" + h + ",top=" + x + ",left=" + y + "";
		var win = window.open(url, "links", att);
		win.focus();
	}

	

	function checkHiddenFields() {
		var fields = [ 'answers[58]', 'answers[59]' ];
		/* for (var i=0; i<fields.length; i++) {
		  var field = $(fields[i]); 
		  if (field) {
		    var emptySelect = field.options && field.options.length <= 1;
		    var emptyCheckboxList = !field.innerHTML; 
		    if (emptySelect || emptyCheckboxList) {
		      field.parentNode.parentNode.style.display="none";
		    } else {
		      try {
		        field.parentNode.parentNode.style.display="table-row";
		      } catch(e) {
		        field.parentNode.parentNode.style.display="block";
		      }
		    }
		  }
		} */
		for (var i = 0; i < fields.length; i++) {
			var field = document.getElementById(fields[i]);
			if (field) {
				var emptySelect = field.options && field.options.length <= 1;
				alert(emptySelect);
				var emptyCheckboxList = !field.innerHTML;
				if (emptySelect || emptyCheckboxList) {
					field.parentNode.parentNode.style.display = "none";
				} else {
					try {
						field.parentNode.parentNode.style.display = "table-row";
					} catch (e) {
						field.parentNode.style.display = "block";
					}
				}
			}
		}
	}
	postPopulateQuestionOptionsCallbackHandler = checkHiddenFields;

	function checkForSubTables() {
		var elems = document.getElementsByTagName("div");
		var subTables = new Array();
		for (var i = 0; i < elems.length; i++) {
			var nameProp = elems[i].getAttribute('id');
			if (!(nameProp == null) && (nameProp.substr(nameProp.length - 3, nameProp.length) == 'div')) {
				subTables.push(elems[i]);
			}
		}
		if (subTables.length > 0) {
			var tableId = subTables[0].id.substr(0, subTables[0].id.indexOf('-'));
			var table = document.getElementById("answers[" + tableId + "]");
			var numberOfRows = table.tBodies[0].rows.length;

			for (var i = 0; i < numberOfRows; i++) {
				var subTableGroup = getSubTablesForRow(subTables, i);
				for (var k = 0; k < subTableGroup.length; k++) {
					var div = subTableGroup[k];
					if (div.firstChild.readOnly == true && div.firstChild.value == "") {
						var defaultValue = div.firstChild.attributes["defaultValue"].value
						if (defaultValue != null) {
							div.firstChild.value = defaultValue;
						}
					}
					//show div
					var trparent = getParent("tr", table);
					var tbodyparent = getParent("tbody", table);
					if (i == 0) {
						var newTableRow = tbodyparent.insertRow(trparent.rowIndex + 1);
					} else {
						var newTableRow = tbodyparent.insertRow(trparent.rowIndex + 1 + (i * subTableGroup.length));
					}
					newTableRow.insertCell(0);
					var cell = newTableRow.insertCell(1);
					div.style.display = "block";
					cell.insertBefore(div, null);
				}
			}
		}
	}

	function init() {
		var arr = jQuery('#theForm').serializeArray();
		var list = document.getElementsByTagName("ul");
		for (var i = 0; i < list.length; i++) { // Append ULs with a questionId attrib to the list
			var obj = list[i].getAttribute("questionid");
			if (list[i].getAttribute("questionid")) {
				arr[arr.length] = list[i];
			}
		}

		checkHiddenFields();
		checkForSubTables();
		showHint();

		<fmt:message key="assessmentStep1.saveDataMsg" />
	}

	function onFormSubmit() {
		var fields = new Array('answers[39]');
		this;
	}

	function optionName(lst, val) {
		response = '';
		for (var i = 0; i < lst.options.length; i++) {
			if (lst.options[i].value == val) {
				response = lst.options[i].text;
				break;
			}
		}
		return response;
	}
	function updateApprovalUser(responsibleUserSelect) {
		var option = optionName(responsibleUserSelect, responsibleUserSelect.value);
		dwr.util.setValue("assessmentApprovalByUserSelect", option);
	}

	function append(value, id) {
		var toAppend = value.value;
		var index;
		if (value.id.indexOf("-") > 0) {
			id = id + value.id.substring(value.id.indexOf("-"), value.id.indexOf("]"))
		}
		var elem = getElementBySubName("answers[" + id + "]");
		dwr.util.setValue(elem.firstChild, elem.firstChild.attributes["defaultValue"].value + " " + toAppend);
	}
	function setScore(elem) {
		var selectedQuestion = elem.getAttribute("questionid");
		var scoringIds=jobScoringQuestions.split(",");
		 if(selectedQuestion == '${rrQuestionIdSeverity2}' || selectedQuestion == '${rrQuestionIdLinkehood2}'){
			 rrQuestion = '<%=request.getAttribute("rrQuestion2")%>';
			 scoringIds = ['${rrQuestionIdSeverity2}', '${rrQuestionIdLinkehood2}'];
		 } else {
			 rrQuestion = '<%=request.getAttribute("rrQuestion")%>';
			 var index1 = scoringIds.indexOf('${rrQuestionIdSeverity2}');
			 var index2 = scoringIds.indexOf('${rrQuestionIdLinkehood2}');
			 if(index1 > -1 && index2 > -1){
				 scoringIds.splice(index1, 1);
				 scoringIds.splice(index2, 1);
			 }
		 }
		var selectedOption = elem.getAttribute("id");
		// alert(selectedOption)
		// var selectedValue=null
		var scoreChanged = false;
		
		if (selectedQuestion != null) {
			for (var i = 0; i < scoringIds.length; i++) {
				if (selectedQuestion.indexOf(scoringIds[i])) {
					scoreChanged = true;
					//			 var selOption = document.getElementById(selectedOption);
					//		     selectedValue = selOption[selOption.selectedIndex].text;
				}
			}
		}
		// alert('scoreChanged: '+scoreChanged);
		if (scoreChanged == true) {
			var score = 1;
			for (var i = 0; i < scoringIds.length; i++) {
				var selectedOptionPart = selectedOption.split("-");
				var selOption = null;
				if (selectedOptionPart.length == 2) {
					var selOption = document.getElementById('answers[' + scoringIds[i] + '-' + selectedOptionPart[1]);
	 				 if(selOption.tagName.toLowerCase() == 'span') {
	 					selOption = selOption.firstChild;
	 				 }
				} else {
					var selOption = document.getElementById('answers[' + scoringIds[i] + ']');
				}
				var selectedValue = selOption[selOption.selectedIndex].text;
				//alert('selectedValue: '+selectedValue);
				if (selectedValue != null) {
					var scoring = selectedValue.split("-");
					if (scoring[0] != null) {
						if (isNumber(scoring[0])) {
							score = score * scoring[0];
						}
					}
				}
			}
			// alert('score: '+score);
			var selectedOptionPart = selectedOption.split("-");
			if (selectedOptionPart.length == 1) {
				document.getElementById('answers[' + rrQuestion + ']').value = score;
			} else {
				//alert('answers['+rrQuestion+'-'+selectedOptionPart[1]);
				document.getElementById('answers[' + rrQuestion + '-' + selectedOptionPart[1]).value = score;
				if(document.getElementById('answers['+rrQuestion+'-'+selectedOptionPart[1]).tagName.toLowerCase() == 'span') {
					document.getElementById('answers['+rrQuestion+'-'+selectedOptionPart[1]).firstChild.value=score;
				}
			}
		}
	}
	function isNumber(n) {
		return !isNaN(parseFloat(n)) && isFinite(n);
	}
	function initScore() {
		//rrQuestionMag is only set when it is a SA template. If it is not a ABBP template this code should not run.
		if (rrQuestionMag == 0) {
			var score = 1;
			var scoringIds = jobScoringQuestions.split(",");
			for (var i = 0; i < scoringIds.length; i++) {
				var selOption = document.getElementById('answers[' + scoringIds[i] + ']');
				var selectedValue = selOption[selOption.selectedIndex].text;
				//alert('selectedValue: '+selectedValue);
				if (selectedValue != null) {
					var scoring = selectedValue.split("-");
					if (isNumber(scoring[0])) {
						score = score * scoring[0];
					} else {
						score = '';
					}
				}
			}
			document.getElementById('answers[' + rrQuestion + ']').value = score;
		}
	}

	function setScore2(elem) {
		var selectedQuestion = elem.getAttribute("questionid");
		var selectedOption = elem.getAttribute("id");
		var scoreChanged = false;
		var scoringIds = jobScoringQuestions.split(",");
		if (selectedQuestion != null) {
			for (var i = 0; i < scoringIds.length; i++) {
				if (selectedQuestion.indexOf(scoringIds[i])) {
					scoreChanged = true;

				}
			}
		}
		if (scoreChanged == true) {
			document.getElementById('answers[' + rrQuestionCon + ']').value = '';
			document.getElementById('answers[' + rrQuestionMag + ']').value = '';
			var score = 1;
			for (var i = 0; i < scoringIds.length; i++) {
				if (probability != scoringIds[i]) {
					var selectedOptionPart = selectedOption.split("-");
					var selOption = document.getElementById('answers[' + scoringIds[i] + ']');
					var selectedValue = selOption[selOption.selectedIndex].text;
					if (isNumber(selectedValue)) {
						var consequence = document.getElementById('answers[' + rrQuestionCon + ']').value;
						if (isNumber(consequence)) {
							selectedValue = parseInt(consequence) + parseInt(selectedValue);
						}
						document.getElementById('answers[' + rrQuestionCon + ']').value = selectedValue;

					}
				}
				var probabilityEle = document.getElementById('answers[' + probability + ']');
				var conqValue = document.getElementById('answers[' + rrQuestionCon + ']').value;
				var probabilityValue = probabilityEle.options[probabilityEle.selectedIndex].text;
				if (isNumber(probabilityValue) && isNumber(conqValue)) {
					document.getElementById('answers[' + rrQuestionMag + ']').value = (parseInt(conqValue) * parseInt(probabilityValue));
					setScoreCM();
				}
			}
		}
	}

	function setScoreCM() {
		controlFactor = controlFactor.replace('[', '');
		controlFactor = controlFactor.replace(']', '');
		var controlF = controlFactor.split(",");
		var reduceValue = 1;
		for (var i = 0; i < controlF.length; i++) {

			controlF[i] = controlF[i].replace(" ", "")
			var selOption = document.getElementById('answers[' + controlF[i] + ']');
			if (selOption != null) {
				var selValue = selOption.options[selOption.selectedIndex].text;
				if (selValue.indexOf("100") != -1) {
					reduceValue = 0;
				} else if (selValue.indexOf("70") != -1 && reduceValue > .7) {
					reduceValue = reduceValue - .7;
				} else if ((selValue.indexOf("50") != -1) && reduceValue > .5) {
					reduceValue = reduceValue - .5;
				} else if ((selValue.indexOf("30") != -1) && reduceValue > .3) {
					reduceValue = reduceValue - .3;
				} else if ((selValue.indexOf("15") != -1) && reduceValue > .15) {
					reduceValue = reduceValue - .15;
				}
			}
		}
		var cmag = document.getElementById('answers[' + rrQuestionMag + ']').value;
		if (cmag) {
			cmag = cmag - (Math.round((cmag - (cmag * reduceValue)) * 100) / 100);
			cmag = cmag.toFixed(2);
			document.getElementById('answers[' + correctedMagnitude + ']').value = cmag;
		}
	}
</script>
<style type="text/css" media="all">
/*  @import "<c:url value='/css/calendar.css'/>";
    @import "<c:url value='/css/risk.css'/>"; */
</style>
</head>
<body>
	<div class="header">
		<h2>
			<fmt:message key="assessment.job.hazard.edit.title" />
		</h2>
	</div>
	<scannell:form id="theForm" onsubmit="return checkForTheCondition();">
		<div class="content">
			<div class="table-responsive">
				<c:if test="${command.assessment.template.prefix != 'SA'}">
					<table id="theJobTable" class="table table-bordered table-responsive">
						<tbody>
							<c:choose>
									<c:when test="${outSideTableJobQuestion ==null }">
										<td><fmt:message key="assessment.job.description" />: <scannell:textarea path="name" cols="63" rows="2"/></td>
									</c:when>
									<c:otherwise>
									<tr style="max-width: 20%">
									<td>&nbsp;&nbsp;
									${outSideTableJobQuestion.name }
									</td>
									</tr>
										<tr>
										<td >
										<enviromanager:question path="answers" question="${outSideTableJobQuestion}" emptyOptionLabel="Choose" class="pestel" cssStyle="float:left;width:20%"/>
										</td>
										</tr>
									</c:otherwise>
								</c:choose>
							<tr>
								<td><enviromanager:question path="answers" question="${jobQuestion}" emptyOptionLabel="Choose"
										multiselectCheckboxes="false" onchange="setScore(this)" class="tableTH"/></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td align="center"><input type="submit" class="g-btn g-btn--primary" id="submit"
										value="<fmt:message key="submit" />"> <input type="button" class="g-btn g-btn--primary"
										value="<fmt:message key="cancel" />"
										onclick="window.location='<c:url value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${command.assessment.id}"/></c:url>'">
								</td>
							</tr>
						</tfoot>
					</table>
				</c:if>
				<c:if test="${command.assessment.template.prefix == 'SA'}">
					<table id="theJobTable" class="viewForm" style="margin-top: 0px;">
						<col class="label" />
						<thead>
							<tr>
								<td colspan="12" align="left">Job Detail</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="12">
									<table id="theJobTable" class="viewForm" style="margin-top: 0px;">
										<thead>
											<tr>
												<scannell:hidden path="name" />
												<c:forEach items="${jobQuestion.columns}" var="columns">
													<c:if test="${not fn:containsIgnoreCase(columns.codeName, 'cf')}">
														<th><c:out value="${columns.name}"></c:out></th>
													</c:if>
												</c:forEach>
											</tr>
										</thead>
										<tbody>
											<tr>
												<c:forEach items="${jobQuestion.columns}" var="columns2">

													<c:if test="${not fn:containsIgnoreCase(columns2.codeName, 'cf')}">
														<td><enviromanager:question path="answers" question="${columns2}" emptyOptionLabel="Choose"
																multiselectCheckboxes="false" onchange="setScore2(this)" /></td>
													</c:if>

												</c:forEach>
											</tr>
											<tr>
												<td colspan="12" class="scoringCategoryTitle">Control Factors:</td>
											</tr>

											<tr>
												<c:forEach items="${jobQuestion.columns}" var="columns3">
													<c:if test="${fn:containsIgnoreCase(columns3.codeName, 'cf')}">
														<tr>
															<th valign="top"><c:out value="${columns3.name}"></c:out></th>
															<td colspan="3"><enviromanager:question path="answers" question="${columns3}"
																	emptyOptionLabel="Choose" multiselectCheckboxes="false" onchange="setScoreCM()" /></td>
														</tr>
													</c:if>
												</c:forEach>
											</tr>
										</tbody>
									</table>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td align="center"><input type="submit" class="g-btn g-btn--primary" id="submit"
										value="<fmt:message key="submit" />"> <input type="button" class="g-btn g-btn--primary"
										value="<fmt:message key="cancel" />"
										onclick="window.location='<c:url value="/risk/expressAssessmentView.htm"><c:param name="showId" value="${command.assessment.id}"/></c:url>'">
								</td>
							</tr>
						</tfoot>
					</table>
				</c:if>

			</div>
		</div>
	</scannell:form>
</body>
</html>
