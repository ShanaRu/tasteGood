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
}
