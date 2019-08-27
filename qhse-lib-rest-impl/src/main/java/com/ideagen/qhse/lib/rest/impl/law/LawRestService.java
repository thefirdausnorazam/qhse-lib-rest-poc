package com.ideagen.qhse.lib.rest.impl.law;

import com.ideagen.qhse.lib.rest.impl.RestService;
import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.pojo.law.TaskQueryCriteria;
import com.ideagen.qhse.pojo.service.LawService;

import java.util.Map;

public class LawRestService extends RestService implements LawService {

    protected LawRestService(Map<String, String> properties) {
        super(properties);
    }

    @Override
    public QueryResult queryTask(TaskQueryCriteria criteria) {
        return requestSingle(QueryResult.class, LawServiceRequestMapping.QUERY_TASK_FULL_PATH, criteria);
    }
}
