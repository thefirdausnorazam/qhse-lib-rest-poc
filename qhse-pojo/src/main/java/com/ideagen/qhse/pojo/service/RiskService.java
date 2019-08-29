package com.ideagen.qhse.pojo.service;

import java.util.List;

import com.ideagen.qhse.pojo.dto.RiskBusinessAreaDto;

public interface RiskService {
	
	RiskBusinessAreaDto getRiskById(Long id);
	
	RiskBusinessAreaDto getRiskByName(String name);
	
	/**
     * Get active RiskAssessment objects sorted by name (descending)
     *
     * @return non null List<RiskBusinessArea>
     */
    List<RiskBusinessAreaDto> listActiveBusinessAreas();
    
    /**
     * Get all RiskAssessment objects sorted by name (descending)
     *
     * @return non null List<RiskBusinessArea>
     */
    List<RiskBusinessAreaDto> listAllBusinessAreas();

}
