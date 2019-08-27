package com.ideagen.qhse.orm.query.config;

/**
 * Filter option for a QueryDefinition
 * 
 */
public class SimpleFilter extends AbstractFilter implements QueryFilter {

    // =========================================================================
    // Fields
    // =========================================================================

    private String filter;

    // =========================================================================
    // Constructors
    // =========================================================================

    /**
     * default
     */
    public SimpleFilter() {
    }

    /**
     * @param name
     * @param filter
     */
    public SimpleFilter(String name, String filter) {
        this(name, filter, null);
    }

    /**
     * @param name
     * @param filter
     * @param required
     */
    public SimpleFilter(String name, String filter, boolean required) {
        super(name, required);
        this.filter = filter;
    }

    /**
     * @param name
     * @param filter
     * @param additionalFromExpression
     */
    public SimpleFilter(String name, String filter, String additionalFromExpression) {
        super(name, additionalFromExpression);
        this.filter = filter;
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * @return
     */
    public String getFilter() {
        return filter;
    }

    /**
     * @param string
     */
    public void setFilter(String string) {
        filter = string;
    }

    /**
     * @see com.scannellsolutions.query.config.QueryFilter#buildFilter(java.lang.Object)
     */
    public String buildFilter(Object criteria) {
        return filter;
    }

    @Override
    public String toString() {
        return "SimpleFilter [name=" + getName() + ", filter=" + filter + "]";
    }
    
}
