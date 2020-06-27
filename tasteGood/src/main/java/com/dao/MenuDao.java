package com.dao;

import com.domain.Menu;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuDao {
    //查询所有菜单
    @Select("select * from menu")
    @Results(id="menuMap",value = {
            @Result(id=true,property = "menuId",column = "menuId"),
            @Result(property = "menuName",column = "menuName"),
            @Result(property = "menuCover",column = "menuCover"),
            @Result(property = "menuDetail",column = "menuDetail"),
            @Result(property = "tip",column = "tip"),
            @Result(property = "uploadTime",column = "uploadTime"),
            @Result(property = "userId",column = "userId"),
            @Result(property = "collection",column = "collection"),
            @Result(property = "classification",column = "classification"),
            @Result(column = "menuId",property = "Ingredients",many = @Many(select ="com.dao.IngredientsDao.findIngredientsById")),
            @Result(column = "menuId",property = "Step",many = @Many(select = "com.dao.StepDao.findStepById"))
    })
    public List<Menu> findAllMenu();

    //保存菜单信息
    @Insert("Insert into menu(menuName,menuCover,menuDetail,tip,uploadTime,userId,collection,classification) values(#{menuName},#{menuCover},#{menuDetail},#{tip},#{uploadTime},#{userId},#{collection},#{classification})")
    @Options(useGeneratedKeys=true,keyProperty="menuId",keyColumn="menuId")
    public int saveMenu(Menu menu);
}
