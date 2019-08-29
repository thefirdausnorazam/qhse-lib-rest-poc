package com.ideagen.qhse.pojo.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.ideagen.qhse.orm.dao.impl.RiskBusinessAreaDaoImpl;
import com.ideagen.qhse.orm.entity.RiskBusinessArea;
import com.ideagen.qhse.pojo.dto.RiskBusinessAreaDto;
import com.ideagen.qhse.pojo.service.RiskService;

public class RiskServiceImpl extends AbstractServiceImpl implements RiskService {
	
	private RiskBusinessAreaDaoImpl riskBusinessAreaDao;

    public RiskServiceImpl(Map<String, String> ormProperties) {
    	riskBusinessAreaDao = new RiskBusinessAreaDaoImpl(ormProperties);
    }
    
    @Override
	public RiskBusinessAreaDto getRiskById(Long id) {
		
    	return riskBusinessAreaDao.findById(id)
                .map(object -> riskBusinessAreatoDto(object))
                .orElse(null);
	}

	@Override
	public RiskBusinessAreaDto getRiskByName(String name) {
		
		return riskBusinessAreaDao.findByName(name)
                .map(object -> riskBusinessAreatoDto(object))
                .orElse(null);
	}

	@Override
	public List<RiskBusinessAreaDto> listActiveBusinessAreas() {
		
		List<RiskBusinessAreaDto> riskBusinessAreaDtos = new ArrayList<RiskBusinessAreaDto>();
		
		for(RiskBusinessArea riskBusinessArea: riskBusinessAreaDao.listActive()) {
			
			RiskBusinessAreaDto riskBusinessAreaDto = new RiskBusinessAreaDto();
			
			abstractCopyProperties(riskBusinessAreaDto, riskBusinessArea);
			
			riskBusinessAreaDtos.add(riskBusinessAreaDto);
		}
		
		return riskBusinessAreaDtos;
	}

	@Override
	public List<RiskBusinessAreaDto> listAllBusinessAreas() {
		
		List<RiskBusinessAreaDto> riskBusinessAreaDtos = new ArrayList<RiskBusinessAreaDto>();
		
		for(RiskBusinessArea riskBusinessArea: riskBusinessAreaDao.listAll()) {
			
			RiskBusinessAreaDto riskBusinessAreaDto = new RiskBusinessAreaDto();
			
			abstractCopyProperties(riskBusinessAreaDto, riskBusinessArea);
			
			riskBusinessAreaDtos.add(riskBusinessAreaDto);
		}
		
		return riskBusinessAreaDtos;
	}
	
	private RiskBusinessAreaDto riskBusinessAreatoDto(RiskBusinessArea riskBusinessArea) {
		
		RiskBusinessAreaDto riskBusinessAreaDto = new RiskBusinessAreaDto();
		
		abstractCopyProperties(riskBusinessAreaDto, riskBusinessArea);
		
		return riskBusinessAreaDto;
	}

}
