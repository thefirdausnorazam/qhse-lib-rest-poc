package com.ideagen.qhse.orm.query.impl;

import java.util.Collections;
import java.util.List;

import javax.naming.directory.SearchResult;

import com.ideagen.qhse.orm.query.QueryResult;

public class ListBackedSearchResult implements QueryResult {

    // =========================================================================
    // Fields
    // =========================================================================

    private List<?> results;

    private int pageNumber;

    private int pageSize;

    private Integer totalResults;

    private boolean more;

    private String sortName;

    public static final QueryResult EMPTY_RESULT = new ListBackedSearchResult(Collections.EMPTY_LIST,
            0, 0, false, 0, "id");

    // =========================================================================
    // Constructors
    // =========================================================================

    /**
     * @param results the list of results in this window
     * @param pageNumber the page number of this result window
     * @param pageSize the maximum number of results per window
     * @param totalResults the total number of results
     */
    public ListBackedSearchResult(List<?> results, int pageNumber, int pageSize, boolean more,
            Integer totalResults, String sortName) {
        this.results = results;
        this.pageNumber = pageNumber;
        this.pageSize = pageSize;
        this.more = more;
        this.totalResults = totalResults;
        this.sortName = sortName;
    }

    // =========================================================================
    // Implementation Of SearchResult
    // =========================================================================

    /**
     * @see SearchResult#getResults()
     */
    public List<?> getResults() {
        return results;
    }

    /**
     * @see SearchResult#getPageNumber()
     */
    public int getPageNumber() {
        return pageNumber;
    }

    /**
     * @see SearchResult#getTotalResults()
     */
    public Integer getTotalResults() {
        return totalResults;
    }

    /**
     * @see SearchResult#getTotalResults()
     */
    public Integer getLastPage() {
        return totalResults == null ? null : Integer.valueOf((((totalResults.intValue() - 1) / pageSize) + 1));
    }

    /**
     * @see SearchResult#getPageSize()
     */
    public int getPageSize() {
        return pageSize;
    }

    /**
     * @see SearchResult#isMore()
     */
    public boolean isMore() {
        return more;
    }

    /**
     * @see SearchResult#getSortName()
     */
    public String getSortName() {
        return sortName;
    }

}
