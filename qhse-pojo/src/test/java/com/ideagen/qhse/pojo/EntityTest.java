package com.ideagen.qhse.pojo;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.ideagen.qhse.pojo.constants.CommonConstants;
import com.ideagen.qhse.pojo.dto.DomainDto;
import com.ideagen.qhse.pojo.dto.GroupDto;
import com.ideagen.qhse.pojo.dto.ModuleDto;
import com.ideagen.qhse.pojo.dto.QuestionOptionDto;
import com.ideagen.qhse.pojo.dto.RiskBusinessAreaDto;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.DomainService;
import com.ideagen.qhse.pojo.service.GroupService;
import com.ideagen.qhse.pojo.service.ModuleService;
import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;
import com.ideagen.qhse.pojo.service.RiskService;
import com.ideagen.qhse.pojo.service.RoleService;
import com.ideagen.qhse.pojo.service.UserService;

public class EntityTest {
	
	UserService userService;
	DomainService domainService;
	RoleService roleService;
	QuestionMaintenanceService questionMaintenanceService;
	RiskService riskService;
	GroupService groupService;
	ModuleService moduleService;
	Map<String, String> ormProperties;
	
	@Before
	public void setUp() {
		ormProperties = new HashMap<String, String>() {
            /**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			{
                /*put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
                put("hibernate.hbm2ddl.auto", "");
                put("hibernate.show_sql", "false");
                put("javax.persistence.jdbc.driver", "com.mysql.cj.jdbc.Driver");
                put("javax.persistence.jdbc.url", "jdbc:mysql://localhost:3306/qhse_test?serverTimezone=Asia/Kuala_Lumpur");
                put("javax.persistence.jdbc.user", "root");
                put("javax.persistence.jdbc.password", "p@ssw0rd");*/
				put("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
				put("hibernate.connection.url", "jdbc:mysql://localhost:3306/qhse_test?serverTimezone=Asia/Kuala_Lumpur");
				put("hibernate.connection.username", "root");
				put("hibernate.connection.password", "root");
				put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
				put("hibernate.hbm2ddl.auto", "");
				//put("hibernate.show_sql", "true");
            }
        };
        
        //userService = QhseServiceFactory.getUserService(ormProperties);
        //domainService = QhseServiceFactory.getDomainService(ormProperties);
        //roleService = QhseServiceFactory.getRoleService(ormProperties);
        //questionMaintenanceService = QhseServiceFactory.getQuestionMaintenanceService(ormProperties);
	}
	
	@Test
	public void testUser() {
		userService = QhseServiceFactory.getUserService(ormProperties);
		assertNotNull(userService);
		
		// search user by name
		UserDto user = userService.getUser("demo");
		assertNotNull(user);
		assertTrue(user.getFirstName().equals("demo"));
		assertNotNull(user.getDomainDto());
		// check user role
		assertNotNull(user.getRolesDto());
		assertTrue(user.getRolesDto().size() == 1);
		// check for groups
		assertTrue(user.getGroupsDto().size() == 4);
		
		userService = QhseServiceFactory.getUserService(ormProperties);
		user = userService.getUser("administrator");
		assertNotNull(user);
		assertTrue(user.getFirstName().equals("System"));
		assertNotNull(user.getDomainDto());
		// check user role
		assertNotNull(user.getRolesDto());
		assertTrue(user.getRolesDto().size() == 10);
		
		// search user by name and domain id
		userService = QhseServiceFactory.getUserService(ormProperties);
		user = userService.getUser("demo", 1L);
		assertNotNull(user);
		assertTrue(user.getFirstName().equals("demo"));
		assertNotNull(user.getDomainDto());
		assertNotNull(user.getRolesDto());
		assertTrue(user.getRolesDto().size() == 1);
		
		//search user by id
		userService = QhseServiceFactory.getUserService(ormProperties);
		user = userService.getUserById(user.getId());
		assertNotNull(user);
		assertTrue(user.getFirstName().equals("demo"));
		assertNotNull(user.getDomainDto());
		assertNotNull(user.getRolesDto());
		assertTrue(user.getRolesDto().size() == 1);
		
		//check for modules
		userService = QhseServiceFactory.getUserService(ormProperties);
		user = userService.getUserById(4L);
		assertNotNull(user);
		assertNotNull(user.getModulesDto());
		assertTrue(user.getModulesDto().size() == 8);
	}
	
	@Test
	public void testDomain() {
		domainService = QhseServiceFactory.getDomainService(ormProperties);
		assertNotNull(domainService);
		
		// search domain by id.
		DomainDto domainDto = domainService.getDomainById(1L);
		assertNotNull(domainDto);
		assertTrue(domainDto.getDiscriminator().equals(CommonConstants.INTERNAL_DISCRIMINATOR));
		assertTrue(domainDto.getName().equals("Q-Pulse"));
		// check is LDAP authentication
		assertFalse(domainService.isLDAPAuthentication(domainDto));
		
		domainService = QhseServiceFactory.getDomainService(ormProperties);
		domainDto = domainService.getDomainById(2L);
		assertNotNull(domainDto);
		assertTrue(domainDto.getDiscriminator().equals(CommonConstants.LDAP_DISCRIMINATOR));
		assertTrue(domainDto.getName().equals("L-LDAP"));
		// check is LDAP authentication
		assertTrue(domainService.isLDAPAuthentication(domainDto));
		
		// get all domains
		domainService = QhseServiceFactory.getDomainService(ormProperties);
		Collection<DomainDto> domains = domainService.getAllDomains();
		assertFalse(domains.isEmpty());
		assertTrue(domains.size() == 2);
		
		// get domain by name
		domainService = QhseServiceFactory.getDomainService(ormProperties);
		domains = domainService.getDomainByName("Q-Pulse");
		assertFalse(domains.isEmpty());
		assertTrue(domains.size() == 1);
		
		domainService = QhseServiceFactory.getDomainService(ormProperties);
		domains = domainService.getDomainByName("L-LDAP");
		assertFalse(domains.isEmpty());
		assertTrue(domains.size() == 1);
		
	}
	
