package com.ideagen.qhse.lib.rest.impl.userV2;

import com.ideagen.qhse.lib.rest.impl.RestService;
import com.ideagen.qhse.lib.versioned.UserServiceV2;
import com.ideagen.qhse.pojo.dto.UserDto;
import org.springframework.util.LinkedMultiValueMap;

import java.util.Map;

public class UserRestServiceV2 extends RestService implements UserServiceV2 {

    UserRestServiceV2(Map<String, String> properties) {
        super(properties);
    }

    @Override
    public UserDto getUser(String username) {
        return requestSingle(UserDto.class, UserServiceV2RequestMapping.GET_USER_FULL_PATH, new LinkedMultiValueMap<>() {
            {
                add("username", username);
            }
        });
    }

    @Override
    public UserDto getUser(String username, Long domain) {
        return requestSingle(UserDto.class, UserServiceV2RequestMapping.GET_USER_2_FULL_PATH, new LinkedMultiValueMap<>() {
            {
                add("username", username);
                add("domain", domain);
            }
        });
    }

    @Override
    public UserDto getUserById(String id) {
        return requestSingle(UserDto.class, UserServiceV2RequestMapping.GET_USER_BY_ID_FULL_PATH, new LinkedMultiValueMap<>() {
            {
                add("id", id);
            }
        });
    }

    @Override
    public UserDto logon(String username, String password) {
        return requestSingle(UserDto.class, UserServiceV2RequestMapping.LOGON_FULL_PATH, new LinkedMultiValueMap<>() {
            {
                add("username", username);
                add("password", password);
            }
        });
    }

    @Override
    public UserDto logon(String username, String password, Long domain) {
        return requestSingle(UserDto.class, UserServiceV2RequestMapping.LOGON_2_FULL_PATH, new LinkedMultiValueMap<>() {
            {
                add("username", username);
                add("password", password);
                add("domain", domain);
            }
        });
    }

    @Override
    public boolean deleteUser(String username) {
        return requestSingle(Boolean.class, UserServiceV2RequestMapping.DELETE_USER_FULL_PATH, new LinkedMultiValueMap<>() {
            {
                add("username", username);
            }
        });
    }
}
