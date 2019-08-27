package com.ideagen.qhse.pojo.dto;

import java.sql.Timestamp;

public class DomainDto implements java.io.Serializable {
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long id;
	
	private String discriminator;
	
	private String name;
	
	private boolean active;
	
	private String url;
	
	private String rootDn;
	
	private String userSearchBase;
	
	private String groupSearchBase;
	
	private String userName;
	
	private String userPassword;
	
	private String userNameProperty;
	
	private String firstNameProperty;
	
	private String surnameNameProperty;
	
	private String emailProperty;
	
	private String departmentProperty;
	
	private String permittedClientAddresses;
	
	private String groupProperty;
	
	private Long defaultDepartment;
	
	private String spnegoKeytabLocation;
	
	private String spnegoServicePrincipal;
	
	private boolean overrideDepartmentAttribute;
	
	private boolean autoSync;
	
	private Timestamp lastSyncTs;
	
	private String employeeIdProperty;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDiscriminator() {
		return discriminator;
	}

	public void setDiscriminator(String discriminator) {
		this.discriminator = discriminator;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getRootDn() {
		return rootDn;
	}

	public void setRootDn(String rootDn) {
		this.rootDn = rootDn;
	}

	public String getUserSearchBase() {
		return userSearchBase;
	}

	public void setUserSearchBase(String userSearchBase) {
		this.userSearchBase = userSearchBase;
	}

	public String getGroupSearchBase() {
		return groupSearchBase;
	}

	public void setGroupSearchBase(String groupSearchBase) {
		this.groupSearchBase = groupSearchBase;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserNameProperty() {
		return userNameProperty;
	}

	public void setUserNameProperty(String userNameProperty) {
		this.userNameProperty = userNameProperty;
	}

	public String getFirstNameProperty() {
		return firstNameProperty;
	}

	public void setFirstNameProperty(String firstNameProperty) {
		this.firstNameProperty = firstNameProperty;
	}

	public String getSurnameNameProperty() {
		return surnameNameProperty;
	}

	public void setSurnameNameProperty(String surnameNameProperty) {
		this.surnameNameProperty = surnameNameProperty;
	}

	public String getEmailProperty() {
		return emailProperty;
	}

	public void setEmailProperty(String emailProperty) {
		this.emailProperty = emailProperty;
	}

	public String getDepartmentProperty() {
		return departmentProperty;
	}

	public void setDepartmentProperty(String departmentProperty) {
		this.departmentProperty = departmentProperty;
	}

	public String getPermittedClientAddresses() {
		return permittedClientAddresses;
	}

	public void setPermittedClientAddresses(String permittedClientAddresses) {
		this.permittedClientAddresses = permittedClientAddresses;
	}

	public String getGroupProperty() {
		return groupProperty;
	}

	public void setGroupProperty(String groupProperty) {
		this.groupProperty = groupProperty;
	}

	public Long getDefaultDepartment() {
		return defaultDepartment;
	}

	public void setDefaultDepartment(Long defaultDepartment) {
		this.defaultDepartment = defaultDepartment;
	}

	public String getSpnegoKeytabLocation() {
		return spnegoKeytabLocation;
	}

	public void setSpnegoKeytabLocation(String spnegoKeytabLocation) {
		this.spnegoKeytabLocation = spnegoKeytabLocation;
	}

	public String getSpnegoServicePrincipal() {
		return spnegoServicePrincipal;
	}

	public void setSpnegoServicePrincipal(String spnegoServicePrincipal) {
		this.spnegoServicePrincipal = spnegoServicePrincipal;
	}

	public boolean isOverrideDepartmentAttribute() {
		return overrideDepartmentAttribute;
	}

	public void setOverrideDepartmentAttribute(boolean overrideDepartmentAttribute) {
		this.overrideDepartmentAttribute = overrideDepartmentAttribute;
	}

	public boolean isAutoSync() {
		return autoSync;
	}

	public void setAutoSync(boolean autoSync) {
		this.autoSync = autoSync;
	}

	public Timestamp getLastSyncTs() {
		return lastSyncTs;
	}

	public void setLastSyncTs(Timestamp lastSyncTs) {
		this.lastSyncTs = lastSyncTs;
	}

	public String getEmployeeIdProperty() {
		return employeeIdProperty;
	}

	public void setEmployeeIdProperty(String employeeIdProperty) {
		this.employeeIdProperty = employeeIdProperty;
	}
	
	@Override
    public String toString() {
        return "{" +
        		"id='" + id + '\'' +
                ", discriminator='" + discriminator + '\'' +
                ", name='" + name + '\'' +
                ", active='" + active + '\'' +
                ", url='" + url + '\'' +
                ", rootDn='" + rootDn + '\'' +
                ", userSearchBase='" + userSearchBase + '\'' +
                ", groupSearchBase='" + groupSearchBase + '\'' +
                ", userName='" + userName + '\'' +
                ", userPassword='" + userPassword + '\'' +
                ", userNameProperty='" + userNameProperty + '\'' +
                ", firstNameProperty='" + firstNameProperty + '\'' +
                ", surnameNameProperty='" + surnameNameProperty + '\'' +
                ", emailProperty='" + emailProperty + '\'' +
                ", departmentProperty='" + departmentProperty + '\'' +
                ", permittedClientAddresses='" + permittedClientAddresses + '\'' +
                ", groupProperty='" + groupProperty + '\'' +
                ", defaultDepartment='" + defaultDepartment + '\'' +
                ", spnegoKeytabLocation='" + spnegoKeytabLocation + '\'' +
                ", spnegoServicePrincipal='" + spnegoServicePrincipal + '\'' +
                ", overrideDepartmentAttribute='" + overrideDepartmentAttribute + '\'' +
                ", autoSync='" + autoSync + '\'' +
                ", lastSyncTs='" + lastSyncTs + '\'' +
                ", employeeIdProperty='" + employeeIdProperty + '\'' +
                '}';
    }

}
