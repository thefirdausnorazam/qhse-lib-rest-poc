package com.ideagen.qhse.orm.dao.impl;

import java.util.Map;
import java.util.Optional;

import javax.persistence.NoResultException;

import org.hibernate.Session;

import com.ideagen.qhse.orm.dao.ProfileChecklistTaskDao;
import com.ideagen.qhse.orm.entity.ProfileChecklistTask;
import com.ideagen.qhse.orm.util.HibernateUtil;

public class ProfileChecklistTaskDaoImpl implements ProfileChecklistTaskDao {
	
	private Map<String, String> ormProperties;

	public ProfileChecklistTaskDaoImpl(Map<String, String> ormProperties) {
		this.ormProperties = ormProperties;
	}

	public Optional<ProfileChecklistTask> findById(Long id) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.find(ProfileChecklistTask.class, id));
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

	public Optional<ProfileChecklistTask> findByName(String name) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.createNamedQuery("profileChecklistTask.listByName", ProfileChecklistTask.class).setParameter("name", name).getSingleResult());
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

}
