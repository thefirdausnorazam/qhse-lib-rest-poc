package com.ideagen.qhse.orm.dao;

import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.orm.query.ScrollingCriteria;

public interface SearchOperationsDao {
	
	public QueryResult search(final ScrollingCriteria criteria);

}
