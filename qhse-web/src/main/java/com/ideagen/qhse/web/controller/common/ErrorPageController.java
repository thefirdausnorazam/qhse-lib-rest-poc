package com.ideagen.qhse.web.controller.common;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorPageController {
    @RequestMapping("/unauthorized")
    public String notAuthorized(Model model){
        model.addAttribute("error_message","Sorry, you are not authorized to view this page");
        return "error";
    }

}
