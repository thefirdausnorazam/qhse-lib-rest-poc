package com.ideagen.qhse.lib.rest.impl.userV2;

import com.ideagen.qhse.lib.rest.impl.user.UserRestService;
import com.ideagen.qhse.pojo.service.UserService;

import java.util.Map;

public class UserRestServiceV2Factory {

    public static UserService getService(Map<String, String> properties) {
        return new UserRestServiceV2(properties);
    }
}
