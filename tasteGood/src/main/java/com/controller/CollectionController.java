package com.controller;

import com.domain.Collection;
import com.domain.Menu;
import com.domain.UserInfo;
import com.github.pagehelper.PageInfo;
import com.service.CollectionService;
import com.service.MenuService;
import com.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/collection")
public class CollectionController {

    @Autowired
    private CollectionService collectionService;
    @Autowired
    private MenuService menuService;
    @Autowired
    private UserInfoService userInfoService;

    @RequestMapping("/showCollections")
    public String showCollection(@RequestParam("userId") Integer userId, HttpServletRequest request, Model model,@RequestParam("page") Integer page,@RequestParam("size") Integer size){
        Integer follow=userInfoService.countFollow(userId);
        Integer followed=userInfoService.countFollowed(userId);
        model.addAttribute("follow",follow);
        model.addAttribute("followed",followed);
        HttpSession session=request.getSession();//获取用户id
        Integer myUserId=(Integer)session.getAttribute("userId");//自己的
        model.addAttribute("myUserId",myUserId);
        List<Collection> collections=collectionService.findCollectionsByUserId(userId,page,size);//获取收藏表，显示complete
        PageInfo<Collection> pageInfo=new PageInfo<>(collections);
        model.addAttribute("pageInfo",pageInfo);
        UserInfo userInfo=userInfoService.findUserById(userId);
        model.addAttribute("userInfo",userInfo);

        return "showCollections";
    }

    @RequestMapping(value = "/updateComplete")
    @ResponseBody
    public String updateComplete(Collection collection){
        collectionService.updateComplete(collection);
        Menu menu=menuService.findMenuByMenuId(collection.getMenuId());
        menuService.updateTotalComplete(collection.getMenuId(),menu.getTotalComplete()+1);
        return "200";
    }

    @RequestMapping(value = "/deleteCollection")
    @ResponseBody
    public String deleteCollection(Collection collection){
        collectionService.deleteCollection(collection);
        return "200";
    }

    @RequestMapping(value = "/addCollection")
    @ResponseBody
    public String addCollection(@RequestParam("menuId") Integer menuId,HttpServletRequest request){
        Collection collection=new Collection();
        collection.setComplete(0);
        collection.setMenuId(menuId);
        HttpSession session=request.getSession();//获取用户id
        Integer uid=(Integer)session.getAttribute("userId");
        collection.setUserId(uid);
        Collection isExist=collectionService.findCollectionById(collection);//查询是否已经收藏了
        if(isExist==null){
            collectionService.addCollection(collection);
            Integer getCollection=menuService.getCollection(menuId);
            menuService.updateCollection(menuId,getCollection+1);//collection+1
            return "200";
        }else{
            return "400";
        }
    }


}
