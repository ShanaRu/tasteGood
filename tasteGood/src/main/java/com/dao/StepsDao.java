package com.dao;

import com.domain.Steps;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StepsDao {
    @Insert("Insert into steps(menuId,step,stepChar) values(#{menuId},#{step},#{stepChar})")
    public void saveSteps(Steps steps);

    @Select("select * from steps where menuId=#{menuId}")
    List<Steps> findStepsById(int menuId);
}
