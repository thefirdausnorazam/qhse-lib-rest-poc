package com.ideagen.qhse.pojo.query.support;

import static com.ideagen.qhse.pojo.site.SearchSiteUtils.currentSearchSiteIfBound;
import static com.ideagen.qhse.pojo.site.SiteUtils.currentSiteIfBound;

import java.sql.Date;
import java.util.Set;

import org.apache.commons.lang3.time.DateUtils;

import com.ideagen.qhse.orm.query.ScrollingCriteria;
import com.ideagen.qhse.orm.query.SummaryCriteria;
import com.ideagen.qhse.pojo.site.Site;

public class SearchCriteriaSupport implements ScrollingCriteria, SummaryCriteria {

    // =========================================================================
    // Fields
    // =========================================================================

    public static int DEFAULT_PAGE_SIZE = 20;

    private int pageNumber = 1;

    private int pageSize;

    private String sortName;

    private boolean calculateTotals = false;

    private String primaryGroupByName;

    private String secondaryGroupByName;

    private String aggregateName;

    private Site currentSite = currentSiteIfBound().orNull();
    
    private Set<Site> currentSearchSite = currentSearchSiteIfBound();

    // =========================================================================
    // Constructors
    // =========================================================================

    /**
     *
     */
    public SearchCriteriaSupport() {
        this(false);
    }

    public SearchCriteriaSupport(boolean calculateTotals) {
        this(calculateTotals, DEFAULT_PAGE_SIZE);
    }

    public SearchCriteriaSupport(boolean calculateTotals, int pageSize) {
        this.calculateTotals = calculateTotals;
        this.pageSize = pageSize;
    }

    // =========================================================================
    // Implementation Of GroupingCriteria
    // =========================================================================

    /**
     * @see SummaryCriteria#getGroupByNames()
     */
    public String getPrimaryGroupByName() {
        return primaryGroupByName;
    }

    /**
     * @see SummaryCriteria#getSecondaryGroupByName()
     */
    public String getSecondaryGroupByName() {
        return secondaryGroupByName;
    }

    /**
     * @see SummaryCriteria#getAggregateName()
     */
    public String getAggregateName() {
        return aggregateName;
    }

    // =========================================================================
    // Implementation Of ScrollingCriteria
    // =========================================================================

    /**
     * @see SearchOperations#getPageNumber()
     */
    public int getPageNumber() {
        return pageNumber;
    }

    /**
     * @see SearchOperations#getPageSize()
     */
    public int getPageSize() {
        return pageSize;
    }

    /**
     * @see SearchOperations#getSortName()
     */
    public String getSortName() {
        return sortName;
    }

    /**
     * @see SearchOperations#calculateTotals()
     */
    public boolean isCalculateTotals() {
        return calculateTotals;
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * @param integer
     */
    public void setPageNumber(int integer) {
        pageNumber = integer;
    }

    /**
     * @param integer
     */
    public void setPageSize(int integer) {
        pageSize = integer;
    }

    /**
     * @param string
     */
    public void setSortName(String string) {
        sortName = string;
    }

    /**
     * @param b
     */
    public void setCalculateTotals(boolean b) {
        calculateTotals = b;
    }

    /**
     * @param primaryGroupByName The primaryGroupByName to set.
     */
    public void setPrimaryGroupByName(String primaryGroupByName) {
        this.primaryGroupByName = primaryGroupByName;
    }

    /**
     * @param aggregateName The aggregateName to set.
     */
    public void setAggregateName(String aggregateName) {
        this.aggregateName = aggregateName;
    }

    /**
     * @param secondaryGroupByName The secondaryGroupByName to set.
     */
    public void setSecondaryGroupByName(String secondaryGroupByName) {
        this.secondaryGroupByName = secondaryGroupByName;
    }

    public Site getCurrentSite() {
        return this.currentSite;
    }
    
    public Set<Site> getCurrentSearchSite() {
        return this.currentSearchSite;
    }

    public void setCurrentSearchSite(Set<Site> sites) {
        currentSearchSite = sites;
    }
    
    // =========================================================================
    // Protected Methods
    // =========================================================================

    /**
     * Convenience method to add one day to a date - useful where inclusive dates are required
     *
     * @param date
     * @return
     */
    protected Date toEndOfDay(Date date) {
        return date == null ? null : new Date(date.getTime() + DateUtils.MILLIS_PER_DAY);
    }
    
    /**
     * This method only return a Date with no time, that strange way of finding end of day. While calculating end of Day current date should not be changed to next date. Adding all Milli second per day will result in next date.
     * ENV-6126. I am subtracting 1 min (60,000 milli second) it will not make any change in current date.
     * @param date
     * @return
     */
    protected Date toEndOfDayExact(Date date) {
        return date == null ? null : new Date(date.getTime() + DateUtils.MILLIS_PER_DAY-60000);
    }

}
