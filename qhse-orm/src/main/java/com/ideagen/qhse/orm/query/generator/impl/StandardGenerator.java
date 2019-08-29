package com.ideagen.qhse.orm.query.generator.impl;

import java.beans.PropertyDescriptor;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.dao.InvalidDataAccessResourceUsageException;

import com.ideagen.qhse.orm.query.ScrollingCriteria;
import com.ideagen.qhse.orm.query.SummaryCriteria;
import com.ideagen.qhse.orm.query.config.QueryClause;
import com.ideagen.qhse.orm.query.config.QueryDefinition;
import com.ideagen.qhse.orm.query.config.QueryFilter;
import com.ideagen.qhse.orm.query.config.QuerySort;
import com.ideagen.qhse.orm.query.generator.GeneratedQuery;
import com.ideagen.qhse.orm.query.generator.QueryGenerator;

public class StandardGenerator implements QueryGenerator {

    /**
     *
     */
    public StandardGenerator() {
    }

    // =========================================================================
    // Implementation of QueryGenerator
    // =========================================================================

    /**
     * @see QueryGenerator#generate(QueryDefinition, Object)
     */
    public Object generateQuery(QueryDefinition definition, ScrollingCriteria criteria) {
        StringBuffer sb = new StringBuffer(500);
        sb.append(definition.getSelection());
        generateFilters(definition, criteria, sb);

        QuerySort sort = definition.resolveSort(criteria);
        sb.append(" order by ");
        sb.append(sort.getSort());

        return sb.toString();
    }

    @Override
    public Object generateCountQuery(QueryDefinition definition, ScrollingCriteria criteria) {
        StringBuffer sb = new StringBuffer(500);
        sb.append(definition.getCountSelection());
        generateFilters(definition, criteria, sb);
        return sb.toString();
    }

    public Object generateSummaryQuery(QueryDefinition definition, SummaryCriteria criteria) {
        Map<String, QueryClause> aggregateClauseMap = definition.getAggregateClauseMap();
        Map<String, QueryClause> groupClauseMap = definition.getGroupClauseMap();
        String aggregateName = criteria.getAggregateName();
        String primaryGroupByName = criteria.getPrimaryGroupByName();
        String secondaryGroupByName = criteria.getSecondaryGroupByName();

        List<QueryClause> usedClauses = new ArrayList<QueryClause>();

        if (aggregateClauseMap == null || aggregateClauseMap.isEmpty()) {
            throw new InvalidDataAccessResourceUsageException("No Aggregate Clauses defined");
        }
        if (groupClauseMap == null || groupClauseMap.isEmpty()) {
            throw new InvalidDataAccessResourceUsageException("No Group Clauses defined");
        }
        if (StringUtils.isBlank(aggregateName)) {
            throw new InvalidDataAccessResourceUsageException("No Aggregate Names specified");
        }
        if (StringUtils.isBlank(primaryGroupByName)) {
            throw new InvalidDataAccessResourceUsageException("No Primary Group By Name specified");
        }

        StringBuffer sb = new StringBuffer(500);
        sb.append("select ");
        
        QueryClause aggregateClause = (QueryClause) aggregateClauseMap.get(aggregateName);
        if (aggregateClause == null) {
            throw new InvalidDataAccessResourceUsageException("Invalid aggregate name '" + aggregateName + "'");
        }
        sb.append(aggregateClause.getExpression()).append(" as ").append(aggregateClause.getName());

        QueryClause primaryGroupClause = (QueryClause) groupClauseMap.get(primaryGroupByName);
        if (primaryGroupClause == null) {
            throw new InvalidDataAccessResourceUsageException("Invalid primary groupBy name '" + primaryGroupByName + "'");
        }
        sb.append(", ").append(primaryGroupClause.getExpression()).append(" as ").append(primaryGroupClause.getName());
        usedClauses.add(primaryGroupClause);

        QueryClause secondaryClause = null;
        if (StringUtils.isNotBlank(secondaryGroupByName)) {
            secondaryClause = (QueryClause) groupClauseMap.get(secondaryGroupByName);
            if (secondaryClause == null) {
                throw new InvalidDataAccessResourceUsageException("Invalid secondary groupBy name '" + secondaryGroupByName + "'");
            }
            sb.append(", ").append(secondaryClause.getExpression()).append(" as ").append(secondaryClause.getName());
            usedClauses.add(secondaryClause);
        }

        if(definition.getSelection().toLowerCase().startsWith("\n\t\t\t\tselect"))
        {
            //This is a hack for distinct list
        	int begin = definition.getSelection().indexOf("f"); //start from 'from' clause
        	sb.append(" ").append(definition.getSelection().substring(begin));
        }
        else
        {
        	sb.append(" ").append(definition.getSelection());
        }

        if (primaryGroupClause.getFromExpression() != null) {
            sb.append(" ").append(primaryGroupClause.getFromExpression());
        }
        if (secondaryClause != null && secondaryClause.getFromExpression() != null) {
            sb.append(" ").append(secondaryClause.getFromExpression());
        }

        boolean filtersAdded = generateFilters(definition, criteria, sb);
        sb.append(filtersAdded ? " and " : " where ").append(primaryGroupClause.getExpression()).append(" is not null");

        if (aggregateClause.getFilterExpression() != null) {
            sb.append(" and ").append(aggregateClause.getFilterExpression());
        }

        sb.append(" group by ");
        sb.append(primaryGroupClause.getExpression());
        if (secondaryClause != null) {
            sb.append(", ").append(secondaryClause.getExpression());
        }
        return new GeneratedQuery(sb.toString(), (QueryClause[]) usedClauses.toArray(new QueryClause[usedClauses.size()]));
    }

