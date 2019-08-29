package com.ideagen.qhse.web.controller.security;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.Map;

@Controller
public class LoginController {

	@GetMapping("/login")
    public String login(Model model) {
        model.addAttribute("contextURL","/");
		model.addAttribute("loginError",null);
		model.addAttribute("recaptchaEnabled",false);
        model.addAttribute("recaptchaDataSiteKey","");
		model.addAttribute("showDomains",true);
        model.addAttribute("sso",false);
		return "login";
    }
	
	@GetMapping("/login-error")
    public String loginError(Model model, HttpServletRequest request) {
        model.addAttribute("errorMessage", "login.failed.error.invalidCredentials");
        return "login";
    }

		
}
