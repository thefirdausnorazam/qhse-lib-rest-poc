package com.ideagen.qhse.rest.service.user;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.dao.PersistenceExceptionTranslationAutoConfiguration;

@SpringBootApplication(exclude = {PersistenceExceptionTranslationAutoConfiguration.class})
public class QhseRestServiceUserApplication {

	public static void main(String[] args) {
		SpringApplication.run(QhseRestServiceUserApplication.class, args);
	}

}
