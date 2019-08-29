package com.ideagen.qhse.web.controller.sitemesh;

import com.ideagen.qhse.web.security.QhseCustomUserDetails;
import com.ideagen.qhse.web.utils.security.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/decorators")
public class DecoratorController {

    private final Environment env;

    @Autowired
    public DecoratorController(Environment env) {
        this.env = env;
    }

    @GetMapping("/{decorator}")
    public String layout(@PathVariable String decorator, Model model, Principal principal) {
        if(principal!=null) {
            QhseCustomUserDetails user = (QhseCustomUserDetails) ((UsernamePasswordAuthenticationToken) principal).getPrincipal();
            UserUtils userUtils = new UserUtils(user.getDomain(),user.getGrantedAuthorities());
            model.addAttribute("uName", principal.getName());
            model.addAttribute("contextURL",env.getProperty("server.servlet.context-path"));
            model.addAttribute("legReg","");
            model.addAttribute("module","law2");
            List<String> licences = new ArrayList<>();
            licences.add("law");
            model.addAttribute("licences",licences);
            model.addAttribute("user",userUtils);
            model.addAttribute("createExcel",true);
        }
        return "decorators/"+decorator;
    }
}
