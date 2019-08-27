package com.ideagen.qhse.service.rest.role.controller;

import com.ideagen.qhse.lib.rest.impl.role.RestServiceRequestMapping;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(RestServiceRequestMapping.ROOT_MAPPING)
public class RoleController implements RoleService {

    private final RoleService roleService;

    @Autowired
    public RoleController(RoleService roleService) {
        this.roleService = roleService;
    }

    @Override
    @PostMapping(value = RestServiceRequestMapping.GET_ROLE_BY_NAME,
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public RoleDto getRoleByName(String name) {
        return roleService.getRoleByName(name);
    }

    @Override
    @PostMapping(value = RestServiceRequestMapping.GET_ROLE_BY_ID,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public RoleDto getRoleById(Long id) {
        return roleService.getRoleById(id);
    }
}
