package com.ideagen.qhse.service.rest.domain.controller;

import com.ideagen.qhse.lib.rest.impl.domain.DomainServiceRequestMapping;
import com.ideagen.qhse.pojo.dto.DomainDto;
import com.ideagen.qhse.pojo.service.DomainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collection;

@RestController
@RequestMapping(DomainServiceRequestMapping.ROOT_MAPPING)
public class DomainController implements DomainService {

    private final DomainService domainService;

    @Autowired
    public DomainController(DomainService domainService) {
        this.domainService = domainService;
    }

    @Override
    @PostMapping(value = DomainServiceRequestMapping.GET_DOMAIN_BY_ID,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public DomainDto getDomainById(Long id) {
        return domainService.getDomainById(id);
    }

    @Override
    @PostMapping(value = DomainServiceRequestMapping.GET_ALL_DOMAINS,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public Collection<DomainDto> getAllDomains() {
        return domainService.getAllDomains();
    }

    @Override
    @PostMapping(value = DomainServiceRequestMapping.IS_LDAP_AUTHENTICATION,
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public boolean isLDAPAuthentication(DomainDto domainDto) {
        return domainService.isLDAPAuthentication(domainDto);
    }

    @Override
    @PostMapping(value = DomainServiceRequestMapping.GET_DOMAIN_BY_NAME,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public Collection<DomainDto> getDomainByName(String name) {
        return domainService.getDomainByName(name);
    }
}
