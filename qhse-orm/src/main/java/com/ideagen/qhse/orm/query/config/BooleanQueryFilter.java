package com.ideagen.qhse.orm.query.config;

/**
 * Filter with two possibilities depending on whether the runtime filter value is true or false.
 * 
 */
public class BooleanQueryFilter extends AbstractFilter implements QueryFilter {

    // =========================================================================
    // Fields
    // =========================================================================

    private String trueFilter;

    private String falseFilter;

    // =========================================================================
    // Constructors
    // =========================================================================

    /**
     * default
     */
    public BooleanQueryFilter() {
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * @see QueryFilter#buildFilter(Object)
     */
    public String buildFilter(Object criteria) {
        if (criteria == null) {
            throw new IllegalArgumentException("null criteria not suppoered by BooleanQueryFilter");
        } else if (criteria instanceof Boolean) {
            Boolean b = (Boolean) criteria;
            return b.booleanValue() ? trueFilter : falseFilter;
        } else {
            throw new IllegalArgumentException(
                    "only Boolean criteria not supported by BooleanQueryFilter but "
                            + criteria.getClass().getName() + " supplied");
        }
    }

    public String getFalseFilter() {
        return falseFilter;
    }

    public void setFalseFilter(String falseFilter) {
        this.falseFilter = falseFilter;
    }

    public String getTrueFilter() {
        return trueFilter;
    }

    public void setTrueFilter(String trueFilter) {
        this.trueFilter = trueFilter;
    }

    @Override
    public String toString() {
        return "BooleanQueryFilter [name=" + getName() + ", trueFilter=" + trueFilter + ", falseFilter="
                + falseFilter + "]";
    }

    
}
