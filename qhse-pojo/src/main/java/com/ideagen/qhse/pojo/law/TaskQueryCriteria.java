package com.ideagen.qhse.pojo.law;

import java.sql.Date;

import com.ideagen.qhse.pojo.dto.UserDto;
import com.ideagen.qhse.pojo.query.support.SearchCriteriaSupport;
//TODO: implement UserUtils
public class TaskQueryCriteria extends SearchCriteriaSupport {

    // =========================================================================
    // Constants
    // =========================================================================

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static final String SORT_BY_ID = "id";

    public static final String SORT_BY_NAME = "description";

    public static final String SORT_BY_RESPONSIBLE_USER = "responsibleUser";

    public static final String SORT_BY_COMPLETION_DATE = "completionDate";

    public static final String SORT_BY_TARGET_COMPLETION_DATE = "targetCompletionDate";

    public static final String SORT_BY_CREATION_DATE = "creationDate";

    public static final String SORT_BY_LAST_UPDATED = "lastUpdatedTs";

    public static final String[] SORT_NAMES = { SORT_BY_ID, SORT_BY_NAME, SORT_BY_RESPONSIBLE_USER,
            SORT_BY_TARGET_COMPLETION_DATE, SORT_BY_COMPLETION_DATE, SORT_BY_CREATION_DATE, SORT_BY_LAST_UPDATED };

    // =========================================================================
    // Fields
    // =========================================================================

    private Long id;

    private Long businessAreaId;

    private String name;

    private String type;

    private String status = LawStatus.IN_PROGRESS.getName();

    private Date startDateFrom;

    private Date startDateTo;

    private Date targetCompletionDateFrom;

    private Date targetCompletionDateTo;

    private Date completionDateFrom;

    private Date completionDateTo;

    private Long responsibleUser;

    private Long departmentId;

    private Long createdByUser;

    private Boolean overdue;

	private Boolean overdueSearch = Boolean.FALSE;

    // Return tasks that as mapped to a score with the following selected option id.
    private Long scoreQuestionId;

    private Date lastUpdateDateFrom;

    private Date lastUpdateDateTo;
    
    private String priority;
    
    // =========================================================================
    // Constructors
    // =========================================================================

    /**
     *
     */
    public TaskQueryCriteria() {
        super(true);
    }

