package com.ideagen.qhse.orm.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

@Entity
@Table(name = "domain")
@NamedQueries({
    @NamedQuery(name = "domain.listAll", query = "from Domain d"),
    @NamedQuery(name = "domain.listByName", query = "from Domain d where d.name = :name")
})
public class Domain {
	
	@Id
    private Long id;
	
	@Column(name = "discriminator", nullable = false)
	private String discriminator;
	
	@Column(name = "name", nullable = false)
	private String name;
	
	@Column(name = "active", nullable = false)
	private boolean active;
	
	@Column(name = "url")
	private String url;
	
	@Column(name = "root_dn")
	private String rootDn;
	
	@Column(name = "user_search_base")
	private String userSearchBase;
	
	@Column(name = "group_search_base")
	private String groupSearchBase;
	
	@Column(name = "user_name")
	private String userName;
	
	@Column(name = "user_password")
	private String userPassword;
	
	@Column(name = "user_name_property")
	private String userNameProperty;
	
	@Column(name = "first_name_property")
	private String firstNameProperty;
	
	@Column(name = "surname_name_property")
	private String surnameNameProperty;
	
	@Column(name = "email_property")
	private String emailProperty;
	
	@Column(name = "department_property")
	private String departmentProperty;
	
	@Column(name = "permitted_client_addresses")
	private String permittedClientAddresses;
	
	@Column(name = "groups_property")
	private String groupProperty;
	
	@Column(name = "default_department")
	private Long defaultDepartment;
	
	@Column(name = "spnego_keytab_location")
	private String spnegoKeytabLocation;
	
	@Column(name = "spnego_service_principal")
	private String spnegoServicePrincipal;
	
	@Column(name = "override_department_attribute", nullable = false)
	private boolean overrideDepartmentAttribute;
	
	@Column(name = "auto_sync", nullable = false)
	private boolean autoSync;
	
	@Column(name = "last_sync_ts")
	private Timestamp lastSyncTs;
	
	@Column(name = "employee_id_property")
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
	
}
