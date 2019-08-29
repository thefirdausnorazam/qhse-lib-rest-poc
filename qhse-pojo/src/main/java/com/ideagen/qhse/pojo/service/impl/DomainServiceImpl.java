package com.ideagen.qhse.pojo.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;


import com.ideagen.qhse.orm.dao.impl.DomainDaoImpl;
import com.ideagen.qhse.orm.entity.Domain;
import com.ideagen.qhse.pojo.constants.CommonConstants;
import com.ideagen.qhse.pojo.dto.DomainDto;
import com.ideagen.qhse.pojo.service.DomainService;

public class DomainServiceImpl extends AbstractServiceImpl implements DomainService {
	
	private DomainDaoImpl domainDao;

    public DomainServiceImpl(Map<String, String> ormProperties) {
        domainDao = new DomainDaoImpl(ormProperties);
    }

	@Override
	public DomainDto getDomainById(Long id) {
		return domainDao.findById(id)
                .map(object -> domaintoDto(object))
                .orElse(null);
	}

	@Override
	public Collection<DomainDto> getAllDomains() {
		
		List<DomainDto> domains = new ArrayList<DomainDto>();
		
		for(Domain domain: domainDao.listAllDomains()) {
			
			domains.add(domaintoDto(domain));
		}
		
		return domains;
	}
	
	@Override
	public boolean isLDAPAuthentication(DomainDto domainDto) {
		return domainDto.getDiscriminator().equals(CommonConstants.LDAP_DISCRIMINATOR);
	}
	
	private DomainDto domaintoDto(Domain domain) {
		
		DomainDto domainDto = new DomainDto();
		
		abstractCopyProperties(domainDto, domain);
		
        return domainDto;
    }
	
	@Override
	public Collection<DomainDto> getDomainByName(String name) {
		
		List<DomainDto> domains = new ArrayList<DomainDto>();
		
		for(Domain domain: domainDao.findByName(name)) {
			
			domains.add(domaintoDto(domain));
		}
		
		return domains;
	}

}
