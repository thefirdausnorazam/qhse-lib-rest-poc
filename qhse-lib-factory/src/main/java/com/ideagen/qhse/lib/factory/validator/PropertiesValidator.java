package com.ideagen.qhse.lib.factory.validator;

import com.ideagen.qhse.lib.factory.ServiceProperties;
import com.ideagen.qhse.lib.factory.exception.FactoryException;
import com.ideagen.qhse.lib.rest.impl.RestServiceProperties;

import java.util.Map;
import java.util.Optional;

public class PropertiesValidator {

    public static boolean isValid(final Map<String, String> properties) throws FactoryException {
        if (!properties.containsKey(ServiceProperties.SERVICE_TYPE)) {
            throw new FactoryException("Please specify a service type (" + ServiceProperties.SERVICE_TYPE + ")");
        }

        String serviceProperties = String.valueOf(properties.get(ServiceProperties.SERVICE_TYPE));

        switch (serviceProperties) {
            case ServiceProperties.BINARY:
                return true;
            case ServiceProperties.REST:
                if (!properties.containsKey(RestServiceProperties.REST_ENDPOINT)) {
                    throw new FactoryException("Please specify the rest endpoints for qhse service (" + RestServiceProperties.REST_ENDPOINT + ")");
                }

                if (!properties.containsKey(RestServiceProperties.SERVICE_SECRET)) {
                    throw new FactoryException("Please provide your secret (" + RestServiceProperties.SERVICE_SECRET + ")");
                }

                if (!properties.containsKey(RestServiceProperties.AUTHENTICATED_USER)) {
                    throw new FactoryException("Please specify authenticated user's username (" + RestServiceProperties.AUTHENTICATED_USER + ")");
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
