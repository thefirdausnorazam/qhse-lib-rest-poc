package com.ideagen.qhse.pojo.service;

import java.util.List;

import com.ideagen.qhse.pojo.dto.QuestionOptionDto;

public interface QuestionMaintenanceService {
	
	public static final int DEPARTMENT_ID = 42;
	public static final int WORK_AREA_ID = 11001;
	public static final int LOCATION_ID = 64;
	
	QuestionOptionDto getQuestionOptionByName(String name);
	
	QuestionOptionDto getQuestionOptionById(Long id);
	
	public List<QuestionOptionDto> listSearchableDepartments(String siteName);

}
