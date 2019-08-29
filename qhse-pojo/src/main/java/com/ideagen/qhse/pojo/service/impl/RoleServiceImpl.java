package com.ideagen.qhse.pojo.service.impl;

import java.util.Map;

import com.ideagen.qhse.orm.dao.impl.RoleDaoImpl;
import com.ideagen.qhse.orm.entity.Role;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.service.RoleService;

public class RoleServiceImpl extends AbstractServiceImpl implements RoleService {
	
	private RoleDaoImpl roleDao;

    public RoleServiceImpl(Map<String, String> ormProperties) {
        roleDao = new RoleDaoImpl(ormProperties);
    }

	@Override
	public RoleDto getRoleByName(String name) {
		
		return roleDao.findByName(name)
                .map(object -> roletoDto(object))
                .orElse(null);
	}

	@Override
	public RoleDto getRoleById(Long id) {
		
		return roleDao.findById(id)
                .map(object -> roletoDto(object))
                .orElse(null);
	}
	
	private RoleDto roletoDto(Role role) {
        
		RoleDto roleDto = new RoleDto();
        
		abstractCopyProperties(roleDto, role);
        
        return roleDto;
    }

}
