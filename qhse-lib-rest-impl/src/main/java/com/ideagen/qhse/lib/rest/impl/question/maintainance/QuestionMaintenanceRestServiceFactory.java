package com.ideagen.qhse.lib.rest.impl.question.maintainance;

import com.ideagen.qhse.pojo.service.QuestionMaintenanceService;

import java.util.Map;

public class QuestionMaintenanceRestServiceFactory {

    public static QuestionMaintenanceService getService(Map<String, String> properties) {
        return new QuestionMaintenanceRestService(properties);
    }
}
