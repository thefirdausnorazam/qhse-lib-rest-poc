package com.ideagen.qhse.service.rest.role;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.dao.PersistenceExceptionTranslationAutoConfiguration;

@SpringBootApplication(exclude = {PersistenceExceptionTranslationAutoConfiguration.class})
public class QhseServiceRestRoleApplication {

	public static void main(String[] args) {
		SpringApplication.run(QhseServiceRestRoleApplication.class, args);
	}

}
