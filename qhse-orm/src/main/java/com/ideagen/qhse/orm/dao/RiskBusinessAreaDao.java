package com.ideagen.qhse.orm.dao;

import java.util.List;
import java.util.Optional;

import com.ideagen.qhse.orm.entity.RiskBusinessArea;

public interface RiskBusinessAreaDao {
	
	Optional<RiskBusinessArea> findByName(String name);
	
	Optional<RiskBusinessArea> findById(Long id);
	
	List<RiskBusinessArea> listActive();
	
	List<RiskBusinessArea> listAll();

}
