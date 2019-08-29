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
@Table(name = "sec_licenced_access_level_role")
//hibernate restriction composite id must implements Serializable
public class LicencedAccessLevelRole implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long licencedAccessLevel;
	private Long role;
	
	private Integer version;
	private Timestamp lastUpdatedTs;
	private Timestamp createdTs;
	private User lastUpdatedByUser;
	private User createdByUser;
	
	@Id
	@Column(name = "licenced_access_level", nullable = false)
	public Long getLicencedAccessLevel() {
		return licencedAccessLevel;
	}
	
	public void setLicencedAccessLevel(Long licencedAccessLevel) {
		this.licencedAccessLevel = licencedAccessLevel;
	}
	
	@Id
	@Column(name = "role", nullable = false)
	public Long getRole() {
		return role;
	}

	public void setRole(Long role) {
		this.role = role;
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
