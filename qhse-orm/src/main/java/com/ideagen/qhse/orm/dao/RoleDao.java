package com.ideagen.qhse.orm.dao;

import java.util.Optional;

import com.ideagen.qhse.orm.entity.Role;

public interface RoleDao {
	
	Optional<Role> findById(Long id);

    Optional<Role> findByName(String name);

}
