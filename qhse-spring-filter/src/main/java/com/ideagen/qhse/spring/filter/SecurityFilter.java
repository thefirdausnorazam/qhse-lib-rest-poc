package com.ideagen.qhse.spring.filter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

public class SecurityFilter extends UsernamePasswordAuthenticationFilter {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private static final String AUTH_HEADER = "qhse-user-is-authenticated";
    private static final String SECRET_HEADER = "qhse-service-secret";
    private static final String AUTHENTICATED_USER = "qhse-authenticated-user";

    private final List<String> allowedSecrets;

    public SecurityFilter(List<String> allowedSecrets) {
        this.allowedSecrets = allowedSecrets;
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        //check header
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;

        final String requestURI = httpServletRequest.getRequestURI();
        final String authenticatedFlag = httpServletRequest.getHeader(AUTH_HEADER);
        final String secret = httpServletRequest.getHeader(SECRET_HEADER);

        Authentication authentication = null;

        try {
            if (isSecretAllowed(secret)) {
                if (authenticatedFlag != null) {
                    if (authenticatedFlag.equals("true")) {
                        String authenticatedUser = httpServletRequest.getHeader(AUTHENTICATED_USER);

                        if (authenticatedUser != null) {
                            authentication = new UsernamePasswordAuthenticationToken(authenticatedUser, null, null);
                        }
                    } else {
                        logger.warn("Access denied to {} for request bearing invalid authenticated flag : {}",
                                requestURI, authenticatedFlag);
                    }
                }
            } else {
                logger.warn("Access denied to {} for request bearing unallowed secret : {}",
                        requestURI, secret);
            }

            SecurityContextHolder.getContext().setAuthentication(authentication);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }

        filterChain.doFilter(servletRequest, servletResponse);
    }

    private boolean isSecretAllowed(String secret) {
        if (secret == null) {
            return false;
        } else {
            return allowedSecrets.stream()
                    .anyMatch(secret::equals);
        }
    }
}
