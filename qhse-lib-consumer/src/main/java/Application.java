import com.fasterxml.jackson.databind.ObjectMapper;
import com.ideagen.qhse.lib.factory.QhseServiceImplFactory;
import com.ideagen.qhse.lib.factory.ServiceProperties;
import com.ideagen.qhse.lib.rest.impl.RestServiceProperties;
import com.ideagen.qhse.pojo.constants.CommonConstants;
import com.ideagen.qhse.pojo.dto.DomainDto;
import com.ideagen.qhse.pojo.dto.RoleDto;
import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.service.DomainService;
import com.ideagen.qhse.pojo.service.RoleService;
import com.ideagen.qhse.pojo.service.UserService;
import com.ideagen.qhse.pojo.service.impl.UserServiceImpl;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Application {

    private static final Map<String, String> BINARY_LIB_PROPERTIES = new HashMap<>() {
        {
            //flag
            put(ServiceProperties.SERVICE_TYPE, ServiceProperties.BINARY);

            //required properties
            put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
            put("hibernate.hbm2ddl.auto", "");
            put("javax.persistence.jdbc.driver", "com.mysql.cj.jdbc.Driver");
            put("javax.persistence.jdbc.url", "jdbc:mysql://localhost:3306/qhse?serverTimezone=Asia/Kuala_Lumpur");
            put("javax.persistence.jdbc.user", "root");
            put("javax.persistence.jdbc.password", "root");
        }
    };

    private static final Map<String, String> REST_LIB_PROPERTIES = new HashMap<>() {
        {
            //flag
            put(ServiceProperties.SERVICE_TYPE, ServiceProperties.REST);

            //required properties
            put(RestServiceProperties.REST_ENDPOINT, "http://localhost:9999/");
            put(RestServiceProperties.SERVICE_SECRET, "firdausnorazam2");
            put(RestServiceProperties.AUTHENTICATED_USER, "demo");
        }
    };

    public static void main(String[] args) {
        try {
            //setup
            ObjectMapper objectMapper = new ObjectMapper();
            DomainDto domainDto = new DomainDto();
            domainDto.setDiscriminator(CommonConstants.LDAP_DISCRIMINATOR);

            //Properties selection
            final Map<String, String> libraryProperties = REST_LIB_PROPERTIES;

            //Get services
            UserService userService = QhseServiceImplFactory.getQhseService(UserService.class, libraryProperties);
            DomainService domainService = QhseServiceImplFactory.getQhseService(DomainService.class, libraryProperties);
            RoleService roleService = QhseServiceImplFactory.getQhseService(RoleService.class, libraryProperties);

            //Using User service
            UserDto adminUser = userService.getUser("admin");

            //Using Domain service
            Collection<DomainDto> domains = domainService.getAllDomains();
            boolean isLdap = domainService.isLDAPAuthentication(domainDto);

            //Using Role service
            RoleDto roleDto = roleService.getRoleById(1L);

            //Print results
            System.out.println("What user we get : ");
            System.out.println(objectMapper.writeValueAsString(adminUser));
            System.out.println("Domain list we get : ");
            System.out.println(objectMapper.writeValueAsString(domains));
            System.out.println("Is it Ldap? : ");
            System.out.println(objectMapper.writeValueAsString(isLdap));
            System.out.println("What role get : ");
            System.out.println(objectMapper.writeValueAsString(roleDto));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
