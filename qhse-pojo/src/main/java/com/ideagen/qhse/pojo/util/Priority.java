package com.ideagen.qhse.pojo.util;

import java.util.List;

import org.apache.commons.lang.enums.Enum;

/** 
 *
 */
public class Priority extends Enum implements Descriptive {

    // =========================================================================
    // Fields
    // =========================================================================
    // 

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static final Priority LOW = new Priority("Low");

    public static final Priority MEDIUM = new Priority("Medium");

    public static final Priority HIGH = new Priority("High");
    

    // =========================================================================
    // Constructors
    // =========================================================================

    /**
     * @param name
     */
    protected Priority(String name) {
        super(name);
    }

    // =========================================================================
    // Implementation of Descriptive
    // =========================================================================

    @Override
    public String getDescription() {
        return this.getName();
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * @param s
     * @return
     */
    public static Priority valueOf(String s) {
        return (Priority) getEnum(Priority.class, s);
    }

    /**
     * @return an list of all RiskStatus
     */
    @SuppressWarnings("unchecked")
    public static List<Priority> values() {
        return getEnumList(Priority.class);
    }

    public static Class<?> getClazz() {
        return Priority.class;
    }

}

