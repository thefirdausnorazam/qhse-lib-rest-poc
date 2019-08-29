package com.ideagen.qhse.pojo.service;

import java.util.List;

import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.pojo.dto.ProfileChecklistTaskDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.law.TaskQueryCriteria;

public interface LawService {
	
	QueryResult queryTask(TaskQueryCriteria criteria);
	
	List<UserDto> listOfLawTasksUsers(String siteName);
	
	ProfileChecklistTaskDto findTaskById(long id);

}
