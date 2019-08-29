package com.ideagen.qhse.orm.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MappedSuperclass;
import javax.persistence.OneToOne;
import javax.persistence.Version;

@MappedSuperclass
public class AbstractEntity {
	
	protected Long id;
	protected Integer version;
	protected Timestamp lastUpdatedTs;
	protected Timestamp createdTs;
	protected User lastUpdatedByUser;
	protected User createdByUser;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
        if (id != null && version == null) {
            setVersion(Integer.valueOf(1));
        }
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
