package com.ideagen.qhse.orm.query.config;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.ideagen.qhse.orm.query.ScrollingCriteria;

/**
 * Bean containing a definition of a query
 *
 */
public class QueryDefinition {

    // =========================================================================
    // Fields
    // =========================================================================

    private String selection;

    private String countSelection;

    private QueryFilter[] filters;

    private QuerySort[] sorts;

    private QueryClause[] groupClauses;

    private QueryClause[] aggregateClauses;

    private Map<String, QueryClause> groupClauseMap;

    private Map<String, QueryClause> aggregateClauseMap;

    // =========================================================================
    // Constructors
    // =========================================================================

    public QueryDefinition() {
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * get the default sort option
     *
     * @return default sort option
     */
    public String getDefaultSort() {
        for (int i = 0; i < sorts.length; i++) {
            if (sorts[i].isDefaultSort()) {
                return sorts[i].getName();
            }
        }
        return sorts[1].getName();
    }

    /**
     * get all filter options
     *
     * @return SimpleFilter[]
     */
    public QueryFilter[] getFilters() {
        return filters;
    }

    /**
     * Get the selection portion of the query
     *
     * @return selection portion
     */
    public String getSelection() {
        return selection;
    }

    /**
     * Set all filer options
     *
     * @param filters
     */
    public void setFilters(QueryFilter[] filters) {
        this.filters = filters;
    }

    /**
     * get all sort options
     *
     * @return all sort options
     */
    public QuerySort[] getSorts() {
        return sorts;
    }

    /**
     * Set all the sort options
     *
     * @param sorts
     */
    public void setSorts(QuerySort[] sorts) {
        this.sorts = sorts;
    }

    /**
     * Set the select part of the query
     *
     * @param string
     */
    public void setSelection(String string) {
        selection = string;
    }
    
    public boolean hasCount() {
        return StringUtils.isNotBlank(countSelection);
    }

    public String getCountSelection() {
        return countSelection;
    }

    public void setCountSelection(String countSelection) {
        this.countSelection = countSelection;
    }

    /**
     * Resolves the sort by name or uses default if no match is found
     *
     * @param criteria
     * @return non null QuerySort
     */
    public QuerySort resolveSort(ScrollingCriteria criteria) {
        QuerySort defaultSort = sorts[0];
        for (int i = 0; i < sorts.length; i++) {
            if (sorts[i].getName().equals(criteria.getSortName())) {
                return sorts[i];
            }
            if (sorts[i].isDefaultSort()) {
                defaultSort = sorts[i];
            }
        }
        return defaultSort;
    }

    /**
     * @return Returns the groupClauses.
     */
    public QueryClause[] getGroupClauses() {
        return groupClauses;
    }

    /**
     * @param groupClauses The groupClauses to set.
     */
    public void setGroupClauses(QueryClause[] groupClauses) {
        this.groupClauses = groupClauses;
        groupClauseMap = new HashMap<String, QueryClause>();
        for (int i = 0; i < groupClauses.length; i++) {
            QueryClause clause = groupClauses[i];
            groupClauseMap.put(clause.getName(), clause);
        }
    }

    /**
     * @return Returns the aggregateClauses.
     */
    public QueryClause[] getAggregateClauses() {
        return aggregateClauses;
    }

    /**
     * @param aggregateClauses The aggregateClauses to set.
     */
    public void setAggregateClauses(QueryClause[] aggregateClauses) {
        this.aggregateClauses = aggregateClauses;
        aggregateClauseMap = new HashMap<String, QueryClause>();
        for (int i = 0; i < aggregateClauses.length; i++) {
            QueryClause clause = aggregateClauses[i];
            aggregateClauseMap.put(clause.getName(), clause);
        }
    }

    /**
     * @return Returns the aggregateClauseMap.
     */
    public Map<String, QueryClause> getAggregateClauseMap() {
        return aggregateClauseMap;
    }

    /**
     * @return Returns the groupClauseMap.
     */
    public Map<String, QueryClause> getGroupClauseMap() {
        return groupClauseMap;
    }

    // =========================================================================
    // Protected Methods
    // =========================================================================

}
