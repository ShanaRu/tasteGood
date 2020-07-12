package com.dao;

import com.domain.Collection;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface CollectionDao {
    //根据用户id查询所有收藏
    @Select("select * from collections where userId=#{userId}")
    @Results(id="userCollection",value = {
            @Result(id=true,property = "menuId",column = "menuId"),
            @Result(id=true,property = "userId",column = "userId"),
            @Result(property = "complete",column = "complete"),
            @Result(column = "menuId",property = "menu",one = @One(select ="com.dao.MenuDao.findMenuByMenuId"))
    })
    List<Collection> findCollectionsByUserId(Integer userId);

    //更新用户收藏的完成量
    @Update("update collections set complete=#{complete} where menuId=#{menuId} and userId=#{userId}")
    void updateComplete(Collection collection);

    //用户删除收藏
    @Delete("delete from collections where menuId=#{menuId} and userId=#{userId}")
    void deleteCollection(Collection collection);

    //用户添加收藏
    @Insert("Insert into collections(complete,menuId,userId) values(#{complete},#{menuId},#{userId})")
    void addCollection(Collection collection);

    //根据menuId和userId查询收藏
    @Select("select * from collections where menuId=#{menuId} and userId=#{userId}")
    Collection findCollectionById(Collection collection);

    //计算每个menuId完成度的总和
    @Select("select sum(complete) complete,menuId from collections group by menuId order by sum(complete) desc")
//    @Results(id="PopularCollection",value = {
//            @Result(id=true,property = "menuId",column = "menuId"),
//            @Result(id=true,property = "userId",column = "userId"),
//            @Result(property = "complete",column = "complete"),
//            @Result(column = "menuId",property = "menu",one = @One(select ="com.dao.MenuDao.findMenuByMenuId"))
//    })
    List<Collection> getPopularCollection();

    //根据userId查询用户的收藏量
    @Select("select count(*) totalCollection from collections where userId=#{userId} group by userId")
    Integer countCollectionsById(Integer userId);
}
