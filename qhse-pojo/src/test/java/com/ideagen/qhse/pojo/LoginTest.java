package com.ideagen.qhse.pojo;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.UserService;

public class LoginTest {
	
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
        
        //userService = QhseServiceFactory.getUserService(ormProperties);
	}
	
	@Test
	public void testLogin() {
		
		String username = "demo";
		String password = "p@ssw0rd";
		Long domain = 1L;
		// logon via username and password
		userService = QhseServiceFactory.getUserService(ormProperties);
		UserDto userDto = userService.logon(username, password);
		assertNotNull(userDto);
		// logon via username and password
		userService = QhseServiceFactory.getUserService(ormProperties);
		userDto = userService.logon(username, password, domain);
		assertNotNull(userDto);
		// check wrong password
		String wrong = "p@ssw0rd123";
		userService = QhseServiceFactory.getUserService(ormProperties);
		userDto = userService.logon(username, wrong);
		assertNull(userDto);
		// check non exist username
		String nonExist = "demo1";
		userService = QhseServiceFactory.getUserService(ormProperties);
		userDto = userService.logon(nonExist, password);
		assertNull(userDto);
		
	}

}
