package com.ideagen.qhse.orm.entity;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "profile_main")
public class ProfileMain extends AbstractNamedEntity {

	private String description;
	private Long owner;
	private Long module;
	private Long state;
	private String questionVersion;
	private Date createDate;
	private Long effectiveOwner;
	private Long mergePid;
	private Long latestVersion;
	private Long type;
	private Boolean loc;
	
	@Column(name = "description")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Column(name = "owner", nullable = false)
	public Long getOwner() {
		return owner;
	}

	public void setOwner(Long owner) {
		this.owner = owner;
	}
	
	@Column(name = "module", nullable = false)
	public Long getModule() {
		return module;
	}

	public void setModule(Long module) {
		this.module = module;
	}
	
	@Column(name = "state", nullable = false)
	public Long getState() {
		return state;
	}

	public void setState(Long state) {
		this.state = state;
	}
	
	@Column(name = "question_version", nullable = false)
	public String getQuestionVersion() {
		return questionVersion;
	}

	public void setQuestionVersion(String questionVersion) {
		this.questionVersion = questionVersion;
	}
	
	@Column(name = "create_date", nullable = false)
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	@Column(name = "effective_owner", nullable = false)
	public Long getEffectiveOwner() {
		return effectiveOwner;
	}

	public void setEffectiveOwner(Long effectiveOwner) {
		this.effectiveOwner = effectiveOwner;
	}
	
	@Column(name = "merge_pid", nullable = false)
	public Long getMergePid() {
		return mergePid;
	}

	public void setMergePid(Long mergePid) {
		this.mergePid = mergePid;
	}
	
	@Column(name = "latest_version", nullable = false)
	public Long getLatestVersion() {
		return latestVersion;
	}

	public void setLatestVersion(Long latestVersion) {
		this.latestVersion = latestVersion;
	}
	
	@Column(name = "type", nullable = false)
	public Long getType() {
		return type;
	}

	public void setType(Long type) {
		this.type = type;
	}
	
	@Column(name = "loc", nullable = false)
	public Boolean getLoc() {
		return loc;
	}

	public void setLoc(Boolean loc) {
		this.loc = loc;
	}

}
