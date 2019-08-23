package com.ideagen.qhse.pojo.service.impl;

import java.lang.reflect.InvocationTargetException;

import javax.persistence.EntityManagerFactory;

import org.apache.commons.beanutils.BeanUtils;

import com.ideagen.qhse.orm.dao.impl.RoleDaoImpl;
import com.ideagen.qhse.orm.entity.Role;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.service.RoleService;

public class RoleServiceImpl implements RoleService {
	
	private RoleDaoImpl roleDao;

    public RoleServiceImpl(EntityManagerFactory entityManagerFactory) {
        roleDao = new RoleDaoImpl(entityManagerFactory);
    }

	@Override
	public RoleDto getRoleByName(String name) {
		
		return roleDao.findByName(name)
                .map(role -> roletoDto(role))
                .orElse(null);
	}

	@Override
	public RoleDto getRoleById(Long id) {
		
		return roleDao.findById(id)
                .map(role -> roletoDto(role))
                .orElse(null);
	}
	
	private RoleDto roletoDto(Role role) {
        
		RoleDto roleDto = new RoleDto();
        
        try {
			BeanUtils.copyProperties(roleDto, role);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
        
        return roleDto;
    }

}
