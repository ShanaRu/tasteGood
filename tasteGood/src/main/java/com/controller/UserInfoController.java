package com.controller;

import com.domain.UserInfo;
import com.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/userInfo")
public class UserInfoController {

    @Autowired
    private UserInfoService userInfoService;

    //查找所有用户
    @RequestMapping("/findAllUser")
    public String  findAllUser(){
        List<UserInfo> userInfos=userInfoService.findAllUser();
        System.out.println("打印出来");
        System.out.println(userInfos);
        return "register";
    }

    //用户登录
    @RequestMapping("/userSignIn")
    public @ResponseBody String userSignIn(@RequestParam("userName")String userName, @RequestParam("userPassword")String userPassword, HttpServletResponse response, HttpServletRequest request) throws Exception{
        System.out.println(userPassword);
        System.out.println(userName);
        UserInfo userInfo=userInfoService.findUser(userName);//根据userName查找用户信息
        if(userInfo==null){//不存在用户
//            System.out.println("没有该用户");
            return "0";
        }else{//存在用户
            String password=userInfo.getUserPassword();
            if(password.equals(userPassword)){
//            response.sendRedirect(request.getContextPath()+"/userInfo/findAllUser");
//                System.out.println("对的");

                //创建获取session对象
                HttpSession session = request.getSession();
                //保存session中数据
                session.setAttribute("userName", userInfo.getUserName());
                session.setAttribute("userId",userInfo.getUserId());
                return "1";
            }else {
//                System.out.println("错的");
                return "0";
            }
        }
    }

    //跳转注册页面
    @RequestMapping("/registerForm")
    public String registerForm(){
        return "register";
    }

    //跳转主页
    @RequestMapping("/homePage")
    public String homPage(){
        return "homePage";
    }

    //保存用户信息
    @RequestMapping("/saveUseInfo")
    public void saveUseInfo(UserInfo userInfo, HttpServletRequest request, HttpServletResponse response) throws Exception{
        System.out.println("控制层");
        System.out.println("刚放进去的"+userInfo);
        userInfoService.saveUserInfo(userInfo);
        System.out.println(userInfo);
        response.sendRedirect(request.getContextPath()+"/");//回到登录页面

    }

    //用户名是否重复
    @RequestMapping("/userNameIsExist")
    @ResponseBody
    public String userNameIsExist(@RequestParam("userName") String userName,HttpServletRequest request,HttpServletResponse response) throws Exception{
        UserInfo oneUser=userInfoService.findUserName(userName);
        if(oneUser==null){
            return "0";//不重复
        }else{
            return "1";//重复
        }
    }

}
