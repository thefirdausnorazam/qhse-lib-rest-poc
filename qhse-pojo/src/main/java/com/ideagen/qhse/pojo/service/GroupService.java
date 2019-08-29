package com.ideagen.qhse.pojo.service;

import com.ideagen.qhse.pojo.dto.GroupDto;

public interface GroupService {
	
	GroupDto getGroupByName(String name);
	
	GroupDto getGroupById(Long id);

}
