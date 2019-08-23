package com.ideagen.qhse.lib.rest.impl.domain;

import com.ideagen.qhse.lib.rest.impl.RestService;
import com.ideagen.qhse.pojo.dto.DomainDto;
import com.ideagen.qhse.pojo.service.DomainService;
import org.springframework.util.LinkedMultiValueMap;

import java.util.Collection;
import java.util.Map;

public class DomainRestService extends RestService implements DomainService {

    DomainRestService(Map<String, String> properties) {
        super(properties);
    }

    @Override
    public DomainDto getDomainById(Long id) {
        return requestSingle(DomainDto.class, DomainServiceRequestMapping.GET_DOMAIN_BY_ID_FULL_PATH, new LinkedMultiValueMap<>() {
            {
                add("id", id);
            }
        });
    }

    @Override
    public Collection<DomainDto> getAllDomains() {
        return requestCollection(DomainDto.class, DomainServiceRequestMapping.GET_ALL_DOMAINS_FULL_PATH);
    }

    @Override
    public boolean isLDAPAuthentication(DomainDto domainDto) {
        return requestSingle(Boolean.class, DomainServiceRequestMapping.IS_LDAP_AUTHENTICATION_FULL_PATH, domainDto);
    }

    @Override
    public Collection<DomainDto> getDomainByName(String name) {
        return requestCollection(DomainDto.class, DomainServiceRequestMapping.GET_DOMAIN_BY_NAME_FULL_PATH, new LinkedMultiValueMap<>() {
            {
                add("name", name);
            }
        });
    }
}
