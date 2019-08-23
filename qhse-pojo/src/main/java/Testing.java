import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import com.ideagen.qhse.pojo.QhseServiceFactory;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.UserService;

public class Testing {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Map<String, String> ormProperties = new HashMap<String, String>() {
            /**
			 * 
			 */
			private static final long serialVersionUID = 1L;

			{
                put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
                put("hibernate.hbm2ddl.auto", "");
                put("javax.persistence.jdbc.driver", "com.mysql.cj.jdbc.Driver");
                put("javax.persistence.jdbc.url", "jdbc:mysql://localhost:3306/qhse?serverTimezone=Asia/Kuala_Lumpur");
                put("javax.persistence.jdbc.user", "root");
                put("javax.persistence.jdbc.password", "root");
            }
        };
        UserService userService = QhseServiceFactory.getUserService(ormProperties);
        UserDto userDto = userService.getUser("demo");
        System.out.println(userDto.getName());
        Collection<RoleDto> roles = userDto.getRolesDto();
        for(RoleDto role: roles) {
        	System.out.println(role.getName());
        }

	}

}
