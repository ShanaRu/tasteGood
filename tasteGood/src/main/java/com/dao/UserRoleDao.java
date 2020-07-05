package com.dao;

import com.domain.UserRole;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;

public interface UserRoleDao {

    //添加用户的角色
    @Insert("Insert into userRole(userId,roleId) values(#{userId},#{roleId})")
    public void addUserRole(UserRole userRole);
}
