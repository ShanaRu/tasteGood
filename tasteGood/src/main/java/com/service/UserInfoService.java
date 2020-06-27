package com.service;

import com.domain.UserInfo;

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

}
