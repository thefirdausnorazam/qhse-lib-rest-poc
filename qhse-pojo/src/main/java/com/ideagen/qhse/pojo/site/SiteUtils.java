package com.ideagen.qhse.pojo.site;

import static com.google.common.collect.Lists.newArrayList;
//import static com.scannellsolutions.users.UserUtils.currentUser;
import static java.util.Collections.singletonList;

import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.google.common.base.Function;
import com.google.common.base.Optional;
import com.ideagen.qhse.pojo.exception.NoSiteException;
import com.ideagen.qhse.pojo.exception.NotFoundException;
import com.ideagen.qhse.pojo.site.InSite;
//import com.scannellsolutions.spring.ContextLookup;
//TODO: to implement site manager
public class SiteUtils {

  private static final Log logger = LogFactory.getLog(SiteUtils.class);

  private static ThreadLocal<Site> holder = new ThreadLocal<Site>();
  
  private static volatile Boolean multisite = null;
  
  public static final String CURRENT_SITE = "currentSite";
  
  public static final String EDITABLE_SITE = "currentSiteRecord";

  
  /**
   * Bind a site to the current context.
   * 
   * @param site
   *            The site to be bound.
   */
  public static void bind(Site site) {
      if (logger.isDebugEnabled()) {
          logger.debug("binding " + site + " to thread " + Thread.currentThread().getName());
      }
      final Site current = holder.get();
      if (current != null) {
          // throw new SiteAlreadyBoundException(current);
          throw new IllegalStateException();
      }
      holder.set(site);
  }

  /**
   * Unbind the site that is currently bound to this context.
   */
  public static void unbind() {
      final Site current = holder.get();
      if (logger.isDebugEnabled()) {
          logger.debug("unbinding " + current + " from thread " + Thread.currentThread().getName());
      }
      holder.set(null);
  }

  /**
   * Get the site that is currently bound to this context.
   * 
   * @return The site that is currently bound.
   */
  public static Site getCurrentSite() {
      final Site current = holder.get();
      if (current == null) {
          // throw new NotBoundException();
          throw new NoSiteException();
      }
      return current;
  }
  /*
  public static Set<Site> listSites()
  {
  	return siteManager().list();	
  }*/
  
  public static Site currentSite() {
      return getCurrentSite();
  }

  public static Optional<Site> currentSiteIfBound() {
      return Optional.fromNullable(holder.get());
  }

      /**
       * Checks if an entity is already bound to the current thread
       *
       * @return true if an entity is already bound.
       */
  public static boolean isBound() {
      return holder.get() != null;
  }
  
  public static boolean isPartOfCurrentSite(InSite entity) {
      return getCurrentSite().equals(entity.getSite());
  }

  /**
   * Execute the callback using the site parameter as the currentSite
   * 
   * @throws IllegalArgumentException
   *             if the user is not a member of the site
   */
  /*public static <T> T withSite(Site site, Function<Site, T> callback) {
      if (site != null && !isCurrentUserInSite(site)) {
          throw new IllegalArgumentException("invalid site " + (site == null ? null : site.getId()));
      }
      return doWithSite(site, callback);
  }*/

  /**
   * Execute the callback in each site the user has access or the default site if no sites are available
   */
  /*public static <T> List<T> withEachSite(Function<Site, T> callback) {
      return withSites(currentUser().getSites(), callback);
  }*/

  /**
   * Execute the callback on ALL sites regardless if whether the current user has access
   */
  /*
  public static <T> List<T> withAllSites(Function<Site, T> callback) {
      return withSites(siteManager().list(), callback);
  }

  public static Site findSite(Long id) {
      if (id == null) {
          return null;
      }
      final Set<Site> sites = currentUser().getSites();
      for (final Site site : sites) {
          if (site.getId().equals(id)) {
              return site;
          }
      }
      throw new NotFoundException(Site.class, id);
  }

  public static boolean isCurrentUserInSite(Site candidate) {
      if (candidate == null) {
          return false;
      }
      for (final Site site : currentUser().getSites()) {
          if (site.getId().equals(candidate.getId())) {
              return true;
          }
      }
      return false;
  }
  
  public static boolean isMultiSite() {
      if(multisite == null) {
          determinMultiSite();
      }
      return multisite;
  }
  */
  private static <T> List<T> withSites(Collection<Site> sites, Function<Site, T> callback) {
      if (sites == null || sites.isEmpty()) {
          return singletonList(doWithSite(null, callback));
      }
      final List<T> result = newArrayList();
      for (final Site site : sites) {
          result.add(doWithSite(site, callback));
      }
      return result;
  }

  private static <T> T doWithSite(Site site, Function<Site, T> callback) {
      final Site current = holder.get();
      try {
          holder.set(site);
          return callback.apply(site);
      } finally {
          holder.set(current);
      }
  }
  /*
  private static void determinMultiSite() {
      multisite = siteManager().list().size() > 1;
      
  }

  private static SiteManager siteManager() {
      return (SiteManager) ContextLookup.getApplicationContext().getBean("siteManager", SiteManager.class);
  }*/
  
}
