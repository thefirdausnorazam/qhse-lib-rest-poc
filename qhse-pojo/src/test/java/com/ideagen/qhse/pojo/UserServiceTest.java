package com.ideagen.qhse.pojo;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.ideagen.qhse.pojo.constants.CommonConstants;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.UserService;

public class UserServiceTest {
	
	UserService userService;
	Map<String, String> ormProperties;
	
	@Before
	public void setup() {
		ormProperties = new HashMap<String, String>() {
            /**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			{
				put("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
				put("hibernate.connection.url", "jdbc:mysql://localhost:3306/qhse_test?serverTimezone=Asia/Kuala_Lumpur");
				put("hibernate.connection.username", "root");
				put("hibernate.connection.password", "root");
				put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
				put("hibernate.hbm2ddl.auto", "");
            }
        };
        
        //lawService = QhseServiceFactory.getLawService(ormProperties);
	}
	
	@Test
	public void testListUsersByMultipleRoles( ) {
		userService = QhseServiceFactory.getUserService(ormProperties);
		assertNotNull(userService);
		
		List<String> roles = new ArrayList<String>();
    	roles.add(CommonConstants.ROLE_SHARE);
    	roles.add(CommonConstants.ROLE_CREATE);
    	roles.add(CommonConstants.ROLE_EDIT_RELEVANCY);
    	roles.add(CommonConstants.COMPLETE_TASKS);
    	
    	String groupName = "1-Demo";
		
		List<UserDto> userDtos = userService.listUsersByMultipleRoles(groupName, roles);
		assertTrue(userDtos.size() == 83);
		/*for(UserDto userDto: userDtos) {
			System.out.println(userDto.getLastName());
		}*/
		
		groupName = "2-Sandbox";
		userService = QhseServiceFactory.getUserService(ormProperties);
		userDtos = userService.listUsersByMultipleRoles(groupName, roles);
		assertTrue(userDtos.size() == 26);
		
	}

}
