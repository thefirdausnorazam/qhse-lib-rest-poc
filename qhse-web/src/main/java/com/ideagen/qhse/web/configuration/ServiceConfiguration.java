package com.ideagen.qhse.web.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class ServiceConfiguration {
    private final Environment env;

    @Autowired
    public ServiceConfiguration(Environment env) {
        this.env = env;
    }

    @Bean
    public Map<String,String> hibernateConfig() {
        return new HashMap<>() {
            {
                put("hibernate.connection.driver_class", env.getProperty("hibernate.connection.driver_class"));
                put("hibernate.connection.url", env.getProperty("hibernate.connection.url"));
                put("hibernate.connection.username", env.getProperty("hibernate.connection.username"));
                put("hibernate.connection.password", env.getProperty("hibernate.connection.password"));
                put("hibernate.dialect", env.getProperty("hibernate.dialect"));
                put("hibernate.hbm2ddl.auto", env.getProperty("hibernate.hbm2ddl.auto"));
            }
        };
    }
}
