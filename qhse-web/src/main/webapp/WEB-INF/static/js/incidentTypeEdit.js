
		var newGroupIndex;
		var newGroupLabel;
		var mandatoryLabel;
		var searchableLabel;
		var exportableLabel;
			
		
	  	jQuery(document).ready(function() {
	  		newGroupIndex = 0;
			newGroupLabel = "New Group";
			mandatoryLabel="<fmt:message key='clientQuestionMandatory' />";
			searchableLabel='<fmt:message key="clientQuestionSearchable" />';
			exportableLabel='<fmt:message key="clientQuestionExportable" />';
			
			resetDelete();
 	  		resetSortable();
 	  		resetEditable();

 			 var itemEdit = jQuery('.itemEdit');
 			 itemEdit.click(function(){
 				 showEditDialog(jQuery(this));
 				});
 			jQuery("#investigationConfigured").change(function(){ 
 			    jQuery("#investigationRow").toggle(this.checked); 
 			    jQuery("#investigationOptionalRow").toggle(this.checked); 
 			}).change();
		  });
	  	
		  	var list = jQuery('ul');
		  	var editList = jQuery('.edit-list');
	
		editList.onclick = function() {
		    //or you can use list.setAttribute("contentEditable", true);
		    list.contentEditable = true;
		}
		 
		 function showEditDialog(el)
		 {
			var li = jQuery(el).parent('li');
			if(li.hasClass('expanded'))
			{
				 li.animate({height:'30px'}, 500);
				 li.removeClass('expanded');
				 li.find('div.checkboxes')[0].style.display='none';
			}
			else
			{
				 li.addClass('expanded');
				 li.animate({height:'100px'}, 500);
				 li.find('div.checkboxes')[0].style.display='';
			}
		 }

		function addNewGroup(parent) {
			var parentDiv = jQuery("#"+parent);
			var index = parentDiv.find("div.questionGroup").length;
			var a = jQuery("<a>", {href: "#"+parent, title:"delete group", onclick:"deleteGroup('ng"+newGroupIndex+"')", style:"float:right;"}).append("<span class='glyphicon glyphicon-remove'></span>");
			var ul = jQuery("<ul>", {id:"newGroup"+newGroupIndex,  class:"sortable" });
  	  		var div = jQuery("<div>", {id: "ng"+newGroupIndex, ondrop: "drop(event, this)", ondragover:"allowDrop(event)",  class:"questionGroup", value:"New Group"});
  	  		div.append('<input type="text" class="groupName" id="'+parent+'['+index+'].name" name="'+parent+'['+index+'].name" value="'+newGroupLabel+'"/>').append(a);
  	  		div.append(ul);
  	  		jQuery("#"+parent).append(div);
  	  		document.getElementById("ng"+newGroupIndex).scrollIntoView();
  	  		newGroupIndex++;
  	  		resetSortable();
  	  		resetDelete();
  	  		resetEditable();
		}
		
		function deleteGroup(group) {
			var g = jQuery("#"+group);
			
			//Return all questions
			jQuery("#"+group+" li").each(function(i)
			{
				var li =  jQuery(this);
		    	var icon = jQuery(this).find(".glyphicon");
				var name = li[0].innerText.replace(/X([^X]*)$/,'$1');
	  	  		var str = "<li id='"+li[0].id+"' draggable='true' ondragstart='drag(event);' ondrop='drop(event)' ondragover='allowDrop(event)' class='question list-group-item  list-group-item-warning' >"+name+"</li>";
	  	  		if(li[0].id.indexOf("client") > -1)
	  	  		{
	  	  			jQuery("#clientQuestionsList").append(str).append(icon[0]);
	  	  		}
	  	  		else
	  	  		{
	  	  			jQuery("#commonQuestionsList").append(str).append(icon[0]);
	  	  		}
	  	  		li.remove();
			});
  	  		
  	  		
	  	  	//delete group
			jQuery("#"+group).remove();
  	  		resetSortable();
  	  		resetDelete();
		}
		
		function highlightDropableDiv(){
				jQuery('.questionGroup').addClass('dropArea');
				if(jQuery('.appendtext').length<=0){
				jQuery('.questionGroup').append('<span class="appendtext" style="color:red"> **Drop on highlighted Area** </span>');
				}
			    setTimeout(function(){
			    	jQuery('.questionGroup').removeClass('dropArea');
			    	jQuery(".appendtext").remove();
			    }, 6000);
				
			 }
	
		function allowDrop(ev) {
			//highlightDropableDiv();
		    ev.preventDefault();
		    if (ev.target.getAttribute("draggable") == "true"){
		        ev.dataTransfer.dropEffect = "none"; // dropping is not allowed
		    } 
		    else if (ev.target.getAttribute("class") == "groupName"){
		        ev.dataTransfer.dropEffect = "none"; // dropping is not allowed
		    }
		    else {
		        ev.dataTransfer.dropEffect = "all"; // drop it like it's hot

		    }
		}
		
		function drag(ev) {
			if(ev != undefined)
			{
		    	ev.dataTransfer.setData("text", ev.target.id);
			}
		}
		
		function resetEditable()
		{
			jQuery('.edit-on-click').click(function() {
 	  		    var $text = jQuery(this),
 	  		      $input = $('<input type="text" />')

 	  		    $text.hide()
 	  		      .after($input);

 	  		    $input.val($text.html()).show().focus()
 	  		      .keypress(function(e) {
 	  		        var key = e.which
 	  		        if (key == 13) // enter key
 	  		        {
 	  		          $input.hide();
 	  		          $text.html($input.val())
 	  		            .show();
 	  		          $text.attr("value", $input.val());
 	  		          $text.parent().parent().attr("value", $input.val());
 	  		          return false;
 	  		        }
 	  		      })
 	  		      .focusout(function() {
 	  		        $input.hide();
 	  		        $text.show();
 	  		      })
 	  		  });	
		}
		
		function resetDelete()
		{
			jQuery('.sortable').on('click', '.itemDelete', function() {
	  	  		var li = jQuery(this).closest('li');
		    	var icon = jQuery(this).closest('li').find(".glyphicon");
	  	  		var type = jQuery(this).closest('li').find('.questionType').val();
	  	  		if(li[0].id.indexOf("ClientQuestion") > -1 || type == "ClientQuestion")
	  	  		{
			    	var qid = jQuery("#"+li[0].id).find(".questionQuestionId").val();
		  	  		var url='findConfigurableQuestion.json?questionId='+qid;
				    jQuery.getJSON(url, function(question) {	
				    	jQuery("#clientQuestionsList").append('<li id="ClientQuestion-'+question.id+'" draggable="true" ondragstart="drag(event);" class="items list-group-item  list-group-item-warning" value="'+question.name+'" ondrop="drop(event, this)" ondragover="allowDrop(event)">&nbsp;<input type="hidden" class="mandatory" value="'+question.mandatory+'"/><input type="hidden" class="questionType" value="'+question.optionType+'"/><client:questionImage questionType="'+question.optionType+'"/>'+question.name+'</li>');
				    }); 
	  	  		}
	  	  		else
	  	  		{
	  	  			var partsOfStr = li[0].id.split('-');
			    	var icon = jQuery(this).closest('li').find(".glyphicon");
	  	  			jQuery("#commonQuestionsList").append('<li id="'+li[0].id+'" draggable="true" ondragstart="drag(event);" class="list-group-item  list-group-item-success" value="'+partsOfStr[1]+'" ondrop="drop(event, this)" ondragover="allowDrop(event)">&nbsp;'+icon+'<input type="hidden" class="mandatory" value="false"/><fmt:message key="'+partsOfStr[1]+'"/></li>');
	  	  		}
	  	  		li.remove();
	  	  	});
		}
		
		function resetSortable()
		{
			jQuery( ".sortable" ).sortable({
			      revert: true,
			      stop: function(event, ui) {
			          if(!ui.item.data('tag') && !ui.item.data('handle')) {
			              ui.item.data('tag', true);
			              ui.item.fadeTo(400, 0.1);
			          }
			      },
			      sort: function () {
			            // gets added unintentionally by droppable interacting with sortable
			            // using connectWithSortable fixes this, but doesn't allow you to customize active/hoverClass options
			            $(this).removeClass("ui-state-default");
			        },
			        over: function () {
			            removeIntent = false;
			        },
			        out: function () {
			            removeIntent = true;
			        },
			        beforeStop: function (event, ui) {
			            if(removeIntent == true){
			                ui.item.remove();   
			            }
			        }

			    });
		  	jQuery( ".sortable" ).disableSelection();
		}
		
		function drop(ev, element) {
		    ev.preventDefault();
		    jQuery(this).find('.groupName').blur(); 
		    var data = ev.dataTransfer.getData("text");
		    if(element.parentElement.id == "investigationQuestionGroups" && data.indexOf("IncidentField") == 0)
		    {
		    	alert("Incident Fields cannot be added to investigation");
		    	return;
		    }

		    if(element.parentElement.id == "incidentQuestionGroups" && data.indexOf("InvestigationField") == 0)
		    {
		    	alert("Investigation Fields cannot be added to incident");
		    	return;
		    }
		    var dataObject = document.getElementById(data);
		    if(dataObject === undefined || dataObject == null)
		    {
		    	return;
		    }
		    var list = ev.target.getElementsByTagName("ul");
		    if(list.length > 0)
		    {
		    	var mandatory = "";
		    	if(jQuery("#"+dataObject.id).find(".mandatory").val() == "true" || jQuery("#"+dataObject.id).find(".mandatory").val() == "on") {
		    		mandatory = "checked";
		    	}
		    	var questionType = jQuery("#"+dataObject.id).find(".questionType").val();
		    	var icon = jQuery("#"+dataObject.id).find(".glyphicon");
			    jQuery("#"+dataObject.id).remove();
				for (var i = 0; i < list.length; i++) {
					var name = dataObject.innerText.replace(/X([^X]*)$/,'$1');
					var li = jQuery("<li>", {id: dataObject.id, ondrop: "drop(event, this)", ondragover:"allowDrop(event)",  class:"question list-group-item  list-group-item-success", ondragstart:'drag(event);'}).append('&nbsp;&nbsp;&nbsp;&nbsp;').append(icon[0]).append(name).append("<a href='#"+element.id+"' title='delete' class='itemDelete' style='float:right;'><span class='glyphicon glyphicon-remove'></span></a>&nbsp;<a title='edit' class='itemEdit' onclick='showEditDialog(this);' style='float:right;padding-right:2%;'><span class='glyphicon glyphicon-pencil'></span></a>");
		  	  		var idName = jQuery('#'+list[i].id).siblings()[0].name.replace('.name','').replace('.id','');
		  	  		var partsOfStr = dataObject.id.split('-');
		  	  		jQuery("#"+list[i].id).append(li);
		  	  		var index = jQuery('#'+dataObject.id).index();
		  	  		var params1;
		  	  		if(partsOfStr[0] == 'IncidentField' || partsOfStr[0] == 'InvestigationField') {
			  	  		params1 = '<input type="hidden" class="questionQuestionId" name="'+idName+'.questions['+index+'].questionId" value="0"/><input type="hidden" class="questionQuestionName" name="'+idName+'.questions['+index+'].questionName" value="'+partsOfStr[1]+'"/>';
		  	  		}
		  	  		else {
		  	  			params1 = '<input type="hidden" class="questionQuestionId" name="'+idName+'.questions['+index+'].questionId" value="'+partsOfStr[1]+'"/>';
		  	  		}
		  	  		var params2 = '<input style="display:none" type="text" class="questionOrder" name="${groupName}.questions[${questionIndex}].questionOrder"/><input type="hidden" class="questionType" name="'+idName+'.questions['+index+'].type" value="'+partsOfStr[0]+'"/>';
		  	  		var checkboxDiv = '<div class="checkboxes" style="display:none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionMandatory" name="'+idName+'.questions['+index+'].mandatory" '+mandatory+'/> Mandatory<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionSearchable" name="'+idName+'.questions['+index+'].searchable" /> Searchable<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionExportable" name="'+idName+'.questions['+index+'].exportable" /> Exportable</div>';
		  	  		if(questionType == "QuestionAnswerType[checkbox]") {
			  	  		checkboxDiv = '<div class="checkboxes" style="display:none"><input type="hidden" class="questionMandatory" name="'+idName+'.questions['+index+'].mandatory" value="false"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionSearchable" name="'+idName+'.questions['+index+'].searchable" /> Searchable<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" class="questionExportable" name="'+idName+'.questions['+index+'].exportable" /> Exportable</div>';
		  	  		}
		  	  		li.attr("draggable","true");
		  	  		jQuery("#"+dataObject.id).prepend(params1).append(params2).append(checkboxDiv);
				}
				resetSortable();
		    }
			jQuery('.questionGroup').removeClass('dropArea');
	    	jQuery(".appendtext").remove();
  	  		document.getElementById(dataObject.id).scrollIntoView();
		}
		
		function prepareGroups()
		{
			updateGroup('incidentQuestionGroups', 'incident');
			updateGroup('investigationQuestionGroups', 'investigation');
		}
		
		function updateGroup(gName, gSize)
		{
			var rows = jQuery('#'+gName+' .questionGroup');
			jQuery('#'+gSize+'Size').val(rows.length);
			var index = 0;
			jQuery('#'+gName+' .questionGroup').each(function(){
				var qrows = jQuery(this).find('li').length;
				jQuery('<input/>').attr({
				    type: 'hidden',
				    name: gSize+"["+index+"]Size",
				    value : qrows
				}).appendTo('form');
				var groupName=gName+"["+index+"].";
				jQuery(this).find('.groupId').attr("name",groupName+"id");
				jQuery(this).find('.groupName').attr("name",groupName+"name");
				var qindex = 0;
			    jQuery(this).find('li input[name$=".questionOrder"]').each(function(){jQuery(this).val(qindex+'');qindex++;});
			    qindex = 0;
			    jQuery(this).find('li').each(function(){
			    	var questionName=groupName+"questions["+qindex+"].";
					jQuery(this).find('.questionId').attr("name",questionName+"id");
					jQuery(this).find('.questionQuestionId').attr("name",questionName+"questionId");
					jQuery(this).find('.questionQuestionName').attr("name",questionName+"questionName");
					jQuery(this).find('.questionType').attr("name",questionName+"type");
					jQuery(this).find('.questionOrder').attr("name",questionName+"questionOrder");
					jQuery(this).find('.questionMandatory').attr("name",questionName+"mandatory");
					jQuery(this).find('.questionSearchable').attr("name",questionName+"searchable");
					jQuery(this).find('.questionExportable').attr("name",questionName+"exportable");
					qindex++;
			    });

			    index++;
			});
		}