package com.ideagen.qhse.lib.rest.impl.role;

import com.ideagen.qhse.pojo.service.RoleService;

public class RoleRestServiceFactory {

    public static RoleService getService(String restEndpoint) {
        return new RoleRestService(restEndpoint);
    }
}
