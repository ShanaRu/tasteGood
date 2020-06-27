package com.service.Impl;

import com.dao.IngredientsDao;
import com.dao.MenuDao;
import com.dao.StepDao;
import com.domain.Ingredients;
import com.domain.Menu;
import com.domain.Step;
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
    private StepDao stepDao;

    @Override
    public List<Menu> findAllMenu() {
        System.out.println("业务层查找执行");
        return menuDao.findAllMenu();
    }

    @Override
    public int saveMenu(Menu menu) {
        System.out.println("业务层保存执行");
        int i=menuDao.saveMenu(menu);
        int newId=menu.getMenuId();
//        System.out.println("业务层的menu的i"+i);
//        System.out.println("业务层的id"+menu.getMenuId());
        return newId;
    }

    @Override
    public void saveIngredients(Ingredients ingredients) {
        System.out.println("业务层执行保存菜单食材");
        ingredientsDao.saveIngredients(ingredients);
    }

    @Override
    public void saveStep(Step step) {
        System.out.println("业务层执行保存菜单步骤");
        stepDao.saveStep(step);
        System.out.println("业务层完成");
    }

    @Override
    public List<Menu> findAllMenuByUserId(int userId) {
        List<Menu> menus=menuDao.findAllMenuByUserId(userId);
        return menus;
    }

    @Override
    public Menu findMenuByMenuId(int menuId) {
        Menu menu=menuDao.findMenuByMenuId(menuId);
        return menu;
    }
}
