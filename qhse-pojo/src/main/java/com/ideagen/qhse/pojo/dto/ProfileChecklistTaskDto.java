package com.ideagen.qhse.pojo.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Set;

import com.ideagen.qhse.pojo.constants.CommonConstants;

public class ProfileChecklistTaskDto extends AbstractNameDto {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public ProfileChecklistTaskDto() {
		setPrefix(CommonConstants.LAW_COMPLIANCE_TASK);
	}
	
	public ProfileChecklistTaskDto(SiteDto siteDto, int version, String type, String name, String status, Date creationDate,
			Date targetCompletionDate, UserDto responsibleUserDto, ProfileMainDto profileMainDto, long checklistId, Timestamp createdTs,
			UserDto createdByUser) {
		this.siteDto = siteDto;
		this.version = version;
		this.type = type;
		this.name = name;
		this.status = status;
		this.creationDate = creationDate;
		this.targetCompletionDate = targetCompletionDate;
		this.responsibleUserDto = responsibleUserDto;
		this.profileMainDto = profileMainDto;
		this.checklistId = checklistId;
		this.createdTs = createdTs;
		this.createdByUserDto = createdByUser;
	}

	public ProfileChecklistTaskDto(ProfileChecklistTaskDto profileChecklistTaskDto, SiteDto siteDto, int version, String type,
			String name, String status, Date creationDate, Date targetCompletionDate, UserDto responsibleUserDto,
			Boolean achieved, ProfileMainDto profileMainDto, long checklistId, UserDto completedByUserDto, String completionComment,
			Date completionDate, String additionalInformation, Timestamp createdTs, UserDto createdByUser, Timestamp lastUpdatedTs,
			UserDto lastUpdatedByUser, String priority, QuestionOptionDto responsibleDepartmentDto,
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
		this.profileMainDto = profileMainDto;
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
		this.responsibleDepartmentDto = responsibleDepartmentDto;
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
	
	private ProfileMainDto profileMainDto;
	
	private long checklistId;
	
	private UserDto completedByUserDto;
	
	private String completionComment;
	
	private Date completionDate;
	
	private String additionalInformation;
	
	private String priority;
	
	private QuestionOptionDto responsibleDepartmentDto;
	
	private Set<RiskBusinessAreaDto> businessAreaDtos;
	
	private String prefix;

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

	public ProfileMainDto getProfileMainDto() {
		return profileMainDto;
	}

	public void setProfileMainDto(ProfileMainDto profileMainDto) {
		this.profileMainDto = profileMainDto;
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

	public QuestionOptionDto getResponsibleDepartmentDto() {
		return responsibleDepartmentDto;
	}

	public void setResponsibleDepartmentDto(QuestionOptionDto responsibleDepartmentDto) {
		this.responsibleDepartmentDto = responsibleDepartmentDto;
	}

	public Set<RiskBusinessAreaDto> getBusinessAreaDtos() {
		return businessAreaDtos;
	}

	public void setBusinessAreaDtos(Set<RiskBusinessAreaDto> businessAreaDtos) {
		this.businessAreaDtos = businessAreaDtos;
	}

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}
	
	public String getDisplayId() {
        StringBuffer sb = new StringBuffer();
        sb.append(getPrefix()).append(getId());
        return sb.toString();
    }
	
}
