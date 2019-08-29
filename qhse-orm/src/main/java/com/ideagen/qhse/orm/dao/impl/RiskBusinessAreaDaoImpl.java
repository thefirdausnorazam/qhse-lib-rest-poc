package com.ideagen.qhse.orm.dao.impl;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.persistence.NoResultException;

import org.hibernate.Session;

import com.ideagen.qhse.orm.dao.RiskBusinessAreaDao;
import com.ideagen.qhse.orm.entity.RiskBusinessArea;
import com.ideagen.qhse.orm.util.HibernateUtil;

public class RiskBusinessAreaDaoImpl implements RiskBusinessAreaDao {
	
	private Map<String, String> ormProperties;

	public RiskBusinessAreaDaoImpl(Map<String, String> ormProperties) {
		this.ormProperties = ormProperties;
	}
	
	@Override
	public Optional<RiskBusinessArea> findById(Long id) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.find(RiskBusinessArea.class, id));
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
		
	}
	
	@Override
	public Optional<RiskBusinessArea> findByName(String name) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.createNamedQuery("riskBusinessArea.listByName", RiskBusinessArea.class).setParameter("name", name).getSingleResult());
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

	@Override
	public List<RiskBusinessArea> listActive() {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return session.createNamedQuery("riskBusinessArea.listActive", RiskBusinessArea.class).getResultList();
		} catch (NoResultException e) {
			return Collections.emptyList();
		} finally {
			session.close();
		}
	}

	@Override
	public List<RiskBusinessArea> listAll() {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return session.createNamedQuery("riskBusinessArea.listAll", RiskBusinessArea.class).getResultList();
		} catch (NoResultException e) {
			return Collections.emptyList();
		} finally {
			session.close();
		}
	}

}
