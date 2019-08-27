package com.ideagen.qhse.pojo.service;

import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.pojo.law.TaskQueryCriteria;

public interface LawService {
	
	QueryResult queryTask(TaskQueryCriteria criteria);

}
