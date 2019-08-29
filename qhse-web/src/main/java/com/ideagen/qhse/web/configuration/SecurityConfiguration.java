package com.ideagen.qhse.web.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.ldap.DefaultSpringSecurityContextSource;
import org.springframework.security.ldap.authentication.BindAuthenticator;
import org.springframework.security.ldap.userdetails.DefaultLdapAuthoritiesPopulator;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.ideagen.qhse.web.security.QhseAuthenticationFilter;
import com.ideagen.qhse.web.security.QhseAuthenticationProvider;
import com.ideagen.qhse.web.security.service.LoginService;

@Configuration
@ComponentScan("com.ideagen.qhse")
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
	
	/** LDAP 
     * User : riemann ,gauss ,euler ,euclid 
     * password : password
    **/
	
    @Value("${ldap.urls}")
	private String ldapUrls;
	@Value("${ldap.base.dn}")
	private String ldapBaseDn;
	@Value("${ldap.username}")
	private String ldapSecurityPrincipal;
	@Value("${ldap.password}")
	private String ldapPrincipalPassword;
	@Value("${ldap.user.dn.pattern}")
	private String ldapUserDnPattern;
	@Value("${ldap.enabled}")
	private String ldapEnabled;
	
	@Autowired
	LoginService loginService;

	@Override
    protected void configure(HttpSecurity http) throws Exception {
        
        http.sessionManagement()
            .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
            .and()
            .csrf().disable()
            .addFilterBefore(authenticationFilter(), UsernamePasswordAuthenticationFilter.class)
            .authorizeRequests()
            .antMatchers("/login/**","/groove/**","/error").permitAll()
            .antMatchers("/").authenticated()
            .antMatchers("/system/**").hasRole("ADMIN")
            .and().exceptionHandling().accessDeniedPage("/unauthorized")
            .and()
            .formLogin().loginPage("/login")
            .and()
            .logout()
            .logoutUrl("/logout")
            .invalidateHttpSession(true);
    }

	public QhseAuthenticationFilter authenticationFilter() throws Exception {
    	QhseAuthenticationFilter filter = new QhseAuthenticationFilter();
        filter.setAuthenticationManager(authenticationManagerBean());
        filter.setAuthenticationFailureHandler(failureHandler());
        return filter;
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(authProvider());
    }

    public AuthenticationProvider authProvider() {
    	//Settings for LDAP
    	DefaultSpringSecurityContextSource contextSource = new DefaultSpringSecurityContextSource(ldapUrls + ldapBaseDn);
        contextSource.setUserDn(ldapSecurityPrincipal);
        contextSource.setPassword(ldapPrincipalPassword);
        contextSource.afterPropertiesSet();
        BindAuthenticator bindAuthenticator = new BindAuthenticator(contextSource);
        bindAuthenticator.setUserDnPatterns(new String[] {ldapUserDnPattern});
        QhseAuthenticationProvider provider = new QhseAuthenticationProvider(bindAuthenticator, new DefaultLdapAuthoritiesPopulator(contextSource, ""));
        //Settings for UserDetails
        provider.setUserDetailsService(loginService);
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    public SimpleUrlAuthenticationFailureHandler failureHandler() {
        return new SimpleUrlAuthenticationFailureHandler("/login-error");
    }

    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
