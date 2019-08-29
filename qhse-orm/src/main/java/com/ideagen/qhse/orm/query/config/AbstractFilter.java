package com.ideagen.qhse.orm.query.config;

/**
 * Implements simple QueryFilter methods
 * 
 */
public abstract class AbstractFilter implements QueryFilter {

    // =========================================================================
    // Fields
    // =========================================================================

    private String name;

    private boolean required = false;

    private String additionalFromExpression;

    // =========================================================================
    // Constructors
    // =========================================================================

    /**
     * default
     */
    protected AbstractFilter() {
    }

    /**
     * @param name
     */
    protected AbstractFilter(String name) {
        this.name = name;
    }

    /**
     * @param name
     * @param required
     */
    protected AbstractFilter(String name, boolean required) {
        this.name = name;
        this.required = required;
    }

    /**
     * @param name
     * @param additionalFromExpression
     */
    protected AbstractFilter(String name, String additionalFromExpression) {
        this.name = name;
        this.additionalFromExpression = additionalFromExpression;
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * @see QueryFilter#getName()
     */
    public final String getName() {
        return name;
    }

    /**
     * @see QueryFilter#isRequired()
     */
    public final boolean isRequired() {
        return required;
    }

    /**
     * @param string
     */
    public final void setName(String string) {
        name = string;
    }

    /**
     * @param b
     */
    public final void setRequired(boolean b) {
        required = b;
    }

    /**
     * @return the additionalFromExpression
     */
    public String getAdditionalFromExpression() {
        return this.additionalFromExpression;
    }

    /**
     * @param additionalFromExpression the additionalFromExpression to set
     */
    public void setAdditionalFromExpression(String fromExpression) {
        this.additionalFromExpression = fromExpression;
    }
}
