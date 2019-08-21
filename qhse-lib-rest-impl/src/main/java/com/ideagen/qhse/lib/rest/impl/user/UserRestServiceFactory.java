package com.ideagen.qhse.lib.rest.impl.user;

import com.ideagen.qhse.lib.rest.impl.user.UserRestService;
import com.ideagen.qhse.pojo.service.UserService;

public class UserRestServiceFactory {

    public static UserService getService(String restEndpoint) {
        return new UserRestService(restEndpoint);
    }
}
