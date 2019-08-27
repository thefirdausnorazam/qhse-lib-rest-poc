package com.ideagen.qhse.orm.dao.impl;

import java.util.Map;

import org.hibernate.Session;

import com.ideagen.qhse.orm.dao.HibernateTestDao;
import com.ideagen.qhse.orm.util.HibernateUtil;

public class HibernateTestDaoImpl implements HibernateTestDao {
	
	private Map<String, String> ormProperties;
	
	public HibernateTestDaoImpl(Map<String, String> ormProperties) {
		this.ormProperties = ormProperties;
	}

	@Override
	public String getVersion() {
		
		// TODO Auto-generated method stub
		Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();
	    session.beginTransaction();

	    // Check database version
	    String sql = "select version()";

	    String result = (String) session.createNativeQuery(sql).getSingleResult();

	    session.getTransaction().commit();
	    session.close();
	    
	    HibernateUtil.shutdown();
		
	    return result;
	}

}