    public TaskQueryCriteria(boolean calculateTotals, int pageSize) {
        super(calculateTotals, pageSize);
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * @return a pre-configured criteria for getting tasks that are overdue for the current user.
     */
    public static TaskQueryCriteria overdueByCurrentUser() {
        TaskQueryCriteria criteria = new TaskQueryCriteria(true, 0);
        //criteria.setResponsibleUser(UserUtils.currentUser());
        criteria.setOverdue(Boolean.TRUE);
        criteria.setSortName(SORT_BY_ID);
        return criteria;
    }

    /**
     * @return the id
     */
    public Long getId() {
        return this.id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * @return the businessAreaId
     */
    public Long getBusinessAreaId() {
        return this.businessAreaId;
    }

    /**
     * @param businessAreaId the businessAreaId to set
     */
    public void setBusinessAreaId(Long businessAreaId) {
        this.businessAreaId = businessAreaId;
    }

    public Date getLastUpdateDateFrom() {
		return lastUpdateDateFrom;
	}

	public void setLastUpdateDateFrom(Date lastUpdateDateFrom) {
		this.lastUpdateDateFrom = lastUpdateDateFrom;
	}

	public Date getLastUpdateDateTo() {
		return lastUpdateDateTo;
	}

	public void setLastUpdateDateTo(Date lastUpdateDateTo) {
		this.lastUpdateDateTo = lastUpdateDateTo;
	}

    /**
     * @return the completionDateFrom
     */
    public Date getCompletionDateFrom() {
        return completionDateFrom;
    }

    /**
     * @param completionDateFrom the completionDateFrom to set
     */
    public void setCompletionDateFrom(Date completionDateFrom) {
        this.completionDateFrom = completionDateFrom;
    }

    /**
     * @return the completionDateTo
     */
    public Date getCompletionDateTo() {
        return completionDateTo;
    }
    
    /**
     * @return Returns the startDateTo plus (23 hrs 59 mins ...).
     */
    public Date getCompletionDateToEOD() {
        return toEndOfDayExact(completionDateTo);
    }

    /**
     * @param completionDateTo the completionDateTo to set
     */
    public void setCompletionDateTo(Date completionDateTo) {
        this.completionDateTo = completionDateTo;
    }

    /**
     * @return the createdByUser
     */
    public Long getCreatedByUser() {
        return createdByUser;
    }

    /**
     * @param createdByUser the createdByUser to set
     */
    public void setCreatedByUser(Long createdByUser) {
        this.createdByUser = createdByUser;
    }

    /**
     * @return the departmentId
     */
    public Long getDepartmentId() {
        return this.departmentId;
    }

    /**
     * @param departmentId the departmentId to set
     */
    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }

    /**
     * @return the name
     */
    public String getName() {
        return this.name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @param overdue the overdue to set
     */
    public Boolean getOverdue() {
        return this.overdue;
    }

    /**
     * @return the overdue
     */
    public void setOverdue(Boolean overdue) {
        this.overdue = overdue;
    }

    /**
     * @return Returns the overdueSearch.
     */
    public Boolean getOverdueSearch() {
        return overdueSearch;
    }

    /**
     * @param overdueSearch The overdueSearch to set.
     */
    public void setOverdueSearch(Boolean overdueSearch) {
        this.overdueSearch = overdueSearch;
    }

    /**
     * @return the responsibleUser
     */
    public Long getResponsibleUser() {
        return this.responsibleUser;
    }

    /**
     * @param responsibleUser the responsibleUser to set
     */
    public void setResponsibleUser(Long responsibleUser) {
        this.responsibleUser = responsibleUser;
    }

    /**
     * @return the scoreQuestionId
     */
    public Long getScoreQuestionId() {
        return this.scoreQuestionId;
    }

    /**
     * @param scoreQuestionId the scoreQuestionId to set
     */
    public void setScoreQuestionId(Long scoreQuestionId) {
        this.scoreQuestionId = scoreQuestionId;
    }

    /**
     * @return the startDateFrom
     */
    public Date getStartDateFrom() {
        return this.startDateFrom;
    }

    /**
     * @param startDateFrom the startDateFrom to set
     */
    public void setStartDateFrom(Date startDateFrom) {
        this.startDateFrom = startDateFrom;
    }

    /**
     * @return the startDateTo
     */
    public Date getStartDateTo() {
        return this.startDateTo;
    }

    /**
     * @param startDateTo the startDateTo to set
     */
    public void setStartDateTo(Date startDateTo) {
        this.startDateTo = startDateTo;
    }
    
    /**
     * @return Returns the startDateTo plus (23 hrs 59 mins ...).
     */
    public Date getStartDateToEOD() {
        return toEndOfDayExact(startDateTo);
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return this.status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return true if the status is not set, otherwise null.
     */
    public Boolean getStatusNotSet() {
        return getStatus() == null ? Boolean.TRUE : null;
    }

    /**
     * @return the targetCompletionDateFrom
     */
    public Date getTargetCompletionDateFrom() {
        return targetCompletionDateFrom;
    }

    /**
     * @param targetCompletionDateFrom the targetCompletionDateFrom to set
     */
    public void setTargetCompletionDateFrom(Date targetCompletionDateFrom) {
        this.targetCompletionDateFrom = targetCompletionDateFrom;
    }

    /**
     * @return the targetCompletionDateTo
     */
    public Date getTargetCompletionDateTo() {
        return targetCompletionDateTo;
    }

    /**
     * @param targetCompletionDateTo the targetCompletionDateTo to set
     */
    public void setTargetCompletionDateTo(Date targetCompletionDateTo) {
        this.targetCompletionDateTo = targetCompletionDateTo;
    }
    
    /**
     * @return Returns the startDateTo plus (23 hrs 59 mins ...).
     */
    public Date getTargetCompletionDateToEOD() {
        return toEndOfDayExact(targetCompletionDateTo);
    }

    /**
     * @return the type
     */
    public String getType() {
        return this.type;
    }

    /**
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public String getPriority() {
		return priority;
	}
	
	@Override
	public String toString() {
		return "TaskQueryCriteria [id=" + id + ", businessAreaId=" + businessAreaId + ", name=" + name + ", type="
				+ type + ", status=" + status + ", startDateFrom=" + startDateFrom + ", startDateTo=" + startDateTo
				+ ", targetCompletionDateFrom=" + targetCompletionDateFrom + ", targetCompletionDateTo="
				+ targetCompletionDateTo + ", completionDateFrom=" + completionDateFrom + ", completionDateTo="
				+ completionDateTo + ", responsibleUser=" + responsibleUser + ", departmentId=" + departmentId
				+ ", createdByUser=" + createdByUser + ", overdue=" + overdue + ", overdueSearch=" + overdueSearch
				+ ", scoreQuestionId=" + scoreQuestionId + ", lastUpdateDateFrom=" + lastUpdateDateFrom
				+ ", lastUpdateDateTo=" + lastUpdateDateTo + ", priority=" + priority + "]";
	}

}
