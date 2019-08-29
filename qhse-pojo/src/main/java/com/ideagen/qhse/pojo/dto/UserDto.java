package com.ideagen.qhse.pojo.dto;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

public class UserDto extends AbstractDto {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    private String firstName;
    private String username;
    private String password;
    private DomainDto domainDto;
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
    
    private Collection<RoleDto> roleDtos;
    private Set<GroupDto> groupsDto = new HashSet<GroupDto>();
    private Set<ModuleDto> modulesDto = new HashSet<ModuleDto>();

    
	public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
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
    
    public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public Long getDepartment() {
		return department;
	}

	public void setDepartment(Long department) {
		this.department = department;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Boolean getForcePasswordChange() {
		return forcePasswordChange;
	}

	public void setForcePasswordChange(Boolean forcePasswordChange) {
		this.forcePasswordChange = forcePasswordChange;
	}

	public String getSetupVerificationToken() {
		return setupVerificationToken;
	}

	public void setSetupVerificationToken(String setupVerificationToken) {
		this.setupVerificationToken = setupVerificationToken;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public Long getDefaultDepartment() {
		return defaultDepartment;
	}

	public void setDefaultDepartment(Long defaultDepartment) {
		this.defaultDepartment = defaultDepartment;
	}

	public Long getDefaultSite() {
		return defaultSite;
	}

	public void setDefaultSite(Long defaultSite) {
		this.defaultSite = defaultSite;
	}

	public Integer getAssignable() {
		return assignable;
	}

	public void setAssignable(Integer assignable) {
		this.assignable = assignable;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public Timestamp getCommenceDate() {
		return commenceDate;
	}

	public void setCommenceDate(Timestamp commenceDate) {
		this.commenceDate = commenceDate;
	}

	public String getDptCodeDescrp() {
		return dptCodeDescrp;
	}

	public void setDptCodeDescrp(String dptCodeDescrp) {
		this.dptCodeDescrp = dptCodeDescrp;
	}

	public String getPostReportPost() {
		return postReportPost;
	}

	public void setPostReportPost(String postReportPost) {
		this.postReportPost = postReportPost;
	}

	public String getPostNumber() {
		return postNumber;
	}

	public void setPostNumber(String postNumber) {
		this.postNumber = postNumber;
	}

	public String getUserFiledDescription() {
		return userFiledDescription;
	}

	public void setUserFiledDescription(String userFiledDescription) {
		this.userFiledDescription = userFiledDescription;
	}

	public Collection<RoleDto> getRoleDtos() {
		return roleDtos;
	}

	public void setRoleDtos(Collection<RoleDto> roleDtos) {
		this.roleDtos = roleDtos;
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

    public Set<GroupDto> getGroupsDto() {
		return groupsDto;
	}

	public void setGroupsDto(Set<GroupDto> groupsDto) {
		this.groupsDto = groupsDto;
	}

	public Set<ModuleDto> getModulesDto() {
		return modulesDto;
	}

	public void setModulesDto(Set<ModuleDto> modulesDto) {
		this.modulesDto = modulesDto;
	}

	@Override
    public String toString() {
        return "{" +
        		"id='" + id + '\'' +
                "firstName='" + firstName + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", domain='" + domainDto + '\'' +
                ", roles='" + roleDtos + '\'' +
                '}';
    }
}
