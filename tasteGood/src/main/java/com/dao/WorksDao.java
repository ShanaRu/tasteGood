package com.dao;

import com.domain.Works;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface WorksDao {
    @Insert("insert into works(menuName,menuId,workId,summary,workPhoto,likes,userId,workTime) values(#{menuName},#{menuId},#{workId},#{summary},#{workPhoto},#{likes},#{userId},#{workTime})")
    public void saveWorks(Works works);

    @Select("select * from works where userId=#{userId}")
    List<Works> findWorksByUserId(Integer userId);

    @Select("select * from works where workId=#{workId}")
    Works findWorksByWorkId(Integer workId);

    @Update("update works set summary=#{summary},workPhoto=#{workPhoto},workTime=#{workTime} where workId=#{workId}")
    public void updateWork(@Param("workPhoto") String workPhoto, @Param("summary") String summary, @Param("workId") Integer workId, @Param("workTime") Date workTime);

    @Select("select * from works order by workTime desc")
    public List<Works> showWorks();

    @Delete("delete from works where workId=#{workId}")
    public void deleteWork(Integer workId);

    @Update("update works set likes=#{likes} where workId=#{workId}")
    public void addLikes(@Param("workId") Integer workId,@Param("likes")Integer likes);

}
