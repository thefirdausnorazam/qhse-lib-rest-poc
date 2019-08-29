package com.ideagen.qhse.pojo.service.impl;

import java.util.Map;

import com.ideagen.qhse.orm.dao.impl.ModuleDaoImpl;
import com.ideagen.qhse.orm.entity.Module;
import com.ideagen.qhse.pojo.dto.ModuleDto;
import com.ideagen.qhse.pojo.service.ModuleService;

public class ModuleServiceImpl extends AbstractServiceImpl implements ModuleService {
	
	private ModuleDaoImpl moduleDao;

    public ModuleServiceImpl(Map<String, String> ormProperties) {
    	moduleDao = new ModuleDaoImpl(ormProperties);
    }

	@Override
	public ModuleDto getModuleByName(String name) {
		
		return moduleDao.findByName(name)
                .map(object -> moduletoDto(object))
                .orElse(null);
	}

	@Override
	public ModuleDto getModuleById(Long id) {
		
		return moduleDao.findById(id)
                .map(object -> moduletoDto(object))
                .orElse(null);
	}
	
	private ModuleDto moduletoDto(Module module) {
        
		ModuleDto moduleDto = new ModuleDto();
        abstractCopyProperties(moduleDto, module);
        
        return moduleDto;
    }

}
