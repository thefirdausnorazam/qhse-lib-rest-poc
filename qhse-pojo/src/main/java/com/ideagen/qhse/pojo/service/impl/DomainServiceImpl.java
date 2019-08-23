package com.ideagen.qhse.pojo.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.EntityManagerFactory;

import org.apache.commons.beanutils.BeanUtils;

import com.ideagen.qhse.orm.dao.impl.DomainDaoImpl;
import com.ideagen.qhse.orm.entity.Domain;
import com.ideagen.qhse.pojo.constants.CommonConstants;
import com.ideagen.qhse.pojo.dto.DomainDto;
import com.ideagen.qhse.pojo.service.DomainService;

public class DomainServiceImpl implements DomainService {
	
	private DomainDaoImpl domainDao;

    public DomainServiceImpl(EntityManagerFactory entityManagerFactory) {
        domainDao = new DomainDaoImpl(entityManagerFactory);
    }

	@Override
	public DomainDto getDomainById(Long id) {
		return domainDao.findById(id)
                .map(domain -> domaintoDto(domain))
                .orElse(null);
	}

	@Override
	public Collection<DomainDto> getAllDomains() {
		
		List<DomainDto> domains = new ArrayList<DomainDto>(domainDao.listAllDomains().size());
		
		for(Domain domain: domainDao.listAllDomains()) {
			
			DomainDto domainDto = new DomainDto();
			
			try {
				BeanUtils.copyProperties(domainDto, domain);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
			
			domains.add(domainDto);
		}
		
		return domains;
	}
	
	@Override
	public boolean isLDAPAuthentication(DomainDto domainDto) {
		return domainDto.getDiscriminator().equals(CommonConstants.LDAP_DISCRIMINATOR);
	}
	
	private DomainDto domaintoDto(Domain domain) {
		
		DomainDto domainDto = new DomainDto();
		
		try {
			BeanUtils.copyProperties(domainDto, domain);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
        return domainDto;
    }
	
	@Override
	public Collection<DomainDto> getDomainByName(String name) {
		
		List<DomainDto> domains = new ArrayList<DomainDto>(domainDao.findByName(name).size());
		
		for(Domain domain: domainDao.findByName(name)) {
			
			DomainDto domainDto = new DomainDto();
			
			try {
				BeanUtils.copyProperties(domainDto, domain);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
			
			domains.add(domainDto);
		}
		
		return domains;
	}

}
