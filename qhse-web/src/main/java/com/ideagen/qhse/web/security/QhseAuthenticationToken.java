package com.ideagen.qhse.web.security;

import java.util.Collection;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;

public class QhseAuthenticationToken extends UsernamePasswordAuthenticationToken {
	
	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;
	
	private Object domain;
	
	public QhseAuthenticationToken(Object principal, Object credentials, String domain) {
        super(principal, credentials);
        this.domain = domain;
        super.setAuthenticated(false);
    }

    public QhseAuthenticationToken(Object principal, Object credentials, String domain, 
        Collection<? extends GrantedAuthority> authorities) {
        super(principal, credentials, authorities);
        super.setAuthenticated(true); // must use super, as we override
        this.domain = domain;
    }

    public Object getDomain() {
        return this.domain;
    }
    
    @Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append(super.toString()).append(": ");
		sb.append("Principal: ").append(this.getPrincipal()).append("; ");
		sb.append("Credentials: [PROTECTED]; ");
		sb.append("Authenticated: ").append(this.isAuthenticated()).append("; ");
		sb.append("Details: ").append(this.getDetails()).append("; ");
		
		if (this.getDomain() != null) {
			sb.append("Domain: ").append(this.getDomain()).append("; ");
		}

		if (!this.getAuthorities().isEmpty()) {
			sb.append("Granted Authorities: ");

			int i = 0;
			for (GrantedAuthority authority : this.getAuthorities()) {
				if (i++ > 0) {
					sb.append(", ");
				}

				sb.append(authority);
			}
		} else {
			sb.append("Not granted any authorities");
		}

		return sb.toString();
	}

}
