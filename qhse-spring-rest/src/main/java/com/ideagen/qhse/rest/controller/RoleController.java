package com.ideagen.qhse.rest.controller;

import com.ideagen.qhse.lib.rest.impl.role.RestServiceRequestMapping;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(RestServiceRequestMapping.ROOT_MAPPING)
public class RoleController implements RoleService {

    private final RoleService roleService;

    @Autowired
    public RoleController(RoleService roleService) {
        this.roleService = roleService;
    }

    @PostMapping(value = RestServiceRequestMapping.GET_ROLE_BY_NAME,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public RoleDto getRoleByName(@RequestParam String name) {
        return roleService.getRoleByName(name);
    }

    @PostMapping(value = RestServiceRequestMapping.GET_ROLE_BY_ID,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public RoleDto getRoleById(@RequestParam Long id) {
        return roleService.getRoleById(id);
    }
}
