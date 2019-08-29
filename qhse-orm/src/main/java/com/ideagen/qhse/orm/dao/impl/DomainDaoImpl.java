package com.ideagen.qhse.orm.dao.impl;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.Optional;

import javax.persistence.NoResultException;

import org.hibernate.Session;

import com.ideagen.qhse.orm.dao.DomainDao;
import com.ideagen.qhse.orm.util.HibernateUtil;
import com.ideagen.qhse.orm.entity.Domain;

public class DomainDaoImpl implements DomainDao {
	
	private Map<String, String> ormProperties;
	
	public DomainDaoImpl(Map<String, String> ormProperties) {
		this.ormProperties = ormProperties;
	}

	@Override
	public Optional<Domain> findById(Long id) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();
		
	    try {
	    	return Optional.of(session.find(Domain.class, id));
	    } catch (NoResultException e) {
			return Optional.empty();
	    } finally {
			session.close();
		}
	}

	@Override
	public Collection<Domain> listAllDomains() {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();
		
	    try {
	    	return session.createNamedQuery("domain.listAll", Domain.class).getResultList();
	    } catch (NoResultException e) {
			return Collections.emptyList();
	    } finally {
			session.close();
		}
	}
	
	@Override
	public Collection<Domain> findByName(String name) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();
		
		try {
	    	return session.createNamedQuery("domain.listByName", Domain.class).setParameter("name", name).getResultList();
		} catch (NoResultException e) {
			return Collections.emptyList();
		} finally {
			session.close();
		}
	    
	}

}
