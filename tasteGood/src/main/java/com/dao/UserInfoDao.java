package com.dao;

import com.domain.FollowTable;
import com.domain.UserInfo;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserInfoDao {

    //查找所有用户信息
    @Select("select * from userInfo")
    List<UserInfo> findAllUser();

    //插入一行用户信息
    @Insert("Insert into userInfo(userName,userPassword,userIntroduce,userSex,userPhoto) values(#{userName},#{userPassword},#{userIntroduce},#{userSex},#{userPhoto})")
    @Options(useGeneratedKeys=true,keyProperty="userId",keyColumn="userId")
    int saveUserInfo(UserInfo userInfo);

    //根据userName查找用户信息,只能登陆时候用
    @Select("select * from userInfo where userName=#{userName}")
    UserInfo findUser(String userName);

//    @Select("select * from userInfo where userName=#{userName}")
//    public List<UserInfo> findUserName(String userName);

    //根据userId查找全部用户信息,用来更改个人信息的
    @Select("select * from userInfo where userId=#{userId}")
    UserInfo findUserInfoById(Integer userId);

    //根据userId查找用户信息，无密码的
    @Select("select userId,userName,userIntroduce,userSex,userPhoto from userInfo where userId=#{userId}")
    UserInfo findUserById(Integer userId);

    //更新用户信息
    @Update("update userInfo set userName=#{userName},userSex=#{userSex},userIntroduce=#{userIntroduce} where userId=#{userId}")
    void updateUserInfo(@Param("userName")String userName,@Param("userSex")Integer userSex,@Param("userIntroduce")String userIntroduce,@Param("userId")Integer userId);

    //更新密码
    @Update("update userInfo set userPassword=#{userPassword} where userId=#{userId}")
    void updatePassword(@Param("userPassword")String userPassword,@Param("userId")Integer userId);

    //更新头像
    @Update("update userInfo set userPhoto=#{userPhoto} where userId=#{userId}")
    void updateUserPhoto(@Param("userPhoto")String userPhoto,@Param("userId")Integer userId);


    //根据userId查找用户名字和头像
    @Select("select userName,userPhoto,userId from userInfo where userId=#{userId}")
    UserInfo findUserNamePhoto(Integer userId);

//    //根据用户名找用户id
//    @Select("select userId from userInfo where userId=#{userId}")
//    Integer findUserId(String userName);

    //保存关注
    @Insert("insert into followTable(userId,follow) values(#{userId},#{follow})")
    void addFollowTable(FollowTable followTable);

    //查询是否已关注
    @Select("select * from followTable where userId=#{userId} and follow=#{follow}")
    FollowTable findFollowTableIsExit(FollowTable followTable);

    //计算关注者
    @Select("select count(*) from followTable where userId=#{userId}")
    Integer countFollow(Integer userId);

    //计算被关注者
    @Select("select count(*) from followTable where follow=#{userId}")
    Integer countFollowed(Integer userId);

    //查找关注者
    @Select("select * from followTable where userId=#{userId}")
    List<FollowTable> findFollow(Integer userId);

    //查找被关注者
    @Select("select * from followTable where follow=#{userId}")
    List<FollowTable> findFollowed(Integer userId);

    //取消关注
    @Delete("delete from followTable where userId=#{userId} and follow=#{follow}")
    void deleteFollow(FollowTable followTable);
}
