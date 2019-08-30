package com.ideagen.qhse.web.controller.sitemesh;

import com.ideagen.qhse.web.security.QhseCustomUserDetails;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequestMapping("/decorators")
public class DecoratorController {
    @GetMapping("/{decorator}")
    public String layout(@PathVariable String decorator, Model model, Principal principal) {
        if(principal!=null) {
            QhseCustomUserDetails user = (QhseCustomUserDetails) ((UsernamePasswordAuthenticationToken) principal).getPrincipal();
            model.addAttribute("uName", principal.getName());
            model.addAttribute("isAdmin", user.isAdmin());
        }
        return "decorators/"+decorator;
    }
}
