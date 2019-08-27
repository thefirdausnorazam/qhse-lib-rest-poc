package com.ideagen.qhse.lib.rest.impl.law;

import com.ideagen.qhse.pojo.service.LawService;

import java.util.Map;

public class LawRestServiceFactory {

    public static LawService getService(Map<String, String> properties) {
        return new LawRestService(properties);
    }
}
