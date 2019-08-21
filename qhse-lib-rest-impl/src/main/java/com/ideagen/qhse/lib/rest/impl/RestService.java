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

public abstract class RestService {

    private String restEndpoint;
    private ObjectMapper objectMapper;
    private RestTemplate restTemplate;

    protected RestService(String restEndpoint) {
        this.restEndpoint = restEndpoint;
        this.objectMapper = new ObjectMapper();
        this.restTemplate = new RestTemplate();
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
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        httpHeaders.setAccept(new ArrayList<>(){
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
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON_UTF8);
        httpHeaders.setAccept(new ArrayList<>(){
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
}
