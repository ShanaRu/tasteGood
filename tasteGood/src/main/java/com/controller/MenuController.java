package com.controller;

import com.domain.Ingredients;
import com.domain.Menu;
import com.domain.Step;
import com.service.MenuService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

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
        System.out.println("数据传到控制层了");
        JSONObject menuData = new JSONObject(jsonData);//拿到的数据
        String menuName=menuData.getString("menuName");
        String menuCover=menuData.getString("menuCover");
        String menuDetail=menuData.getString("menuDetail");
        String time=menuData.getString("uploadTime");
        Date uploadTime=new Date();
        String tip=menuData.getString("tip");
        JSONArray ingredientsArray=menuData.getJSONArray("ingredients");
        JSONArray stepArray=menuData.getJSONArray("steps");

        Menu menu=new Menu();
        menu.setMenuCover(menuCover);
        menu.setMenuDetail(menuDetail);
        menu.setTip(tip);
        menu.setUploadTime(uploadTime);
        menu.setMenuName(menuName);
        HttpSession session=request.getSession();
        int uid=(int)session.getAttribute("userId");
        menu.setUserId(uid);
        menu.setClassification("汤");
        menu.setCollection(0);
        int newId=menuService.saveMenu(menu);//拿到的新增id
        System.out.println("新id"+newId);
        System.out.println("回到控制层");
        System.out.println("开始执行材料");
        saveIngredients(newId,ingredientsArray);
        System.out.println("开始执行步骤");
        saveStep(newId,stepArray);
        response.sendRedirect(request.getContextPath()+"/userInfo/homePage");
        return  "";
    }

    @RequestMapping("/saveIngredients")
    public void saveIngredients(int newId,JSONArray ingredientsArray){
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

    @RequestMapping("/saveStep")
    public void saveStep(int newId,JSONArray stepArray){
        System.out.println("执行了菜单步骤");
        JSONObject stepObject;
        Step oneStep=new Step();
        for (int i = 0; i < stepArray.length(); i++){
            stepObject = stepArray.getJSONObject(i);
            String step = stepObject.getString("step");
            String stepChar = stepObject.getString("stepChar");
            oneStep.setStep(step);
            oneStep.setStepChar(stepChar);
            oneStep.setMenuId(newId);
            menuService.saveStep(oneStep);
            System.out.println(oneStep);
        }
    }

}
