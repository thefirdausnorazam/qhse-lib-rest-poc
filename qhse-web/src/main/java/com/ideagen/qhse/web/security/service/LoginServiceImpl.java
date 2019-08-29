package com.ideagen.qhse.web.security.service;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;

import com.ideagen.qhse.web.security.QhseCustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.ideagen.qhse.pojo.QhseServiceFactory;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.UserService;

@Service
public class LoginServiceImpl implements LoginService {
	
	private UserService userService;

    @Autowired
    public LoginServiceImpl(Map<String, String> hibernateConfig) {
        this.userService = QhseServiceFactory.getUserService(hibernateConfig);
    }

	@Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
        if (StringUtils.isEmpty(username)) {
            throw new UsernameNotFoundException("Username and domain must be provided");
        }
        
		UserDto user = userService.getUser(username);
        
        if (user == null){
            throw new UsernameNotFoundException("Invalid username or password.");
        }
        
        return new QhseCustomUserDetails(user.getUsername(),
                user.getPassword(), user.getDomainDto(),
                mapRolesToAuthorities(user.getRolesDto()));
    }
	
	private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Collection<RoleDto> roles){
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority(role.getName()))
                .collect(Collectors.toList());
    }

}
