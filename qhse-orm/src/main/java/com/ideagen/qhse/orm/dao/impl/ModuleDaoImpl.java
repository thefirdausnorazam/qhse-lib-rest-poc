package com.ideagen.qhse.orm.dao.impl;

import java.util.Map;
import java.util.Optional;

import javax.persistence.NoResultException;

import org.hibernate.Session;

import com.ideagen.qhse.orm.dao.ModuleDao;
import com.ideagen.qhse.orm.entity.Module;
import com.ideagen.qhse.orm.util.HibernateUtil;

public class ModuleDaoImpl implements ModuleDao {

	private Map<String, String> ormProperties;

	public ModuleDaoImpl(Map<String, String> ormProperties) {
		this.ormProperties = ormProperties;
	}

	public Optional<Module> findById(Long id) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.find(Module.class, id));
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

	public Optional<Module> findByName(String name) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.createNamedQuery("module.listByName", Module.class).setParameter("name", name).getSingleResult());
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

}
