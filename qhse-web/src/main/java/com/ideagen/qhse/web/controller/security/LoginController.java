package com.ideagen.qhse.web.controller.security;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.net.http.HttpRequest;

@Controller
public class LoginController {
	@GetMapping("/login")
    public String login(Model model) {
		model.addAttribute("loginError",null);
		return "page/common/login";
    }
	
	@GetMapping("/login-error")
    public String loginError(Model model, HttpServletRequest request) {
        model.addAttribute("loginError", true);
        return "page/common/login";
    }

		
}
