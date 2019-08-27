package com.ideagen.qhse.pojo.dto;

import java.util.Collection;

public class UserDto extends AbstractDto implements java.io.Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long id;

    private String name;

    private String username;

    private String password;
    
    private DomainDto domainDto;
    
    private Collection<RoleDto> roleDtos;

    public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public DomainDto getDomainDto() {
		return domainDto;
	}

	public void setDomainDto(DomainDto domainDto) {
		this.domainDto = domainDto;
	}
    
    public Collection<RoleDto> getRolesDto() {
        return roleDtos;
    }

    public void setRolesDto(Collection<RoleDto> roleDtos) {
        this.roleDtos = roleDtos;
    }

    @Override
    public String toString() {
        return "{" +
        		"id='" + id + '\'' +
                "name='" + name + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", domain='" + domainDto + '\'' +
                ", roles='" + roleDtos + '\'' +
                '}';
    }
}
