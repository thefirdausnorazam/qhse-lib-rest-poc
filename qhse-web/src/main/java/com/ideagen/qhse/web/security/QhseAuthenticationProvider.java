package com.ideagen.qhse.web.security;

import java.util.Collection;

import org.springframework.ldap.NamingException;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsPasswordService;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.ldap.authentication.LdapAuthenticator;
import org.springframework.security.ldap.authentication.NullLdapAuthoritiesPopulator;
import org.springframework.security.ldap.ppolicy.PasswordPolicyException;
import org.springframework.security.ldap.userdetails.LdapAuthoritiesPopulator;
import org.springframework.util.Assert;

public class QhseAuthenticationProvider extends QhseAbstractAuthenticationProvider {
	
	private LdapAuthenticator authenticator;
	private LdapAuthoritiesPopulator authoritiesPopulator;
	private boolean hideUserNotFoundExceptions = true;

	// ~ Constructors
	// ===================================================================================================

	/**
	 * Create an instance with the supplied authenticator and authorities populator
	 * implementations.
	 *
	 * @param authenticator the authentication strategy (bind, password comparison, etc)
	 * to be used by this provider for authenticating users.
	 * @param authoritiesPopulator the strategy for obtaining the authorities for a given
	 * user after they've been authenticated.
	 */
	public QhseAuthenticationProvider(LdapAuthenticator authenticator,
			LdapAuthoritiesPopulator authoritiesPopulator) {
		this.setAuthenticator(authenticator);
		this.setAuthoritiesPopulator(authoritiesPopulator);
	}

	/**
	 * Creates an instance with the supplied authenticator and a null authorities
	 * populator. In this case, the authorities must be mapped from the user context.
	 *
	 * @param authenticator the authenticator strategy.
	 */
	public QhseAuthenticationProvider(LdapAuthenticator authenticator) {
		this.setAuthenticator(authenticator);
		this.setAuthoritiesPopulator(new NullLdapAuthoritiesPopulator());
	}

	// ~ Methods
	// ========================================================================================================

	private void setAuthenticator(LdapAuthenticator authenticator) {
		Assert.notNull(authenticator, "An LdapAuthenticator must be supplied");
		this.authenticator = authenticator;
	}

	private LdapAuthenticator getAuthenticator() {
		return this.authenticator;
	}

	private void setAuthoritiesPopulator(LdapAuthoritiesPopulator authoritiesPopulator) {
		Assert.notNull(authoritiesPopulator,
				"An LdapAuthoritiesPopulator must be supplied");
		this.authoritiesPopulator = authoritiesPopulator;
	}

	protected LdapAuthoritiesPopulator getAuthoritiesPopulator() {
		return this.authoritiesPopulator;
	}

	public void setHideUserNotFoundExceptions(boolean hideUserNotFoundExceptions) {
		this.hideUserNotFoundExceptions = hideUserNotFoundExceptions;
	}

	@Override
	protected DirContextOperations doAuthentication(
			UsernamePasswordAuthenticationToken authentication) {
		try {
			return getAuthenticator().authenticate(authentication);
		}
		catch (PasswordPolicyException ppe) {
			// The only reason a ppolicy exception can occur during a bind is that the
			// account is locked.
			throw new LockedException(this.messages.getMessage(
					ppe.getStatus().getErrorCode(), ppe.getStatus().getDefaultMessage()));
		}
		catch (UsernameNotFoundException notFound) {
			if (this.hideUserNotFoundExceptions) {
				throw new BadCredentialsException(this.messages.getMessage(
						"LdapAuthenticationProvider.badCredentials", "Bad credentials"));
			}
			else {
				throw notFound;
			}
		}
		catch (NamingException ldapAccessFailure) {
			throw new InternalAuthenticationServiceException(
					ldapAccessFailure.getMessage(), ldapAccessFailure);
		}
	}

	@Override
	protected Collection<? extends GrantedAuthority> loadUserAuthorities(
			DirContextOperations userData, String username, String password) {
		return getAuthoritiesPopulator().getGrantedAuthorities(userData, username);
	}
	/** UserDetail **/
	// ~ Static fields/initializers
	// =====================================================================================

	/**
	 * The plaintext password used to perform
	 * PasswordEncoder#matches(CharSequence, String)}  on when the user is
	 * not found to avoid SEC-2056.
	 */
	private static final String USER_NOT_FOUND_PASSWORD = "userNotFoundPassword";

	// ~ Instance fields
	// ================================================================================================

	private PasswordEncoder passwordEncoder;

