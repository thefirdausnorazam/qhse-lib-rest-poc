package com.ideagen.qhse.pojo.dto;

import java.util.HashSet;
import java.util.Set;

import com.ideagen.qhse.pojo.util.Activated;
import com.ideagen.qhse.pojo.util.Descriptive;

public class QuestionOptionDto extends AbstractNameDto implements Activated, Descriptive, java.io.Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int optionOrder;
	private QuestionDto questionDto;
	private String furtherInfo;
	private boolean active;
	private boolean visible;
	private QuestionOptionDto dependsOnDto;
	private Long masterId;
	private String dependsOnMultipleOptionIds;
    private boolean obsolete;
    private String pictogram;
    protected Set<SiteDto> inactiveInSitesDto = new HashSet<SiteDto>();

	public int getOptionOrder() {
		return optionOrder;
	}

	public void setOptionOrder(int optionOrder) {
		this.optionOrder = optionOrder;
	}

	public String getFurtherInfo() {
		return furtherInfo;
	}

	public void setFurtherInfo(String furtherInfo) {
		this.furtherInfo = furtherInfo;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public boolean isVisible() {
		return visible;
	}

	public void setVisible(boolean visible) {
		this.visible = visible;
	}

	public Long getMasterId() {
		return masterId;
	}

	public void setMasterId(Long masterId) {
		this.masterId = masterId;
	}

	public String getDependsOnMultipleOptionIds() {
		return dependsOnMultipleOptionIds;
	}

	public void setDependsOnMultipleOptionIds(String dependsOnMultipleOptionIds) {
		this.dependsOnMultipleOptionIds = dependsOnMultipleOptionIds;
	}

	public boolean isObsolete() {
		return obsolete;
	}

	public void setObsolete(boolean obsolete) {
		this.obsolete = obsolete;
	}

	public String getPictogram() {
		return pictogram;
	}

	public void setPictogram(String pictogram) {
		this.pictogram = pictogram;
	}

	public QuestionDto getQuestionDto() {
		return questionDto;
	}

	public void setQuestionDto(QuestionDto questionDto) {
		this.questionDto = questionDto;
	}

	public QuestionOptionDto getDependsOnDto() {
		return dependsOnDto;
	}

	public void setDependsOnDto(QuestionOptionDto dependsOnDto) {
		this.dependsOnDto = dependsOnDto;
	}
	
	public Set<SiteDto> getInactiveInSitesDto() {
		return inactiveInSitesDto;
	}

	public void setInactiveInSitesDto(Set<SiteDto> inactiveInSitesDto) {
		this.inactiveInSitesDto = inactiveInSitesDto;
	}

	@Override
	public String getDescription() {
		return getName();
	}

	@Override
	public boolean isActiveInCurrentSite() {
		return this.isActive();
	}

}
