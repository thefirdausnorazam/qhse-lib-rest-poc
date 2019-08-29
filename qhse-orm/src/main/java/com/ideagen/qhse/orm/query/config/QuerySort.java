package com.ideagen.qhse.orm.query.config;

/**
 * Sort option for a QueryDefinition
 * 
 */
public class QuerySort {

    // =========================================================================
    // Fields
    // =========================================================================

    private String name;

    private String sort;

    private boolean defaultSort = false;

    // =========================================================================
    // Constructors
    // =========================================================================

    /**
     * default
     */
    public QuerySort() {
    }

    /**
     * @param name
     * @param sort
     */
    public QuerySort(String name, String sort) {
        this.name = name;
        this.sort = sort;
    }

    /**
     * @param name
     * @param sort
     * @param defaultSort
     */
    public QuerySort(String name, String sort, boolean defaultSort) {
        this.name = name;
        this.sort = sort;
        this.defaultSort = defaultSort;
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * Get the query sort string
     * 
     * @return sort
     */
    public String getSort() {
        return sort;
    }

    /**
     * Get the logical name
     * 
     * @return name
     */
    public String getName() {
        return name;
    }

    /**
     * @return true to sort by this by default
     */
    public boolean isDefaultSort() {
        return defaultSort;
    }

    /**
     * Set the query sort string
     * 
     * @param string
     */
    public void setSort(String string) {
        sort = string;
    }

    /**
     * Set the logical name
     * 
     * @param string
     */
    public void setName(String string) {
        name = string;
    }

    /**
     * @param defaultSort true => default sort
     */
    public void setDefaultSort(boolean defaultSort) {
        this.defaultSort = defaultSort;
    }

}
