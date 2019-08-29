package com.ideagen.qhse.orm.entity;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "sec_licence")
public class Licence extends AbstractEntity {

	private String computerCode;
	private Date expiryDate;
	private String type;
	private String signature;
	private String comment;
	private String mobile;

	@Column(name = "computer_code", nullable = false)
	public String getComputerCode() {
		return computerCode;
	}

	public void setComputerCode(String computerCode) {
		this.computerCode = computerCode;
	}
	
	@Column(name = "expiry_date", nullable = false)
	public Date getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}
	
	@Column(name = "type", nullable = false)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Column(name = "signature", nullable = false)
	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}
	
	@Column(name = "comment")
	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
	
	@Column(name = "mobile")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

}
