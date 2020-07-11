package com.controller;

import com.domain.LeaveMessage;
import com.github.pagehelper.PageInfo;
import com.service.LeaveMessageService;
import com.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/leaveMessage")
public class LeaveMessageController {

    @Autowired
    private LeaveMessageService leaveMessageService;

    @RequestMapping("/addLeaveMessage")
    @ResponseBody
    public void addLeaveMessage(LeaveMessage leaveMessage, HttpServletRequest request, HttpServletResponse response)throws Exception{
        HttpSession session=request.getSession();
        Integer uid=(Integer) session.getAttribute("userId");
        leaveMessage.setLeaveTime(new Date());
        leaveMessage.setUserId(uid);
        System.out.println(leaveMessage);
        leaveMessageService.addLeaveMessage(leaveMessage);
        response.sendRedirect(request.getContextPath()+"/menu/showMenu?menuId="+leaveMessage.getMenuId());
    }

    @RequestMapping("/showLeaveMessage")
    public String showLeaveMessage(HttpServletRequest request, Model model, @RequestParam("page") Integer page, @RequestParam("size") Integer size){
        HttpSession session=request.getSession();
        Integer uid=(Integer) session.getAttribute("userId");
        List<LeaveMessage> leaveMessages=leaveMessageService.getLeaveMessageByUserId(uid,page,size);
        PageInfo<LeaveMessage> pageInfo=new PageInfo<>(leaveMessages);
        model.addAttribute("pageInfo",pageInfo);
        return "showLeaveMessage";
    }

    @RequestMapping("/deleteLeaveMessage")
    @ResponseBody
    public String deleteLeaveMessage(Integer leaveId){
        leaveMessageService.deleteLeaveMessage(leaveId);
        return "200";
    }
}