package com.ideagen.qhse.orm.dao;

import java.util.Optional;

import com.ideagen.qhse.orm.entity.ProfileChecklistTask;

public interface ProfileChecklistTaskDao {
	
	Optional<ProfileChecklistTask> findById(Long id);

    Optional<ProfileChecklistTask> findByName(String name);

}
