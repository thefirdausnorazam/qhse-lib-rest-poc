package com.ideagen.qhse.pojo.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.ideagen.qhse.orm.dao.impl.UserDaoImpl;
import com.ideagen.qhse.orm.entity.Group;
import com.ideagen.qhse.orm.entity.Module;
import com.ideagen.qhse.orm.entity.Role;
import com.ideagen.qhse.orm.entity.User;
import com.ideagen.qhse.pojo.dto.DomainDto;
import com.ideagen.qhse.pojo.dto.GroupDto;
import com.ideagen.qhse.pojo.dto.ModuleDto;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.UserService;

public class UserServiceImpl extends AbstractServiceImpl implements UserService {

    private UserDaoImpl userDao;

    public UserServiceImpl(Map<String, String> ormProperties) {
    	userDao = new UserDaoImpl(ormProperties);
    }
    
    @Override
    public UserDto getUser(String username) {
        return userDao.findByUsername(username)
                .map(object -> usertoDto(object))
                .orElse(null);
    }
    
    @Override
    public UserDto getUser(String username, Long domain) {
        return userDao.findByUsername(username, domain)
                .map(user -> usertoDto(user))
                .orElse(null);
    }
    
    @Override
    public UserDto getUserById(Long id) {
        return userDao.findById(id)
                .map(object -> usertoDto(object))
                .orElse(null);
    }
    
    @Override
    public UserDto logon(String username, String password) {
    	
    	UserDto userDto = getUser(username);
    	
    	BCryptPasswordEncoder encode = new BCryptPasswordEncoder();
    	
    	if (userDto != null && encode.matches(password, userDto.getPassword()))
    		return userDto;
    	
    	return null;
    	
    }
    
    @Override
    public UserDto logon(String username, String password, Long domain) {
    	
    	UserDto userDto = getUser(username, domain);
    	
    	BCryptPasswordEncoder encode = new BCryptPasswordEncoder();
    	
    	if (userDto != null && encode.matches(password, userDto.getPassword()))
    		return userDto;
    	
    	return null;
    	
    }
    
    @Override
	public List<UserDto> listUsersByMultipleRoles(String groupName, List<String> roles) {
		
		List<UserDto> userDtos = new ArrayList<UserDto>();
		
		for(User user: userDao.listUsersByMultipleRoles(groupName, roles)) {
			UserDto userDto = usertoDto(user);
			userDtos.add(userDto);
		}
		
		return userDtos;
	}

    private UserDto usertoDto(User user) {
        
    	UserDto userDto = new UserDto();
    	List<RoleDto> roleDtos = new ArrayList<RoleDto>();
    	Set<GroupDto> groupDtos = new HashSet<GroupDto>();
    	Set<ModuleDto> moduleDtos = new HashSet<ModuleDto>();
        
    	abstractCopyProperties(userDto, user);
		//have to set this manually
		DomainDto domainDto = new DomainDto();
		abstractCopyProperties(domainDto, user.getDomain());
		userDto.setDomainDto(domainDto);
		
		for(Role role: user.getRoles()) {
			RoleDto roleDto = new RoleDto();
			abstractCopyProperties(roleDto, role);
			roleDtos.add(roleDto);
		}
		userDto.setRolesDto(roleDtos);
		
		for(Group group: user.getGroups()) {
			GroupDto groupDto = new GroupDto();
			abstractCopyProperties(groupDto, group);
			groupDtos.add(groupDto);
		}
		userDto.setGroupsDto(groupDtos);
		
		for(Module module: user.getModules()) {
			ModuleDto moduleDto = new ModuleDto();
			abstractCopyProperties(moduleDto, module);
			moduleDtos.add(moduleDto);
		}
		userDto.setModulesDto(moduleDtos);
			
        return userDto;
    }
    
}
