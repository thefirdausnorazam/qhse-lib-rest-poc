package com.ideagen.qhse.web.controller.common;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorPageController {
    @RequestMapping("/unauthorized")
    public String notAuthorized(Model model){
        model.addAttribute("error_message","Sorry, you are not authorized to view this page");
        return "page/common/error";
    }
}
