package com.service.Impl;

import com.dao.IngredientsDao;
import com.dao.MenuDao;
import com.dao.StepsDao;
import com.domain.Ingredients;
import com.domain.Menu;
import com.domain.Steps;
import com.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("menuService")
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuDao menuDao;
    @Autowired
    private IngredientsDao ingredientsDao;
    @Autowired
    private StepsDao stepsDao;

    @Override
    public List<Menu> findAllMenu() {
        return menuDao.findAllMenu();
    }

    @Override
    public Integer saveMenu(Menu menu) {
        Integer i=menuDao.saveMenu(menu);
        Integer newId=menu.getMenuId();
        return newId;
    }

    @Override
    public void saveIngredients(Ingredients ingredients) {
        ingredientsDao.saveIngredients(ingredients);
    }

    @Override
    public void saveSteps(Steps steps) {
        stepsDao.saveSteps(steps);
    }

    @Override
    public List<Menu> findAllMenuByUserId(Integer userId) {
        List<Menu> menus=menuDao.findAllMenuByUserId(userId);
        return menus;
    }

    @Override
    public Menu findMenuByMenuId(Integer menuId) {
        Menu menu=menuDao.findMenuByMenuId(menuId);
        return menu;
    }

    @Override
    public void deleteIngredients(Integer menuId) {
        ingredientsDao.deleteIngredientsById(menuId);
    }

    @Override
    public void deleteSteps(Integer menuId) {
        stepsDao.deleteStepsById(menuId);
    }

    @Override
    public void updateMenu(Menu menu) {
        menuDao.updateMenu(menu);
    }

    @Override
    public List<Ingredients> findIngredientsByMenuId(Integer menuId) {
        return ingredientsDao.findIngredientsById(menuId);
    }

    @Override
    public List<Steps> findStepsByMenuId(Integer menuId) {
        return stepsDao.findStepsById(menuId);
    }

    @Override
    public void deleteMenu(Integer menuId) {
        menuDao.deleteMenu(menuId);
    }


}
