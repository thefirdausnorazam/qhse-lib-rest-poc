package com.ideagen.qhse.orm.dao.impl;

import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;

import com.ideagen.qhse.orm.dao.UserDao;
import com.ideagen.qhse.orm.entity.User;

public class UserDaoImpl implements UserDao {

    private EntityManagerFactory entityManagerFactory;

    public UserDaoImpl(EntityManagerFactory entityManagerFactory) {
        this.entityManagerFactory = entityManagerFactory;
    }

    public Optional<User> findById(String id) {
        EntityTransaction transaction = null;
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            //get transaction
            transaction = entityManager.getTransaction();
            //begin transaction
            transaction.begin();

            //get user
            User user = entityManager.find(User.class, id);

            //commit transaction
            transaction.commit();

            return Optional.of(user);
        } catch (Exception e) {

        } finally {
            entityManager.close();
        }

        return Optional.empty();
    }

    public Optional<User> findByUsername(String username) {
        EntityTransaction transaction = null;
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            //get transaction
            transaction = entityManager.getTransaction();
            //begin transaction
            transaction.begin();

            //get user
            User user = entityManager
                    .createQuery("from User u where u.username = :username ", User.class)
                    .setParameter("username", username)
                    .getSingleResult();

            //commit transaction
            transaction.commit();

            return Optional.of(user);
        } catch (Exception e) {

        } finally {
            entityManager.close();
        }

        return Optional.empty();
    }
    
    public Optional<User> findByUsername(String username, Long domain) {
        EntityTransaction transaction = null;
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            //get transaction
            transaction = entityManager.getTransaction();
            //begin transaction
            transaction.begin();

            //get user
            User user = entityManager
                    .createQuery("from User u where u.username = :username and u.domain.id = :domain ", User.class)
                    .setParameter("username", username)
                    .setParameter("domain", domain)
                    .getSingleResult();

            //commit transaction
            transaction.commit();

            return Optional.of(user);
        } catch (Exception e) {

        } finally {
            entityManager.close();
        }

        return Optional.empty();
    }
    
}
