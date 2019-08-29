package com.ideagen.qhse.orm.query.generator;

import com.ideagen.qhse.orm.query.config.QueryClause;

public class GeneratedQuery {

    private final QueryClause[] clauses;

    private final String queryString;

    /**
     * 
     */
    public GeneratedQuery(String queryString, QueryClause[] clauses) {
        this.queryString = queryString;
        this.clauses = clauses;
    }

    /**
     * @return Returns the clauses.
     */
    public QueryClause[] getClauses() {
        return clauses;
    }

    /**
     * @return Returns the queryString.
     */
    public String getQueryString() {
        return queryString;
    }

}
