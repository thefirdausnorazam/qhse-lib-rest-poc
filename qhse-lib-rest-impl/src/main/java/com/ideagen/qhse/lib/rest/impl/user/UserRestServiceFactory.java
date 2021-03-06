package com.ideagen.qhse.lib.rest.impl.user;

import com.ideagen.qhse.lib.rest.impl.user.UserRestService;
import com.ideagen.qhse.pojo.service.UserService;

import java.util.Map;

public class UserRestServiceFactory {

    public static UserService getService(Map<String, String> properties) {
        return new UserRestService(properties);
    }
}
