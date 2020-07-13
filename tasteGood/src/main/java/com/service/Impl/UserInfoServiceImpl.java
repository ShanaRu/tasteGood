package com.service.Impl;
import com.dao.UserInfoDao;
import com.dao.UserRoleDao;
import com.domain.FollowTable;
import com.domain.UserInfo;
import com.domain.UserRole;
import com.github.pagehelper.PageHelper;
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
        return userInfoDao.findAllUser();
    }

    public Integer saveUserInfo(UserInfo userInfo){
        int i=userInfoDao.saveUserInfo(userInfo);
        return userInfo.getUserId();
    }

    @Override
    public UserInfo findUser(String userName) {
        return userInfoDao.findUser(userName);
    }

    @Override
    public UserInfo findUserInfoById(Integer userId) {
        return userInfoDao.findUserInfoById(userId);
    }

    @Override
    public UserInfo findUserName(String userName) {
        return userInfoDao.findUser(userName);
    }

    @Override
    public UserInfo findUserById(Integer userId) {
        return userInfoDao.findUserById(userId);
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

    @Override
    public UserInfo findUserNamePhoto(Integer userId) {
        return userInfoDao.findUserNamePhoto(userId);
    }

    @Override
    public void addFollowTable(FollowTable followTable) {
        userInfoDao.addFollowTable(followTable);
    }

    @Override
    public FollowTable findFollowTableIsExit(FollowTable followTable) {
        return userInfoDao.findFollowTableIsExit(followTable);
    }

    @Override
    public Integer countFollow(Integer userId) {
        return userInfoDao.countFollow(userId);
    }

    @Override
    public Integer countFollowed(Integer userId) {
        return userInfoDao.countFollowed(userId);
    }

    @Override
    public List<FollowTable> findFollow(Integer userId,Integer page,Integer size) {
        PageHelper.startPage(page,size);
        return userInfoDao.findFollow(userId);
    }

    @Override
    public List<FollowTable> findFollowed(Integer userId,Integer page,Integer size) {
        PageHelper.startPage(page,size);
        return userInfoDao.findFollowed(userId);
    }

    @Override
    public void deleteFollow(FollowTable followTable) {
        userInfoDao.deleteFollow(followTable);
    }


}
