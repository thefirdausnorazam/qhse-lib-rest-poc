package com.ideagen.qhse.orm.query;

/**
 * request object for summary queries
 * 
 */
public interface SummaryCriteria {

    /**
     * Get the logical names of the primary group clause that is to be applied to the query.
     * 
     * @return String
     */
    String getPrimaryGroupByName();

    /**
     * Get the logical names of the optional secondary group clause that is to be applied to the
     * query.
     * 
     * @return String
     */
    String getSecondaryGroupByName();

    /**
     * Get the logical name of the aggregate clauses that are to be applied to the query.
     * 
     * @return String
     */
    String getAggregateName();

}