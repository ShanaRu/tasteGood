package com.controller;

import com.domain.Works;
import com.service.WorksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/work")
public class WorkController {

    @Autowired
    private WorksService worksService;

    @RequestMapping("/addWork")
    public String addWork(@RequestParam("menuId")Integer menuId, @RequestParam("menuName")String menuName,Model model){
//        System.out.println("进来了");
        model.addAttribute("menuId",menuId);
        model.addAttribute("menuName",menuName);
        return "addWork";
    }

    @RequestMapping("/saveWork")
    @ResponseBody
    public void saveWork(Works works, HttpServletResponse response, HttpServletRequest request) throws Exception{
        System.out.println("进入了works");
        works.setLikes(0);
        System.out.println(works);
        worksService.saveWorks(works);
        System.out.println("跳回主页");
        response.sendRedirect(request.getContextPath()+"/userInfo/homePage");
    }
}
