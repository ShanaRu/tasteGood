package com.service;

import com.domain.FollowTable;
import com.domain.UserInfo;
import com.domain.UserRole;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.omg.PortableInterceptor.INACTIVE;

import java.util.List;

public interface UserInfoService {

    //查找所有用户信息
    List<UserInfo> findAllUser();

    //保存用户信息
    Integer saveUserInfo(UserInfo userInfo);

    //根据userName查找用户信息,无密码的
    UserInfo findUser(String userName);

    //查找userName是否重复
    UserInfo findUserName(String userName);

    //根据userId查找用户信息
    UserInfo findUserById(Integer userId);

    //根据userId查找全部用户信息
    UserInfo findUserInfoById(Integer userId);

    //更新用户信息
    void updateUserInfo(String userName,Integer userSex,String userIntroduce,Integer userId);

    //更新密码
    void updatePassword(String userPassword,Integer userId);

    //更新头像
    void updateUserPhoto(String userPhoto,Integer userId);

    //添加用户的角色
    void addUserRole(UserRole userRole);

    //根据userId查找用户名字和头像
    UserInfo findUserNamePhoto(Integer userId);

    void addFollowTable(FollowTable followTable);

    FollowTable findFollowTableIsExit(FollowTable followTable);

    Integer countFollow(Integer userId);

    Integer countFollowed(Integer userId);

    List<FollowTable> findFollow(Integer userId,Integer page,Integer size);

    List<FollowTable> findFollowed(Integer userId,Integer page,Integer size);

    void deleteFollow(FollowTable followTable);

    Integer findRoleId(Integer userId);

}
