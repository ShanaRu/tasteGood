package com.service.Impl;
import com.dao.UserInfoDao;
import com.domain.UserInfo;
import com.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {

    @Autowired
    private UserInfoDao userInfoDao;

    @Override
    public List<UserInfo> findAllUser() {
        List<UserInfo> userInfos=userInfoDao.findAllUser();
        return userInfos;
    }

    public void saveUserInfo(UserInfo userInfo){
        System.out.println("业务层");
        userInfoDao.saveUserInfo(userInfo);
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
}
