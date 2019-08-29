package com.ideagen.qhse.orm.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

@Entity
@Table(name = "sec_user_domain")
@NamedQueries({
    @NamedQuery(name = "domain.listAll", query = "from Domain d"),
    @NamedQuery(name = "domain.listByName", query = "from Domain d where d.name = :name")
})
public class Domain extends AbstractNamedEntity {
	
	
	private String discriminator;
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
	
	@Column(name = "discriminator", nullable = false)
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
	
	@Column(name = "active", nullable = false)
	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}
	
	@Column(name = "url")
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	@Column(name = "root_dn")
	public String getRootDn() {
		return rootDn;
	}

	public void setRootDn(String rootDn) {
		this.rootDn = rootDn;
	}
	
	@Column(name = "user_search_base")
	public String getUserSearchBase() {
		return userSearchBase;
	}

	public void setUserSearchBase(String userSearchBase) {
		this.userSearchBase = userSearchBase;
	}
	
	@Column(name = "group_search_base")
	public String getGroupSearchBase() {
		return groupSearchBase;
	}

	public void setGroupSearchBase(String groupSearchBase) {
		this.groupSearchBase = groupSearchBase;
	}
	
	@Column(name = "user_name")
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	@Column(name = "user_password")
	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	
	@Column(name = "user_name_property")
	public String getUserNameProperty() {
		return userNameProperty;
	}

	public void setUserNameProperty(String userNameProperty) {
		this.userNameProperty = userNameProperty;
	}
	
	@Column(name = "first_name_property")
	public String getFirstNameProperty() {
		return firstNameProperty;
	}

	public void setFirstNameProperty(String firstNameProperty) {
		this.firstNameProperty = firstNameProperty;
	}
	
	@Column(name = "surname_name_property")
	public String getSurnameNameProperty() {
		return surnameNameProperty;
	}

	public void setSurnameNameProperty(String surnameNameProperty) {
		this.surnameNameProperty = surnameNameProperty;
	}
	
	@Column(name = "email_property")
	public String getEmailProperty() {
		return emailProperty;
	}

	public void setEmailProperty(String emailProperty) {
		this.emailProperty = emailProperty;
	}
	
	@Column(name = "department_property")
	public String getDepartmentProperty() {
		return departmentProperty;
	}

	public void setDepartmentProperty(String departmentProperty) {
		this.departmentProperty = departmentProperty;
	}
	
	@Column(name = "permitted_client_addresses")
	public String getPermittedClientAddresses() {
		return permittedClientAddresses;
	}

	public void setPermittedClientAddresses(String permittedClientAddresses) {
		this.permittedClientAddresses = permittedClientAddresses;
	}
	
	@Column(name = "groups_property")
	public String getGroupProperty() {
		return groupProperty;
	}

	public void setGroupProperty(String groupProperty) {
		this.groupProperty = groupProperty;
	}
	
	@Column(name = "default_department")
	public Long getDefaultDepartment() {
		return defaultDepartment;
	}

	public void setDefaultDepartment(Long defaultDepartment) {
		this.defaultDepartment = defaultDepartment;
	}
	
	@Column(name = "spnego_keytab_location")
	public String getSpnegoKeytabLocation() {
		return spnegoKeytabLocation;
	}

	public void setSpnegoKeytabLocation(String spnegoKeytabLocation) {
		this.spnegoKeytabLocation = spnegoKeytabLocation;
	}
	
	@Column(name = "spnego_service_principal")
	public String getSpnegoServicePrincipal() {
		return spnegoServicePrincipal;
	}

	public void setSpnegoServicePrincipal(String spnegoServicePrincipal) {
		this.spnegoServicePrincipal = spnegoServicePrincipal;
	}
	
	@Column(name = "override_department_attribute", nullable = false)
	public boolean isOverrideDepartmentAttribute() {
		return overrideDepartmentAttribute;
	}

	public void setOverrideDepartmentAttribute(boolean overrideDepartmentAttribute) {
		this.overrideDepartmentAttribute = overrideDepartmentAttribute;
	}
	
	@Column(name = "auto_sync", nullable = false)
	public boolean isAutoSync() {
		return autoSync;
	}

	public void setAutoSync(boolean autoSync) {
		this.autoSync = autoSync;
	}
	
	@Column(name = "last_sync_ts")
	public Timestamp getLastSyncTs() {
		return lastSyncTs;
	}

	public void setLastSyncTs(Timestamp lastSyncTs) {
		this.lastSyncTs = lastSyncTs;
	}
	
	@Column(name = "employee_id_property")
	public String getEmployeeIdProperty() {
		return employeeIdProperty;
	}

	public void setEmployeeIdProperty(String employeeIdProperty) {
		this.employeeIdProperty = employeeIdProperty;
	}
	
}
