package com.ideagen.qhse.orm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table(name = "common_questions_question")
public class Question extends AbstractNamedEntity {

	// =========================================================================
	// Fields
	// =========================================================================
	private String codeName;
	private String furtherInfo;
	private String answerType;
	private boolean active;
	private boolean visible;
	private Question parentQuestion;
	private QuestionHelp help;
	private Long masterId;
	private String questionType;
	private Question copiedFrom;
	private boolean pictogramActive;
	
	@Column(name = "code_name", unique = true, nullable = false)
	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	
	@Column(name = "further_info", length = 16777215)
	public String getFurtherInfo() {
		return furtherInfo;
	}

	public void setFurtherInfo(String furtherInfo) {
		this.furtherInfo = furtherInfo;
	}
	
	@Column(name = "answer_type", nullable = false, length = 30)
	public String getAnswerType() {
		return answerType;
	}

	public void setAnswerType(String answerType) {
		this.answerType = answerType;
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
	@JoinColumn(name = "parent_id", updatable = false)
	public Question getParentQuestion() {
		return parentQuestion;
	}

	public void setParentQuestion(Question parentQuestion) {
		this.parentQuestion = parentQuestion;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "help_id", updatable = false)
	@NotFound(action=NotFoundAction.IGNORE)
	public QuestionHelp getHelp() {
		return help;
	}

	public void setHelp(QuestionHelp help) {
		this.help = help;
	}
	
	
	@Column(name = "master_id")
	public Long getMasterId() {
		return masterId;
	}

	public void setMasterId(Long masterId) {
		this.masterId = masterId;
	}
	
	@Column(name = "question_type")
	public String getQuestionType() {
		return questionType;
	}

	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "copied_from", updatable = false)
	public Question getCopiedFrom() {
		return copiedFrom;
	}

	public void setCopiedFrom(Question copiedFrom) {
		this.copiedFrom = copiedFrom;
	}
	
	@Column(name = "pictogram_active", nullable = false)
	public boolean isPictogramActive() {
		return pictogramActive;
	}

	public void setPictogramActive(boolean pictogramActive) {
		this.pictogramActive = pictogramActive;
	}

}
