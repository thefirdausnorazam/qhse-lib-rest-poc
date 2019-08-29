package com.ideagen.qhse.orm.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Version;

@Entity
@Table(name = "sec_user_module")
//hibernate restriction composite id must implements Serializable
public class UserModule implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long userId;
	private Long moduleId;
	private String accessLevel;
	
	private Integer version;
	private Timestamp lastUpdatedTs;
	private Timestamp createdTs;
	private User lastUpdatedByUser;
	private User createdByUser;
	
	@Id
	@Column(name = "user_id", nullable = false)
	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	@Id
	@Column(name = "module_id", nullable = false)
	public Long getModuleId() {
		return moduleId;
	}

	public void setModuleId(Long moduleId) {
		this.moduleId = moduleId;
	}
	
	@Column(name = "access_level")
	public String getAccessLevel() {
		return accessLevel;
	}

	public void setAccessLevel(String accessLevel) {
		this.accessLevel = accessLevel;
	}

	@Version
	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}
	
	@Column(name = "last_updated_ts", nullable = true)
	public Timestamp getLastUpdatedTs() {
		return lastUpdatedTs;
	}
	
	public void setLastUpdatedTs(Timestamp lastUpdatedTs) {
		this.lastUpdatedTs = lastUpdatedTs;
	}
	
	@Column(name = "created_ts", nullable = false)
	public Timestamp getCreatedTs() {
		return createdTs;
	}

	public void setCreatedTs(Timestamp createdTs) {
		this.createdTs = createdTs;
	}
	
	@OneToOne
    @JoinColumn(name = "last_updated_by_user", nullable = true)
	public User getLastUpdatedByUser() {
		return lastUpdatedByUser;
	}

	public void setLastUpdatedByUser(User lastUpdatedByUser) {
		this.lastUpdatedByUser = lastUpdatedByUser;
	}
	
	@OneToOne
    @JoinColumn(name = "created_by_user", nullable = false)
	public User getCreatedByUser() {
		return createdByUser;
	}

	public void setCreatedByUser(User createdByUser) {
		this.createdByUser = createdByUser;
	}

}
