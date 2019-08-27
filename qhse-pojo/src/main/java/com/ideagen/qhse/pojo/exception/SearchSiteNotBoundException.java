package com.ideagen.qhse.pojo.exception;

public class SearchSiteNotBoundException extends RuntimeException {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
     *
     */
    public SearchSiteNotBoundException() {
        super("no search sites bound to thread " + Thread.currentThread().getName());
    }

}
