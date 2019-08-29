package com.ideagen.qhse.pojo.util;

import com.google.common.base.Predicate;

/**
 * An object that can be active or inactive. The activeness of an object depends on what context
 * where it is used.
 * 
 */
public interface Activated {
    
    public static final Predicate<Activated> IS_ACTIVE = new Predicate<Activated>() {
        @Override
        public boolean apply(Activated input) {
            return input.isActive();
        }
    };

    /**
     * @return true if this object is currently 'active'.
     */
    public boolean isActive();

    /**
     * @return true if this object is currently 'active'.
     */
    public boolean isActiveInCurrentSite();

}
