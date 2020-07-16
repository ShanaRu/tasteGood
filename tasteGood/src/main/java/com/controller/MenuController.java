package com.controller;

import com.domain.*;
import com.github.pagehelper.PageInfo;
import com.service.LeaveMessageService;
import com.service.MenuService;
import com.service.UserInfoService;
import com.service.WorksService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;
    @Autowired
    private LeaveMessageService leaveMessageService;
    @Autowired
    private UserInfoService userInfoService;
    @Autowired
    private WorksService worksService;

    //写菜谱页面
    @RequestMapping("/addMenu")
    public String writeMenu(Model model){
        List<Menu> menus=menuService.recommendMenu();
        model.addAttribute("menus",menus);
        return "addMenu";
    }

    @RequestMapping(value = "/saveMenu")
    public @ResponseBody String saveMenu(@RequestBody String jsonData, HttpServletRequest request){
        JSONObject menuData = new JSONObject(jsonData);//从前端拿到的数据
        String menuName=menuData.getString("menuName");
        String menuCover=menuData.getString("menuCover");
        String menuDetail=menuData.getString("menuDetail");
        String time=menuData.getString("uploadTime");
        Date uploadTime=new Date();//当前时间
        String tip=menuData.getString("tip");
        String classification=menuData.getString("classification");
        JSONArray ingredientsArray=menuData.getJSONArray("ingredients");
        JSONArray stepsArray=menuData.getJSONArray("steps");
        //放入Menu对象中
        Menu menu=new Menu();
        menu.setMenuCover(menuCover);
        menu.setMenuDetail(menuDetail);
        menu.setTip(tip);
        menu.setClassification(classification);
        menu.setUploadTime(uploadTime);
        menu.setMenuName(menuName);
        menu.setTotalComplete(0);
        HttpSession session=request.getSession();//获取用户id
        Integer uid=(Integer)session.getAttribute("userId");
        menu.setUserId(uid);
        menu.setCollection(0);
        Integer newId=menuService.saveMenu(menu);//拿到的新增id
        saveIngredients(newId,ingredientsArray);
        saveSteps(newId,stepsArray);
        return "200";
    }

    @RequestMapping("/saveIngredients")
    public void saveIngredients(Integer newId,JSONArray ingredientsArray){
        JSONObject ingredientsObject;
        Ingredients oneIngredient =new Ingredients();
        for (int i = 0; i < ingredientsArray.length(); i++) {
            ingredientsObject = ingredientsArray.getJSONObject(i);
            String ingredient = ingredientsObject.getString("ingredient");
            String dosage = ingredientsObject.getString("dosage");
            oneIngredient.setIngredient(ingredient);
            oneIngredient.setDosage(dosage);
            oneIngredient.setMenuId(newId);
            menuService.saveIngredients(oneIngredient);
        }

    }

    @RequestMapping("/saveSteps")
    public void saveSteps(Integer newId,JSONArray stepsArray){
        JSONObject stepsObject;
        Steps oneSteps =new Steps();
        for (int i = 0; i < stepsArray.length(); i++){
            stepsObject = stepsArray.getJSONObject(i);
            String step = stepsObject.getString("step");
            String stepChar = stepsObject.getString("stepChar");
            oneSteps.setStep(step);
            oneSteps.setStepChar(stepChar);
            oneSteps.setMenuId(newId);
            menuService.saveSteps(oneSteps);
        }
    }


    //用户菜谱列表
    @RequestMapping("/userMenu")
    public String userMenu(@RequestParam("userId")Integer userId,Model model, HttpServletRequest request,@RequestParam("page") Integer page,@RequestParam("size") Integer size){
        HttpSession session=request.getSession();
        Integer myUserId=(int)session.getAttribute("userId");//自己的
        model.addAttribute("myUserId",myUserId);
        //访问用户的
        List<Menu> menus=menuService.findAllMenuByUserId(userId,page,size);
        PageInfo<Menu> pageInfo=new PageInfo<>(menus);
        model.addAttribute("pageInfo",pageInfo);
        //用户信息
        UserInfo userInfo=userInfoService.findUserById(userId);
        model.addAttribute("userInfo",userInfo);
        Integer follow=userInfoService.countFollow(userId);
        Integer followed=userInfoService.countFollowed(userId);
        model.addAttribute("follow",follow);
        model.addAttribute("followed",followed);
        return "userMenu";
    }

    //菜谱详细信息
    @RequestMapping("/showMenu")
    public String showMenu(@RequestParam("menuId")Integer menuId,Model model){
        Menu menu=menuService.findMenuByMenuId(menuId);
        model.addAttribute("menu",menu);
        UserInfo menuUser=userInfoService.findUserById(menu.getUserId());
        model.addAttribute("menuUser",menuUser);//菜谱对应的用户信息
        List<LeaveMessage> leaveMessages=leaveMessageService.getLeaveMessageByMenuId(menuId);
        model.addAttribute("leaveMessages",leaveMessages);
        List<UserInfo> userInfos=new ArrayList<>();
        for (LeaveMessage leaveMessage:leaveMessages){
            userInfos.add(userInfoService.findUserNamePhoto(leaveMessage.getUserId()));
        }//留言对应的用户信息
        model.addAttribute("userInfos",userInfos);
        List<Menu> menus=menuService.recommendMenu();
        model.addAttribute("menus",menus);
        List<Works> menuWork=worksService.getMenuWorks(menuId);
        model.addAttribute("menuWork",menuWork);
        return "showMenu";
    }

    //跳到修改菜谱页面
    @RequestMapping("/modifyMenu")
    public String modifyMenu(@RequestParam("menuId")Integer menuId,Model model){
        Menu menu=menuService.findMenuByMenuId(menuId);
        model.addAttribute("menu",menu);
        List<Menu> recommends=menuService.recommendMenu();
        model.addAttribute("recommends",recommends);
        return "modifyMenu";
    }

    //更新菜谱信息
    @RequestMapping("/updateMenu")
    @ResponseBody
    public String updateMenu(@RequestBody String updateData){
        //从前端拿到的数据
        JSONObject updateMenu = new JSONObject(updateData);
        String menuName=updateMenu.getString("menuName");
        String menuCover=updateMenu.getString("menuCover");
        String menuDetail=updateMenu.getString("menuDetail");
        String time=updateMenu.getString("uploadTime");
        Date uploadTime=new Date();//当前时间
        String tip=updateMenu.getString("tip");
        String classification=updateMenu.getString("classification");
        Integer menuId=updateMenu.getInt("menuId");
        Integer userId=updateMenu.getInt("userId");
        Integer collection=updateMenu.getInt("collection");
        Integer totalComplete=updateMenu.getInt("totalComplete");
        JSONArray ingredientsArray=updateMenu.getJSONArray("ingredients");
        JSONArray stepsArray=updateMenu.getJSONArray("steps");
        //先删掉子表数据
        menuService.deleteIngredients(menuId);
        menuService.deleteSteps(menuId);
        //放入Menu对象中
        Menu menu=new Menu();
        menu.setMenuName(menuName);
        menu.setMenuCover(menuCover);
        menu.setMenuDetail(menuDetail);
        menu.setClassification(classification);
        menu.setCollection(collection);
        menu.setTotalComplete(totalComplete);
        menu.setTip(tip);
        menu.setUploadTime(uploadTime);
        menu.setMenuId(menuId);
        menu.setUserId(userId);
        menuService.updateMenu(menu);//更新菜单
        saveIngredients(menuId,ingredientsArray);
        saveSteps(menuId,stepsArray);
        return "200";
    }

    //删除菜谱
    @RequestMapping("/deleteMenu")
    @ResponseBody
    public String deleteMenu(@RequestParam("menuId") Integer menuId){
        System.out.println(menuId);
        menuService.deleteMenu(menuId);
        return "200";
    }

    //根据名称模糊查找菜谱
    @RequestMapping("/searchMenu")
    public String searchMenu(@RequestParam("searchMenuName") String searchMenuName,@RequestParam("page") Integer page,@RequestParam("size") Integer size,Model model){
        model.addAttribute("searchMenuName",searchMenuName);
        List<Menu> menus=menuService.searchMenu(searchMenuName,page,size);
        PageInfo<Menu> pageInfo=new PageInfo<>(menus);
        model.addAttribute("pageInfo",pageInfo);
        return "searchMenu";
    }

    //根据菜谱查找菜谱
    @RequestMapping("/searchClassification")
    public String searchClassification(@RequestParam("classification") String classification,@RequestParam(name = "page", defaultValue = "1") int page, @RequestParam(name = "size", defaultValue = "6") int size,Model model){
        List<Menu> menus=menuService.searchClassification(classification,page,size);
        model.addAttribute("classification",classification);//目前分类
        //PageInfo是一个分页Bean
        PageInfo<Menu> pageInfo=new PageInfo<>(menus);
        model.addAttribute("pageInfo",pageInfo);
        return "classificationMenu";
    }
}
