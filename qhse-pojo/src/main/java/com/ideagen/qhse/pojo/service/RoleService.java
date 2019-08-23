package com.ideagen.qhse.pojo.service;

import com.ideagen.qhse.pojo.dto.RoleDto;

public interface RoleService {
	
	RoleDto getRoleByName(String name);
	
	RoleDto getRoleById(Long id);

}
