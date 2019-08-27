package com.ideagen.qhse.pojo.service;

import java.util.Collection;

import com.ideagen.qhse.pojo.dto.DomainDto;

public interface DomainService {
	
	DomainDto getDomainById(Long id);
	
	Collection<DomainDto> getAllDomains();
	
	boolean isLDAPAuthentication(DomainDto domainDto);
	
	Collection<DomainDto> getDomainByName(String name);

}
