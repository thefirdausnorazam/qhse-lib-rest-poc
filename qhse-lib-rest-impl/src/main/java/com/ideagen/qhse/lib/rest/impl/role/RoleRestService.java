package com.ideagen.qhse.lib.rest.impl.role;

import com.ideagen.qhse.lib.rest.impl.RestService;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.service.RoleService;
import org.springframework.util.LinkedMultiValueMap;

public class RoleRestService extends RestService implements RoleService {

    RoleRestService(String restEndpoint) {
        super(restEndpoint);
    }

    @Override
    public RoleDto getRoleByName(String name) {
        return requestSingle(RoleDto.class, RestServiceRequestMapping.GET_ROLE_BY_NAME_FULL_PATH, new LinkedMultiValueMap<>() {
            {
                add("name", name);
            }
        });
    }

    @Override
    public RoleDto getRoleById(Long id) {
        return requestSingle(RoleDto.class, RestServiceRequestMapping.GET_ROLE_BY_ID_FULL_PATH, new LinkedMultiValueMap<>() {
            {
                add("id", id);
            }
        });
    }
}
