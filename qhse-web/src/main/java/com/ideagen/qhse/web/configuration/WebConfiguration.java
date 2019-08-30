package com.ideagen.qhse.web.configuration;


import com.ideagen.qhse.web.resolver.CustomErrorViewResolver;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import org.springframework.context.MessageSource;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;

@Configuration
@EnableWebMvc
@ComponentScan({"com.ideagen.qhse"})
public class WebConfiguration implements WebMvcConfigurer  {
    @Bean
    public ViewResolver internalResourceViewResolver() {
        InternalResourceViewResolver view = new InternalResourceViewResolver();
        view.setViewClass(JstlView.class);
        view.setPrefix("/WEB-INF/jsp/");
        view.setSuffix(".jsp");
        return view;
    }

    @Bean
    public ErrorViewResolver errorPageViewResolver(){
        CustomErrorViewResolver view = new CustomErrorViewResolver();
        return view;
    }

    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasename("/WEB-INF/messages");
        return messageSource;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/login/**")
                .addResourceLocations("/WEB-INF/static/login/");
        registry
                .addResourceHandler("/static/**")
                .addResourceLocations("/WEB-INF/static/common/");
        registry
                .addResourceHandler("/public/**")
                .addResourceLocations("/WEB-INF/static/public/");
    }
}
