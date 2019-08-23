package com.ideagen.qhse.rest.controller;

import com.ideagen.qhse.lib.rest.impl.userV2.UserServiceV2RequestMapping;
import com.ideagen.qhse.lib.versioned.UserServiceV2;
import com.ideagen.qhse.pojo.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(UserServiceV2RequestMapping.ROOT_MAPPING)
public class UserV2Controller implements UserServiceV2 {

    private final UserServiceV2 userServiceV2;

    @Autowired
    public UserV2Controller(UserServiceV2 userServiceV2) {
        this.userServiceV2 = userServiceV2;
    }

    @PostMapping(value = UserServiceV2RequestMapping.DELETE_USER,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public boolean deleteUser(String username) {
        return userServiceV2.deleteUser(username);
    }

    @PostMapping(value = UserServiceV2RequestMapping.GET_USER,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public UserDto getUser(String username) {
        return userServiceV2.getUser(username);
    }

    @PostMapping(value = UserServiceV2RequestMapping.GET_USER_2,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public UserDto getUser(String username, Long domain) {
        return userServiceV2.getUser(username, domain);
    }

    @PostMapping(value = UserServiceV2RequestMapping.GET_USER_BY_ID,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public UserDto getUserById(String id) {
        return userServiceV2.getUserById(id);
    }

    @PostMapping(value = UserServiceV2RequestMapping.LOGON,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public UserDto logon(String username, String password) {
        return userServiceV2.logon(username, password);
    }

    @PostMapping(value = UserServiceV2RequestMapping.LOGON_2,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public UserDto logon(String username, String password, Long domain) {
        return userServiceV2.logon(username, password, domain);
    }
}
