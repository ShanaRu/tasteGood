package com.dao;

import com.domain.UserRole;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface UserRoleDao {

    //添加用户的角色
    @Insert("Insert into userRole(userId,roleId) values(#{userId},#{roleId})")
    public void addUserRole(UserRole userRole);

    @Select("select roleId from userRole where userId=#{userId}")
    Integer findRoleId(Integer userId);
}
