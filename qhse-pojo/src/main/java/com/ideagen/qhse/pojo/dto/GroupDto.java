package com.ideagen.qhse.pojo.dto;

public class GroupDto extends AbstractNameDto {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Boolean siteGroup;
	private SiteDto siteDto;

	public Boolean getSiteGroup() {
		return siteGroup;
	}

	public void setSiteGroup(Boolean siteGroup) {
		this.siteGroup = siteGroup;
	}

	public SiteDto getSiteDto() {
		return siteDto;
	}

	public void setSiteDto(SiteDto siteDto) {
		this.siteDto = siteDto;
	}

}
