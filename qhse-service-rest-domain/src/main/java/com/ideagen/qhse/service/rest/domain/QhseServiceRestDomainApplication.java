package com.ideagen.qhse.service.rest.domain;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.dao.PersistenceExceptionTranslationAutoConfiguration;

@SpringBootApplication(exclude = {PersistenceExceptionTranslationAutoConfiguration.class})
public class QhseServiceRestDomainApplication {

	public static void main(String[] args) {
		SpringApplication.run(QhseServiceRestDomainApplication.class, args);
	}

}