	/**
	 * The password used to perform
	 * {@link PasswordEncoder#matches(CharSequence, String)} on when the user is
	 * not found to avoid SEC-2056. This is necessary, because some
	 * {@link PasswordEncoder} implementations will short circuit if the password is not
	 * in a valid format.
	 */
	private volatile String userNotFoundEncodedPassword;

	private UserDetailsService userDetailsService;

	private UserDetailsPasswordService userDetailsPasswordService;

	public QhseAuthenticationProvider() {
		setPasswordEncoder(PasswordEncoderFactories.createDelegatingPasswordEncoder());
	}

	// ~ Methods
	// ========================================================================================================
	@Override
	protected void additionalAuthenticationChecks(UserDetails userDetails,
			UsernamePasswordAuthenticationToken authentication)
			throws AuthenticationException {
		if (authentication.getCredentials() == null) {
			logger.debug("Authentication failed: no credentials provided");

			throw new BadCredentialsException(messages.getMessage(
					"AbstractUserDetailsAuthenticationProvider.badCredentials",
					"Bad credentials"));
		}

		String presentedPassword = authentication.getCredentials().toString();

		if (!passwordEncoder.matches(presentedPassword, userDetails.getPassword())) {
			logger.debug("Authentication failed: password does not match stored value");

			throw new BadCredentialsException(messages.getMessage(
					"AbstractUserDetailsAuthenticationProvider.badCredentials",
					"Bad credentials"));
		}
	}

	protected void doAfterPropertiesSet() throws Exception {
		Assert.notNull(this.userDetailsService, "A UserDetailsService must be set");
	}
	
	@Override
	protected final UserDetails retrieveUser(String username,
			UsernamePasswordAuthenticationToken authentication)
			throws AuthenticationException {
		prepareTimingAttackProtection();
		try {
			UserDetails loadedUser = this.getUserDetailsService().loadUserByUsername(username);
			if (loadedUser == null) {
				throw new InternalAuthenticationServiceException(
						"UserDetailsService returned null, which is an interface contract violation");
			}
			return loadedUser;
		}
		catch (UsernameNotFoundException ex) {
			mitigateAgainstTimingAttack(authentication);
			throw ex;
		}
		catch (InternalAuthenticationServiceException ex) {
			throw ex;
		}
		catch (Exception ex) {
			throw new InternalAuthenticationServiceException(ex.getMessage(), ex);
		}
	}

	@Override
	protected Authentication createSuccessAuthentication(Object principal,
			Authentication authentication, UserDetails user) {
		boolean upgradeEncoding = this.userDetailsPasswordService != null
				&& this.passwordEncoder.upgradeEncoding(user.getPassword());
		if (upgradeEncoding) {
			String presentedPassword = authentication.getCredentials().toString();
			String newPassword = this.passwordEncoder.encode(presentedPassword);
			user = this.userDetailsPasswordService.updatePassword(user, newPassword);
		}
		return super.createSuccessAuthentication(principal, authentication, user);
	}

	private void prepareTimingAttackProtection() {
		if (this.userNotFoundEncodedPassword == null) {
			this.userNotFoundEncodedPassword = this.passwordEncoder.encode(USER_NOT_FOUND_PASSWORD);
		}
	}

	private void mitigateAgainstTimingAttack(UsernamePasswordAuthenticationToken authentication) {
		if (authentication.getCredentials() != null) {
			String presentedPassword = authentication.getCredentials().toString();
			this.passwordEncoder.matches(presentedPassword, this.userNotFoundEncodedPassword);
		}
	}

	/**
	 * Sets the PasswordEncoder instance to be used to encode and validate passwords. If
	 * not set, the password will be compared using {@link PasswordEncoderFactories#createDelegatingPasswordEncoder()}
	 *
	 * @param passwordEncoder must be an instance of one of the {@code PasswordEncoder}
	 * types.
	 */
	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		Assert.notNull(passwordEncoder, "passwordEncoder cannot be null");
		this.passwordEncoder = passwordEncoder;
		this.userNotFoundEncodedPassword = null;
	}

	protected PasswordEncoder getPasswordEncoder() {
		return passwordEncoder;
	}

	public void setUserDetailsService(UserDetailsService userDetailsService) {
		this.userDetailsService = userDetailsService;
	}

	protected UserDetailsService getUserDetailsService() {
		return userDetailsService;
	}

	public void setUserDetailsPasswordService(
			UserDetailsPasswordService userDetailsPasswordService) {
		this.userDetailsPasswordService = userDetailsPasswordService;
	}

}
