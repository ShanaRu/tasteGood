package com.dao;

import com.domain.Ingredients;
import com.domain.Step;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StepDao {
    @Insert("Insert into step(menuId,step,stepChar) values(#{menuId},#{step},#{stepChar})")
    public void saveStep(Step step);

    @Select("select * from step where menuId=#{menuId}")
    List<Step> findStepById(int menuId);
}
