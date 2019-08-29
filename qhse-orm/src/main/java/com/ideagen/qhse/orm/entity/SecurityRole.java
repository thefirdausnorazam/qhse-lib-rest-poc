package com.ideagen.qhse.orm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "sec_role")
public class SecurityRole extends AbstractEntity {

	private Long module;
	private String code;
	
	@Column(name = "module")
	public Long getModule() {
		return module;
	}

	public void setModule(Long module) {
		this.module = module;
	}
	
	@Column(name = "code", nullable = false)
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}
