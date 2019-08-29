package com.ideagen.qhse.orm.query;

import java.util.List;

/**
 * Result Object for scrolling searches
 * 
 */
public interface QueryResult {

    /**
     * get all the results for this page
     * 
     * @return non null List
     */
    List getResults();

    /**
     * Get the page number of this result window
     * 
     * @return int
     */
    int getPageNumber();

    /**
     * Get the number of results per window. <code>getRsults().size()</code> may return a smaller
     * value if there are not enough results to fill the page
     * 
     * @return int
     */
    int getPageSize();

    /**
     * Are there are more results available?
     * 
     * @return true if there are more results available
     */
    boolean isMore();

    /**
     * Get the total number of results (if calculated) that satisfy the search criteria.
     * 
     * @return null if the total was not calculated.
     */
    Integer getTotalResults();

}
