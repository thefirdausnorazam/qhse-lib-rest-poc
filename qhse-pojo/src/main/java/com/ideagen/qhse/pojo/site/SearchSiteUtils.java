package com.ideagen.qhse.pojo.site;

import static com.google.common.collect.Sets.newHashSet;
import static com.ideagen.qhse.pojo.site.SiteUtils.currentSiteIfBound;

import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.google.common.base.Function;
import com.google.common.collect.Iterables;
import com.google.common.collect.Sets;
import com.ideagen.qhse.orm.query.QueryResult;
import com.ideagen.qhse.pojo.exception.SearchSiteAlreadyBoundException;
import com.ideagen.qhse.pojo.exception.SearchSiteNotBoundException;

public class SearchSiteUtils {

	private static final Log logger = LogFactory.getLog(SiteUtils.class);

	private static ThreadLocal<Set<Site>> holder = new ThreadLocal();

	//private static volatile Boolean multisite = null;

	public static String SESSION_ID = "searchSite";

	public static final String SHOW_SITE_COLUMN = "showSiteColumn";

	public static String GROUP_SITES = "groupSite";

	public static String SITES = "sites";

	public static String SITE_EDITABLE = "editable";

	/**
	 * Bind a site to the current context.
	 * 
	 * @param site The site to be bound.
	 */
	public static void bind(Set<Site> sites) {
		if (logger.isDebugEnabled()) {
			logger.debug("binding " + sites + " to thread " + Thread.currentThread().getName());
		}
		final Set<Site> current = holder.get();
		if (current != null) {
			throw new SearchSiteAlreadyBoundException(current);
		}
		holder.set(sites);
	}

	/**
	 * Unbind the site that is currently bound to this context.
	 */
	public static void unbind() {
		final Set<Site> current = holder.get();
		if (logger.isDebugEnabled()) {
			logger.debug("unbinding " + current + " from thread " + Thread.currentThread().getName());
		}
		holder.set(null);
	}

	public static Set<Site> currentSearchSites() {
		return getCurrentSearchSites();
	}

	/**
	 * Get the site that is currently bound to this context.
	 * 
	 * @return The site that is currently bound.
	 */
	public static Set<Site> getCurrentSearchSites() {
		final Set<Site> current = holder.get();
		if (current == null) {
			throw new SearchSiteNotBoundException();
		}
		return current;
	}

	public static Set<Site> currentSearchSiteIfBound() {
		Set<Site> siteSet = holder.get();
		if (siteSet == null) {
			siteSet = newHashSet();
			siteSet.add(currentSiteIfBound().orNull());

		}
		return siteSet;
	}

	public static boolean isSitesGrouped() {
		final Set<Site> current = holder.get();
		if (current == null) {
			return false;
		}
		return current.size() > 1 ? true : current.contains(SiteUtils.currentSite()) ? false : true;
	}

	public static Set<Site> getDistinctSites(List<InSite> list) {
		return Sets.newHashSet(Iterables.transform(list, new Function<InSite, Site>() {
			@Override
			public Site apply(InSite obj) {
				return obj.getSite();
			}
		}));
	}

	public static Set<Site> getDistinctSitesFromList(List list) {
		return Sets.newHashSet(Iterables.transform(list, new Function<InSite, Site>() {
			@Override
			public Site apply(InSite obj) {
				return obj.getSite();
			}
		}));
	}

	public static Set<Site> getDistinctSites(QueryResult result) {
		if (result != null) {
			List<InSite> list = result.getResults();
			return Sets.newHashSet(Iterables.transform(list, new Function<InSite, Site>() {
				@Override
				public Site apply(InSite obj) {
					return obj.getSite();
				}
			}));
		}
		return newHashSet();
	}

	/**
	 * Get the site that is currently bound to this context.
	 * 
	 * @return The site that is currently bound.
	 */
	public static String getCurrentSearchSitesString() {
		final Set<Site> current = holder.get();
		String sitesAsString = "";
		if (current == null) {
			throw new SearchSiteNotBoundException();
		}
		for (Site site : current) {
			if (sitesAsString.length() > 0) {
				sitesAsString = sitesAsString + "," + site.getId();
			} else {
				sitesAsString = site.getId().toString();
			}
		}
		return sitesAsString;
	}
}
