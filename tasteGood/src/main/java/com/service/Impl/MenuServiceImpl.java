package com.service.Impl;

import com.dao.IngredientsDao;
import com.dao.MenuDao;
import com.dao.StepsDao;
import com.domain.Collection;
import com.domain.Ingredients;
import com.domain.Menu;
import com.domain.Steps;
import com.github.pagehelper.PageHelper;
import com.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
        int i=menuDao.saveMenu(menu);
        return menu.getMenuId();
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
    public List<Menu> findAllMenuByUserId(Integer userId,Integer page,Integer size) {
        PageHelper.startPage(page,size);
        return menuDao.findAllMenuByUserId(userId);
    }

    @Override
    public Menu findMenuByMenuId(Integer menuId) {
        return menuDao.findMenuByMenuId(menuId);
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

    @Override
    public List<Menu> searchMenu(String menuName,Integer page,Integer size) {
        PageHelper.startPage(page, size);
        return menuDao.searchMenu(menuName);
    }

    public List<Menu> searchClassification(String classification,Integer page,Integer size){
        //参数pageNum 是页码值   参数pageSize 代表是每页显示条数
        PageHelper.startPage(page, size);
        return menuDao.searchClassification(classification);
    }

    @Override
    public Integer getCollection(Integer menuId) {
        return menuDao.getCollection(menuId);
    }

    @Override
    public void updateCollection(Integer menuId,Integer collection) {
        menuDao.updateCollection(menuId,collection);
    }

    @Override
    public List<Menu> getPopularMenus() {
        return menuDao.getPopularMenus();
    }

    @Override
    public Integer countMenusById(Integer userId) {
        return menuDao.countMenusById(userId);
    }

    @Override
    public List<Menu> getMenusByTotalComplete() {
        return menuDao.getMenusByTotalComplete();
    }

    @Override
    public void updateTotalComplete(Integer menuId, Integer totalComplete) {
        menuDao.updateTotalComplete(menuId,totalComplete);
    }

    @Override
    public List<Menu> recommendMenu() {
        return menuDao.recommendMenu();
    }
}

