package com.ideagen.qhse.service.rest.question.maintainance.controller;

import com.ideagen.qhse.lib.rest.impl.domain.DomainServiceRequestMapping;
import com.ideagen.qhse.lib.rest.impl.question.maintainance.QuestionMaintainanceServiceRequestMapping;
import com.ideagen.qhse.pojo.dto.QuestionOptionDto;
import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping(QuestionMaintainanceServiceRequestMapping.ROOT_MAPPING)
public class QuestionMaintenanceController implements QuestionMaintenanceService {

    private final QuestionMaintenanceService questionMaintenanceService;

    @Autowired
    public QuestionMaintenanceController(QuestionMaintenanceService questionMaintenanceService) {
        this.questionMaintenanceService = questionMaintenanceService;
    }

    @Override
    @PostMapping(value = QuestionMaintainanceServiceRequestMapping.GET_QUESTION_OPTION_BY_NAME,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public QuestionOptionDto getQuestionOptionByName(String name) {
        return questionMaintenanceService.getQuestionOptionByName(name);
    }

    @Override
    @PostMapping(value = QuestionMaintainanceServiceRequestMapping.GET_QUESTION_OPTION_BY_ID,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public QuestionOptionDto getQuestionOptionById(Long id) {
        return questionMaintenanceService.getQuestionOptionById(id);
    }

    @Override
    @PostMapping(value = QuestionMaintainanceServiceRequestMapping.LIST_SEARCHABLE_DEPARTMENT,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public List<QuestionOptionDto> listSearchableDepartments() {
        return questionMaintenanceService.listSearchableDepartments();
    }
}
