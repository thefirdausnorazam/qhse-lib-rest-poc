package com.ideagen.qhse.lib.rest.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

public abstract class RestService {

    private static final String AUTH_HEADER = "qhse-user-is-authenticated";
    private static final String SECRET_HEADER = "qhse-service-secret";
    private static final String AUTHENTICATED_USER = "qhse-authenticated-user";

    private final String restEndpoint;
    private final ObjectMapper objectMapper;
    private final RestTemplate restTemplate;
    private final String secret;
    private final String authenticatedUser;

    protected RestService(Map<String, String> properties) {
        this.objectMapper = new ObjectMapper();
        this.restTemplate = new RestTemplate();
        this.restEndpoint = properties.get(RestServiceProperties.REST_ENDPOINT);
        this.secret = properties.get(RestServiceProperties.SERVICE_SECRET);
        this.authenticatedUser = properties.get(RestServiceProperties.AUTHENTICATED_USER);
    }

    protected <S> S requestSingle(Class<S> responseClass, String requestMapping) {
        try {
            String httpResponse = requestWithRequestParameter(requestMapping, null);

            //convert JSON to POJO
            return objectMapper.readValue(httpResponse, responseClass);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    protected <S> S requestSingle(Class<S> responseClass, String requestMapping, MultiValueMap<String, Object> requestParameter) {
        try {
            String httpResponse = requestWithRequestParameter(requestMapping, requestParameter);

            //convert JSON to POJO
            return objectMapper.readValue(httpResponse, responseClass);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    protected <S> S requestSingle(Class<S> responseClass, String requestMapping, Object requestBody) {
        try {
            String httpResponse = requestWithRequestBody(requestMapping, requestBody);

            //convert JSON to POJO
            return objectMapper.readValue(httpResponse, responseClass);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    protected <S> Collection<S> requestCollection(Class<S> responseClass, String requestMapping) {
        try {
            String httpResponse = requestWithRequestParameter(requestMapping, null);

            //convert JSON to POJO
            return objectMapper.readValue(httpResponse, objectMapper.getTypeFactory().constructCollectionType(List.class, responseClass));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    protected <S> Collection<S> requestCollection(Class<S> responseClass, String requestMapping, MultiValueMap<String, Object> requestParameter) {
        try {
            String httpResponse = requestWithRequestParameter(requestMapping, requestParameter);

            //convert JSON to POJO
            return objectMapper.readValue(httpResponse, objectMapper.getTypeFactory().constructCollectionType(List.class, responseClass));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    protected <S> Collection<S> requestCollection(Class<S> responseClass, String requestMapping, Object requestBody) {
        try {
            String httpResponse = requestWithRequestBody(requestMapping, requestBody);

            //convert JSON to POJO
            return objectMapper.readValue(httpResponse, objectMapper.getTypeFactory().constructCollectionType(List.class, responseClass));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private String requestWithRequestParameter(String requestMapping, MultiValueMap<String, Object> requestParameter) {
        //build headers
        HttpHeaders httpHeaders = getHeaderWithAuthentication();
        httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        httpHeaders.setAccept(new ArrayList<>() {
            {
                add(MediaType.APPLICATION_JSON_UTF8);
            }
        });

        //build endpoint
        String requestUrl = restEndpoint + "/" + requestMapping;

        //build request entity
        HttpEntity httpEntity;
        if (requestParameter != null) {
            httpEntity = new HttpEntity<>(requestParameter, httpHeaders);
        } else {
            httpEntity = new HttpEntity<>(httpHeaders);
        }

        //send request
        return restTemplate.postForObject(requestUrl, httpEntity, String.class);
    }

    private String requestWithRequestBody(String requestMapping, Object requestBody) throws JsonProcessingException {
        //build headers
        HttpHeaders httpHeaders = getHeaderWithAuthentication();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON_UTF8);
        httpHeaders.setAccept(new ArrayList<>() {
            {
                add(MediaType.APPLICATION_JSON_UTF8);
            }
        });

        //build endpoint
        String requestUrl = restEndpoint + "/" + requestMapping;

        //build requestEntity
        String requestBodyJson = objectMapper.writeValueAsString(requestBody);
        HttpEntity<String> httpEntity = new HttpEntity<>(requestBodyJson, httpHeaders);

        //send request
        return restTemplate.postForObject(requestUrl, httpEntity, String.class);
    }

    private HttpHeaders getHeaderWithAuthentication() {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add(AUTH_HEADER, "true");
        httpHeaders.add(SECRET_HEADER, secret);
        httpHeaders.add(AUTHENTICATED_USER, authenticatedUser);
        return httpHeaders;
    }
}
