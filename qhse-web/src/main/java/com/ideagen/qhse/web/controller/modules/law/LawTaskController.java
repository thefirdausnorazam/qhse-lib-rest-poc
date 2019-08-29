package com.ideagen.qhse.web.controller.modules.law;

import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.pojo.QhseServiceFactory;
import com.ideagen.qhse.pojo.dto.ProfileChecklistTaskDto;
import com.ideagen.qhse.pojo.dto.QuestionOptionDto;
import com.ideagen.qhse.pojo.law.TaskQueryCriteria;
import com.ideagen.qhse.pojo.service.LawService;
import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;
import com.ideagen.qhse.web.utils.datatable.DataTableRequest;
import com.ideagen.qhse.web.utils.datatable.DataTableResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
//@SessionAttributes("LAW_LAWTASK_SEARCH_CRITERIA")
public class LawTaskController {

    private LawService lawService;
    private QuestionMaintenanceService questionMaintenanceService;

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    public LawTaskController(Map<String, String> hibernateConfig) {
        logger.info("hibernate config : " + hibernateConfig);
        this.lawService = QhseServiceFactory.getLawService(hibernateConfig);
        this.questionMaintenanceService = QhseServiceFactory.getQuestionMaintenanceService(hibernateConfig);
    }

    @Autowired
    private MessageSource messageSource;

    @ModelAttribute("LAW_LAWTASK_SEARCH_CRITERIA")
    public TaskQueryCriteria getSearchCriteria() {
        return new TaskQueryCriteria();
    }

    @GetMapping("/law/lawTask")
    public String lawTask(Model model, Locale loc) {

        String title = messageSource.getMessage("lawTasks", null, loc);
        Map<String, Object> page = new HashMap<>();
        page.put("title", title);
        page.put("name", "lawTasks");


        List<QuestionOptionDto> departmentsList = this.questionMaintenanceService.listSearchableDepartments();
        List<Map<String,Object>> departments=new ArrayList<>();
        departmentsList.iterator().forEachRemaining(department->{
            Map<String,Object> option = new HashMap<>();
            option.put("id",department.getId());
            option.put("description",department.getDescription());
            departments.add(option);
        });

        page.put("departments",departments);

        model.addAttribute("page", page);

        return "page/law/lawTask";
    }

    @RequestMapping(value = "/law/lawTask/getColumns", method = RequestMethod.GET, produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
    public ResponseEntity<List<String>> getColumns() {
        List<String> columns = new ArrayList<>();

        columns.add("ID");
        columns.add("Description");
        columns.add("Status");
        columns.add("Department");
        columns.add("Profile Name");
        columns.add("User Responsibility");
        columns.add("Target Completion Date");

        return new ResponseEntity<>(columns, HttpStatus.OK);
    }

    @RequestMapping(value = "/law/lawTask/getRows", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE, produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
    public ResponseEntity<DataTableResponse> getRows(@RequestBody DataTableRequest request) {
        TaskQueryCriteria criteria = new TaskQueryCriteria();
        return new ResponseEntity<>(this.searchRows(request, criteria), HttpStatus.OK);
    }

    private DataTableResponse searchRows(DataTableRequest request, TaskQueryCriteria criteria) {
        Integer startIndex = request.getStart();
        Integer recordsPerPage = request.getLength();
        criteria.setPageSize(recordsPerPage);
        criteria.setPageNumber(((int) Math.ceil(startIndex / recordsPerPage)) + 1);
        QueryResult result = this.lawService.queryTask(criteria);


        DataTableResponse response = new DataTableResponse(request.getDraw(), result.getTotalResults(), result.getTotalResults());

        List<Object> viewModel = new ArrayList<>();
        result.getResults().iterator().forEachRemaining(data -> {
            List<String> model = new ArrayList<>();
            ProfileChecklistTaskDto dto = (ProfileChecklistTaskDto) data;
            model.add("LT" + dto.getId().toString());
            model.add(dto.getName());
            model.add(dto.getStatus());
            model.add(dto.getResponsibleDepartment().toString());
            model.add(String.valueOf(dto.getProfileId()));
            model.add(dto.getResponsibleUserDto().getName());
            model.add(dto.getTargetCompletionDate().toString());
            viewModel.add(model);
        });
        response.setData(viewModel);

        return response;
    }

}

