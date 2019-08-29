package com.ideagen.qhse.orm.query;

/**
 * request object for scrolling searches
 * 
 */
public interface ScrollingCriteria {

    /**
     * Get the page number of the desired result window
     * 
     * @return Integer, null implies first page
     */
    int getPageNumber();

    /**
     * Get the page number of the desired result window
     * 
     * @return int, null implies default page size
     */
    int getPageSize();

    /**
     * Return the logical name by which the results are sorted
     * 
     * @return sortName, null implies default sort
     */
    String getSortName();

    /**
     * Calculate the total number of results
     * 
     * @return true if results are to be calculated
     */
    boolean isCalculateTotals();

}
