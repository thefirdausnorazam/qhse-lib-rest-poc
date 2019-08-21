package com.ideagen.qhse.lib.rest.impl.domain;

public class DomainServiceRequestMapping {

    public static final String ROOT_MAPPING = "/domain";

    public static final String GET_DOMAIN_BY_ID = "/getById";
    public static final String GET_ALL_DOMAINS = "/getAll";
    public static final String IS_LDAP_AUTHENTICATION = "/isLdap";
    public static final String GET_DOMAIN_BY_NAME = "/getByName";

    public static final String GET_DOMAIN_BY_ID_FULL_PATH = ROOT_MAPPING + GET_DOMAIN_BY_ID;
    public static final String GET_ALL_DOMAINS_FULL_PATH = ROOT_MAPPING + GET_ALL_DOMAINS;
    public static final String IS_LDAP_AUTHENTICATION_FULL_PATH = ROOT_MAPPING + IS_LDAP_AUTHENTICATION;
    public static final String GET_DOMAIN_BY_NAME_FULL_PATH = ROOT_MAPPING + GET_DOMAIN_BY_NAME;
}
