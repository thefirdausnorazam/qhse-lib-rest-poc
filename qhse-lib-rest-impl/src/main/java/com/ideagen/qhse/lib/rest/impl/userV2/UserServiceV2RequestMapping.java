package com.ideagen.qhse.lib.rest.impl.userV2;

public class UserServiceV2RequestMapping {

    public static final String ROOT_MAPPING = "/v2/user";

    public static final String GET_USER = "/getUser";
    public static final String GET_USER_2 = "/getUser2";
    public static final String GET_USER_BY_ID = "/getById";
    public static final String LOGON = "/logon";
    public static final String LOGON_2 = "/logon2";
    public static final String DELETE_USER = "/delete";

    public static final String GET_USER_FULL_PATH = ROOT_MAPPING + GET_USER;
    public static final String GET_USER_2_FULL_PATH = ROOT_MAPPING + GET_USER_2;
    public static final String GET_USER_BY_ID_FULL_PATH = ROOT_MAPPING + GET_USER_BY_ID;
    public static final String LOGON_FULL_PATH = ROOT_MAPPING + LOGON;
    public static final String LOGON_2_FULL_PATH = ROOT_MAPPING + LOGON_2;
    public static final String DELETE_USER_FULL_PATH = ROOT_MAPPING + DELETE_USER;
}
