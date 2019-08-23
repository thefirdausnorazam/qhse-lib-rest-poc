package com.ideagen.qhse.rest.filter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Component
public class RequestLoggerFilter implements Filter {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm:ss z");

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;

        logger.info("Incoming request : timestamp = {}, request URI = {}, origin = {}, ",
                ZonedDateTime.now().format(formatter),
                httpServletRequest.getRequestURI(),
                httpServletRequest.getRemoteAddr());

        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}