	@Test
	public void testRole() {
		roleService = QhseServiceFactory.getRoleService(ormProperties);
		assertNotNull(roleService);
		
		//search by id
		RoleDto roleDto = roleService.getRoleById(1L);
		assertNotNull(roleDto);
		assertTrue(roleDto.getName().equals(CommonConstants.ROLE_LAW));
		
		//search by name
		roleService = QhseServiceFactory.getRoleService(ormProperties);
		roleDto = roleService.getRoleByName(CommonConstants.ROLE_AUDIT);
		assertNotNull(roleDto);
		assertTrue(roleDto.getName().equals(CommonConstants.ROLE_AUDIT));
	}
	
	@Test
	public void testQuestionOption() {
		questionMaintenanceService = QhseServiceFactory.getQuestionMaintenanceService(ormProperties);
		assertNotNull(questionMaintenanceService);
		
		//search by id
		QuestionOptionDto questionOptionDto = questionMaintenanceService.getQuestionOptionById(1L);
		assertNotNull(questionOptionDto);
		assertTrue(questionOptionDto.getName().equals("Africa"));
		assertTrue(questionOptionDto.getOptionOrder() == 10);
		assertTrue(questionOptionDto.getVersion() == 2);
		assertNotNull(questionOptionDto.getCreatedByUserDto());
		assertTrue(questionOptionDto.getCreatedByUserDto().getFirstName().equals("System"));
		
		//search by name
		questionMaintenanceService = QhseServiceFactory.getQuestionMaintenanceService(ormProperties);
		questionOptionDto = questionMaintenanceService.getQuestionOptionByName("European Union");
		assertNotNull(questionOptionDto);
		assertTrue(questionOptionDto.getOptionOrder() == 40);
		assertTrue(questionOptionDto.getVersion() == 1);
		assertTrue(questionOptionDto.getId() == 3);
		assertTrue(questionOptionDto.getCreatedByUserDto().getFirstName().equals("System"));
	}
	
	@Test
	public void testRiskBusinessArea() {
		riskService = QhseServiceFactory.getRiskService(ormProperties);
		assertNotNull(riskService);
		
		//search by id
		RiskBusinessAreaDto riskBusinessAreaDto = riskService.getRiskById(1L);
		assertNotNull(riskBusinessAreaDto);
		assertTrue(riskBusinessAreaDto.getName().equals("Environmental"));
		assertNotNull(riskBusinessAreaDto.getCreatedByUserDto());
		assertTrue(riskBusinessAreaDto.getCreatedByUserDto().getFirstName().equals("System"));
		
		//search by name
		riskService = QhseServiceFactory.getRiskService(ormProperties);
		riskBusinessAreaDto = riskService.getRiskByName("Business");
		assertNotNull(riskBusinessAreaDto);
		assertTrue(riskBusinessAreaDto.getId().intValue() == 3L);
		assertNotNull(riskBusinessAreaDto.getCreatedByUserDto());
		assertTrue(riskBusinessAreaDto.getCreatedByUserDto().getFirstName().equals("System"));
	}
	
	@Test
	public void testGroup() {
		groupService = QhseServiceFactory.getGroupService(ormProperties);
		assertNotNull(groupService);
		
		//search by id
		GroupDto groupDto = groupService.getGroupById(1L);
		assertNotNull(groupDto);
		assertTrue(groupDto.getName().equals("All Users"));
		assertNotNull(groupDto.getSiteDto());
		assertTrue(groupDto.getSiteDto().getName().equals("1-Demo"));
		
		//search by name
		groupService = QhseServiceFactory.getGroupService(ormProperties);
		groupDto = groupService.getGroupByName("Atlantic Ballina");
		assertNotNull(groupDto);
		assertTrue(groupDto.getId().longValue() == 8L);
		assertNotNull(groupDto.getSiteDto());
		assertTrue(groupDto.getSiteDto().getName().equals("1-Demo"));
		
		
	}
	
	@Test
	public void testModule( ) {
		moduleService = QhseServiceFactory.getModuleService(ormProperties);
		assertNotNull(moduleService);
		
		//search by id
		ModuleDto moduleDto = moduleService.getModuleById(1L);
		assertNotNull(moduleDto);
		assertTrue(moduleDto.getName().equals("LAW"));
		
		//search by name
		moduleService = QhseServiceFactory.getModuleService(ormProperties);
		moduleDto = moduleService.getModuleByName("DOCCONTROL");
		assertNotNull(moduleDto);
		assertTrue(moduleDto.getId().longValue() == 11L);
		assertTrue(moduleDto.getName().equals("DOCCONTROL"));
		assertTrue(moduleDto.getCode().equals("doccontrol"));
	}
	
}
