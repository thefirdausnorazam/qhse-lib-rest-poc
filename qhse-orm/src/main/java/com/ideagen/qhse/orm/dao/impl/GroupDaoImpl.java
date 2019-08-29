package com.ideagen.qhse.orm.dao.impl;

import java.util.Map;
import java.util.Optional;

import javax.persistence.NoResultException;

import org.hibernate.Session;

import com.ideagen.qhse.orm.dao.GroupDao;
import com.ideagen.qhse.orm.entity.Group;
import com.ideagen.qhse.orm.util.HibernateUtil;

public class GroupDaoImpl implements GroupDao {

	private Map<String, String> ormProperties;

	public GroupDaoImpl(Map<String, String> ormProperties) {
		this.ormProperties = ormProperties;
	}

	public Optional<Group> findById(Long id) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.find(Group.class, id));
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

	public Optional<Group> findByName(String name) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.createNamedQuery("group.listByName", Group.class).setParameter("name", name).getSingleResult());
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

}
