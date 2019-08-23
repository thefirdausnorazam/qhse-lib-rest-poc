package com.ideagen.qhse.pojo.service;

import com.ideagen.qhse.pojo.dto.UserDto;

public interface UserService {

    UserDto getUser(String username);
    
    UserDto getUser(String username, Long domain);
    
    UserDto getUserById(String id);
    
    UserDto logon(String username, String password);
    
    UserDto logon(String username, String password, Long domain);

}
