package com.ideagen.qhse.web.controller.system;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/system")
public class SystemController {

    @GetMapping("/")
    public String root(Model model){
        model.addAttribute(". But now you are viewing system index page");
        return "page/common/index";
    }
}
