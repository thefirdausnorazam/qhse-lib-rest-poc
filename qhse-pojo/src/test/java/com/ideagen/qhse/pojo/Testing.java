package com.ideagen.qhse.pojo;
import java.util.HashMap;
import java.util.Map;

import com.ideagen.qhse.orm.dao.HibernateTestDao;

public class Testing {

	public static void main(String[] args) {
		
		Map<String, String> ormProperties = new HashMap<String, String>() {
            /**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			{
                /*put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
                put("hibernate.hbm2ddl.auto", "");
                put("javax.persistence.jdbc.driver", "com.mysql.cj.jdbc.Driver");
                put("javax.persistence.jdbc.url", "jdbc:mysql://localhost:3306/qhse_test?serverTimezone=Asia/Kuala_Lumpur");
                put("javax.persistence.jdbc.user", "root");
                put("javax.persistence.jdbc.password", "p@ssw0rd");*/
				put("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
				put("hibernate.connection.url", "jdbc:mysql://localhost:3306/qhse?serverTimezone=Asia/Kuala_Lumpur");
				put("hibernate.connection.username", "root");
				put("hibernate.connection.password", "p@ssw0rd");
				put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
				put("hibernate.hbm2ddl.auto", "");
				put("hibernate.show_sql", "true");
            }
        };
        /*UserService userService = QhseServiceFactory.getUserService(ormProperties);
        UserDto userDto = userService.getUser("demo");
        System.out.println(userDto.getFirstName());
        Collection<RoleDto> roles = userDto.getRolesDto();
        for(RoleDto role: roles) {
        	System.out.println(role.getName());
        }
        */
        HibernateTestDao hibernateTestDao = QhseServiceFactory.getHibernateDaoTestService(ormProperties);
        System.out.println(hibernateTestDao.getVersion());
        
	}

}
