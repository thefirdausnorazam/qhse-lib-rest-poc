package com.ideagen.qhse.lib.rest.impl.role;

import com.ideagen.qhse.pojo.service.RoleService;

import java.util.Map;

public class RoleRestServiceFactory {

    public static RoleService getService(Map<String, String> properties) {
        return new RoleRestService(properties);
    }
}
