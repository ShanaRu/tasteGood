package com.controller;

import com.domain.LeaveMessage;
import com.domain.Menu;
import com.domain.Works;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.LeaveMessageService;
import com.service.MenuService;
import com.service.WorksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/manager")
public class ManagerController {

    @Autowired
    private MenuService menuService;
    @Autowired
    private WorksService worksService;
    @Autowired
    private LeaveMessageService leaveMessageService;

    @RequestMapping("/managerMenu")
    public String managerMenu(@RequestParam("page") Integer page, @RequestParam("size") Integer size, Model model){
        List<Menu> menus=menuService.findAllMenu(page,size);
        PageInfo<Menu> pageInfo=new PageInfo<>(menus);
        model.addAttribute("pageInfo",pageInfo);
        return "managerMenu";
    }

    @RequestMapping("/managerWork")
    public String managerWork(@RequestParam("page") Integer page, @RequestParam("size") Integer size, Model model){
        List<Works> works=worksService.showWorks(page,size);
        PageInfo<Works> pageInfo=new PageInfo<>(works);
        model.addAttribute("pageInfo",pageInfo);
        return "managerWork";
    }

    @RequestMapping("/managerMessage")
    public String managerMessage(@RequestParam("page") Integer page, @RequestParam("size") Integer size, Model model){
        List<LeaveMessage> messages=leaveMessageService.getAllLeaveMessage(page,size);
        PageInfo<LeaveMessage> pageInfo=new PageInfo<>(messages);
        model.addAttribute("pageInfo",pageInfo);
        return "managerMessage";
    }

    @RequestMapping("/showMenuInfo")
    public String showMenuInfo(@RequestParam("menuId") Integer menuId,@RequestParam("pageNum")Integer pageNum,@RequestParam("pageSize")Integer pageSize,Model model){
        Menu menu=menuService.findMenuByMenuId(menuId);
        model.addAttribute("menu",menu);
        model.addAttribute("pageNum",pageNum);
        model.addAttribute("pageSize",pageSize);
        return "menuInfo";
    }

}
