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
            @Result(column = "menuId",property = "Steps",many = @Many(select = "com.dao.StepsDao.findStepsById"))
    })
    public List<Menu> findAllMenu();

    //保存菜单信息
    @Insert("Insert into menu(menuName,menuCover,menuDetail,tip,uploadTime,userId,collection,classification) values(#{menuName},#{menuCover},#{menuDetail},#{tip},#{uploadTime},#{userId},#{collection},#{classification})")
    @Options(useGeneratedKeys=true,keyProperty="menuId",keyColumn="menuId")
    public int saveMenu(Menu menu);

    //根据用户id查询所有菜谱
    @Select("select * from menu where userId=#{userId}")
    @Results(id="userMenu",value = {
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
            @Result(column = "menuId",property = "Steps",many = @Many(select = "com.dao.StepsDao.findStepsById"))
    })
    public List<Menu> findAllMenuByUserId(int userId);

    //根据菜谱id查询所有菜谱
    @Select("select * from menu where menuId=#{menuId}")
    @Results(id="oneMenu",value = {
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
            @Result(column = "menuId",property = "Steps",many = @Many(select = "com.dao.StepsDao.findStepsById"))
    })
    public Menu findMenuByMenuId(int menuId);


    //保存菜单信息
    @Update("Update menu set menuName=#{menuName},menuCover=#{menuCover},menuDetail=#{menuDetail},tip=#{tip},uploadTime=#{uploadTime},collection=#{collection},classification=#{classification} where menuId=#{menuId}")
    public void updateMenu(Menu menu);

    //删除菜谱
    @Delete("Delete from menu where menuId=#{menuId}")
    public void deleteMenu(Integer menuId);

    //模糊查询菜谱名
    @Select("select * from menu where menuName LIKE '%${value}%'")
    @Results(id="searchMenu",value = {
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
            @Result(column = "menuId",property = "Steps",many = @Many(select = "com.dao.StepsDao.findStepsById"))
    })
    public List<Menu> searchMenu(String menuName);
}
