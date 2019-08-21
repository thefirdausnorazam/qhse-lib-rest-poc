package com.ideagen.qhse.lib.rest.impl.domain;

import com.ideagen.qhse.pojo.service.DomainService;

public class DomainRestServiceFactory {

    public static DomainService getService(String restEndpoint){
        return new DomainRestService(restEndpoint);
    }
}
