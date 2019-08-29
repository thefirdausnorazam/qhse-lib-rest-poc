package com.ideagen.qhse.orm.dao;

import java.util.Optional;

import com.ideagen.qhse.orm.entity.Module;

public interface ModuleDao {
	
	Optional<Module> findById(Long id);

    Optional<Module> findByName(String name);

}
