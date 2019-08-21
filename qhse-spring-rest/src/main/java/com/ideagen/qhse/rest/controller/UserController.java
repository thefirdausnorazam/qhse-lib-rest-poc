package com.ideagen.qhse.rest.controller;

import com.ideagen.qhse.lib.rest.impl.user.UserServiceRequestMapping;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(UserServiceRequestMapping.ROOT_MAPPING)
public class UserController implements UserService {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping(value = UserServiceRequestMapping.GET_USER,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public UserDto getUser(@RequestParam String username) {
        return userService.getUser(username);
    }

    @PostMapping(value = UserServiceRequestMapping.GET_USER_2,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public UserDto getUser(@RequestParam String username, @RequestParam Long domain) {
        return userService.getUser(username, domain);
    }

    @PostMapping(value = UserServiceRequestMapping.GET_USER_BY_ID,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public UserDto getUserById(@RequestParam String id) {
        return userService.getUserById(id);
    }

    @PostMapping(value = UserServiceRequestMapping.LOGON,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public UserDto logon(@RequestParam String username, @RequestParam String password) {
        return userService.logon(username, password);
    }

    @PostMapping(value = UserServiceRequestMapping.LOGON_2,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public UserDto logon(@RequestParam String username, @RequestParam String password, @RequestParam Long domain) {
        return userService.logon(username, password, domain);
    }
}
