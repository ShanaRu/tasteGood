package com.controller;

import com.domain.Ingredients;
import com.domain.Menu;
import com.domain.Steps;
import com.domain.Update;
import com.service.MenuService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public @ResponseBody Update saveMenu(@RequestBody String jsonData, HttpServletResponse response, HttpServletRequest request)throws IOException {
        System.out.println("数据传到控制层了");
        JSONObject menuData = new JSONObject(jsonData);//拿到的数据
        String menuName=menuData.getString("menuName");
        String menuCover=menuData.getString("menuCover");
        String menuDetail=menuData.getString("menuDetail");
        String time=menuData.getString("uploadTime");
        Date uploadTime=new Date();
        String tip=menuData.getString("tip");
        JSONArray ingredientsArray=menuData.getJSONArray("ingredients");
        JSONArray stepsArray=menuData.getJSONArray("steps");
        Menu menu=new Menu();
        menu.setMenuCover(menuCover);
        menu.setMenuDetail(menuDetail);
        menu.setTip(tip);
        menu.setUploadTime(uploadTime);
        menu.setMenuName(menuName);
        HttpSession session=request.getSession();
        Integer uid=(Integer)session.getAttribute("userId");
        menu.setUserId(uid);
        menu.setClassification("汤");
        menu.setCollection(0);
        Integer newId=menuService.saveMenu(menu);//拿到的新增id
        saveIngredients(newId,ingredientsArray);
        saveSteps(newId,stepsArray);
        System.out.println("写完了跳转主页");
        Update update=new Update();
        update.setResult("success");
        update.setCode(200);
        return update;

//        response.sendRedirect(request.getContextPath()+"/userInfo/homePage");
//        JSONObject json =new JSONObject();
//        json.put("result"," success");
//        response.setCharacterEncoding("utf-8");
//        response.setContentType("application/json;charset=utf-8");
//        response.getWriter().print(json.toString());


    }

    @RequestMapping("/saveIngredients")
    public void saveIngredients(Integer newId,JSONArray ingredientsArray){
        System.out.println("执行了菜单材料");
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
            System.out.println(oneIngredient);
        }

    }

    @RequestMapping("/saveSteps")
    public void saveSteps(Integer newId,JSONArray stepsArray){
        System.out.println("执行了菜单步骤");
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
            System.out.println(oneSteps);
        }
    }

    //根据userid查询菜谱
    @RequestMapping("/userMenu")
    public String userMenu(Model model, HttpServletRequest request, HttpServletResponse response){
        HttpSession session=request.getSession();
//        System.out.println(session.getAttribute("userName"));
//        System.out.println(session.getAttribute("userId"));
        Integer uid=(int)session.getAttribute("userId");
//        System.out.println(uid);
        List<Menu> menus=menuService.findAllMenuByUserId(uid);
//        List<Menu> menus=menuService.findAllMenuByUserId(3);
        for (Menu menu:menus){
            System.out.println(menu);
            System.out.println(menu.getIngredients());
            System.out.println(menu.getSteps());
        }
        model.addAttribute("userMenus",menus);
        return "userMenu";
    }

    //根据menuId查询菜谱
    @RequestMapping("/showMenu")
    public String showMenu(@RequestParam("menuId")Integer menuId,Model model){
//        System.out.println(menuId);
        Menu menu=menuService.findMenuByMenuId(menuId);
        model.addAttribute("menu",menu);
        return "showMenu";
    }

}
