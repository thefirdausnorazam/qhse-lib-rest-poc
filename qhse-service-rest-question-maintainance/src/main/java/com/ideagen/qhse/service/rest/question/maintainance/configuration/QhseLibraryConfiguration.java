package com.ideagen.qhse.service.rest.question.maintainance.configuration;

import com.ideagen.qhse.pojo.QhseServiceFactory;
import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class QhseLibraryConfiguration {

    @Autowired
    private Environment environment;

    @Bean
    public Map libraryProperties() {
        return new HashMap() {
            {
                put("hibernate.dialect", environment.getProperty("qhse.lib.hibernate.dialect"));
                put("hibernate.hbm2ddl.auto", environment.getProperty("qhse.lib.hibernate.hbm2ddl.auto"));
                put("hibernate.show_sql", environment.getProperty("qhse.lib.hibernate.show_sql"));
                put("javax.persistence.jdbc.driver", environment.getProperty("qhse.lib.javax.persistence.jdbc.driver"));
                put("javax.persistence.jdbc.url", environment.getProperty("qhse.lib.javax.persistence.jdbc.url"));
                put("javax.persistence.jdbc.user", environment.getProperty("qhse.lib.javax.persistence.jdbc.user"));
                put("javax.persistence.jdbc.password", environment.getProperty("qhse.lib.javax.persistence.jdbc.password"));
            }
        };
    }

    @Bean
    public QuestionMaintenanceService questionMaintenanceService() {
        return QhseServiceFactory.getQuestionMaintenanceService(libraryProperties());
    }
}