package com.ideagen.qhse.orm.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

@Entity
@Table(name = "common_questions_option")
@NamedQueries({
    @NamedQuery(name = "questionOption.listSearchable", query = "from QuestionOption o where (o.active=true OR o.obsolete=true) and o.question.id=:questionId order by o.optionOrder"),
    @NamedQuery(name = "questionOption.listByQuestionName", query = "from QuestionOption q where q.name = :name")
})
public class QuestionOption extends AbstractNamedEntity {
	
	private Long optionOrder;
	private Question question;
	private String furtherInfo;
	private boolean active;
	private boolean visible;
	private QuestionOption dependsOn;
	private Long masterId;
	private String dependsOnMultipleOptionIds;
    private boolean obsolete;
    private String pictogram;
    //active by default so store inactive
    protected Set<Site> inactiveInSites = new HashSet<Site>();
    
    @Column(name = "option_order", nullable = false)
	public Long getOptionOrder() {
		return optionOrder;
	}

	public void setOptionOrder(Long optionOrder) {
		this.optionOrder = optionOrder;
	}
	
	@Column(name = "further_info")
	public String getFurtherInfo() {
		return furtherInfo;
	}

	public void setFurtherInfo(String furtherInfo) {
		this.furtherInfo = furtherInfo;
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
	
	@Column(name = "master_id")
	public Long getMasterId() {
		return masterId;
	}

	public void setMasterId(Long masterId) {
		this.masterId = masterId;
	}
	
	@Column(name = "depends_on_multiple_option_ids")
	public String getDependsOnMultipleOptionIds() {
		return dependsOnMultipleOptionIds;
	}

	public void setDependsOnMultipleOptionIds(String dependsOnMultipleOptionIds) {
		this.dependsOnMultipleOptionIds = dependsOnMultipleOptionIds;
	}
	
	@Column(name = "obsolete", nullable = false)
	public boolean isObsolete() {
		return obsolete;
	}

	public void setObsolete(boolean obsolete) {
		this.obsolete = obsolete;
	}
	
	@Column(name = "pictogram")
	public String getPictogram() {
		return pictogram;
	}

	public void setPictogram(String pictogram) {
		this.pictogram = pictogram;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "depends_on_option_id")
	@NotFound(action=NotFoundAction.IGNORE)
	public QuestionOption getDependsOn() {
		return dependsOn;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "question_id", nullable = false)
	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	public void setDependsOn(QuestionOption dependsOn) {
		this.dependsOn = dependsOn;
	}
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "common_questions_option_inactive_site",
            joinColumns = @JoinColumn(
                    name = "option_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(
                    name = "site", referencedColumnName = "id"))
	public Set<Site> getInactiveInSites() {
		return inactiveInSites;
	}

	public void setInactiveInSites(Set<Site> inactiveInSites) {
		this.inactiveInSites = inactiveInSites;
	}

}
