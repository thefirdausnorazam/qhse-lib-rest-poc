package com.ideagen.qhse.pojo.service;

import com.ideagen.qhse.pojo.dto.ModuleDto;

public interface ModuleService {
	
	ModuleDto getModuleByName(String name);
	
	ModuleDto getModuleById(Long id);

}
