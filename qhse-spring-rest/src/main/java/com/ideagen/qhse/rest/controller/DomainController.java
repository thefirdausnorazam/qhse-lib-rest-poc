package com.ideagen.qhse.rest.controller;

import com.ideagen.qhse.lib.rest.impl.domain.DomainServiceRequestMapping;
import com.ideagen.qhse.pojo.dto.DomainDto;
import com.ideagen.qhse.pojo.service.DomainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;

@RestController
@RequestMapping(DomainServiceRequestMapping.ROOT_MAPPING)
public class DomainController implements DomainService {

    private final DomainService domainService;

    @Autowired
    public DomainController(DomainService domainService) {
        this.domainService = domainService;
    }

    @PostMapping(value = DomainServiceRequestMapping.GET_DOMAIN_BY_ID,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public DomainDto getDomainById(@RequestParam Long id){
        return domainService.getDomainById(id);
    }

    @PostMapping(value = DomainServiceRequestMapping.GET_ALL_DOMAINS,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public Collection<DomainDto> getAllDomains() {
        return domainService.getAllDomains();
    }


    @PostMapping(value = DomainServiceRequestMapping.IS_LDAP_AUTHENTICATION,
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public boolean isLDAPAuthentication(@RequestBody DomainDto domainDto){
        return domainService.isLDAPAuthentication(domainDto);
    }

    @PostMapping(value = DomainServiceRequestMapping.GET_DOMAIN_BY_NAME,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public Collection<DomainDto> getDomainByName(@RequestParam String name){
        return domainService.getDomainByName(name);
    }
}
