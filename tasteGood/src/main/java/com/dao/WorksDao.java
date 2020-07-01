package com.dao;

import com.domain.Works;
import org.apache.ibatis.annotations.Insert;
import org.springframework.stereotype.Repository;

@Repository
public interface WorksDao {
    @Insert("insert into works(menuName,menuId,workId,summary,workPhoto,likes) values(#{menuName},#{menuId},#{workId},#{summary},#{workPhoto},#{likes})")
    public void saveWorks(Works works);
}
