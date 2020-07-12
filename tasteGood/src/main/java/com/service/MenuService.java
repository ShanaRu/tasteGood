package com.service;

import com.domain.Collection;
import com.domain.Ingredients;
import com.domain.Menu;
import com.domain.Steps;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuService {
    //查询所有菜单信息
    List<Menu> findAllMenu();

    //保存所有菜单
    Integer saveMenu(Menu menu);

    //保存菜单食材
    void saveIngredients(Ingredients ingredients);

    //保存菜单步骤
    void saveSteps(Steps steps);

    //根据用户id查询所有菜谱
    List<Menu> findAllMenuByUserId(Integer userId,Integer page,Integer size);

    //根据菜谱id查询菜谱信息
    Menu findMenuByMenuId(Integer menuId);

    //删除菜单食材
    void deleteIngredients(Integer menuId);

    //删除菜单步骤
    void deleteSteps(Integer menuId);

    //更新菜谱
    void updateMenu(Menu menu);

    //根据菜谱id获取全部Ingredients
    List<Ingredients> findIngredientsByMenuId(Integer menuId);

    //根据菜谱id获取全部Steps
    List<Steps> findStepsByMenuId(Integer menuId);

    //删除菜谱
    void deleteMenu(Integer menuId);

    //模糊查询菜谱名
    List<Menu> searchMenu(String menuName,Integer page,Integer size);

    //根据分类找菜谱
    List<Menu> searchClassification(String classification,Integer page,Integer size);

    //查询收藏数量
    Integer getCollection(Integer menuId);

    //更新收藏数量
    void updateCollection(Integer menuId,Integer collection);

    //按收藏排行
    List<Menu> getPopularMenus();

    //用户收藏数量
    Integer countMenusById(Integer userId);

    //按TotalComplete排行
    List<Menu> getMenusByTotalComplete();

    //更新完成量
    void updateTotalComplete(Integer menuId,Integer totalComplete);
}
