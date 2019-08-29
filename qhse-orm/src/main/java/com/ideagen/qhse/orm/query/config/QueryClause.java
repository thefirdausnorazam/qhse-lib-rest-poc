package com.ideagen.qhse.orm.query.config;

/**
 * Group by clause for a QueryDefinition
 * 
 */
public class QueryClause {

    // =========================================================================
    // Fields
    // =========================================================================

    private String name;

    private String expression;

    private String fromExpression;

    private String filterExpression;

    private boolean timeType = false;

    // =========================================================================
    // Constructors
    // =========================================================================

    /**
     * default
     */
    public QueryClause() {
    }

    /**
     * @param name
     * @param expression
     */
    public QueryClause(String name, String expression) {
        this.name = name;
        this.expression = expression;
    }

    /**
     * @param name
     * @param expression
     * @param fromExpression
     * @param filterExpression
     * @param timeType
     */
    public QueryClause(String name, String expression, String fromExpression,
            String filterExpression, boolean timeType) {
        this.name = name;
        this.expression = expression;
        this.fromExpression = fromExpression;
        this.filterExpression = filterExpression;
        this.timeType = timeType;
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * @return Returns the expression.
     */
    public String getExpression() {
        return expression;
    }

    /**
     * @param expression The expression to set.
     */
    public void setExpression(String expression) {
        this.expression = expression;
    }

    /**
     * @return Returns the name.
     */
    public String getName() {
        return name;
    }

    /**
     * @param name The name to set.
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return Returns the fromExpression.
     */
    public String getFromExpression() {
        return fromExpression;
    }

    /**
     * @param fromExpression The fromExpression to set.
     */
    public void setFromExpression(String fromExpression) {
        this.fromExpression = fromExpression;
    }

    /**
     * @return Returns the timeType.
     */
    public boolean isTimeType() {
        return timeType;
    }

    /**
     * @param timeType The timeType to set.
     */
    public void setTimeType(boolean timeType) {
        this.timeType = timeType;
    }

    /**
     * @return the filterExpression
     */
    public String getFilterExpression() {
        return this.filterExpression;
    }

    /**
     * @param filterExpression the filterExpression to set
     */
    public void setFilterExpression(String filterExpression) {
        this.filterExpression = filterExpression;
    }

}
