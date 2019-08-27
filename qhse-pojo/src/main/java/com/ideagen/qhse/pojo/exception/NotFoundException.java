package com.ideagen.qhse.pojo.exception;

/**
 * Exception thrown when a persistent instance was expected to be retrieved but none was not found.
 * 
 */
public class NotFoundException extends RuntimeException {

    // =========================================================================
    // Fields
    // =========================================================================

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Class<?> type;

    private Object id;
    
    

    // =========================================================================
    // Constructors
    // =========================================================================
    public NotFoundException() {
    	
    }
    public NotFoundException(Class<?> type, long id) {
        super("could not find instance of [" + type.getName() + "] with id [" + id + "]");
        this.type = type;
        this.id = Long.valueOf(id);
    }

    public NotFoundException(Class<?> type, Object id) {
        super("could not find instance of [" + type.getName() + "] with id [" + id + "]");
        this.type = type;
        this.id = id;
    }

    // =========================================================================
    // Public Methods
    // =========================================================================

    /**
     * @return Returns the id.
     */
    public Object getId() {
        return id;
    }

    /**
     * @return Returns the type.
     */
    public Class<?> getType() {
        return type;
    }

}