    // =========================================================================
    // Protected Methods
    // =========================================================================

    /**
     * Generate the query string for the current criteria
     *
     * @return true if any filters were added to the query
     */
    protected final boolean generateFilters(QueryDefinition definition, Object criteria, StringBuffer querySB) {
        BeanWrapper bw = new BeanWrapperImpl(criteria);
        PropertyDescriptor[] descriptors = bw.getPropertyDescriptors();
        Map<String, PropertyDescriptor> descriptorMap = new HashMap<String, PropertyDescriptor>();
        boolean where = true;
        for (int i = 0; i < descriptors.length; i++) {
            descriptorMap.put(descriptors[i].getName(), descriptors[i]);
        }
        QueryFilter[] filters = definition.getFilters();
        Map<QueryFilter, Object> selectedFiltersToValueMap = new LinkedHashMap<QueryFilter, Object>();
        for (int j = 0, length = filters.length; j < length; j++) {
            QueryFilter filter = filters[j];
            String name = filter.getName();
            PropertyDescriptor desc = (PropertyDescriptor) descriptorMap.get(name);
            if (desc == null) {
                throw new InvalidDataAccessResourceUsageException("SimpleFilter '" + name + "' not found in bean "
                        + criteria.getClass().getName());
            }
            Object value = bw.getPropertyValue(name);
            if (value == null && filter.isRequired()) {
                throw new InvalidDataAccessResourceUsageException("SimpleFilter '" + name + "' is mandatory");
            } else if (!isNull(value)) {
                selectedFiltersToValueMap.put(filter, value);
            }
        }
        for (QueryFilter filter : selectedFiltersToValueMap.keySet()) {
            // Ensure that the additional from expression is only ever added to the query once
            if (filter.getAdditionalFromExpression() != null && querySB.indexOf(filter.getAdditionalFromExpression()) == -1) {
                querySB.append(" ").append(filter.getAdditionalFromExpression());
            }
        }
        for (QueryFilter filter : selectedFiltersToValueMap.keySet()) {
            String filterPart = filter.buildFilter(selectedFiltersToValueMap.get(filter));
            if (filterPart != null && filterPart.trim().length() > 0) {
                if (where) {
                    querySB.append(" where ");
                    where = false;
                } else {
                    querySB.append(" and ");
                }
                querySB.append(filterPart);
            }
        }
        return !where;
    }

    /**
     * Determines if a value can be considered null.
     *
     * @param value
     * @return true if the value is null or a blank string
     */
    protected boolean isNull(Object value) {
        if (value instanceof String) {
            return StringUtils.isBlank((String) value);
        }
        return value == null;
    }

}
