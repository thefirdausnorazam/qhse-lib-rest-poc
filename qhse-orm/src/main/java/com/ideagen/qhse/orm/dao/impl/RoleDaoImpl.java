package com.ideagen.qhse.orm.dao.impl;

import java.util.Map;
import java.util.Optional;

import javax.persistence.NoResultException;

import org.hibernate.Session;

import com.ideagen.qhse.orm.dao.RoleDao;
import com.ideagen.qhse.orm.entity.Role;
import com.ideagen.qhse.orm.util.HibernateUtil;

public class RoleDaoImpl implements RoleDao {

	private Map<String, String> ormProperties;

	public RoleDaoImpl(Map<String, String> ormProperties) {
		this.ormProperties = ormProperties;
	}

	public Optional<Role> findById(Long id) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.find(Role.class, id));
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

	public Optional<Role> findByName(String name) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.createNamedQuery("role.listByName", Role.class).setParameter("name", name).getSingleResult());
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

}
