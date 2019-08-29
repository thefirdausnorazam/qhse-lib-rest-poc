package com.ideagen.qhse.web.controller.modules.law;

import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.pojo.QhseServiceFactory;
import com.ideagen.qhse.pojo.dto.ProfileChecklistTaskDto;
import com.ideagen.qhse.pojo.dto.QuestionOptionDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.law.TaskQueryCriteria;
import com.ideagen.qhse.pojo.service.LawService;
import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LawTaskFormController {

    private LawService lawService;
    private QuestionMaintenanceService questionMaintenanceService;
    private static final String SEARCH_CRITERIA_SESSION_ATTRIBUTE = "LAW_TASK_SEARCH_CRITERIA";

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    public LawTaskFormController(Map<String, String> hibernateConfig) {
        logger.info("hibernate config : " + hibernateConfig);
        this.lawService = QhseServiceFactory.getLawService(hibernateConfig);
        this.questionMaintenanceService = QhseServiceFactory.getQuestionMaintenanceService(hibernateConfig);
    }

    @RequestMapping(value = "law/taskQueryForm.htm",method= RequestMethod.GET)
    public String taskQueryForm(Model model,HttpServletRequest request){

        List<QuestionOptionDto> departmentQuery = this.questionMaintenanceService.listSearchableDepartments();
        Map<String,Object> departments = new HashMap<>();
        List<Map<String,String>> departmentsList = new ArrayList<>();
        departmentQuery.iterator().forEachRemaining(department->{
            departmentsList.add(new HashMap<>(){{put("value",department.getId().toString());put("label",department.getDescription());}});
        });
        departments.put("list",departmentsList);

        // Populate form with placeholder from session
        TaskQueryCriteria criteria = (TaskQueryCriteria)request.getSession().getAttribute(SEARCH_CRITERIA_SESSION_ATTRIBUTE);
        if(criteria!=null) {
            departments.put("selected", (criteria.getDepartmentId() != null) ? criteria.getDepartmentId() : null);
        }

        model.addAttribute("departments",departments);
        return "law/taskQueryForm";
    }

    @RequestMapping(value = "law/taskQueryResult.htmf",method= RequestMethod.GET)
    public String taskQueryResult(Model model, HttpServletRequest request) throws ParseException {

        TaskQueryCriteria criteria = new TaskQueryCriteria();
        String excel =request.getParameter("excel");
        if(excel != null && excel.equalsIgnoreCase("YES")){
            criteria.setPageSize(0);
            criteria.setPageNumber(0);
        } else {
            criteria.setPageNumber(Integer.valueOf(request.getParameter("pageNumber")));
            criteria.setPageSize(Integer.valueOf(request.getParameter("pageSize")));
        }

        criteria.setCalculateTotals(true);

        if(!(request.getParameter("businessAreaId").isBlank()||request.getParameter("businessAreaId").isEmpty())) {
            criteria.setBusinessAreaId(Long.valueOf(request.getParameter("businessAreaId")));
        }
        criteria.setName(request.getParameter("name"));
        criteria.setType(request.getParameter("type"));

        if(!(request.getParameter("responsibleUser").isBlank()||request.getParameter("responsibleUser").isEmpty())) {
            UserDto responsibleUser = new UserDto();
            responsibleUser.setId(Long.valueOf(request.getParameter("responsibleUser")));
            criteria.setResponsibleUser(responsibleUser);
        }

        criteria.setStatus(request.getParameter("status"));
        criteria.setPriority(request.getParameter("priority"));

        if(!(request.getParameter("departmentId").isBlank()||request.getParameter("departmentId").isEmpty())) {
            criteria.setDepartmentId(Long.valueOf(request.getParameter("departmentId")));
        }

        if(!(request.getParameter("startDateFrom").isBlank()||request.getParameter("startDateFrom").isEmpty())) {
            criteria.setStartDateFrom(Date.valueOf(request.getParameter("startDateFrom")));
        }

        if(!(request.getParameter("startDateTo").isBlank()||request.getParameter("startDateTo").isEmpty())) {
            criteria.setStartDateTo(Date.valueOf(request.getParameter("startDateTo")));
        }

        if(!(request.getParameter("targetCompletionDateFrom").isBlank()||request.getParameter("targetCompletionDateFrom").isEmpty())) {
            criteria.setTargetCompletionDateFrom(Date.valueOf(request.getParameter("targetCompletionDateFrom")));
        }

        if(!(request.getParameter("targetCompletionDateTo").isBlank()||request.getParameter("targetCompletionDateTo").isEmpty())) {
            criteria.setTargetCompletionDateTo(Date.valueOf(request.getParameter("targetCompletionDateTo")));
        }

        if(!(request.getParameter("completionDateFrom").isBlank()||request.getParameter("completionDateFrom").isEmpty())) {
            criteria.setCompletionDateFrom(Date.valueOf(request.getParameter("completionDateFrom")));
        }

        if(!(request.getParameter("completionDateTo").isBlank()||request.getParameter("completionDateTo").isEmpty())) {
            criteria.setCompletionDateTo(Date.valueOf(request.getParameter("completionDateTo")));
        }

        if(!(request.getParameter("createdByUser").isBlank()||request.getParameter("createdByUser").isEmpty())) {
            UserDto createdByUser = new UserDto();
            createdByUser.setId(Long.valueOf(request.getParameter("createdByUser")));
            criteria.setCreatedByUser(createdByUser);
        }

        if(request.getParameter("_overdue")!=null) {
            if (!(request.getParameter("_overdue").isBlank() || request.getParameter("_overdue").isEmpty())) {
                criteria.setOverdue(Boolean.valueOf(request.getParameter("_overdue")));
            }
        }

        if(!(request.getParameter("sortName").isBlank()||request.getParameter("sortName").isEmpty())) {
            criteria.setSortName(request.getParameter("sortName"));
        }

        QueryResult query = this.lawService.queryTask(criteria);
        List<Map<String,Object>> results = new ArrayList<>();

        request.getSession().setAttribute(SEARCH_CRITERIA_SESSION_ATTRIBUTE,criteria);
        model.addAttribute("showSiteColumn",false);
        model.addAttribute("result",query);

        return "law/taskQueryResult";
    }
}
