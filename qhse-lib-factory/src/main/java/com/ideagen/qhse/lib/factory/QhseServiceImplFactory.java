package com.ideagen.qhse.lib.factory;

import com.ideagen.qhse.lib.factory.exception.FactoryException;
import com.ideagen.qhse.lib.factory.validator.PropertiesValidator;
import com.ideagen.qhse.lib.rest.impl.domain.DomainRestServiceFactory;
import com.ideagen.qhse.lib.rest.impl.law.LawRestServiceFactory;
import com.ideagen.qhse.lib.rest.impl.question.maintainance.QuestionMaintenanceRestServiceFactory;
import com.ideagen.qhse.lib.rest.impl.role.RoleRestServiceFactory;
import com.ideagen.qhse.lib.rest.impl.user.UserRestServiceFactory;
import com.ideagen.qhse.pojo.QhseServiceFactory;
import com.ideagen.qhse.pojo.service.*;

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
                    } else if (serviceClass == LawService.class) {
                        return serviceClass.cast(QhseServiceFactory.getLawService(properties));
                    } else if (serviceClass == QuestionMaintenanceService.class) {
                        return serviceClass.cast(QuestionMaintenanceService.class);
                    }
                    break;
                case ServiceProperties.REST:
                    if (serviceClass == UserService.class) {
                        return serviceClass.cast(UserRestServiceFactory.getService(properties));
                    } else if (serviceClass == DomainService.class) {
                        return serviceClass.cast(DomainRestServiceFactory.getService(properties));
                    } else if (serviceClass == RoleService.class) {
                        return serviceClass.cast(RoleRestServiceFactory.getService(properties));
                    } else if (serviceClass == LawService.class) {
                        return serviceClass.cast(LawRestServiceFactory.getService(properties));
                    } else if (serviceClass == QuestionMaintenanceService.class) {
                        return serviceClass.cast(QuestionMaintenanceRestServiceFactory.getService(properties));
                    }
                    break;
                default:
                    return null;
            }
        }

        return null;
    }
}
