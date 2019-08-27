package com.ideagen.qhse.service.rest.law;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.dao.PersistenceExceptionTranslationAutoConfiguration;

@SpringBootApplication(exclude = {PersistenceExceptionTranslationAutoConfiguration.class})
public class QhseServiceRestLawApplication {

	public static void main(String[] args) {
		SpringApplication.run(QhseServiceRestLawApplication.class, args);
	}

}
