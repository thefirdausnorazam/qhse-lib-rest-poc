package com.ideagen.qhse.orm.dao;

import java.util.List;
import java.util.Optional;

import com.ideagen.qhse.orm.entity.User;

public interface UserDao {
	
	Optional<User> findById(Long id);

    Optional<User> findByUsername(String username);
    
    Optional<User> findByUsername(String username, Long domain);
    
    List<User> listUsersByMultipleRoles(String groupName, List<String> roles);
    
}
