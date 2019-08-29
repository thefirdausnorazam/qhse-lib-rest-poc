package com.ideagen.qhse.pojo;

import java.util.Map;

import com.ideagen.qhse.orm.dao.HibernateTestDao;
import com.ideagen.qhse.orm.dao.impl.HibernateTestDaoImpl;
import com.ideagen.qhse.pojo.service.DomainService;
import com.ideagen.qhse.pojo.service.GroupService;
import com.ideagen.qhse.pojo.service.LawService;
import com.ideagen.qhse.pojo.service.ModuleService;
import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;
import com.ideagen.qhse.pojo.service.RiskService;
import com.ideagen.qhse.pojo.service.RoleService;
import com.ideagen.qhse.pojo.service.UserService;
import com.ideagen.qhse.pojo.service.impl.DomainServiceImpl;
import com.ideagen.qhse.pojo.service.impl.GroupServiceImpl;
import com.ideagen.qhse.pojo.service.impl.LawServiceImpl;
import com.ideagen.qhse.pojo.service.impl.ModuleServiceImpl;
import com.ideagen.qhse.pojo.service.impl.QuestionMaintenanceServiceImpl;
import com.ideagen.qhse.pojo.service.impl.RiskServiceImpl;
import com.ideagen.qhse.pojo.service.impl.RoleServiceImpl;
import com.ideagen.qhse.pojo.service.impl.UserServiceImpl;

public class QhseServiceFactory {
	
	public static HibernateTestDao getHibernateDaoTestService(Map<String, String> ormProperties) {
    	
    	HibernateTestDao hibernateTestDao = new HibernateTestDaoImpl(ormProperties);
    	
    	return hibernateTestDao;
    	
    }

    public static UserService getUserService(Map<String, String> ormProperties) {

        UserService userService = new UserServiceImpl(ormProperties);

        return userService;
    }
    
    public static DomainService getDomainService(Map<String, String> ormProperties) {
    	
    	DomainService domainService = new DomainServiceImpl(ormProperties);

        return domainService;
    }
    
    public static RoleService getRoleService(Map<String, String> ormProperties) {
    	
        RoleService roleService = new RoleServiceImpl(ormProperties);

        return roleService;
    }
    
    public static QuestionMaintenanceService getQuestionMaintenanceService(Map<String, String> ormProperties) {
    	
    	QuestionMaintenanceService questionMaintenanceService = new QuestionMaintenanceServiceImpl(ormProperties);
    	
    	return questionMaintenanceService;
    	
    }
    
    public static LawService getLawService(Map<String, String> ormProperties) {
    	
    	LawService lawService = new LawServiceImpl(ormProperties);
    	
    	return lawService;
    	
    }
    
    public static RiskService getRiskService(Map<String, String> ormProperties) {
    	
    	RiskService riskService = new RiskServiceImpl(ormProperties);
    	
    	return riskService;
    	
    }
    
    public static GroupService getGroupService(Map<String, String> ormProperties) {
    	
    	GroupService groupService = new GroupServiceImpl(ormProperties);
    	
    	return groupService;
    	
    }
    
    public static ModuleService getModuleService(Map<String, String> ormProperties) {
    	
    	ModuleService moduleService = new ModuleServiceImpl(ormProperties);
    	
    	return moduleService;
    	
    }
    
}
