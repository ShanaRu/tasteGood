package com.dao;

import com.domain.Ingredients;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IngredientsDao {
    @Insert("Insert into ingredients(menuId,ingredient,dosage) values(#{menuId},#{ingredient},#{dosage})")
    public void saveIngredients(Ingredients ingredients);

    @Select("select * from ingredients where menuId=#{menuId}")
    List<Ingredients> findIngredientsById(int menuId);

    @Delete("delete from ingredients where menuId=#{menuId}")
    public void deleteIngredientsById(int menuId);
}
