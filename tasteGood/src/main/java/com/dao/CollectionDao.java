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

    @Update("update collections set complete=#{complete} where menuId=#{menuId} and userId=#{userId}")
    void updateComplete(Collection collection);

    @Delete("delete from collections where menuId=#{menuId} and userId=#{userId}")
    void deleteCollection(Collection collection);

    @Insert("Insert into collections(complete,menuId,userId) values(#{complete},#{menuId},#{userId})")
    void addCollection(Collection collection);

    @Select("select * from collections where menuId=#{menuId} and userId=#{userId}")
    Collection findCollectionById(Collection collection);

    @Select("select sum(complete) complete,menuId from collections group by menuId order by sum(complete) desc")
    List<Collection> getPopularCollection();

    @Select("select count(*) totalCollection from collections where userId=#{userId} group by userId")
    Integer countCollectionsById(Integer userId);
}
