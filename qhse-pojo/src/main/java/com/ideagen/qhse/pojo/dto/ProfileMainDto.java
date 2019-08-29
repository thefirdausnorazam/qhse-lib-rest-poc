package com.ideagen.qhse.pojo.dto;

import java.sql.Date;

public class ProfileMainDto extends AbstractNameDto {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Long getOwner() {
		return owner;
	}

	public void setOwner(Long owner) {
		this.owner = owner;
	}

	public Long getModule() {
		return module;
	}

	public void setModule(Long module) {
		this.module = module;
	}

	public Long getState() {
		return state;
	}

	public void setState(Long state) {
		this.state = state;
	}

	public String getQuestionVersion() {
		return questionVersion;
	}

	public void setQuestionVersion(String questionVersion) {
		this.questionVersion = questionVersion;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Long getEffectiveOwner() {
		return effectiveOwner;
	}

	public void setEffectiveOwner(Long effectiveOwner) {
		this.effectiveOwner = effectiveOwner;
	}

	public Long getMergePid() {
		return mergePid;
	}

	public void setMergePid(Long mergePid) {
		this.mergePid = mergePid;
	}

	public Long getLatestVersion() {
		return latestVersion;
	}

	public void setLatestVersion(Long latestVersion) {
		this.latestVersion = latestVersion;
	}

	public Long getType() {
		return type;
	}

	public void setType(Long type) {
		this.type = type;
	}

	public Boolean getLoc() {
		return loc;
	}

	public void setLoc(Boolean loc) {
		this.loc = loc;
	}

}
