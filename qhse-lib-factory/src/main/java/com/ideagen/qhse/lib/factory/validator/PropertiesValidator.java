package com.ideagen.qhse.lib.factory.validator;

import com.ideagen.qhse.lib.factory.ServiceProperties;
import com.ideagen.qhse.lib.factory.exception.FactoryException;

import java.util.Map;
import java.util.Optional;

public class PropertiesValidator {

    public static boolean isValid(final Map<String, String> properties) throws FactoryException {
        if (!properties.containsKey(ServiceProperties.SERVICE_TYPE)) {
            throw new FactoryException("Please specify a service type");
        }

        String serviceProperties = String.valueOf(properties.get(ServiceProperties.SERVICE_TYPE));

        switch (serviceProperties) {
            case ServiceProperties.BINARY:
                return true;
            case ServiceProperties.REST:
                if (!properties.containsKey(ServiceProperties.REST_ENDPOINT)) {
                    throw new FactoryException("Please specify the rest endpoints for qhse service.");
                }
                return true;
            default:
                throw new FactoryException("Invalid service type specified : "
                        + Optional.ofNullable(serviceProperties)
                        .orElse("null")
                );
        }
    }
}
