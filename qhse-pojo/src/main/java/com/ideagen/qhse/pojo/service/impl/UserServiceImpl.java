package com.ideagen.qhse.pojo.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManagerFactory;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.ideagen.qhse.orm.dao.impl.UserDaoImpl;
import com.ideagen.qhse.orm.entity.Role;
import com.ideagen.qhse.orm.entity.User;
import com.ideagen.qhse.pojo.dto.DomainDto;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.UserService;

public class UserServiceImpl implements UserService {

    private UserDaoImpl userDao;

    public UserServiceImpl(EntityManagerFactory entityManagerFactory) {
        userDao = new UserDaoImpl(entityManagerFactory);
    }

    public UserDto getUser(String username) {
        return userDao.findByUsername(username)
                .map(user -> usertoDto(user))
                .orElse(null);
    }
    
    public UserDto getUser(String username, Long domain) {
        return userDao.findByUsername(username, domain)
                .map(user -> usertoDto(user))
                .orElse(null);
    }
    
    public UserDto getUserById(String id) {
        return userDao.findById(id)
                .map(user -> usertoDto(user))
                .orElse(null);
    }

    private UserDto usertoDto(User user) {
        
    	UserDto userDto = new UserDto();
    	List<RoleDto> roleDtos = new ArrayList<RoleDto>(user.getRoles().size());
        
        try {
			BeanUtils.copyProperties(userDto, user);
			//have to set this manually
			DomainDto domainDto = new DomainDto();
			BeanUtils.copyProperties(domainDto, user.getDomain());
			userDto.setDomainDto(domainDto);
			
			for(Role role: user.getRoles()) {
				RoleDto roleDto = new RoleDto();
				BeanUtils.copyProperties(roleDto, role);
				roleDtos.add(roleDto);
			}
			
			userDto.setRolesDto(roleDtos);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
        
        return userDto;
    }
    
    public UserDto logon(String username, String password) {
    	
    	UserDto userDto = getUser(username);
    	
    	BCryptPasswordEncoder encode = new BCryptPasswordEncoder();
    	
    	if (userDto != null && encode.matches(password, userDto.getPassword()))
    		return userDto;
    	
    	return null;
    	
    }
    
    public UserDto logon(String username, String password, Long domain) {
    	
    	UserDto userDto = getUser(username, domain);
    	
    	BCryptPasswordEncoder encode = new BCryptPasswordEncoder();
    	
    	if (userDto != null && encode.matches(password, userDto.getPassword()))
    		return userDto;
    	
    	return null;
    	
    }
}
