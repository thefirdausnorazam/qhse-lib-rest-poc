importPackage(Packages.org.eclipse.birt.chart.model.attribute.impl);
    
function logDebug(text) {
	var writer = new Packages.java.io.FileWriter("/tmp/ss-birt.log", true);
	writer.write(text);
	writer.write("\n");
	writer.close();
}

ss = {
  substringBefore: function(str, delim) {
	  var index = str.indexOf(delim);
	  return (index > 0) ? str.substring(0, index) : str;
  },
		
  ellipsis: function(value, len) {
    if (value && value.length > len) {
      return value.substr(0, len - 3) + "...";
    }
    return value;
  },    

  resolveDepartmentName: function(originalDeptName) {
  	if(originalDeptName) {
        return BirtStr.trim((params["groupDepartments"] == true ? ss.substringBefore(originalDeptName, params["departmentDelimiter"]) : originalDeptName));
  	} else {
  	  return "Unknown Dept";
  	}
  },
  
  resolveCode: function(code) {
	  if(ss.messageSource) {
		  return ss.messageSource.getMessage(code, null, '???' + code + '???', null);
	  }
	  return "[" + code + "]";
  },
  
  actionTaskUrl: function(type, id) {
    var typeUrl = 
      type == "action" ? "/incident/viewAction" :
      type == "actionTask" ? "/incident/viewTask" :
      type == "riskTask" ? "/risk/taskView" :
      type == "profileTask" ? "/law/taskViewSearch" :
      type = "hazardTask" ? "/risk/taskView" :
      "unknown/task/type";

    return ss.enviroUrl(typeUrl, id);
  }, 

  enviroUrl: function(controllerUrl, entityId) {
    var siteUtils = Packages.com.scannellsolutions.site.SiteUtils;
    var baseUrl = ss.enviroMgrContextURL + controllerUrl + ".htm?" ;
    //ENV-7775: ID was coming with comma like 10,0589. This ER remove all commas
    try{entityId= entityId.replace(/,/g, "");}catch(e){}
    var params = ["id=" + entityId];
    var renderType = ss.renderType;

    if(siteUtils.isBound()) {
      params.push("switchToSite=" + siteUtils.getCurrentSite().getId())
    }
    
    // include the redirect to self parameter hack if the document is going to be opened in ms office
    if(renderType == "XLSX" || renderType == "XLS" || renderType == "ODS") {
      params.push("_ss_rts=1")
    }
    
    return baseUrl + params.join("&");
  },
  
  actionTaskDescription: function(type) {
    switch (type) {
      case "action":  
        return "Action"; 
      case "actionTask": 
        return "Action Task";
      case "riskTask": 
        return "Risk Task";
      default: 
        return type;
    }
  },
  
  riskTaskTypeDescription: function(type) {
    switch(type) {
    case "MP":
      return "Management Programme Tasks";
    case "RA":
      return "Risk Assessment Tasks";
    case "HT":
      return "Risk Hazard Tasks";
    default: 
      return type;
    }
  },
  
  riskTaskDisplayId: function(id, type) {
	  if(type === 'HT'){
		  type = "RH"
	  }
      return type + "T" + id;
  },

  setRiskAssessmentFillColor: function(value, fill, icsc ) {
    if(value == "1green") {
      ss.setFillColor(fill, [100, 255, 100], [60, 200, 60]);
    } else if(value == "2amber") { 
      ss.setFillColor(fill, [255, 180, 80], [250, 150, 60]);
    }  else if(value == "3blue" || value == "3yellow") { 
      ss.setFillColor(fill, [80, 155, 255], [80, 200, 255]);
    } else {
      ss.setFillColor(fill, [250, 40, 40], [200, 30, 30]);
    }
  },

  setOutstandingTaskFillColor: function(value, fill, icsc ) {
    var lcValue = value.toLowerCase();
    if(lcValue == "pending") {
      ss.setFillColor(fill, [100, 255, 100], [60, 200, 60]);
    } else if(lcValue == "overdue") { 
      ss.setFillColor(fill, [250, 40, 40], [200, 30, 30]);
    }
  },

  setDataLimitPeriodFillColor: function(value, fill, icsc ) {
    if(value == "r") {
      ss.setFillColor(fill, [250, 40, 40], [200, 30, 30]);
    } else if(value == "o") { 
      ss.setFillColor(fill, [255, 180, 80], [250, 150, 60]);
    } else {
      ss.setFillColor(fill, [100, 255, 100], [60, 200, 60]);
    }
  },
    
  setFillColor: function(fill, startColor, endColor) {
    
    if( fill.getClass().isAssignableFrom(GradientImpl)) {
      fill.setStartColor(ss.newColorDefinition(startColor));
      fill.setEndColor(ss.newColorDefinition(endColor));
    } else {
      fill.set(startColor[0], startColor[1], startColor[2]);
    }
  },
  
  newColorDefinition: function(rgbArray) {
    return ColorDefinitionImpl.create(rgbArray[0], rgbArray[1], rgbArray[2]);
  },
  
  incident: {
    resolveTypeCode: function(code) {
      return ss.resolveCode("IncidentType[" + code + "]");
    } 
  }

};

ss.users = function() {
	var usersById = undefined;
	var unknownUser = {
	  id: 0,
	  name: 'Unknown User',
	  dept_name: 'Unknown Dept'
	}
	
	function init() {
		if(usersById != undefined) {
			return;
		}
		usersById = {};
		if(ss.jdbcTemplate) {
		  	var results = ss.jdbcTemplate.queryForList("select "
				+ "u.id user_id, u.last_name, u.first_name, dept.name dep_name_or_null "
				+ "from sec_user u "
				+ "left join common_questions_option dept on u.department = dept.id "
			);
		  	var len = results.size();
		  	var i, user_id;
		  	for (i=0; i<len; i++) {
			  	row = results.get(i);
			  	user_id = String(row["user_id"]);
			  	usersById[user_id] = {
			  	  id: user_id,
			  	  name: row["last_name"] + ', ' + row["first_name"],
			  	  dept_name: ss.resolveDepartmentName(row["dep_name_or_null"])
			  	}
		  	}
		}
	}
	return { 
		findById: function(id) {
			init();
			return usersById[String(id)] || unknownUser;
		}
	  }
}();


function ssInit(reportContext) {
	ss.appCtx = reportContext.getAppContext().get("ss_springApplicationContext");
	ss.jdbcTemplate = ss.appCtx ? ss.appCtx.getBean("jdbcTemplate") : null;
	ss.messageSource = ss.appCtx ? ss.appCtx.getBean("messageSource") : null;
  ss.enviroMgrContextURL = reportContext.getAppContext().get("ss_contextURL") || "http://enviromanagerUrlNotResolved";
  ss.renderType = reportContext.getAppContext().get("ss_renderType");
}