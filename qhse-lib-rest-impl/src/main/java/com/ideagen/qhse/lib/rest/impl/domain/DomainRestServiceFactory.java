package com.ideagen.qhse.lib.rest.impl.domain;

import com.ideagen.qhse.pojo.service.DomainService;

import java.util.Map;

public class DomainRestServiceFactory {

    public static DomainService getService(Map<String, String> properties){
        return new DomainRestService(properties);
    }
}
