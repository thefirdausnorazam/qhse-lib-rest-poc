package com.ideagen.qhse.lib.factory;

import com.ideagen.qhse.lib.factory.exception.FactoryException;
import com.ideagen.qhse.lib.factory.validator.PropertiesValidator;
import com.ideagen.qhse.lib.rest.impl.domain.DomainRestServiceFactory;
import com.ideagen.qhse.lib.rest.impl.role.RoleRestServiceFactory;
import com.ideagen.qhse.lib.rest.impl.user.UserRestServiceFactory;
import com.ideagen.qhse.pojo.QhseServiceFactory;
import com.ideagen.qhse.pojo.service.DomainService;
import com.ideagen.qhse.pojo.service.RoleService;
import com.ideagen.qhse.pojo.service.UserService;

import java.util.Map;

public class QhseServiceImplFactory {

    public static <S> S getQhseService(Class<S> serviceClass, Map<String, String> properties) throws FactoryException {
        if (PropertiesValidator.isValid(properties)) {

            String serviceProperties = String.valueOf(properties.get(ServiceProperties.SERVICE_TYPE));

            switch (serviceProperties) {
                case ServiceProperties.BINARY:
                    if (serviceClass == UserService.class) {
                        return serviceClass.cast(QhseServiceFactory.getUserService(properties));
                    } else if (serviceClass == DomainService.class) {
                        return serviceClass.cast(QhseServiceFactory.getDomainService(properties));
                    } else if (serviceClass == RoleService.class) {
                        return serviceClass.cast(QhseServiceFactory.getRoleService(properties));
                    }
                    break;
                case ServiceProperties.REST:
                    String restEndpoint = String.valueOf(properties.get(ServiceProperties.REST_ENDPOINT));
                    if (serviceClass == UserService.class) {
                        return serviceClass.cast(UserRestServiceFactory.getService(restEndpoint));
                    } else if (serviceClass == DomainService.class) {
                        return serviceClass.cast(DomainRestServiceFactory.getService(restEndpoint));
                    } else if (serviceClass == RoleService.class) {
                        return serviceClass.cast(RoleRestServiceFactory.getService(restEndpoint));
                    }
                    break;
                default:
                    return null;
            }
        }

        return null;
    }
}
