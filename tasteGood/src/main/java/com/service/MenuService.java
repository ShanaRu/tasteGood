package com.service;

import com.domain.Ingredients;
import com.domain.Menu;
import com.domain.Steps;

import java.util.List;

public interface MenuService {
    //查询所有菜单信息
    public List<Menu> findAllMenu();

    //保存所有菜单
    public Integer saveMenu(Menu menu);

    //保存菜单食材
    public void saveIngredients(Ingredients ingredients);

    //保存菜单步骤
    public void saveSteps(Steps steps);

    //根据用户id查询所有菜谱
    public List<Menu> findAllMenuByUserId(Integer userId);

    //根据菜谱id查询菜谱信息
    public Menu findMenuByMenuId(Integer menuId);

    //删除菜单食材
    public void deleteIngredients(Integer menuId);

    //删除菜单步骤
    public void deleteSteps(Integer menuId);

    //更新菜谱
    public void updateMenu(Menu menu);

    //根据菜谱id获取全部Ingredients
    public List<Ingredients> findIngredientsByMenuId(Integer menuId);

    //根据菜谱id获取全部Steps
    public List<Steps> findStepsByMenuId(Integer menuId);

    //删除菜谱
    public void deleteMenu(Integer menuId);

}
