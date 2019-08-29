package com.ideagen.qhse.pojo.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.ideagen.qhse.orm.entity.AbstractEntity;
import com.ideagen.qhse.orm.entity.Role;
import com.ideagen.qhse.pojo.dto.AbstractDto;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.dto.UserDto;

public class AbstractServiceImpl {

	protected void abstractCopyProperties(AbstractDto dto, AbstractEntity entity) {

		UserDto createdDto = new UserDto();
		UserDto updatedDto = new UserDto();
		List<RoleDto> roleDtos = new ArrayList<RoleDto>();

		try {

			BeanUtils.copyProperties(dto, entity);

			if (entity.getCreatedByUser() != null) {
				BeanUtils.copyProperties(createdDto, entity.getCreatedByUser());
				dto.setCreatedByUserDto(createdDto);
				
				for(Role role: entity.getCreatedByUser().getRoles()) {
					RoleDto roleDto = new RoleDto();
					BeanUtils.copyProperties(roleDto, role);
					roleDtos.add(roleDto);
				}
				
				dto.getCreatedByUserDto().setRolesDto(roleDtos);

			}

			if (entity.getLastUpdatedByUser() != null) {
				BeanUtils.copyProperties(updatedDto, entity.getLastUpdatedByUser());
				dto.setLastUpdatedByUserDto(updatedDto);
			}

		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}

	}
	
	protected void abstractReverseCopyProperties(AbstractEntity entity, AbstractDto dto) {
		
		try {
			
			BeanUtils.copyProperties(entity, dto);
			
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}

}
