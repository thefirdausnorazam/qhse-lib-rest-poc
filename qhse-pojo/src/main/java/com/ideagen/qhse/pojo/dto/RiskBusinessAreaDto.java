package com.ideagen.qhse.pojo.dto;

import java.sql.Timestamp;

public class RiskBusinessAreaDto extends AbstractNameDto {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public RiskBusinessAreaDto() {
	}
	
	public RiskBusinessAreaDto(int version, String name, Timestamp createdTs, UserDto createdByUser) {
		this.version = version;
		this.name = name;
		this.createdTs = createdTs;
		this.createdByUserDto = createdByUser;
	}
	
	//TODO: Need to add more fields
	public RiskBusinessAreaDto(int version, String name, Boolean active, Timestamp createdTs, UserDto createdByUser,
			Timestamp lastUpdatedTs, UserDto lastUpdatedByUser/*, Set<RiskObjective> riskObjectives,
			Set<ChangeProgramme> changeProgrammes, Set<Audit> audits, Set<AuditProgramme> auditProgrammes,
			Set<ChangeAssessment> changeAssessments, Set<ChangePlan> changePlans,
			Set<AudRecurringAudit> audRecurringAudits, Set<RiskAssessment> riskAssessments,
			Set<RiskManagementProgramme> riskManagementProgrammes, Set<ProfileChecklistTask> profileChecklistTasks,
			Set<MeasurementReadingPoint> measurementReadingPoints, Set<ActionTask> actionTasks, Set<RiskTask> riskTasks,
			Set<Incident> incidents, Set<HazardTask> hazardTasks, Set<RiskTemplate> riskTemplates, Set<Action> actions,
			Set<RiskCategory> riskCategories, Set<DocControlDoc> docControlDocs,
			Set<MeasurementReading> measurementReadings*/) {
		this.version = version;
		this.name = name;
		this.active = active;
		this.createdTs = createdTs;
		this.createdByUserDto = createdByUser;
		this.lastUpdatedTs = lastUpdatedTs;
		this.lastUpdatedByUserDto = lastUpdatedByUser;
		/*this.riskObjectives = riskObjectives;
		this.changeProgrammes = changeProgrammes;
		this.audits = audits;
		this.auditProgrammes = auditProgrammes;
		this.changeAssessments = changeAssessments;
		this.changePlans = changePlans;
		this.audRecurringAudits = audRecurringAudits;
		this.riskAssessments = riskAssessments;
		this.riskManagementProgrammes = riskManagementProgrammes;
		this.profileChecklistTasks = profileChecklistTasks;
		this.measurementReadingPoints = measurementReadingPoints;
		this.actionTasks = actionTasks;
		this.riskTasks = riskTasks;
		this.incidents = incidents;
		this.hazardTasks = hazardTasks;
		this.riskTemplates = riskTemplates;
		this.actions = actions;
		this.riskCategories = riskCategories;
		this.docControlDocs = docControlDocs;
		this.measurementReadings = measurementReadings;*/
	}
	
	private Boolean active;
	
	public Boolean getActive() {
		return this.active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

}
