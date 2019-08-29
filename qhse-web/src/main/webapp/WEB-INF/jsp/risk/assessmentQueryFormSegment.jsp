<%@ page language="java" contentType="text/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
function loadTemplateQuestions() {
  var questions = [
  <c:forEach var="q" items="${template.summaryQuestions}" varStatus="s">
  <%-- Question 42 Functional Department will now always be shown instead of depending on template question, so removing from here --%>
  <c:if test="${q.id != 42}">
    { id: <c:out value="${q.id}" />, name: '<c:out value="${q.name}" />', answerType: '<c:out value="${q.answerType.name}" />', value: '${answerCache[q.id]}' }<c:if test="${!s.last}">,</c:if>
    </c:if>
     </c:forEach>
  ];
	var hazardAspectSelected = false;
	var keyScoreSelected=false;
  var table=document.getElementById("queryTable");    
  for (i = table.rows.length - 1; i >= 0; i--) {
    if (table.rows[i].getAttribute("templateQuestion")) {
      table.deleteRow(i);
    }
  }
   for(i=0; i< questions.length; i++) {
   if(questions[i].id=='300287' || questions[i].id=='300295'  ||questions[i].id=='400287'){ 
   		var rowScoreType = table.insertRow(table.rows.length - 4);
   		var cellRiskLabel = rowScoreType.insertCell(0);
   		cellRiskLabel.className = "searchLabel";
   		cellRiskLabel.innerHTML='<label for="ScoreType">Score Type</label>';
   		var cellRisk = rowScoreType.insertCell(1);
   		cellRisk.className = "search";
   		cellRisk.innerHTML='<input type="radio" id="scoreType1" name="scoreType" value="Scorecard Score" onclick="disableHazard()"> Scorecard Score</input><br /><input type="radio" id="scoreType2" name="scoreType" value="Hazard/Aspect Score" checked="checked" onclick="enableHazard()"> Hazard/Aspect Score</input>';	
   		rowScoreType.setAttribute("templateQuestion", true);
   		hazardAspectSelected = true;
   }
      if(questions[i].id=='310287' || questions[i].id=='350287'  ||questions[i].id=='410002'){ 
   		var rowScoreType = table.insertRow(table.rows.length - 4);
   		var cellRiskLabel = rowScoreType.insertCell(0);
   		cellRiskLabel.className = "searchLabel";
   		cellRiskLabel.innerHTML='<label for="ScoreType">Search By</label>';
   		var cellRisk = rowScoreType.insertCell(1);
   		cellRisk.className = "search";
   		cellRisk.innerHTML='<input type="radio" id="keyIssuesRadio1" name="scoreType" checked="checked" value="Scorecard Score" onclick="disableKeyIssues()"> Scorecard Score</input><br /><input type="radio" id="keyIssuesRadio2" name="scoreType" value="Key Issues" onclick="enableKeyIssues()"> Key Issues</input>';
   		rowScoreType.setAttribute("templateQuestion", true);
   		keyScoreSelected = true;
   }
    var question = questions[i];
    var id = 'answers[' + question.id + ']';
    var idMulti = 'answers_' + question.id + '_';

    var row = table.insertRow(table.rows.length - 4);
    row.setAttribute("templateQuestion", true);
    row.className = "form-group";

    var cell = row.insertCell(0);
    cell.setAttribute("templateQuestion", true);
    cell.id = id + 'Label';
    cell.className = "searchLabel nowrap";
    
    cell.innerHTML = question.name + ":";
   

    cell = row.insertCell(1);
    cell.className = "search";
    if(question.id=='300287' || question.id=='300295' || questions[i].id=='300287'){  //it's a hack to display multiple choice option for new risk Hazard.
      cell.innerHTML ='<select id="' + idMulti + '" name="' + id + '" style="width:130%" class="boot select2Util" questionid="' + question.id + '" multiple="multiple"></select>';
      emptyCell = row.insertCell(2);
      emptyCell.style.border=0;
      emptyCell.className = "search";
      help=row.insertCell(3);
      help.className = "searchQueryFormSegment";
      help.innerHTML='(For hazard/aspect score select hazard(s)/aspect(s))';      
      populateQuestionOptions(document.getElementById(idMulti), question.value);
    } else
    if (question.answerType == "option" || question.answerType == "option-multi-choice") {    
      cell.innerHTML = '<select id="' + idMulti + '" name="' + id + '" class="boot select2Util" onchange="addChoose();"  style="width:100%" questionid="' + question.id + '"></select>';          
      populateQuestionOptions(document.getElementById(idMulti), question.value);      
      
    } else {
      cell.innerHTML = '<input type="text" id="' + id + '" name="' + id + '" style="width:40%" value="' + question.value + '" />';
    }
  }
  if(hazardAspectSelected == true)
  {
   	 	enableHazard();
  }
  if(keyScoreSelected == true){
  disableKeyIssues();
  }
  return !(questions.length==0);
}

