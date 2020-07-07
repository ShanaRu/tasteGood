package com.dao;

import com.domain.Collection;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface CollectionDao {
    //根据用户id查询所有收藏
    @Select("select * from collections where userId=#{userId}")
    List<Collection> findCollectionsByUserId(Integer userId);

    @Update("update collections set complete=#{complete} where menuId=#{menuId} and userId=#{userId}")
    void updateComplete(Collection collection);

    @Delete("delete from collections where menuId=#{menuId} and userId=#{userId}")
    void deleteCollection(Collection collection);

    @Insert("Insert into collections(complete,menuId,userId) values(#{complete},#{menuId},#{userId})")
    void addCollection(Collection collection);

    @Select("select * from collections where menuId=#{menuId} and userId=#{userId}")
    Collection findCollectionById(Collection collection);
}
