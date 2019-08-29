package com.ideagen.qhse.orm.entity;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

@Entity
@Table(name = "user")
@NamedQueries({
    @NamedQuery(name = "user.listByName", query = "from User u where u.username = :username"),
    @NamedQuery(name = "user.listByNameDomain", query = "from User u where u.username = :username and u.domain.id = :domain"),
    @NamedQuery(name = "user.listUsersByMultipleRoles", query = "select distinct u from User u "
    		+ "inner join u.modules m "
    		+ "inner join u.groups g "
    		+ "join UserModule um on u.id = um.userId "
    		+ "join LicencedAccessLevel lal on um.accessLevel = lal.accessLevel "
    		+ "join LicencedAccessLevelRole lalr on lal.id = lalr.licencedAccessLevel "
    		+ "join SecurityRole sr on lalr.role = sr.id "
    		+ "where u.active = true "
    		+ "and um.moduleId = sr.module "
    		+ "and lal.licence = (select max(id) from Licence) "
    		+ "and g.name = :groupName "
    		+ "and sr.code in (:roles) "
    		+ "order by u.lastName")
})
public class User extends AbstractEntity {

    private String username;
    private String password;
    private Domain domain;
    private String firstName;
    private String lastName;
    private String title;
    private String division;
    private Long department;
    private String emailAddress;
    private String phoneNumber;
    private Boolean forcePasswordChange;
    private String setupVerificationToken;
    private Boolean active;
    private String empId;
    private Long defaultDepartment;
    private Long defaultSite;
    private Integer assignable;
    private String gender;
    private Integer age;
    private Timestamp commenceDate;
    private String dptCodeDescrp;
    private String postReportPost;
    private String postNumber;
    private String userFiledDescription;
    
    private Collection<Role> roles;
    private Set<Group> groups = new HashSet<Group>();
    private Set<Module> modules = new HashSet<Module>();

    @Column(name = "username", nullable = false, unique = true)
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    @Column(name = "password", nullable = false)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    @Column(name = "first_name")
    public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	@Column(name = "last_name")
    public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	@Column(name = "title")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Column(name = "division")
	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}
	
	@Column(name = "department")
	public Long getDepartment() {
		return department;
	}

	public void setDepartment(Long department) {
		this.department = department;
	}
	
	@Column(name = "email_address")
	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	
	@Column(name = "phone_number")
	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
	@Column(name = "force_password_change", nullable = false)
	public Boolean getForcePasswordChange() {
		return forcePasswordChange;
	}

	public void setForcePasswordChange(Boolean forcePasswordChange) {
		this.forcePasswordChange = forcePasswordChange;
	}
	
	@Column(name = "setup_verification_token")
	public String getSetupVerificationToken() {
		return setupVerificationToken;
	}

	public void setSetupVerificationToken(String setupVerificationToken) {
		this.setupVerificationToken = setupVerificationToken;
	}
	
	@Column(name = "active", nullable = false)
	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}
	
	@Column(name = "emp_id")
	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}
	
	@Column(name = "default_department")
	public Long getDefaultDepartment() {
		return defaultDepartment;
	}

	public void setDefaultDepartment(Long defaultDepartment) {
		this.defaultDepartment = defaultDepartment;
	}
	
	@Column(name = "default_site")
	public Long getDefaultSite() {
		return defaultSite;
	}

	public void setDefaultSite(Long defaultSite) {
		this.defaultSite = defaultSite;
	}
	
	@Column(name = "assignable")
	public Integer getAssignable() {
		return assignable;
	}

	public void setAssignable(Integer assignable) {
		this.assignable = assignable;
	}
	
	@Column(name = "gender")
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	@Column(name = "age")
	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}
	
	@Column(name = "commence_date")
	public Timestamp getCommenceDate() {
		return commenceDate;
	}

	public void setCommenceDate(Timestamp commenceDate) {
		this.commenceDate = commenceDate;
	}
	
	@Column(name = "dpt_code_descrp")
	public String getDptCodeDescrp() {
		return dptCodeDescrp;
	}

	public void setDptCodeDescrp(String dptCodeDescrp) {
		this.dptCodeDescrp = dptCodeDescrp;
	}
	
	@Column(name = "post_report_post")
	public String getPostReportPost() {
		return postReportPost;
	}

	public void setPostReportPost(String postReportPost) {
		this.postReportPost = postReportPost;
	}
	
	@Column(name = "post_number")
	public String getPostNumber() {
		return postNumber;
	}

	public void setPostNumber(String postNumber) {
		this.postNumber = postNumber;
	}
	
	@Column(name = "user_filed_description")
	public String getUserFiledDescription() {
		return userFiledDescription;
	}

	public void setUserFiledDescription(String userFiledDescription) {
		this.userFiledDescription = userFiledDescription;
	}

	@OneToOne
    @JoinColumn(name = "domain", nullable = false, unique = true)
    public Domain getDomain() {
		return domain;
	}

	public void setDomain(Domain domain) {
		this.domain = domain;
	}
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "users_roles",
            joinColumns = @JoinColumn(
                    name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(
                    name = "role_id", referencedColumnName = "id"))
	public Collection<Role> getRoles() {
        return roles;
    }

    public void setRoles(Collection<Role> roles) {
        this.roles = roles;
    }
    
    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "sec_user_group",
            joinColumns = @JoinColumn(
                    name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(
                    name = "group_id", referencedColumnName = "id"))
	public Set<Group> getGroups() {
		return groups;
	}

	public void setGroups(Set<Group> groups) {
		this.groups = groups;
	}
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "sec_user_module",
            joinColumns = @JoinColumn(
                    name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(
                    name = "module_id", referencedColumnName = "id"))
	public Set<Module> getModules() {
		return modules;
	}

	public void setModules(Set<Module> modules) {
		this.modules = modules;
	}
    
}
