package com.ideagen.qhse.pojo.site;

import com.google.common.base.Function;
import com.ideagen.qhse.pojo.util.Activated;
import com.ideagen.qhse.pojo.util.Descriptive;

public interface Site extends Descriptive, Activated, Comparable<Site> {

	public Function<Site, Long> GET_ID = new Function<Site, Long>() {
		@Override
		public Long apply(Site from) {
			return from.getId();
		}
	};

	public Function<Site, String> GET_NAME = new Function<Site, String>() {
		@Override
		public String apply(Site from) {
			return from.getName();
		}
	};

	String SESSION_ID = "site";

	Long getId();

	String getName();

}
