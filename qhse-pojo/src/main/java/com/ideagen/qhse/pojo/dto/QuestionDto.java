package com.ideagen.qhse.pojo.dto;

import com.ideagen.qhse.pojo.util.Activated;
import com.ideagen.qhse.pojo.util.Descriptive;

public class QuestionDto extends AbstractNameDto implements Activated, Descriptive, java.io.Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codeName;
	private String furtherInfo;
	private String answerType;
	private boolean active;
	private boolean visible;
	private QuestionDto parentQuestionDto;
	private QuestionHelpDto helpDto;
	private Long masterId;
	private String questionType;
	//TODO
	private String copiedFrom;
	private boolean pictogramActive;
	
	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	public String getFurtherInfo() {
		return furtherInfo;
	}

	public void setFurtherInfo(String furtherInfo) {
		this.furtherInfo = furtherInfo;
	}

	public String getAnswerType() {
		return answerType;
	}

	public void setAnswerType(String answerType) {
		this.answerType = answerType;
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

	public QuestionDto getParentQuestionDto() {
		return parentQuestionDto;
	}

	public void setParentQuestionDto(QuestionDto parentQuestionDto) {
		this.parentQuestionDto = parentQuestionDto;
	}

	public QuestionHelpDto getHelpDto() {
		return helpDto;
	}

	public void setHelpDto(QuestionHelpDto helpDto) {
		this.helpDto = helpDto;
	}

	public Long getMasterId() {
		return masterId;
	}

	public void setMasterId(Long masterId) {
		this.masterId = masterId;
	}

	public String getQuestionType() {
		return questionType;
	}

	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}

	public String getCopiedFrom() {
		return copiedFrom;
	}

	public void setCopiedFrom(String copiedFrom) {
		this.copiedFrom = copiedFrom;
	}

	public boolean isPictogramActive() {
		return pictogramActive;
	}

	public void setPictogramActive(boolean pictogramActive) {
		this.pictogramActive = pictogramActive;
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
