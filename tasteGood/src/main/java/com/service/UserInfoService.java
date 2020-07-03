package com.service;

import com.domain.UserInfo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.omg.PortableInterceptor.INACTIVE;

import java.util.List;

public interface UserInfoService {

    //查找所有用户信息
    public List<UserInfo> findAllUser();

    //保存用户信息
    public void saveUserInfo(UserInfo userInfo);

    //根据userName查找用户信息
    public UserInfo findUser(String userName);

    //查找userName是否重复
    public UserInfo findUserName(String userName);

    //根据userId查找用户信息
    public UserInfo findUserById(Integer userId);

    //更新用户信息
    public void updateUserInfo(String userName,Integer userSex,String userIntroduce,Integer userId);

    //更新密码
    public void updatePassword(String userPassword,Integer userId);

    //更新头像
    public void updateUserPhoto(String userPhoto,Integer userId);

}
