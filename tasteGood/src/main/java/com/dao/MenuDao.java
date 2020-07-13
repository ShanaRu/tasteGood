package com.dao;

import com.domain.Collection;
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
            @Result(property = "totalComplete",column = "totalComplete"),
            @Result(column = "menuId",property = "Ingredients",many = @Many(select ="com.dao.IngredientsDao.findIngredientsById")),
            @Result(column = "menuId",property = "Steps",many = @Many(select = "com.dao.StepsDao.findStepsById"))
    })
    List<Menu> findAllMenu();

    //保存菜单信息
    @Insert("Insert into menu(menuName,menuCover,menuDetail,tip,uploadTime,userId,collection,classification,totalComplete) values(#{menuName},#{menuCover},#{menuDetail},#{tip},#{uploadTime},#{userId},#{collection},#{classification},#{totalComplete})")
    @Options(useGeneratedKeys=true,keyProperty="menuId",keyColumn="menuId")
    int saveMenu(Menu menu);

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
            @Result(property = "totalComplete",column = "totalComplete"),
            @Result(column = "menuId",property = "Ingredients",many = @Many(select ="com.dao.IngredientsDao.findIngredientsById")),
            @Result(column = "menuId",property = "Steps",many = @Many(select = "com.dao.StepsDao.findStepsById"))
    })
    List<Menu> findAllMenuByUserId(int userId);

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
            @Result(property = "totalComplete",column = "totalComplete"),
            @Result(column = "menuId",property = "Ingredients",many = @Many(select ="com.dao.IngredientsDao.findIngredientsById")),
            @Result(column = "menuId",property = "Steps",many = @Many(select = "com.dao.StepsDao.findStepsById"))
    })
    Menu findMenuByMenuId(int menuId);


    //更新菜单信息
    @Update("Update menu set menuName=#{menuName},menuCover=#{menuCover},menuDetail=#{menuDetail},tip=#{tip},uploadTime=#{uploadTime},collection=#{collection},classification=#{classification},totalComplete=#{totalComplete} where menuId=#{menuId}")
    void updateMenu(Menu menu);

    //删除菜谱
    @Delete("Delete from menu where menuId=#{menuId}")
    void deleteMenu(Integer menuId);

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
            @Result(property = "totalComplete",column = "totalComplete"),
            @Result(column = "menuId",property = "Ingredients",many = @Many(select ="com.dao.IngredientsDao.findIngredientsById")),
            @Result(column = "menuId",property = "Steps",many = @Many(select = "com.dao.StepsDao.findStepsById"))
    })
    List<Menu> searchMenu(String menuName);

    @Select("select * from menu where classification=#{classification}")
    @Results(id="searchClassification",value = {
            @Result(id=true,property = "menuId",column = "menuId"),
            @Result(property = "menuName",column = "menuName"),
            @Result(property = "menuCover",column = "menuCover"),
            @Result(property = "menuDetail",column = "menuDetail"),
            @Result(property = "tip",column = "tip"),
            @Result(property = "uploadTime",column = "uploadTime"),
            @Result(property = "userId",column = "userId"),
            @Result(property = "collection",column = "collection"),
            @Result(property = "classification",column = "classification"),
            @Result(property = "totalComplete",column = "totalComplete"),
            @Result(column = "menuId",property = "Ingredients",many = @Many(select ="com.dao.IngredientsDao.findIngredientsById")),
            @Result(column = "menuId",property = "Steps",many = @Many(select = "com.dao.StepsDao.findStepsById"))
    })
    List<Menu> searchClassification(String classification);

    //获取collection信息
    @Select("select collection from menu where menuId=#{menuId}")
    Integer getCollection(Integer menuId);

    //更新收藏字段
    @Update("Update menu set collection=#{collection} where menuId=#{menuId}")
    void updateCollection(@Param("menuId") Integer menuId,@Param("collection") Integer collection);

    //按收藏数量排行
    @Select("select * from menu order by collection desc")
    @Results(id="searchCollection",value = {
            @Result(id=true,property = "menuId",column = "menuId"),
            @Result(property = "menuName",column = "menuName"),
            @Result(property = "menuCover",column = "menuCover"),
            @Result(property = "menuDetail",column = "menuDetail"),
            @Result(property = "tip",column = "tip"),
            @Result(property = "uploadTime",column = "uploadTime"),
            @Result(property = "userId",column = "userId"),
            @Result(property = "collection",column = "collection"),
            @Result(property = "classification",column = "classification"),
            @Result(property = "totalComplete",column = "totalComplete"),
            @Result(column = "menuId",property = "Ingredients",many = @Many(select ="com.dao.IngredientsDao.findIngredientsById")),
            @Result(column = "menuId",property = "Steps",many = @Many(select = "com.dao.StepsDao.findStepsById"))
    })
    List<Menu> getPopularMenus();

    //用户写的菜谱数量
    @Select("select count(*) totalMenu from menu where userId=#{userId} group by userId")
    Integer countMenusById(Integer userId);

    //按totalComplete排行
    @Select("select * from menu order by totalComplete desc")
    List<Menu> getMenusByTotalComplete();

    @Update("Update menu set totalComplete=#{totalComplete} where menuId=#{menuId}")
    void updateTotalComplete(@Param("menuId") Integer menuId,@Param("totalComplete") Integer totalComplete);

    //推荐菜谱
    @Select("select * from menu order by rand() limit 4")
    List<Menu> recommendMenu();

}
