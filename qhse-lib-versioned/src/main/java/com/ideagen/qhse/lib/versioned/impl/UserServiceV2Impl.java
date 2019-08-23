package com.ideagen.qhse.lib.versioned.impl;

import com.ideagen.qhse.lib.versioned.UserServiceV2;
import com.ideagen.qhse.pojo.QhseServiceFactory;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.UserService;

import java.util.Map;

public class UserServiceV2Impl implements UserServiceV2 {

    private UserService userService;

    public UserServiceV2Impl(Map<String, String> properties) {
        this.userService = QhseServiceFactory.getUserService(properties);
    }

    public boolean deleteUser(String username) {
        return true;
    }

    public UserDto getUser(String username) {
        return userService.getUser(username);
    }

    public UserDto getUser(String username, Long domain) {
        return userService.getUser(username, domain);
    }

    public UserDto getUserById(String id) {
        return userService.getUserById(id);
    }

    public UserDto logon(String username, String password) {
        return userService.logon(username, password);
    }

    public UserDto logon(String username, String password, Long domain) {
        return userService.logon(username, password, domain);
    }
}
