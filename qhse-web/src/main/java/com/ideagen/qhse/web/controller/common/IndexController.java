package com.ideagen.qhse.web.controller.common;

import com.ideagen.qhse.web.security.QhseCustomUserDetails;
import com.ideagen.qhse.web.utils.security.UserUtils;
import org.springframework.security.access.AuthorizationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;

@Controller
public class IndexController {
    @GetMapping("/")
    public String root(Model model,Principal principal) {
        if(principal==null){
            throw new AuthorizationServiceException("User not logged in");
        }
        return "redirect:/home";
    }
    @GetMapping("/home")
    public String home(Model model,Principal principal) {
        if(principal==null){
            throw new AuthorizationServiceException("User not logged in");
        }
        return "enviro/home";
    }
}
