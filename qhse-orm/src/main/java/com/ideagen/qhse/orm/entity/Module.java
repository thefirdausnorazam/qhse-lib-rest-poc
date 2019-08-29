package com.ideagen.qhse.orm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

@Entity
@Table(name = "sec_module")
@NamedQueries({ @NamedQuery(name = "module.listByName", query = "from Module g where g.name = :name") })
public class Module extends AbstractNamedEntity {

	private String code;

	public String getCode() {
		return code;
	}
	
	@Column(name = "code", nullable = false)
	public void setCode(String code) {
		this.code = code;
	}

}
