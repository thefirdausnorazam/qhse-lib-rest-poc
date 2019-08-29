package com.ideagen.qhse.orm.dao;

import java.util.Optional;

import com.ideagen.qhse.orm.entity.Group;

public interface GroupDao {
	
	Optional<Group> findById(Long id);

    Optional<Group> findByName(String name);

}
