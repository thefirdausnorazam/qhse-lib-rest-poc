package com.ideagen.qhse.web.security;

import com.ideagen.qhse.pojo.dto.DomainDto;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;

public class QhseCustomUserDetails extends User {

    private final DomainDto domain;

    private Collection<? extends GrantedAuthority> grantedAuthorities;

    public QhseCustomUserDetails(String username, String password, DomainDto domain, Collection<? extends GrantedAuthority> grantedAuthorities){
        super(username, password, grantedAuthorities);
        this.domain = domain;
        this.grantedAuthorities = grantedAuthorities;
    }

    public DomainDto getDomain() { return this.domain; }

    public boolean isAdmin() {
        return this.grantedAuthorities.stream().anyMatch(auth->((GrantedAuthority) auth).getAuthority().equals("ROLE_ADMIN"));
    }

    public boolean hasRole(String role) {
        return this.grantedAuthorities.stream().anyMatch(auth->((GrantedAuthority) auth).getAuthority().equals(role));
    }
}
