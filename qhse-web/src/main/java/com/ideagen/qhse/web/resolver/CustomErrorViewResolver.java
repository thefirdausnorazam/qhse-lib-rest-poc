package com.ideagen.qhse.web.resolver;

import org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class CustomErrorViewResolver implements ErrorViewResolver {

    @Override
    public ModelAndView resolveErrorView(HttpServletRequest request, HttpStatus status, Map<String, Object> model) {
        ModelAndView view = new ModelAndView("page/common/error");
        String errorMessage;
        switch(status){
            case NOT_FOUND:
                errorMessage="Sorry, page does not exist";
                break;
            default:
                errorMessage="Sorry, an error has occurred";

        }
        view.getModel().put("error_message",errorMessage);
        return view;
    }
}