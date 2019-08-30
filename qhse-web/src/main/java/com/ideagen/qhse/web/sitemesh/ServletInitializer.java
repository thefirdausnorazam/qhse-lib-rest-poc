package com.ideagen.qhse.web.sitemesh;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ServletInitializer extends SpringBootServletInitializer {
    @Bean
    public FilterRegistrationBean<LayoutFilter> LayoutFilter() {
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        LayoutFilter layoutFilter = new LayoutFilter();
        filterRegistrationBean.setFilter(layoutFilter);
        filterRegistrationBean.addUrlPatterns("/*");
        return filterRegistrationBean;
    }
}
