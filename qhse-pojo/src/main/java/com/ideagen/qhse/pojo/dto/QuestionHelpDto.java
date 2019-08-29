package com.ideagen.qhse.pojo.dto;

import com.ideagen.qhse.pojo.util.Activated;
import com.ideagen.qhse.pojo.util.Descriptive;

public class QuestionHelpDto extends AbstractNameDto implements Activated, Descriptive {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String helpText;
	private boolean active;
	private boolean visible;
	private QuestionDto questionDto;
	private String questionType;

	public String getHelpText() {
		return helpText;
	}

	public void setHelpText(String helpText) {
		this.helpText = helpText;
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

	public QuestionDto getQuestionDto() {
		return questionDto;
	}

	public void setQuestionDto(QuestionDto questionDto) {
		this.questionDto = questionDto;
	}

	public String getQuestionType() {
		return questionType;
	}

	public void setQuestionType(String questionType) {
		this.questionType = questionType;
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
