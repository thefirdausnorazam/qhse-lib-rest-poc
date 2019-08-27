package com.ideagen.qhse.service.rest.law.controller;

import com.ideagen.qhse.lib.rest.impl.law.LawServiceRequestMapping;
import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.pojo.law.TaskQueryCriteria;
import com.ideagen.qhse.pojo.service.LawService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(LawServiceRequestMapping.ROOT_MAPPING)
public class LawController implements LawService {

    private final LawService lawService;

    @Autowired
    public LawController(LawService lawService) {
        this.lawService = lawService;
    }

    @Override
    @PostMapping(value = LawServiceRequestMapping.QUERY_TASK,
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public QueryResult queryTask(TaskQueryCriteria criteria) {
        return lawService.queryTask(criteria);
    }
}
