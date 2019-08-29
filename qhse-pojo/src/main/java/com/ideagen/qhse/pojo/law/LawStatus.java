package com.ideagen.qhse.pojo.law;

import java.util.List;

import org.apache.commons.lang.enums.Enum;

import com.ideagen.qhse.pojo.util.Descriptive;

public class LawStatus extends Enum implements Descriptive {

    // =========================================================================
    // Fields
    // =========================================================================

    // public static final LawStatus PENDING = new LawStatus("p");

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static final LawStatus IN_PROGRESS = new LawStatus("IN_PROGR");

    public static final LawStatus COMPLETE = new LawStatus("COMPLETE");

    public static final LawStatus TRASH = new LawStatus("TRASH");

    public static final LawStatus ARCHIVE = new LawStatus("ARCHIVE");

    // =========================================================================
    // Constructors
    // =========================================================================

    /**
     * @param name
     */
    protected LawStatus(String name) {
        super(name);
    }
    
    @Override
    public String getDescription() {
        // TODO The below is hard coded to output the Law Assessment Status and not the general Law Status.
        // It is used in the Law assessment reports.
        return this.getName();
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * @param s
     * @return
     */
    public static LawStatus valueOf(String s) {
        return (LawStatus) getEnum(LawStatus.class, s);
    }

    /**
     * @return an list of all LawStatus
     */
    @SuppressWarnings("unchecked")
    public static List<LawStatus> values() {
        return getEnumList(LawStatus.class);
    }

    public static Class<?> getClazz() {
        return LawStatus.class;
    }

}
