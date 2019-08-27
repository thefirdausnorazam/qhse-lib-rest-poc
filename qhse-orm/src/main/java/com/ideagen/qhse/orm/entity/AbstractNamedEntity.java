package com.ideagen.qhse.orm.entity;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public class AbstractNamedEntity extends AbstractEntity {
	
    protected String name;

    /**
     * @return Returns the name.
     */
    @Column(name = "name", nullable = false)
    public String getName() {
        return name;
    }

    /**
     * @param name The name to set.
     */
    public void setName(String name) {
        this.name = name;
    }

}
