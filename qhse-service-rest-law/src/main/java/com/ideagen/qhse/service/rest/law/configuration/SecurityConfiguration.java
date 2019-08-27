package com.ideagen.qhse.service.rest.law.configuration;

import com.ideagen.qhse.spring.filter.SecurityFilter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import java.util.List;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Value("#{'${service.allowed.secrets}'.split(',')}")
    private List<String> allowedSecrets;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf().disable()
                .authorizeRequests()
                .antMatchers("/v2/api-docs",
                        "/com/ideagen/qhse/service/rest/law/configuration/ui",
                        "/swagger-resources",
                        "/com/ideagen/qhse/service/rest/law/configuration/security",
                        "/swagger-ui.html",
                        "/webjars/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .addFilter(new SecurityFilter(allowedSecrets));
    }
}
