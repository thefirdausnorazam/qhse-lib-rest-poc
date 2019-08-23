package com.ideagen.qhse.orm.dao.impl;

import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;

import com.ideagen.qhse.orm.dao.RoleDao;
import com.ideagen.qhse.orm.entity.Role;

public class RoleDaoImpl implements RoleDao {
	
	private EntityManagerFactory entityManagerFactory;

    public RoleDaoImpl(EntityManagerFactory entityManagerFactory) {
        this.entityManagerFactory = entityManagerFactory;
    }
	
	public Optional<Role> findById(Long id) {
        EntityTransaction transaction = null;
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            //get transaction
            transaction = entityManager.getTransaction();
            //begin transaction
            transaction.begin();

            //get role
            Role role = entityManager.find(Role.class, id);

            //commit transaction
            transaction.commit();

            return Optional.of(role);
        } catch (Exception e) {

        } finally {
            entityManager.close();
        }

        return Optional.empty();
    }
	
	public Optional<Role> findByName(String name) {
        EntityTransaction transaction = null;
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            //get transaction
            transaction = entityManager.getTransaction();
            //begin transaction
            transaction.begin();

            //get role
            Role role = entityManager
                    .createQuery("from Role r where r.name = :name ", Role.class)
                    .setParameter("name", name)
                    .getSingleResult();

            //commit transaction
            transaction.commit();

            return Optional.of(role);
        } catch (Exception e) {

        } finally {
            entityManager.close();
        }

        return Optional.empty();
    }

}
