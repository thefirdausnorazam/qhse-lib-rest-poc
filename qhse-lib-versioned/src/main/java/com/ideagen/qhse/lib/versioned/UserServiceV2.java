package com.ideagen.qhse.lib.versioned;

import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.UserService;

public interface UserServiceV2 extends UserService {

    boolean deleteUser(String username);
}
