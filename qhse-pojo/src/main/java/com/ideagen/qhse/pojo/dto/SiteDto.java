package com.ideagen.qhse.pojo.dto;

import java.sql.Timestamp;

public class SiteDto extends AbstractNameDto {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public SiteDto() {
	}

	public SiteDto(int version, String name) {
		this.version = version;
		this.name = name;
	}
	//TODO
	public SiteDto(int version, String name, String schema, Timestamp createdTs, UserDto createdByUser, Timestamp lastUpdatedTs,
			UserDto lastUpdatedByUser/*, Set<ProfileLegalMain> profileLegalMains, Set<SecGroup> secGroups,
			Set<ChangePlan> changePlans, Set<RiskTemplate> riskTemplates,
			Set<SecSiteReportingGroup> secSiteReportingGroups,
			Set<ClientQuestionsOptionDependsOn> clientQuestionsOptionDependsOns, Set<HealthRecord> healthRecords,
			Set<RiskAssessment> riskAssessments, Set<Auditee> auditees, Set<CauseType> causeTypes,
			Set<MeasurementReadingPoint> measurementReadingPoints, Set<WasteType> wasteTypes,
			Set<AuditProgrammeType> auditProgrammeTypes, Set<AuditPlan> auditPlans,
			Set<CommonQuestionsOption> commonQuestionsOptions, Set<DocControlGroup> docControlGroups,
			Set<ChangeProgrammeType> changeProgrammeTypes, Set<HazardTask> hazardTasks, Set<ActionTask> actionTasks,
			Set<RiskObjective> riskObjectives, Set<DocControlAudience> docControlAudiences, Set<RiskTask> riskTasks,
			Set<ActionJustification> actionJustifications, Set<AuditProgramme> auditProgrammes, Set<Reportee> reportees,
			Set<ChangeTemplate> changeTemplates, Set<DocLinkCategory> docLinkCategories,
			Set<DocumentLinkHolder> documentLinkHolders, Set<AuditTemplateActiveSite> auditTemplateActiveSites,
			Set<Help> helps, Set<Trainee> trainees, Set<ClientQuestionsOption> clientQuestionsOptions,
			Set<ClientTemplateQuestion> clientTemplateQuestions, Set<Action> actions, Set<IncidentType> incidentTypes,
			Set<MeasurementQuantityCategory> measurementQuantityCategories,
			Set<ProfileChecklistTask> profileChecklistTasks, Set<Incident> incidents,
			Set<RiskAssessmentRevision> riskAssessmentRevisions, Set<Notification> notifications,
			Set<GeneralQuickLink> generalQuickLinks, Set<RiskThreshold> riskThresholds,
			Set<ChangeHistory> changeHistories, Set<WasteConsignment> wasteConsignments,
			Set<MaintenanceRecord> maintenanceRecords*/) {
		this.version = version;
		this.name = name;
		this.schema = schema;
		this.createdTs = createdTs;
		this.createdByUserDto = createdByUser;
		this.lastUpdatedTs = lastUpdatedTs;
		this.lastUpdatedByUserDto = lastUpdatedByUser;
		/*this.profileLegalMains = profileLegalMains;
		this.secGroups = secGroups;
		this.changePlans = changePlans;
		this.riskTemplates = riskTemplates;
		this.secSiteReportingGroups = secSiteReportingGroups;
		this.clientQuestionsOptionDependsOns = clientQuestionsOptionDependsOns;
		this.healthRecords = healthRecords;
		this.riskAssessments = riskAssessments;
		this.auditees = auditees;
		this.causeTypes = causeTypes;
		this.measurementReadingPoints = measurementReadingPoints;
		this.wasteTypes = wasteTypes;
		this.auditProgrammeTypes = auditProgrammeTypes;
		this.auditPlans = auditPlans;
		this.commonQuestionsOptions = commonQuestionsOptions;
		this.docControlGroups = docControlGroups;
		this.changeProgrammeTypes = changeProgrammeTypes;
		this.hazardTasks = hazardTasks;
		this.actionTasks = actionTasks;
		this.riskObjectives = riskObjectives;
		this.docControlAudiences = docControlAudiences;
		this.riskTasks = riskTasks;
		this.actionJustifications = actionJustifications;
		this.auditProgrammes = auditProgrammes;
		this.reportees = reportees;
		this.changeTemplates = changeTemplates;
		this.docLinkCategories = docLinkCategories;
		this.documentLinkHolders = documentLinkHolders;
		this.auditTemplateActiveSites = auditTemplateActiveSites;
		this.helps = helps;
		this.trainees = trainees;
		this.clientQuestionsOptions = clientQuestionsOptions;
		this.clientTemplateQuestions = clientTemplateQuestions;
		this.actions = actions;
		this.incidentTypes = incidentTypes;
		this.measurementQuantityCategories = measurementQuantityCategories;
		this.profileChecklistTasks = profileChecklistTasks;
		this.incidents = incidents;
		this.riskAssessmentRevisions = riskAssessmentRevisions;
		this.notifications = notifications;
		this.generalQuickLinks = generalQuickLinks;
		this.riskThresholds = riskThresholds;
		this.changeHistories = changeHistories;
		this.wasteConsignments = wasteConsignments;
		this.maintenanceRecords = maintenanceRecords;*/
	}

	private String schema;

	public String getSchema() {
		return schema;
	}

	public void setSchema(String schema) {
		this.schema = schema;
	}
	
}
