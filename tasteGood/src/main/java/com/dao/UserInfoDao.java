package com.dao;

import com.domain.UserInfo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserInfoDao {

    //查找所有用户信息
    @Select("select * from userInfo")
    public List<UserInfo> findAllUser();

    //插入一行用户信息
    @Insert("Insert into userInfo(userName,userPassword,userIntroduce,userSex,userPhoto) values(#{userName},#{userPassword},#{userIntroduce},#{userSex},#{userPhoto})")
    public void saveUserInfo(UserInfo userInfo);

    //根据userName查找用户信息
    @Select("select * from userInfo where userName=#{userName}")
    public UserInfo findUser(String userName);

//    @Select("select * from userInfo where userName=#{userName}")
//    public List<UserInfo> findUserName(String userName);

}
