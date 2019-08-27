package com.ideagen.qhse.orm.dao.impl;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.persistence.NoResultException;

import org.hibernate.Session;

import com.ideagen.qhse.orm.dao.QuestionOptionDao;
import com.ideagen.qhse.orm.entity.QuestionOption;
import com.ideagen.qhse.orm.util.HibernateUtil;

public class QuestionOptionDaoImpl implements QuestionOptionDao {

	private Map<String, String> ormProperties;

	public QuestionOptionDaoImpl(Map<String, String> ormProperties) {
		this.ormProperties = ormProperties;
	}

	@Override
	public Optional<QuestionOption> findById(Long id) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.find(QuestionOption.class, id));
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

	@Override
	public Optional<QuestionOption> findByName(String name) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return Optional.of(session.createNamedQuery("questionOption.listByQuestionName", QuestionOption.class).setParameter("name", name).getSingleResult());
		} catch (NoResultException e) {
			return Optional.empty();
		} finally {
			session.close();
		}
	}

	@Override
	public List<QuestionOption> listSearchable(long questionId) {
		
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();

		try {
			return session.createNamedQuery("questionOption.listSearchable", QuestionOption.class).setParameter("questionId", questionId).getResultList();
		} catch (NoResultException e) {
			return Collections.emptyList();
		} finally {
			session.close();
		}

	}

}
