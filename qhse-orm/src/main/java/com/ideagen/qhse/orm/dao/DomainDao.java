package com.ideagen.qhse.orm.dao;

import java.util.Collection;
import java.util.Optional;

import com.ideagen.qhse.orm.entity.Domain;

public interface DomainDao {
	
	Optional<Domain> findById(Long id);
	
	Collection<Domain> listAllDomains();
	
	Collection<Domain> findByName(String name);

}
