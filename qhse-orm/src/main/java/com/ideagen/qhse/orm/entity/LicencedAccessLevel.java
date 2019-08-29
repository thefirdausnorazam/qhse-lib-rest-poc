package com.ideagen.qhse.orm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "sec_licenced_access_level")
public class LicencedAccessLevel extends AbstractEntity {

	private Long licence;
	private String accessLevel;
	
	@Column(name = "licence")
	public Long getLicence() {
		return licence;
	}

	public void setLicence(Long licence) {
		this.licence = licence;
	}
	
	@Column(name = "access_level")
	public String getAccessLevel() {
		return accessLevel;
	}

	public void setAccessLevel(String accessLevel) {
		this.accessLevel = accessLevel;
	}

}
