package com.ideagen.qhse.web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

import java.util.Arrays;

@SpringBootApplication
public class QhseWebApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext ctx = SpringApplication.run(QhseWebApplication.class, args);
        /*String[] beanNames = ctx.getBeanDefinitionNames();

        Arrays.sort(beanNames);

        for (String beanName : beanNames) {
            System.out.println(beanName);
        }*/
    }

}
