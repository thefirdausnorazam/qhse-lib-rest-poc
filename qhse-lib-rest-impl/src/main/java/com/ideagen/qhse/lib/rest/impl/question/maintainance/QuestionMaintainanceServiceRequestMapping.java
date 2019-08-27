package com.ideagen.qhse.lib.rest.impl.question.maintainance;

public class QuestionMaintainanceServiceRequestMapping {

    public static final String ROOT_MAPPING = "/questionMaintainance";

    public static final String GET_QUESTION_OPTION_BY_NAME = "/getQuestionOptionByName";
    public static final String GET_QUESTION_OPTION_BY_ID = "/getQuestionOptionById";
    public static final String LIST_SEARCHABLE_DEPARTMENT = "/listSearchableDepartment";

    public static final String GET_QUESTION_OPTION_BY_NAME_FULL_PATH = ROOT_MAPPING + GET_QUESTION_OPTION_BY_NAME;
    public static final String GET_QUESTION_OPTION_BY_ID_FULL_PATH = ROOT_MAPPING + GET_QUESTION_OPTION_BY_ID;
    public static final String LIST_SEARCHABLE_DEPARTMENT_FULL_PATH = ROOT_MAPPING + LIST_SEARCHABLE_DEPARTMENT;
}
