package com.dao;

import com.domain.UserInfo;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserInfoDao {

    //查找所有用户信息
    @Select("select * from userInfo")
    public List<UserInfo> findAllUser();

    //插入一行用户信息
    @Insert("Insert into userInfo(userName,userPassword,userIntroduce,userSex,userPhoto) values(#{userName},#{userPassword},#{userIntroduce},#{userSex},#{userPhoto})")
    @Options(useGeneratedKeys=true,keyProperty="userId",keyColumn="userId")
    public int saveUserInfo(UserInfo userInfo);

    //根据userName查找用户信息
    @Select("select * from userInfo where userName=#{userName}")
    public UserInfo findUser(String userName);

//    @Select("select * from userInfo where userName=#{userName}")
//    public List<UserInfo> findUserName(String userName);

    //根据userId查找用户信息
    @Select("select * from userInfo where userId=#{userId}")
    public UserInfo findUserById(Integer userId);

    //更新用户信息
    @Update("update userInfo set userName=#{userName},userSex=#{userSex},userIntroduce=#{userIntroduce} where userId=#{userId}")
    public void updateUserInfo(@Param("userName")String userName,@Param("userSex")Integer userSex,@Param("userIntroduce")String userIntroduce,@Param("userId")Integer userId);

    //更新密码
    @Update("update userInfo set userPassword=#{userPassword} where userId=#{userId}")
    public void updatePassword(@Param("userPassword")String userPassword,@Param("userId")Integer userId);

    //更新头像
    @Update("update userInfo set userPhoto=#{userPhoto} where userId=#{userId}")
    public void updateUserPhoto(@Param("userPhoto")String userPhoto,@Param("userId")Integer userId);

}
