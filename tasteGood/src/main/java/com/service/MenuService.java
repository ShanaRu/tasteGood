package com.service;

import com.domain.Ingredients;
import com.domain.Menu;
import com.domain.Step;

import java.util.List;

public interface MenuService {
    //查询所有菜单信息
    public List<Menu> findAllMenu();

    //保存所有菜单
    public int saveMenu(Menu menu);

    //保存菜单食材
    public void saveIngredients(Ingredients ingredients);

    //保存菜单步骤
    public void saveStep(Step step);

    //根据用户id查询所有菜谱
    public List<Menu> findAllMenuByUserId(int userId);

    //根据菜谱id查询菜谱信息
    public Menu findMenuByMenuId(int menuId);
}
