package com.ideagen.qhse.orm.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.NamedQueries;
import org.hibernate.annotations.NamedQuery;

@Entity
@Table(name = "role")
@NamedQueries({
    @NamedQuery(name = "role.listByName", query = "from Role r where r.name = :name")
})
public class Role extends AbstractNamedEntity {

	public Role() {
    }

    @Override
    public String toString() {
        return "Role{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
