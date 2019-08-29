package com.ideagen.qhse.orm.dao.impl;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.NoResultException;

import org.hibernate.query.Query;
import org.hibernate.ScrollableResults;
import org.hibernate.Session;

import com.ideagen.qhse.orm.dao.SearchOperationsDao;
import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.orm.query.ScrollingCriteria;
import com.ideagen.qhse.orm.query.config.QueryDefinition;
import com.ideagen.qhse.orm.query.generator.QueryGenerator;
import com.ideagen.qhse.orm.query.generator.impl.StandardGenerator;
import com.ideagen.qhse.orm.query.impl.ListBackedSearchResult;
import com.ideagen.qhse.orm.util.HibernateUtil;

public class SearchOperationsDaoImpl implements SearchOperationsDao {
	
	private Map<String, String> ormProperties;
	private QueryDefinition queryDefinition;
    private QueryGenerator queryGenerator = new StandardGenerator();

    public SearchOperationsDaoImpl(Map<String, String> ormProperties, QueryDefinition queryDefinition) {
        this.ormProperties = ormProperties;
        this.queryDefinition = queryDefinition;
    }

	@Override
	public QueryResult search(ScrollingCriteria criteria) {
		
		final String hql = (String) queryGenerator.generateQuery(queryDefinition, criteria);        
        final QueryDefinition queryDef = queryDefinition;
        final String sortName = queryDef.resolveSort(criteria).getName();
        
        Session session = HibernateUtil.getSessionFactory(ormProperties).openSession();
		
		try {
        	
			Query<Object> query = session.createQuery(hql);
            query.setProperties(criteria);     
            
			List list = new ArrayList(criteria.getPageSize());
            int pageNo = criteria.getPageNumber() < 1 ? 1 : criteria.getPageNumber();
            int pageSize = criteria.getPageSize() < 1 ? Integer.MAX_VALUE
                    : criteria.getPageSize();
            Integer total = null;
            boolean more = false;
            
            if (criteria.isCalculateTotals() && !queryDef.hasCount()) {
                // have to scroll if count query not configured
                // scrolling loads all objects into memory so is very slow for large result sets
                ScrollableResults results = query.scroll();
                if (more = results.first()) {
                    if (pageNo > 1) {
                        more = results.scroll((pageNo - 1) * pageSize);
                    }
                    for (int i = 0; more && i < pageSize; i++) {
                        list.add(results.get(0));
                        more = results.next();
                    }
                    if (criteria.isCalculateTotals()) {
                        results.last();
                        total = Integer.valueOf(results.getRowNumber() + 1);
                    }
                }
            } else {
                query.setFirstResult(pageSize * (pageNo - 1));
                query.setMaxResults(pageSize == Integer.MAX_VALUE ? pageSize : pageSize + 1);
                list = query.list();
                if (list.size() > pageSize) {
                    more = true;
                    list.remove(list.size() - 1);
                }
            }
            if (criteria.isCalculateTotals() && queryDef.hasCount()) {
                // execute the separate count query to avoid scrolling 
                final String countHql = (String) queryGenerator.generateCountQuery(queryDefinition, criteria);
                final Query<Object> countQuery = session.createQuery(countHql);
                countQuery.setProperties(criteria);
                final Number count = (Number) countQuery.uniqueResult();
                total = count == null ? 0 : count.intValue();
            }
            
            return new ListBackedSearchResult(list, pageNo, pageSize, more, total, sortName);
		} catch (NoResultException e) {
			return ListBackedSearchResult.EMPTY_RESULT;
		} finally {
			session.close();
		}
		
	}


}
