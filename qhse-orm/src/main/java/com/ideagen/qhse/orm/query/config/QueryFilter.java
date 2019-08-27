package com.ideagen.qhse.orm.query.config;

public interface QueryFilter {

    /**
     * @return
     */
    String getName();

    /**
     * @return
     */
    boolean isRequired();

    /**
     * @return the optional additional expression to append to the From clause of the query.
     */
    String getAdditionalFromExpression();

    String buildFilter(Object criteria);

}
