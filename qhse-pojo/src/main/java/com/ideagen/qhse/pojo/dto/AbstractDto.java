package com.ideagen.qhse.pojo.dto;

import java.sql.Timestamp;

public class AbstractDto {
	
	protected Long id;
	
	protected Integer version;
	
	protected Timestamp lastUpdatedTs;
	
	protected Timestamp createdTs;
	
	protected UserDto lastUpdatedByUserDto;
	
	protected UserDto createdByUserDto;
	
	public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
        if (id != null && version == null) {
            setVersion(Integer.valueOf(1));
        }
    }
	
	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public Timestamp getLastUpdatedTs() {
		return lastUpdatedTs;
	}

	public void setLastUpdatedTs(Timestamp lastUpdatedTs) {
		this.lastUpdatedTs = lastUpdatedTs;
	}

	public Timestamp getCreatedTs() {
		return createdTs;
	}

	public void setCreatedTs(Timestamp createdTs) {
		this.createdTs = createdTs;
	}

	public UserDto getLastUpdatedByUserDto() {
		return lastUpdatedByUserDto;
	}

	public void setLastUpdatedByUserDto(UserDto lastUpdatedByUserDto) {
		this.lastUpdatedByUserDto = lastUpdatedByUserDto;
	}

	public UserDto getCreatedByUserDto() {
		return createdByUserDto;
	}

	public void setCreatedByUserDto(UserDto createdByUserDto) {
		this.createdByUserDto = createdByUserDto;
	}

}
