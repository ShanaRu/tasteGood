package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class IndexController {
    @RequestMapping(value="/")
    public ModelAndView GoToSignIn(HttpServletRequest request, HttpServletResponse response){
        System.out.println("欢迎登录");
        return new ModelAndView("signIn");
    }

}
