package com.ideagen.qhse.orm.dao.impl;

import java.util.Collection;
import java.util.Collections;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;

import com.ideagen.qhse.orm.dao.DomainDao;
import com.ideagen.qhse.orm.entity.Domain;
import com.ideagen.qhse.orm.entity.User;

public class DomainDaoImpl implements DomainDao {
	
	private EntityManagerFactory entityManagerFactory;

    public DomainDaoImpl(EntityManagerFactory entityManagerFactory) {
        this.entityManagerFactory = entityManagerFactory;
    }

	@Override
	public Optional<Domain> findById(Long id) {
		EntityTransaction transaction = null;
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            //get transaction
            transaction = entityManager.getTransaction();
            //begin transaction
            transaction.begin();

            //get domain
            Domain domain = entityManager.find(Domain.class, id);

            //commit transaction
            transaction.commit();

            return Optional.of(domain);
        } catch (Exception e) {
        	e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return Optional.empty();
	}

	@Override
	public Collection<Domain> listAllDomains() {
		EntityTransaction transaction = null;
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            //get transaction
            transaction = entityManager.getTransaction();
            //begin transaction
            transaction.begin();

            //get domain list
            Collection<Domain> domainList = entityManager
                    .createQuery("from Domain d ", Domain.class)
                    .getResultList();

            //commit transaction
            transaction.commit();

            return domainList;
        } catch (Exception e) {
        	e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return Collections.emptyList();
	}
	
	@Override
	public Collection<Domain> findByName(String name) {
		EntityTransaction transaction = null;
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            //get transaction
            transaction = entityManager.getTransaction();
            //begin transaction
            transaction.begin();

            //get domain list
            Collection<Domain> domainList = entityManager
                    .createQuery("from Domain d where d.name = :name", Domain.class)
                    .setParameter("name", name)
                    .getResultList();

            //commit transaction
            transaction.commit();

            return domainList;
        } catch (Exception e) {
        	e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return Collections.emptyList();
	}

}
