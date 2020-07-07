package com.controller;

import com.domain.Collection;
import com.domain.Ingredients;
import com.domain.Menu;
import com.domain.Steps;
import com.service.MenuService;
import com.sun.deploy.net.HttpResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @RequestMapping("/addMenu")
    public String writeMenu(){
        return "addMenu";
    }

    @RequestMapping(value = "/saveMenu")
    public @ResponseBody String saveMenu(@RequestBody String jsonData, HttpServletResponse response, HttpServletRequest request)throws IOException {
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


    //根据userid查询菜谱
    @RequestMapping("/userMenu")
    public String userMenu(Model model, HttpServletRequest request, HttpServletResponse response){
        HttpSession session=request.getSession();
        Integer uid=(int)session.getAttribute("userId");
        List<Menu> menus=menuService.findAllMenuByUserId(uid);
//        for (Menu menu:menus){
//            System.out.println(menu);
//            System.out.println(menu.getIngredients());
//            System.out.println(menu.getSteps());
//        }
        model.addAttribute("userMenus",menus);
        return "userMenu";
    }

    //根据menuId查询菜谱
    @RequestMapping("/showMenu")
    public String showMenu(@RequestParam("menuId")Integer menuId,Model model){
        Menu menu=menuService.findMenuByMenuId(menuId);
        model.addAttribute("menu",menu);
        return "showMenu";
    }

    //跳到修改菜谱页面
    @RequestMapping("/modifyMenu")
    public String modifyMenu(@RequestParam("menuId")Integer menuId,Model model){
        Menu menu=menuService.findMenuByMenuId(menuId);
        model.addAttribute("menu",menu);
        System.out.println(menu);
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
        menu.setTip(tip);
        menu.setUploadTime(uploadTime);
        menu.setMenuId(menuId);
//        HttpSession session=request.getSession();//获取用户id
//        Integer uid=(Integer)session.getAttribute("userId");
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
        menuService.deleteMenu(menuId);
        return "200";
    }

    //根据名称查找菜谱
    @RequestMapping("/searchMenu")
    public String searchMenu(@RequestParam("searchMenuName") String searchMenuName,Model model){
        List<Menu> menus=menuService.searchMenu(searchMenuName);
        model.addAttribute("menus",menus);
        return "searchMenu";
    }

    //根据菜谱查找菜谱
    @RequestMapping("/searchClassification")
    public String searchClassification(@RequestParam("classification") String classification,Model model){
        List<Menu> menus=menuService.searchClassification(classification);
        model.addAttribute("menus",menus);
        return "classificationMenu";
    }


}
