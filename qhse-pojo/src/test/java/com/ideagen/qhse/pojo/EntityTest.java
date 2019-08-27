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
import com.ideagen.qhse.pojo.dto.QuestionOptionDto;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.DomainService;
import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;
import com.ideagen.qhse.pojo.service.RoleService;
import com.ideagen.qhse.pojo.service.UserService;

public class EntityTest {
	
	UserService userService;
	DomainService domainService;
	RoleService roleService;
	QuestionMaintenanceService questionMaintenanceService;
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
            }
        };
        
        userService = QhseServiceFactory.getUserService(ormProperties);
        domainService = QhseServiceFactory.getDomainService(ormProperties);
        roleService = QhseServiceFactory.getRoleService(ormProperties);
        questionMaintenanceService = QhseServiceFactory.getQuestionMaintenanceService(ormProperties);
	}
	
	@Test
	public void testUser() {
		assertNotNull(userService);
		
		// search user by name
		UserDto user = userService.getUser("demo");
		assertNotNull(user);
		assertTrue(user.getName().equals("demo"));
		assertNotNull(user.getDomainDto());
		// check user role
		assertNotNull(user.getRolesDto());
		assertTrue(user.getRolesDto().size() == 1);
		
		userService = QhseServiceFactory.getUserService(ormProperties);
		user = userService.getUser("admin");
		assertNotNull(user);
		assertTrue(user.getName().equals("admin"));
		assertNotNull(user.getDomainDto());
		// check user role
		assertNotNull(user.getRolesDto());
		assertTrue(user.getRolesDto().size() == 8);
		
		// search user by name and domain id
		userService = QhseServiceFactory.getUserService(ormProperties);
		user = userService.getUser("demo", 1L);
		assertNotNull(user);
		assertTrue(user.getName().equals("demo"));
		assertNotNull(user.getDomainDto());
		assertNotNull(user.getRolesDto());
		assertTrue(user.getRolesDto().size() == 1);
		
		//search user by id
		userService = QhseServiceFactory.getUserService(ormProperties);
		user = userService.getUserById(user.getId());
		assertNotNull(user);
		assertTrue(user.getName().equals("demo"));
		assertNotNull(user.getDomainDto());
		assertNotNull(user.getRolesDto());
		assertTrue(user.getRolesDto().size() == 1);
	}
	
	@Test
	public void testDomain() {
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
		assertNotNull(roleService);
		
		//search by id
		RoleDto roleDto = roleService.getRoleById(1L);
		assertNotNull(roleDto);
		assertTrue(roleDto.getName().equals(CommonConstants.ROLE_ADMIN));
		
		//search by name
		roleService = QhseServiceFactory.getRoleService(ormProperties);
		roleDto = roleService.getRoleByName(CommonConstants.ROLE_AUDIT);
		assertNotNull(roleDto);
		assertTrue(roleDto.getName().equals(CommonConstants.ROLE_AUDIT));
	}
	
	@Test
	public void testQuestionOption() {
		assertNotNull(questionMaintenanceService);
		
		//search by id
		QuestionOptionDto questionOptionDto = questionMaintenanceService.getQuestionOptionById(1L);
		assertNotNull(questionOptionDto);
		assertTrue(questionOptionDto.getName().equals("Africa"));
		assertTrue(questionOptionDto.getOptionOrder() == 10);
		assertTrue(questionOptionDto.getVersion() == 2);
		assertNotNull(questionOptionDto.getCreatedByUserDto());
		assertTrue(questionOptionDto.getCreatedByUserDto().getName().equals("admin"));
		
		//search by name
		questionMaintenanceService = QhseServiceFactory.getQuestionMaintenanceService(ormProperties);
		questionOptionDto = questionMaintenanceService.getQuestionOptionByName("European Union");
		assertNotNull(questionOptionDto);
		assertTrue(questionOptionDto.getOptionOrder() == 40);
		assertTrue(questionOptionDto.getVersion() == 1);
		assertTrue(questionOptionDto.getId() == 3);
		assertTrue(questionOptionDto.getCreatedByUserDto().getName().equals("admin"));
	}
	
}
