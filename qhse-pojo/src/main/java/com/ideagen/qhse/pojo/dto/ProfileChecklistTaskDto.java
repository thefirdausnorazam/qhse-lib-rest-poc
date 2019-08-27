package com.ideagen.qhse.pojo.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Set;

public class ProfileChecklistTaskDto extends AbstractNameDto implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public ProfileChecklistTaskDto() {
	}
	
	public ProfileChecklistTaskDto(SiteDto siteDto, int version, String type, String name, String status, Date creationDate,
			Date targetCompletionDate, UserDto responsibleUserDto, long profileId, long checklistId, Timestamp createdTs,
			UserDto createdByUser) {
		this.siteDto = siteDto;
		this.version = version;
		this.type = type;
		this.name = name;
		this.status = status;
		this.creationDate = creationDate;
		this.targetCompletionDate = targetCompletionDate;
		this.responsibleUserDto = responsibleUserDto;
		this.profileId = profileId;
		this.checklistId = checklistId;
		this.createdTs = createdTs;
		this.createdByUserDto = createdByUser;
	}

	public ProfileChecklistTaskDto(ProfileChecklistTaskDto profileChecklistTaskDto, SiteDto siteDto, int version, String type,
			String name, String status, Date creationDate, Date targetCompletionDate, UserDto responsibleUserDto,
			Boolean achieved, long profileId, long checklistId, UserDto completedByUserDto, String completionComment,
			Date completionDate, String additionalInformation, Timestamp createdTs, UserDto createdByUser, Timestamp lastUpdatedTs,
			UserDto lastUpdatedByUser, String priority, Long responsibleDepartment,
			Set<RiskBusinessAreaDto> businessAreaDtos, Set<ProfileChecklistTaskDto> profileChecklistTasksDto) {
		this.profileChecklistTaskDto = profileChecklistTaskDto;
		this.siteDto = siteDto;
		this.version = version;
		this.type = type;
		this.name = name;
		this.status = status;
		this.creationDate = creationDate;
		this.targetCompletionDate = targetCompletionDate;
		this.responsibleUserDto = responsibleUserDto;
		this.achieved = achieved;
		this.profileId = profileId;
		this.checklistId = checklistId;
		this.completedByUserDto = completedByUserDto;
		this.completionComment = completionComment;
		this.completionDate = completionDate;
		this.additionalInformation = additionalInformation;
		this.createdTs = createdTs;
		this.createdByUserDto = createdByUser;
		this.lastUpdatedTs = lastUpdatedTs;
		this.lastUpdatedByUserDto = lastUpdatedByUser;
		this.priority = priority;
		this.responsibleDepartment = responsibleDepartment;
		this.businessAreaDtos = businessAreaDtos;
		//this.profileChecklistTasks = profileChecklistTasks;
	}
	
	private ProfileChecklistTaskDto profileChecklistTaskDto;
	
	private SiteDto siteDto;
	
	private String type;
	
	private String status;
	
	private Date creationDate;
	
	private Date targetCompletionDate;
	
	private UserDto responsibleUserDto;
	
	private Boolean achieved;
	
	private long profileId;
	
	private long checklistId;
	
	private UserDto completedByUserDto;
	
	private String completionComment;
	
	private Date completionDate;
	
	private String additionalInformation;
	
	private String priority;
	
	private Long responsibleDepartment;
	//TODO:
	private Set<RiskBusinessAreaDto> businessAreaDtos;

	public ProfileChecklistTaskDto getProfileChecklistTaskDto() {
		return profileChecklistTaskDto;
	}

	public void setProfileChecklistTaskDto(ProfileChecklistTaskDto profileChecklistTaskDto) {
		this.profileChecklistTaskDto = profileChecklistTaskDto;
	}

	public SiteDto getSiteDto() {
		return siteDto;
	}

	public void setSiteDto(SiteDto siteDto) {
		this.siteDto = siteDto;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public Date getTargetCompletionDate() {
		return targetCompletionDate;
	}

	public void setTargetCompletionDate(Date targetCompletionDate) {
		this.targetCompletionDate = targetCompletionDate;
	}

	public UserDto getResponsibleUserDto() {
		return responsibleUserDto;
	}

	public void setResponsibleUserDto(UserDto responsibleUserDto) {
		this.responsibleUserDto = responsibleUserDto;
	}

	public Boolean getAchieved() {
		return achieved;
	}

	public void setAchieved(Boolean achieved) {
		this.achieved = achieved;
	}

	public long getProfileId() {
		return profileId;
	}

	public void setProfileId(long profileId) {
		this.profileId = profileId;
	}

	public long getChecklistId() {
		return checklistId;
	}

	public void setChecklistId(long checklistId) {
		this.checklistId = checklistId;
	}

	public UserDto getCompletedByUserDto() {
		return completedByUserDto;
	}

	public void setCompletedByUserDto(UserDto completedByUserDto) {
		this.completedByUserDto = completedByUserDto;
	}

	public String getCompletionComment() {
		return completionComment;
	}

	public void setCompletionComment(String completionComment) {
		this.completionComment = completionComment;
	}

	public Date getCompletionDate() {
		return completionDate;
	}

	public void setCompletionDate(Date completionDate) {
		this.completionDate = completionDate;
	}

	public String getAdditionalInformation() {
		return additionalInformation;
	}

	public void setAdditionalInformation(String additionalInformation) {
		this.additionalInformation = additionalInformation;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public Long getResponsibleDepartment() {
		return responsibleDepartment;
	}

	public void setResponsibleDepartment(Long responsibleDepartment) {
		this.responsibleDepartment = responsibleDepartment;
	}

	public Set<RiskBusinessAreaDto> getBusinessAreaDtos() {
		return businessAreaDtos;
	}

	public void setBusinessAreaDtos(Set<RiskBusinessAreaDto> businessAreaDtos) {
		this.businessAreaDtos = businessAreaDtos;
	}
	
}
