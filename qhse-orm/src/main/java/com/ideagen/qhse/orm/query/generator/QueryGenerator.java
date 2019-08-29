package com.ideagen.qhse.orm.query.generator;

import com.ideagen.qhse.orm.query.ScrollingCriteria;
import com.ideagen.qhse.orm.query.SummaryCriteria;
import com.ideagen.qhse.orm.query.config.QueryDefinition;

public interface QueryGenerator {

    /**
     * Generate a query from the supplied definition and criteria
     * 
     * @param definition
     * @param criteria
     * @return generated query
     */
    Object generateQuery(QueryDefinition definition, ScrollingCriteria criteria);

    /**
     * Generate a "select count(*)" query from the supplied definition and criteria to calculate total rows for the above query
     * 
     * @param definition
     * @param criteria
     * @return generated query
     */
    Object generateCountQuery(QueryDefinition definition, ScrollingCriteria criteria);

    /**
     * Generate a summary query from the supplied definition and criteria
     * 
     * @param definition
     * @param criteria
     * @return generated query
     */
    Object generateSummaryQuery(QueryDefinition definition, SummaryCriteria criteria);
}
