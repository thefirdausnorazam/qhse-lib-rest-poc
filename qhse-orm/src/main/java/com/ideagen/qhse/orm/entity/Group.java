package com.ideagen.qhse.orm.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

@Entity
@Table(name = "sec_group")
@NamedQueries({
    @NamedQuery(name = "group.listByName", query = "from Group g where g.name = :name")
})
public class Group extends AbstractNamedEntity {

	private Boolean siteGroup;
	private Site site;
	
	@Column(name = "site_group")
	public Boolean getSiteGroup() {
		return siteGroup;
	}

	public void setSiteGroup(Boolean siteGroup) {
		this.siteGroup = siteGroup;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "site")
	public Site getSite() {
		return site;
	}

	public void setSite(Site site) {
		this.site = site;
	}

}
