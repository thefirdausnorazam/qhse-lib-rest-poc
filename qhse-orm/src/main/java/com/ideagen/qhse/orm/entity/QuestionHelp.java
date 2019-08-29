package com.ideagen.qhse.orm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "common_questions_help")
public class QuestionHelp extends AbstractNamedEntity {
	
	private String helpText;
	private boolean active;
	private boolean visible;
	private Question question;
	private String questionType;
	
	@Column(name = "help_text", nullable = false)
	public String getHelpText() {
		return helpText;
	}

	public void setHelpText(String helpText) {
		this.helpText = helpText;
	}
	
	@Column(name = "active", nullable = false)
	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}
	
	@Column(name = "visible", nullable = false)
	public boolean isVisible() {
		return visible;
	}

	public void setVisible(boolean visible) {
		this.visible = visible;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "question_id", updatable = false)
	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}
	
	@Column(name = "question_type")
	public String getQuestionType() {
		return questionType;
	}

	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}
	
}
