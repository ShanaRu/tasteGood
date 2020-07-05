package com.service.Impl;
import com.dao.UserInfoDao;
import com.dao.UserRoleDao;
import com.domain.UserInfo;
import com.domain.UserRole;
import com.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {

    @Autowired
    private UserInfoDao userInfoDao;
    @Autowired
    private UserRoleDao userRoleDao;

    @Override
    public List<UserInfo> findAllUser() {
        List<UserInfo> userInfos=userInfoDao.findAllUser();
        return userInfos;
    }

    public Integer saveUserInfo(UserInfo userInfo){
        int i=userInfoDao.saveUserInfo(userInfo);
        Integer userId=userInfo.getUserId();
        return userId;
    }

    @Override
    public UserInfo findUser(String userName) {
        UserInfo userInfo=userInfoDao.findUser(userName);
        return userInfo;
    }

    @Override
    public UserInfo findUserName(String userName) {
        UserInfo userInfo=userInfoDao.findUser(userName);
        return userInfo;
    }

    @Override
    public UserInfo findUserById(Integer userId) {
        UserInfo userInfo=userInfoDao.findUserById(userId);
        return userInfo;
    }

    @Override
    public void updateUserInfo(String userName,Integer userSex,String userIntroduce,Integer userId) {
        userInfoDao.updateUserInfo(userName,userSex,userIntroduce,userId);
    }

    @Override
    public void updatePassword(String userPassword, Integer userId) {
        userInfoDao.updatePassword(userPassword,userId);
    }

    @Override
    public void updateUserPhoto(String userPhoto, Integer userId) {
        userInfoDao.updateUserPhoto(userPhoto,userId);
    }

    @Override
    public void addUserRole(UserRole userRole) {
        userRoleDao.addUserRole(userRole);
    }
}
