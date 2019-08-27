package com.ideagen.qhse.orm.dao.impl;

import java.util.Map;
import java.util.Optional;

import javax.persistence.NoResultException;

import org.hibernate.Session;

import com.ideagen.qhse.orm.dao.UserDao;
import com.ideagen.qhse.orm.entity.User;
import com.ideagen.qhse.orm.util.HibernateUtil;

public class UserDaoImpl implements UserDao {

	private Map<String, String> ormProperties;

	public UserDaoImpl(Map<String, String> ormProperties) {
		this.ormProperties = ormProperties;
	}

	public Optional<User> findById(Long id) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.find(User.class, id));
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

	public Optional<User> findByUsername(String username) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.createNamedQuery("user.listByName", User.class).setParameter("username", username).getSingleResult());

		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
		
	}

	public Optional<User> findByUsername(String username, Long domain) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.createNamedQuery("user.listByNameDomain", User.class).setParameter("username", username).setParameter("domain", domain).getSingleResult());

		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

}
