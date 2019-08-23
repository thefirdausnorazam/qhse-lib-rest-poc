package com.ideagen.qhse.pojo;

import java.util.Map;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import com.ideagen.qhse.pojo.service.DomainService;
import com.ideagen.qhse.pojo.service.RoleService;
import com.ideagen.qhse.pojo.service.UserService;
import com.ideagen.qhse.pojo.service.impl.DomainServiceImpl;
import com.ideagen.qhse.pojo.service.impl.RoleServiceImpl;
import com.ideagen.qhse.pojo.service.impl.UserServiceImpl;

public class QhseServiceFactory {

    private static final String PERSISTENCE_UNIT_NAME = "com.ideagen.qhse.pojo.persistance";

    public static UserService getUserService(Map<String, String> ormProperties) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME, ormProperties);

        UserService userService = new UserServiceImpl(entityManagerFactory);

//        QhseService qhseService = new QhseServiceImpl(userService, null);

        return userService;
    }
    
    public static DomainService getDomainService(Map<String, String> ormProperties) {
    	
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME, ormProperties);

        DomainService domainService = new DomainServiceImpl(entityManagerFactory);

        return domainService;
    }
    
    public static RoleService getRoleService(Map<String, String> ormProperties) {
    	
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME, ormProperties);

        RoleService roleService = new RoleServiceImpl(entityManagerFactory);

        return roleService;
    }

}
