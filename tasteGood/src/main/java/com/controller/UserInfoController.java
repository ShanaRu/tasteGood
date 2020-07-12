package com.controller;

import com.domain.*;
import com.service.CollectionService;
import com.service.MenuService;
import com.service.UserInfoService;
import com.service.WorksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/userInfo")
public class UserInfoController {

    @Autowired
    private UserInfoService userInfoService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private WorksService worksService;

    @Autowired
    private CollectionService collectionService;

    //查找所有用户
    @RequestMapping("/findAllUser")
    public String  findAllUser(){
        List<UserInfo> userInfos=userInfoService.findAllUser();
        return "register";
    }

    //用户登录
    @RequestMapping("/userSignIn")
    public @ResponseBody String userSignIn(@RequestParam("userName")String userName, @RequestParam("userPassword")String userPassword, HttpServletRequest request){
        System.out.println(userPassword);
        System.out.println(userName);
        UserInfo userInfo=userInfoService.findUser(userName);//根据userName查找用户信息
        if(userInfo==null){//不存在用户
            return "0";
        }else{//存在用户
            String password=userInfo.getUserPassword();
            if(password.equals(userPassword)){
                //创建获取session对象
                HttpSession session = request.getSession();
                //保存session中数据
                session.setAttribute("userName", userInfo.getUserName());
                session.setAttribute("userId",userInfo.getUserId());
                return "1";
            }else {//存在错误
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
    public String homPage(Model model,HttpServletRequest request){
        //主页中的流行作品
        List<Works> works=worksService.getPopularWorks();
        model.addAttribute("works",works);

//        List<Menu> menus=new ArrayList<>();
//        List<Collection> collections=collectionService.getPopularCollection();
//        model.addAttribute("collections",collections);
//        for (Collection collection:collections){
//            menus.add(menuService.findMenuByMenuId(collection.getMenuId()));
//        }
//        model.addAttribute("menus",menus);
        //主页中的菜谱排行榜
        List<Menu> menus=menuService.getMenusByTotalComplete();
        model.addAttribute("menus",menus);

        //主业的用户信息
        HttpSession session=request.getSession();
        Integer uid=(Integer)session.getAttribute("userId");
        UserInfo userInfo=userInfoService.findUserById(uid);
        model.addAttribute("userInfo",userInfo);

        Integer totalWork=worksService.countWorksById(uid);
        if (totalWork==null){
            totalWork=0;
        }
        model.addAttribute("totalWork",totalWork);

        Integer totalCollection=collectionService.countCollectionsById(uid);
        if (totalCollection==null){
            totalCollection=0;
        }
        model.addAttribute("totalCollection",totalCollection);

        Integer totalMenu=menuService.countMenusById(uid);
        if (totalMenu==null){
            totalMenu=0;
        }
        model.addAttribute("totalMenu",totalMenu);

        return "homePage";
    }

    //保存用户信息
    @RequestMapping("/saveUseInfo")
    public void saveUseInfo(UserInfo userInfo, HttpServletRequest request, HttpServletResponse response) throws Exception{
        //返回新增userId
        Integer userId=userInfoService.saveUserInfo(userInfo);
        UserRole userRole=new UserRole();
        userRole.setRoleId(2);//roleId都是2
        userRole.setUserId(userId);
        userInfoService.addUserRole(userRole);
        response.sendRedirect(request.getContextPath()+"/");//回到登录页面

    }

    //用户名是否重复
    @RequestMapping("/userNameIsExist")
    @ResponseBody
    public String userNameIsExist(@RequestParam("userName") String userName){
        UserInfo oneUser=userInfoService.findUserName(userName);
        if(oneUser==null){
            return "0";//不重复
        }else{
            return "1";//重复
        }

    }

    //跳到修改账号信息页面
    @RequestMapping("/modifyUserInfo")
    public String modifyUserInfo(Model model,HttpServletRequest request){
        HttpSession session=request.getSession();
        Integer userId=(Integer)session.getAttribute("userId");
        UserInfo userInfo=userInfoService.findUserInfoById(userId);
        model.addAttribute("userInfo",userInfo);
        return "modifyUserInfo";
    }

    @RequestMapping("/updateUserInfo")
    public void updateUserInfo(UserInfo userInfo,HttpServletRequest request, HttpServletResponse response) throws Exception{
        //这里拿到的userInfo不是完整的userInfo
        String userName=userInfo.getUserName();
        Integer userId=userInfo.getUserId();
        Integer userSex=userInfo.getUserSex();
        String userIntroduce=userInfo.getUserIntroduce();
        userInfoService.updateUserInfo(userName,userSex,userIntroduce,userId);
        response.sendRedirect(request.getContextPath()+"/userInfo/modifyUserInfo");
    }

    @RequestMapping("/updateUserPassword")
    public void updateUserPassword(UserInfo userInfo,HttpServletRequest request, HttpServletResponse response) throws Exception{
        //这里拿到的userInfo不是完整的userInfo
        String userPassword=userInfo.getUserPassword();
        Integer userId=userInfo.getUserId();
        userInfoService.updatePassword(userPassword,userId);
        response.sendRedirect(request.getContextPath()+"/userInfo/modifyUserInfo");
    }

    @RequestMapping("/updateUserPhoto")
    public void updateUserPhoto(UserInfo userInfo,HttpServletRequest request, HttpServletResponse response) throws Exception{
        //这里拿到的userInfo不是完整的userInfo
        String userPhoto=userInfo.getUserPhoto();
        Integer userId=userInfo.getUserId();
        userInfoService.updateUserPhoto(userPhoto,userId);
        response.sendRedirect(request.getContextPath()+"/userInfo/modifyUserInfo");
    }

    @RequestMapping("/exit")
    public void exit(HttpServletRequest request, HttpServletResponse response)throws Exception{
        HttpSession session=request.getSession();
        session.removeAttribute("userId");
        session.removeAttribute("userName");
        response.sendRedirect(request.getContextPath()+"/");
    }

//    //自己访问的
//    @RequestMapping("/myKitchen")
//    public String myKitchen(Model model,HttpServletRequest request){
//        HttpSession session=request.getSession();
//        Integer userId=(Integer)session.getAttribute("userId");
//        model.addAttribute("myUserId",userId);//自己的userId
//        //用户信息
//        UserInfo userInfo=userInfoService.findUserById(userId);
//        model.addAttribute("userInfo",userInfo);
//        //菜谱数量
//        Integer totalWork=worksService.countWorksById(userId);
//        if (totalWork==null){
//            totalWork=0;
//        }
//        model.addAttribute("totalWork",totalWork);
//        //作品数量
//        Integer totalCollection=collectionService.countCollectionsById(userId);
//        if (totalCollection==null){
//            totalCollection=0;
//        }
//        model.addAttribute("totalCollection",totalCollection);
//        //收藏数量
//        Integer totalMenu=menuService.countMenusById(userId);
//        if (totalMenu==null){
//            totalMenu=0;
//        }
//        model.addAttribute("totalMenu",totalMenu);
//        //用户菜谱
//        List<Menu> userMenus=menuService.findAllMenuByUserId(userId,1,3);
//        model.addAttribute("userMenus",userMenus);
//        //用户作品
//        List<Works> works=worksService.findWorksByUserId(userId,1,3);
//        model.addAttribute("works",works);
//        //用户收藏
//        List<Collection> collections=collectionService.findCollectionsByUserId(userId,1,3);
//        model.addAttribute("collections",collections);
//        return "myKitchen";
//    }


    @RequestMapping("/kitchen")
    public String kitchen(@RequestParam("userId")Integer userId,Model model,HttpServletRequest request){
        //自己的userId
        HttpSession session=request.getSession();
        Integer myUserId=(Integer)session.getAttribute("userId");
        model.addAttribute("myUserId",myUserId);
        //访问用户信息
        UserInfo userInfo=userInfoService.findUserById(userId);
        model.addAttribute("userInfo",userInfo);
        //菜谱数量
        Integer totalWork=worksService.countWorksById(userId);
        if (totalWork==null){
            totalWork=0;
        }
        model.addAttribute("totalWork",totalWork);
        //作品数量
        Integer totalCollection=collectionService.countCollectionsById(userId);
        if (totalCollection==null){
            totalCollection=0;
        }
        model.addAttribute("totalCollection",totalCollection);
        //收藏数量
        Integer totalMenu=menuService.countMenusById(userId);
        if (totalMenu==null){
            totalMenu=0;
        }
        model.addAttribute("totalMenu",totalMenu);
        //用户菜谱
        List<Menu> userMenus=menuService.findAllMenuByUserId(userId,1,3);
        model.addAttribute("userMenus",userMenus);
        //用户作品
        List<Works> works=worksService.findWorksByUserId(userId,1,3);
        model.addAttribute("works",works);
        //用户收藏
        List<Collection> collections=collectionService.findCollectionsByUserId(userId,1,3);
        model.addAttribute("collections",collections);
        Integer follow=userInfoService.countFollow(userId);
        Integer followed=userInfoService.countFollowed(userId);
        model.addAttribute("follow",follow);
        model.addAttribute("followed",followed);
        return "myKitchen";
    }

    @RequestMapping("/addFollow")
    @ResponseBody
    public String addFollow(FollowTable followTable){
//        System.out.println(followTable);
        FollowTable isExist=userInfoService.findFollowTableIsExit(followTable);
//        System.out.println(isExist);
        if(isExist==null){
            userInfoService.addFollowTable(followTable);
            return "200";
        }else{
            return "400";
        }
    }
}
