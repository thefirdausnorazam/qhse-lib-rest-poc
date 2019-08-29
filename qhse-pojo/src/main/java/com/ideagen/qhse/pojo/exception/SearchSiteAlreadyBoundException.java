package com.ideagen.qhse.pojo.exception;

import java.util.Set;

import com.ideagen.qhse.pojo.site.Site;

public class SearchSiteAlreadyBoundException extends RuntimeException {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
     *
     */
    public SearchSiteAlreadyBoundException(Set<Site> sites) {
        super("search site " + sites + "already bound to thread " + Thread.currentThread().getName());
    }

}