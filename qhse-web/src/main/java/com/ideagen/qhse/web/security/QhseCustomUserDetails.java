package com.ideagen.qhse.web.security;

import com.ideagen.qhse.pojo.dto.DomainDto;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.ArrayList;
import java.util.Collection;

public class QhseCustomUserDetails extends User {

    private final DomainDto domain;

    private Collection<? extends GrantedAuthority> grantedAuthorities;

    public QhseCustomUserDetails(String username, String password, DomainDto domain, Collection<? extends GrantedAuthority> grantedAuthorities) {
        super(username, password, grantedAuthorities);
        this.domain = domain;
        this.grantedAuthorities = new ArrayList<>(grantedAuthorities);
    }

    public DomainDto getDomain() {
        return this.domain;
    }

    public Collection<? extends GrantedAuthority> getGrantedAuthorities() {
        return grantedAuthorities;
    }
}
