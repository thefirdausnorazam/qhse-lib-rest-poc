package com.ideagen.qhse.web.utils.security;

import com.ideagen.qhse.pojo.dto.DomainDto;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class UserUtils {

    private final DomainDto domain;

    private Collection<? extends GrantedAuthority> grantedAuthorities;

    public UserUtils(DomainDto domain, Collection<? extends GrantedAuthority> grantedAuthorities) {
        this.domain = domain;
        this.grantedAuthorities = grantedAuthorities;
    }

    public boolean isAdmin() {
        return this.grantedAuthorities.stream().anyMatch(auth->((GrantedAuthority) auth).getAuthority().equals("ROLE_ADMIN"));
    }

    public boolean isInRole(String role) {
        return this.grantedAuthorities.stream().anyMatch(auth->((GrantedAuthority) auth).getAuthority().equals(role));
    }
}
