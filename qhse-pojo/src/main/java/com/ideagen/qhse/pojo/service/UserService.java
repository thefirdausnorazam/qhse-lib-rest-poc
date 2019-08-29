package com.ideagen.qhse.pojo.service;

import java.util.List;

import com.ideagen.qhse.pojo.dto.UserDto;

public interface UserService {

    UserDto getUser(String username);
    
    UserDto getUser(String username, Long domain);
    
    UserDto getUserById(Long id);
    
    UserDto logon(String username, String password);
    
    UserDto logon(String username, String password, Long domain);
    
    List<UserDto> listUsersByMultipleRoles(String groupName, List<String> roles);

}
